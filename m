Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFA655B455
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jun 2022 01:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiFZWmO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Jun 2022 18:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiFZWmO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 26 Jun 2022 18:42:14 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07092BC7;
        Sun, 26 Jun 2022 15:42:13 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w83so10751686oiw.1;
        Sun, 26 Jun 2022 15:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=uIE8gKMJ6mLlCMRbp3LqS0tnA9eQSWmifmvEY7fIxFs=;
        b=CMFJOxB5ugqwghnDzXk33D61FP9nb3o8ckuZ2Lkvo7eFEffE5YdQ+NIJnNwyYW6A3S
         plXzv29WtaorKlGdc8sNPsdHaj/lbUKNctFqyxporlDAuMooFfoZ5U4fCyH+oVWQa0+o
         xPqZGzOWIjH0ZwKg07auJ2DM2WcUekvdbWXFP0z2US4KpG3VzJ1OyyDZoeL11+ggRZpU
         SUQHhsjIlGRk9uIEJ95e3C+in5K8fc9odL34jL+E1ydz7EHIh4PTHnOKFx8ESfsQbLhW
         k+Ll7NVdPgGhHu24M0mDEPkh1/FLZkuYdNdauKunpSTLC1FxfjPKhhzeometK59VunVv
         /xvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uIE8gKMJ6mLlCMRbp3LqS0tnA9eQSWmifmvEY7fIxFs=;
        b=2bSE5mxnX2itjoIh7pqzjGeGJaXp2hEUhRDJHZ7fGxOsH5zF09RBDy2/8DhdTaxbp6
         ZAe1/zZaJ2jrj1VW15B/lwhtQR2ynZB5Bc4D7A4qDvjcksyw1SrbLd1fTmyu2G46qBwe
         etZ5eLeUZxEDeovGDgFb5iPwPNBYnDHX1nDObIPgu9Tu7Ub8Jilu6pBbocH29PGMkjEu
         1tcG0I0Pj8C1Aem24AcqNu4iLMw/q2s2hAllbrK/d+aCAOjcqEtEajJmcgEXlexHkgnZ
         k2G5jvzVowxL045grcw9ZhIwxloifEP1VIjcqos//20n3mtt/+U0/2RfaJ85IDv8je08
         2Mvg==
X-Gm-Message-State: AJIora//KNP8bRQ0yMJoH6nb+XgaLDGxyfHume/dqo2xTEcdPhTktXuu
        nW7pO4AMic5H9zFQvTzF1D0=
X-Google-Smtp-Source: AGRyM1vNFUW8TYrg4+oxkLjHUXXfnsMv26Bz6TiZ5D2wwePgcQhrNyzhz8UPXQCaqoMFM5bGNy0Upg==
X-Received: by 2002:a05:6808:1898:b0:331:4343:7637 with SMTP id bi24-20020a056808189800b0033143437637mr8891384oib.83.1656283333059;
        Sun, 26 Jun 2022 15:42:13 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:7f25:2769:1033:f8c1? (2603-8081-140c-1a00-7f25-2769-1033-f8c1.res6.spectrum.com. [2603:8081:140c:1a00:7f25:2769:1033:f8c1])
        by smtp.gmail.com with ESMTPSA id en38-20020a05687007a600b000f325409614sm6053772oab.13.2022.06.26.15.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 15:42:12 -0700 (PDT)
Message-ID: <40582262-9d58-b38a-5a0e-7c32d1efadbe@gmail.com>
Date:   Sun, 26 Jun 2022 17:42:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 2/2] RDMA/rxe: Generate error completion for error
 requester QP state
Content-Language: en-US
To:     Li Zhijian <lizhijian@fujitsu.com>,
        Yanjun Zhu <yanjun.zhu@linux.dev>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        Cheng Xu <chengyou@linux.alibaba.com>,
        linux-rdma@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220516015329.445474-1-lizhijian@fujitsu.com>
 <20220516015329.445474-3-lizhijian@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220516015329.445474-3-lizhijian@fujitsu.com>
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

On 5/15/22 20:53, Li Zhijian wrote:
> As per IBTA specification, all subsequent WQEs while QP is in error
> state should be completed with a flush error.
> 
> Here we check QP_STATE_ERROR after req_next_wqe() so that rxe_completer()
> has chance to be called where it will set CQ state to FLUSH ERROR and the
> completion can associate with its WQE.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> V3: unlikely() optimization # Cheng Xu <chengyou@linux.alibaba.com>
>     update commit log # Haakon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index 8bdd0b6b578f..c1f1c19f26b2 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -624,7 +624,7 @@ int rxe_requester(void *arg)
>  	rxe_get(qp);
>  
>  next_wqe:
> -	if (unlikely(!qp->valid || qp->req.state == QP_STATE_ERROR))
> +	if (unlikely(!qp->valid))
>  		goto exit;
>  
>  	if (unlikely(qp->req.state == QP_STATE_RESET)) {
> @@ -646,6 +646,14 @@ int rxe_requester(void *arg)
>  	if (unlikely(!wqe))
>  		goto exit;
>  
> +	if (unlikely(qp->req.state == QP_STATE_ERROR)) {
> +		/*
> +		 * Generate an error completion so that user space is able to
> +		 * poll this completion.
> +		 */
> +		goto err;
> +	}
> +
>  	if (wqe->mask & WR_LOCAL_OP_MASK) {
>  		ret = rxe_do_local_ops(qp, wqe);
>  		if (unlikely(ret))

There may be issues with moving this after the retry check since the retransmit timer can
fire at any time and may race with the completer setting the error state and result in
a retry flow occurring while you are trying to flush out all the wqes. Perhaps better
to to duplicate setting wqe in the error state check.

Bob
