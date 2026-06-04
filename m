Return-Path: <linux-rdma+bounces-21727-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +i0IFPHUIGo08QAAu9opvQ
	(envelope-from <linux-rdma+bounces-21727-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:29:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FA763C339
	for <lists+linux-rdma@lfdr.de>; Thu, 04 Jun 2026 03:29:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=Gl+BhzhL;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21727-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21727-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 192513041A0E
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Jun 2026 01:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14401A6817;
	Thu,  4 Jun 2026 01:28:08 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013033.outbound.protection.outlook.com [40.107.201.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D0E266B46
	for <linux-rdma@vger.kernel.org>; Thu,  4 Jun 2026 01:28:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780536488; cv=fail; b=nZ1OKyb6CuQrBLGjupyc/bgt0+szvkVx2oFYSRKNes1Mi4T0hXUoCeQ70IKF/LlTooOWf8kjf7PWhfBmmo7ATjDk/RAODmEZX5NvuYU900yA2HM1TOmQZnqtB6iwtBn2BIGr+zTxokg3kHUNXdyWDN0UfytvDsgf9epWa11Rej0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780536488; c=relaxed/simple;
	bh=pPc8V/s+H14s8uTChzVLgopQ3U5f47mspsUjW0hTQoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BfXQXwfw0I+O7LZbdOzmkl+LpKOpQC7K7CgDouayXLO7l+RmE2DHP8tt15gL1wUYCNQPEGlu0gb0/gbqTM4GdOh4nc1ok/QXaZCIxMAsLHigoD+hlc8d8D1DbAAZe59NH7x+O/b6m1rh0XgeXH1EKFp36NfOTQuRak4I0raSbMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gl+BhzhL; arc=fail smtp.client-ip=40.107.201.33
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deZh/PS/vMtM78cJZIRHCb5Id/w9TuGk7Nyw5riWWOE6nSdt82h/UjYkyZOHfqhbvcJdfdhSOXMn3xwXTwyyyt/OVgJXugCkZB9f3Px6rMAJZfBl9XlTdQoW4EzxKutjEAY7r/UxyWjb/IjPfUhIozKNpqRrUCCKEpM8oCP9uOBCsozpZ/863yAR5Nm/WXbndY+udXqcBWuJiefA/Uo5VpvGj2+panfLKMLwHI97QUCc1iJkCQiRfxd3Y15uSQWoHozVe00GG6Uy5uCBqyFCsnR0Auc7D9euyH9uH+zSem96kEfAuo6UzTBK4ecQWD3e+k1RJWsnFK22s7uL+UjcCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEf/wVlwzo0VK2plDLKsWqfitL+xwcz9GWP9y678OUU=;
 b=xXVP3CZRIPziBULXQIK//tLSUICJDOK8YSkvhhzhJVMfl1NNVneyYvepLLfKoynuAouSrYA9H1n4l3GjlVXjAImzAzkEf0YyVmSWt1TNxzE+gPTw9wd1kYr6yskOgtKXHP8KJzEisjhk27uVtYJCk1Vk0iP5XNL3LTLuEw65WBfT1l1pJ7VXMqmGU4tJtwQDlUYXl/cXZOJ4p5E0dwFCndh7/UNUG8VXSrK4YE94EEAL9KPWnOsREHzzMzOCICNV5kNEBdeS5v4cw0+o9mn8O2EQFAFzMxN7QxO/OnAt9G3P8RxcqT8II79pzO2iMBBf7I4crHB7u7uAnXkES6K3lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEf/wVlwzo0VK2plDLKsWqfitL+xwcz9GWP9y678OUU=;
 b=Gl+BhzhLA5iab5tCX7U1rboylJPFshJE5ZSvhcwcFADMhekHB/Hu8vCTstSIbUw2c5AMGvlaahtpGWdW1+w3USaCqV9/zIrvGu+7cv3QyFPpQPN8smHBi63Y1RvdMnMSA3495PzDzlWh1lzPIeD97IQLSsq9SJYnCcqtoiUDIKsOP4BDq5IEKAOKOG5SAZVDSotKF3fqlnFQ2DfnDa61j4E9W4Rqfhtjw7fO5gAp4DHNzj+HjuqOt4OazCMdAREdiVj4eGX2AcPxVs5lrGIfdRXqWAgiSJ+nVGxcFdpWaGmNUfX83P2ujGVea0wFqhpsiTUbFVxhWww4WTbB6VklQg==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA0PR12MB8981.namprd12.prod.outlook.com (2603:10b6:208:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 01:27:56 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 01:27:56 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Doug Ledford <dledford@redhat.com>,
	Edward Srouji <edwards@nvidia.com>,
	Leon Romanovsky <leonro@mellanox.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Matan Barak <matanb@mellanox.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Noa Osherovich <noaos@mellanox.com>,
	patches@lists.linux.dev,
	Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH 09/10] IB/mlx5: Push pdn above pagfault_real_mr()
Date: Wed,  3 Jun 2026 22:27:48 -0300
Message-ID: <9-v1-29ebd2c229b5+fd5-ib_mr_pd_jgg@nvidia.com>
In-Reply-To: <0-v1-29ebd2c229b5+fd5-ib_mr_pd_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4P288CA0096.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d0::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA0PR12MB8981:EE_
X-MS-Office365-Filtering-Correlation-Id: 963ceb20-ebc0-43a1-292a-08dec1d87f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	lVx+kB0dTK1wdBOnJRM5PXEYcq7kYolPqyaszbwGZpfvqsFi4LMsVFwppSZSJBXEEvLYAsEkHEh87NeLxpKSgoRBtR56IRe4gj2+4DDc8JrnowhfYCJU0lqDsiydNtQBOunK2xyPrizQhDGDlMQRpBPJ23xN6B5QJ+/7a2NHuziQjzbKUb0fSijO7aL2VlFxfhzdTtKlG2qMXGqoML39zK7jOI1OJoWcfokk5tqMyJVjVrgM9VKvHVYsDIzj123KjWBWsLDYeHC0RKpPNWoEmqEwqDpU97TaPBYcNYjeDk43jPMSb0Ffok/OunsK9bA8Va5gS0eiRaVugZe9aM7lS0g82NEDm7Iwvl6cEmHGyCUYwtMKENQiIN3D/AKdGV4PdRLHE7urXiffJCdhp8gM7xl8cSydQaLNBFPpABBGuh3/VGiLwDimuk4dgDboJi5J9ysynJcozDt0Xdri+0HdCD2iWZ56/Im8q/SYWj2s3lGM/Cy9T+gzvF1+OoFpUNRozAwLM5T0p1swz+wdHWf9YIOp8M8QbAwPt4nsmjSZEKuRPreRxV0fK2JBM/Wp45vBVbgiUE4wY4popFdnSw15lgrrl0c8O1NUBycvXeadN16C8zFl5QiDucVCIUXnVAjq/Wjn8xV56AsRQCpJzGKXIQI/7ID9wC4HVNxsNu8RR7A6lr+Y77Kh+nZPN8jsqtLN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3YJ8Fv0AeB2nzT2zC8lP9lfEfYkZ1JZK46q1pkSq5Z6oR7mfyEKb+5MZzCkS?=
 =?us-ascii?Q?ozYGmTHvbvBJIuZcTWsku/clYJ9zzd6gen4akBQnrt4mJbLktpr4RPMgs7sR?=
 =?us-ascii?Q?WKOUyA5O24ehx7FFZfyHCaMPKKo30v066fi78hy7pyS3/IKjVOfBMloaM0yg?=
 =?us-ascii?Q?xEpaV/J1yJSYnVzW1Qf8UhbudJNxYJ7iZlH4yD2lWQVuQ0WztAWRmfd3Q9qd?=
 =?us-ascii?Q?1lKYKQG3Atqmrn3T6+GsUPJ7iocZTkxbRwUuCZogx/G2g7vRH5SeGEzNzSU6?=
 =?us-ascii?Q?FdOfmcJKIHbGhDyMYbHDeWq0JwBk5UxyLMSiJAsAPR+oNDPB/sweN5JbbP42?=
 =?us-ascii?Q?juXuT5Z/HCI2E6YQD/nWIKig8HzvKkUgDjBacuZUhZOVXN6aVOOQsRa+yaYN?=
 =?us-ascii?Q?K99Qb2W9VbIrJ+LA7AKSw4ZAlONdYqecO9RtoIzV5C/TwXUf4ndZARVgsFRs?=
 =?us-ascii?Q?OCW2x49J1kXlrkA6mi1UVIMbLTvr7+ALU+TrEb5UGnrQMROmXt6YMvyJU7P0?=
 =?us-ascii?Q?7A1bLnaDo9+QY37M5+LqsPrIxnGXJBOkZGPb1CF0XrFvjS8l9/7Dr3dGNlbT?=
 =?us-ascii?Q?fAZ+bkTMK74/OVj4eoSBmje0p1ot/1FwW5hF8OIFeIoxSRJT3/eV5I5hHpFr?=
 =?us-ascii?Q?uzKY3u2ZBSPDAyz9fbFZ75wibLmf3jI0ZdU+DgmfuUuqmgh9AOEPg8apAzSN?=
 =?us-ascii?Q?x14taxHgZoYGLPxCDbQbgDAgJaevwFaxLuHgLiaF/vxQ7/ejqP0vrN+TsBpd?=
 =?us-ascii?Q?G+bZOe/MUUrjf7dkA8+FINH+xKOFQmXdECYTVQcyMcFAaPf+09z0IKS7bnQ4?=
 =?us-ascii?Q?cYR6DBeJlQRCLz48u/iRXvnnc2UhrT3fDM5Wxa4Zyuv9p0MzPwKFhiTL2hsV?=
 =?us-ascii?Q?ypdOKXGCu59w3Teb0Bv6ZJex5+Y22a+GlGDe86QOnApZSjTZU4Lt5vrExASf?=
 =?us-ascii?Q?M2SE04ktDE2qgh3Wb/GAP8/VQJ+QgjR5lBCtfHElfZV0K1DTf6JdvyzeIa4k?=
 =?us-ascii?Q?FCqMcWTTOgIJfbJfLRiGXI6Fm3fh14mI0JnUz0obasGtdasIn9fCJHzRNAYL?=
 =?us-ascii?Q?nxYb7aY2wlv2x/d6JlNs+gjVVJYkP3XFbddCFWZ/g3g0nP+slMbcnMyPF0xB?=
 =?us-ascii?Q?HnjKRi9wkuOJ3KVywYNCkfDOKUmyt0blNnpeyW3PcvLM8eu2rirfOZOKSRwm?=
 =?us-ascii?Q?+/mDV3HUPSHPHNfgYi6XW2i/4pWgGTTAXv2a8UbUct4IbAhn3XiypiDo19o9?=
 =?us-ascii?Q?hYWgH0EOiGrWDAVA2LX+GtFvtWJpp5y4haVTGbwgzrLNrozRr4cKQ97HKffr?=
 =?us-ascii?Q?4DIla4c6/e/tDts8kFJbnoIkI5kAfReq8+Z9sH0+y+iiuRE9Iu/FHq6SP2+f?=
 =?us-ascii?Q?zm+PijASqbR6ODEcVra0XwsK2L4k4f0aw45JyPuFnGhKm1/a8qOt3yFi4G8Z?=
 =?us-ascii?Q?c9vuF7moJpQLPGeUEYXuLC5Ylw/1O0tevrFMAayovkpXPR1Q+m6gmcj8HHZE?=
 =?us-ascii?Q?FA49gP/PmrCRw/pxOCB9MGdDN06es8InPxaIV1d8aU/i1gV92a/XyK+BOqWG?=
 =?us-ascii?Q?CoAh+fzvqOf7Vdy9sZlRfV6uUVHY47e7PfTjwq8z5CO6stk+ILeEEx6+AKKl?=
 =?us-ascii?Q?IVu2vB2wIo5L4nAm7OYLBzHxULTuyE/63FUY3UhZ1zF5EamJXpEy8g46QKMw?=
 =?us-ascii?Q?38e171T3dyM8EjaU+U2tyep/UzzDTs7+EzrHHxUQwx1mKlB8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963ceb20-ebc0-43a1-292a-08dec1d87f95
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 01:27:53.3863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s0Dz0rntAfXjnjdvwM/mxnljptWri8yF6Lm97JFWRKCYs4rUXwOI2VVNi/Km1AKY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8981
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21727-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:dledford@redhat.com,m:edwards@nvidia.com,m:leonro@mellanox.com,m:leonro@nvidia.com,m:matanb@mellanox.com,m:michaelgur@nvidia.com,m:noaos@mellanox.com,m:patches@lists.linux.dev,m:swise@opengridcomputing.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,nvidia.com:mid,nvidia.com:from_mime,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A2FA763C339

Remove the mlx5_mr_pdn() in pagefault_real_mr() by pushing the pdn up, all
the callers use 0 since they don't pass MLX5_PF_FLAGS_ENABLE except the
ioctl reg_mr path which can use the ioctl pd.

Assisted-by: Codex:gpt-5-5
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  4 ++--
 drivers/infiniband/hw/mlx5/mr.c      |  2 +-
 drivers/infiniband/hw/mlx5/odp.c     | 20 ++++++++++++--------
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 0a2b8ede0d818a..1c88a11f8dfc93 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1422,7 +1422,7 @@ int mlx5_odp_populate_xlt(void *xlt, size_t idx, size_t nentries,
 int mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
 			       enum ib_uverbs_advise_mr_advice advice,
 			       u32 flags, struct ib_sge *sg_list, u32 num_sge);
-int mlx5_ib_init_odp_mr(struct mlx5_ib_mr *mr);
+int mlx5_ib_init_odp_mr(struct mlx5_ib_mr *mr, struct ib_pd *pd);
 int mlx5_ib_init_dmabuf_mr(struct mlx5_ib_mr *mr);
 #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
 static inline int mlx5_ib_odp_init_one(struct mlx5_ib_dev *ibdev) { return 0; }
@@ -1451,7 +1451,7 @@ mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
 {
 	return -EOPNOTSUPP;
 }
-static inline int mlx5_ib_init_odp_mr(struct mlx5_ib_mr *mr)
+static inline int mlx5_ib_init_odp_mr(struct mlx5_ib_mr *mr, struct ib_pd *pd)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index a56443b9053734..46847054491f50 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -842,7 +842,7 @@ static struct ib_mr *create_user_odp_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (err)
 		goto err_dereg_mr;
 
-	err = mlx5_ib_init_odp_mr(mr);
+	err = mlx5_ib_init_odp_mr(mr, pd);
 	if (err)
 		goto err_dereg_mr;
 	return &mr->ibmr;
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 50804b4c90e477..2dcc4f5339f9d3 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -687,12 +687,16 @@ void mlx5_ib_free_odp_mr(struct mlx5_ib_mr *mr)
 	}
 }
 
