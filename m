Return-Path: <linux-rdma+bounces-21266-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDkmLgb2FGr2RwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21266-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 03:23:18 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 535E25CF6E6
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 03:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01344301876F
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2026 01:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A454280318;
	Tue, 26 May 2026 01:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NMHsvkfy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013028.outbound.protection.outlook.com [40.93.196.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A95290DBB
	for <linux-rdma@vger.kernel.org>; Tue, 26 May 2026 01:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779758594; cv=fail; b=EUalmCj7lNPCfHdEcSjsvpdgm0IWubcyGKJWnQbuAWGZHArMGDzP+nS8cZ7fu7/ts4m8rChbSKgC8GUrZKml1Kvj5/J81u1/uGJYFVlsmwtpOD8tw9dquk6OUwMpCmhj7xchjt8MyFFTSSljq7ytNVPudy6o6+obluDBfh/+k4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779758594; c=relaxed/simple;
	bh=tmH6o2CaumrGXdV76UnZhYoJDoVzS7D84baiksbC5js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OhhYzg15N12R9Rmd0NjjPoidhj6M3ExcQYM/guWCq5OmDbf7tEFHTyHD3lWM6VXofqJ/BvczHsKbHFCmAkZ0WeJl3nS+pBRKJHtf6KMWaM1xfydbY37S+5HNdawV0pDpgrjP+W2Q7nvPjGX6AEWc1c7BbfHMqfSJvuV0erE7u2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NMHsvkfy; arc=fail smtp.client-ip=40.93.196.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mC5+srkAzOF5HXMH3ZzN1/VMlk+RcdiGFLLwhAQu5ZOL0DEWV/ukEcs2FWtvuS9Pf7eVbCwTFn81+lk9fOSW7VSg4JcZ11eyrypOS1zihQ6zVT0jvuPrMmqEbGMt0SrNPLVm43/ZMsilcV76ygYHE0zjFS7UirTNtlrLV56cropvozZVMr0IX2ZZYiznh1+kEmrTz5aTUo1ue2Tz1+8VMh28nsBADRaVmQRwZ0UZUELWiirb4V81xETcIp4yVzQ3nsMw434HdOvaQDfPXOlWOMwWI4SNqGFiE/Kp//XlkJqP3pfnXa0k610vjR+C8+I95dPYCsmVOQ707OVkraYZxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDLXzcwUmDjirkq0CmPKV8se647DkA3lYvX+1aRmQi4=;
 b=c0LP/76A4+Zq3ZIKu/ol3ycakDscmYmd3sRWjTs4M8Y/3nUgs49cd8tDVyUg8iSBMyx0c29STi6RP/pMww3ZJW9NbSMo3qZ2EFQd00mYukA4DuDMMVMfoEgejcSPtdlcDd8ZlLIHlphAxh/ZPRjGTEER15V+UnCIf+cc+UR+7WMV7gc6Ea62OXTOE5ucVk3MGCh51cOZ9nS7l6mesFYPgqmZ4EKaM9ALvRPQ3bnTbbokVSSqJIKGGon0DpFc8F4iGKwWnXNE8MY0L5MFXoYYXRCRqRjwo4k50Db8foIjO0y22zzimXDr4wrIOw1fbDDiOq0iKKOMj+CGS7CyLNY/SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDLXzcwUmDjirkq0CmPKV8se647DkA3lYvX+1aRmQi4=;
 b=NMHsvkfylivcu3GdkcwD6r2tHzzUVhGSH9kuQO5IfkVceFkwT8YX2a78nff5NtyWPeaaTVX7xi39SHru7tR09deYaMka/MrHwJfX5vlUAa2Iit5f+bFUp2EyC5R8ie+U2GS+mCetLH6f5sz7JNsWPoe54dIhW8rOMLersPMIR0Z84N/jwCRqzACrNLecLl6wZGYHy85/4pOQtUCLmsK21UH1vJP51WRmVqantoKuKATdR8z///2oZficaM5ckXlm270lQzux+AL5a5Fd4s0LtrD4CIuY80JOn8c+XfGnfU9AH+0iTR3SHNfO8CHifZoaJKNkeNo9xosbpcN2nOeMTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by IA0PPF73BED5E32.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd2) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Tue, 26 May
 2026 01:22:48 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 01:22:48 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>,
	patches@lists.linux.dev
Subject: [PATCH v3 1/6] RDMA/core: Do not compile ib_core_uverbs without USER_ACCESS
Date: Mon, 25 May 2026 22:22:37 -0300
Message-ID: <1-v3-43aba1969751+1988-ib_uverbs_support_ko_jgg@nvidia.com>
In-Reply-To: <0-v3-43aba1969751+1988-ib_uverbs_support_ko_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: IA4P221CA0011.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:559::14) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|IA0PPF73BED5E32:EE_
X-MS-Office365-Filtering-Correlation-Id: 4647e909-08d0-4fc0-6fc0-08debac54c14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	TVZJPKJsw0bz1mDH5Pa/XxhopeuMu4OT71OpGlt/nmPbp3YMCoB5BVYo2fvph1g2N8vRZucpZJZQYiSJo+xLQVr+4Ah6NEU+/y85v5/0rahX3/2G712O+x6oQdMNpP1VeKZ+FFG2ramhRzdwmtnriZyZrK7be++rsZiPCjK9GQLPNVFOAS+yJfZArVaEwirxsIge0sEWqFLmsRVbKdehMQ2YZolmLUNq6iM4gCM+1M1wqT+o1Z3JWLVR3PyT6jBd8H6K5BiMZYUK66RkzdjgN8JBlN/V3tBy8s9VQvZRuL/cY/8kjYauqEVTiEs9iGdox0TLBfOv4tfFXhOUJjx1wrOSN2kOAXR6YE6qyr+3qn5OKdUM5SwW5pGJZpNwGxNkiQGqikUFu2AN00KiOdJxGj2Ec2ixIWa7uw3T644bLXs3nL9ytQiJiFKNFKz4OnrMwagI4qi2RA1v/jOrqcrYvD0A4xuJ0cgfLxU/81wtqnXC86XedNCfyRanZHyqw//RRyxIOkpmSmH8JQFfvxrS8o3bicI4c5WPNBXiGMt/uv2WHGcDIqXtvzXCc8dc0gUKjPBbZb9P1T9T6N9ZNqsgnknldhnVahRoGD/mGg8P9nbqIiEoKkfNKFy8SeejNICuEi0UYJ21LhL4IyMEcNiNjgg0p5BHRyxemjlOWGRK7e/EOP9L/kTr4BnvlsaRW5+8lGgnbRhaikISdo3eAKx86w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YCCBHkkPfDTsyC/c45eYW4FEC7CO1c6nY4SweSALiDsc9FF5AzIdXvhcL4Iv?=
 =?us-ascii?Q?mSHCidIABWysQ+P0HCnBHXG9NIx5mzqA95oXI3sXY6q30KWYMu0FHXck+z7N?=
 =?us-ascii?Q?z5TbiBMTlv95SlHhjwSTok8612eLpXGEEcKN1eXPgfbMagnac6J+k1ef2bB7?=
 =?us-ascii?Q?aEtSbG6be2/NfBNuOEizTKUeFzAPsOxmHjSedVLllbLfhb9DmlBxIMNf/sW8?=
 =?us-ascii?Q?u9eqygvN9NYwQqO59osuAqLJ20piCOLmxPpTubWlvw2xNvmMtbG8ngvoGo6l?=
 =?us-ascii?Q?l4IiP1tFPLpnYSdloZVCvRNHL8+q9cozydSKC14FYGet6dFrwCF6nG0fbRl7?=
 =?us-ascii?Q?HnIbo/GS7fJLGHby6uCU2SJQkOAcIzj/AEWT0Zq1FOdLpcY9nkRH3369+DKg?=
 =?us-ascii?Q?Q3x71Hcs9eKPaA6cuvX152wZqUIzKPdwruXtU+Tec27ZGNlF4arle2QyHZss?=
 =?us-ascii?Q?wIopc2P+R5yF+8AZwilmEVzsxiMUTPcZitmN8IBuTqXXn8Q+SE/WB5nDF6jl?=
 =?us-ascii?Q?D4/5/eS9dluWRAW3z0Bz8YMCp4rpEPU55gSzupSyfltyV8SzIFZmg+lilihP?=
 =?us-ascii?Q?dUAUzLzmJk9d0Ey9sMX3QXQnrcPOlBJrinWB2nmaRIiIhiOVGvLlg1OVhfqH?=
 =?us-ascii?Q?0XRaGriB7kuacyjr9wWxAYpmVbJvrnyh096pgW6kS4FA9SQyoCx6qCwuTpSw?=
 =?us-ascii?Q?W9Q/zx+/7D+J/H0zkWddow40NMNa3JIhEhdN+KFcFDeoJn5A86u25IUWtrdZ?=
 =?us-ascii?Q?md0iVN7GkIvZAURcx1iDE/dt4f+mBujC3VvH771iXr91n1nDrfjI2zRoX3CB?=
 =?us-ascii?Q?VwtFDtNYuTFx4KAohlQ6MhQ58y7bmRzrUcRNcRdpk8ANCaWRcDEsvsgw0HWj?=
 =?us-ascii?Q?3Kc56AE91ZLIWRnOPNEqlc0TE6zayQJ8zs16FgyHMVrewqC9R57bDKm1xkWd?=
 =?us-ascii?Q?re3/glydSILoYpSvrbZCUNvIp+gH+X9rAD0g7fWVFO9+hSVm/L6L2hPcV2UH?=
 =?us-ascii?Q?o4732by0jxZSNPdcNun5co29Mq1xhTX6Ywl9tXs7Wm568iCfxjaHgG5fIJTd?=
 =?us-ascii?Q?xDt0ds1piE0ipxBg4TT5av2v9r1PKAyLLCcfEPU4WbFa4T/JN7D8rMCDcOh0?=
 =?us-ascii?Q?roH089saYboqVvW0mFfHlbIEsSRA746pLMEAb2Xj3KXFsQHhfZsAz4wGxySt?=
 =?us-ascii?Q?gLlyE+RrlwRBEbi7nway6vPha25EJmzXhJEef62ANwxGPusMvYnXeHPsbaBu?=
 =?us-ascii?Q?WXCFsMmUw1y+TKZiPJzR9d2fPp2sG2sI8PdZwUYUHWpPaTaNHe06dmidlPd7?=
 =?us-ascii?Q?p79NJSUb9Gf0fv0wXJ2juS7fpmwmNV9h4aCcbKLyuFpiHv8d7TR+36Rl/xTc?=
 =?us-ascii?Q?2iVw+9W4jyS5V5ZzQ4TkEI2le5pXkdam3Uua0d87YTCZ6+MN4bFi4Xs4U+C0?=
 =?us-ascii?Q?eI+vrDTMpnzrAX9qIMJbT57vdPbWijwzolxF34QcS1FyjxBXjvVE3HYRTLRk?=
 =?us-ascii?Q?uX1JORqXIGeKyPYthjYav11hLMw9PACTOcRJLykOnyyPDJGalNQqvgVQeQvV?=
 =?us-ascii?Q?MslZOrEVa9vzWj2Q+YjvTS+YkEOsUJ7/17TEPQu1IxRsNTnh4WLgI5EhaU/T?=
 =?us-ascii?Q?GMh13+/1oVW/9BJAVjSvZ1yDWwu/i7fBma81MDKCbSS7p/7KIxaiONVFYxjX?=
 =?us-ascii?Q?COfskf4er3i7NJQ687y7jHLI3iim9y3QaRuhGSYzIx/gwqap?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4647e909-08d0-4fc0-6fc0-08debac54c14
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 01:22:48.3878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXs8EA8gTMOUYDuTX5VS0ZlzWRHsG9yshqV9L8+YTWSzfhuYXAdrUnZINAR/sbIl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF73BED5E32
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21266-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 535E25CF6E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove the entire ib_core_uverbs.c from the build if
CONFIG_INFINIBAND_USER_ACCESS is not set. These functions are only used to
support uverbs and are never callable even if they happen to get linked
in.

