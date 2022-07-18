Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE635780D4
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Jul 2022 13:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233220AbiGRLdU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Jul 2022 07:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbiGRLdT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Jul 2022 07:33:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A084B1FCF7
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 04:33:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 411B561226
        for <linux-rdma@vger.kernel.org>; Mon, 18 Jul 2022 11:33:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00265C341C0;
        Mon, 18 Jul 2022 11:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658143997;
        bh=G5aFLshZmO/rP19TGbupyMi6G0livTwCe3VhBMkJTk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K21HeyPOIBHxYTCtOSTzgF4VWEdRFZLGACZ3EC8oJs+4GpY8B3FGL17Q+06fGdo5p
         FcZu/3v1Yho/ssPaBOx9ScAESP0lLAD3/FQPvudktyd+ShvWQODjyPdBMgeF6pprEp
         zYfi1JDO4g5827Pxkz0Y3ivHNHsz8FPr8EZK6GYgp/qaEiRnuMqpSSldsc/yyJqUjM
         lcvi48iB4Hoe5ngb7m93DKkpkTjreYgtXd5TQmy+HF4KSdOpro27dAwyjWEUFAf+Dr
         vbGodOBWTvYzBoMHnTp20j30Xlxn8qXTHQBvJPVT5E4sir36bS4G8xgWS26HHB+mb3
         TRH2lqcHSJQrw==
Date:   Mon, 18 Jul 2022 14:33:13 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     yanjun.zhu@linux.dev
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCHv2 1/1] RDMA/rxe: Fix BUG: KASAN: null-ptr-deref in
 rxe_qp_do_cleanup
Message-ID: <YtVE+YpjEwNrzmsQ@unreal>
References: <20220705225414.315478-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705225414.315478-1-yanjun.zhu@linux.dev>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 05, 2022 at 06:54:14PM -0400, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> The function rxe_create_qp calls rxe_qp_from_init. If some error
> occurs, the error handler of function rxe_qp_from_init will set
> both scq and rcq to NULL.
> 
> Then rxe_create_qp calls rxe_put to handle qp. In the end,
> rxe_qp_do_cleanup is called by rxe_put. rxe_qp_do_cleanup directly
> accesses scq and rcq before checking them. This will cause 
> null-ptr-deref error.
> 
> The call graph is as below:
> 
> rxe_create_qp {
>   ...
>   rxe_qp_from_init {
>     ...
>   err1:
>     ...
>     qp->rcq = NULL;  <---rcq is set to NULL
>     qp->scq = NULL;  <---scq is set to NULL
>     ...
>   }
>         
> qp_init:
>   rxe_put{
>     ...
>     rxe_qp_do_cleanup {
>       ...
>       atomic_dec(&qp->scq->num_wq); <--- scq is accessed
>       ...
>       atomic_dec(&qp->rcq->num_wq); <--- rcq is accessed
>     }
> }
> 
> Fixes: 4703b4f0d94a ("RDMA/rxe: Enforce IBA C11-17")
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
> V1->V2: Describe the error flows.
> ---
>  drivers/infiniband/sw/rxe/rxe_qp.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 

Thanks, applied.
