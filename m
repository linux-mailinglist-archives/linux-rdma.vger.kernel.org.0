Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F7875D26C
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jul 2023 20:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjGUS7X (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 21 Jul 2023 14:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjGUS7X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 21 Jul 2023 14:59:23 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FF530D4
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 11:59:21 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-563439ea4a2so1442046eaf.0
        for <linux-rdma@vger.kernel.org>; Fri, 21 Jul 2023 11:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689965961; x=1690570761;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OzDlGTou8SGQ18NhmJwEdpd749YK6BHY7yUmfjKJzBQ=;
        b=cOLPJuRreBIpR38ueKwhZe5I9rk0JsaG4e2rOCcNTQHqITG/RxQVqNpqurTcvKLkGo
         xA10nUa8ps8JZUmBHz0zlnn2BGtva+6am/l47PNPBZetdImPMuDIf7+tZ8LXZ5/AUVZh
         3bViEUFuY/1H42Zs4M1HskmAwc0F0pCerL4r4PGv3qfpTl43G5vclZF2Agdvb1CGHoBg
         M5uxZKvUaqlUKG/8sX8m1A3VOksTunmHYd6YYyGkTwayoJmeoV6tpdGuPhidKazMYXzM
         PxjcXEHhfS0/tlgSrM62sKFraKLDczK6pA/qFBm7xtvNU8NkLdDBjHN1FbAXPuRLJIzP
         5LAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689965961; x=1690570761;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OzDlGTou8SGQ18NhmJwEdpd749YK6BHY7yUmfjKJzBQ=;
        b=UDTY2zKhc98CyMt+8zgqqBvA6Br63NFB9L/9wPL2c334HXwWndZABmjl/g7frQYD8h
         OQ+Ub6IifR0cJ8yvAckVIGeIcJ78ZudWBJoESVmAK33adFVvt02JejQyAJAq5L4qDX0j
         805eimMKVp9zHuRseT2NiZmb35woCoXyhOzQKLMSlfzDVvsigfW+yCd+AXq41qpIGO+Y
         Y4A1N1GATK9uaDgJ7Z1gKr2WCJVWmgH5zZsFsTmySbtIh/aqqfwvWc7m0eYH7RIvMCB2
         Wnsk76mo1ELC7Wo4avPX5kLMyqIHEoXaMXIzyWiNpppacGH2fcmyZ64MtWxUrxrUllgv
         xXKA==
X-Gm-Message-State: ABy/qLbAHlUFLlgDSptPeo1oBqaCulaeAmrL8pZhzb8jIXQGO8vUkW7j
        AlxIy7KS+Xpfcm8U0rprbQI=
X-Google-Smtp-Source: APBJJlEtVRpJFvHQQzzOPInsZuwXgSlCEgZSUSL/OUp6Xe6Q0QNpKtck4Nhy/aM1lLBgGQsd/yQ4Zw==
X-Received: by 2002:a05:6808:178d:b0:3a3:c1af:e097 with SMTP id bg13-20020a056808178d00b003a3c1afe097mr4034827oib.28.1689965961166;
        Fri, 21 Jul 2023 11:59:21 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:c215:5210:c1ed:1da0? (2603-8081-140c-1a00-c215-5210-c1ed-1da0.res6.spectrum.com. [2603:8081:140c:1a00:c215:5210:c1ed:1da0])
        by smtp.gmail.com with ESMTPSA id 15-20020aca210f000000b003a1f444307esm1704281oiz.58.2023.07.21.11.59.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 11:59:20 -0700 (PDT)
Message-ID: <c6f80a3c-9a10-2cf0-b126-2221fdad884f@gmail.com>
Date:   Fri, 21 Jul 2023 13:59:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] RDMA/rxe: Fix incomplete state save in rxe_requester
Content-Language: en-US
To:     jgg@nvidia.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
References: <20230721180443.16817-1-rpearsonhpe@gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20230721180443.16817-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/21/23 13:04, Bob Pearson wrote:
> If a send packet is dropped by the IP layer in rxe_requester()
> the call to rxe_xmit_packet() can fail with err == -EAGAIN.
> To recover, the state of the wqe is restored to the state before
> the packet was sent so it can be resent. However, the routines
> that save and restore the state miss a significnt part of the
> variable state in the wqe, the dma struct which is used to process
> through the sge table. And, the state is not saved before the packet
> is built which modifies the dma struct.
> 
> Under heavy stress testing with many QPs on a fast node sending
> large messages to a slow node dropped packets are observed and
> the resent packets are corrupted because the dma struct was not
> restored. This patch fixes this behavior and allows the test cases
> to succeed.
> 
> Fixes: 3050b9985024 ("IB/rxe: Fix race condition between requester and completer")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_req.c | 47 ++++++++++++++++-------------
>  1 file changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index 76d85731a45f..10ff2715d9bb 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -708,10 +708,11 @@ static void save_state(struct rxe_send_wqe *wqe,
>  		       struct rxe_send_wqe *rollback_wqe,
>  		       u32 *rollback_psn)
>  {
> -	rollback_wqe->state     = wqe->state;
> +	rollback_wqe->state = wqe->state;
>  	rollback_wqe->first_psn = wqe->first_psn;
> -	rollback_wqe->last_psn  = wqe->last_psn;
> -	*rollback_psn		= qp->req.psn;
> +	rollback_wqe->last_psn = wqe->last_psn;
> +	rollback_wqe->dma = wqe->dma;
> +	*rollback_psn = qp->req.psn;
>  }
>  
>  static void rollback_state(struct rxe_send_wqe *wqe,
> @@ -719,10 +720,11 @@ static void rollback_state(struct rxe_send_wqe *wqe,
>  			   struct rxe_send_wqe *rollback_wqe,
>  			   u32 rollback_psn)
>  {
> -	wqe->state     = rollback_wqe->state;
> +	wqe->state = rollback_wqe->state;
>  	wqe->first_psn = rollback_wqe->first_psn;
> -	wqe->last_psn  = rollback_wqe->last_psn;
> -	qp->req.psn    = rollback_psn;
> +	wqe->last_psn = rollback_wqe->last_psn;
> +	wqe->dma = rollback_wqe->dma;
> +	qp->req.psn = rollback_psn;
>  }
>  
>  static void update_state(struct rxe_qp *qp, struct rxe_pkt_info *pkt)
> @@ -922,6 +924,9 @@ int rxe_requester(struct rxe_qp *qp)
>  		payload = mtu;
>  	}
>  
> +	/* save wqe state before we build and send packet */
> +	save_state(wqe, qp, &rollback_wqe, &rollback_psn);
> +
>  	skb = rxe_init_req_packet(qp, wqe, opcode, payload, &pkt);
>  	if (unlikely(!skb)) {
>  		rxe_err_qp(qp, "failed to create packet for %s",
> @@ -929,29 +934,29 @@ int rxe_requester(struct rxe_qp *qp)
>  		goto err;
>  	}
>  
> -	/*
> -	 * To prevent a race on wqe access between requester and completer,
> -	 * wqe members state and psn need to be set before calling
> -	 * rxe_xmit_packet().
> -	 * Otherwise, completer might initiate an unjustified retry flow.
> -	 */
> -	save_state(wqe, qp, &rollback_wqe, &rollback_psn);
> +	/* update wqe state as though we had sent it */
>  	update_wqe_state(qp, wqe, &pkt);
>  	update_wqe_psn(qp, wqe, &pkt, payload);
>  
>  	err = rxe_xmit_packet(qp, &pkt, skb);
>  	if (err) {
> -		qp->need_req_skb = 1;
> +		if (err != -EAGAIN) {
> +			wqe->status = IB_WC_LOC_QP_OP_ERR;
> +			goto err;
> +		}
>  
> +		/* the packet was dropped so reset wqe to the state
> +		 * before we sent it so we can try to resend
> +		 */
>  		rollback_state(wqe, qp, &rollback_wqe, rollback_psn);
>  
> -		if (err == -EAGAIN) {
> -			rxe_sched_task(&qp->req.task);
> -			goto exit;
> -		}
> +		/* force a delay until the dropped packet is freed and
> +		 * the send queue is drained below the low water mark
> +		 */
> +		qp->need_req_skb = 1;
>  
> -		wqe->status = IB_WC_LOC_QP_OP_ERR;
> -		goto err;
> +		rxe_sched_task(&qp->req.task);
> +		goto exit;
>  	}
>  
>  	update_state(qp, &pkt);

Never mind. Missing some prereq patches. 