Provide inlines for the missing ones to return errors to further push code
elimination in drivers.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/Kconfig               |  4 ++
 drivers/infiniband/core/Makefile         |  3 +-
 drivers/infiniband/core/ib_core_uverbs.c |  8 ++-
 drivers/infiniband/core/rdma_core.h      |  3 --
 include/rdma/ib_verbs.h                  | 67 +++++++++++++++++++++---
 include/rdma/uverbs_ioctl.h              | 13 +++--
 6 files changed, 78 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index a7e3f29dc037f4..086195758a8ac8 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -37,6 +37,10 @@ config INFINIBAND_USER_ACCESS
 	  libibverbs, libibcm and a hardware driver library from
 	  rdma-core <https://github.com/linux-rdma/rdma-core>.
 
+config INFINIBAND_USER_ACCESS_CORE
+	bool
+	default y if INFINIBAND_USER_ACCESS != n
+
 config INFINIBAND_USER_MEM
 	bool
 	depends on INFINIBAND_USER_ACCESS != n
diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
index dce798d8cfe67b..8c2ba2ce035176 100644
--- a/drivers/infiniband/core/Makefile
+++ b/drivers/infiniband/core/Makefile
@@ -11,13 +11,14 @@ ib_core-y :=			packer.o ud_header.o verbs.o cq.o rw.o sysfs.o \
 				device.o cache.o netlink.o \
 				roce_gid_mgmt.o mr_pool.o addr.o sa_query.o \
 				multicast.o mad.o smi.o agent.o mad_rmpp.o \
