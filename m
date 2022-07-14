Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0BA5753BF
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jul 2022 19:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbiGNRI3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jul 2022 13:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiGNRI3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jul 2022 13:08:29 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1C228711
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 10:08:27 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id j70so3099272oih.10
        for <linux-rdma@vger.kernel.org>; Thu, 14 Jul 2022 10:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=i7nPmOhO4/W22RWflezeSDi8NUVxAax/VWiPQ+pAj1A=;
        b=MXlJAJEsVaKLFnBusIck4gudeoLsBwLVUm8xoq8qHrp4bl9wwjmiJwiFp7t5ONf63t
         CCdIJ27wrDzDuSjfxpYejABIPOxK26cjat8KObGMuqYzJRH5NbRI2SgM/hduqfxsWvjV
         GCJZz79bT36KlvQlu/rirjUjOEuxaG6HQqUInbs2U09aWq9QU8PCLeGVlAdPymGaWFAM
         Oig4tZsR7ZwfdXSfoFIPiMyTWfFa4bvX/tyc273oqoq+AyqhRS9qzASLu0oYnJFulexb
         E5S1Y5TdcRf6LDdiLcm79PmUnDY3xz13njvUkl6ln9deJjYFsgqoGWWvzNpvq2VPKCGf
         4UUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i7nPmOhO4/W22RWflezeSDi8NUVxAax/VWiPQ+pAj1A=;
        b=hbX99AkY8Zcyy34+rq57GgG7yVS5smFTsmq6yT70Rze2zOL8s3xNeX3Iu1jwFM4k0X
         XNiNMeFh8pqRpjoKq5oilv//IFG+Af2D1+3mVQuiOSdRmegUu6xJsws9hmVHaANwy92N
         XVTtUmX822vHSzaJErJL48vfyFi448edta8yTSNMi86604Zh7E0eOj+f7BYa7nmihRPP
         Jbs5FYWPUlwLIzDh5Y3hJagCYq2uvkhhVk1sU1UsnO+ERCp1ycfPITtYcQ0lONqdpYDJ
         OBKgn6fWyf/GvyDGyyijHQENm2UXzilv5gln7Df1pfHoqkvrXJnpQ/7AKKNzwH5FJcjq
         7cXQ==
X-Gm-Message-State: AJIora/MCFmbX2iAvYV1wlQ/a8uAwKC9RVNO7gT8XLl1uVdQ/sTTxbtF
        JDWZGmYqazrOKkSpu96wTh8=
X-Google-Smtp-Source: AGRyM1s2hJOtjeM0xtcLn4UME5azfNi7dlG7sgE6kkZLX0v4kXmXAkx7fklaj6Q0tbkmSavAkJ8EQQ==
X-Received: by 2002:a05:6808:17a6:b0:337:bc20:4bcb with SMTP id bg38-20020a05680817a600b00337bc204bcbmr4974550oib.16.1657818507357;
        Thu, 14 Jul 2022 10:08:27 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:e02a:9936:8f26:4598? (2603-8081-140c-1a00-e02a-9936-8f26-4598.res6.spectrum.com. [2603:8081:140c:1a00:e02a:9936:8f26:4598])
        by smtp.gmail.com with ESMTPSA id 16-20020a9d0e90000000b0061c309b1dc2sm886701otj.39.2022.07.14.10.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 10:08:26 -0700 (PDT)
Message-ID: <417d778e-6047-d4c8-a33f-a8da9cbbaee3@gmail.com>
Date:   Thu, 14 Jul 2022 12:08:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Add common rxe_prepare_res()
Content-Language: en-US
To:     Xiao Yang <yangx.jy@fujitsu.com>, linux-rdma@vger.kernel.org
Cc:     leon@kernel.org, jgg@ziepe.ca, zyjzyj2000@gmail.com
References: <20220705145212.12014-1-yangx.jy@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220705145212.12014-1-yangx.jy@fujitsu.com>
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

