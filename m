Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B2F52A54B
	for <lists+linux-rdma@lfdr.de>; Tue, 17 May 2022 16:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244850AbiEQOvy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 May 2022 10:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349344AbiEQOvs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 May 2022 10:51:48 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D334192A5
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 07:51:46 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w123so22563220oiw.5
        for <linux-rdma@vger.kernel.org>; Tue, 17 May 2022 07:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Zvsvqlg5tb5I1MU/XfFP2vZFPX3ccrgBSECf3GGh4ts=;
        b=l8c+q0i0C/Pjn1jtikZ5hzcdAbgZ68Bu0NiUlbr7QyleUvGBOBCAtxgBPhZ5Ae22KA
         PFYf2UGR0fgNnmA6lVlCU5eI72XyWB+z1nB61NtYkj815cPfvI5p0xGSohEOoY3CF+if
         JjWlDIEtDCkhwEX7kqz5S6ESE8tfC9jdoBeJkrouXq9Z8zcB8Uq7W5ZgRwi0Msg8Byxf
         Yp3GoYQa1We+/sYtxQFuP9Q+2RnuA975TbuVYUUOpOKUz1rUFmACAh+NzsR8xiUsXkwO
         3VJmR3PkqVXs9+zkZP6Ei/Ylb6Zzyoy6WN+50dZL7HlVfQ2hjdtpoa+vPXnzqg5RnnKF
         GZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Zvsvqlg5tb5I1MU/XfFP2vZFPX3ccrgBSECf3GGh4ts=;
        b=YEgOUusxJ6oJjGjaTkFqzCpHtSgRlCvA38uROCs2SEDF7V5p7E1Vhgv7Dl2pwtMWol
         ywklWk8otEjN5P4pgcNQSDP11BWFcAks6b2NUUvYuQB+0VDpUkeva/Vc5NDV2ei6AYYQ
         wje8r4Xxd5fVrdge4rWh/ZKKFUnJQydFxbSvfdmZ0gH/R1JCFTS6Z2CnmDoI7LDtbIMM
         fSqOafH89zrIzOWPlAgj53/4ARAbivgTUlH9bWL/YapP8hGdfN7gy5beldo+9J1qSLcE
         BR9F1l3HWfpd6bI27N58OvpmYZXlZhZuGbDxkhOLD484JegsFaCfKk7x9KQYlwZmNrAB
         ZfAA==
X-Gm-Message-State: AOAM530AXfKZjJuswhwVMyHkw04ijhaHbimVnlu6P9wQaBYBy9gzYyDZ
        OuAm4XI+7QC72m0M1TNJWBK8fKCVQq4=
X-Google-Smtp-Source: ABdhPJx9sHrQH00xtxQYUKiO0vD+ZBYZX0eNj4b9yp72SPKswZSc9PF0sJUe1iBHhvv9ewRAjWTWYA==
X-Received: by 2002:aca:a8d7:0:b0:328:b19f:dbac with SMTP id r206-20020acaa8d7000000b00328b19fdbacmr7353753oie.243.1652799105561;
        Tue, 17 May 2022 07:51:45 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:d310:a4f5:635f:2e00? (2603-8081-140c-1a00-d310-a4f5-635f-2e00.res6.spectrum.com. [2603:8081:140c:1a00:d310:a4f5:635f:2e00])
        by smtp.gmail.com with ESMTPSA id g15-20020a9d6a0f000000b006060322124csm4980643otn.28.2022.05.17.07.51.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 May 2022 07:51:45 -0700 (PDT)
Message-ID: <c9e99081-f6aa-0167-77ff-57533b107e90@gmail.com>
Date:   Tue, 17 May 2022 09:51:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/1] RDMA/rxe: Compact the function
 free_rd_atomic_resource
Content-Language: en-US
To:     yanjun.zhu@linux.dev, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
References: <20220517190800.122757-1-yanjun.zhu@linux.dev>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220517190800.122757-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/17/22 14:08, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Compact the function and move it to the header file.
I have two issues with this patch.

There is no advantage of having an inline function in a header file
that is only called once. The compiler is perfectly capable of (and does)
inlining a static function in a .c file if only called once. This just
makes the code harder to read.

There is a patch in for-rc that gets rid of read.mr in favor of an rkey.
This patch is out of date.

Bob
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_loc.h  | 11 ++++++++++-
>  drivers/infiniband/sw/rxe/rxe_qp.c   | 15 ++-------------
>  drivers/infiniband/sw/rxe/rxe_resp.c |  4 ++--
>  3 files changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 409efeecd581..6517b4f104b1 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -145,7 +145,16 @@ static inline int rcv_wqe_size(int max_sge)
>  		max_sge * sizeof(struct ib_sge);
>  }
>  
> -void free_rd_atomic_resource(struct rxe_qp *qp, struct resp_res *res);
> +static inline void free_rd_atomic_resource(struct resp_res *res)
> +{
> +	if (res->type == RXE_ATOMIC_MASK) {
> +		kfree_skb(res->atomic.skb);
> +	} else if (res->type == RXE_READ_MASK) {
> +		if (res->read.mr)
> +			rxe_drop_ref(res->read.mr);
> +	}
> +	res->type = 0;
> +}
>  
>  static inline void rxe_advance_resp_resource(struct rxe_qp *qp)
>  {
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index 5f270cbf18c6..b29208852bc4 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -126,24 +126,13 @@ static void free_rd_atomic_resources(struct rxe_qp *qp)
>  		for (i = 0; i < qp->attr.max_dest_rd_atomic; i++) {
>  			struct resp_res *res = &qp->resp.resources[i];
>  
> -			free_rd_atomic_resource(qp, res);
> +			free_rd_atomic_resource(res);
>  		}
>  		kfree(qp->resp.resources);
>  		qp->resp.resources = NULL;
>  	}
>  }
>  
> -void free_rd_atomic_resource(struct rxe_qp *qp, struct resp_res *res)
> -{
> -	if (res->type == RXE_ATOMIC_MASK) {
> -		kfree_skb(res->atomic.skb);
> -	} else if (res->type == RXE_READ_MASK) {
> -		if (res->read.mr)
> -			rxe_drop_ref(res->read.mr);
> -	}
> -	res->type = 0;
> -}
> -
>  static void cleanup_rd_atomic_resources(struct rxe_qp *qp)
>  {
>  	int i;
> @@ -152,7 +141,7 @@ static void cleanup_rd_atomic_resources(struct rxe_qp *qp)
>  	if (qp->resp.resources) {
>  		for (i = 0; i < qp->attr.max_dest_rd_atomic; i++) {
>  			res = &qp->resp.resources[i];
> -			free_rd_atomic_resource(qp, res);
> +			free_rd_atomic_resource(res);
>  		}
>  	}
>  }
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index c369d78fc8e8..923a71ff305c 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -663,7 +663,7 @@ static enum resp_states read_reply(struct rxe_qp *qp,
>  		 */
>  		res = &qp->resp.resources[qp->resp.res_head];
>  
> -		free_rd_atomic_resource(qp, res);
> +		free_rd_atomic_resource(res);
>  		rxe_advance_resp_resource(qp);
>  
>  		res->type		= RXE_READ_MASK;
> @@ -977,7 +977,7 @@ static int send_atomic_ack(struct rxe_qp *qp, struct rxe_pkt_info *pkt,
>  	}
>  
>  	res = &qp->resp.resources[qp->resp.res_head];
> -	free_rd_atomic_resource(qp, res);
> +	free_rd_atomic_resource(res);
>  	rxe_advance_resp_resource(qp);
>  
>  	skb_get(skb);

