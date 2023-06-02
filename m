Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7EB7207D8
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Jun 2023 18:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbjFBQni (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Jun 2023 12:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbjFBQnh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 2 Jun 2023 12:43:37 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A099197
        for <linux-rdma@vger.kernel.org>; Fri,  2 Jun 2023 09:43:35 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6af713338ccso1798045a34.0
        for <linux-rdma@vger.kernel.org>; Fri, 02 Jun 2023 09:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685724214; x=1688316214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ztvqo9dEvEewn15+stfPz2bAyVShxNd0yL4S+Ankfc8=;
        b=q43lxTnpQ7AXsk3SmzGWHpf2/uVfpwHM3S+iGhRUxZUVGBiuD+qbeL1J1/gVc5/5FC
         EZk57910MkVD3qDHm9GthCtNPs7RBTCNiMIgvc8CbPQzrVN08HDgcVysycGP3yoCCCIz
         zRLpP8N6XGWCONoM42yrCefxhdf6DEysPlvZA7Z0OL9ckgZw0b0e1+fXx2WuewxvRfX6
         hoa6dCujFQCTMfUm7IsL2gfLq8Rvjr/y5pnM8UiWqX/0sUzZXEBYHR9P95njDoVd40jE
         Ds3SE1xhLYYybdDM6wXkUeO7OkBzm4XU5CAmMZ4TRDUeVcf+J8s74sFaxt1qOVSmFvy9
         YflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685724214; x=1688316214;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ztvqo9dEvEewn15+stfPz2bAyVShxNd0yL4S+Ankfc8=;
        b=LQ/XpuAv2XbCnHOA1Lzrwjask1IMgpCx8QOdEZyB2iZYKlwP1uayjPnMCyhOPGqkBO
         beXWjL3ZwAago3+XsgRIT2qLZmsKZVdMbc8qVkvcAELjdamfitExk/xXJTAFcMuyoEPz
         yq6k7lWWl5Iq/z2ePPOlQKgz2Z0WTK+16lTL2nbS//+iSdu+iUONEByqX+aX48AMDbzW
         z4XNLIcy8ivK0vuRa8BsRoNT9GZRikT1RIBgr5CiI6FfVmUODeAWycrVeRGqLq33Ys5g
         rE0qKnO5447GIOx3Efrvn7A1AP7lOiubcSccHck191dMm1mU8U7LtBMfQIYzSxcs5TXB
         HMjA==
X-Gm-Message-State: AC+VfDx+rMK/o4ffpr579bkK7ae6KxWF2dX1oivqh4wdpU3RpG4sw0iq
        ROe+I3yL+BGMxJQXEZr/ouY=
X-Google-Smtp-Source: ACHHUZ4i3jjkvQFFMWWN7byE83xEz1LfoGcno8S30WmzPBCLCtvizILAgkiw89grKf4qyOVrGCRLIQ==
X-Received: by 2002:a05:6830:ce:b0:6af:9cfa:a38b with SMTP id x14-20020a05683000ce00b006af9cfaa38bmr2618466oto.32.1685724214250;
        Fri, 02 Jun 2023 09:43:34 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:8586:f477:c596:9820? (2603-8081-140c-1a00-8586-f477-c596-9820.res6.spectrum.com. [2603:8081:140c:1a00:8586:f477:c596:9820])
        by smtp.gmail.com with ESMTPSA id t2-20020a9d7f82000000b006af7ccca526sm779141otp.20.2023.06.02.09.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 09:43:33 -0700 (PDT)
Message-ID: <dd87f075-e0f9-7fea-e134-6dd5167c8334@gmail.com>
Date:   Fri, 2 Jun 2023 11:43:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] RDMA/rxe: Send last wqe reached event on qp cleanup
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, leon@kernel.org,
        linux-rdma@vger.kernel.org
References: <20230602164042.9240-1-rpearsonhpe@gmail.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20230602164042.9240-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Sorry ignore this one. I forgot the for-next.

Bob

On 6/2/23 11:40, Bob Pearson wrote:
> The IBA requires:
> 	o11-5.2.5: If the HCA supports SRQ, for RC and UD service,
> 	the CI shall generate a Last WQE Reached Affiliated Asynchronous
> 	Event on a QP that is in the Error State and is associated with
> 	an SRQ when either:
> 		• a CQE is generated for the last WQE, or
> 		• the QP gets in the Error State and there are no more
> 		  WQEs on the RQ.
> 
> This patch implements this behavior in flush_recv_queue() which is
> called as a result of rxe_qp_error() being called whenever the qp
> is put into the error state. The rxe responder executes SRQ WQEs
> directly from the SRQ so there are never more WQES on the RQ.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 172c8f916470..0c24facd12cb 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -1492,8 +1492,17 @@ static void flush_recv_queue(struct rxe_qp *qp, bool notify)
>  	struct rxe_recv_wqe *wqe;
>  	int err;
>  
> -	if (qp->srq)
> +	if (qp->srq) {
> +		if (notify && qp->ibqp.event_handler) {
> +			struct ib_event ev;
> +
> +			ev.device = qp->ibqp.device;
> +			ev.element.qp = &qp->ibqp;
> +			ev.event = IB_EVENT_QP_LAST_WQE_REACHED;
> +			qp->ibqp.event_handler(&ev, qp->ibqp.qp_context);
> +		}
>  		return;
> +	}
>  
>  	while ((wqe = queue_head(q, q->type))) {
>  		if (notify) {