On 7/5/22 09:52, Xiao Yang wrote:
> It's redundant to prepare resources for Read and Atomic
> requests by different functions. Replace them by a common
> rxe_prepare_res() with different parameters. In addition,
> the common rxe_prepare_res() can also be used by new Flush
> and Atomic Write requests in the future.
> 
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_resp.c | 71 +++++++++++++---------------
>  1 file changed, 32 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index ccdfc1a6b659..5536582b8fe4 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -553,27 +553,48 @@ static enum resp_states write_data_in(struct rxe_qp *qp,
>  	return rc;
>  }
>  
> -/* Guarantee atomicity of atomic operations at the machine level. */
> -static DEFINE_SPINLOCK(atomic_ops_lock);
> -
> -static struct resp_res *rxe_prepare_atomic_res(struct rxe_qp *qp,
> -					       struct rxe_pkt_info *pkt)
> +static struct resp_res *rxe_prepare_res(struct rxe_qp *qp,
> +					struct rxe_pkt_info *pkt,
> +					int type)
>  {
>  	struct resp_res *res;
> +	u32 pkts;
>  
>  	res = &qp->resp.resources[qp->resp.res_head];
>  	rxe_advance_resp_resource(qp);
>  	free_rd_atomic_resource(qp, res);
>  
> -	res->type = RXE_ATOMIC_MASK;
> -	res->first_psn = pkt->psn;
> -	res->last_psn = pkt->psn;
> -	res->cur_psn = pkt->psn;
> +	res->type = type;
>  	res->replay = 0;
>  
> +	switch (type) {
> +	case RXE_READ_MASK:
> +		res->read.va = qp->resp.va + qp->resp.offset;
> +		res->read.va_org = qp->resp.va + qp->resp.offset;
> +		res->read.resid = qp->resp.resid;
> +		res->read.length = qp->resp.resid;
> +		res->read.rkey = qp->resp.rkey;
> +
> +		pkts = max_t(u32, (reth_len(pkt) + qp->mtu - 1)/qp->mtu, 1);
> +		res->first_psn = pkt->psn;
> +		res->cur_psn = pkt->psn;
> +		res->last_psn = (pkt->psn + pkts - 1) & BTH_PSN_MASK;
> +
> +		res->state = rdatm_res_state_new;
> +		break;
> +	case RXE_ATOMIC_MASK:
> +		res->first_psn = pkt->psn;
> +		res->last_psn = pkt->psn;
> +		res->cur_psn = pkt->psn;
> +		break;
> +	}
> +
>  	return res;
>  }
>  
> +/* Guarantee atomicity of atomic operations at the machine level. */
> +static DEFINE_SPINLOCK(atomic_ops_lock);
> +
>  static enum resp_states rxe_atomic_reply(struct rxe_qp *qp,
>  					 struct rxe_pkt_info *pkt)
>  {
> @@ -584,7 +605,7 @@ static enum resp_states rxe_atomic_reply(struct rxe_qp *qp,
>  	u64 value;
>  
>  	if (!res) {
> -		res = rxe_prepare_atomic_res(qp, pkt);
> +		res = rxe_prepare_res(qp, pkt, RXE_ATOMIC_MASK);
>  		qp->resp.res = res;
>  	}
>  
> @@ -680,34 +701,6 @@ static struct sk_buff *prepare_ack_packet(struct rxe_qp *qp,
>  	return skb;
>  }
>  
> -static struct resp_res *rxe_prepare_read_res(struct rxe_qp *qp,
> -					struct rxe_pkt_info *pkt)
> -{
> -	struct resp_res *res;
> -	u32 pkts;
> -
> -	res = &qp->resp.resources[qp->resp.res_head];
> -	rxe_advance_resp_resource(qp);
> -	free_rd_atomic_resource(qp, res);
> -
> -	res->type = RXE_READ_MASK;
> -	res->replay = 0;
> -	res->read.va = qp->resp.va + qp->resp.offset;
> -	res->read.va_org = qp->resp.va + qp->resp.offset;
> -	res->read.resid = qp->resp.resid;
> -	res->read.length = qp->resp.resid;
> -	res->read.rkey = qp->resp.rkey;
> -
> -	pkts = max_t(u32, (reth_len(pkt) + qp->mtu - 1)/qp->mtu, 1);
> -	res->first_psn = pkt->psn;
> -	res->cur_psn = pkt->psn;
> -	res->last_psn = (pkt->psn + pkts - 1) & BTH_PSN_MASK;
> -
> -	res->state = rdatm_res_state_new;
> -
> -	return res;
> -}
> -
>  /**
>   * rxe_recheck_mr - revalidate MR from rkey and get a reference
>   * @qp: the qp
> @@ -778,7 +771,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>  	struct rxe_mr *mr;
>  
>  	if (!res) {
> -		res = rxe_prepare_read_res(qp, req_pkt);
> +		res = rxe_prepare_res(qp, req_pkt, RXE_READ_MASK);
>  		qp->resp.res = res;
>  	}
>  

Looks good.

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
