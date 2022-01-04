Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A91483C19
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jan 2022 08:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiADHAF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jan 2022 02:00:05 -0500
Received: from out0.migadu.com ([94.23.1.103]:23246 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233043AbiADHAF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Jan 2022 02:00:05 -0500
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1641279604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jv67uNF4jcDSGj8iV6+GARuFSCNDUTCK4ZZPS14RKQM=;
        b=EUKGsDe73FjAMDNIl7omA2JC1S15hMx3mbah3SXSIM9rXlCXl11qufggOWJpdrx2aQDcDY
        dAnqWq9XBZqh6HONeBoX3lL2JDKpXvbIMRgcJTU03coXRrRsvYzyD6iWcSj0wZv8C247Ca
        vYs2ENo90zDyjhvLvLTCBDz+Q2jaxK4=
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: [PATCHv2 for-next 4/5] RDMA/rtrs-srv: Rename rtrs_srv to
 rtrs_srv_sess
To:     Jack Wang <jinpu.wang@ionos.com>, linux-rdma@vger.kernel.org
Cc:     bvanassche@acm.org, leon@kernel.org, jgg@ziepe.ca,
        haris.iqbal@ionos.com,
        Vaishali Thakkar <vaishali.thakkar@ionos.com>
References: <20220103133339.9483-1-jinpu.wang@ionos.com>
 <20220103133339.9483-5-jinpu.wang@ionos.com>
Message-ID: <21f09494-6b5b-087e-f312-0d4b1faf5f44@linux.dev>
Date:   Tue, 4 Jan 2022 14:59:57 +0800
MIME-Version: 1.0
In-Reply-To: <20220103133339.9483-5-jinpu.wang@ionos.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 1/3/22 9:33 PM, Jack Wang wrote:
> diff --git a/drivers/block/rnbd/rnbd-srv.h b/drivers/block/rnbd/rnbd-srv.h
> index 98ddc31eb408..e5604bce123a 100644
> --- a/drivers/block/rnbd/rnbd-srv.h
> +++ b/drivers/block/rnbd/rnbd-srv.h
> @@ -20,7 +20,7 @@
>   struct rnbd_srv_session {
>   	/* Entry inside global sess_list */
>   	struct list_head        list;
> -	struct rtrs_srv		*rtrs;
> +	struct rtrs_srv_sess	*rtrs;

How about change it to srv_sess?

>   	char			sessname[NAME_MAX];
>   	int			queue_depth;
>   	struct bio_set		sess_bio_set;
> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> index 628ef20ebf0c..b94ae12c2795 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv-sysfs.c
> @@ -154,7 +154,7 @@ static const struct attribute_group rtrs_srv_stats_attr_group = {
>   
>   static int rtrs_srv_create_once_sysfs_root_folders(struct rtrs_srv_path *srv_path)
>   {
> -	struct rtrs_srv *srv = srv_path->srv;
> +	struct rtrs_srv_sess *srv = srv_path->srv;

It is srv here, maybe srv_sess too, FYI.

[ ... ]

> diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.h b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> index 6119e6708080..6292e87f6afd 100644
> --- a/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> +++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.h
> @@ -73,7 +73,7 @@ struct rtrs_srv_mr {
>   
>   struct rtrs_srv_path {
>   	struct rtrs_path	s;
> -	struct rtrs_srv	*srv;
> +	struct rtrs_srv_sess	*srv;

Ditto.

Thanks,
Guoqing
