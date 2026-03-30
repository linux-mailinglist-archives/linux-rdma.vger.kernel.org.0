Return-Path: <linux-rdma+bounces-18796-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIRVKAC0ymmE/QUAu9opvQ
	(envelope-from <linux-rdma+bounces-18796-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 19:33:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5E135F547
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 19:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 518E7301E20F
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Mar 2026 17:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46BF375AA7;
	Mon, 30 Mar 2026 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NTlbBZ8u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013056.outbound.protection.outlook.com [40.93.196.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFAD40DFCA;
	Mon, 30 Mar 2026 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774891944; cv=fail; b=tuCU8PSUCl3mUDL6vGwy3ZHjjvuWqypivVt8PN0KzGVlJSsNnc4G4MMixgiSazRgWdWIVShL1Spb4EKwwQWK9nyXg/5aw6Ui270XQ95iu4WWKr2bQSXeNDouYq+l+LOgTbJuF8eGsIzw+7d4DA5b5Yf9DFY79Ulwo2uxRhDtoVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774891944; c=relaxed/simple;
	bh=vKRUkWJFwFKWFrOpxU/uq46vDNgOrOwLJbG+m/e/3CE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e1cjeklYNPl3zOV6wbl6nFBwSKuHi0NtejIr7o6jvWRNgQeiT4CjtxWwCgnmBn7WOMUeu0AYm3icD9WG6/p8UO3OHpeDiDjhFMHquiuhIZqIP53Cem8vaNHQK+by+JCL5pc9J0YgFTP3Kcaif0lEnhGhWH3lLH8idm2YI+xeAoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NTlbBZ8u; arc=fail smtp.client-ip=40.93.196.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=arghyaxGmcothBRmy0Lfp4xeTRISbDVUo1gt2csN09nQSrNzoz5sOBDLrHw85iOka3aAKbbiLUD0w5uQ5MX55FjNIcxXU5PvFU/93/2Pf/uF4gu2FEKAxffHhvnGFsbGSNrt8u8PE+Hr4sYRWJ0lQiJlt/4yV3armaJh/MzbNlj86ZWoK93FSXlzOD+9yI9mED4D6M1FdnEMxpaoKxv2ZbvF4Z+Xx8rPA3aNTzvwGSvhjrI8Tt5/pB3hxGIkOeEGoOyV3MbQCGBeFP7sUPqY1+gxYmuroXMAx/5MZpJBGHsevQ2gFR6o/QHUvlqfL6GtPn+TslIG+b3b1lCDfxvxqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOLRcV5PogVCTx2xAVOqDyPLdbYDu/VBeqLnadbIS94=;
 b=LAg6zaNew0e2MVOEIxPmVwnr2100+ipRLGWnbRPbS+g7rP9MF8zfEq8atNAk1Xzvtk94AokHng+m8Kmv+NIGiVgZ3hUe1RrHxRaQiB+cl01WPX+W3dGy7LdzCjyXGxrPbcbh23E8T/Cko4JT5lJP/LbQJBVuAlY7YPRGQNLmOJLFwv9J2k3yQCX4krHJCRsdgEAO89uIFTEGQCxq7OtDE9tWfR8tStj1Lf4YBOTgXslQEC1PmPXkhqWVQVkZGa7DPQlgXsDzY6K4i20cmMHN2477lwL2xZCmOtx8xNALjEvwKU8wuwLWpsYO0qQKkt5Qfli+a6kKIuOfKZqXg3DPeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOLRcV5PogVCTx2xAVOqDyPLdbYDu/VBeqLnadbIS94=;
 b=NTlbBZ8uUWpAdsr5FGYhf0B9MXH6AUxgxNOtwpIbU8YN2EhSmm2Qi2GiMTFFvXXS5tbJOtaleU1SQl4fBLiRIvwe1TCogER67J8ki47/sFJcV97UVKin6U2MGN8vig6q1mDVK2Vk/ieuDLUCR3STmJEO9mIgHQC5FsftfS0zlCEXiq/0DeYz9LrQOYLPxexwzd05c4ZvNKhXy29oUlfZzhcg8+y6aBTbWn2fiP9E6XIruv3da43cAm88zsYVMaiUP2ad7GVKEh7HDCCyP/typP5pD5IAItFGTVcbvevn3sbRs5okqBtGJ7zUwYl+2E8sabvhIFHOiZdFtN4qbk8gOw==
Received: from PH7P221CA0035.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:33c::15)
 by MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.12; Mon, 30 Mar
 2026 17:32:19 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:510:33c:cafe::6e) by PH7P221CA0035.outlook.office365.com
 (2603:10b6:510:33c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 17:32:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.0 via Frontend Transport; Mon, 30 Mar 2026 17:32:19 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 10:31:57 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 30 Mar
 2026 10:31:56 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 30
 Mar 2026 10:31:54 -0700
From: Chiara Meiohas <cmeiohas@nvidia.com>
To: <leon@kernel.org>, <dsahern@gmail.com>, <stephen@networkplumber.org>
CC: <michaelgur@nvidia.com>, <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<netdev@vger.kernel.org>, Chiara Meiohas <cmeiohas@nvidia.com>
Subject: [PATCH v2 iproute2-next 0/4] Introduce FRMR pools
Date: Mon, 30 Mar 2026 20:31:14 +0300
Message-ID: <20260330173118.766885-1-cmeiohas@nvidia.com>
X-Mailer: git-send-email 2.38.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|MN2PR12MB4317:EE_
X-MS-Office365-Filtering-Correlation-Id: be57b099-65f7-4da8-8e14-08de8e824b3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	9x6SFdTzFQiCsyOlHU/HGeUcaAtazDbAaXMcFrZwjTOKPf/hmEzGAkTb4906Vt6M6TZUgvz0kqwhqMDbBMLqhZyEmoyDOoacsbcTqTJLLw3bUW1v78pOBujRmh2xYlMoOrtQGJL+kYrzwNvUPTJ9HHBd4+jM5hlvOfm2jQdy8mIvMPq6Rq/iN9veKlSRnkPFs3kz7l7nYDWMDp89b1Ot5AAw+OSjJ6PrcSRIj+obrscniBi2Sf0FFpMIjZb8Xs1acEFDRTsp3Rl+FLhVjx1Fa4Ux1XZZETz4WTxOJmlJ2cfHuGcksirwi2j6hhtRRb8jEt2HTPi4EbyN3/K0nh90NZZqQOs77Gm3dD4aSOaHIxCt5cQ9qpngrrg92YYwqkjms2cthNAxmzSSbvwkNIrs4VqIcBlA3IizCNVgS9ibF5+fOVjV2mWyqFqH0+fPQ0xKdgdOKk0BvSdHwI4e7wntSPm+DoLKeumJ3jZOfJUfrWtFHCQlCXw5/OcnH4ptuKyhYEZcaH79fB+0qSeCHV/qEvx0ptYUS297MEHpaC7rUkMqgwmQYNbJy9X9OMbxlBeCYHSGzomMRG1wn3Ttf5w+VjE9EPNCHsrkI59QSQx7eHcvVi7EG7h3ksVhf8wUaBBeBfO2VWGQ0SJVJqMTwbaKXegDMt2942tlGWpwlfzc4ecoS9AYogmk1LXr7ZOZcr2Vl6QKA6dyW2H2kVCHM1G55n3F5jYuzfpRaMGL98MNEBUKKQ07fbzylyxtMLw49nQ6MP7c4923yJKm2OvToSvwag==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	krtltZLXN1zP14Z8a2yRTVlgAza6/hfOvKenGGC7u+QP8MnN7gZaZEcjruIq5LL2UQqo6XQ55HZEdlI8jB2lztEqD+FrMOPZnAuqu3uj0xwwZhnB/s6X8rMX4CFGOIIoletLXr446idjXIJaSG/SPTJ+Od8CuquOGTdVQm/nngQZLihKi2BxugLKshY7mmIIBhlwr54QKA/P/LRNF88IZRik26G8fTZHGa5IM8zTujl3hTfr2869M4t/FdsDBHQctKxRXIIkiWSrdBiiBCGbmYGbv1fd8UkAPkr8HUWwqO9dKV1agD9cGpqMzYrAJhm5YnCOMpew1tCC+Ijy30hCjxhBqicFCyiTRPo8AySh8j69FhclISnTyPBJPBE+2RTQW/hu5GQLuENsjaIHHmiUNZHkyhs8O/64vEu4MVVlsYKRLIiQ9ddCrwCoqlb8IGY7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 17:32:19.1864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be57b099-65f7-4da8-8e14-08de8e824b3a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-18796-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,networkplumber.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cmeiohas@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 2C5E135F547
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From Michael: 

This series adds support for managing Fast Registration Memory Region
(FRMR) pools in rdma tool, enabling users to monitor and configure FRMR
pool behavior.

FRMR pools are used to cache and reuse Fast Registration Memory Region
handles to improve performance by avoiding the overhead of repeated
memory region creation and destruction. This series introduces commands
to view FRMR pool statistics and configure pool parameters such as
aging time and pinned handle count.

The 'show' command allows users to display FRMR pools created on
devices, their properties, and usage statistics. Each pool is identified
by a unique key (hex-encoded properties) for easy reference in
subsequent operations.

The aging 'set' command allows users to modify the aging time parameter,
which controls how long unused FRMR handles remain in the pool before
being released.

The pinned 'set' command allows users to configure the number of pinned
handles in a pool. Pinned handles are exempt from aging and remain
permanently available for reuse, which is useful for workloads with
predictable memory region usage patterns.

Command usage and examples are included in the commits and man pages.

These patches are complimentary to the kernel patches:
https://lore.kernel.org/linux-rdma/20260226-frmr_pools-v4-0-95360b54f15e@nvidia.com/

--
v1->v2:
- frmr_pool_key: Replaced packed union with plain struct                                                               
- moved to colon-separated fields output format for pool keys instead of hex
  strings                                     
- Fix commented types of AGING_PERIOD and PINNED                                                                         
- Add res_frmr_pools_idx_parse_cb stub 

Michael Guralnik (4):
  rdma: Update headers
  rdma: Add resource FRMR pools show command
  rdma: Add FRMR pools set aging command
  rdma: Add FRMR pools set pinned command

 man/man8/rdma-resource.8              |  51 +++-
 rdma/Makefile                         |   2 +-
 rdma/include/uapi/rdma/rdma_netlink.h |  22 ++
 rdma/res-frmr-pools.c                 | 352 ++++++++++++++++++++++++++
 rdma/res.c                            |  19 +-
 rdma/res.h                            |  20 ++
 6 files changed, 463 insertions(+), 3 deletions(-)
 create mode 100644 rdma/res-frmr-pools.c

-- 
2.38.1