-				nldev.o restrack.o counters.o ib_core_uverbs.o \
+				nldev.o restrack.o counters.o \
 				trace.o lag.o iter.o frmr_pools.o
 
 ib_core-$(CONFIG_SECURITY_INFINIBAND) += security.o
 ib_core-$(CONFIG_CGROUP_RDMA) += cgroup.o
 ib_core-$(CONFIG_INFINIBAND_USER_MEM) += umem.o umem_dmabuf.o
 ib_core-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += umem_odp.o
+ib_core-$(CONFIG_INFINIBAND_USER_ACCESS_CORE) += ib_core_uverbs.o
 
 ib_cm-y :=			cm.o cm_trace.o
 
diff --git a/drivers/infiniband/core/ib_core_uverbs.c b/drivers/infiniband/core/ib_core_uverbs.c
index 8a0e6fa2a52837..0acb0d4967cb6b 100644
--- a/drivers/infiniband/core/ib_core_uverbs.c
+++ b/drivers/infiniband/core/ib_core_uverbs.c
@@ -398,7 +398,7 @@ EXPORT_SYMBOL(rdma_user_mmap_entry_insert);
  * The struct ib_device that is handling the uverbs call. Must not be called if
  * udata is NULL. The result can be NULL.
  */
-struct ib_device *rdma_udata_to_dev(struct ib_udata *udata)
+static struct ib_device *rdma_udata_to_dev(struct ib_udata *udata)
 {
 	struct uverbs_attr_bundle *bundle =
 		rdma_udata_to_uverbs_attr_bundle(udata);
@@ -415,10 +415,9 @@ struct ib_device *rdma_udata_to_dev(struct ib_udata *udata)
 	return srcu_dereference(bundle->ufile->device->ib_dev,
 				&bundle->ufile->device->disassociate_srcu);
 }