+/*
+ * pdn must be valid only when xlt_flags updates the mkey PD. In this path that
+ * is only MLX5_PF_FLAGS_ENABLE. DOWNGRADE and SNAPSHOT leave the PD masked out.
+ */
 #define MLX5_PF_FLAGS_DOWNGRADE BIT(1)
 #define MLX5_PF_FLAGS_SNAPSHOT BIT(2)
 #define MLX5_PF_FLAGS_ENABLE BIT(3)
 static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 			     u64 user_va, size_t bcnt, u32 *bytes_mapped,
-			     u32 flags)
+			     u32 flags, u32 pdn)
 {
 	int page_shift, ret, np;
 	bool downgrade = flags & MLX5_PF_FLAGS_DOWNGRADE;
@@ -722,7 +726,7 @@ static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 	 * ib_umem_odp_map_dma_and_lock already checks this.
 	 */
 	ret = mlx5r_umr_update_xlt(mr, start_idx, np, page_shift, xlt_flags,
-				   mlx5_mr_pdn(mr));
+				   pdn);
 	mutex_unlock(&odp->umem_mutex);
 
 	if (ret < 0) {
@@ -788,7 +792,7 @@ static int pagefault_implicit_mr(struct mlx5_ib_mr *imr,
 		      user_va;
 
 		ret = pagefault_real_mr(mtt, umem_odp, user_va, len,
-					bytes_mapped, flags);
+					bytes_mapped, flags, 0);
 
 		mlx5r_deref_odp_mkey(&mtt->mmkey);
 
@@ -930,19 +934,20 @@ static int pagefault_mr(struct mlx5_ib_mr *mr, u64 io_virt, size_t bcnt,
 				    ib_umem_end(odp) - user_va < bcnt))
 			return -EFAULT;
 		return pagefault_real_mr(mr, odp, user_va, bcnt, bytes_mapped,
-					 flags);
+					 flags, 0);
 	}
 	return pagefault_implicit_mr(mr, odp, io_virt, bcnt, bytes_mapped,
 				     flags);
 }
 
