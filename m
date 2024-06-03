Return-Path: <linux-rdma+bounces-2792-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 303CD8D8698
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 17:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546391C2167D
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jun 2024 15:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4229137743;
	Mon,  3 Jun 2024 15:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gRrv+CDG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603161369A4;
	Mon,  3 Jun 2024 15:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430021; cv=fail; b=AtuQjDmY1duI8srBjvp3z5H6zb07X/L8+o2nQSoEmp+gKG72eFQb6NhE2fyW1PGM7M3LO//b4DtM632kqg1iGwVDNyKrDBbP6gOclUwS8QPyA+PjXPFVHyJ5UvAUB5ifVz71J/URPtDd1sLKByBexpXp3rTIL0SNYKnchGJ9A5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430021; c=relaxed/simple;
	bh=fwbsMauJGBpqqC6/rfXsMvepiLWAjmtVZN1uirWxISo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Jw6f0sdAYYvHrEhlsjHa8MGomgSxeTUlPZFdKXAQHjT4w4gqYNEpSVzAWzvYdt9Z9P9y+zMtyqr/a5NDqYPQsh5DemQ/gavMs+yLlT2R4J4GRnF15V+njNmRXBCPAKx6uFLnD7vtkuRQllcLTS12r0ArsvNVMvKWHjccavTnKws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gRrv+CDG; arc=fail smtp.client-ip=40.107.220.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wy43SvdgifFahXqp9rf20B2YtgrfsoR40Zn8dwQyxd/7FTLNUE5OYBS2IZaWz86qcN+v4LLduqPsULU+M35/gynCptrWFT8O+1Aja+v11HxG5P99oD1CBVFFwrLrtlbdpIngV/ukZSmb9JTXt3zga5/udkRaKOHUGgGiP7u3/Shenj5BphsYrfXiCryqDOeyPqLSm6ySu6YOk5ET5xiPSOvjhnAAM8tLb5pPQOcK+PXqiqraT9oY8qADKFJX8+9TClC9aPUE/hIp6fCFjhseoHfim1qCGO8bzCO2vh1KlcDXebUoNGCEs0RpW0laGoJGVB1klYBuLWSZYqEFs+PdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MBsVt4IHfkuZMkd24mTDHfp9+FpVCtg5DVR1sp3YVx8=;
 b=jw0Psy8ffiv5DdSbCJys1wh8fzYy9MZCR3iG/s0HVzK+ZrEyPPk0Ay6K9HV7Yc2COKGb7162NulVjfHgAbYLghnaQ+TJt4DhaFiHJJko7GP3FZiuO8UccR6tBKFL2U8ikhQSX3/IKrSqy0zmypPWAUODnJouz2uVW4cxzKHDoAZjgjrpM/raFOucYE55YSbn1bvhelTghZ2HTlkxjZ0wTnt69WTaJNoVplAOdwii6WK2gqYN6Vk8lEs6KXMQw69zxLvRISm0Yey9PYeo4OzV5zAG1s4jGL+bcucBnI0v6qz0K0ibZHJPDzokJwgFLQ0Zc0LyDlg5UBmU00PGXLaN0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MBsVt4IHfkuZMkd24mTDHfp9+FpVCtg5DVR1sp3YVx8=;
 b=gRrv+CDGuAUdL55oNHYbTMefOvKMvsF1rq4EHqgnnN9vaiEaXfiwTJKrewdwswU9YaS0mebUZBxBhJMAgQQ5nkWWsrnjuZwZdEwyQejgWgxQawm9ba1V70opNdz63roMsd3Kh8CSM+HpzYzF+Mil6TYEZEF7WxUN3eg88bisDlcikUMCLkdtzPIYTnmn9tfa8hBmk5H0yyHy4R/HaCy+hYMiZwbI0SO3plbLiqTdoMv64/pZjgFCpXyM087eCyND0EptIW4HuQCv40bP2CgHZsuLfWThdjHTDDbPBZgaAIbfr9dRoUbAECmsiXL6TqKRZLrLFLgMdVDhBHBYrWteIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 15:53:30 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 15:53:30 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Itay Avraham <itayavr@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH 7/8] fwctl/mlx5: Support for communicating with mlx5 fw
