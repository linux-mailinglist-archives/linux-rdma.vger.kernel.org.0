Return-Path: <linux-rdma+bounces-16587-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KufJPqphGk14QMAu9opvQ
	(envelope-from <linux-rdma+bounces-16587-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:32:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9587F4081
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BFD1302A6C3
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 14:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B71A3EFD11;
	Thu,  5 Feb 2026 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eHkddD8C"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010048.outbound.protection.outlook.com [52.101.46.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FCF218845;
	Thu,  5 Feb 2026 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301864; cv=fail; b=coGEKrgqwIFmafuu5kyIm0FObNVqceS/tEt9ei80SyLv4HxRxQcpRAcaTj0eDvzVUp++oK+Me9m6GEf4kuAOA90q6PKxE9+INEfcQT72n7kx6qexTnO9hVMrEYJubWSffQswCA5q89+jYFCZi2dX2u0DzLGbhAjXyxXtpEFb7k0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301864; c=relaxed/simple;
	bh=2CHOeT539KpSsqg0RfDx+UajNjNV3t2llxoFH0QMDbQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J0+fqIbptpjWME6IdvhdNPD+BEkkmpTH+68tF0OwzXszloU+OQPn6viWdeTjbn8DzVwFt6IBM4VGim6HLKgE1Iyeqxigz/tkSbeqt4wFpwEWnIbKXGD2a7BcoIXp0h3ItGTI/vBjds44YB1vzruv+8y1tS0rMkl1eEPvu7+A/9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eHkddD8C; arc=fail smtp.client-ip=52.101.46.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EolqKAvfTnEn3rzlNQZIeGsc+4+EMUo90Cemj8+L9xZ0XByys6ajsintZRDuCpMCGxtbaw+4TSkRTGFCO9pNJi0mqUW4KFz9Tt0FoM/RTBul+p+H7zGimmtAnT6H1kTMV+9CRFumxTcQw5tcKtxpbtVpG5R2ayy9noN/vAUKvvz9ULG9E6elnbnJ00+GCPzM34FqFlKPaYC4oWsbZ8XMmlGgtTqWkOcGRJwjTa1hjgqrkHNCgFpfq/KunfXsDvYOB1x7h06MhIHgD5aUigQosycn0Lat70eZr254aKpX2QIafOmqVSVo/0NY8yjh8AUGDLW/mYgHLCtJgaXgO8GC9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/zdk2ndmGt9gGUI4Y9819rRXu1ejUA9UP6c2xvG4rY=;
 b=vqkIFpHA/8o6ilCetpwGPQvFiZ/DAZZ3tjAyev2ykwftc7LOqMAsA/0kOb2Qwg50kqZane1Wf6OIvzMcLtwble6FbOAZyu/OtedWDjYDhtFVLiNAmcoIU9qnEgsifrZXqS5dw5KjzLYr0ILyY9kCn/k9Hr/Hg61nEsoclSncF2lQAyDxZ/c3fGwkyRX54dQpoNVQ0AmXFJ6carQO67Cbcran1NIQXEEb1kQIQzRut7Paa4atZU+R6oJM0jcdvhM37TGlAlNJ55oDmooOBEchtoU1koh1EZaIjbIeWYd38Mfg241HQqncHw5xbFLxZMiODg5IsnhoQ0xohnxJ7B3Isg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/zdk2ndmGt9gGUI4Y9819rRXu1ejUA9UP6c2xvG4rY=;
 b=eHkddD8C2TQiCXXcSTcmpxIU2unoohVhEpWdEknjmyah5bCphBH/89QxzIoHu6dXUdV5JWVmhLMaxeVNjqibxYyF6t1TL0XoYhs6Vy7y4q6SlQA0Sqx2/9uaDhx+4kpP4V2srbGEmZ6yEk7VydqR9manx/24myUGmchCXnAveC9+WPVz2mNaT8AgXMkpwKltWfpEiOmMxNLxn/0+yFgkXZV5BVCu8+gxSyUBNa1WUj5vA4B4hn4+C/5uVWRPQ90Cssf1mIJyHfXc372oYC1gOwu+qHFMlN/tuomKO/FTfv6oyN7GJCLBAxvIWKGaE6Wdgil9VfHkIOx8LX0mw5bfWA==
Received: from BN9PR03CA0378.namprd03.prod.outlook.com (2603:10b6:408:f7::23)
 by BN7PPF34483F4BA.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6cb) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 14:30:59 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:f7:cafe::6b) by BN9PR03CA0378.outlook.office365.com
 (2603:10b6:408:f7::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Thu,
 5 Feb 2026 14:30:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.0 via Frontend Transport; Thu, 5 Feb 2026 14:30:59 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 06:30:40 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Feb 2026 06:30:40 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 06:30:35 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Shay Drori
	<shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V2 0/7] devlink: add per-port resource support
