Return-Path: <linux-rdma+bounces-557-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ADA826C4B
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 12:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFB20283103
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 11:11:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4712829436;
	Mon,  8 Jan 2024 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pPDDvcPb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412972940E;
	Mon,  8 Jan 2024 11:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+atkYQS7TpSZqgMyQoOghnMNTSpDgYLSfZhYHBYHEz5MjrbjlEOa4eLKkgI0ISCGaj9vPjP3fphhbX1W8i7gdbj/WV/OrrUIUfQUrZL1GUaRU4ay/z3sRHwJeaaaHCxPzwmEKgf/iNbo75Gq7KGsFikHmg1IXmxfcNL3PrtErXTPI5doHjgIPbW0QkRMpwWkXHxC+j8IMGhPpoR5h5sb+Dp2GDlp+hhxRkhVgvP7jDd7OVQig3XdKvS/CtYtwQhBfIi8l9hVX2C/fMfNDQEXZHB2aDHQH+YIuTo3cM5pY+T0Jx6RNJ4lhS+f7PmGAp+VDxk+4Xz0LzAHZa5PywwZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNNY/LR1kjpi00vn0zXHCf5GRoDDxIk/5D2yR6EhKYY=;
 b=R4CgCBpQI/uRghI24mI4C+rzibB+r0Vq+wXNgv/XJw1AnRAQ6flxTwWycbsKRu9h2dKV8HVe6sI545WpXyYmu6gPKtmVO09ZrIL2sLw3R5LVvCuuYO6g7BcMpJu4S2NIt899aH3wmYOz3VWwoIsIIQASxum1616JsP8X4jVMVU3ToHflVgJsYbr/waeVvHx4GepyEsU1Rd+eKaXvlqEmC4zP/y2IvIlwKg2TQ/0EQrwaZVwF4AIvtqKJwValln28PIYXbKIN0yZJUdvs9ExgiidrDG21iRemBGxgm9ZNTcbRfFneq1Y+ADcKjxB+o6XTasgzkBJ6rkFtlcXSn0R/Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNNY/LR1kjpi00vn0zXHCf5GRoDDxIk/5D2yR6EhKYY=;
 b=pPDDvcPbjNMkMk1jfYV1mIs9MiEE4iLmQ+pIjprlyMRC4xFXzJc7RAyMcuxDcao2kCiw7HMmsBVl+JBQPVjhR9otTNae5iLdyHpRqPhTohE3jY032wTnpyti8kNwIK/FC30is+y38o49Ge+jbawJg2crW8yKNBpNCkT199dqM/sHblliHZcOxtpBBJlntC34W0fWAiD7NC8UurCbIG02k3k5Rw0DITAyFiPAHN9CUJ5MLKXx3o2GCW9gvF8fuPxYiqBkpZ00H0OvHyIMgzexCu5LYpFjVRyE42iK2fY0xS7NwQL7Ga+E6fCYXzTq0FXZ2LhJTLzCXyWsedYpF9EyXA==