Date: Mon,  3 Jun 2024 12:53:23 -0300
Message-ID: <7-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::18) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb93356-f8e5-4960-644d-08dc83e54fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|7416005|366007|376005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MMyk5oAGOpCwVUXnDGkhhSmOZBrsxhTasf+r59xGb79maz5pVetTKCgDnggL?=
 =?us-ascii?Q?j78LmXGSaVxqFjje8SUV+tgOhfqVkmrEMLnoLcbJH9deRoKlUVcsW4UYphvO?=
 =?us-ascii?Q?yQTcANKLgNFOyzyVYuwKlhxhGK24nAlWhIUdoeE5OIt/UEhQ1Lh5eXGU351V?=
 =?us-ascii?Q?lE77n3wGAWduAVvauoTv7dU9QItw9uAydxXnkVjYqllsH7cpxs0Lo+Pp6V0V?=
 =?us-ascii?Q?jvjsMvsK56YEqj9i/q4jD/zghUYUR/UynQCa00faBLM1zP9881XN3/93RP2e?=
 =?us-ascii?Q?UUCWwcPEaiHNCRzXs5d7tSmyZDCOs6/kJPzYz0rKkOYsSWywmJMFHg2hKqrq?=
 =?us-ascii?Q?BYp31XEVnANO4qbRGL2ffe2CWvXunAq9SoeWk4vYVMTuPoy8AIVtJtpnxQUw?=
 =?us-ascii?Q?Ij+PcA9xjBiExd1POKlivllpCP2bNL3ZYUCAyJUJIIgZfHcV8i7Aj84wjaPc?=
 =?us-ascii?Q?3Yw9EQey04ioCYsB1Ml3mo7KXpXNnle2TtI7wrBGEEiXEC5EXDdG9rsFkPPJ?=
 =?us-ascii?Q?x89tJ12l4xg63HyrJl8qWi7Djvh4hTQuaj9o5mGxhUdsCJeNxywuPkgB3Zt/?=
 =?us-ascii?Q?BYlmL6QydcxnMLUbZW89Lf970K687ZiAUCsAgi2vgGRoqoANXZmjq+eZxog8?=
 =?us-ascii?Q?tYl/WOBwt6eViy2k+QicmW66xd/RXfcox26RonaELk4MNuO8jp377IckA6OF?=
 =?us-ascii?Q?R0aCoYbMfYRsa92CMRNj2p5c3jBNIU3VEUAb6Wo/EtPgDbJ8EW1fz+aHcfDz?=
 =?us-ascii?Q?74H6QVwLEv1rIVcTittgZyrDBrqC629pfe6ap+9gAfR/X20aI3klOR/vVcSU?=
 =?us-ascii?Q?tQVuePJUYM3wyMknWojzex2jQbMgPJ1C5YWD8kNVyQdkjjptQEGq+GfGKIq3?=
 =?us-ascii?Q?UfcjXtDe42R8D+s11ffH5ViMMZ7/A/ZxcBkMulLfJAcaFSyGqnu13mJ4OkY8?=
 =?us-ascii?Q?dVmRnbAr39sWBRBU9CxfYZ73Smr6P6IcBAo/VrR3kYZUIngTBmevDQfdKmMg?=
 =?us-ascii?Q?PRCjJ2AqaWxcZ0Y75hwLZiezF5BnlyPcccFNvw9FjhNGgk8hRA6FvFFCkYlG?=
 =?us-ascii?Q?21sqOsoFy6HSTsBwijV+eD+t55KshqmHe5Z5gtUeUcfzqHyfbUlvknqgllAa?=
 =?us-ascii?Q?jXjCbcE/JyWYZFA38PMGoBDCtU7tjuAlu9hWntbQr3sD4g672AyXg0+zDYCt?=
 =?us-ascii?Q?uB8HRpW4GgPfg+Tb2bhENAfYMdXH+ep4nV7XXhQUk3p1QMYMOcaPofyiF4ju?=
 =?us-ascii?Q?//9j79TSujRIz/OQkpcMusAVkG9BAH3LxVowZF+NlmTzufKAY/2SrH+KYfh3?=
 =?us-ascii?Q?Z5Pw7ob9nxEjNQ1yN9YzQ7+O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EBYxErPTW9geptB0ksIacpt4O6xlYl4xsFSSyib8df0FdrOUM4AGVb6JqTJ/?=
 =?us-ascii?Q?pQg0dAGAp/aXtrfE2Fuce1Y8lmDP88kZT9NgcssOwDtSmPu7t/dYckoT8m18?=
 =?us-ascii?Q?N9UQFctsQW8krbvmL/lk3x9pqKvMkGQ6XiX+00SDoIgvFhdRhzJtadI8xHwi?=
 =?us-ascii?Q?L9G5GYRmZc1Felfb41ooVRfVIvynUnnUW9F9KdgUy1wdKD7eh5Kpa1LLkoFI?=
 =?us-ascii?Q?pP2I6KRiOhlqvk1yj2IAH7wNHMCeU0dEEW+0XFGb1peB5F9BvNyVGleTFafn?=
 =?us-ascii?Q?KAotEOOz1bOXt/b1uE1GeOUlOIaMERrgOcm1LseT9TSekjn2jl1SxbhK68IP?=
 =?us-ascii?Q?Y3r4ttOE5q4ojUunUBNfqaUe77izFYT0/7fU9IXyPpXGhvnc0UBC/YlcL/gS?=
 =?us-ascii?Q?/RWP7lfdAq8QieF8vrbW5YMHTxtv8WwLHo3lBX+KiaI35UEkd6/zLBWkg4Jf?=
 =?us-ascii?Q?vNaNhz45TGat13XYh9pWObbEjuJvGaJgDY3z5kxkCMJ0iYoKV1/3HAsKKQiY?=
 =?us-ascii?Q?njZX3ynbY2GSQrRDQRnwG5MY8TU2LdHojoQgV9z0gc7Ql8wD10RMBBaCbFUt?=
 =?us-ascii?Q?ALH3YjhuahBptTmH/sjaHbYb5nL+2wLVy/i2AnQMG2bgDmGqHzHJ4q9KaMJ2?=
 =?us-ascii?Q?oNgm5cgHqLKfcb2poUPGX9pwmdjpYwsynyu/a+luDCAw+L9aDiDlGMeZTpDd?=
 =?us-ascii?Q?8eTHNUD19n8mwK5IZpZRh3rQnJPzTX6FUG6A9v+QtGTmFb1KyoGQBpk+MRTi?=
 =?us-ascii?Q?nbpzhf56m1gE4U7PgvggAgOWVIRUo9a4tJp49ufeKyc8P/7S9PFBziSPhF0M?=
 =?us-ascii?Q?fhVHP6/Sag+1zQ9azgj8ZkcXpbGbLzmBUY+lJKC6CtOqHQWH7/C2LCuOQMRr?=
 =?us-ascii?Q?ftjjFz7uqMsqlm3v3URpDJG7u3QZaglFcxp+hLKh9XlWMuiinig19B8kHZwO?=
 =?us-ascii?Q?cVNwpl4VQ5e2s5FrnNnaHblt4FLFl/Koidce5UV1OEpA6AS8Hd7btUJS3IQ3?=
 =?us-ascii?Q?gydgsvx7lzOiBsWvxxgljPMJ0njqyWLWdsWJvgVsBPr/DRkuzmq2GKXphg4M?=
 =?us-ascii?Q?Ah9fGtJ4ZqfFl42OSlib/Yfa3lLUbS6tQxIQ2yXVNe3OarVJ2jvAEitAb5xH?=
 =?us-ascii?Q?zoRw9Q/UhcVBGDz/TsasGHiK8ZbKSUbnBet5BObZwOefvN5EQ7YQFekzD3Q1?=
 =?us-ascii?Q?9m1D5W58uuF+T8/n4qnYDmpmdid9vU+6FZwVhAKjmCfdU4PgV+Hh+d4AjRkG?=
 =?us-ascii?Q?cU9ouM1vgTCt3z20gx2XYjBwdmWSAryAEn/18xlmCnkDYJi80Km6W6ulKaPE?=
 =?us-ascii?Q?JqsDTrxmI2ev05GZaSAjk3/zgXcbGnAmFA3cHGniJvMCwtjqLot14m9vA7dA?=
 =?us-ascii?Q?2p2p6rxOsJZKIqQ5oIYJSZwRfN3wA+jowq2OxZRbC383Zcx6Ou2T8AS0WE7V?=
 =?us-ascii?Q?bCujR85vZ2eko5zyySRHl70bTDS8usCLJFdezSpnVTbPWpdWkYfg5mHkOXAx?=
 =?us-ascii?Q?WhadL5T3VNkG8jcDELdWdvRnjeNrvY9o6b1uRHWQSP8T59/xSfwXSZMGVOCr?=
 =?us-ascii?Q?NUAKqZUH/fj8kYA9/W1kj7SWY3Gl+BqdJz6CSE0G?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb93356-f8e5-4960-644d-08dc83e54fab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 15:53:28.8908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdwiCZqbCBS9BEyQfffXXg7mAR8B/TGcRIA7x6DAKHrp41ivzxUvds0mu25asjkc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197

