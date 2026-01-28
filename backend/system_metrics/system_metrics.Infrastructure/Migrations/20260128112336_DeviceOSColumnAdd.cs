using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace system_metrics.Infrastructure.Migrations
{
    /// <inheritdoc />
    public partial class DeviceOSColumnAdd : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "DeviceOS",
                table: "DeviceDetails",
                type: "TEXT",
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "DeviceOS",
                table: "DeviceDetails");
        }
    }
}