-int mlx5_ib_init_odp_mr(struct mlx5_ib_mr *mr)
+int mlx5_ib_init_odp_mr(struct mlx5_ib_mr *mr, struct ib_pd *pd)
 {
 	int ret;
 
 	ret = pagefault_real_mr(mr, to_ib_umem_odp(mr->umem), mr->umem->address,
 				mr->umem->length, NULL,
-				MLX5_PF_FLAGS_SNAPSHOT | MLX5_PF_FLAGS_ENABLE);
+				MLX5_PF_FLAGS_SNAPSHOT | MLX5_PF_FLAGS_ENABLE,
+				to_mpd(pd)->pdn);
 	return ret >= 0 ? 0 : ret;
 }
 
@@ -1575,8 +1580,7 @@ static void mlx5_ib_mr_memory_pfault_handler(struct mlx5_ib_dev *dev,
 	ret = pagefault_mr(mr, prefetch_va, prefetch_size, NULL, 0, true);
 	if (ret < 0) {
 		ret = pagefault_mr(mr, pfault->memory.va,
-				   pfault->memory.fault_byte_count, NULL, 0,
-				   true);
+				   pfault->memory.fault_byte_count, NULL, 0, true);
 		if (ret < 0)
 			goto err;
 	}
-- 
2.43.0