From: Saeed Mahameed <saeedm@nvidia.com>

mlx5's fw has long provided a User Context concept. This has a long
history in RDMA as part of the devx extended verbs programming
interface. A User Context is a security envelope that contains objects and
controls access. It contains the Protection Domain object from the
InfiniBand Architecture and both togther provide the OS with the necessary
tools to bind a security context like a process to the device.

The security context is restricted to not be able to touch the kernel or
other processes. In the RDMA verbs case it is also restricted to not touch
global device resources.

The fwctl_mlx5 takes this approach and builds a User Context per fwctl
file descriptor and uses a FW security capability on the User Context to
enable access to global device resources. This makes the context useful
for provisioning and debugging the global device state.

mlx5 already has a robust infrastructure for delivering RPC messages to
fw. Trivially connect fwctl's RPC mechanism to mlx5_cmd_do(). Enforce the
User Context ID in every RPC header so the FW knows the security context
of the issuing ID.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 MAINTAINERS                 |   7 +
 drivers/fwctl/Kconfig       |  14 ++
 drivers/fwctl/Makefile      |   1 +
 drivers/fwctl/mlx5/Makefile |   4 +
 drivers/fwctl/mlx5/main.c   | 333 ++++++++++++++++++++++++++++++++++++
 include/uapi/fwctl/fwctl.h  |   1 +
 include/uapi/fwctl/mlx5.h   |  36 ++++
 7 files changed, 396 insertions(+)
 create mode 100644 drivers/fwctl/mlx5/Makefile
 create mode 100644 drivers/fwctl/mlx5/main.c
 create mode 100644 include/uapi/fwctl/mlx5.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 94062161e9c4d7..3bd74656d73d5d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9086,6 +9086,13 @@ F:	drivers/fwctl/
 F:	include/linux/fwctl.h
 F:	include/uapi/fwctl/
 
