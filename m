Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986876CF2D8
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 21:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjC2TPe (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 15:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjC2TPd (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 15:15:33 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A9440C8
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 12:15:32 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id a30-20020a9d3e1e000000b006a13f728172so5599150otd.3
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 12:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680117331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FwWsdyn4cpTk0docVOVkziAB637spOiTSdQco97TrDc=;
        b=gSgmRxTGbg8JL+hYPyJ/AO6iB52MUpeN1WGnMM+U3lsY0jFbefv6WjnC2aNFdTVfzs
         udc88T4wEOL8P6xMKcVg4KkBnpvwK5mpm2r6c/x5M5M4Fjv8H6VQngIYys2QXgNOnYY1
         IKrat0neVkCYCFWz8CMzd2yrIqAL30GOH4e7cafBKM33ddyUwA50fLgHRvaXAgyeq1CY
         YL7lN4rihhfFcVs/n6XP32zl9mM4GxsXxL1u+8miPjT5zP8KlNN6RbZoeUJ4oL6VNpMA
         I628m4BsnqD4fXbIjgtIgvnrdl6YZt9YnsBzf2V1NrUULMKjcFmjH6LHzT+l80UeQPTm
         jsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680117332;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwWsdyn4cpTk0docVOVkziAB637spOiTSdQco97TrDc=;
        b=ibENQLIOggpwm2hu/HNX0GP+fszp4936pfBguf2hYTBwfBVOgndN8T/B22qc4pMLtG
         wPqRcys8I7rvYC6NZF0EyZenRwDDzjec5eyjae1cwN05uTbP0B6P8KS1AM0cqpE5tjyu
         0Jwq2vvSP3OWmXtkEunannVqiyjBLx33bnsJ5bTK6nslDLqeY5IpAMEGGdIYnG+QIrSq
         53OciqB2QM7Lt8w/MrXCs8nyrqskaZuH84WSyADNA3tmb6hlDqygr30qh/AjH9Wcq8l/
         OpiMAHTiDWFwlhPMHgwzuQyIObmMLBU0Zky70TBTwu2CdNKm0TRsOZig2TNY8ObQ/9DA
         SKDA==
X-Gm-Message-State: AO0yUKWS65c4b/yXPKRS0beQLRotqoK0VUrNYFVPSVGXipnKgTaXwvxR
        SRaavzJO5exlgVce42awVmA=
X-Google-Smtp-Source: AK7set+Bf4uJPSzqW8y4jpWiXIClVpdLf1UtMcyoTy/deAt2BUioJdFyfKoYtYRZwx9ooxEa7JD33w==
X-Received: by 2002:a9d:760d:0:b0:69f:9616:2c75 with SMTP id k13-20020a9d760d000000b0069f96162c75mr8809446otl.24.1680117331748;
        Wed, 29 Mar 2023 12:15:31 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:5b9e:1cc2:c3f7:6f9c? (2603-8081-140c-1a00-5b9e-1cc2-c3f7-6f9c.res6.spectrum.com. [2603:8081:140c:1a00:5b9e:1cc2:c3f7:6f9c])
        by smtp.gmail.com with ESMTPSA id di7-20020a0568303a0700b00690e21a46e1sm14378309otb.56.2023.03.29.12.15.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 12:15:31 -0700 (PDT)
Message-ID: <e74f86fa-7332-8503-0660-4568c730c5df@gmail.com>
Date:   Wed, 29 Mar 2023 14:15:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH rdma-next] RDMA/rxe: Properly check tasklet state
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Dan Carpenter <error27@gmail.com>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>
References: <1a6376525c40454282a14ab659de0b17b02fe523.1680113901.git.leon@kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <1a6376525c40454282a14ab659de0b17b02fe523.1680113901.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/29/23 13:18, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Fix the following smatch error:
> 
>   drivers/infiniband/sw/rxe/rxe_task.c:24 __reserve_if_idle()
>   warn: bitwise AND condition is false here
> 
> Fixes: d94671632572 ("RDMA/rxe: Rewrite rxe_task.c")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/all/480b32b6-0f1c-4646-9ecc-e0760004cd24@kili.mountain
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_task.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
> index fea9a517c8d9..48c89987137c 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.c
> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> @@ -21,7 +21,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
>  {
>  	WARN_ON(rxe_read(task->qp) <= 0);
>  
> -	if (task->tasklet.state & TASKLET_STATE_SCHED)
> +	if (task->tasklet.state == TASKLET_STATE_SCHED)
>  		return false;
>  
>  	if (task->state == TASK_STATE_IDLE) {
> @@ -46,7 +46,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
>   */
>  static bool __is_done(struct rxe_task *task)
>  {
> -	if (task->tasklet.state & TASKLET_STATE_SCHED)
> +	if (task->tasklet.state == TASKLET_STATE_SCHED)
>  		return false;
>  
>  	if (task->state == TASK_STATE_IDLE ||

Leon, This is not correct either. I am about to fix this. -- Bob
