Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83A568BEFE
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Feb 2023 14:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjBFN5c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Feb 2023 08:57:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjBFN5P (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Feb 2023 08:57:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BDA27D5E;
        Mon,  6 Feb 2023 05:56:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E72660EF3;
        Mon,  6 Feb 2023 13:55:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C950C433AA;
        Mon,  6 Feb 2023 13:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675691749;
        bh=lIXsek5n6wDPJwQHFHqeRyxPTSxNcjqPYEciCIuzBWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M7dHnZY+z0hBSLVAbE/QJYOmu64NrsCeMJ4mbsvbMqZ8Gszujenbyk8I9LJtOCoUP
         tRXvRAhYmiK3lB9Zld8rt4V9NHOZt1EN7zZUWjyogAaQBOkqqwA9ZchN1hRIvb7FWG
         2n9F4fPf6h1qxgaFCG3Qm07aXGsvw8RR3QHVQxumXk4Rn8dA0KHs7C4pGmAlF9KzCa
         4BXAtpYbmuq5g6Fznh9gtPIgSAw+V/IrnXHatCh1Rvut/97cZl+4gWrqTz9PVyf+76
         nvBb+kPR5qaGlGkF1L4HBEpv9fMlI9CGexlvXKQ8FpeGPUgVf/ENYicQUwuCOWdabH
         4QBGSvJx0JKHw==
Date:   Mon, 6 Feb 2023 15:55:46 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc:     Potnuri Bharat Teja <bharat@chelsio.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] RDMA/cxgb4: Fix potential null-ptr-deref in
 pass_establish()
Message-ID: <Y+EG4uZnMr0lYPwU@unreal>
References: <Y9vdndjG0e9cCaI/@ziepe.ca>
 <20230202184850.29882-1-n.zhandarovich@fintech.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202184850.29882-1-n.zhandarovich@fintech.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 02, 2023 at 10:48:50AM -0800, Nikita Zhandarovich wrote:
> If get_ep_from_tid() fails to lookup non-NULL value for ep, ep is
> dereferenced later regardless of whether it is empty.
> This patch adds a simple sanity check to fix the issue.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 944661dd97f4 ("RDMA/iw_cxgb4: atomically lookup ep and get a reference")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
> v2: do not use pr_warn() when get_ep_from_tid() returns NULL as
> Jason Gunthorpe <jgg@ziepe.ca> suggested.
> 
>  drivers/infiniband/hw/cxgb4/cm.c | 2 ++
>  1 file changed, 2 insertions(+)

I applied, but please next time.
1. Don't send patches as reply-to. It messes whole patch flow.
2. Use target in subject line, e.g. [PATCH rdma-next] or [PATCH rdma-rc]

Thanks


> 
> diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
> index 499a425a3379..f5f4579f037c 100644
> --- a/drivers/infiniband/hw/cxgb4/cm.c
> +++ b/drivers/infiniband/hw/cxgb4/cm.c
> @@ -2676,6 +2676,8 @@ static int pass_establish(struct c4iw_dev *dev, struct sk_buff *skb)
>  	u16 tcp_opt = ntohs(req->tcp_opt);
>  
>  	ep = get_ep_from_tid(dev, tid);
> +	if (!ep)
> +		return 0;
>  	pr_debug("ep %p tid %u\n", ep, ep->hwtid);
>  	ep->snd_seq = be32_to_cpu(req->snd_isn);
>  	ep->rcv_seq = be32_to_cpu(req->rcv_isn);
> -- 
> 2.25.1
> 
