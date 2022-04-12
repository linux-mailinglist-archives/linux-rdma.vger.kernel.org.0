Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D58D4FCD78
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Apr 2022 06:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242822AbiDLENf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 00:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiDLENe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 00:13:34 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299D62E6AE
        for <linux-rdma@vger.kernel.org>; Mon, 11 Apr 2022 21:11:18 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 12so17831143oix.12
        for <linux-rdma@vger.kernel.org>; Mon, 11 Apr 2022 21:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=dc2FJCFm9L8Rsf+cXqasDi/Z/Q30sRa1LaH3Y/CZpzE=;
        b=FOIZKpE0GFWyOG2F/R2UKMcMECCzyhLvA5frp9xVX3PHCbgkdEf/fNSmXROZhZA8Mh
         zr24FkNvEuOvu9o3pfnEwqxPR2NWsg+NVo47rFpDK8pRVhX/WuQKGqvTWkg2SgZr0lxr
         dWuMHZAXJTCyfSXJ98n4gr60EPyBm1BMGIKZofY82jqQnb3kVn/ocKMtSENvuGBDR9ac
         j62g7v/bJgOfzaGs8OSVWGOQLNqPwW+DekCR3Trg4rb9Kh/nJOcYFt99byg/XdE0hvjt
         na6w8+LDQdkKiPgnuXCH0JxkNIcxEpZGLaxXaXLjgzJfratx2/01O10x6NcvQPha/jG6
         JrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=dc2FJCFm9L8Rsf+cXqasDi/Z/Q30sRa1LaH3Y/CZpzE=;
        b=4dpR9q7l0Jf/aVBQfF4Ggog0jUgjubcfAUObYRezOl17COL+jtIOm90slh7j/SodlY
         iuXxhwCaVREkahzxi9Qy0yudTqY6BbDvHk5rw177a81WqIAd86zAsi3yfjo3nrbZU7ZB
         5AwUfqQh7lj1OsKQqlpsHK9nPBj1Dh9d9/Inkn1yIlKbvacIbeLF7sWRRVNu0jPaMC7w
         njzWV9VsBemxAxRsD+UOqS7Ff0C2gyyaoecIusCswbT+ug4uuFc/qU7Vfo5PYW2mo9xS
         X0mMJkhkTYxEEHumJ36Uh6ux/8zh5SDoH0PzAa2g5RrAPoyr0NSFJuIPCoEqwUu7jgH2
         2i2w==
X-Gm-Message-State: AOAM531Y1zp2iIT4N/n7yqsFe4/FAYl9gtdvRXJm1+NeLrw05IX7WENt
        4FLfzy51lZSUHogUnFGQF3Y=
X-Google-Smtp-Source: ABdhPJzVvLWf/78dmM5BuEF1H1bHK/gm+5is4U7tg7oBycSn3W8C0+pdG4gocpMu44FU7fu8lwoP4g==
X-Received: by 2002:a05:6808:ecf:b0:2f9:f0b1:7ee8 with SMTP id q15-20020a0568080ecf00b002f9f0b17ee8mr917017oiv.225.1649736677430;
        Mon, 11 Apr 2022 21:11:17 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:e8e8:cfa3:e55d:7274? (2603-8081-140c-1a00-e8e8-cfa3-e55d-7274.res6.spectrum.com. [2603:8081:140c:1a00:e8e8:cfa3:e55d:7274])
        by smtp.gmail.com with ESMTPSA id a6-20020a9d4706000000b005cdff2d400bsm13002758otf.24.2022.04.11.21.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 21:11:17 -0700 (PDT)
Message-ID: <3f13c82a-8d80-45a3-95fe-5a9c0ff3db1c@gmail.com>
Date:   Mon, 11 Apr 2022 23:11:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: null pointer in rxe_mr_copy()
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <1b0ae089-ff3f-7e84-4c07-a5d97554e3c0@gmail.com>
In-Reply-To: <1b0ae089-ff3f-7e84-4c07-a5d97554e3c0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/10/22 22:34, Bob Pearson wrote:
> Zhu,
> 
> Since checking for mr == NULL in rxe_mr_copy fixes the problem you were seeing in rping.
> Perhaps it would be a good idea to apply the following patch which would tell us which of
> the three calls to rxe_mr_copy is failing. My suspicion is the one in read_reply() in rxe_resp.c
> This could be caused by a race between shutting down the qp and finishing up an RDMA read.
> The responder resources state machine is completely unprotected from simultaneous access by
> verbs code and bh code in rxe_resp.c. rxe_resp is a tasklet so all the accesses from there are
> serialized but if anyone makes a verbs call that touches the responder resources it could
> cause problems. The most likely (only?) place this could happen is qp shutdown.

I have reproduced a failure in rping on the v13 patch series. So never mind. It's something else.
It runs for about a couple minutes on my  system between a pair of VMs with

rping -s or c -C 10000 -S 4096 -a 192.168.0.xx -d -V -p 1234

after a couple of minutes client hangs. Nothing in dmesg though. Happens right after an RDMA read
that reports success on the server. Possibly it is at 10000 packets feels about the right time but
job does not finish. 
> 
> Bob
> 
> 
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> 
> index 60a31b718774..66184f5a4ddf 100644
> 
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> 
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> 
> @@ -489,6 +489,7 @@ int copy_data(
> 
>  		if (bytes > 0) {
> 
>  			iova = sge->addr + offset;
> 
>  
> 
> +			WARN_ON(!mr);
> 
>  			err = rxe_mr_copy(mr, iova, addr, bytes, dir);
> 
>  			if (err)
> 
>  				goto err2;
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> 
> index 1d95fab606da..6e3e86bdccd7 100644
> 
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> 
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> 
> @@ -536,6 +536,7 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
> 
>  	int	err;
> 
>  	int data_len = payload_size(pkt);
> 
>  
> 
> +	WARN_ON(!qp->resp.mr);
> 
>  	err = rxe_mr_copy(qp->resp.mr, qp->resp.va + qp->resp.offset,
> 
>  			  payload_addr(pkt), data_len, RXE_TO_MR_OBJ);
> 
>  	if (err) {
> 
> @@ -772,6 +773,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
> 
>  	if (!skb)
> 
>  		return RESPST_ERR_RNR;
> 
>  
> 
> +	WARN_ON(!mr);
> 
>  	err = rxe_mr_copy(mr, res->read.va, payload_addr(&ack_pkt),
> 
>  			  payload, RXE_FROM_MR_OBJ);
> 
>  	if (err)
> 