Received: from PH0PR07CA0075.namprd07.prod.outlook.com (2603:10b6:510:f::20)
 by LV3PR12MB9143.namprd12.prod.outlook.com (2603:10b6:408:19e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Mon, 8 Jan
 2024 11:10:19 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::8c) by PH0PR07CA0075.outlook.office365.com
 (2603:10b6:510:f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21 via Frontend
 Transport; Mon, 8 Jan 2024 11:10:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.12 via Frontend Transport; Mon, 8 Jan 2024 11:10:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Jan 2024
 03:10:06 -0800
Received: from yaviefel (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 8 Jan 2024
 03:10:03 -0800
References: <20231229065241.554726-1-huangjunxian6@hisilicon.com>
 <20231229065241.554726-3-huangjunxian6@hisilicon.com>
 <fb7c85a4-165d-7eda-740a-d11a32cb86c0@hisilicon.com>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Junxian Huang <huangjunxian6@hisilicon.com>
CC: <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
	<stephen@networkplumber.org>, Chengchang Tang <tangchengchang@huawei.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH iproute2-rc 2/2] rdma: Fix the error of accessing string
 variable outside the lifecycle
Date: Mon, 8 Jan 2024 12:09:04 +0100
In-Reply-To: <fb7c85a4-165d-7eda-740a-d11a32cb86c0@hisilicon.com>
Message-ID: <8734v8ozcn.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|LV3PR12MB9143:EE_
X-MS-Office365-Filtering-Correlation-Id: 402252f7-66c9-4ea6-4c2b-08dc103a6682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KpV9Thy+qWzTMTatlst5gXm0fL9pTSE9MPhP6WLXTSqpmkVATOADerNR8ApOVg9iig2Ls0wLvuj1f9VYfILnc28nXAx+ktbdOkprKxPBNlek90HYUTHypZB0wKytS/nOjCExwvMjJvY+YthHE+3wFqiDRk4Gl1K0p0Y/CDm5SNJ9WP75uKPvyOH1dD49AbNnN5r227NmIyV67uWY9zTw8ykBQvJjDVWmVG/6uTYQ9WxUXzmG5YL0qiGVTpGhagc10woD8dW35l4wIUws3IjFL1x9wQT16r2CaILptYvqYFFhmV//lsZ38BVfSmmtpuGA9jn+F+BxCgK0alA93X6VRFMBzRHvveHgRENaceS9TRdoQ75IHqt2/4Oe2pPtCePf+tiygGaoeLQatpdT+fc0QYCq9QR6Hvx7BIrjIT6RygzgZ2yoa/H3sFleFi/AoX8QhbptiPaehLOc9mRLCBng+bSZtkNTUdPmpzfSe0G1zwkchmdiGeXIepVDG4yqsJR8RJbNR+resfqo/+w52HUrg9gnR9elM4/7ZLqWdWxWdUG2w5F9y7+H3Nrzy/jYgZeAu+erwJ1rRsAspB5quOqowUr1jT0BB4Kspo/7PZsX2WvuBHz+aG5uIcLx9yoDVkS276FWtu4h0YvRbHcKFnFqvJqf3r1SshMYxkYbuyJAgoX9uCsOvesSxrVQS/JXYMA8VOjyG5+vxt9bFj6M1AINkgZTsSboekLS63uLuDwBrotry70pawIe6hiSC3MgYTdr
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799012)(46966006)(40470700004)(36840700001)(4326008)(82740400003)(7416002)(2906002)(5660300002)(47076005)(478600001)(53546011)(83380400001)(26005)(2616005)(336012)(426003)(16526019)(54906003)(316002)(36756003)(70586007)(70206006)(6916009)(36860700001)(8936002)(8676002)(86362001)(41300700001)(356005)(7636003)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:10:19.1699
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 402252f7-66c9-4ea6-4c2b-08dc103a6682
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9143


Junxian Huang <huangjunxian6@hisilicon.com> writes:

> the first patch is replaced by Stephen's latest patches. Are there any
> comments to this patch?

Yeah, what the code is currently doing is invalid.

Reviewed-by: Petr Machata <petrm@nvidia.com>

