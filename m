Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5BE708B86
	for <lists+linux-rdma@lfdr.de>; Fri, 19 May 2023 00:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjERWZu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 May 2023 18:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjERWZt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 18 May 2023 18:25:49 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFDFE57;
        Thu, 18 May 2023 15:25:41 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-199bffcfd21so1063173fac.1;
        Thu, 18 May 2023 15:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684448741; x=1687040741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBnzViueWiSeaAyUH7qOpg9qLcoZlKiPDtOoCkjrY3Y=;
        b=rSOPivk+T0fYowJPrSIxxuhMi7FvDcxqk8DOum1A+yf0j9RKdCe84YJhW3VdcbcHfE
         dMsDgQXFXp5P4TI4JemYnB4qFt2k9juvZ/6D4JJPftaoLQbwgM0pl3DO1aTYaWLn9y68
         a3hnpMyWL1llrD0378/Bz8kD0TsdTWolxXvzkLEh3OOY/nhnCy9zTVXgZnyh/h5P2oe6
         10vlgHi3pcMy0WG4VwJeePWmskFU8xbLgKyhtaFbGGdH0f1/KmH/1pmLIUbMEyRCIXo9
         yVYZijmt4Gmz8D/rW7uu8ycltHb8BQnZuFt7QQA2TUc7qnAtikOJ9vDTS9iNOW8IIbog
         iiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684448741; x=1687040741;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBnzViueWiSeaAyUH7qOpg9qLcoZlKiPDtOoCkjrY3Y=;
        b=XWf3iUbkx58h8R4xyAZpZL6TZbrJTvRzeqhv1aUFj59NQsRc1Pw6L2218+D0w3iQjX
         GEIW9ljTNYZ3gA05ZLPt6LfRfRTQ6rin0He2aZNK0jdM2kJVUblH4c1+9JjXW3I8uum4
         g9zU+VNqiVimB8GjjpTYG7cR6QeYxkEtliJx/dfG9wIJDFsvMwOkXJjRdwnZwO0mjHDw
         brSA0EZk/SoPuCnpPp/7Ize+F2DYKi5KUpeqUxXoZcgLlpn1kFb0VFRpsCCSDOatpBR4
         40w722ivqWLTr/PA3bJzZZZMwDF1dNlBD59kcTPldRxl8B9zedVuhOY/dtHegSn2WPXL
         XFlQ==
X-Gm-Message-State: AC+VfDy/jxkEBy5LiaVbqYC/XcJu0w1scA8P92FuoZVQOpgBk6gq7nKU
        5F8dk90syrt/xRqKGt5KcfM=
X-Google-Smtp-Source: ACHHUZ6JXXbue5lGhuLkFH1GILeZ9GLc1vPwQuJVHq0FESjJXWqbRJQaoW1i7JUhQy0ES/I95xuD+w==
X-Received: by 2002:a05:6870:1945:b0:199:ccb2:12f2 with SMTP id m5-20020a056870194500b00199ccb212f2mr122516oak.20.1684448741133;
        Thu, 18 May 2023 15:25:41 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:1b3d:4b6b:e581:f922? (2603-8081-140c-1a00-1b3d-4b6b-e581-f922.res6.spectrum.com. [2603:8081:140c:1a00:1b3d:4b6b:e581:f922])
        by smtp.gmail.com with ESMTPSA id bd6-20020a056870d78600b00172ac40356csm1286417oab.50.2023.05.18.15.25.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 15:25:40 -0700 (PDT)
Message-ID: <660e05c8-9016-f97a-1af3-341eec8e911e@gmail.com>
Date:   Thu, 18 May 2023 17:25:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH for-next v5 1/7] RDMA/rxe: Always defer tasks on responder
 and completer to workqueue
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, yangx.jy@fujitsu.com,
        lizhijian@fujitsu.com, y-goto@fujitsu.com
References: <cover.1684397037.git.matsuda-daisuke@fujitsu.com>
 <3edbcfacf7ff4fbe8b527a372ef73d1a6db17144.1684397037.git.matsuda-daisuke@fujitsu.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <3edbcfacf7ff4fbe8b527a372ef73d1a6db17144.1684397037.git.matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/18/23 03:21, Daisuke Matsuda wrote:
