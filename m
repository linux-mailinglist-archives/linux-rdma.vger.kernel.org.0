Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7799028D666
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Oct 2020 00:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgJMWVS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Oct 2020 18:21:18 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37776 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgJMWVR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 13 Oct 2020 18:21:17 -0400
Received: by mail-pl1-f196.google.com with SMTP id o8so675709pll.4
        for <linux-rdma@vger.kernel.org>; Tue, 13 Oct 2020 15:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GCfIwwEmqcmrGdpmRy+dNGKhXjAJNdKZUgKG0gMSjic=;
        b=E1MmvFG6H64JBn0xt2wsNEZg7c2wKDbAxD3So4zUKuNtmv8Xu82RwrqLmaZMKtK77N
         2XGCIfriV0uYHcyarWekkAf61fBzgYfJfDgI1w+qTI3rwdIZ8/1H38vVyOR/ipE6cLc9
         Fkmi8wMG9v7Myqz/RtbXRHI2bZHP1llxViBpTXQ3SaYdgN5I8PfHG0b4oZjggfYrmsKQ
         gY78PycFSa4Tmnzkopg/IX/l5uVselui/JaX7tdIsll7ETyeqpf45fts4ERNl9SAOhUt
         zjtK+QBiQcUAvC0S6/ksRSGlexzWsiijcxQAPe4tWuZsIr8BcS7qMUIwuw04CqpP4HXw
         5L5w==
X-Gm-Message-State: AOAM53087U7EeYnpL13Vf9k3TcrIjsld2kAC3DxEFdoaDi2cThKFEvxR
        BgwRUJStWYu400tIzWSl+rQ=
X-Google-Smtp-Source: ABdhPJzy3l82XuS3tyQJmermvhuQwnI1YYynencBC4vYQoD+DVYQTO+AC1zLSNX21eKb/5/LYIROLg==
X-Received: by 2002:a17:902:930c:b029:d3:b362:7939 with SMTP id bc12-20020a170902930cb02900d3b3627939mr1584507plb.54.1602627677150;
        Tue, 13 Oct 2020 15:21:17 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5a09:2d7:19f0:1ee0? ([2601:647:4802:9070:5a09:2d7:19f0:1ee0])
        by smtp.gmail.com with ESMTPSA id f17sm694118pfq.141.2020.10.13.15.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 15:21:16 -0700 (PDT)
Subject: Re: [PATCH 1/1] IB/isert: add module param to set sg_tablesize for IO
 cmd
To:     Max Gurtovoy <mgurtovoy@nvidia.com>, krishna2@chelsio.com,
        linux-rdma@vger.kernel.org, jgg@nvidia.com, dledford@redhat.com
Cc:     oren@nvidia.com, maxg@mellanox.com
References: <20201011090608.159333-1-mgurtovoy@nvidia.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <80448269-91b9-7d11-b18d-fc838d72e2ec@grimberg.me>
Date:   Tue, 13 Oct 2020 15:21:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201011090608.159333-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 10/11/20 2:06 AM, Max Gurtovoy wrote:
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

You can add a "Fixes:" tag to help it get to stable.

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

Maybe name it ISCSI_ISER_DEF_SG_TABLESIZE

Otherwise,

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