-EXPORT_SYMBOL(rdma_udata_to_dev);
 
-#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
-uverbs_api_ioctl_handler_fn uverbs_get_handler_fn(struct ib_udata *udata)
+typedef int (*uverbs_api_ioctl_handler_fn)(struct uverbs_attr_bundle *attrs);
+static uverbs_api_ioctl_handler_fn uverbs_get_handler_fn(struct ib_udata *udata)
 {
 	struct uverbs_attr_bundle *bundle =
 		rdma_udata_to_uverbs_attr_bundle(udata);
@@ -502,4 +501,3 @@ int _ib_respond_udata(struct ib_udata *udata, const void *src, size_t len)
 	return -EFAULT;
 }
 EXPORT_SYMBOL(_ib_respond_udata);
-#endif
diff --git a/drivers/infiniband/core/rdma_core.h b/drivers/infiniband/core/rdma_core.h
index 269b393799abbc..55f1e3558856f1 100644
--- a/drivers/infiniband/core/rdma_core.h
+++ b/drivers/infiniband/core/rdma_core.h
@@ -151,9 +151,6 @@ void uapi_compute_bundle_size(struct uverbs_api_ioctl_method *method_elm,
 			      unsigned int num_attrs);
 void uverbs_user_mmap_disassociate(struct ib_uverbs_file *ufile);
 