> Both responder and completer need to sleep to execute page-fault when used
> with ODP. It can happen when they are going to access user MRs, so tasks
> must be executed in process context for such cases.
> 
> Additionally, current implementation seldom defers tasks to workqueue, but
> instead defers to a softirq context running do_task(). It is called from
> rxe_resp_queue_pkt() and rxe_comp_queue_pkt() in SOFTIRQ_NET_RX context and
> can last until maximum RXE_MAX_ITERATIONS (=1024) loops are executed. The
> problem is the that task execuion appears to be anonymous loads in the
> system and that the loop can throttle other softirqs on the same CPU.
> 
> This patch makes responder and completer codes run in process context for
> ODP and the problem described above.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_comp.c        | 12 +-----------
>  drivers/infiniband/sw/rxe/rxe_hw_counters.c |  1 -
>  drivers/infiniband/sw/rxe/rxe_hw_counters.h |  1 -
>  drivers/infiniband/sw/rxe/rxe_resp.c        | 13 +------------
>  4 files changed, 2 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
> index db18ace74d2b..671fdb645030 100644
> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
> @@ -128,18 +128,8 @@ void retransmit_timer(struct timer_list *t)
>  
>  void rxe_comp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
>  {
> -	int must_sched;
> -
>  	skb_queue_tail(&qp->resp_pkts, skb);
> -
> -	must_sched = skb_queue_len(&qp->resp_pkts) > 1;
> -	if (must_sched != 0)
> -		rxe_counter_inc(SKB_TO_PKT(skb)->rxe, RXE_CNT_COMPLETER_SCHED);
> -
> -	if (must_sched)
> -		rxe_sched_task(&qp->comp.task);
> -	else
> -		rxe_run_task(&qp->comp.task);
> +	rxe_sched_task(&qp->comp.task);
>  }
>  
>  static inline enum comp_state get_wqe(struct rxe_qp *qp,
> diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.c b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
> index a012522b577a..dc23cf3a6967 100644
> --- a/drivers/infiniband/sw/rxe/rxe_hw_counters.c
> +++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.c
> @@ -14,7 +14,6 @@ static const struct rdma_stat_desc rxe_counter_descs[] = {
>  	[RXE_CNT_RCV_RNR].name             =  "rcvd_rnr_err",
>  	[RXE_CNT_SND_RNR].name             =  "send_rnr_err",
>  	[RXE_CNT_RCV_SEQ_ERR].name         =  "rcvd_seq_err",
> -	[RXE_CNT_COMPLETER_SCHED].name     =  "ack_deferred",
>  	[RXE_CNT_RETRY_EXCEEDED].name      =  "retry_exceeded_err",
>  	[RXE_CNT_RNR_RETRY_EXCEEDED].name  =  "retry_rnr_exceeded_err",
>  	[RXE_CNT_COMP_RETRY].name          =  "completer_retry_err",
> diff --git a/drivers/infiniband/sw/rxe/rxe_hw_counters.h b/drivers/infiniband/sw/rxe/rxe_hw_counters.h
> index 71f4d4fa9dc8..303da0e3134a 100644
> --- a/drivers/infiniband/sw/rxe/rxe_hw_counters.h
> +++ b/drivers/infiniband/sw/rxe/rxe_hw_counters.h
> @@ -18,7 +18,6 @@ enum rxe_counters {
>  	RXE_CNT_RCV_RNR,
>  	RXE_CNT_SND_RNR,
>  	RXE_CNT_RCV_SEQ_ERR,
> -	RXE_CNT_COMPLETER_SCHED,
>  	RXE_CNT_RETRY_EXCEEDED,
>  	RXE_CNT_RNR_RETRY_EXCEEDED,
>  	RXE_CNT_COMP_RETRY,
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 68f6cd188d8e..ba0222bfce9e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -46,21 +46,10 @@ static char *resp_state_name[] = {
>  	[RESPST_EXIT]				= "EXIT",
>  };
>  
> -/* rxe_recv calls here to add a request packet to the input queue */
>  void rxe_resp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
>  {
> -	int must_sched;
> -	struct rxe_pkt_info *pkt = SKB_TO_PKT(skb);
> -
>  	skb_queue_tail(&qp->req_pkts, skb);
> -
> -	must_sched = (pkt->opcode == IB_OPCODE_RC_RDMA_READ_REQUEST) ||
> -			(skb_queue_len(&qp->req_pkts) > 1);
> -
> -	if (must_sched)
> -		rxe_sched_task(&qp->resp.task);
> -	else
> -		rxe_run_task(&qp->resp.task);
> +	rxe_sched_task(&qp->resp.task);
>  }
>  
>  static inline enum resp_states get_req(struct rxe_qp *qp,

Looks good.

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>


