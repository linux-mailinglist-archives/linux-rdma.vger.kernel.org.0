Return-Path: <linux-rdma+bounces-3459-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0458B915A0C
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2024 00:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282EA1C22245
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2024 22:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D231A2C22;
	Mon, 24 Jun 2024 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jD0ppvrn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618701A2C0D;
	Mon, 24 Jun 2024 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719269268; cv=fail; b=XGEVGZy0wkA9Yy4xhNdJjYxgBtgKmNsMfQpYnHpLBM09XopHWK+76CKm5DuHNc5tUtZi7k4K0LJfb1nstV5Bhg+zyjt8LT3oxPOcDbhNcYaECsoZXBdz61HqGRlt9hk8eErYHuTahtNzFZDtCRX73C7ythfmE7Vfgky+z9cRpj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719269268; c=relaxed/simple;
	bh=VwewmplYDVp+G8uPxuU84wYJGKqGDPz+ZZRBBjyeLdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TjF9tvP9i8N7Fir5zZqy5APBdsPJmXkMEXyhjkJLol0/+tbY+412/JkiqrIjuQr+laEM+I7IBqiJ9tG1Tra5QOIGf5m2AJzMSLY9X6ZesbhP+5sJWO/G4274hWbjWepYOBeX1YA/Q5kVgeAIDhvV1rkXwghmcBf2vvEYAKxcHGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jD0ppvrn; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBH/zAtOYsDmjggMYM9FrbWkCt9888mJWQpp6a/jQzEWODtFENA0MnLJ9bU7LbmnxgRVqqE91c0VW2eBKZ2Hw6K/ABFzXvaUb9qhKL8NmsFmCi4dFSUuVLNJ/18ZOeGdPuU27QLi7sfyFMb5ll6bE6fKMV67ff6b85Ui8lf5ns1OpHrZmw6wxz6lT+XJi9gZkSbCXUmkoq0fgxbg/Qm/DpaSmqzlBfOwoNSX/Xq1X2ot95fnzkVa4bN1fyS+EjACWMlrPbxrTJuOZq2XHjqO2knUod3bgqNT45f55rrpK11WzBjIXWQ6N+kQWcf45Cal/e3qSguXRscZkD4xVeFjjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=apam43stmI6A8HxJdS7uki9gbqUgu640LtMjI4qCpLE=;
 b=hzOGVY2AjMIzSih9SMaR/b+ytI20fNvuPuaLqjEu8H0MRkydx5xmDcDZMjJAlxKUVu4WxXJ2pqTiH5L/oR+5U1JPZdzMhL8pwWJXc1/CTB6YizszzOkz7b5zuLSwGj3ROKPMUwboGyHi/Gkcl4Lf/9A/HXHSOsxJUgbN1cmwHicUXmnYxpHPME/vvIBuNRfvNEg57i9ct1Bmr1ZPxfVUkEZ4rk2ckNHVQo5KTxU1j0EEGHcSPRH0mm50gfal5RW5F2HQacnGBU5Xa5VJsZVjAfmU9ZLHlBKeqC6txeEokfBmQs+urzT8PaCd8ZW8N5Q8Zszcxw5cKx4xGhk0pyhuqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apam43stmI6A8HxJdS7uki9gbqUgu640LtMjI4qCpLE=;
 b=jD0ppvrnVhg/1EwFxajKdwA13Zqqo4ir5I7fRyRhXXrLu7oINibVn+Iall23GoieJ71dpokayWQB8geLHDOES3es6S0q5xsVopA8a0wHGK9RsNleZ9u13X3OyJe8XxTc+nBh/nsomm/4opgDoPu5IezJtBUDU3pTfgMMk/e/0lG7EKlsh91H0YaKu5mtI6rKJZP31SlwvspmpFk3+O7lp1jb3DwBRhGei9Buu0wfkHpKrgniE3byNmY8BuWaMy3DUud2pUOKOVoSZJZraGCG2CwkX0tFvlXFQPRC35/YFWKvWOssw9p+XouHyYD578lNGDX8laQ9Kt8fxCcOP7wyFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 22:47:38 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%6]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 22:47:37 +0000
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
Subject: [PATCH v2 1/8] fwctl: Add basic structure for a class subsystem with a cdev
Date: Mon, 24 Jun 2024 19:47:25 -0300
Message-ID: <1-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
In-Reply-To: <0-v2-940e479ceba9+3821-fwctl_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0330.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::35) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|BY5PR12MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: 28fbe3bb-8ece-400b-aed1-08dc949fa32a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|366013|7416011|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?edtw2lwwmzbqZNhcmH8gGE305NYMI/WG8dMAy7WifcPFUTH5pivmIxUny3Ys?=
 =?us-ascii?Q?3H3S8bBGbvyxs3NP2fVy7AwGu86SJqCYdV63E7NdQVfBqW0i3AyrBRwiWO9N?=
 =?us-ascii?Q?nT2JXfv31kAg53ZQhF8UJ9i+hVHEtmEAieZYjLxgku5wQGNY4amHsb3Hs2pK?=
 =?us-ascii?Q?eM6rGFgEb+8Y2+pL77vPUFc9WiRhQ7gUQHoW29ivcPwKJWus22G7Q0dmjPu4?=
 =?us-ascii?Q?vuOnWDXZ2Zeiv32bCyAXuDZOrvbVYo744b8qRL0iXPwmpjlf9GAV2c2V0Yg9?=
 =?us-ascii?Q?OQGzvssAjFJuquso6qjGMZhxFUFYL21yRtjz3fUFqhWX7kDfawjFd1gthi9M?=
 =?us-ascii?Q?55Z21jXfwLWY6n2eQM4/yVkdgluJnGidWAn8XGThs6P/5rrNM7L2o3CXjykx?=
 =?us-ascii?Q?xNSi4Nl3juj+CXZjxdp6RI6TRIZ3F6yYHvsSvZ6cf87bNGPFVTaxex5bJ5tw?=
 =?us-ascii?Q?FgWcuSLxwUEG3Wnmy1BtItoHYmsXPUnlV5mpAOXDO9xtiZw3wWlAc15ibol2?=
 =?us-ascii?Q?IqPTOGZSKmGvIjiKfHMo8PIjAGiUO34X+5YZqsjr5RcX2mf7MwnKs79Srh8L?=
 =?us-ascii?Q?WnF2V+Up7OghXK1x5T418CtkBJfA7MrcS1V7zZw/8PNyh248UFZimVfzh4XA?=
 =?us-ascii?Q?vLkHnIk2s0bjMCLsVPfrtL0agdHKhEzann4fM6ZesIn9+N8zhpgpDk2DA2zK?=
 =?us-ascii?Q?RMtWO41+ug516HLyK+E28bc0bgyW/vhX4l+VcPo3wO6hoX7PiWe3xkfzLl14?=
 =?us-ascii?Q?SfghpD8BNB/iMFkjmWcD17czzLDHGTHwM27hHBP+bg+G1gMg9xopMW1RCP1I?=
 =?us-ascii?Q?CaECbQoRERSsOuloiIGBiCnS0sDflU6Wk6GCYDH2BQ4MTRjovCMtiIONyaSN?=
 =?us-ascii?Q?q5Fhe7nhHJXl/1QvN8kN5QzIPBTYzp/vl+vBsY2teQNTQLGQbf8wcwk6+lew?=
 =?us-ascii?Q?WQb4OJ+8+cEwo/0nLtTsa0lBjwP6rLApMGhf+YK1g1t7EfbZN/L36DiPUsIZ?=
 =?us-ascii?Q?l35ZtS1YrLy8R2XRCzX4g9ZpVJtt6SDIwwIou5oO1MjVeu75Zl8DISOCSOcF?=
 =?us-ascii?Q?OL1ECBVV3agmyYzlDUDlzAkz4GpWWpTM7fb1vZ4qtqtCahn5Ghdqa0auWyPX?=
 =?us-ascii?Q?FPn1/JTF/hLxjYDOjReaU3c7+URjmAVc+goxh0G+Bghq3Ymc7hrUt2FYKTm9?=
 =?us-ascii?Q?Cw3vO435EMVNKkWUVxwhyhYFP2rEAdQBMIeyPQHlJU7udGP+zbScAGN/MJhA?=
 =?us-ascii?Q?Edln1W682Xhp5UBvJcX3TKHWS22MI2ObeJnZ6VL36ReCr9HUb0qPY3QZlPxS?=
 =?us-ascii?Q?SGcXBABd2DBTHV0gJEA7jJnlh0dUYuhKLDiKhGq8K7EK8dujdlRu0x68P0+M?=
 =?us-ascii?Q?Sj00Q/w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(7416011)(1800799021)(921017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K8Mu0LO/XtjcbUOSTPGbXM/BTRzm2xCB1oD69R8ujR61J38x+x3nQPes8OQN?=
 =?us-ascii?Q?nIJ4kKGAFkQ9SUdePHIMeUW5Bpy+Rm9vgbrIe3mOIoc20RPGBi96/IG5VSVQ?=
 =?us-ascii?Q?pZxciqmMPAihpiXaCOSwDLFEOwF/ruI5BPQXVnq07JdnBexPecKyA8kMa321?=
 =?us-ascii?Q?iga00asdvXkxm/3R3JKVVDqdKqBjPFUQlsp43DHABvElJD1y80epQPYxNOOV?=
 =?us-ascii?Q?1P+++Y+t4kzenapBxHNavDj58ujncOE5HL/A2lrC9XHS2wdOd6QJvZUHrmNy?=
 =?us-ascii?Q?79v4O3Wm30v+7QZIlj5RpGGLsS26yoAzvQuGdwaVr96fW0Xr7uIedkZmdy1i?=
 =?us-ascii?Q?c/cDmuqqkAshHy2k4VkA233vn+VqbpIZSvlTkx+zEV/UKghWEAJs6fiIyPU1?=
 =?us-ascii?Q?OEmwladCYx0CuFHniH6aj3ypKkd7AYNyDtpCdCGaAdojZSjFP3v3EIbXCPTl?=
 =?us-ascii?Q?iR/gwyGujQ8ba+pXYA7t/z7qsQRJuyfdNir3KsxGkeQFRaclZowYOKQjwLcv?=
 =?us-ascii?Q?dE+AyDHTnFJ2WXlXID3P1f3SzFDFGaXZawlAMREsRxPIZK0Po3IswvQoM3RH?=
 =?us-ascii?Q?ttGM/fdD26qr1dkcwHw04Vw1XLGHdy+8vkQK+rO5i6XuHv3DrtiyBh63Uaqw?=
 =?us-ascii?Q?OTTGeAMLgi9tpUi5waUCyLhalJE5rvMjd8ALhNI6xoOMF5Pg/DlR6v/W25RP?=
 =?us-ascii?Q?P6ui9MM1vLGkzh0OvbeFfbJzaNq1l+GNh0G4snZqRKyC3q9RO99A4PEZhg2K?=
 =?us-ascii?Q?UKpV85XwYHEJMT+Iju+MpFxf9AKZSziB2Z/6WK4Zla+9N9oC/pUZ4HLQ8Zs+?=
 =?us-ascii?Q?zcQWhw0rxqdSow0n/H0YV+9mnfAHLpfML/kHQkSTjLnOQH7RCxZxajAX8jgX?=
 =?us-ascii?Q?Ox+AG80EJI+99iHBsAM/04YecFSmnXDB1hEkzNNgBUCFNv55u1M+gsRnUf7k?=
 =?us-ascii?Q?tARJMd5TDfaA63QeItPrrOinp8NEz4HIG2d9oPHrqwQPWYw9Wc2TEtQ2z0lU?=
 =?us-ascii?Q?kMYpMhjl00JId7+IxktikG00UqzAZSpTkLNzzCbfE/wgDw5gnybPfRGyYjU/?=
 =?us-ascii?Q?OYsLoEIdy9bj8BMJyZrgZCx8v7Huy88ggUuafORbkEo5C5tlx22ex/dlVU7H?=
 =?us-ascii?Q?QdG2ByZl04LL6cYeM3vXb76H79OtgHG36fVSbqSOgrK2gMbkbG9Oqujqc1JH?=
 =?us-ascii?Q?t+JBUdNtZGb6mOG9J/U+50D7e8yjCtaU6tkmaxVr6ocr11sWGTEaO4K8I5rJ?=
 =?us-ascii?Q?CFWH8MZNmzlX69xm/H4v8l3jyrgi36+gGMvg3ccvnMFyEYw/dawlld15cqWI?=
 =?us-ascii?Q?b4x1IVA9Cme5w7XgMyYEmtEu/xpiZL3YDtGdbJokfmv30lQWAIZm5Xz5XtLF?=
 =?us-ascii?Q?EOBFWA+/GbPZT1AXv2iW5imiWCrpGf/Sqj5TBXKmt5Y6ipMq6E1kwGI9X6op?=
 =?us-ascii?Q?e1mVaK3EKOy+12aIqp+4o9ys06/UPEVxowBTqhk6qQPRRNo+nhW9n2CKqv5M?=
 =?us-ascii?Q?s0zrLSxZZE4wFGVOGXNkN9bN2OYUVAxxID2o5RBTWw7mdXWWOyu288PLUx+x?=
 =?us-ascii?Q?KlJy3/Ip36j5jyEquKpLg9cHBShzHJavdOj7ejdz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28fbe3bb-8ece-400b-aed1-08dc949fa32a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 22:47:34.0082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYGo8PYaX0/y4ejT/GQ3ljIcCI3qe8gznGIXmWLOk6y+2gcZtI7421/fWW9quPR6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147

Create the class, character device and functions for a fwctl driver to
un/register to the subsystem.

A typical fwctl driver has a sysfs presence like:

$ ls -l /dev/fwctl/fwctl0
crw------- 1 root root 250, 0 Apr 25 19:16 /dev/fwctl/fwctl0

$ ls /sys/class/fwctl/fwctl0
dev  device  power  subsystem  uevent

$ ls /sys/class/fwctl/fwctl0/device/infiniband/
ibp0s10f0

$ ls /sys/class/infiniband/ibp0s10f0/device/fwctl/
fwctl0/

$ ls /sys/devices/pci0000:00/0000:00:0a.0/fwctl/fwctl0
dev  device  power  subsystem  uevent

Which allows userspace to link all the multi-subsystem driver components
together and learn the subsystem specific names for the device's
components.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 MAINTAINERS            |   8 ++
 drivers/Kconfig        |   2 +
 drivers/Makefile       |   1 +
 drivers/fwctl/Kconfig  |   9 +++
 drivers/fwctl/Makefile |   4 +
 drivers/fwctl/main.c   | 177 +++++++++++++++++++++++++++++++++++++++++
 include/linux/fwctl.h  |  68 ++++++++++++++++
 7 files changed, 269 insertions(+)
 create mode 100644 drivers/fwctl/Kconfig
 create mode 100644 drivers/fwctl/Makefile
 create mode 100644 drivers/fwctl/main.c
 create mode 100644 include/linux/fwctl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ca8f35dfe0399..aa7a760d12f8ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9076,6 +9076,14 @@ F:	kernel/futex/*
 F:	tools/perf/bench/futex*
 F:	tools/testing/selftests/futex/
 
+FWCTL SUBSYSTEM
+M:	Jason Gunthorpe <jgg@nvidia.com>
+M:	Saeed Mahameed <saeedm@nvidia.com>
+S:	Maintained
+F:	Documentation/userspace-api/fwctl.rst
+F:	drivers/fwctl/
+F:	include/linux/fwctl.h
+
 GALAXYCORE GC0308 CAMERA SENSOR DRIVER
 M:	Sebastian Reichel <sre@kernel.org>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 7bdad836fc6207..7c556c5ac4fddc 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -21,6 +21,8 @@ source "drivers/connector/Kconfig"
 
 source "drivers/firmware/Kconfig"
 
+source "drivers/fwctl/Kconfig"
+
 source "drivers/gnss/Kconfig"
 
 source "drivers/mtd/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index fe9ceb0d2288ad..f6a241b747b29c 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -133,6 +133,7 @@ obj-$(CONFIG_MEMSTICK)		+= memstick/
 obj-y				+= leds/
 obj-$(CONFIG_INFINIBAND)	+= infiniband/
 obj-y				+= firmware/
+obj-$(CONFIG_FWCTL)		+= fwctl/
 obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
 obj-y				+= clocksource/
diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
new file mode 100644
index 00000000000000..37147a695add9a
--- /dev/null
+++ b/drivers/fwctl/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menuconfig FWCTL
+	tristate "fwctl device firmware access framework"
+	help
+	  fwctl provides a userspace API for restricted access to communicate
+	  with on-device firmware. The communication channel is intended to
+	  support a wide range of lockdown compatible device behaviors including
+	  manipulating device FLASH, debugging, and other activities that don't
+	  fit neatly into an existing subsystem.
diff --git a/drivers/fwctl/Makefile b/drivers/fwctl/Makefile
new file mode 100644
index 00000000000000..1cad210f6ba580
--- /dev/null
+++ b/drivers/fwctl/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_FWCTL) += fwctl.o
+
+fwctl-y += main.o
diff --git a/drivers/fwctl/main.c b/drivers/fwctl/main.c
new file mode 100644
index 00000000000000..6e9bf15c743b5c
--- /dev/null
+++ b/drivers/fwctl/main.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
+#define pr_fmt(fmt) "fwctl: " fmt
+#include <linux/fwctl.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/container_of.h>
+#include <linux/fs.h>
+
+enum {
+	FWCTL_MAX_DEVICES = 256,
+};
+static dev_t fwctl_dev;
+static DEFINE_IDA(fwctl_ida);
+
+static int fwctl_fops_open(struct inode *inode, struct file *filp)
+{
+	struct fwctl_device *fwctl =
+		container_of(inode->i_cdev, struct fwctl_device, cdev);
+
+	get_device(&fwctl->dev);
+	filp->private_data = fwctl;
+	return 0;
+}
+
+static int fwctl_fops_release(struct inode *inode, struct file *filp)
+{
+	struct fwctl_device *fwctl = filp->private_data;
+
+	fwctl_put(fwctl);
+	return 0;
+}
+
+static const struct file_operations fwctl_fops = {
+	.owner = THIS_MODULE,
+	.open = fwctl_fops_open,
+	.release = fwctl_fops_release,
+};
+
+static void fwctl_device_release(struct device *device)
+{
+	struct fwctl_device *fwctl =
+		container_of(device, struct fwctl_device, dev);
+
+	ida_free(&fwctl_ida, fwctl->dev.devt - fwctl_dev);
+	kfree(fwctl);
+}
+
+static char *fwctl_devnode(const struct device *dev, umode_t *mode)
+{
+	return kasprintf(GFP_KERNEL, "fwctl/%s", dev_name(dev));
+}
+
+static struct class fwctl_class = {
+	.name = "fwctl",
+	.dev_release = fwctl_device_release,
+	.devnode = fwctl_devnode,
+};
+
+static struct fwctl_device *
+_alloc_device(struct device *parent, const struct fwctl_ops *ops, size_t size)
+{
+	struct fwctl_device *fwctl __free(kfree) = kzalloc(size, GFP_KERNEL);
+	int devnum;
+
+	if (!fwctl)
+		return NULL;
+	fwctl->dev.class = &fwctl_class;
+	fwctl->dev.parent = parent;
+
+	devnum = ida_alloc_max(&fwctl_ida, FWCTL_MAX_DEVICES - 1, GFP_KERNEL);
+	if (devnum < 0)
+		return NULL;
+	fwctl->dev.devt = fwctl_dev + devnum;
+
+	device_initialize(&fwctl->dev);
+	return_ptr(fwctl);
+}
+
+/* Drivers use the fwctl_alloc_device() wrapper */
+struct fwctl_device *_fwctl_alloc_device(struct device *parent,
+					 const struct fwctl_ops *ops,
+					 size_t size)
+{
+	struct fwctl_device *fwctl __free(fwctl) =
+		_alloc_device(parent, ops, size);
+
+	if (!fwctl)
+		return NULL;
+
+	cdev_init(&fwctl->cdev, &fwctl_fops);
+	fwctl->cdev.owner = THIS_MODULE;
+
+	if (dev_set_name(&fwctl->dev, "fwctl%d", fwctl->dev.devt - fwctl_dev))
+		return NULL;
+
+	fwctl->ops = ops;
+	return_ptr(fwctl);
+}
+EXPORT_SYMBOL_NS_GPL(_fwctl_alloc_device, FWCTL);
+
+/**
+ * fwctl_register - Register a new device to the subsystem
+ * @fwctl: Previously allocated fwctl_device
+ *
+ * On return the device is visible through sysfs and /dev, driver ops may be
+ * called.
+ */
+int fwctl_register(struct fwctl_device *fwctl)
+{
+	int ret;
+
+	ret = cdev_device_add(&fwctl->cdev, &fwctl->dev);
+	if (ret)
+		return ret;
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(fwctl_register, FWCTL);
+
+/**
+ * fwctl_unregister - Unregister a device from the subsystem
+ * @fwctl: Previously allocated and registered fwctl_device
+ *
+ * Undoes fwctl_register(). On return no driver ops will be called. The
+ * caller must still call fwctl_put() to free the fwctl.
+ *
+ * Unregister will return even if userspace still has file descriptors open.
+ * This will call ops->close_uctx() on any open FDs and after return no driver
+ * op will be called. The FDs remain open but all fops will return -ENODEV.
+ *
+ * The design of fwctl allows this sort of disassociation of the driver from the
+ * subsystem primarily by keeping memory allocations owned by the core subsytem.
+ * The fwctl_device and fwctl_uctx can both be freed without requiring a driver
+ * callback. This allows the module to remain unlocked while FDs are open.
+ */
+void fwctl_unregister(struct fwctl_device *fwctl)
+{
+	cdev_device_del(&fwctl->cdev, &fwctl->dev);
+
+	/*
+	 * The driver module may unload after this returns, the op pointer will
+	 * not be valid.
+	 */
+	fwctl->ops = NULL;
+}
+EXPORT_SYMBOL_NS_GPL(fwctl_unregister, FWCTL);
+
+static int __init fwctl_init(void)
+{
+	int ret;
+
+	ret = alloc_chrdev_region(&fwctl_dev, 0, FWCTL_MAX_DEVICES, "fwctl");
+	if (ret)
+		return ret;
+
+	ret = class_register(&fwctl_class);
+	if (ret)
+		goto err_chrdev;
+	return 0;
+
+err_chrdev:
+	unregister_chrdev_region(fwctl_dev, FWCTL_MAX_DEVICES);
+	return ret;
+}
+
+static void __exit fwctl_exit(void)
+{
+	class_unregister(&fwctl_class);
+	unregister_chrdev_region(fwctl_dev, FWCTL_MAX_DEVICES);
+}
+
+module_init(fwctl_init);
+module_exit(fwctl_exit);
+MODULE_DESCRIPTION("fwctl device firmware access framework");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/fwctl.h b/include/linux/fwctl.h
new file mode 100644
index 00000000000000..ef4eaa87c945e4
--- /dev/null
+++ b/include/linux/fwctl.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES
+ */
+#ifndef __LINUX_FWCTL_H
+#define __LINUX_FWCTL_H
+#include <linux/device.h>
+#include <linux/cdev.h>
+#include <linux/cleanup.h>
+
+struct fwctl_device;
+struct fwctl_uctx;
+
+struct fwctl_ops {
+};
+
+/**
+ * struct fwctl_device - Per-driver registration struct
+ * @dev: The sysfs (class/fwctl/fwctlXX) device
+ *
+ * Each driver instance will have one of these structs with the driver
+ * private data following immeidately after. This struct is refcounted,
+ * it is freed by calling fwctl_put().
+ */
+struct fwctl_device {
+	struct device dev;
+	/* private: */
+	struct cdev cdev;
+	const struct fwctl_ops *ops;
+};
+
+struct fwctl_device *_fwctl_alloc_device(struct device *parent,
+					 const struct fwctl_ops *ops,
+					 size_t size);
+/**
+ * fwctl_alloc_device - Allocate a fwctl
+ * @parent: Physical device that provides the FW interface
+ * @ops: Driver ops to register
+ * @drv_struct: 'struct driver_fwctl' that holds the struct fwctl_device
+ * @member: Name of the struct fwctl_device in @drv_struct
+ *
+ * This allocates and initializes the fwctl_device embedded in the drv_struct.
+ * Upon success the pointer must be freed via fwctl_put(). Returns NULL on
+ * failure. Returns a 'drv_struct *' on success, NULL on error.
+ */
+#define fwctl_alloc_device(parent, ops, drv_struct, member)                  \
+	container_of(_fwctl_alloc_device(                                    \
+			     parent, ops,                                    \
+			     sizeof(drv_struct) +                            \
+				     BUILD_BUG_ON_ZERO(                      \
+					     offsetof(drv_struct, member))), \
+		     drv_struct, member)
+
+static inline struct fwctl_device *fwctl_get(struct fwctl_device *fwctl)
+{
+	get_device(&fwctl->dev);
+	return fwctl;
+}
+static inline void fwctl_put(struct fwctl_device *fwctl)
+{
+	put_device(&fwctl->dev);
+}
+DEFINE_FREE(fwctl, struct fwctl_device *, if (_T) fwctl_put(_T));
+
+int fwctl_register(struct fwctl_device *fwctl);
+void fwctl_unregister(struct fwctl_device *fwctl);
+
+#endif
-- 
2.45.2


