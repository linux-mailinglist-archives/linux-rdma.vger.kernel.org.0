Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EE9575376
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jul 2022 18:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbiGNQyk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jul 2022 12:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiGNQyL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jul 2022 12:54:11 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FF9481D4
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 09:54:10 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id j3so3067388oif.8
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 09:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=R76bv1QbmBxpKls9nXFBwARku0Dh0AFnIQbIDxmge0c=;
        b=cY4M2lxFUteagG4x3JJyrHttoJi+FthKvHZr7xqmOc4QhkaaY2BQ70l9Zx1OEUA8pw
         08wm8aBT236iF9Rp/0hIXjg/V4CVwNKPsW59U2+JnZtinMIUXWxr+tzUE37XBjnLm0XM
         inEKChUtlItaqmUiMmdV9aRn+kSn3Ey96A0g4BPhxtEuqTsapO0+TYa/Kw/4spMteicO
         B8snuLFoQyaBlvzy2hqFuClQA9OFsmEKHzzzJWxZ3dr7HRa0/ygC4FmJI0m04YkS2Qpl
         EQ+oXmK+yoQgxu+O7wQ9hGTzqF2KCd4gvufVrl+jaF4ZIWxc3RPsY4rlo8sfKKipuOBk
         1QIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R76bv1QbmBxpKls9nXFBwARku0Dh0AFnIQbIDxmge0c=;
        b=S5w6HsYR99cV/YICVPB/LfgnS1nIpmMpw3uu6dDv7RDwRhOL2h/FOBLw2VKtDvJWOM
         t9OemnUD4FYWKtOjihAy/6gPdAmSmLb09IYYk42vWJgaq7oyaLiPD/nyVcOiv4HIwhuZ
         kRrLJmZhSZUunBXjXNp7AjO6XcyIw9k0j40QlR+gH809wc6s6Dl7I9ZBZOtpCsP4o1eu
         34WJIPBCPU3J4XyCYCfw3YCMA6gkTGokK+BagI4WguwTtk1+BJJrqOpztbu6K7N8rNWJ
         oBWCiQsQ/6KOyW1WZO6YLWYi92IVdwRVqAPp9+ubBOS3zFn+z7maXPwKKSab3cqV/IJw
         CaNg==
X-Gm-Message-State: AJIora9gCLQpQwX/xim20qd76/kmsbwV1Torh5Wj6/VxgjwuAd+EVUt5
        FJ0gKCDCdd9idcGSZ+tOPdQ=
X-Google-Smtp-Source: AGRyM1tMGgXVK+OPc6eq1vMg0hU7W+XWfsyUXHJSEtY+1DmHN3dIPmDMJTAr7knEEs/V90kMJeHTWw==
X-Received: by 2002:a05:6808:1a2a:b0:33a:381:c5 with SMTP id bk42-20020a0568081a2a00b0033a038100c5mr7957251oib.9.1657817650198;
        Thu, 14 Jul 2022 09:54:10 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:e02a:9936:8f26:4598? (2603-8081-140c-1a00-e02a-9936-8f26-4598.res6.spectrum.com. [2603:8081:140c:1a00:e02a:9936:8f26:4598])
        by smtp.gmail.com with ESMTPSA id 2-20020a9d0002000000b0061c24cd628bsm864581ota.7.2022.07.14.09.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 09:54:09 -0700 (PDT)
Message-ID: <2faee762-d9d4-f2d0-30ae-cade450d6f71@gmail.com>
Date:   Thu, 14 Jul 2022 11:54:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv2 1/1] RDMA/rxe: Fix qp error handler
Content-Language: en-US
To:     yanjun.zhu@linux.dev, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com
References: <20220710043709.707649-1-yanjun.zhu@linux.dev>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220710043709.707649-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/9/22 23:37, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> About 7 spin locks in qp creation needs to be initialized. Now these
> spin locks are initialized in the function rxe_qp_init_misc. This
> will avoid the error "initialize spin locks before use".
> 
> Reported-by: syzbot+833061116fa28df97f3b@syzkaller.appspotmail.com
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c   | 12 ++++++++----
>  drivers/infiniband/sw/rxe/rxe_task.c |  1 -
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index 8355a5b1cb60..259d8bb15116 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -172,6 +172,14 @@ static void rxe_qp_init_misc(struct rxe_dev *rxe, struct rxe_qp *qp,
>  
>  	spin_lock_init(&qp->state_lock);
>  
> +	spin_lock_init(&qp->req.task.state_lock);
> +	spin_lock_init(&qp->resp.task.state_lock);
> +	spin_lock_init(&qp->comp.task.state_lock);
> +
> +	spin_lock_init(&qp->sq.sq_lock);
> +	spin_lock_init(&qp->rq.producer_lock);
> +	spin_lock_init(&qp->rq.consumer_lock);
> +
>  	atomic_set(&qp->ssn, 0);
>  	atomic_set(&qp->skb_out, 0);
>  }
> @@ -231,7 +239,6 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>  	qp->req.opcode		= -1;
>  	qp->comp.opcode		= -1;
>  
> -	spin_lock_init(&qp->sq.sq_lock);
>  	skb_queue_head_init(&qp->req_pkts);
>  
>  	rxe_init_task(rxe, &qp->req.task, qp,
> @@ -282,9 +289,6 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
>  		}
>  	}
>  
> -	spin_lock_init(&qp->rq.producer_lock);
> -	spin_lock_init(&qp->rq.consumer_lock);
> -
>  	skb_queue_head_init(&qp->resp_pkts);
>  
>  	rxe_init_task(rxe, &qp->resp.task, qp,
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
> index 0c4db5bb17d7..77c691570673 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.c
> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> @@ -98,7 +98,6 @@ int rxe_init_task(void *obj, struct rxe_task *task,
>  	tasklet_setup(&task->tasklet, rxe_do_task);
>  
>  	task->state = TASK_STATE_START;
> -	spin_lock_init(&task->state_lock);
>  
>  	return 0;
>  }

Zhu,

The task.state_lock spinlocks are an implementation detail of the tasklet code. Seems strange to
move the spin_lock_init() calls up into the qp code for these. This breaks encapsulation. We (HPE)
have a patch coming that extends the tasklet code to support tasklets and/or work queues which allow
steering the work to specific cpus. This gives a significant performance boost for IO intensive
work flows.

The only other issue with this patch is that for xrc QPs, which we don't support yet, the QPs only
have one side implemented and there won't be a reason to do unneeded work. Not a big issue though.

Bob 
