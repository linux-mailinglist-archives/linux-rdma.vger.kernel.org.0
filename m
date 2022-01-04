Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C0F483C25
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 08:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbiADHKA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 02:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiADHJ7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jan 2022 02:09:59 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6345DC061761
        for <linux-rdma@vger.kernel.org>; Mon,  3 Jan 2022 23:09:59 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1641280196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1P/cKhngnL10m8GGc4v0rKq3ocbYu1g/ieOyqa/1jaQ=;
        b=nIkRLtCygJbssgRbz6mxDAl9GKoGXGG6ZD9T95weIefPwrrxMC/kQtfxrSZVDP2Xk7fEhc
        TYRHkFrwj5a1wPr7AcEoW8nYbL/8oVZUUicCFwhfN8w1WU2gxOs7G2NFRaZgHo+LvYzf5Y
        2OO9o7RiBO3+yM+xLgwfuyKsHyaQ0QU=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCHv2 for-next 5/5] RDMA/rtrs-clt: Rename rtrs_clt to
 rtrs_clt_sess
To:     Jack Wang <jinpu.wang@ionos.com>, linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com,
        Vaishali Thakkar <vaishali.thakkar@ionos.com>
References: <20220103133339.9483-1-jinpu.wang@ionos.com>
 <20220103133339.9483-6-jinpu.wang@ionos.com>
Message-ID: <c6289d43-1593-39c8-2869-2098ec3defd0@linux.dev>
Date:   Tue, 4 Jan 2022 15:09:47 +0800
MIME-Version: 1.0
In-Reply-To: <20220103133339.9483-6-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 1/3/22 9:33 PM, Jack Wang wrote:
> From: Vaishali Thakkar<vaishali.thakkar@ionos.com>
>
> Structure rtrs_clt is used for sessions. So to
> avoid confusions rename it to rtrs_clt_sess.
>
> Transformations are done with the help of
> following coccinelle script.
>
> @@
> @@
> struct
> - rtrs_clt
> + rtrs_clt_sess
>
> Signed-off-by: Vaishali Thakkar<vaishali.thakkar@ionos.com>
> Signed-off-by: Jack Wang<jinpu.wang@ionos.com>
> ---
>   drivers/block/rnbd/rnbd-clt.c                |  4 +-
>   drivers/block/rnbd/rnbd-clt.h                |  2 +-
>   drivers/infiniband/ulp/rtrs/rtrs-clt-sysfs.c | 24 +++---
>   drivers/infiniband/ulp/rtrs/rtrs-clt.c       | 78 ++++++++++----------
>   drivers/infiniband/ulp/rtrs/rtrs-clt.h       | 19 ++---
>   drivers/infiniband/ulp/rtrs/rtrs.h           | 21 +++---
>   6 files changed, 77 insertions(+), 71 deletions(-)
>
> diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
> index 2df0657cdf00..70bbbdb81db1 100644
> --- a/drivers/block/rnbd/rnbd-clt.c
> +++ b/drivers/block/rnbd/rnbd-clt.c
> @@ -433,7 +433,7 @@ static void msg_conf(void *priv, int errno)
>   	schedule_work(&iu->work);
>   }
>   
> -static int send_usr_msg(struct rtrs_clt *rtrs, int dir,
> +static int send_usr_msg(struct rtrs_clt_sess *rtrs, int dir,
>   			struct rnbd_iu *iu, struct kvec *vec,
>   			size_t len, struct scatterlist *sg, unsigned int sg_len,
>   			void (*conf)(struct work_struct *work),
> @@ -1010,7 +1010,7 @@ static int rnbd_client_xfer_request(struct rnbd_clt_dev *dev,
>   				     struct request *rq,
>   				     struct rnbd_iu *iu)
>   {
> -	struct rtrs_clt *rtrs = dev->sess->rtrs;
> +	struct rtrs_clt_sess *rtrs = dev->sess->rtrs;
>   	struct rtrs_permit *permit = iu->permit;
>   	struct rnbd_msg_io msg;
>   	struct rtrs_clt_req_ops req_ops;
> diff --git a/drivers/block/rnbd/rnbd-clt.h b/drivers/block/rnbd/rnbd-clt.h
> index 9ef8c4f306f2..0c2cae7f39b9 100644
> --- a/drivers/block/rnbd/rnbd-clt.h
> +++ b/drivers/block/rnbd/rnbd-clt.h
> @@ -75,7 +75,7 @@ struct rnbd_cpu_qlist {
>   
>   struct rnbd_clt_session {
>   	struct list_head        list;
> -	struct rtrs_clt        *rtrs;
> +	struct rtrs_clt_sess        *rtrs;

While at it, how about change it to clt_sess? Otherwise there is symbol name
pollution between rnbd_clt_session and rnbd_srv_session.

[ ...]

>   		/*
> @@ -743,7 +744,7 @@ static int post_recv_path(struct rtrs_clt_path *clt_path)
>   struct path_it {
>   	int i;
>   	struct list_head skip_list;
> -	struct rtrs_clt *clt;
> +	struct rtrs_clt_sess *clt;

To align with the change of type, s/clt/clt_sess? If so, it applies to 
others as well.

[ ... ]

> --- a/drivers/infiniband/ulp/rtrs/rtrs-clt.h
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.h
> @@ -126,7 +126,7 @@ struct rtrs_rbuf {
>   
>   struct rtrs_clt_path {
>   	struct rtrs_path	s;
> -	struct rtrs_clt	*clt;
> +	struct rtrs_clt_sess	**clt*;

Ditto.

[ ... ]

> -struct rtrs_clt *rtrs_clt_open(struct rtrs_clt_ops *ops,
> +struct rtrs_clt_sess *rtrs_clt_open(struct rtrs_clt_ops *ops,
>   				 const char *pathname,
>   				 const struct rtrs_addr *paths,
>   				 size_t path_cnt, u16 port,
>   				 size_t pdu_sz, u8 reconnect_delay_sec,
>   				 s16 max_reconnect_attempts, u32 nr_poll_queues);
>   
> -void rtrs_clt_close(struct rtrs_clt *clt_path);
> +void rtrs_clt_close(struct rtrs_clt_sess *clt_path);

void rtrs_clt_close(struct rtrs_clt_sess *clt_sess);

or

void rtrs_clt_close(struct rtrs_clt_path *clt_path);


Maybe rename those functions to rtrs_clt_session_{open,close} to resolve 
the ambiguous
completely, or we can live with current name I am not sure.

BTW, I suppose the series deserve beer from Danil 😉

Thanks,
Guoqing

