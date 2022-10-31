Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778C4613B51
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Oct 2022 17:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiJaQcG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Oct 2022 12:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbiJaQcF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Oct 2022 12:32:05 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B726212761;
        Mon, 31 Oct 2022 09:32:04 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso16384790pjg.5;
        Mon, 31 Oct 2022 09:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oqq3jqLTWRS4cM2iifoZtLovQibgnAW+PBZWmfixbMM=;
        b=7YV15WtWhgSmzXdfYyg9l+Y5J0l2em+qi34mWo9rH6q3pXzUnFvUFdnUEQv4NWt4eJ
         v5Nqw1IqSd3fSKdSeP4iPcthGoeiTEpKp9GWjNj8cIfObVMrr/ZWF+aiv3di4RFAo8xd
         bJ0h7UYKz8/TXqs+gjwUJsJArsPZF3meOMl89dPZBUoN92kF05DRAC4TkGTXnaUb4e1p
         E+WYMQxGBZjksaJ0F7aUf591g56GNxeFJuSCa/0Honl+70WioxwRpkLiw4d+oXcntzzr
         zC/uHzytnjbCxBKbjuj0JxoMUKgtXjmXma0KhtPdSFCKTaCaAelwDQS4EldM0dE15uT/
         I/HA==
X-Gm-Message-State: ACrzQf01B2sRLXRVfr14iFYl57SfLoWFhumkctOUPVMppmtYAPJAIoew
        zZREnEwi/Q6TtFuB055K0tU=
X-Google-Smtp-Source: AMsMyM6TS5ZL5TaM1SaOfdHUtz0N7r9Ae3RiNzHWf2h7Z2RKFD1mMOf3CZraVgWmobJCwn9WSMjPmg==
X-Received: by 2002:a17:902:64c1:b0:186:827e:a0da with SMTP id y1-20020a17090264c100b00186827ea0damr15401249pli.94.1667233923736;
        Mon, 31 Oct 2022 09:32:03 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:f781:cff2:5c46:49bd? ([2620:15c:211:201:f781:cff2:5c46:49bd])
        by smtp.gmail.com with ESMTPSA id o8-20020a1709026b0800b00172ea8ff334sm4696343plk.7.2022.10.31.09.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 09:32:01 -0700 (PDT)
Message-ID: <b406b5d8-284d-2af3-e37b-44fadd4fb34c@acm.org>
Date:   Mon, 31 Oct 2022 09:32:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] RDMA/srp (gcc13): force int types for max_send_sge and
 can_queue
Content-Language: en-US
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Martin Liska <mliska@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
References: <20221031114506.10501-1-jirislaby@kernel.org>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221031114506.10501-1-jirislaby@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 10/31/22 04:45, Jiri Slaby (SUSE) wrote:
> Since gcc13, each member of an enum has the same type as the enum [1]. And
> that is inherited from its members. Provided "SRP_TAG_TSK_MGMT = 1U << 31",
> SRP_MAX_SGE and SRP_TSK_MGMT_SQ_SIZE are unsigned ints.
> 
> This results in the following warnings:
>    include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast
>    drivers/infiniband/ulp/srp/ib_srp.c:563:42: note: in expansion of macro 'min'
> 
>    include/linux/minmax.h:20:35: error: comparison of distinct pointer types lacks a cast
>    drivers/infiniband/ulp/srp/ib_srp.c:2369:27: note: in expansion of macro 'min'
> 
> Force the use of min_t() instead of min() to use int for all those, as
> this is what both targets
>    target->scsi_host->can_queue
> and
>    init_attr->cap.max_send_sge
> are.
> 
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=36113
> 
> Cc: Martin Liska <mliska@suse.cz>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> ---
>   drivers/infiniband/ulp/srp/ib_srp.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/ulp/srp/ib_srp.c b/drivers/infiniband/ulp/srp/ib_srp.c
> index 1075c2ac8fe2..7db487da8293 100644
> --- a/drivers/infiniband/ulp/srp/ib_srp.c
> +++ b/drivers/infiniband/ulp/srp/ib_srp.c
> @@ -560,7 +560,8 @@ static int srp_create_ch_ib(struct srp_rdma_ch *ch)
>   	init_attr->cap.max_send_wr     = m * target->queue_size;
>   	init_attr->cap.max_recv_wr     = target->queue_size + 1;
>   	init_attr->cap.max_recv_sge    = 1;
> -	init_attr->cap.max_send_sge    = min(SRP_MAX_SGE, attr->max_send_sge);
> +	init_attr->cap.max_send_sge    = min_t(int, SRP_MAX_SGE,
> +			attr->max_send_sge);
>   	init_attr->sq_sig_type         = IB_SIGNAL_REQ_WR;
>   	init_attr->qp_type             = IB_QPT_RC;
>   	init_attr->send_cq             = send_cq;
> @@ -2366,7 +2367,7 @@ static void srp_cm_rep_handler(struct ib_cm_id *cm_id,
>   		 * bounce requests back to the SCSI mid-layer.
>   		 */
>   		target->scsi_host->can_queue
> -			= min(ch->req_lim - SRP_TSK_MGMT_SQ_SIZE,
> +			= min_t(int, ch->req_lim - SRP_TSK_MGMT_SQ_SIZE,
>   			      target->scsi_host->can_queue);
>   		target->scsi_host->cmd_per_lun
>   			= min_t(int, target->scsi_host->can_queue,

I don't like this patch because it changes min() into min_t(). The 
former checks its arguments types while the latter uses casts and hence 
ignores most information that is present in the argument types. Please 
split the enum in ib_srp.h instead of changing min() into min_t().

Thanks,

Bart.