-typedef int (*uverbs_api_ioctl_handler_fn)(struct uverbs_attr_bundle *attrs);
-uverbs_api_ioctl_handler_fn uverbs_get_handler_fn(struct ib_udata *udata);
-
 extern const struct uapi_definition uverbs_def_obj_async_fd[];
 extern const struct uapi_definition uverbs_def_obj_counters[];
 extern const struct uapi_definition uverbs_def_obj_cq[];
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 9dd76f489a0ba4..01e0eea0703f9d 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3101,6 +3101,7 @@ void  ib_set_client_data(struct ib_device *device, struct ib_client *client,
 void ib_set_device_ops(struct ib_device *device,
 		       const struct ib_device_ops *ops);
 
+#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 int rdma_user_mmap_io(struct ib_ucontext *ucontext, struct vm_area_struct *vma,
 		      unsigned long pfn, unsigned long size, pgprot_t prot,
 		      struct rdma_user_mmap_entry *entry);
@@ -3112,13 +3113,7 @@ int rdma_user_mmap_entry_insert_range(struct ib_ucontext *ucontext,
 				      size_t length, u32 min_pgoff,
 				      u32 max_pgoff);
 
-#if IS_ENABLED(CONFIG_INFINIBAND_USER_ACCESS)
 void rdma_user_mmap_disassociate(struct ib_device *device);
