Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1DAC677748
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Jan 2023 10:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjAWJTh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Jan 2023 04:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjAWJTe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Jan 2023 04:19:34 -0500
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BFE1F936;
        Mon, 23 Jan 2023 01:19:25 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id f12-20020a7bc8cc000000b003daf6b2f9b9so10081797wml.3;
        Mon, 23 Jan 2023 01:19:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EhF34KjhcigsQ8Sumr9Yw6lq9mbAjHuBdUMpo5UVdls=;
        b=WldooazI5C7QuxJQgC7Wei6itWDc2uK1UTxuu2kR/Y2AUueSgqfosE2kk9AdfyGkUc
         RDbyCUPTOnVuLS2k99DObmqdFtUnG9i9noKnUOA7ZLD7hZnjS3LxftZwVAYuRaNoNlXi
         9OyZt/LG75cR9/czMgd9/8YOzkxSGAy/8itON/ghtYsZ8QH8jLmqjmZhPahYqwwNbkAO
         AXU12rlRRgMesjdlWAcDRsb8B6d0+PFQ+uEm1dOUhzBuTouvvQKAHbMo9eDGODBLczN4
         2TyJaGo7Q2iO0UPB4/kJmjIBWz0UIu2fGLnTxP2HyJ+QnlZeF1KuI6MfqR0ypbYkcayk
         qlWw==
X-Gm-Message-State: AFqh2kqizGep9bu5KNcLpnWH2CumuugT3Zt/trhcRSueB4cIazjZYMKe
        eFi1k4jO0JUu5xUt+09+i18=
X-Google-Smtp-Source: AMrXdXuxTCBhBfo1o3xFl9aH36pUefJwbKNu0A8P2xNSFJqmLGtz0kSX5BJjsks3Zu941pfKJ+hOFw==
X-Received: by 2002:a05:600c:4928:b0:3d9:a5a2:65fa with SMTP id f40-20020a05600c492800b003d9a5a265famr23260832wmp.7.1674465563561;
        Mon, 23 Jan 2023 01:19:23 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b003daff80f16esm13945019wmg.27.2023.01.23.01.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 01:19:23 -0800 (PST)
Message-ID: <909684d4-f169-792b-7f84-ba18a6e19824@grimberg.me>
Date:   Mon, 23 Jan 2023 11:19:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH for-rc] IB/isert: Fix hang in iscsit_wait_for_tag
Content-Language: en-US
To:     Shiraz Saleem <shiraz.saleem@intel.com>, jgg@nvidia.com,
        leon@kernel.org, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org,
        Mike Christie <michael.christie@oracle.com>
Cc:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>
References: <20230119210659.1871-1-shiraz.saleem@intel.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230119210659.1871-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> From: Mustafa Ismail <mustafa.ismail@intel.com>
> 
> Running fio can occasionally cause a hang when sbitmap_queue_get() fails to
> return a tag in iscsit_allocate_cmd() and iscsit_wait_for_tag() is called
> and will never return from the schedule(). This is because the polling
> thread of the CQ is suspended, and will not poll for a SQ completion which
> would free up a tag.
> Fix this by creating a separate CQ for the SQ so that send completions are
> processed on a separate thread and are not blocked when the RQ CQ is
> stalled.
> 
> Fixes: 10e9cbb6b531 ("scsi: target: Convert target drivers to use sbitmap")

Is this the real offending commit? What prevented this from happening
before?

> Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>   drivers/infiniband/ulp/isert/ib_isert.c | 33 +++++++++++++++++++++++----------
>   drivers/infiniband/ulp/isert/ib_isert.h |  3 ++-
>   2 files changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
> index 7540488..f827b91 100644
> --- a/drivers/infiniband/ulp/isert/ib_isert.c
> +++ b/drivers/infiniband/ulp/isert/ib_isert.c
> @@ -109,19 +109,27 @@ static int isert_sg_tablesize_set(const char *val, const struct kernel_param *kp
>   	struct ib_qp_init_attr attr;
>   	int ret, factor;
>   
> -	isert_conn->cq = ib_cq_pool_get(ib_dev, cq_size, -1, IB_POLL_WORKQUEUE);
> -	if (IS_ERR(isert_conn->cq)) {
> -		isert_err("Unable to allocate cq\n");
> -		ret = PTR_ERR(isert_conn->cq);
> +	isert_conn->snd_cq = ib_cq_pool_get(ib_dev, cq_size, -1,
> +					    IB_POLL_WORKQUEUE);
> +	if (IS_ERR(isert_conn->snd_cq)) {
> +		isert_err("Unable to allocate send cq\n");
> +		ret = PTR_ERR(isert_conn->snd_cq);
>   		return ERR_PTR(ret);
>   	}
> +	isert_conn->rcv_cq = ib_cq_pool_get(ib_dev, cq_size, -1,
> +					    IB_POLL_WORKQUEUE);
> +	if (IS_ERR(isert_conn->rcv_cq)) {
> +		isert_err("Unable to allocate receive cq\n");
> +		ret = PTR_ERR(isert_conn->rcv_cq);
> +		goto create_cq_err;
> +	}

Does this have any noticeable performance implications?

Also I wander if there are any other assumptions in the code
for having a single context processing completions...

It'd be much easier if iscsi_allocate_cmd could accept
a timeout to fail...

CCing target-devel and Mike.

