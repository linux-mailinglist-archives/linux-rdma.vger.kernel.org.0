Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3567A52730D
	for <lists+linux-rdma@lfdr.de>; Sat, 14 May 2022 18:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiENQmA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 14 May 2022 12:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbiENQl6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 14 May 2022 12:41:58 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAE76553
        for <linux-rdma@vger.kernel.org>; Sat, 14 May 2022 09:41:56 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-f17f1acffeso1778172fac.4
        for <linux-rdma@vger.kernel.org>; Sat, 14 May 2022 09:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=zlxEWicIHbHxigySyzBYcNjypvwnK5xEjE8S/JppIGg=;
        b=XWP7aTNa4hRHC9NuJFgf1T6UkPCGNlVUq2qaxiw0tzQXvjZFAXH/TXnkxGPpdsvLsP
         lIMuiAV//3J3UrKtD9QMK3eNW6uE5xKOqmF0Jzx0N8x2oJjG7pAmVmH6ONnKQ+nLq84V
         7tqb1GjF4KIPqNeMLnR3mAxbAhCX4WksNAcVfNKKP6vDrksbYbogDQYl1i3Gz6RWCl0C
         9kJmzwEFq7C6xFD9wppl6hONtfq2YPl2d3oi54je6empW7DfimUWd/vQfAAofsSt9omz
         DmaOQHL7ZXbAPvY448axsFUS02/qMM9pB7LOARetXuBQHte0xmMsTwjVmCdlPFNaMQgC
         gGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zlxEWicIHbHxigySyzBYcNjypvwnK5xEjE8S/JppIGg=;
        b=UNMPBhqBPbM/lqD6+zVdOSoWaDSs/JyA87gE3c3LODFmYj9hk1pAc+J3hcphpyk5bO
         Sx/RpuMczEO/RoAgKDMcY/hXOB7UFPDXc8IaiCfbe77Y7xq4O1WoGyLpeWm6O/uXAGvS
         mdAJCPu7BzejOW7J3AUKH/NB6gzXqorxj79EgEewdIeS0JgM6aLrgkljDiVPgx/uedBd
         BtzMRshLsEmIk2ZZaAi2kRIBkh1G3eV3/zK5pKgFYXukXMSGNxmFV07Rsqz8uDM6r7tS
         fZ2HAYbBZ3Yp6JuAP2ZOnG7XGsAnfOQRGqRFp2jmhN6l6qza7MVJXmrmY01SsO/w2RMn
         9v/g==
X-Gm-Message-State: AOAM533sSJR68HcAJkkXlHV/So0CBl6tIFQoCAw6Rg/OrqftJhxXSC9I
        Tu43Pkil1z2kjD2FCh+C3K7rVd/ezXs=
X-Google-Smtp-Source: ABdhPJxWR7cjg1lG8lnyGFovzjuEezCRIKf11h08JUdSbOC23TbuCzZrgE90lGOKuEl34fjD9Vxl+A==
X-Received: by 2002:a05:6870:34f:b0:ec:5be1:fa81 with SMTP id n15-20020a056870034f00b000ec5be1fa81mr5215274oaf.234.1652546516258;
        Sat, 14 May 2022 09:41:56 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:ff90:a992:e964:f3bc? (2603-8081-140c-1a00-ff90-a992-e964-f3bc.res6.spectrum.com. [2603:8081:140c:1a00:ff90:a992:e964:f3bc])
        by smtp.gmail.com with ESMTPSA id i20-20020a056870345400b000f17905320esm1070374oah.13.2022.05.14.09.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 09:41:55 -0700 (PDT)
Message-ID: <6223c9fb-6e6f-3248-8f65-0f11fbfd3d68@gmail.com>
Date:   Sat, 14 May 2022 11:41:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH for-rc v2 4/4] RDMA/rxe: Reduce spurious retransmit
 timeouts
Content-Language: en-US
To:     jgg@nvidia.com, zyjzyj2000@gmail.com, tom@talpey.com,
        linux-rdma@vger.kernel.org, jhack@hpe.com
References: <20220514030435.91155-1-rpearsonhpe@gmail.com>
 <20220514030435.91155-5-rpearsonhpe@gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220514030435.91155-5-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/13/22 22:04, Bob Pearson wrote:
> Currently the rxe driver sets a timer to handle response timeouts
> from lost packets or other failures. However this timer is never
> deleted so it will always fire in the period it was set for.
> Under heavy load this means that there will be retry flows attempted
> every few msec depending on the setting for retry timeout.
> 
> This patch modifies the driver in several ways to reduce the
> number of spurious timeouts:
> 
>  - The psn of the current packet is saved when the timer is set
>    for non-read requests and for read requests a psn in the
>    expected response is saved. When a response packet is received
>    by the completer tasklet that has a psn >= to the saved psn
>    the timer is deleted.
>  - As soon as there is no pending timer any new request will
>    reset the timer. For long read replies the timer is reset
>    as blocks of data arrive so that the response is covered by
>    a timer.
> 
> For typical heavy loads (e.g. ib_send_bw etc.) the number of
> retries is reduced from ~40 retries per second to one every
> several seconds. These are legitimate timeouts where the responder
> does not reply in the given time.
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_comp.c  | 50 ++++++++++++++++++---------
>  drivers/infiniband/sw/rxe/rxe_req.c   | 26 ++++++++++++--
>  drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
>  3 files changed, 57 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
> index 3c77201c01d1..a8ef1f781a24 100644
> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
> @@ -170,12 +170,44 @@ static inline void reset_retry_counters(struct rxe_qp *qp)
>  	qp->comp.started_retry = 0;
>  }
>  
> +static void update_retransmit_timer(struct rxe_qp *qp,
> +				    struct rxe_pkt_info *pkt,
> +				    struct rxe_send_wqe *wqe)
> +{
> +	/* reset the retry timer for long read responses
> +	 * if there is more data expected
> +	 */
> +	if ((pkt->opcode & 0x1f) == IB_OPCODE_RDMA_READ_REQUEST) {

Oops. This is the wrong opcode. Should be one of the read replies.
Bob

> +		int psn = (pkt->psn + RXE_MAX_PKT_PER_ACK) & 0xffffff;
> +
> +		if (psn_compare(psn, wqe->last_psn) > 0)
> +			psn = wqe->last_psn;
> +
> +		if (psn_compare(psn, pkt->psn) > 0) {
> +			atomic_set(&qp->timeout_psn, psn);
> +			mod_timer(&qp->retrans_timer,
> +				  jiffies + qp->timeout_jiffies);
> +			return;
> +		}
> +	}
> +
> +	/* else just delete the timer */
> +	del_timer_sync(&qp->retrans_timer);
> +}
> +
>  static inline enum comp_state check_psn(struct rxe_qp *qp,
>  					struct rxe_pkt_info *pkt,
>  					struct rxe_send_wqe *wqe)
>  {
>  	s32 diff;
>  
> +	/* if this packet psn matches or exceeds the request that set the
> +	 * retry timer update the timer.
> +	 */
> +	if ((psn_compare(pkt->psn, atomic_read(&qp->timeout_psn)) >= 0) &&
> +	    timer_pending(&qp->retrans_timer))
> +		update_retransmit_timer(qp, pkt, wqe);
> +
>  	/* check to see if response is past the oldest WQE. if it is, complete
>  	 * send/write or error read/atomic
>  	 */
> @@ -663,20 +695,6 @@ int rxe_completer(void *arg)
>  				break;
>  			}
>  
> -			/* re reset the timeout counter if
> -			 * (1) QP is type RC
> -			 * (2) the QP is alive
> -			 * (3) there is a packet sent by the requester that
> -			 *     might be acked (we still might get spurious
> -			 *     timeouts but try to keep them as few as possible)
> -			 * (4) the timeout parameter is set
> -			 */
> -			if ((qp_type(qp) == IB_QPT_RC) &&
> -			    (qp->req.state == QP_STATE_READY) &&
> -			    (psn_compare(qp->req.psn, qp->comp.psn) > 0) &&
> -			    qp->timeout_jiffies)
> -				mod_timer(&qp->retrans_timer,
> -					  jiffies + qp->timeout_jiffies);
>  			ret = -EAGAIN;
>  			goto done;
>  
> @@ -684,9 +702,7 @@ int rxe_completer(void *arg)
>  			/* we come here if the retry timer fired and we did
>  			 * not receive a response packet. try to retry the send
>  			 * queue if that makes sense and the limits have not
> -			 * been exceeded. remember that some timeouts are
> -			 * spurious since we do not reset the timer but kick
> -			 * it down the road or let it expire
> +			 * been exceeded.
>  			 */
>  
>  			/* there is nothing to retry in this case */
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index aa9066ff5257..5e031661bc49 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -397,7 +397,9 @@ static struct sk_buff *init_req_packet(struct rxe_qp *qp,
>  					 qp->attr.dest_qp_num;
>  
>  	ack_req = ((pkt->mask & RXE_END_MASK) ||
> -		(qp->req.noack_pkts++ > RXE_MAX_PKT_PER_ACK));
> +		   (qp->req.noack_pkts++ > RXE_MAX_PKT_PER_ACK) ||
> +		   (qp->timeout_jiffies &&
> +				!timer_pending(&qp->retrans_timer)));
>  	if (ack_req) {
>  		qp->req.noack_pkts = 0;
>  		pkt->mask |= RXE_ACK_REQ_MASK;
> @@ -545,10 +547,28 @@ static void update_state(struct rxe_qp *qp, struct rxe_send_wqe *wqe,
>  
>  	qp->need_req_skb = 0;
>  
> -	if ((pkt->mask & RXE_ACK_REQ_MASK) && qp->timeout_jiffies &&
> -	    !timer_pending(&qp->retrans_timer))
> +	/* reset the retry timer if the packet has the ackreq bit set,
> +	 * we are using the retry timer and there is no timer set
> +	 * currently
> +	 */
> +	if (pkt->mask & RXE_ACK_REQ_MASK && qp->timeout_jiffies &&
> +	    !timer_pending(&qp->retrans_timer)) {
> +		int psn = pkt->psn;
> +
> +		/* for read ops delay matching psn by RXE_MAX_PKT_PER_ACK
> +		 * up to the last psn. The completer will also reset the
> +		 * retry timer as required
> +		 */
> +		if ((pkt->opcode & 0x1f) == IB_OPCODE_RDMA_READ_REQUEST) {
> +			psn = (psn + RXE_MAX_PKT_PER_ACK) & 0xffffff;
> +			if (psn_compare(psn, wqe->last_psn) > 0)
> +				psn = wqe->last_psn;
> +		}
> +
> +		atomic_set(&qp->timeout_psn, psn);
>  		mod_timer(&qp->retrans_timer,
>  			  jiffies + qp->timeout_jiffies);
> +	}
>  }
>  
>  static int rxe_do_local_ops(struct rxe_qp *qp, struct rxe_send_wqe *wqe)
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index a6c6f0d786c7..c41092d790f0 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -252,6 +252,7 @@ struct rxe_qp {
>  	 */
>  	struct timer_list	retrans_timer;
>  	u64			timeout_jiffies;
> +	atomic_t		timeout_psn;
>  
>  	/* Timer for handling RNR NAKS. */
>  	struct timer_list	rnr_nak_timer;