+FWCTL MLX5 DRIVER
+M:	Saeed Mahameed <saeedm@nvidia.com>
+R:	Itay Avraham <itayavr@nvidia.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	drivers/fwctl/mlx5/
+
 GALAXYCORE GC0308 CAMERA SENSOR DRIVER
 M:	Sebastian Reichel <sre@kernel.org>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
index 6ceee3347ae642..d7aa64710146ce 100644
--- a/drivers/fwctl/Kconfig
+++ b/drivers/fwctl/Kconfig
@@ -7,3 +7,17 @@ menuconfig FWCTL
 	  support a wide range of lockdown compatible device behaviors including
 	  manipulating device FLASH, debugging, and other activities that don't
 	  fit neatly into an existing subsystem.
+
+if FWCTL
+config FWCTL_MLX5
+	tristate "mlx5 ConnectX control fwctl driver"
+	depends on MLX5_CORE
+	help
+	  MLX5CTL provides interface for the user process to access the debug and
+	  configuration registers of the ConnectX hardware family
+	  (NICs, PCI switches and SmartNIC SoCs).
+	  This will allow configuration and debug tools to work out of the box on
+	  mainstream kernel.
+
+	  If you don't know what to do here, say N.
+endif
diff --git a/drivers/fwctl/Makefile b/drivers/fwctl/Makefile
index 1cad210f6ba580..1c535f694d7fe4 100644
--- a/drivers/fwctl/Makefile
+++ b/drivers/fwctl/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_FWCTL) += fwctl.o
+obj-$(CONFIG_FWCTL_MLX5) += mlx5/
 
 fwctl-y += main.o
