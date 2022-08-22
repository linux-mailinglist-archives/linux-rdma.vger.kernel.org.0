Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB5F59C7DB
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Aug 2022 21:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbiHVTG7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Aug 2022 15:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237405AbiHVTG6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Aug 2022 15:06:58 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A5A13F92
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 12:06:57 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-11d2dcc31dbso5911350fac.7
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 12:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=3xKgXW92RMYKXBX71BVmDk5m0O+xSB5xRVw7sY92njs=;
        b=MHHJ4N6T6YhFRipS7o2ooHn3T4Y2dzJMgM9tVot1kdnuZtY6mugA305skvTVQJ6+L/
         FaNJWPqeFDWSYH6UmmjL3CIYhVROoDzLYegWEyaKPDoVRXQ298UabgM+CkVmvCnmkJ6i
         hUKjWzX1g5T9+lBk38dAPWv7RlwR6DJALPpFBXJabUd30cRDbt6Z5zPxI3HC8KIVIANJ
         qjc79CUvQUEjv1cQtYq31/sQKL1yBX9cs9lK3E9r1RWB3s90v9dgr2Cq1v+4vlVr6MCi
         Yd0/W/ErCd45ZPOj8+D9id1+mW+82z9KdTIPRtiEuTOJXQo0ysU3ULs8yZQ0Lmqdzn0N
         ORZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=3xKgXW92RMYKXBX71BVmDk5m0O+xSB5xRVw7sY92njs=;
        b=MyFvE7AoBTDm4EkliU4BwTekbJA9pWEwO6kftI/daWqdQG8H8529UKOgZnUrGYT/qQ
         ZfWEcrUqGJgcikHbPTBKuhJs4OEomCgSRceXJOuAFlAOhEvK3tbf2W9KjP2GhjVzb4CD
         BapbF4pxRVlU6+RwzMHncvCjT3iSpUeKK5tp1qEIGv5ZyD/o8On8Rf4IknYm6KTXw4sR
         PiimwcsV1hf8OTAk7knBoPYAviH6FU0F9XmIc6zIy+r0p+zYgUhs7ukd2edpvOAhtShv
         6LCMIysHTa9IoxypoUpWHySdmta0e+mYjGp0uICsbSl90zjQWTlKmlYhNyxaicAiHh1J
         Y9mA==
X-Gm-Message-State: ACgBeo0c9vs9WIQeiPQtxcW2Thlz8HD+F4A/cT7v/8HAQR75vy9hGu91
        FZRoC2cT3DjrZ3DSkSBBZWs=
X-Google-Smtp-Source: AA6agR4Uios6vectqzWesX8Au4Yf8CHDnQcs8LwasM7L7s3IPGhIi+M8pSYfHjPUZCfEFomx6rrDdQ==
X-Received: by 2002:a05:6870:3449:b0:11d:1e78:266c with SMTP id i9-20020a056870344900b0011d1e78266cmr4760173oah.122.1661195216831;
        Mon, 22 Aug 2022 12:06:56 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:fd1d:d13f:3b8b:5104? (2603-8081-140c-1a00-fd1d-d13f-3b8b-5104.res6.spectrum.com. [2603:8081:140c:1a00:fd1d:d13f:3b8b:5104])
        by smtp.gmail.com with ESMTPSA id a26-20020a9d6e9a000000b00638ef9bb847sm3042922otr.79.2022.08.22.12.06.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 12:06:56 -0700 (PDT)
Message-ID: <8d5fb124-c2fc-c191-3786-a243977774a8@gmail.com>
Date:   Mon, 22 Aug 2022 14:06:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 3/3] RDMA/rxe: Remove the unused variable obj
Content-Language: en-US
To:     yanjun.zhu@linux.dev, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com
References: <20220822011615.805603-1-yanjun.zhu@linux.dev>
 <20220822011615.805603-4-yanjun.zhu@linux.dev>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220822011615.805603-4-yanjun.zhu@linux.dev>
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

On 8/21/22 20:16, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> The member variable obj in struct rxe_task is not needed.
> So remove it to save memory.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c   | 6 +++---
>  drivers/infiniband/sw/rxe/rxe_task.c | 3 +--
>  drivers/infiniband/sw/rxe/rxe_task.h | 3 +--
>  3 files changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index b229052ae91a..ee4f7a4a7e01 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -242,9 +242,9 @@ static int rxe_qp_init_req(struct rxe_dev *rxe, struct rxe_qp *qp,
>  
>  	skb_queue_head_init(&qp->req_pkts);
>  
> -	rxe_init_task(rxe, &qp->req.task, qp,
> +	rxe_init_task(&qp->req.task, qp,
>  		      rxe_requester, "req");
> -	rxe_init_task(rxe, &qp->comp.task, qp,
> +	rxe_init_task(&qp->comp.task, qp,
>  		      rxe_completer, "comp");
>  
>  	qp->qp_timeout_jiffies = 0; /* Can't be set for UD/UC in modify_qp */
> @@ -292,7 +292,7 @@ static int rxe_qp_init_resp(struct rxe_dev *rxe, struct rxe_qp *qp,
>  
>  	skb_queue_head_init(&qp->resp_pkts);
>  
> -	rxe_init_task(rxe, &qp->resp.task, qp,
> +	rxe_init_task(&qp->resp.task, qp,
>  		      rxe_responder, "resp");
>  
>  	qp->resp.opcode		= OPCODE_NONE;
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
> index 2248cf33d776..ec2b7de1c497 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.c
> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> @@ -94,10 +94,9 @@ void rxe_do_task(struct tasklet_struct *t)
>  	task->ret = ret;
>  }
>  
> -int rxe_init_task(void *obj, struct rxe_task *task,
> +int rxe_init_task(struct rxe_task *task,
>  		  void *arg, int (*func)(void *), char *name)
>  {
> -	task->obj	= obj;
>  	task->arg	= arg;
>  	task->func	= func;
>  	snprintf(task->name, sizeof(task->name), "%s", name);
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
> index 11d183fd3338..7f612a1c68a7 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.h
> +++ b/drivers/infiniband/sw/rxe/rxe_task.h
> @@ -19,7 +19,6 @@ enum {
>   * called again.
>   */
>  struct rxe_task {
> -	void			*obj;
>  	struct tasklet_struct	tasklet;
>  	int			state;
>  	spinlock_t		state_lock; /* spinlock for task state */
> @@ -35,7 +34,7 @@ struct rxe_task {
>   *	arg  => parameter to pass to fcn
>   *	func => function to call until it returns != 0
>   */
> -int rxe_init_task(void *obj, struct rxe_task *task,
> +int rxe_init_task(struct rxe_task *task,
>  		  void *arg, int (*func)(void *), char *name);
>  
>  /* cleanup task */

Looks OK to me. Not sure why that was ever there.

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