> Thanks,
> Junxian
>
> On 2023/12/29 14:52, Junxian Huang wrote:
>> From: wenglianfa <wenglianfa@huawei.com>
>> 
>> All these SPRINT_BUF(b) definitions are inside the 'if' block, but
>> accessed outside the 'if' block through the pointers 'comm'. This
>> leads to empty 'comm' attribute when querying resource information.
>> So move the definitions to the beginning of the functions to extend
>> their life cycle.
>> 
>> Before:
>> $ rdma res show srq
>> dev hns_0 srqn 0 type BASIC lqpn 18 pdn 5 pid 7775 comm
>> 
>> After:
>> $ rdma res show srq
>> dev hns_0 srqn 0 type BASIC lqpn 18 pdn 5 pid 7775 comm ib_send_bw
>> 
>> Fixes: 1808f002dfdd ("lib/fs: fix memory leak in get_task_name()")
>> Signed-off-by: wenglianfa <wenglianfa@huawei.com>
>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>> ---
>>  rdma/res-cmid.c | 3 +--
>>  rdma/res-cq.c   | 3 +--
>>  rdma/res-ctx.c  | 3 +--
>>  rdma/res-mr.c   | 3 +--
>>  rdma/res-pd.c   | 3 +--
>>  rdma/res-qp.c   | 3 +--
>>  rdma/res-srq.c  | 3 +--
>>  rdma/stat.c     | 3 +--
>>  8 files changed, 8 insertions(+), 16 deletions(-)
>> 
>> diff --git a/rdma/res-cmid.c b/rdma/res-cmid.c
>> index 7371c3a6..595af848 100644
>> --- a/rdma/res-cmid.c
>> +++ b/rdma/res-cmid.c
>> @@ -102,6 +102,7 @@ static int res_cm_id_line(struct rd *rd, const char *name, int idx,
>>  	uint32_t lqpn = 0, ps;
>>  	uint32_t cm_idn = 0;
>>  	char *comm = NULL;
>> +	SPRINT_BUF(b);
>>  
>>  	if (!nla_line[RDMA_NLDEV_ATTR_RES_STATE] ||
>>  	    !nla_line[RDMA_NLDEV_ATTR_RES_PS])
>> @@ -159,8 +160,6 @@ static int res_cm_id_line(struct rd *rd, const char *name, int idx,
>>  		goto out;
>>  
>>  	if (nla_line[RDMA_NLDEV_ATTR_RES_PID]) {
>> -		SPRINT_BUF(b);
>> -
>>  		pid = mnl_attr_get_u32(nla_line[RDMA_NLDEV_ATTR_RES_PID]);
>>  		if (!get_task_name(pid, b, sizeof(b)))
>>  			comm = b;
>> diff --git a/rdma/res-cq.c b/rdma/res-cq.c
>> index 2cfa4994..80994a03 100644
>> --- a/rdma/res-cq.c
>> +++ b/rdma/res-cq.c
>> @@ -63,6 +63,7 @@ static int res_cq_line(struct rd *rd, const char *name, int idx,
>>  	uint32_t cqn = 0;
>>  	uint64_t users;
>>  	uint32_t cqe;
>> +	SPRINT_BUF(b);
>>  
>>  	if (!nla_line[RDMA_NLDEV_ATTR_RES_CQE] ||
>>  	    !nla_line[RDMA_NLDEV_ATTR_RES_USECNT])
>> @@ -84,8 +85,6 @@ static int res_cq_line(struct rd *rd, const char *name, int idx,
>>  		goto out;
>>  
>>  	if (nla_line[RDMA_NLDEV_ATTR_RES_PID]) {
>> -		SPRINT_BUF(b);
>> -
>>  		pid = mnl_attr_get_u32(nla_line[RDMA_NLDEV_ATTR_RES_PID]);
>>  		if (!get_task_name(pid, b, sizeof(b)))
>>  			comm = b;
>> diff --git a/rdma/res-ctx.c b/rdma/res-ctx.c
>> index 500186d9..99736ea0 100644
>> --- a/rdma/res-ctx.c
>> +++ b/rdma/res-ctx.c
>> @@ -13,13 +13,12 @@ static int res_ctx_line(struct rd *rd, const char *name, int idx,
>>  	char *comm = NULL;
>>  	uint32_t ctxn = 0;
>>  	uint32_t pid = 0;
>> +	SPRINT_BUF(b);
>>  
>>  	if (!nla_line[RDMA_NLDEV_ATTR_RES_CTXN])
>>  		return MNL_CB_ERROR;
>>  
>>  	if (nla_line[RDMA_NLDEV_ATTR_RES_PID]) {
>> -		SPRINT_BUF(b);
>> -
>>  		pid = mnl_attr_get_u32(nla_line[RDMA_NLDEV_ATTR_RES_PID]);
>>  		if (!get_task_name(pid, b, sizeof(b)))
>>  			comm = b;
>> diff --git a/rdma/res-mr.c b/rdma/res-mr.c
>> index fb48d5df..e6c81d11 100644
>> --- a/rdma/res-mr.c
>> +++ b/rdma/res-mr.c
>> @@ -30,6 +30,7 @@ static int res_mr_line(struct rd *rd, const char *name, int idx,
>>  	uint32_t pdn = 0;
>>  	uint32_t mrn = 0;
>>  	uint32_t pid = 0;
>> +	SPRINT_BUF(b);
>>  
>>  	if (!nla_line[RDMA_NLDEV_ATTR_RES_MRLEN])
>>  		return MNL_CB_ERROR;
>> @@ -47,8 +48,6 @@ static int res_mr_line(struct rd *rd, const char *name, int idx,
>>  		goto out;
>>  
>>  	if (nla_line[RDMA_NLDEV_ATTR_RES_PID]) {
>> -		SPRINT_BUF(b);
>> -
>>  		pid = mnl_attr_get_u32(nla_line[RDMA_NLDEV_ATTR_RES_PID]);
>>  		if (!get_task_name(pid, b, sizeof(b)))
>>  			comm = b;
>> diff --git a/rdma/res-pd.c b/rdma/res-pd.c
>> index 66f91f42..0dbb310a 100644
>> --- a/rdma/res-pd.c
>> +++ b/rdma/res-pd.c
>> @@ -16,6 +16,7 @@ static int res_pd_line(struct rd *rd, const char *name, int idx,
>>  	uint32_t pid = 0;
>>  	uint32_t pdn = 0;
>>  	uint64_t users;
>> +	SPRINT_BUF(b);
>>  
>>  	if (!nla_line[RDMA_NLDEV_ATTR_RES_USECNT])
>>  		return MNL_CB_ERROR;
>> @@ -34,8 +35,6 @@ static int res_pd_line(struct rd *rd, const char *name, int idx,
>>  			nla_line[RDMA_NLDEV_ATTR_RES_UNSAFE_GLOBAL_RKEY]);
>>  
>>  	if (nla_line[RDMA_NLDEV_ATTR_RES_PID]) {
>> -		SPRINT_BUF(b);
>> -
>>  		pid = mnl_attr_get_u32(nla_line[RDMA_NLDEV_ATTR_RES_PID]);
>>  		if (!get_task_name(pid, b, sizeof(b)))
>>  			comm = b;
>> diff --git a/rdma/res-qp.c b/rdma/res-qp.c
>> index c180a97e..cd2f4aa2 100644
>> --- a/rdma/res-qp.c
>> +++ b/rdma/res-qp.c
>> @@ -86,6 +86,7 @@ static int res_qp_line(struct rd *rd, const char *name, int idx,
>>  	uint32_t port = 0, pid = 0;
>>  	uint32_t pdn = 0;
>>  	char *comm = NULL;
>> +	SPRINT_BUF(b);
>>  
>>  	if (!nla_line[RDMA_NLDEV_ATTR_RES_LQPN] ||
>>  	    !nla_line[RDMA_NLDEV_ATTR_RES_SQ_PSN] ||
>> @@ -146,8 +147,6 @@ static int res_qp_line(struct rd *rd, const char *name, int idx,
>>  		goto out;
>>  
>>  	if (nla_line[RDMA_NLDEV_ATTR_RES_PID]) {
>> -		SPRINT_BUF(b);
>> -
>>  		pid = mnl_attr_get_u32(nla_line[RDMA_NLDEV_ATTR_RES_PID]);
>>  		if (!get_task_name(pid, b, sizeof(b)))
>>  			comm = b;
>> diff --git a/rdma/res-srq.c b/rdma/res-srq.c
>> index cf9209d7..758bb193 100644
>> --- a/rdma/res-srq.c
>> +++ b/rdma/res-srq.c
>> @@ -183,13 +183,12 @@ static int res_srq_line(struct rd *rd, const char *name, int idx,
>>  	char qp_str[MAX_QP_STR_LEN] = {};
>>  	char *comm = NULL;
>>  	uint8_t type = 0;
>> +	SPRINT_BUF(b);
>>  
>>  	if (!nla_line[RDMA_NLDEV_ATTR_RES_SRQN])
>>  		return MNL_CB_ERROR;
>>  
>>  	if (nla_line[RDMA_NLDEV_ATTR_RES_PID]) {
>> -		SPRINT_BUF(b);
>> -
>>  		pid = mnl_attr_get_u32(nla_line[RDMA_NLDEV_ATTR_RES_PID]);
>>  		if (!get_task_name(pid, b, sizeof(b)))
>>  			comm = b;
>> diff --git a/rdma/stat.c b/rdma/stat.c
>> index 3df2c98f..c7dde680 100644
>> --- a/rdma/stat.c
>> +++ b/rdma/stat.c
>> @@ -223,6 +223,7 @@ static int res_counter_line(struct rd *rd, const char *name, int index,
>>  	struct nlattr *hwc_table, *qp_table;
>>  	struct nlattr *nla_entry;
>>  	const char *comm = NULL;
>> +	SPRINT_BUF(b);
>>  	bool isfirst;
>>  	int err;
>>  
>> @@ -248,8 +249,6 @@ static int res_counter_line(struct rd *rd, const char *name, int index,
>>  		return MNL_CB_OK;
>>  
>>  	if (nla_line[RDMA_NLDEV_ATTR_RES_PID]) {
>> -		SPRINT_BUF(b);
>> -
>>  		pid = mnl_attr_get_u32(nla_line[RDMA_NLDEV_ATTR_RES_PID]);
>>  		if (!get_task_name(pid, b, sizeof(b)))
>>  			comm = b;


