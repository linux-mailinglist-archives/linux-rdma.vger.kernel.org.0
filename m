Return-Path: <linux-rdma+bounces-551-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A8282671B
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 02:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AC3B2817FE
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 01:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DFEEA5;
	Mon,  8 Jan 2024 01:29:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E8F7F;
	Mon,  8 Jan 2024 01:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4T7byg4v76z1Q7r7;
	Mon,  8 Jan 2024 09:27:23 +0800 (CST)
Received: from kwepemi500006.china.huawei.com (unknown [7.221.188.68])
	by mail.maildlp.com (Postfix) with ESMTPS id D7EC61800BC;
	Mon,  8 Jan 2024 09:28:53 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemi500006.china.huawei.com (7.221.188.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Jan 2024 09:28:53 +0800
Message-ID: <fb7c85a4-165d-7eda-740a-d11a32cb86c0@hisilicon.com>
Date: Mon, 8 Jan 2024 09:28:52 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
From: Junxian Huang <huangjunxian6@hisilicon.com>
Subject: Re: [PATCH iproute2-rc 2/2] rdma: Fix the error of accessing string
 variable outside the lifecycle
To: <jgg@ziepe.ca>, <leon@kernel.org>, <dsahern@gmail.com>,
	<stephen@networkplumber.org>, Chengchang Tang <tangchengchang@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>
References: <20231229065241.554726-1-huangjunxian6@hisilicon.com>
 <20231229065241.554726-3-huangjunxian6@hisilicon.com>
Content-Language: en-US
In-Reply-To: <20231229065241.554726-3-huangjunxian6@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500006.china.huawei.com (7.221.188.68)


Hi all,

the first patch is replaced by Stephen's latest patches. Are there any
comments to this patch?

Thanks,
Junxian

On 2023/12/29 14:52, Junxian Huang wrote:
> From: wenglianfa <wenglianfa@huawei.com>
> 
> All these SPRINT_BUF(b) definitions are inside the 'if' block, but
> accessed outside the 'if' block through the pointers 'comm'. This
> leads to empty 'comm' attribute when querying resource information.
> So move the definitions to the beginning of the functions to extend
> their life cycle.
> 
> Before:
> $ rdma res show srq
> dev hns_0 srqn 0 type BASIC lqpn 18 pdn 5 pid 7775 comm
> 
> After:
> $ rdma res show srq
> dev hns_0 srqn 0 type BASIC lqpn 18 pdn 5 pid 7775 comm ib_send_bw
> 
> Fixes: 1808f002dfdd ("lib/fs: fix memory leak in get_task_name()")
> Signed-off-by: wenglianfa <wenglianfa@huawei.com>
> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
> ---
>  rdma/res-cmid.c | 3 +--
>  rdma/res-cq.c   | 3 +--
>  rdma/res-ctx.c  | 3 +--
>  rdma/res-mr.c   | 3 +--
>  rdma/res-pd.c   | 3 +--
>  rdma/res-qp.c   | 3 +--
>  rdma/res-srq.c  | 3 +--
>  rdma/stat.c     | 3 +--
>  8 files changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/rdma/res-cmid.c b/rdma/res-cmid.c
> index 7371c3a6..595af848 100644
> --- a/rdma/res-cmid.c
> +++ b/rdma/res-cmid.c
> @@ -102,6 +102,7 @@ static int res_cm_id_line(struct rd *rd, const char *name, int idx,
>  	uint32_t lqpn = 0, ps;
>  	uint32_t cm_idn = 0;
>  	char *comm = NULL;
> +	SPRINT_BUF(b);
>  
>  	if (!nla_line[RDMA_NLDEV_ATTR_RES_STATE] ||
>  	    !nla_line[RDMA_NLDEV_ATTR_RES_PS])
> @@ -159,8 +160,6 @@ static int res_cm_id_line(struct rd *rd, const char *name, int idx,
>  		goto out;
>  
>  	if (nla_line[RDMA_NLDEV_ATTR_RES_PID]) {
> -		SPRINT_BUF(b);
> -
>  		pid = mnl_attr_get_u32(nla_line[RDMA_NLDEV_ATTR_RES_PID]);
>  		if (!get_task_name(pid, b, sizeof(b)))
>  			comm = b;
> diff --git a/rdma/res-cq.c b/rdma/res-cq.c
> index 2cfa4994..80994a03 100644
> --- a/rdma/res-cq.c
> +++ b/rdma/res-cq.c
> @@ -63,6 +63,7 @@ static int res_cq_line(struct rd *rd, const char *name, int idx,
>  	uint32_t cqn = 0;
>  	uint64_t users;
>  	uint32_t cqe;
> +	SPRINT_BUF(b);
>  
>  	if (!nla_line[RDMA_NLDEV_ATTR_RES_CQE] ||
>  	    !nla_line[RDMA_NLDEV_ATTR_RES_USECNT])
> @@ -84,8 +85,6 @@ static int res_cq_line(struct rd *rd, const char *name, int idx,
>  		goto out;
>  
>  	if (nla_line[RDMA_NLDEV_ATTR_RES_PID]) {
> -		SPRINT_BUF(b);
> -
>  		pid = mnl_attr_get_u32(nla_line[RDMA_NLDEV_ATTR_RES_PID]);
>  		if (!get_task_name(pid, b, sizeof(b)))
>  			comm = b;
> diff --git a/rdma/res-ctx.c b/rdma/res-ctx.c
> index 500186d9..99736ea0 100644
> --- a/rdma/res-ctx.c
> +++ b/rdma/res-ctx.c
> @@ -13,13 +13,12 @@ static int res_ctx_line(struct rd *rd, const char *name, int idx,
>  	char *comm = NULL;
>  	uint32_t ctxn = 0;
>  	uint32_t pid = 0;
> +	SPRINT_BUF(b);
>  
>  	if (!nla_line[RDMA_NLDEV_ATTR_RES_CTXN])
>  		return MNL_CB_ERROR;
>  
>  	if (nla_line[RDMA_NLDEV_ATTR_RES_PID]) {
> -		SPRINT_BUF(b);
> -
>  		pid = mnl_attr_get_u32(nla_line[RDMA_NLDEV_ATTR_RES_PID]);
>  		if (!get_task_name(pid, b, sizeof(b)))
>  			comm = b;
> diff --git a/rdma/res-mr.c b/rdma/res-mr.c
> index fb48d5df..e6c81d11 100644
> --- a/rdma/res-mr.c
> +++ b/rdma/res-mr.c
> @@ -30,6 +30,7 @@ static int res_mr_line(struct rd *rd, const char *name, int idx,
>  	uint32_t pdn = 0;
>  	uint32_t mrn = 0;
>  	uint32_t pid = 0;
> +	SPRINT_BUF(b);
>  
>  	if (!nla_line[RDMA_NLDEV_ATTR_RES_MRLEN])
>  		return MNL_CB_ERROR;
> @@ -47,8 +48,6 @@ static int res_mr_line(struct rd *rd, const char *name, int idx,
>  		goto out;
>  
>  	if (nla_line[RDMA_NLDEV_ATTR_RES_PID]) {
> -		SPRINT_BUF(b);
> -
>  		pid = mnl_attr_get_u32(nla_line[RDMA_NLDEV_ATTR_RES_PID]);
>  		if (!get_task_name(pid, b, sizeof(b)))
>  			comm = b;
> diff --git a/rdma/res-pd.c b/rdma/res-pd.c
> index 66f91f42..0dbb310a 100644
> --- a/rdma/res-pd.c
> +++ b/rdma/res-pd.c
> @@ -16,6 +16,7 @@ static int res_pd_line(struct rd *rd, const char *name, int idx,
>  	uint32_t pid = 0;
>  	uint32_t pdn = 0;
>  	uint64_t users;
> +	SPRINT_BUF(b);
>  
>  	if (!nla_line[RDMA_NLDEV_ATTR_RES_USECNT])
>  		return MNL_CB_ERROR;
> @@ -34,8 +35,6 @@ static int res_pd_line(struct rd *rd, const char *name, int idx,
>  			nla_line[RDMA_NLDEV_ATTR_RES_UNSAFE_GLOBAL_RKEY]);
>  
>  	if (nla_line[RDMA_NLDEV_ATTR_RES_PID]) {
> -		SPRINT_BUF(b);
> -
>  		pid = mnl_attr_get_u32(nla_line[RDMA_NLDEV_ATTR_RES_PID]);
>  		if (!get_task_name(pid, b, sizeof(b)))
>  			comm = b;
> diff --git a/rdma/res-qp.c b/rdma/res-qp.c
> index c180a97e..cd2f4aa2 100644
> --- a/rdma/res-qp.c
> +++ b/rdma/res-qp.c
> @@ -86,6 +86,7 @@ static int res_qp_line(struct rd *rd, const char *name, int idx,
>  	uint32_t port = 0, pid = 0;
>  	uint32_t pdn = 0;
>  	char *comm = NULL;
> +	SPRINT_BUF(b);
>  
>  	if (!nla_line[RDMA_NLDEV_ATTR_RES_LQPN] ||
>  	    !nla_line[RDMA_NLDEV_ATTR_RES_SQ_PSN] ||
> @@ -146,8 +147,6 @@ static int res_qp_line(struct rd *rd, const char *name, int idx,
>  		goto out;
>  
>  	if (nla_line[RDMA_NLDEV_ATTR_RES_PID]) {
> -		SPRINT_BUF(b);
> -
>  		pid = mnl_attr_get_u32(nla_line[RDMA_NLDEV_ATTR_RES_PID]);
>  		if (!get_task_name(pid, b, sizeof(b)))
>  			comm = b;
> diff --git a/rdma/res-srq.c b/rdma/res-srq.c
> index cf9209d7..758bb193 100644
> --- a/rdma/res-srq.c
> +++ b/rdma/res-srq.c
> @@ -183,13 +183,12 @@ static int res_srq_line(struct rd *rd, const char *name, int idx,
>  	char qp_str[MAX_QP_STR_LEN] = {};
>  	char *comm = NULL;
>  	uint8_t type = 0;
> +	SPRINT_BUF(b);
>  
>  	if (!nla_line[RDMA_NLDEV_ATTR_RES_SRQN])
>  		return MNL_CB_ERROR;
>  
>  	if (nla_line[RDMA_NLDEV_ATTR_RES_PID]) {
> -		SPRINT_BUF(b);
> -
>  		pid = mnl_attr_get_u32(nla_line[RDMA_NLDEV_ATTR_RES_PID]);
>  		if (!get_task_name(pid, b, sizeof(b)))
>  			comm = b;
> diff --git a/rdma/stat.c b/rdma/stat.c
> index 3df2c98f..c7dde680 100644
> --- a/rdma/stat.c
> +++ b/rdma/stat.c
> @@ -223,6 +223,7 @@ static int res_counter_line(struct rd *rd, const char *name, int index,
>  	struct nlattr *hwc_table, *qp_table;
>  	struct nlattr *nla_entry;
>  	const char *comm = NULL;
> +	SPRINT_BUF(b);
>  	bool isfirst;
>  	int err;
>  
> @@ -248,8 +249,6 @@ static int res_counter_line(struct rd *rd, const char *name, int index,
>  		return MNL_CB_OK;
>  
>  	if (nla_line[RDMA_NLDEV_ATTR_RES_PID]) {
> -		SPRINT_BUF(b);
> -
>  		pid = mnl_attr_get_u32(nla_line[RDMA_NLDEV_ATTR_RES_PID]);
>  		if (!get_task_name(pid, b, sizeof(b)))
>  			comm = b;

