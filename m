Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F8F28D33D
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Oct 2020 19:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgJMRnS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Oct 2020 13:43:18 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12829 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgJMRnR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Oct 2020 13:43:17 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f85e6f90001>; Tue, 13 Oct 2020 10:42:17 -0700
Received: from [172.27.0.178] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 13 Oct
 2020 17:43:06 +0000
Subject: Re: [PATCH 1/1] IB/isert: add module param to set sg_tablesize for IO
 cmd
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <sagi@grimberg.me>, <krishna2@chelsio.com>,
        <linux-rdma@vger.kernel.org>, <jgg@nvidia.com>,
        <dledford@redhat.com>
CC:     <oren@nvidia.com>, <maxg@mellanox.com>
References: <20201011090608.159333-1-mgurtovoy@nvidia.com>
Message-ID: <1d4f4c66-5c87-c2c2-c45b-6ab6a30481ea@nvidia.com>
Date:   Tue, 13 Oct 2020 20:43:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201011090608.159333-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1602610937; bh=6vx46N7wL665Tjpk0ZYJfj+xh77D8BIsWmXCUYMsJuA=;
        h=Subject:From:To:CC:References:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=FQ91MZ/SFCo9Ss+J1wvD4e/sNUib/0lTfO7ydQmuiPLqBEHxxw/RaV2hWy+es0W1V
         mkqiQZjDuuN1PL7hb88HYffmwMHqYO3iMhuxEdl4OPokh8lZDo0hLM6VQNYJwgYXgM
         AZ0l7Mih59GxFTc33U3A19P7l5xNx1AJiSkqm4zBjIjMufX0Y5KLTMGHuOnMWchhnN
         OQY1U6vecxvMdGjm3T72khr/IoSxN7V6sKc+0tqgjtdAzGpBBk3qJ77jXGk4TvQx46
         MdPx/uhxWLIHkr8tW99PniLc8nAmY/Kolm26Xtqz7WmwRJDOt1xLMxWKYPzwHFFTrN
         am2Bdd8fiulXw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Krishna,

did this patch fix the issue you reported ?


On 10/11/2020 12:06 PM, Max Gurtovoy wrote:
> From: Max Gurtovoy <maxg@mellanox.com>
>
> Currently, iser target support max IO size of 16MiB by default. For some
> adapters, allocating this amount of resources might reduce the total
> number of possible connections that can be created. For those adapters,
> it's preferred to reduce the max IO size to be able to create more
> connections. Since there is no handshake procedure for max IO size in
> iser protocol, set the default max IO size to 1MiB and add a module
> parameter for enabling the option to control it for suitable adapters.
>
> Reported-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> ---
>   drivers/infiniband/ulp/isert/ib_isert.c | 27 ++++++++++++++++++++++++-
>   drivers/infiniband/ulp/isert/ib_isert.h |  6 ++++++
>   2 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
> index 695f701dc43d..5a47f1bbca96 100644
> --- a/drivers/infiniband/ulp/isert/ib_isert.c
> +++ b/drivers/infiniband/ulp/isert/ib_isert.c
> @@ -28,6 +28,18 @@ static int isert_debug_level;
>   module_param_named(debug_level, isert_debug_level, int, 0644);
>   MODULE_PARM_DESC(debug_level, "Enable debug tracing if > 0 (default:0)");
>   
> +static int isert_sg_tablesize_set(const char *val,
> +				  const struct kernel_param *kp);
> +static const struct kernel_param_ops sg_tablesize_ops = {
> +	.set = isert_sg_tablesize_set,
> +	.get = param_get_int,
> +};
> +
> +static int isert_sg_tablesize = ISCSI_ISER_SG_TABLESIZE;
> +module_param_cb(sg_tablesize, &sg_tablesize_ops, &isert_sg_tablesize, 0644);
> +MODULE_PARM_DESC(sg_tablesize,
> +		 "Number of gather/scatter entries in a single scsi command, should >= 128 (default: 256, max: 4096)");
> +
>   static DEFINE_MUTEX(device_list_mutex);
>   static LIST_HEAD(device_list);
>   static struct workqueue_struct *isert_comp_wq;
> @@ -47,6 +59,19 @@ static void isert_send_done(struct ib_cq *cq, struct ib_wc *wc);
>   static void isert_login_recv_done(struct ib_cq *cq, struct ib_wc *wc);
>   static void isert_login_send_done(struct ib_cq *cq, struct ib_wc *wc);
>   
> +static int isert_sg_tablesize_set(const char *val, const struct kernel_param *kp)
> +{
> +	int n = 0, ret;
> +
> +	ret = kstrtoint(val, 10, &n);
> +	if (ret != 0 || n < ISCSI_ISER_MIN_SG_TABLESIZE ||
> +	    n > ISCSI_ISER_MAX_SG_TABLESIZE)
> +		return -EINVAL;
> +
> +	return param_set_int(val, kp);
> +}
> +
> +
>   static inline bool
>   isert_prot_cmd(struct isert_conn *conn, struct se_cmd *cmd)
>   {
> @@ -101,7 +126,7 @@ isert_create_qp(struct isert_conn *isert_conn,
>   	attr.cap.max_send_wr = ISERT_QP_MAX_REQ_DTOS + 1;
>   	attr.cap.max_recv_wr = ISERT_QP_MAX_RECV_DTOS + 1;
>   	factor = rdma_rw_mr_factor(device->ib_device, cma_id->port_num,
> -				   ISCSI_ISER_MAX_SG_TABLESIZE);
> +				   isert_sg_tablesize);
>   	attr.cap.max_rdma_ctxs = ISCSI_DEF_XMIT_CMDS_MAX * factor;
>   	attr.cap.max_send_sge = device->ib_device->attrs.max_send_sge;
>   	attr.cap.max_recv_sge = 1;
> diff --git a/drivers/infiniband/ulp/isert/ib_isert.h b/drivers/infiniband/ulp/isert/ib_isert.h
> index 7fee4a65e181..90ef215bf755 100644
> --- a/drivers/infiniband/ulp/isert/ib_isert.h
> +++ b/drivers/infiniband/ulp/isert/ib_isert.h
> @@ -65,6 +65,12 @@
>    */
>   #define ISER_RX_SIZE		(ISCSI_DEF_MAX_RECV_SEG_LEN + 1024)
>   
> +/* Default I/O size is 1MB */
> +#define ISCSI_ISER_SG_TABLESIZE 256
> +
> +/* Minimum I/O size is 512KB */
> +#define ISCSI_ISER_MIN_SG_TABLESIZE 128
> +
>   /* Maximum support is 16MB I/O size */
>   #define ISCSI_ISER_MAX_SG_TABLESIZE	4096
>   
