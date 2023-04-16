Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD446E3978
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Apr 2023 16:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjDPOoB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Apr 2023 10:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjDPOoA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 16 Apr 2023 10:44:00 -0400
Received: from out-41.mta1.migadu.com (out-41.mta1.migadu.com [95.215.58.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B24E26BA
        for <linux-rdma@vger.kernel.org>; Sun, 16 Apr 2023 07:43:58 -0700 (PDT)
Message-ID: <5eafd0d6-f1fb-a9d8-3337-1f4b1691fa91@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1681656236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nVaooAlQNOj6EZBX9nYz8T3rAllPt2W+TkhY3/+hCz0=;
        b=jJRCoEUyNGhKfu5NQe2qlAXfsQip3aY0D4OA2gLA+RnAgOfOhQYU4oruyjOY3i5fURh+42
        rwY/lHcG1pq5Po3WYz1O88asihLpIhuh6RZIxj+kUcUFMfIYcVZxtcihV4aXs+MPkuXoWo
        PwU/dt6bKaUEPrqf/eBCG0+98P+SG04=
Date:   Sun, 16 Apr 2023 22:43:48 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] RDMA/rxe: Add function name to the logs
To:     Zhu Yanjun <yanjun.zhu@intel.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org
References: <20230410102105.1084967-1-yanjun.zhu@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230410102105.1084967-1-yanjun.zhu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/4/10 18:21, Zhu Yanjun 写道:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Add the function names to the pr_ logs. As such, if some bugs occur,
> with function names, it is easy to locate the bugs.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Gently ping

Zhu Yanjun

> ---
>   drivers/infiniband/sw/rxe/rxe.h       |  2 +-
>   drivers/infiniband/sw/rxe/rxe_queue.h | 12 ++++--------
>   2 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
> index 2415f3704f57..43742d2f32de 100644
> --- a/drivers/infiniband/sw/rxe/rxe.h
> +++ b/drivers/infiniband/sw/rxe/rxe.h
> @@ -10,7 +10,7 @@
>   #ifdef pr_fmt
>   #undef pr_fmt
>   #endif
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
>   
>   #include <linux/skbuff.h>
>   
> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
> index c711cb98b949..5d6e17b00e60 100644
> --- a/drivers/infiniband/sw/rxe/rxe_queue.h
> +++ b/drivers/infiniband/sw/rxe/rxe_queue.h
> @@ -185,8 +185,7 @@ static inline void queue_advance_producer(struct rxe_queue *q,
>   	case QUEUE_TYPE_FROM_CLIENT:
>   		/* used by rxe, client owns the index */
>   		if (WARN_ON(1))
> -			pr_warn("%s: attempt to advance client index\n",
> -				__func__);
> +			pr_warn("attempt to advance client index\n");
>   		break;
>   	case QUEUE_TYPE_TO_CLIENT:
>   		/* used by rxe which owns the index */
> @@ -206,8 +205,7 @@ static inline void queue_advance_producer(struct rxe_queue *q,
>   	case QUEUE_TYPE_TO_ULP:
>   		/* used by ulp, rxe owns the index */
>   		if (WARN_ON(1))
> -			pr_warn("%s: attempt to advance driver index\n",
> -				__func__);
> +			pr_warn("attempt to advance driver index\n");
>   		break;
>   	}
>   }
> @@ -228,14 +226,12 @@ static inline void queue_advance_consumer(struct rxe_queue *q,
>   	case QUEUE_TYPE_TO_CLIENT:
>   		/* used by rxe, client owns the index */
>   		if (WARN_ON(1))
> -			pr_warn("%s: attempt to advance client index\n",
> -				__func__);
> +			pr_warn("attempt to advance client index\n");
>   		break;
>   	case QUEUE_TYPE_FROM_ULP:
>   		/* used by ulp, rxe owns the index */
>   		if (WARN_ON(1))
> -			pr_warn("%s: attempt to advance driver index\n",
> -				__func__);
> +			pr_warn("attempt to advance driver index\n");
>   		break;
>   	case QUEUE_TYPE_TO_ULP:
>   		/* used by ulp which owns the index */

