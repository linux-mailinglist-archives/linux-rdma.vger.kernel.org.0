Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022CB6F66DA
	for <lists+linux-rdma@lfdr.de>; Thu,  4 May 2023 10:10:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjEDIJr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 4 May 2023 04:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjEDIJM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 4 May 2023 04:09:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6CB5241
        for <linux-rdma@vger.kernel.org>; Thu,  4 May 2023 01:07:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58948631F1
        for <linux-rdma@vger.kernel.org>; Thu,  4 May 2023 08:07:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C71C433EF;
        Thu,  4 May 2023 08:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683187655;
        bh=Khzb4eFDnpXqKGDnmnon4hRs6jdgd+QXbUgG1ocZzCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JjGEy6B4efrZSW1iWIv6//TbedynPlFYxDzKTqkw3SIQyFSpv0pFrn9x/OGHJFcwB
         7LPFcjqWThV1pukazFlO+aNxlc3ZolDI98tFHhIfuynIfomjbFWM/cKYy+hFi0ncI2
         qW3vunbaM+CyZH0XbcX+0X+YOVvF5rJQyTvjYwU4kQtE6C5LnDVH4HE2GXcLVmSdhU
         /T0xlYSlw/kB2VpPDL7z4rp0QDBAGqRdaEetH1G3p8x0UVeFrl0Mqj+rMSY8eJd8PQ
         vNM2lBIWZPl3q/m90qTa6dVe8nVNIisBrZmmbsBFCRU7afwqWwCLZ0mmTVHB9ZFTY4
         cXK4riLpfmm/Q==
Date:   Thu, 4 May 2023 11:07:31 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     rpearsonhpe@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [bug report] RDMA/rxe: Protect QP state with qp->state_lock
Message-ID: <20230504080731.GT525452@unreal>
References: <27773078-40ce-414f-8b97-781954da9f25@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27773078-40ce-414f-8b97-781954da9f25@kili.mountain>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 04, 2023 at 10:28:59AM +0300, Dan Carpenter wrote:
> Hello Bob Pearson,
> 
> The patch f605f26ea196: "RDMA/rxe: Protect QP state with
> qp->state_lock" from Apr 4, 2023, leads to the following Smatch
> static checker warning:
> 
> 	drivers/infiniband/sw/rxe/rxe_qp.c:716 rxe_qp_to_attr()
> 	error: double unlocked '&qp->state_lock' (orig line 713)
> 
> drivers/infiniband/sw/rxe/rxe_qp.c
>     705         rxe_av_to_attr(&qp->pri_av, &attr->ah_attr);
>     706         rxe_av_to_attr(&qp->alt_av, &attr->alt_ah_attr);
>     707 
>     708         /* Applications that get this state typically spin on it.
>     709          * Yield the processor
>     710          */
>     711         spin_lock_bh(&qp->state_lock);
>     712         if (qp->attr.sq_draining) {
>     713                 spin_unlock_bh(&qp->state_lock);
>                              ^^^^^^
> Unlock
> 
>     714                 cond_resched();
>     715         }

Arguably, lines 708-716 should be deleted.

Thanks

> --> 716         spin_unlock_bh(&qp->state_lock);
>                      ^^^^^^
> Double unlock
> 
>     717 
>     718         return 0;
>     719 }
> 
> regards,
> dan carpenter
