Return-Path: <linux-rdma+bounces-22141-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TM8ELswJK2r+1gMAu9opvQ
	(envelope-from <linux-rdma+bounces-22141-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 21:17:32 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD0C674B4C
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 21:17:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=oZ3QVtV6;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22141-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22141-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA1EF3028AD5
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 19:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BABFE3128B8;
	Thu, 11 Jun 2026 19:17:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011029.outbound.protection.outlook.com [40.93.194.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAF41BBBE5;
	Thu, 11 Jun 2026 19:17:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781205450; cv=fail; b=JGvD4RI87euTq/hpH9/LDgWvUuRd/cPEPXKtwEhVjdOD4y2XBHDfSiTxm8RJVhyHdRbm2/es87aIyNGuki4auUtQK4QIT1eoFZDVSqfw9imME0A+pq9J3lAUyQdRvlt0qyaB7tQj7f0Fruaf5HPU7Xy+nI1QYEIXr2GzFPC1JrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781205450; c=relaxed/simple;
	bh=yTo/tZGfQ+Z5v5Y6APt34yDRxS7Nrlju5eOk58jrr9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WiptIm2/uUsSFfEt0TTbKgcUocdqFWyxt/l59GSJaI2o9zvqOhKZBfCWV9bfE86KC/VAoCy0LCPIEqWpBA0uvPbIlh4E5UMVqnCL0IfVvPTw4AkHwCAcqPPJOAXLhr5ESzPCd0bxKeMShTHWCuHc+jfHGcryOQGdVxIipeBhsuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oZ3QVtV6; arc=fail smtp.client-ip=40.93.194.29
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+1tyHgJSL6BZ4BAqCJQxIpLcI0cDOWACGEaBtOZTunRFMBQf1lc4QNc9ZgLi4lHWgr0xocbGptpjH0wRaaDT3gsio0wsSfwliUTXCV7yNHu3B5bA4cbHBWh2czQ+LuBKoH+3JRLq85Mo7fiRLFUi9/t8+Ur/K/g+p12mPWtIRCnBgzWngL2yq5lXs50vzcYedsZfamOZeHwWS6nqz50WgbEh9q3vuijnrzSreedaB6ZbcJpqNj5uCPTFkrc6D4hEgqa6q3NlDRAlf59hGL7QKSQsb4c1TUm8Pb6cA0mJfUnpMZXNynTAVOVK7/h9kTeL3bXWepPv7sl7YIvsxNShQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FCfVDRFOfovDodCPDWszxmmtTWcQZhtr6tUMAqaJOo=;
 b=DE7ZtZ/EVsoEzUnf32g9H3wBqG9gYvI4W3k72AoPL94VmNn78C6oke4SJLzEn0nq0O9Bvcu0UXJWoLsUA3fO7bx1QAFhUTrNanN2VrQHrKrAsn2zp09e8WAshnjh8ATsSKnqJgvjJBVsqUKGAnHAnYvG2Ix6+40/J8IogbJ2Fgxu+7/XuEIAePSo40dpfxixWOMEbYzQ4j7oJkyx/kK+GOtbKz60FdqPXzGQvSAPJUTCq5Fj+JPeo/u0qFg3BrZ+A9CmsnkXeDKPfrCFhFSddkJlYeY34Va1Fud4lo3XMea03GPL5D4KQt8KdCe50Dshnzfa5wT4ig5h3UqDiFjeBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FCfVDRFOfovDodCPDWszxmmtTWcQZhtr6tUMAqaJOo=;
 b=oZ3QVtV6bjTCRHyeyPDEYkShEgQJ0gEasdbd/PYreB/NtcoBjg9sCqlT76RrQIQTUnZxsH0XZnDgtnaxkmz0HgkrplKzccQMQSooVWpR78sauTrwGEQ5lVwk19Cl2qw5bMIYjX/2+cKg+tyODUdIw0Hv39yympd+Tk8Vy9d8uA6p78fPeySCo8KfU2T00X1GntAZ0/VjMr6eZoz5/rAHw7png/HfUXDs0R0RTqoq7x/nA7oonMXSt0JTZSDrWQSQc6A0s99FP7byGnrTqRN8HnBIjJH73zjLuoDWixyHPYJp+gbNCfWq6toXper1qwrBqbEgq/06XyfdX9yJnSsnqg==
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.18; Thu, 11 Jun
 2026 19:17:24 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 19:17:24 +0000
Date: Thu, 11 Jun 2026 16:17:23 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Edward Srouji <edwards@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Or Gerlitz <ogerlitz@mellanox.com>,
	Jack Morgenstein <jackm@dev.mellanox.co.il>,
	Roland Dreier <roland@purestorage.com>,
	Eli Cohen <eli@mellanox.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Maher Sanalla <msanalla@nvidia.com>
Subject: Re: [PATCH rdma-next 2/2] RDMA/mlx5: Fix integer overflow of user QP
 buffer size
Message-ID: <20260611191723.GA1516987@nvidia.com>
References: <20260611-maher-sec-fixes-v1-0-cd8eb2542869@nvidia.com>
 <20260611-maher-sec-fixes-v1-2-cd8eb2542869@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-maher-sec-fixes-v1-2-cd8eb2542869@nvidia.com>
X-ClientProxiedBy: BN0PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:408:e4::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a018d9b-c8cf-4b0b-64b0-08dec7ee1183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	UWbXTPXeiLeaE2saO8xD28Vp7o5ZVsJ/FG6CmHfdwMkuWWQLz8j6/ziUBdfqvF67romm+2dC2tM/IBP7AFa9ZVMkDkmIqWkDKC6Y29uzXof0EdulXQTHYf7DHRr8RiXrDin1LqzJq4xd4dKe2hChlf8IzaPLvYbG18s4CNs931recq5Biis11epo5ubtdIn4Nv0XG0FJ6h0AUJWxXJkf6Vpj0C5SNKHen6fCSziejXoMlh5vo4Hgybv+s4VGHg3WT6m11roNnWy73sryk901MOBs6QRVnNcs6RHRc5NA73eqCmSmq8Kxt/AI7ug4IGkUQGO200YXcXV7i1AS0nGMP3VxHCq/nqw9/N2pmUiSvLH4XCD6fPXD38eEESdb+6ij8i629X3hpCXFj0PStD0JRGmIlGE6d65ps4koZkRq03uLbjXWMqAFTh8xRy8BKUqX+5vyeqNzu2In5o+y1cC8LCpUJruzmXbZK0zDhilX4fkjLuuH151HlpxROusfKfHKcyxTpCj4E0wR3sWn/b91cxhFR3e/cXesdyLEV24kL7sBi2+WJjzI3ie60ILonwoFJOv1cCcdnU7F1oivRv0HG5iOUx4/YvfSNJigG5VIG3AtCC/pqBZ9PiKD9LhFgBy9nOENIuq/JoHLkBJTJGtlqw5qn0p1nv2+Fhz8Uht5/cMoTc+U+8O2Wl0axllr7REv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AOjXcmrZreLd39e3/+A1taO0i4H/LPBUOreVubnL4ndzIK/bRxYwyP073Zfz?=
 =?us-ascii?Q?V00nqk3CRRkc7Gc/ODXpEHSYsBSpiOQ9YyShKv/p3pB7CGfn8g2AEEVIMoTM?=
 =?us-ascii?Q?4YJY5Jk3b+6G12Gi/hNsQtbYZgK/FHi25fCUT3veZu4tvVNcsqyPtBo1bs8P?=
 =?us-ascii?Q?meKPHeTbMvdzMrEVoYeI70H+lfA7Bkh89VlAMU4wtQ1/nf1G1Bwmvq5qZJxh?=
 =?us-ascii?Q?4pb1l3oJ41eeqAOxl2gHxRBH5NexmFqeZXrARZP7Ru1cpP964IG7mSbG4ElY?=
 =?us-ascii?Q?KYqGDNX+rbs4Boj9Tjav2QCzHg46mCUWJGOZVrx/opaKq6hmiPBthoIYtfOT?=
 =?us-ascii?Q?5UTKbptv9UA5lLTyXmClraRkbaxyJU118PPB5Ym5ibIO7Tuj9nLjGmkxE0t6?=
 =?us-ascii?Q?2FevQesHwlKXs+979iumdjmep8PLClXlrEBeqvV9qfqRPsYvx+59nC0gPPz6?=
 =?us-ascii?Q?hqK43Wai596vFLL/jlQ3Bgn8CxiUjpSisJoiScoPmhulx2ee1/4twtNPpKB3?=
 =?us-ascii?Q?S+xFGLoJ/rw0vdYr16Mplfmlu3hV58efASMOQ84zHfJh2Q2Pp3969Jf8ug8Q?=
 =?us-ascii?Q?u7ngfZXI8bBiSesGwV/DK2nUzz3abR9bksPPqaungmGPfM7gtt8PkIBeXtgq?=
 =?us-ascii?Q?HP9lIkVs9YcOJ7pDDOKR6voud4lYKgXFV72hmR3GqDtFAXlcNJ07ZF/kqm8Z?=
 =?us-ascii?Q?64HYA2MAHnwH/llhBAjWiyAGxCl43f5WlzsH3+gglYwvPO4EpN4T6rsLljgF?=
 =?us-ascii?Q?muxTaiRAroxpkoc3+sNwUZ/nmhlYEtEbwxfqgVvAf1pg1yalmTTXQV/E7/ak?=
 =?us-ascii?Q?fff7hRocRLBIel1yWv9WN+d1v3tc9/MZdyUr4F7LUfGHoFaLSNLlyVkPzvZf?=
 =?us-ascii?Q?mU1tLRE9dNwkprZ5gxxzY6KsNcfQnoo5ESdSJ25UOD9ir0LhQQTzC1wElTwV?=
 =?us-ascii?Q?ccsrvYez3wdUl6leq1JBkZL0pvMroCd1WW3vsfVU3D9OJO/HLyFCp0iSTaYq?=
 =?us-ascii?Q?jeiCQnyhSYabncohvLyv6c579rPPGx0G++WfbB352wHIyCc8CKpFRq7fHV/u?=
 =?us-ascii?Q?lunfJ4FQ3tiHwc9NPrtxR+OcoszTek45yfamSZYUE2M7IpBP7YZw1RC65xZX?=
 =?us-ascii?Q?1JU4JkpBzZDn4usbqWfFMEiUpAifrsfNWF+spUQ0iizu2YSrLdAsy3RHjLCq?=
 =?us-ascii?Q?d/onT0U9MlNHjBAIInovRiKEQ8inFFv9Sg/nrTQaNtWWZCTZ50lmIzBRheoU?=
 =?us-ascii?Q?PbTLtLm7RqCx8au5llK3da+lWEwdFHlEqB7QwDRftjuJwSkBDCHRjXQ0xiPk?=
 =?us-ascii?Q?pAI04AgBxsNXzJDrAdqDr6rg5Sis27fx28nnV2zBbPDMOP7/ini0WLS4Xi5X?=
 =?us-ascii?Q?OJAgFlGXmcTeJc6ZAYB4wCLdWs7JfhlxgimDbN3UDyUbS2oA9+TuSG/JIy7O?=
 =?us-ascii?Q?GlYgrSAPskjrB4JNyh1Nwr6eF4HpJSRyefT2//t8yN1yBJzGIxOI8stpbV1v?=
 =?us-ascii?Q?NuNqv3BPGPCUEX0rKwUz60mycUR2RPPDKzLY4CmfHF5dsM29QLm5jkgnfsZ/?=
 =?us-ascii?Q?T65uyu2etWkwRGmoWu1wj9Uc3NGyU6WtpjzhKhJevvXYuY+jWUHq+jcpM4fW?=
 =?us-ascii?Q?mVQtq0XsXmedhH1l6uzX/t2XfM/H5V+OsWWLMVkRFeENk7KoTDaoQTeMfHov?=
 =?us-ascii?Q?WND1BnLQUyj+0qOSFC2XoMOPGC4a53vLmdQ+Vo6Inn3irLc9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a018d9b-c8cf-4b0b-64b0-08dec7ee1183
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 19:17:24.6874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFwCOGQcG3uN4HXvBYWHFszHufyvuFGNlgqYeU81ICnkE93JXTKnunCYIylAH94q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22141-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edwards@nvidia.com,m:leon@kernel.org,m:ogerlitz@mellanox.com,m:jackm@dev.mellanox.co.il,m:roland@purestorage.com,m:eli@mellanox.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:msanalla@nvidia.com,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4BD0C674B4C

On Thu, Jun 11, 2026 at 03:50:43PM +0300, Edward Srouji wrote:
> @@ -664,11 +666,36 @@ static int set_user_buf_size(struct mlx5_ib_dev *dev,
>  
>  	if (attr->qp_type == IB_QPT_RAW_PACKET ||
>  	    qp->flags & IB_QP_CREATE_SOURCE_QPN) {
> -		base->ubuffer.buf_size = qp->rq.wqe_cnt << qp->rq.wqe_shift;
> -		qp->raw_packet_qp.sq.ubuffer.buf_size = qp->sq.wqe_cnt << 6;
> +		if (check_shl_overflow(qp->rq.wqe_cnt, qp->rq.wqe_shift,
> +				       &base->ubuffer.buf_size)) {
> +			mlx5_ib_warn(dev, "rq buf size overflow: wqe_cnt %d wqe_shift %d\n",
> +				     qp->rq.wqe_cnt, qp->rq.wqe_shift);
> +			return -EINVAL;

No prints triggerable by uapi.

Jason

