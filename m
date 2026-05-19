Return-Path: <linux-rdma+bounces-20971-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJk0Egt7DGoSiQUAu9opvQ
	(envelope-from <linux-rdma+bounces-20971-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:00:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D46C158107F
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0CB8630E095A
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 14:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A0E71624C5;
	Tue, 19 May 2026 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cU2mGBRz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D063546D5;
	Tue, 19 May 2026 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779202061; cv=fail; b=Q41+V3/Bo3LQ9IANvSZnNny790O+SjqjreTpthjopejWomTmJ4mkm2xljprn7YUakyVvajCIib/4ckbhsPiNz9R7BGHjqPd7/l0GqI4hGriQWDeUIyzOD0pGHyawV1MjNlyk1Ygbt256UwpJT6kgGQ4AADaEMlHM3BI2zhVtxFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779202061; c=relaxed/simple;
	bh=FBdAV+0c35bxOs2gz0yZlOcFFaNLLgcAg3cs4duom54=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hE06tLvf5jah2OpwxgddYFR1BNR/WUYiPnLvFJQqY2HowQqzIYMKLqj1EZuZZFKgDid5B3sNGTenJtGCEOMSCLTVeMbKFeUYX8xaSrsQjxx2a+hiaHgxivXVoD6cZ2r1YAaZqGa5IWPxGGQWoevzzH3sFRtAV8cD/mY4WorCzME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cU2mGBRz; arc=fail smtp.client-ip=40.93.198.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YoFnLJ4iqyK2x+DQRcfTNZ/N/NUWBwO/kIOPcPTVrJCVeDv1fi9T9/3foToaPo1Db4gSIEspNGKH+KkxVMsOLB4K5fuuEeCCItjR0aBbP+/OB5oLxk6ApbGlwsKweiyNQs7UEelga6SGDBQkBbC9CirgGEeoYMLmnmm4IGMnfVKx+uWzXvYWf1tmJWyOeEY/u7jwow+2fMXkQehJJcTCNJdW2OOcsLU6jPf2HkOcktuEQ43lZntZSgItqVVD4jNzQyt/AIze+zqDK2nKjXO+j1I6S5QCn+cqACCu2wAbr5vQzRlYGOLk4HwUTi3w9fg4PQflGnkWFKddqEe0ZHLpVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3iPY+8H0z0cGfeKfm9eO1Rar98Fab+gJJVy9TX4dtQ=;
 b=DaN/fbeOxheKNVZpWnMRiHffBPkFo+sByM1K4vIMnAa3olTbe6p7uXiUiyuh/YZHrkbcmm3yOqp/V9dIJCxtU7DQqdQ49Geb/Nihir735yYR0eu3JoZ8p6eBRIr28s9o/IFTGkB+iLrYpJypP0zbHFjs4DwqjssLnJxK1LV0dN15R8nlTb9tD2cbOmaLaRyQuQREIo6CGIq+dEZnWvcl+XqDzteffQiRWppdpqeEykSBDWfYl1p202RdwnhGvLpsc9yPgBH8lANp2ZMI09/B+4eAJTibq5VRrltTKa6sXbAFsK+ogZGdlvwNvoPQ9lgV7yJB3HUlLBr7s4HRgf9TWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3iPY+8H0z0cGfeKfm9eO1Rar98Fab+gJJVy9TX4dtQ=;
 b=cU2mGBRzGxVviMVA8g8xpiZVmc6f4Xq2GUfxzv3CopeZjcrjlvXl6ezXSoENCseIK6L1UyvuDobaDSzjPy+u9XpAUxlgbjhBqQKEGby6SBM/uf1VS1cRh0C/k8IK3z7Nfrpnc4BMi7odf2Pp/Ie8WogKlDv+4wH/oDU2XQ07Xy3hJr/qXwb6j6SG4Q5lhoam909Wxd317wrC1+zMcxUIcYFvBtdTz677TXeRMZ4qiLHSR8a4OyMURmiqWz9atOJAcFW0wb/8wOQ4C4y4KezE//wrpCpn4S+FT72fAMC7zkpglccIwK2qs2fiLcfHBU9jR7dlz8KVlAiSQV2JT/w1Lw==
Received: from BN9PR03CA0396.namprd03.prod.outlook.com (2603:10b6:408:111::11)
 by CH3PR12MB8754.namprd12.prod.outlook.com (2603:10b6:610:170::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 14:47:30 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:408:111:cafe::b3) by BN9PR03CA0396.outlook.office365.com
 (2603:10b6:408:111::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.24 via Frontend Transport; Tue, 19
 May 2026 14:47:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 14:47:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 07:47:02 -0700
Received: from localhost (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 07:47:01 -0700
Date: Tue, 19 May 2026 17:46:53 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Vlad Dumitrescu
	<vdumitrescu@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>, Bob Pearson
	<rpearsonhpe@gmail.com>, Sean Hefty <shefty@nvidia.com>, Kees Cook
	<kees@kernel.org>
Subject: Re: [PATCH] IB/mad: cap RMPP reassembly window size to bound
 find_seg_location walk
Message-ID: <20260519144653.GZ33515@unreal>
References: <20260518212336.337104-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260518212336.337104-1-michael.bommarito@gmail.com>
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|CH3PR12MB8754:EE_
X-MS-Office365-Filtering-Correlation-Id: f75c4d4c-5cdd-4bfe-3c89-08deb5b58da1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|11063799006|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NxNZme9tPfasz60MgE//aS3obMWtQPO3ia1e0SAH6lMemiUi4X3QT6rQmZ0mVBdF+d6gFFxmAjPXvMEjmhLivRPXZfes/av2IzHGCp7Bb7/MdRfejtqbhPMQPHuJIe9JHuA8ZZxMZS7OQFwoyBRsMJca5TMj2SIUrcrlsiaGUE3J3ojH4jqli8N2tAm71fqFe5/vycEW/dmh1RXAeNwGC3Mhk/CRJhKT8PkgCBPbkIGpBnsY84IeDxPP1NkdYZc0zCsf0DhAZ9uyLJJIXfSOePhWZ6WECC4uSX9dmoJLt3AfYhblWLofrim+RZ3BDpfLUwJE/USJ59SxiKJ/04p73xbeVqPDMydg0l78ckisLtgg0QaY7QSc3OQgTX7cdoTn1CHGbau1X2pYStwS6ftDy/9FW76JkAqCvu4TANls84t58LT7IIoZ8a/Q/jGlUU2i1f4VITEWCTR6vx6g4SVXP7s7sDF/XcPAorZDVmVsB4vqdWtLmWsMSl73ODol7eGsUv41H8oTlgGBxWRXBpAp9GWMRnzErrpmvLx1ffeM7GM2304PoRiA88uAb4WFROAbe1t9Ui25cOMfwicG6VvDTUPCpl4T9S3bWgZFYstoooV8kfrKXSBV/S0bSUpJkGG9hqZlDvPXnTneLDHaHcH7f0ZDdbvF+ZqLCMs+HGbdnx9Y33hQUhru9+CXmL3nJ02PFvKVzRtWv/nKXs8TgfhGXEnCozIw+W9wk9n1B34cAUg=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(11063799006)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	S/jRIQEuKJ7FVBW+32hhnd7UA6+aFRtunWyDb30LWidRIYmKhTRb6oKnRoZljjb2f4Cnou0SBRsVlCc/kkwRpmId5376iKE+gGZ3jbSRPRoStbdmvbDqqfjN7kVm//4SAULFdCBjdhDTCkdtkKjGGaj5EdFreLfjjIYotLCNNV7qCbG0uLyi9IiUS/n0yP/j+Di4NX/tcUxWtqtBjyJC5Knn62E+zGhx+3zePz/pJ70MmsI94U8xLLlitGQw31cAldULLjXKHQx1lpsVTWnLl1rqtvxSsCPfur6rRxfPBM4bTkM5MQ8Q5sOwaSIvqmjDFx/fX07/zTGivkkaKJl1h8b3DWzIonlFuBSInj6/vvYXdLaO6+TvVoVzRIHXu9ivwzm4SVOAzBmft1w/whDZzk2n7PEow7EB7Zho5kwcpzLE0vRvRuctzI6zqkAHdm7f
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 14:47:30.1067
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f75c4d4c-5cdd-4bfe-3c89-08deb5b58da1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8754
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20971-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,Nvidia.com:dkim];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,vger.kernel.org,gmail.com,kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonro@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: D46C158107F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 05:23:36PM -0400, Michael Bommarito wrote:
> A peer on the same InfiniBand subnet or RoCEv2 L2 (or any UDP/4791-
> reachable peer for internet-exposed RoCEv2 ports) can pin a target
> port's IB MAD kworker for milliseconds per low-bandwidth RMPP burst
> by sending an RMPP management transaction with descending segment
> numbers. QP1 GMP traffic is unauthenticated by IBTA spec, so no
> credentials are required. The bug sits on the IB management path
> (QP1 GMP RMPP reassembly), not the RDMA data plane, so RDMA verbs
> throughput is unaffected; deployments that raise recv_queue_size to
> tune management-plane throughput are quadratically more exposed,
> because per-burst cost grows O(F^2) with the configured window.
> 
> drivers/infiniband/core/mad_rmpp.c::find_seg_location() walks
> rmpp_recv->rmpp_wc->rmpp_list in reverse on every inbound RMPP DATA
> segment to locate the insertion point keyed by segment number. The
> walk is O(N) per insert under spin_lock_irqsave(&rmpp_recv->lock) in
> kworker context, so F adversarially-reordered segments aggregate to
> O(F^2). window_size() returns max(recv_queue.max_active >> 3, 1):
> the IB MAD core default recv_queue_size of 512 yields window=64
> (per-burst cost in the microsecond range), but tuned production
> configs with recv_queue_size=8192 push window to 1024 and let a
> single low-bandwidth burst pin the per-port MAD kworker for several
> milliseconds.
> 
> Cap the effective window at IB_MAD_RMPP_MAX_WINDOW = 64 in
> window_size() so admins tuning recv_queue_size for higher RX throughput
> do not enlarge the walker attack surface. Real RMPP transactions in
> the wild (SA queries, perf-counter reads) are well served by a window
> of 64, which is also the IB MAD core default. A structural follow-up
> would convert rmpp_recv->rmpp_wc->rmpp_list to an rb_tree keyed by
> seg_num and lift the cap; that mirrors tcp_data_queue_ofo post-
> CVE-2018-5390. For now the cap suffices.
> 
> Fixes: fa619a77046b ("[PATCH] IB: Add RMPP implementation")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> I reproduced this under x86_64 QEMU/KVM (4 vCPUs) on v7.1-rc2 with
> CONFIG_RDMA_RXE + CONFIG_INFINIBAND_USER_MAD, a veth pair carrying
> two rdma_rxe links, and raw RoCEv2/UDP/4791 packet injection with
> descending seg_num while holding seg #1. Without the cap, F=1024
> burst produces 1022 paired continue_rmpp invocations whose per-call
> walker duration grows from ~1 us (early, near-empty list) to ~5 us
> (late, ~1000-deep list), a 4x per-call amplification as the queue
> deepens, with aggregate walker time per burst >= 1.5 ms (lower bound,
> ftrace 1 us granularity). With the cap, the same F=1024 burst drops
> to ~0.28 ms aggregate (5.4x reduction); F=32 in-window legitimate
> RMPP still completes normally (30 walker calls, avg 1.5 us, max 3 us).
> tools/testing/selftests/drivers/net/rdma/ carries no RMPP-specific
> selftest in v7.1-rc2 (rdma_rxe self-tests do not exercise QP1 GMP
> RMPP reassembly), so no in-tree selftest delta to report.
> 
>  drivers/infiniband/core/mad_rmpp.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)

Please rewrite this patch in human language without AI slop.
While working on this, please ensure that your commit message clearly
explains why the change is needed and what issue it actually resolves.

Thanks

