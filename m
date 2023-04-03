Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E886D529E
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Apr 2023 22:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjDCUiS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Apr 2023 16:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbjDCUiR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Apr 2023 16:38:17 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D14139
        for <linux-rdma@vger.kernel.org>; Mon,  3 Apr 2023 13:38:16 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id w15-20020a056830410f00b006a386a0568dso1038481ott.4
        for <linux-rdma@vger.kernel.org>; Mon, 03 Apr 2023 13:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680554295;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H8mkN1SjpMrd5+yz/bQqs3fGE+QBrjGFaKv+VBrZmeI=;
        b=clMFxEpU3X+qRImCkYGQ2kXJsgCRfbYWwwQyc0EQJCdxWxS+51BmVo7TcX5KnmmCIb
         TYdZ71vveuOe7yjLqHgybRF5JCDMuJ36+ilXTbY0kkujqsWg0kWAHtt7YZGy8Lwov+em
         h2hAuGrGsTTHr7HWIq0WuYuPNLy3D2JUkZCHun/9KG3TsM3/9plW4MUPp3byKBDFMTQg
         MnNT9rslF/SMiTVfDJT4kKAwbJA9JLkuzzvQ0qW0JBTpkwKdUUOSmP1Bx379GRuyiLp4
         W6rDb3LI8c35Y4qQbeUwyvxYFLqct7zDtXnUfOu+uXu591rujgxZsw8FP7W+SfJDL5kW
         xlgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680554295;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H8mkN1SjpMrd5+yz/bQqs3fGE+QBrjGFaKv+VBrZmeI=;
        b=yK5DCHLF75AzdAxZyVWluhzre0BDi+NIqWsJZK77VOkwhEccJMeIr8dMFuZetVPzcO
         Wjl6dbNGxehgqQPdy1r9Dz752OUPNX9IwZlJmEp/9CVQl8trfzfVISz55Mhtg0Dj2uSh
         ibjVYhzKyB2QO6USS7S8tFrrXKv0OcDk4jfM1Eoqy2EdDVVPbPsGxvJVBh7XwAfwbAO4
         h7aoW0DdJTjC7FncTnrAXxgepxkpSOfVF8jXswklGMkVnxuSL6Ns4SiKtMHmpbtsgNZg
         j0mqYv6xk3Lve6Mh1U9fMQ84ZhGalH1bIpmXt7j7xNFdMOY+y05k0H5guuLHG5p/sckf
         10og==
X-Gm-Message-State: AAQBX9ftfWm934ft1BDM/4g0BrBbg25tfszWHiiQYGAjHSbW/j4FaRrD
        Ix4TrjYMGR2DMFcVpC9avwc=
X-Google-Smtp-Source: AKy350bgezWyKC8GAVYQH4Kmm/dNvrKuVSk5DRBB2OmCKXxGQBNZ+hnCpozQNhZTKhLMx3jcE/SRDw==
X-Received: by 2002:a05:6830:22c5:b0:6a1:1ed4:bc4d with SMTP id q5-20020a05683022c500b006a11ed4bc4dmr224957otc.14.1680554294981;
        Mon, 03 Apr 2023 13:38:14 -0700 (PDT)
Received: from [192.168.0.27] (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id x9-20020a05683000c900b006a30260ccfdsm3398121oto.11.2023.04.03.13.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 13:38:14 -0700 (PDT)
Message-ID: <727cd25c-7d8f-73d0-8867-836da29c54b2@gmail.com>
Date:   Mon, 3 Apr 2023 15:38:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] RDMA/rxe: Fix error in rxe_task.c
Content-Language: en-US
To:     error27@gmail.com, leon@kernel.org, jgg@nvidia.com,
        zyjzyj2000@gmail.com, jhack@hpe.com, linux-rdma@vger.kernel.org
References: <20230329193308.7489-1-rpearsonhpe@gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20230329193308.7489-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/29/23 14:33, Bob Pearson wrote:
> In a previous patch TASKLET_STATE_SCHED was used as a bit but it
> is a bit position instead. This patch corrects that error.
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/linux-rdma/8a054b78-6d50-4bc6-8d8a-83f85fbdb82f@kili.mountain/
> Fixes: d94671632572 ("RDMA/rxe: Rewrite rxe_task.c")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_task.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
> index fea9a517c8d9..fb9a6bc8e620 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.c
> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> @@ -21,7 +21,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
>  {
>  	WARN_ON(rxe_read(task->qp) <= 0);
>  
> -	if (task->tasklet.state & TASKLET_STATE_SCHED)
> +	if (task->tasklet.state & BIT(TASKLET_STATE_SCHED))
>  		return false;
>  
>  	if (task->state == TASK_STATE_IDLE) {
> @@ -46,7 +46,7 @@ static bool __reserve_if_idle(struct rxe_task *task)
>   */
>  static bool __is_done(struct rxe_task *task)
>  {
> -	if (task->tasklet.state & TASKLET_STATE_SCHED)
> +	if (task->tasklet.state & BIT(TASKLET_STATE_SCHED))
>  		return false;
>  
>  	if (task->state == TASK_STATE_IDLE ||

This patch fixes a bug in rxe_task.c introduced by the earlier patch (d94671632572 RDMA/rxe: Rewrite rxe_task.c)
which is in for-next. The bug actually has minimal effects because TASKLET_STATE_SCHED is zero and in testing
so far it doesn't seem to make a difference.

There is a second patch currently in patchworks ([for-next,v6] RDMA/rxe: Add workqueue support for tasks
[for-next,v6] RDMA/rxe: Add workqueue support for tasks 	- - - 	--- 	2023-03-02 	Bob Pearson New)
which is ahead of this one and replaces the tasklet implementation by work queues. This second patch replaces the
lines lines containing the error with a workqueue specific equivalent.

There are two ways forward here. We could fix the tasklet version by applying this patch first or ignore the
error and apply the workqueue patch first. My desire is to get rid of tasklets altogether so I prefer the
second choice. If we choose the first choice then we need to reorder the two patches in patchworks and
rebase the workqueue patch to match the fixed tasklet code.

Please suggest how you would like me to proceed.

Bob
