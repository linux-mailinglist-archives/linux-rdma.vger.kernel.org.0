Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14E16E5BAD
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Apr 2023 10:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbjDRIKP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Apr 2023 04:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjDRIKK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Apr 2023 04:10:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF5F76A8
        for <linux-rdma@vger.kernel.org>; Tue, 18 Apr 2023 01:09:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57342614B8
        for <linux-rdma@vger.kernel.org>; Tue, 18 Apr 2023 08:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF6BC433EF;
        Tue, 18 Apr 2023 08:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681805290;
        bh=xJes2lNGawdO5mEOeG5e0I7NqVQ89WYwdLLE4LXgJOQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sB6Xo7mkVOp+3CZ9VdjoUU7R8WRbszCkLBkWJCd43VLTbDkNJs/sYB/hZiI9sQ+Dr
         86LivsDeqWkT/bYKt3En25A8clUYwg2xwPu5dZoY/gdAG1XXUcYySdVDWa5PpFvoOZ
         oiKX6YeAf03zmcCgJAvtsm7aDWVD7Q8jT/w6xvWEadHAp0Cs97mn7/+v5yFqtkO+Td
         SOStSbB/EouCQeWxhwMUGqKpTBvMnqH1Jf2DutMITkNfXbkLtETYEtKU5ub/hCHjNZ
         FJ214AscpQFfXM73chrJ0gdb0a89GxPlqbJs+NXUQJnnJotKhUKjC5MDNYqhHs35ol
         Mlo2SkWtb7CDA==
Date:   Tue, 18 Apr 2023 11:08:07 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH 1/1] RDMA/rxe: Add function name to the logs
Message-ID: <20230418080807.GD9740@unreal>
References: <20230410102105.1084967-1-yanjun.zhu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410102105.1084967-1-yanjun.zhu@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 10, 2023 at 06:21:05PM +0800, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Add the function names to the pr_ logs. As such, if some bugs occur,
> with function names, it is easy to locate the bugs.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe.h       |  2 +-
>  drivers/infiniband/sw/rxe/rxe_queue.h | 12 ++++--------
>  2 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.h b/drivers/infiniband/sw/rxe/rxe.h
> index 2415f3704f57..43742d2f32de 100644
> --- a/drivers/infiniband/sw/rxe/rxe.h
> +++ b/drivers/infiniband/sw/rxe/rxe.h
> @@ -10,7 +10,7 @@
>  #ifdef pr_fmt
>  #undef pr_fmt
>  #endif
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#define pr_fmt(fmt) KBUILD_MODNAME ": %s: " fmt, __func__
>  
>  #include <linux/skbuff.h>
>  
> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.h b/drivers/infiniband/sw/rxe/rxe_queue.h
> index c711cb98b949..5d6e17b00e60 100644
> --- a/drivers/infiniband/sw/rxe/rxe_queue.h
> +++ b/drivers/infiniband/sw/rxe/rxe_queue.h
> @@ -185,8 +185,7 @@ static inline void queue_advance_producer(struct rxe_queue *q,
>  	case QUEUE_TYPE_FROM_CLIENT:
>  		/* used by rxe, client owns the index */
>  		if (WARN_ON(1))
> -			pr_warn("%s: attempt to advance client index\n",
> -				__func__);
> +			pr_warn("attempt to advance client index\n");

Delete all if (WARN_ON(1)) pr_warn(...) in favour of plain WARN_ON().
It will give you all information which you need.

Thanks
