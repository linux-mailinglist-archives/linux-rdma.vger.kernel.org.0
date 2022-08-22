Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7679859C7C7
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Aug 2022 21:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbiHVTCb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Aug 2022 15:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238089AbiHVTCO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Aug 2022 15:02:14 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 932D3422D8
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 12:00:20 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id l5-20020a05683004a500b0063707ff8244so8306545otd.12
        for <linux-rdma@vger.kernel.org>; Mon, 22 Aug 2022 12:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=H0HITnH7kGxnAUl3UvTxh5XAD3IhgNqM28KSM1Ep90s=;
        b=krPjbo+tQ8ywTCTO//N1l0p2kKKKI7jr45n5en57fd05KRXPTupfYMgCDoPxayfexe
         kC7impCtWozHSeUCQfTwg/VyTG6agaNB24Ce3YapSi/5u95do/cyO3GDWNH44I/2lSmC
         wFMbtjHbppQiDy4AXT+TMjQ8lnXQIisnHJ62ZlTkk75L/XSdCH3syVtuG1GF6hFT2hh9
         1RCk6ldCwdRzX+5hY+AKbBddg5jz4TP3Jpb6RqzNne84sxCrNRYw1PKEx+B6QOv/U4Vi
         E8031zg+XASpM9ZqnN//E5T3M8xVXs7Q9Kqdio3KuODMa2sCTW4mFC2UoL9NBb6ZD1r8
         NrPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=H0HITnH7kGxnAUl3UvTxh5XAD3IhgNqM28KSM1Ep90s=;
        b=qoDkrq3ZlmAYETPgkHvrNOATR250U3k2odLdEZB3Q9cMlf5Y7+eh7hV2hMa5A7lGpL
         m/czXg2hdT0yoUkr1dVT0AeTzwTWtef55MYCkDcOpKvC7SSj8bQrfrTTlth/qpoV54UF
         9bagl/TRHNXbVl1SqNf6+bZT+QXaJawXFg6lNjgUB056EHl7o0fWhwFc0CsPK/SfH4yp
         MMbhmpgf4aTLDmqwYyDNGaY0Z6/tmytvAXo8gHJoszXIO/49gCgb5CtH049snbGq++k/
         KxRDqaB2PSHuhQsmsO+na7AZV0Y0vXkJnJXexo4ctI7NMWMt29aGf0+A+JfXLI9193d5
         4oyA==
X-Gm-Message-State: ACgBeo0GMspouS1JRrcjWyMOMb1nhk5ig97Bepp81LuY3GvERottPxUD
        1cfvk6q56FgMoe5HM1u+9jE=
X-Google-Smtp-Source: AA6agR6qMjOJa4UKvI5j+4YlJVOtdi2bdNAH2ixM4zi/2LcGh9TIDVnzPPda3WL+DsIFWvTT1kk9iw==
X-Received: by 2002:a05:6830:8d:b0:637:1e6c:8975 with SMTP id a13-20020a056830008d00b006371e6c8975mr8070839oto.135.1661194819951;
        Mon, 22 Aug 2022 12:00:19 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:fd1d:d13f:3b8b:5104? (2603-8081-140c-1a00-fd1d-d13f-3b8b-5104.res6.spectrum.com. [2603:8081:140c:1a00:fd1d:d13f:3b8b:5104])
        by smtp.gmail.com with ESMTPSA id m37-20020a05687088a500b0010efb044e37sm3075213oam.27.2022.08.22.12.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Aug 2022 12:00:19 -0700 (PDT)
Message-ID: <6aaad445-0c9c-ad35-4941-7d3a6653cab6@gmail.com>
Date:   Mon, 22 Aug 2022 14:00:18 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] RDMA/rxe: Fix "kernel NULL pointer dereference" error
Content-Language: en-US
To:     yanjun.zhu@linux.dev, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com
Cc:     syzbot+ab99dc4c6e961eed8b8e@syzkaller.appspotmail.com
References: <20220822011615.805603-1-yanjun.zhu@linux.dev>
 <20220822011615.805603-2-yanjun.zhu@linux.dev>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220822011615.805603-2-yanjun.zhu@linux.dev>
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
> When rxe_queue_init in the function rxe_qp_init_req fails,
> both qp->req.task.func and qp->req.task.arg are not initialized.
> 
> Because of creation of qp fails, the function rxe_create_qp will
> call rxe_qp_do_cleanup to handle allocated resource.
> 
> Before calling __rxe_do_task, both qp->req.task.func and
> qp->req.task.arg should be checked.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Reported-by: syzbot+ab99dc4c6e961eed8b8e@syzkaller.appspotmail.com
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index 516bf9b95e48..f10b461b9963 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -797,7 +797,9 @@ static void rxe_qp_do_cleanup(struct work_struct *work)
>  	rxe_cleanup_task(&qp->comp.task);
>  
>  	/* flush out any receive wr's or pending requests */
> -	__rxe_do_task(&qp->req.task);
> +	if (qp->req.task.func && qp->req.task.arg)
func would be enough since they get set together. But, this is still fine since not performance critical.
> +		__rxe_do_task(&qp->req.task);
> +
>  	if (qp->sq.queue) {
>  		__rxe_do_task(&qp->comp.task);
>  		__rxe_do_task(&qp->req.task);

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