diff --git a/drivers/fwctl/mlx5/Makefile b/drivers/fwctl/mlx5/Makefile
new file mode 100644
index 00000000000000..139a23e3c7c517
--- /dev/null
+++ b/drivers/fwctl/mlx5/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_FWCTL_MLX5) += mlx5_fwctl.o
+
+mlx5_fwctl-y += main.o
diff --git a/drivers/fwctl/mlx5/main.c b/drivers/fwctl/mlx5/main.c
new file mode 100644
index 00000000000000..d5b751f1e98486
--- /dev/null
+++ b/drivers/fwctl/mlx5/main.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
+#include <linux/fwctl.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/mlx5/device.h>
+#include <linux/mlx5/driver.h>
+#include <uapi/fwctl/mlx5.h>
+
+#define mlx5ctl_err(mcdev, format, ...) \
+	dev_err(&mcdev->fwctl.dev, format, ##__VA_ARGS__)
+
+#define mlx5ctl_dbg(mcdev, format, ...)                             \
+	dev_dbg(&mcdev->fwctl.dev, "PID %u: " format, current->pid, \
+		##__VA_ARGS__)
+
+struct mlx5ctl_uctx {
+	struct fwctl_uctx uctx;
+	u32 uctx_caps;
+	u32 uctx_uid;
+};
+
+struct mlx5ctl_dev {
+	struct fwctl_device fwctl;
+	struct mlx5_core_dev *mdev;
+};
+DEFINE_FREE(mlx5ctl, struct mlx5ctl_dev *, if (_T) fwctl_put(&_T->fwctl));
+
+struct mlx5_ifc_mbox_in_hdr_bits {
+	u8 opcode[0x10];
+	u8 uid[0x10];
+
+	u8 reserved_at_20[0x10];
+	u8 op_mod[0x10];
+
+	u8 reserved_at_40[0x40];
+};
+
+struct mlx5_ifc_mbox_out_hdr_bits {
+	u8 status[0x8];
+	u8 reserved_at_8[0x18];
+
+	u8 syndrome[0x20];
+
+	u8 reserved_at_40[0x40];
+};
+
+enum {
+	MLX5_UCTX_OBJECT_CAP_TOOLS_RESOURCES = 0x4,
+};
+
+enum {
+	MLX5_CMD_OP_QUERY_DIAGNOSTIC_PARAMS = 0x819,
+	MLX5_CMD_OP_SET_DIAGNOSTIC_PARAMS = 0x820,
+	MLX5_CMD_OP_QUERY_DIAGNOSTIC_COUNTERS = 0x821,
+};
+
+static int mlx5ctl_alloc_uid(struct mlx5ctl_dev *mcdev, u32 cap)
+{
+	u32 out[MLX5_ST_SZ_DW(create_uctx_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(create_uctx_in)] = {};
+	void *uctx;
+	int ret;
+	u16 uid;
+
+	uctx = MLX5_ADDR_OF(create_uctx_in, in, uctx);
+
+	mlx5ctl_dbg(mcdev, "%s: caps 0x%x\n", __func__, cap);
+	MLX5_SET(create_uctx_in, in, opcode, MLX5_CMD_OP_CREATE_UCTX);
+	MLX5_SET(uctx, uctx, cap, cap);
+
+	ret = mlx5_cmd_exec(mcdev->mdev, in, sizeof(in), out, sizeof(out));
+	if (ret)
+		return ret;
+
+	uid = MLX5_GET(create_uctx_out, out, uid);
+	mlx5ctl_dbg(mcdev, "allocated uid %u with caps 0x%x\n", uid, cap);
+	return uid;
+}
+
+static void mlx5ctl_release_uid(struct mlx5ctl_dev *mcdev, u16 uid)
+{
+	u32 in[MLX5_ST_SZ_DW(destroy_uctx_in)] = {};
+	struct mlx5_core_dev *mdev = mcdev->mdev;
+	int ret;
+
+	MLX5_SET(destroy_uctx_in, in, opcode, MLX5_CMD_OP_DESTROY_UCTX);
+	MLX5_SET(destroy_uctx_in, in, uid, uid);
+
+	ret = mlx5_cmd_exec_in(mdev, destroy_uctx, in);
+	mlx5ctl_dbg(mcdev, "released uid %u %pe\n", uid, ERR_PTR(ret));
+}
+
+static int mlx5ctl_open_uctx(struct fwctl_uctx *uctx)
+{
+	struct mlx5ctl_uctx *mfd =
+		container_of(uctx, struct mlx5ctl_uctx, uctx);
+	struct mlx5ctl_dev *mcdev =
+		container_of(uctx->fwctl, struct mlx5ctl_dev, fwctl);
+	int uid;
+
+	/*
+	 * New FW supports the TOOLS_RESOURCES uid security label
+	 * which allows commands to manipulate the global device state.
+	 * Otherwise only basic existing RDMA devx privilege are allowed.
+	 */
+	if (MLX5_CAP_GEN(mcdev->mdev, uctx_cap) &
+	    MLX5_UCTX_OBJECT_CAP_TOOLS_RESOURCES)
+		mfd->uctx_caps |= MLX5_UCTX_OBJECT_CAP_TOOLS_RESOURCES;
+
+	uid = mlx5ctl_alloc_uid(mcdev, mfd->uctx_caps);
+	if (uid < 0)
+		return uid;
+
+	mfd->uctx_uid = uid;
+	return 0;
+}
+
+static void mlx5ctl_close_uctx(struct fwctl_uctx *uctx)
+{
+	struct mlx5ctl_dev *mcdev =
+		container_of(uctx->fwctl, struct mlx5ctl_dev, fwctl);
+	struct mlx5ctl_uctx *mfd =
+		container_of(uctx, struct mlx5ctl_uctx, uctx);
+
+	mlx5ctl_release_uid(mcdev, mfd->uctx_uid);
+}
+
+static void *mlx5ctl_info(struct fwctl_uctx *uctx, size_t *length)
+{
+	struct mlx5ctl_uctx *mfd =
+		container_of(uctx, struct mlx5ctl_uctx, uctx);
+	struct fwctl_info_mlx5 *info;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	info->uid = mfd->uctx_uid;
+	info->uctx_caps = mfd->uctx_caps;
+	return info;
+}
+
+static bool mlx5ctl_validate_rpc(const void *in, enum fwctl_rpc_scope scope)
+{
+	u16 opcode = MLX5_GET(mbox_in_hdr, in, opcode);
+
+	/*
+	 * Currently the driver can't keep track of commands that allocate
+	 * objects in the FW, these commands are safe from a security
+	 * perspective but nothing will free the memory when the FD is closed.
+	 * For now permit only query commands. Also the caps for the scope have
+	 * not been defined yet, filter commands manually for now.
+	 */
+	switch (opcode) {
+	case MLX5_CMD_OP_QUERY_ADAPTER:
+	case MLX5_CMD_OP_QUERY_ESW_FUNCTIONS:
+	case MLX5_CMD_OP_QUERY_HCA_CAP:
+	case MLX5_CMD_OP_QUERY_HCA_VPORT_CONTEXT:
+		return scope <= FWCTL_RPC_CONFIGURATION;
+
+	case MLX5_CMD_OP_QUERY_CONG_PARAMS:
+	case MLX5_CMD_OP_QUERY_CONG_STATISTICS:
+	case MLX5_CMD_OP_QUERY_CONG_STATUS:
+	case MLX5_CMD_OP_QUERY_CQ:
+	case MLX5_CMD_OP_QUERY_DCT:
+	case MLX5_CMD_OP_QUERY_DIAGNOSTIC_COUNTERS:
+	case MLX5_CMD_OP_QUERY_DIAGNOSTIC_PARAMS:
+	case MLX5_CMD_OP_QUERY_EQ:
+	case MLX5_CMD_OP_QUERY_ESW_VPORT_CONTEXT:
+	case MLX5_CMD_OP_QUERY_FLOW_COUNTER:
+	case MLX5_CMD_OP_QUERY_FLOW_GROUP:
+	case MLX5_CMD_OP_QUERY_FLOW_TABLE_ENTRY:
+	case MLX5_CMD_OP_QUERY_FLOW_TABLE:
+	case MLX5_CMD_OP_QUERY_GENERAL_OBJECT:
+	case MLX5_CMD_OP_QUERY_ISSI:
+	case MLX5_CMD_OP_QUERY_L2_TABLE_ENTRY:
+	case MLX5_CMD_OP_QUERY_LAG:
+	case MLX5_CMD_OP_QUERY_MAD_DEMUX:
+	case MLX5_CMD_OP_QUERY_MKEY:
+	case MLX5_CMD_OP_QUERY_MODIFY_HEADER_CONTEXT:
+	case MLX5_CMD_OP_QUERY_PACKET_REFORMAT_CONTEXT:
+	case MLX5_CMD_OP_QUERY_PAGES:
+	case MLX5_CMD_OP_QUERY_Q_COUNTER:
+	case MLX5_CMD_OP_QUERY_QP:
+	case MLX5_CMD_OP_QUERY_RMP:
+	case MLX5_CMD_OP_QUERY_RQ:
+	case MLX5_CMD_OP_QUERY_RQT:
+	case MLX5_CMD_OP_QUERY_SCHEDULING_ELEMENT:
+	case MLX5_CMD_OP_QUERY_SPECIAL_CONTEXTS:
+	case MLX5_CMD_OP_QUERY_SQ:
+	case MLX5_CMD_OP_QUERY_SRQ:
+	case MLX5_CMD_OP_QUERY_TIR:
+	case MLX5_CMD_OP_QUERY_TIS:
+	case MLX5_CMD_OP_QUERY_VHCA_MIGRATION_STATE:
+	case MLX5_CMD_OP_QUERY_VNIC_ENV:
+	case MLX5_CMD_OP_QUERY_VPORT_COUNTER:
+	case MLX5_CMD_OP_QUERY_VPORT_STATE:
+	case MLX5_CMD_OP_QUERY_WOL_ROL:
+	case MLX5_CMD_OP_QUERY_XRC_SRQ:
+	case MLX5_CMD_OP_QUERY_XRQ_DC_PARAMS_ENTRY:
+	case MLX5_CMD_OP_QUERY_XRQ_ERROR_PARAMS:
+	case MLX5_CMD_OP_QUERY_XRQ:
+		return scope <= FWCTL_RPC_DEBUG_READ_ONLY;
+
+	case MLX5_CMD_OP_SET_DIAGNOSTIC_PARAMS:
+		return scope <= FWCTL_RPC_DEBUG_WRITE;
+
+	case MLX5_CMD_OP_ACCESS_REG:
+		return scope <= FWCTL_RPC_DEBUG_WRITE_FULL;
+	default:
+		return false;
+	}
+}
+
+static void *mlx5ctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
+			    void *rpc_in, size_t in_len, size_t *out_len)
+{
+	struct mlx5ctl_dev *mcdev =
+		container_of(uctx->fwctl, struct mlx5ctl_dev, fwctl);
+	struct mlx5ctl_uctx *mfd =
+		container_of(uctx, struct mlx5ctl_uctx, uctx);
+	void *rpc_alloc __free(kvfree) = NULL;
+	void *rpc_out;
+	int ret;
+
+	if (in_len < MLX5_ST_SZ_BYTES(mbox_in_hdr) ||
+	    *out_len < MLX5_ST_SZ_BYTES(mbox_out_hdr))
+		return ERR_PTR(-EMSGSIZE);
+
+	/* FIXME: Requires device support for more scopes */
+	if (scope != FWCTL_RPC_CONFIGURATION &&
+	    scope != FWCTL_RPC_DEBUG_READ_ONLY)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	mlx5ctl_dbg(mcdev, "[UID %d] cmdif: opcode 0x%x inlen %zu outlen %zu\n",
+		    mfd->uctx_uid, MLX5_GET(mbox_in_hdr, rpc_in, opcode),
+		    in_len, *out_len);
+
+	if (!mlx5ctl_validate_rpc(rpc_in, scope))
+		return ERR_PTR(-EBADMSG);
+
+	/*
+	 * mlx5_cmd_do() copies the input message to its own buffer before
+	 * executing it, so we can reuse the allocation for the output.
+	 */
+	if (*out_len <= in_len) {
+		rpc_out = rpc_in;
+	} else {
+		rpc_out = rpc_alloc = kvzalloc(*out_len, GFP_KERNEL);
+		if (!rpc_alloc)
+			return ERR_PTR(-ENOMEM);
+	}
+
+	/* Enforce the user context for the command */
+	MLX5_SET(mbox_in_hdr, rpc_in, uid, mfd->uctx_uid);
+	ret = mlx5_cmd_do(mcdev->mdev, rpc_in, in_len, rpc_out, *out_len);
+
+	mlx5ctl_dbg(mcdev,
+		    "[UID %d] cmdif: opcode 0x%x status 0x%x retval %pe\n",
+		    mfd->uctx_uid, MLX5_GET(mbox_in_hdr, rpc_in, opcode),
+		    MLX5_GET(mbox_out_hdr, rpc_out, status), ERR_PTR(ret));
+
+	/*
+	 * -EREMOTEIO means execution succeeded and the out is valid,
+	 * but an error code was returned inside out. Everything else
+	 * means the RPC did not make it to the device.
+	 */
+	if (ret && ret != -EREMOTEIO)
+		return ERR_PTR(ret);
+	if (rpc_out == rpc_in)
+		return rpc_in;
+	return_ptr(rpc_alloc);
+}
+
+static const struct fwctl_ops mlx5ctl_ops = {
+	.device_type = FWCTL_DEVICE_TYPE_MLX5,
+	.uctx_size = sizeof(struct mlx5ctl_uctx),
+	.open_uctx = mlx5ctl_open_uctx,
+	.close_uctx = mlx5ctl_close_uctx,
+	.info = mlx5ctl_info,
+	.fw_rpc = mlx5ctl_fw_rpc,
+};
+
+static int mlx5ctl_probe(struct auxiliary_device *adev,
+			 const struct auxiliary_device_id *id)
+
+{
+	struct mlx5_adev *madev = container_of(adev, struct mlx5_adev, adev);
+	struct mlx5_core_dev *mdev = madev->mdev;
+	struct mlx5ctl_dev *mcdev __free(mlx5ctl) = fwctl_alloc_device(
+		&mdev->pdev->dev, &mlx5ctl_ops, struct mlx5ctl_dev, fwctl);
+	int ret;
+
+	if (!mcdev)
+		return -ENOMEM;
+
+	mcdev->mdev = mdev;
+
+	ret = fwctl_register(&mcdev->fwctl);
+	if (ret)
+		return ret;
+	auxiliary_set_drvdata(adev, no_free_ptr(mcdev));
+	return 0;
+}
+
+static void mlx5ctl_remove(struct auxiliary_device *adev)
+{
+	struct mlx5ctl_dev *mcdev __free(mlx5ctl) = auxiliary_get_drvdata(adev);
+
+	fwctl_unregister(&mcdev->fwctl);
+}
+
+static const struct auxiliary_device_id mlx5ctl_id_table[] = {
+	{.name = MLX5_ADEV_NAME ".fwctl",},
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, mlx5ctl_id_table);
+
+static struct auxiliary_driver mlx5ctl_driver = {
+	.name = "mlx5_fwctl",
+	.probe = mlx5ctl_probe,
+	.remove = mlx5ctl_remove,
+	.id_table = mlx5ctl_id_table,
+};
+
+module_auxiliary_driver(mlx5ctl_driver);
+
+MODULE_IMPORT_NS(FWCTL);
+MODULE_DESCRIPTION("mlx5 ConnectX fwctl driver");
+MODULE_AUTHOR("Saeed Mahameed <saeedm@nvidia.com>");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index 8bde0d4416fd55..49a357e1bc713f 100644
--- a/include/uapi/fwctl/fwctl.h
+++ b/include/uapi/fwctl/fwctl.h
@@ -42,6 +42,7 @@ enum {
 
 enum fwctl_device_type {
 	FWCTL_DEVICE_TYPE_ERROR = 0,
+	FWCTL_DEVICE_TYPE_MLX5 = 1,
 };
 
 /**
diff --git a/include/uapi/fwctl/mlx5.h b/include/uapi/fwctl/mlx5.h
new file mode 100644
index 00000000000000..bcb4602ffdeee4
--- /dev/null
+++ b/include/uapi/fwctl/mlx5.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ *
+ * These are definitions for the command interface for mlx5 HW. mlx5 FW has a
+ * User Context mechanism which allows the FW to understand a security scope.
+ * FWCTL binds each FD to a FW user context and then places the User Context ID
+ * (UID) in each command header. The created User Context has a capability set
+ * that is appropriate for FWCTL's security model.
+ *
+ * Command formation should use a copy of the structs in mlx5_ifc.h following
+ * the Programmers Reference Manual. A open release is available here:
+ *
+ *  https://network.nvidia.com/files/doc-2020/ethernet-adapters-programming-manual.pdf
+ *
+ * The device_type for this file is FWCTL_DEVICE_TYPE_MLX5.
+ */
+#ifndef _UAPI_FWCTL_MLX5_H
+#define _UAPI_FWCTL_MLX5_H
+
+#include <linux/types.h>
+
+/**
+ * struct fwctl_info_mlx5 - ioctl(FWCTL_INFO) out_device_data
+ * @uid: The FW UID this FD is bound to. Each command header will force
+ *	this value.
+ * @uctx_caps: The FW capabilities that are enabled for the uid.
+ *
+ * Return basic information about the FW interface available.
+ */
+struct fwctl_info_mlx5 {
+	__u32 uid;
+	__u32 uctx_caps;
+};
+
+#endif
-- 
2.45.2


