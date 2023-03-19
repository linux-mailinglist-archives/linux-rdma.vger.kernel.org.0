Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7176C00E9
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Mar 2023 12:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjCSLlk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 19 Mar 2023 07:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbjCSLli (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 19 Mar 2023 07:41:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE6B1CAF4;
        Sun, 19 Mar 2023 04:41:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 584FD60FCB;
        Sun, 19 Mar 2023 11:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AF5FC433D2;
        Sun, 19 Mar 2023 11:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679226095;
        bh=ExZwx8jh/Z19yiEgpkbK+BLckhnmEjECfuwpp5U7nW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ha8+NoV5KMotFaVzeYbTTD0suS9RQhwThazW8291t+hgww4f0xcPfrj9jgFcFOf5v
         2L7C2u1/bVqlT97R7EHX1ke2bQkA/gTuxbaw9ce9AMWEqb7cnohczlyJ9GrZIRXfqP
         pyJxs2ofUrBoG9XjYnSAyZVvXK943irTuZlpKGoo64viKasN/0aCS+nzz3vFaOpGfk
         oZIiFfawDpAoHNBPf9TodIQg9XuxGEkHu+KGPT1CXtbVE1oW4f8dq3WzoPfMrwDjQ4
         H3U/+90PtAdU/D0gMVkRZkIGrnSXUmqwWXP9bbV2CoA8VqUQYGfQNrM8OwXUYZM42u
         6C20zTKGgbUrw==
Date:   Sun, 19 Mar 2023 13:41:31 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org,
        Cheng Xu <chengyou@linux.alibaba.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Kai Shen <kaishen@linux.alibaba.com>,
        Yang Li <yang.lee@linux.alibaba.com>, cocci@inria.fr,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/erdma: Fix exception handling in
 erdma_accept_newconn()
Message-ID: <20230319114131.GC36557@unreal>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <f0f96f74-21d1-f5bf-1086-1c3ce0ea18f5@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0f96f74-21d1-f5bf-1086-1c3ce0ea18f5@web.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Mar 18, 2023 at 09:15:58PM +0100, Markus Elfring wrote:
> Date: Sat, 18 Mar 2023 21:08:58 +0100
> 
> The label “error” was used to jump to another pointer check despite of
> the detail in the implementation of the function “erdma_accept_newconn”
> that it was determined already that corresponding variables contained
> still null pointers.
> 
> 1. Thus return directly if
>    * the cep state is not the value “ERDMA_EPSTATE_LISTENING”
>      or
>    * a call of the function “erdma_cep_alloc” failed.
> 
> 2. Use more appropriate labels instead.
> 
> 3. Delete two questionable checks.
> 
> 4. Omit extra initialisations (for the variables “new_cep”, “new_s” and “ret”)
>    which became unnecessary with this refactoring.
> 
> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: 920d93eac8b97778fef48f34f10e58ddf870fc2a ("RDMA/erdma: Add connection management (CM) support")
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/infiniband/hw/erdma/erdma_cm.c | 39 +++++++++++---------------
>  1 file changed, 17 insertions(+), 22 deletions(-)

Same comment as for your RDMA/siw patch.

Thanks
