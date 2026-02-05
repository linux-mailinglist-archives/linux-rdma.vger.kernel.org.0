Return-Path: <linux-rdma+bounces-16591-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI06EUaqhGk14QMAu9opvQ
	(envelope-from <linux-rdma+bounces-16591-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:33:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC7CF40FC
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Feb 2026 15:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0350301DDBA
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Feb 2026 14:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211043F23B3;
	Thu,  5 Feb 2026 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tJRH/zbN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012034.outbound.protection.outlook.com [40.93.195.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40B73F0763;
	Thu,  5 Feb 2026 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770301894; cv=fail; b=XjuSq26iRFDsj39X/NiGRO/WXee9nFTHp2zLUeAMRksHenhR36YjrI6LwPOk14vmEekcpdJ5nK+pw1yFaosTeSA0CRn8skQl3IGlEHWZHSq4HXFJKH3VWkMfqDv0JuWAMnIAlfzCzFnsEFvajSYJrSOnm8yamfd4ltdsYOWHAic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770301894; c=relaxed/simple;
	bh=GLLWfKEOCQVN33ESbtGsN7AgOzSsE4uzarRRj6PHDcE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a5xdVwahzVdL0VFbtyHy8FGuHy55g+VgUafKdFRwkwPO7eb5iQNFMPmIYOQvwwl6jmO6kKFHhm+H5sGHiVLS2LDMiLEtyWn/oKBoIPNcgSjaBbS+aj8dtUBjV2CUUo6ox4maFL1n9hxgL4dgH5o2EGmFBjSe3+Vp8PFdGRY1Co0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tJRH/zbN; arc=fail smtp.client-ip=40.93.195.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EU48KYDBkXaAPCO2Pvrhz73nl189G32EmsOZ6dKVhzso/FjrKtjAOawqI6hiGXOkkqoj5kjmcdiw+UVxuFGP1gLxOSvMqzRwL3Gomohaz1kqjwAQ0CsrWiCnIsvMK7+TwII96WZ20NZ/ngw6gVI7NPox7qrqH0R+xhlKHPxHEBXW66NDfTvn7Pd2SlDTq06srb2hFvoD0hEq5i7IJmBGIjY5m7PhvsWNs+3puLYSL8gZ9Y3nFf2m5cSl/XRzFSPDrhiYE1rml1pJisMswghF+Gpd+Swh/LdKuduMBgpVrG/ag3lMmFygJETto446LMGaeI94+DGVRv5cyTSP5JUstA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIQ40VeGyMlM9MDgoHOWCs9pHCsRt1h7sOIEqfxQktQ=;
 b=lrVEp1OuqmuH2lRE5YbLL/CsNLf18Z02DBjWTf4HvxdOuX8JB7KEOCWDUh5YBDxZeTPwQdobRn5D2M6SvEudOD80q8Q+fT0zbMVOzwxdfT7O4bCmq6JdRdxWeNEpAI7cGNF/TK2u93vgBWaV+XPSFs0tsmbe7AOML5z6p9I+CicZNTsG5ZDCihAjCqsOJEmzBvzSw6IhawimkFMDgOo2WotiZkgqX4DrF6bRL3rPyhZzkixRWgmKwDdxBfbDQ2qm16YDm5YL5Vk6rk6/gf6n134vjxH3hOg+IR2Xf23FtN5cVROszBHVaJuhlPWCQrvlTS1gZbG26w4npaQkMCRy5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIQ40VeGyMlM9MDgoHOWCs9pHCsRt1h7sOIEqfxQktQ=;
 b=tJRH/zbNhHdUm1ENURrG5yc/f1SYBYuHL2wKbay0KU3B17kmEyi8s7IfnxdnSgEY+CwZdbDyrs/Rbw2WlFcoS8rz2I+Faxwud5nXcC+shOOJR/8vm0y+wAS0YzfIM0tFSG7x1FMmrK2GUXjLeDwD78jQuzHuXwDxFtx+r+tjdsObhcCC+eqP29Q0ceKCI3UAXVp7KMz8fm679bpE5/SJvw/Qon4sFcusInVc+q+8tk07UXZdEMmon7ypGKP6HuTL1/qRRdzucLVAEQVGiW4RFXINGBqvPUHE+dOK+4BnfIOJs6T93H+tjKBgH/y67VKy5z49nl2fnoW7ZIRCrg8Zyw==
Received: from CH0PR04CA0075.namprd04.prod.outlook.com (2603:10b6:610:74::20)
 by MW4PR12MB8611.namprd12.prod.outlook.com (2603:10b6:303:1ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 14:31:29 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::17) by CH0PR04CA0075.outlook.office365.com
 (2603:10b6:610:74::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.15 via Frontend Transport; Thu,
 5 Feb 2026 14:31:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 14:31:29 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 06:31:03 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 5 Feb 2026 06:31:03 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 5 Feb 2026 06:30:57 -0800
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
	<shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Or Har-Toov
	<ohartoov@nvidia.com>
Subject: [PATCH net-next V2 4/7] net/mlx5: Register SF resource on PF port representor
Date: Thu, 5 Feb 2026 16:28:30 +0200
Message-ID: <20260205142833.1727929-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260205142833.1727929-1-tariqt@nvidia.com>
References: <20260205142833.1727929-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|MW4PR12MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: 10e2ac93-cba9-474b-ee2a-08de64c34081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mfdgRmAyncXwlNwlsMUgGkMxdWHRF2Gi2hLUi6fxLEY6F6KYrF1weG5YOSKE?=
 =?us-ascii?Q?ber0Q++AcCmJQbNK1i7/r5MNtInLjS3iFEaMgno0dXi2TppNj/qTd+37lHu/?=
 =?us-ascii?Q?1Ki5Ov5bDGhGuUvseRopybQE4VP1UMhzEn1Ai6Y3629iNzFsFVwN/RnGjvV3?=
 =?us-ascii?Q?Xt5LjaH2d7jZGUxwJRJT8cjmF6TSSXcQqQ1Z6QdEKzs2jySCkwmON87ZlkN4?=
 =?us-ascii?Q?Wi14r02sJqvezbthwSDnjYwNVRs8zo6ep0ol65Rx7xeJJuMF257IEQIpBrRR?=
 =?us-ascii?Q?pAUJqBfcBOjGmV13w3ovN8RvG09pU5iDITiu9TD7lbrYDgrBuPx1rvGQWoq5?=
 =?us-ascii?Q?fsHCYFqbDOpF2nxHVkRHKnUfPwwJ/qUFTDMwiawfHu5O9CwmaV4z0TNQTGt6?=
 =?us-ascii?Q?FxDqI21yIHJF6j4Ely6mLvIKljOEFHlpaHS2mX7eSiIAF81ncmZR2HNWisLc?=
 =?us-ascii?Q?iXzojmROblsB/evr2XEmhaW3+Sz68BCVmgO5hjZe7cbRqr+jL+Ap4UBZUREs?=
 =?us-ascii?Q?g8ARBmg6cTFT5vI9uLhywHwK/xb8ZfJemQUasL9LwvUO/jzJllXsXPtO2H+V?=
 =?us-ascii?Q?Bt15cMGoJWG7F3czyoghzEgfOyhVca56GI8nWi0j6quJoZe/7vPbQeo6NwDj?=
 =?us-ascii?Q?zo8/fM7Em93NJ0dBiclmGfG5qqgvRwGmPv6lZg+1tHC0d20F7tbb83CK+AN4?=
 =?us-ascii?Q?BJ3vJSJ/WWNHLuyiAXaG7Op1urT/GJFDWJie+HRCc71RKs2ZNNhH6eaZVoGz?=
 =?us-ascii?Q?xqUMd0gRRjiDdMCmGPfXQfNDidlOhNKKk/OAf2QR4W9y6JXZvip9EqeRtA1w?=
 =?us-ascii?Q?Ty/oDCKTFrHmsnVsSvsgYgJpEvlaDriNJv5ZbbKyUM+/8GpWZcVowrD2Rcg/?=
 =?us-ascii?Q?yxrgyutFkeEOJa5G/CcZm1NkMCWFHam7BGx1YRBS/0lCMBVD3OdfuLymjRNA?=
 =?us-ascii?Q?5og9atwRju06jW6iI8wZQxlM+A/P3dlIXLyfUfRdQJykOdOQ0UqrdC4uWRUH?=
 =?us-ascii?Q?Pp2gK3I0tUwBHfNUeHfat7jkr5D2RWF2Ra5+mWVF/K/6xRyZpbwwByp77Bs8?=
 =?us-ascii?Q?ndJDf+ZvKzlbzXw+jolPrnbEy98A/cUPjdmhzQnAXbF5KMaYfbGptp1JtyZp?=
 =?us-ascii?Q?05XOHTeaH88Z2Q9dbkslauKsQFTqa55wjd3lCcwISOpSlsjBH8QHRwKValU4?=
 =?us-ascii?Q?tquoO8q1HJzLW+qPPFkQ2/SK2/mQYpTA88pTKY0cCX1Cp7ltP5P9uUTaqyTf?=
 =?us-ascii?Q?JHAJrgZ/8udJPm5sIkItdJP/TQUqy62heh914o/ejPrWeO9G8e/2j858nEoI?=
 =?us-ascii?Q?f2zJGO782qQJop1/0Ogm64df+i4wBFffvAFgSBeHIntSFylb3BnlLX2Uo/g9?=
 =?us-ascii?Q?gtwNx+pehbhIFFWVMrOdrj2u+WKRmgIili7+ukzLpzusVigsCvApCuUv2xnx?=
 =?us-ascii?Q?9sSFfVLXCkXipXtNOGlzVv8X0Ix1+U6VIyZneGShDRkWAjtcXj2XC/zldIl2?=
 =?us-ascii?Q?lNuWWj/vSUroqYhtkg+tJlopZjfUPVGcC3jYPL8Lr1X1jxZ2/Uv9HaOX9dNi?=
 =?us-ascii?Q?Wo6J6KYcKFv/UFjMAvpvBbum2mxtQV/pbtGDi6nXHvxukLpcTzN3d9BNJe+i?=
 =?us-ascii?Q?bi0VrTgHSR33tw0rPHciJyNeYlQRGiUT6yqIQKM12EySh09+QA3oBBPHLnIq?=
 =?us-ascii?Q?XLIGSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bcZurddTsDfvUXUarFnTsBDI5LRAzbw/+wCLylz6pJ+RoNAVOS6rR0DuYT6yaEUgF5cxLZcKIBXTy/BEo7jGTx581scnA27e6x/YCRtuxNYlaNt8EIAGdjAKgH8utpvmgAQqOFK5ZMSGPu0eQQ/AEVLNABHJy12tVlUymKylFF6UiQX5uGpziNutTcBOBvfm9Qc0pGTbp5qciz98K7kP5/SpkdR3IhkEvfyyOU2eLMLLeG7/HiVnbF+IYfSFx/xZCTo9dncSqe9O+LL11scHvGUkRHfOrdkftLRiWqMqdoii8jh8nNvAG82w8nIpdwfxwidomPT/uRlPUITqtF3JQ2CXcBgfciOTlz2otGaYt/3hiF7JjBwfV1qWoWufWX5HO2h1yLnq4856ZItAqBlmnYPbrc5rZRkX3I71q0iDtXe3tXGiMA/H9ZAZLtWO/G09
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 14:31:29.5946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e2ac93-cba9-474b-ee2a-08de64c34081
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8611
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16591-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email,Nvidia.com:dkim];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: EBC7CF40FC
X-Rspamd-Action: no action

From: Or Har-Toov <ohartoov@nvidia.com>

The device-level "resource show" displays max_local_SFs and
max_external_SFs without indicating which port each resource belongs
to. Users cannot determine the controller number and pfnum associated
with each SF pool.

Register max_SFs resource on the Host PF representor port to expose
per-port SF limits. Users can correlate the port resource with the
controller number and pfnum shown in 'devlink port show'.

Future patches will introduce an ECPF that manages multiple PFs,
where each PF has its own SF pool.

Example usage:

  $ devlink port resource show
  pci/0000:03:00.0/196608:
    name max_SFs size 20 unit entry
  pci/0000:03:00.1/262144:
    name max_SFs size 20 unit entry

  $ devlink port resource show pci/0000:03:00.0/196608
  pci/0000:03:00.0/196608:
    name max_SFs size 20 unit entry

  $ devlink port show pci/0000:03:00.0/196608
  pci/0000:03:00.0/196608: type eth netdev pf0hpf flavour pcipf
    controller 1 pfnum 0 external true splittable false
    function:
      hw_addr b8:3f:d2:e1:8f:dc roce enable max_io_eqs 120

We can create up to 20 SFs over devlink port pci/0000:03:00.0/196608,
with pfnum 0 and controller 1.

Signed-off-by: Or Har-Toov <ohartoov@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/devlink.h |  4 ++
 .../mellanox/mlx5/core/esw/devlink_port.c     | 37 +++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.h b/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
index 43b9bf8829cf..4fbb3926a3e5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.h
@@ -14,6 +14,10 @@ enum mlx5_devlink_resource_id {
 	MLX5_ID_RES_MAX = __MLX5_ID_RES_MAX - 1,
 };
 
+enum mlx5_devlink_port_resource_id {
+	MLX5_DL_PORT_RES_MAX_SFS = 1,
+};
+
 enum mlx5_devlink_param_id {
 	MLX5_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
 	MLX5_DEVLINK_PARAM_ID_FLOW_STEERING_MODE,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index 89a58dee50b3..2b6c3c9e5cc3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -3,6 +3,7 @@
 
 #include <linux/mlx5/driver.h>
 #include "eswitch.h"
+#include "devlink.h"
 
 static void
 mlx5_esw_get_port_parent_id(struct mlx5_core_dev *dev, struct netdev_phys_item_id *ppid)
@@ -156,6 +157,32 @@ static const struct devlink_port_ops mlx5_esw_dl_sf_port_ops = {
 	.port_fn_max_io_eqs_set = mlx5_devlink_port_fn_max_io_eqs_set,
 };
 
+static int mlx5_esw_devlink_port_res_register(struct mlx5_eswitch *esw,
+					      struct devlink_port *dl_port)
+{
+	struct devlink_resource_size_params size_params;
+	struct mlx5_core_dev *dev = esw->dev;
+	u16 max_sfs, sf_base_id;
+	int err;
+
+	err = mlx5_esw_sf_max_hpf_functions(dev, &max_sfs, &sf_base_id);
+	if (err)
+		return err;
+
+	devlink_resource_size_params_init(&size_params, max_sfs, max_sfs, 1,
+					  DEVLINK_RESOURCE_UNIT_ENTRY);
+
+	return devl_port_resource_register(dl_port, "max_SFs", max_sfs,
+					   MLX5_DL_PORT_RES_MAX_SFS,
+					   DEVLINK_RESOURCE_ID_PARENT_TOP,
+					   &size_params);
+}
+
+static void mlx5_esw_devlink_port_res_unregister(struct devlink_port *dl_port)
+{
+	devl_port_resources_unregister(dl_port);
+}
+
 int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 {
 	struct mlx5_core_dev *dev = esw->dev;
@@ -187,6 +214,15 @@ int mlx5_esw_offloads_devlink_port_register(struct mlx5_eswitch *esw, struct mlx
 	if (err)
 		goto rate_err;
 
+	if (vport_num == MLX5_VPORT_PF) {
+		err = mlx5_esw_devlink_port_res_register(esw,
+							 &dl_port->dl_port);
+		if (err)
+			mlx5_core_dbg(dev,
+				      "Failed to register port resources: %d\n",
+				       err);
+	}
+
 	return 0;
 
 rate_err:
@@ -201,6 +237,7 @@ void mlx5_esw_offloads_devlink_port_unregister(struct mlx5_vport *vport)
 	if (!vport->dl_port)
 		return;
 	dl_port = vport->dl_port;
+	mlx5_esw_devlink_port_res_unregister(&dl_port->dl_port);
 
 	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);
 	devl_rate_leaf_destroy(&dl_port->dl_port);
-- 
2.44.0