Date: Thu, 5 Feb 2026 16:28:26 +0200
Message-ID: <20260205142833.1727929-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|BN7PPF34483F4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: ac0283fd-4264-4971-b502-08de64c32e65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5/nUr+DONj2vOvsr3Wt9AoD5/mfhPegKYtKoUEoPKRxmK6BDE53P4zH+y2cr?=
 =?us-ascii?Q?ehpAOWhEn4Z6L0Ui+ILaRi+CgqyjB29akBAvh/aS2OzyPjIC6MmfnBCOOGj5?=
 =?us-ascii?Q?ue/8X9qHtYfa00oktDmE4Lool7mYGTotR88xfAp9epEbEr+MNfhKtUq8I12o?=
 =?us-ascii?Q?zLBwmjvGGvOnXO9yGthpsG9m5A4P1iqmZxjqSXSBYuNpL1/27/bInSJA5nuP?=
 =?us-ascii?Q?iJuQ5EveOV1icqC/MjWV78RAxV4nSCJYYUNMeIZeYRQ+o0lvOG8oOfIuPaZB?=
 =?us-ascii?Q?GOLs6tvCfcjcS9TLuMok5nKR5xsaDy/qZ2XLESWjFbj5HBXerZJKhsKXLaG3?=
 =?us-ascii?Q?qHQU9mkwXwDhEvfPEAovuXhBDXJA9TQqM0nXJdECAtG8esTbjPJECyThS2A6?=
 =?us-ascii?Q?1L/AzcH+TUg2Xkwq+C1rpF5qqXAXLLw4tZvm4YUThd6M2P9/6Sco61Jc2eHT?=
 =?us-ascii?Q?ic73lHuvib50v149h9535wAS/Qk2Z1A1DEXY31+cxJfEapnfJOjyD2m2VsmP?=
 =?us-ascii?Q?lxzqhkvQvvg+v9wuIBO3j2E5FcpXmTQsEzro68gZU60a4rrOfOh2rW4LF1RX?=
 =?us-ascii?Q?VXXgDuarkeEfUwGexwbBUYu/YmG/oSf8XRpKBxrrAKoBrZaIjsENVy4UdPc1?=
 =?us-ascii?Q?0k9jQ5njRgea2C5IXIGI3UsnTwc0MndAvSq1hsinmjEPQjLh4Y9uyBIIjIG4?=
 =?us-ascii?Q?/RGIxRa1Qmc+yHERaO5qis+7aQyLYNmj2ir/+e/WuA2QlpAiFPyoGZ6cvgo2?=
 =?us-ascii?Q?RoiLqvdoB/EbwDo/zt38m/zq3VcDdWctNVndmN/6xCMjGeqp3Qfo8wXRlgQH?=
 =?us-ascii?Q?66i+5wL8Oc01yL8PzOXSuu8x9sOkL6hkKQ6zM0BhNy8HGwf5S+RVyXMTlzfD?=
 =?us-ascii?Q?42l3a9awpNjvr/ovZVM4+vE0loxWO/iQIyFJBJaJdWiuWpD9dePSbHJmSwTN?=
 =?us-ascii?Q?AZ/wK/qbEIWsTzrFHkt8ErQm61cRr6uC93KIK0Zg/PzSat2ZumQfTnm9cQXw?=
 =?us-ascii?Q?kS/zF/xS3/dV9CCbR6RqtcgYmz2i928y/bs1bQ1/vDL0L5CxEz17vTetx3zt?=
 =?us-ascii?Q?7Nzw9VuRNYIAWNstE5//VoJxtBEzaGb1VB0jh9C33hOshshpXUo7vU9WmwtG?=
 =?us-ascii?Q?Uvm3uJ+QheFf6Mg+jqdK/U0awoY53K3Q+y3b9uml6CdMYFP57/Jo37WAxUha?=
 =?us-ascii?Q?l/zb/yJ3due7YQJthkv79ol/2XKXJNvRqLW5PGaRUY/zqnsscTDbImIbq1XW?=
 =?us-ascii?Q?KDguql6j7KrCil4yipOlSjYTGiln8Ckb/nOrleHcYs1oLZA/D7UkoPadVApI?=
 =?us-ascii?Q?YtrGqrB4H6z9y4WKJATykTGlnMFw0ZFdYpHSZGns/5GSeoGa27VcORSgpYPa?=
 =?us-ascii?Q?WYmqm9+LUoQDpEzYo8JzbtoYNZ1MJf7xvLdXWv0Zzk32sYVsEza4Fl+Tcq4e?=
 =?us-ascii?Q?oEVcwJnFboEjQVpDg342FCV2kQHOi2xiEtd2biy2spn70phEhJlUOLY3wbuQ?=
 =?us-ascii?Q?0loYEK2lMUyHWoCBrCnITlAPyI0VPLqGnIR/xPVl66FT8KQqm1d4oG1XDvm9?=
 =?us-ascii?Q?yaYZ/09rdw7zS5FnVASdElM7ujVoY/kQOdy2DU1AObfKJyor5rCK1HxPs4d4?=
 =?us-ascii?Q?4fkN9M4Z8mAkHBV7G1YAQ48=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HchDD9I9ADz5laiLkBNCJrMaMJ5i6dUCid/6Kgm4vcYc4sHOUYHom/9iWNG8wj3LXl/BqiAnGcKlU1i/kLhb/r41guCYbo0RfvJcd5MO7KKbgoIvv74tQEvsuZ9EIkcqvQxEgVblDgFCGx8EQEcakjLVtbBOPLN8nZ/5h0PphQ+Rg5IZGCrNQloZVsQa+dhxUWglvVoshm9Vm4NoW2N6Bg2uirqfEpanNNMNtEt4l7VbcKeH9Ejs05RQCETb+/a5h78xyc6UlUCKx8ALceafUzA9j72xkIP7J1uwF1bdJKcxVspFbye0cN+1JPxExTEzdh3pCVoGIGOtyOAeYAZxGFwk2JOIUIh01SjAUpabMI03LAOZT3oEip6jTF7KWgaluX8RvB/Ix8OvcCfGWaeSO3eWrmlnjtok5fA4nWgkWWdlB9hv4HL99PwFHq9lEsxQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:30:59.1096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac0283fd-4264-4971-b502-08de64c32e65
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF34483F4BA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16587-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:mid,Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: D9587F4081
X-Rspamd-Action: no action

