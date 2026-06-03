Return-Path: <linux-rdma+bounces-21698-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ydIoLCJqIGp43AAAu9opvQ
	(envelope-from <linux-rdma+bounces-21698-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 19:53:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB0A63A4BD
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 19:53:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=RLSRD9Wt;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21698-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21698-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2214F302C5E7
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 17:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52FC2FC898;
	Wed,  3 Jun 2026 17:44:42 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011066.outbound.protection.outlook.com [40.93.194.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801D12DA762
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jun 2026 17:44:41 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780508682; cv=fail; b=JKaVo9gXldXcMCZ+X9jKTz/ygZUWyINO6TVD6i95xBYASGro0WqA8OVDQrTUxDmYlntiob7PwZw0oIy5Moj+G1OGfP/3IzMv+lCOeKuMZSRgCkKHyM+5n4+OQsfw63IDJKC8bS2wBqQHva8WpT6PBnNLRW9hIRNrwkIsh8XRH8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780508682; c=relaxed/simple;
	bh=iYkW/Agy2MhkuGgmS0uzUv1Io3ER/w/UHbsbdzw7mxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=s/vQKUGLY/6oa2gzntB57kcItoV30powNn6wZth39p899DH+EK3s+O5fAWxYEJ68TyPYhLA2lke8AHcxQxu4BZhdrNIfeJoenN6UvCkgrcZd10otoKuk665kIVcL/CbHDZPxcteREfmMNZdM2yaTrmGC5BgXwBFt7o+pH8l8YiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RLSRD9Wt; arc=fail smtp.client-ip=40.93.194.66
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GSdO0DeAi7YfRC7jvjGs4d4CIo5rby5mn1osbsMyh7b6ScmZvWu24WvRkBasMg9PrWTzrSBIa6gvyW8z3whI36BfQGlDJEcJ4b2U5NJhVnsg00B5URMXYQ/BZcdEn5CSf61UcgTzgcGHnHm/0NUEp+jqRZs7ClF50XwQAykfm5pnhAba5WxvVYiar3zgZEoMB3a7Adp0YQCvUfYqlVmq3SpKJpssYNE6yA90VH80G0OQekQFUDE6iz8pRAXdZsi+xZdG0diGJzTEqLpAaUMJTxS/az2uFa4z2+motoBjhgyb/DyNcgDkYZ1DczAKyJV61kXQnEzq2/1pWIf1grmCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wwIqHyiwtGi+BRhzXEvS3fm6Tvyirsnw9dGuz+CUbK8=;
 b=gku3jfhFacdRTuvEjSAuKzAzxalInW7aFHAQ1KgqOpm1+pQ/NSwgW3/KU+eEz/a5JCtdoS1S08JXT3lrPyQf89b3fJokMjk9p6EXocUhEFPtUrewr0YYo18bUTkeHpolG4J9mhcMFAtFUejfauf4NaiOao1rSD2wtZaFrLLjGjnshFdQfx+u1o86nJen4JBlnZEcu9xUw2BDWvbKTlVBfsmkPs/fbc7E0CwqeiLFjgFZwkyu+J/vDaMjAtUJlc47ds14k781BEgQbKMryCI7d7hNcbtyk8KMfWMNN1PH0IhFXUWhzVmWufIjmAOvXmogOeyDTsUPK74vxsXGio7hiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwIqHyiwtGi+BRhzXEvS3fm6Tvyirsnw9dGuz+CUbK8=;
 b=RLSRD9Wt5HV/cz8cA9f40XZbujEUlpRrqDfM4F/vXjte1x0YXkh3/9oh4LPb8zISwB8klrO/DGLQ54+Krh//Kd2IQZHabzeWLrSOrsCC076v1F2KdlsyiWScLtmzifXzU/Ror8n8mYGJNl0jRekvqMIn60t7pASv8f8Un0SQlmL4ZYsoVYw2vXmB74eF8lfotBroy1HMUryIpzktRKzKSEAnIaZEGq1ffKVnUzTzhbPCqi1SMY6Fq1zEHtaytMj6xo2Opnk1Y0ef9VHf5I4m8KhWTH98u0K8OnRDpDZ0vKzl080tTDrNEhjh4kri0IgDvnwbn+rFq6bpit//Yk/ZBw==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4189.namprd12.prod.outlook.com (2603:10b6:208:1d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 17:44:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 17:44:36 +0000
Date: Wed, 3 Jun 2026 14:44:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yonatan Nachum <ynachum@amazon.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org, mrgolin@amazon.com,
	sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev
Subject: Re: [PATCH for-next v2 0/2] RDMA/efa: Add AH cache for AH reuse
Message-ID: <20260603174434.GA1552272@nvidia.com>
References: <20260512061121.2177521-1-ynachum@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512061121.2177521-1-ynachum@amazon.com>
X-ClientProxiedBy: MN2PR01CA0052.prod.exchangelabs.com (2603:10b6:208:23f::21)
 To LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: 428876b8-2e6f-4160-2e43-08dec197c713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|3023799007|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	WbOxdxSEBaS1inu1E6EeCTmzbtQpT5RwyBVxq+8Y5YocYjITI4Im51V4CPrV0vE/RJqfwDU3z3VkdlSu9OGRTFJFhZkU7D/j0iAvDjPd4OdNgN+YLNE9jGgI9wmt/wt6esZIHNMBoXOCuTPzv6c7LhvlnT/H8ojFyfuUC1/IVJOS2qgtOvitu3UznumCMGkr/HUHMiDTEYzP5Zo9aCZ2zLSCJajDqO5+xKQXkEYiFYS+2YpGTw2oyx5xcFHrC4wGibHPhOTqgrCt8ytt+ev6lMjQh8v2CszIHdBkKeEO3dy/6+oTAIH9sm/traLXr6uoiQqJSGCgLVyszv9KyeiV5BcenU8wu/mGVmZ3u3Hp89RtAJpdU2ibxzCfQhNCWTMLJI37bz9fnS/yjgpgUWG8CoCxOGjVJRz6umT6/CtZnHlXUSHF0IahkqrBaQoEhEtksVi/Ba9Ye9E9/sEhVAqYHvb4eyTlb3VXuOaKqcciu4Covs+6l/prRSmln4HwtJ+8Mi5Se0RKw4JY0h80fTc+FmsJAe/LVsUAoa/0wQxYs6TP1PTGmeLhZw1g1KkWouudVXftZEipa+tl5MKIS46Byu+GppndG5K50aLm8t8nevn0QPxjDBWtRKjoU4nJMepINMBzxwc+3/IGMQ7pa6JCNpjCvIqdkfFl5PYvUTRRsiqOtCPaa7hGfRsNYnvmEkpL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(3023799007)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gvwFJUn9Wia1rQOFoyM/hIwbe+RoPRkec0qpNm4CfHpfs5h0AnVRCM8eL0s0?=
 =?us-ascii?Q?8LgfCa6hU2uY1a7vA5nEGFKGl3RVoXMmJtJv/HwF4kylVlB6rPAsuOzdLYog?=
 =?us-ascii?Q?KewhW7bcX9lBn7v6PJsduKLijpvnDqBTQQAdjVaiY8c+VUjIoMlQ1KA/YSau?=
 =?us-ascii?Q?Ge9SuS3y/m/Vn0pO43XoHGfUmwCh0lyWekKrtqW/zZUXEoCTKC/xB1kJXdwf?=
 =?us-ascii?Q?al/tWtP1j031v5EavYEDHm7UMwQS7Y3zHWMQfq/yhbdIVV7jSzpZHBMJsnUT?=
 =?us-ascii?Q?N3mlH509nUb0+p8uI5CEyMs336nmKjHqd5eQNnPwSNlkjBZ/2iELx3Gf4BSG?=
 =?us-ascii?Q?Pu/Qc1RbH98TGBoQN16DsCNATcaNw9QknhqX75x9jC98rrUl/ZpjM9damxCK?=
 =?us-ascii?Q?KoYn+cf0RFVwPvf1QQlG213uUR4XKzqMrHfvPFbjHRTqKMmgMb/LmijLjcbN?=
 =?us-ascii?Q?yTr/zBVGIrqHAZRI8MrupTjZKL89GCREot/c4M7eqTTEq8Ghnlya+G1VP7ce?=
 =?us-ascii?Q?D0Cwq52re9oj/km/hofKjfT5IzdVPMrVvtFFF4MCdevs5mg8COXfJ7l6LNCU?=
 =?us-ascii?Q?hZka56/AaUT4Yrv13sSoBuo/eOyuMzyELWcux63EIku0ip1grxiASXPASVo+?=
 =?us-ascii?Q?A0yuOKMeKaiyAAx4VER0qTYGY5qYk0UkKrpIYkzoqjQbGRLnX/10CvKkGvvX?=
 =?us-ascii?Q?XbkTEEIUtwQ0tj2n4LEgdygjd8dGdMUQkUj12Au1G/l2JR8A/BrD5GoAUl/a?=
 =?us-ascii?Q?PeRylaF2k5MqAdjr99vZ8BbFYNClKaL+4v9a0nIVHrKRmizcDDqFUA9779cZ?=
 =?us-ascii?Q?cqrHn9+6iMoDG14xmYrVIoAsYrwceZVvMAuMAlBHE2fLkBxG/DoBDT71NbPf?=
 =?us-ascii?Q?soi02xAZo2MJI8h5uBgURy1YJ+416RFLuCaFjczfcaPx5G0zpSVVteYGs0b9?=
 =?us-ascii?Q?LpHK95FwaCmXbQgBkoH4eqG8jvDHYXh3bheKpXYvbK2yLawbrURpvl36P2R5?=
 =?us-ascii?Q?MI2S1cqwEVX9/kOC5WDze1CECr0ivfEhih/cA4AnccRgBeH1FfMYU4yNXvji?=
 =?us-ascii?Q?dB4M//a69JWsuRxhHRx8QAoVIPpvU98zLpIGpnPNaAOXHgfTSw88sczIZ6cJ?=
 =?us-ascii?Q?2xWMAT+zhltiL2HKlegtZDmnS40DqsLLad2rjr0kLQ9tpyivrk7lT6Zt64vK?=
 =?us-ascii?Q?X+vvOAkL9/AnOut/nyEnplItkOKwYhKzuUx1GeUF6mvTNL1NdueWrP1tjeAs?=
 =?us-ascii?Q?y+ClL1UNJ01q/IVUYZdpGl2O+DnJmwLmOkUynSig4awACjUVTZkX/PCDuORj?=
 =?us-ascii?Q?RqcjKhUf9iHN3RYPeAUUUi1Zpjo15krpYsoqp5SErmjypqOT/yxLYBuWoukN?=
 =?us-ascii?Q?LY0pNMxlXxQyfkxHTIkfjQ8yM4dVz32pD5H+qs+bYEOCwIYotBJ+9aVSpGFG?=
 =?us-ascii?Q?oiJW7ZteWO2GMJ+LETWtzepbVe0yRgAw7QCy8RlkK7nWHb/O16GpOg2Zh3k0?=
 =?us-ascii?Q?3MJmY7wTDCWORugt2F2hR3kt9cyDwl9qa7RX5D0jE+Qhs+yuTZbdKmEfMBCi?=
 =?us-ascii?Q?c/N+0IHuU5a97yF+LbaEte9pb3ivYuIPBmRtu2Fso0FRVgYL37Ira0zHv/hB?=
 =?us-ascii?Q?jIu50Ur95Hj7bLFP7drWQMxq/dWP0DFVkWZVtAIqGQNG7HSYsUN8SdZoFFn7?=
 =?us-ascii?Q?N3aNtw/87FG6txVI8DLYXtqPVRQtWDHpXUQlBDDYduO8+MPM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 428876b8-2e6f-4160-2e43-08dec197c713
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 17:44:36.0162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kf00zUI0Knba8WuNWbcgVfJzaCfD5dCoXh91OOGZYPGMkuY3gFQ6cmNteSqhn649
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4189
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21698-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ynachum@amazon.com,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:mrgolin@amazon.com,m:sleybo@amazon.com,m:matua@amazon.com,m:gal.pressman@linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,vger.kernel.org:from_smtp,nvidia.com:from_mime,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1BB0A63A4BD

On Tue, May 12, 2026 at 06:11:19AM +0000, Yonatan Nachum wrote:
> Changelog:
> v2:
>  * Zero-initialize AH cache key on cache lookup.
> v1: https://lore.kernel.org/all/20260510083035.458081-1-ynachum@amazon.com/
> 
> -------------------------------------------------------------------------
> New EFA devices don't support the creation of multiple AHs to the same
> remote on the same PD. To overcome this limitation, introduce an AH
> cache that manages AH reuse transparently.
> 
> The cache uses an rhashtable keyed by (PD, GID) to track active address
> handles with refcounts. On create AH, the driver returns an existing AH
> number if one is already cached, or creates a new one and caches it. On
> destroy AH, the driver only issues the device destroy command when the
> last reference is dropped.
> 
> A per-entry mutex serializes concurrent device commands on the same
> cache entry, preventing create-before-destroy races on the device.
> 
> Yonatan Nachum (2):
>   RDMA/efa: Add initialization of AH cache rhashtable
>   RDMA/efa: Add AH cache handling on create and destroy AH
> 
>  drivers/infiniband/hw/efa/Makefile       |   4 +-
>  drivers/infiniband/hw/efa/efa_ah_cache.c | 154 +++++++++++++++++++++++
>  drivers/infiniband/hw/efa/efa_ah_cache.h |  41 ++++++
>  drivers/infiniband/hw/efa/efa_com.c      |  12 +-
>  drivers/infiniband/hw/efa/efa_com.h      |   5 +-
>  drivers/infiniband/hw/efa/efa_com_cmd.c  |  27 ++++
>  drivers/infiniband/hw/efa/efa_com_cmd.h  |   1 +
>  drivers/infiniband/hw/efa/efa_verbs.c    |   9 +-
>  8 files changed, 245 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.c
>  create mode 100644 drivers/infiniband/hw/efa/efa_ah_cache.h

The sashiko comments seem quite serious, please fix some of them up..

https://sashiko.dev/#/patchset/20260512061121.2177521-1-ynachum%40amazon.com

I would not do the GFP_ACCOUNT suggestion, we don't do that in RDMA
(though perhaps we should)

The races look right, the mis-use of the API looks right, and IDK
about the leak on cache_destroy, either clean it up or stick a WARN_ON
that it must be empty.

Jason


