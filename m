Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA735018F8
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Apr 2022 18:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238916AbiDNQoo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Apr 2022 12:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245368AbiDNQnO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Apr 2022 12:43:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEC21168C8
        for <linux-rdma@vger.kernel.org>; Thu, 14 Apr 2022 09:12:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA3D1B82A6F
        for <linux-rdma@vger.kernel.org>; Thu, 14 Apr 2022 16:12:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAB9C385A1;
        Thu, 14 Apr 2022 16:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649952776;
        bh=YEwGGrCmOuml11IxY2pcrbwmImmo7uiSG9ps8CXDkAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BYGxpuU7iN+DBB+CdAwA5bElgsV6kvty/FLSYp6FhYXWvNPWUScxYeGn80a/PTdR8
         N+OKQzSThhQEV7N4akZuAh6eFbqqsurf2MmJm6fZI9FdenugNpk6eQrf2Gz+6T3nVO
         RvzPvaQMiMx0sSUxgukIRLW0QoGf76k4zhB/zuxDLnGT46VuYgXqDGkkI66Juw7Gju
         4pXS8S7dWlI7rTSIHUZltAi1ANf2kvAuvSUjDOEIAJ6g9NFG0jADYAqRutarlVTYfP
         VJ6REd6406LacUZvA9ecKGiYWhpqhq12EBsbRCwDdxmE3sf5Qt4qqjqrXpVvDJUT1r
         ydVl/4EpFKSXg==
Date:   Thu, 14 Apr 2022 19:12:52 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCHv3 1/1] RDMA/rxe: Fix a dead lock problem
Message-ID: <YlhIBI4NmAvK7E5S@unreal>
References: <20220413074208.1401112-1-yanjun.zhu@linux.dev>
 <20220413004504.GH64706@ziepe.ca>
 <81db8dcc-e417-bff5-b7ec-1067c717ea62@linux.dev>
 <56c4e893-223d-ad6b-2fa9-ca8b2aace9de@linux.dev>
 <20220414135255.GK64706@ziepe.ca>
 <75363d6a-99f2-f61a-0f41-87e641746efa@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75363d6a-99f2-f61a-0f41-87e641746efa@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 14, 2022 at 11:13:57PM +0800, Yanjun Zhu wrote:
> 在 2022/4/14 21:52, Jason Gunthorpe 写道:
> > On Thu, Apr 14, 2022 at 09:01:29PM +0800, Yanjun Zhu wrote:
> > 
> > > > > Still no, this does almost every allocation - only AH with the
> > > > > non-blocking flag set should use this path.
> > 
> > > To the function ib_send_cm_req, the call chain is as below.
> > > 
> > > ib_send_cm_req --> cm_alloc_priv_msg --> cm_alloc_msg --> rdma_create_ah -->
> > > _rdma_create_ah --> rxe_create_ah --> rxe_av_chk_attr -->__rxe_add_to_pool
> > > 
> > > As such, xa_lock_irqsave/irqrestore is selected.
> > 
> > As I keep saying, only the rxe_create_ah() with the non-blocking flag
> > set should use the GFP_ATOMIC. All other paths must use GFP_KERNEL.
> > 
> 
> Got it. The GFP_ATOMIC/GFP_KERNEL are used in different paths.
> rxe_create_ah will use GFP_ATOMIC and others will use GFP_KERNEL.
> So the codes should be as below:
> 
> -int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
> +int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
> gfp_t gfp)
>  {
>         int err;
> +       unsigned long flags;
> 
>         if (WARN_ON(pool->flags & RXE_POOL_ALLOC))
>                 return -EINVAL;
> @@ -168,10 +170,17 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct
> rxe_pool_elem *elem)
>         elem->obj = (u8 *)elem - pool->elem_offset;
>         kref_init(&elem->ref_cnt);
> 
> -       xa_lock_irq(&pool->xa);
> -       err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> -                               &pool->next, GFP_ATOMIC);
> -       xa_unlock_irq(&pool->xa);
> +       if (gfp == GFP_ATOMIC) { /* for rxe_create_ah */

gfp is bitfield.
"gfp == GFP_ATOMIC" -> "gfp & GFP_ATOMIC"

Thanks