Hi,

This series adds devlink per-port resource support.
See detailed description by Or below [1].

Regards,
Tariq

[1]
Currently, devlink resources are only available at the device level.
However, some resources are inherently per-port, such as the maximum
number of subfunctions (SFs) that can be created on a specific PF port.
This limitation prevents user space from obtaining accurate per-port
capacity information.
This series adds infrastructure for per-port resources in devlink core
and implements it in the mlx5 driver to expose the max_SFs resource on
PF devlink ports.

Patch #1 refactors resource functions to be generic
Patch #2 adds port-level resource registration functions
Patch #3 adds port resource netlink command
Patch #4 registers SF resource on PF port representor in mlx5
Patch #5 adds port resource registration to netdevsim for testing
Patch #6 adds selftest for devlink port resources
Patch #7 adds documentation for port-level resources

With this series (and upcoming userspace patches), users can query
per-port resources:

$ devlink port resource show pci/0000:03:00.0/196608
pci/0000:03:00.0/196608:
  name max_SFs size 20 unit entry

$ devlink port resource show
pci/0000:03:00.0/196608:
  name max_SFs size 20 unit entry
pci/0000:03:00.1/262144:
  name max_SFs size 20 unit entry

Userspace patches for iproute2:
https://github.com/ohartoov/iproute2/tree/port_resource

V2:
- Skip selftest on old userspace that doesn't have the devlink
  port resource command.
- Add link to the userspace patch.
- Rename internal helper functions to follow kernel __ prefix
  convention.
- Split first patch into three logical commits.
- Change names with "res" to "resource".
- Change netdevsim test resource to be generic and not with max_sfs.
- Change "max_sfs" to "max_SFs" in documentation file.
- V1 link: https://lore.kernel.org/all/20260203071033.1709445-1-tariqt@nvidia.com/

Or Har-Toov (7):
  devlink: Refactor resource functions to be generic
  devlink: Add port-level resource registration infrastructure
  devlink: Add port resource netlink command
  net/mlx5: Register SF resource on PF port representor
  netdevsim: Add devlink port resource registration
  selftest: netdevsim: Add devlink port resource test
  devlink: Document port-level resources

 Documentation/netlink/specs/devlink.yaml      |  23 ++
 .../networking/devlink/devlink-resource.rst   |  36 +++
 .../net/ethernet/mellanox/mlx5/core/devlink.h |   4 +
 .../mellanox/mlx5/core/esw/devlink_port.c     |  37 +++
 drivers/net/netdevsim/dev.c                   |  23 +-
 drivers/net/netdevsim/netdevsim.h             |   4 +
 include/net/devlink.h                         |   8 +
 include/uapi/linux/devlink.h                  |   3 +
 net/devlink/netlink.c                         |   2 +-
 net/devlink/netlink_gen.c                     |  32 +-
 net/devlink/netlink_gen.h                     |   6 +-
 net/devlink/port.c                            |   3 +
 net/devlink/resource.c                        | 281 ++++++++++++++----
 .../drivers/net/netdevsim/devlink.sh          |  37 ++-
 14 files changed, 441 insertions(+), 58 deletions(-)


base-commit: 021718d2cc1a2df2f53b06968fa89280199371bd
-- 
2.44.0