-#else
-static inline void rdma_user_mmap_disassociate(struct ib_device *device)
-{
-}
-#endif
 
 static inline int
 rdma_user_mmap_entry_insert_exact(struct ib_ucontext *ucontext,
@@ -3138,6 +3133,66 @@ rdma_user_mmap_entry_get(struct ib_ucontext *ucontext,
 void rdma_user_mmap_entry_put(struct rdma_user_mmap_entry *entry);
 
 void rdma_user_mmap_entry_remove(struct rdma_user_mmap_entry *entry);
+#else
+static inline int rdma_user_mmap_io(struct ib_ucontext *ucontext,
+				    struct vm_area_struct *vma,
+				    unsigned long pfn, unsigned long size,
+				    pgprot_t prot,
+				    struct rdma_user_mmap_entry *entry)
+{
+	return -EINVAL;
+}
+
+static inline int
+rdma_user_mmap_entry_insert(struct ib_ucontext *ucontext,
+			    struct rdma_user_mmap_entry *entry, size_t length)
+{
+	return -EINVAL;
+}
+
+static inline int
+rdma_user_mmap_entry_insert_range(struct ib_ucontext *ucontext,
+				  struct rdma_user_mmap_entry *entry,
+				  size_t length, u32 min_pgoff, u32 max_pgoff)
+{
+	return -EINVAL;
+}
+
+static inline void rdma_user_mmap_disassociate(struct ib_device *device)
+{
+}
+
+static inline int
+rdma_user_mmap_entry_insert_exact(struct ib_ucontext *ucontext,
+				  struct rdma_user_mmap_entry *entry,
+				  size_t length, u32 pgoff)
+{
+	return -EINVAL;
+}
+
+static inline struct rdma_user_mmap_entry *
+rdma_user_mmap_entry_get_pgoff(struct ib_ucontext *ucontext,
+			       unsigned long pgoff)
+{
+	return NULL;
+}
+
+static inline struct rdma_user_mmap_entry *
+rdma_user_mmap_entry_get(struct ib_ucontext *ucontext,
+			 struct vm_area_struct *vma)
+{
+	return NULL;
+}
+
+static inline void rdma_user_mmap_entry_put(struct rdma_user_mmap_entry *entry)
+{
+}
+
+static inline void
+rdma_user_mmap_entry_remove(struct rdma_user_mmap_entry *entry)
+{
+}
+#endif
 
 static inline int ib_copy_from_udata(void *dest, struct ib_udata *udata, size_t len)
 {
diff --git a/include/rdma/uverbs_ioctl.h b/include/rdma/uverbs_ioctl.h
index c89428030d61ae..9d7575d999e121 100644
--- a/include/rdma/uverbs_ioctl.h
+++ b/include/rdma/uverbs_ioctl.h
@@ -668,8 +668,6 @@ rdma_udata_to_uverbs_attr_bundle(struct ib_udata *udata)
 	(udata ? container_of(rdma_udata_to_uverbs_attr_bundle(udata)->context, \
 			      drv_dev_struct, member) : (drv_dev_struct *)NULL)
 
-struct ib_device *rdma_udata_to_dev(struct ib_udata *udata);
-
 #define IS_UVERBS_COPY_ERR(_ret)		((_ret) && (_ret) != -ENOENT)
 
 static inline const struct uverbs_attr *uverbs_attr_get(const struct uverbs_attr_bundle *attrs_bundle,
@@ -902,6 +900,8 @@ int uverbs_copy_to_struct_or_zero(const struct uverbs_attr_bundle *bundle,
 int _ib_copy_validate_udata_in(struct ib_udata *udata, void *req,
 			       size_t kernel_size, size_t minimum_size);
 int _ib_respond_udata(struct ib_udata *udata, const void *src, size_t len);
+int _ib_copy_validate_udata_cm_fail(struct ib_udata *udata, u64 req_cm,
+				    u64 valid_cm);
 #else
 static inline int
 uverbs_get_flags64(u64 *to, const struct uverbs_attr_bundle *attrs_bundle,
@@ -971,6 +971,12 @@ static inline int _ib_respond_udata(struct ib_udata *udata, const void *src,
 {
 	return -EINVAL;
 }
+
+static inline int _ib_copy_validate_udata_cm_fail(struct ib_udata *udata,
+						  u64 req_cm, u64 valid_cm)
+{
+	return -EINVAL;
+}
 #endif
 
 #define uverbs_get_const_signed(_to, _attrs_bundle, _idx)                      \
@@ -1051,9 +1057,6 @@ uverbs_get_raw_fd(int *to, const struct uverbs_attr_bundle *attrs_bundle,
 	_ib_copy_validate_udata_in(_udata, &(_req), sizeof(_req), \
 				   offsetofend(typeof(_req), _end_member))
 
-int _ib_copy_validate_udata_cm_fail(struct ib_udata *udata, u64 req_cm,
-				    u64 valid_cm);
-
 /**
  * ib_copy_validate_udata_in_cm - Copy the req structure and check the comp_mask
  * @_udata: The system calls ib_udata struct
-- 
2.43.0


