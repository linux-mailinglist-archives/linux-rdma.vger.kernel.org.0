Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7196861D8
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Feb 2023 09:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjBAIk0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 Feb 2023 03:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjBAIk0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 1 Feb 2023 03:40:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6535C0F4
        for <linux-rdma@vger.kernel.org>; Wed,  1 Feb 2023 00:40:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A77D8B82131
        for <linux-rdma@vger.kernel.org>; Wed,  1 Feb 2023 08:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9F2C4339E;
        Wed,  1 Feb 2023 08:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675240822;
        bh=yXMuOVXi30gkrJf/G6YHddBj1idNTe/sitL7VkxFSv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m89sZCNzdc3rZjV9QsF6lcfSxmwcjheM+wPBy3jylRACAOQi6MiN8uggP3PzR1qZF
         S05hZeLSfA4NDtWdQ5nfGU81CsVx5dGnXyoey2PuBP2BnB0meVo2A6keJ32sOaId5r
         iXx7MHsk4JD84EFzU+0Me5KFj06q7SVKNYeakzJz4VTF2mZzLh6kqG8ly4KwqSsM30
         eowF+ljEdZ63bl11WX70zm2jOL+nLQBj9AGe/UnfeZKG/8qat8O3wERlu8AUNFXiad
         9KUDpbN7QBerRyyu7uDoAJgtSCMr1DsUl3eZN77llIBC071cbMSllN+uJ+D46H//3j
         sTgaqxXXF/eHw==
Date:   Wed, 1 Feb 2023 10:40:17 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Dean Luick <dean.luick@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/7] FIXME and other fixes
Message-ID: <Y9olcZ7PWIzc6BqS@unreal>
References: <Y8T5602bNhscGixb@unreal>
 <a1efafe0-1c8e-60ae-cc77-b3592ea5b989@cornelisnetworks.com>
 <Y8rK16KNpj0lzQ2a@unreal>
 <Y8rSiD5s+ZFV666t@nvidia.com>
 <a830a1f2-0042-4fc6-7416-da8a8d2d1fe6@cornelisnetworks.com>
 <Y8z+ZH69DRxw+b6c@unreal>
 <6a495007-0c84-3c7b-e3bb-9eadb1b92f54@cornelisnetworks.com>
 <6e74d22f-a583-0cf5-fe06-ac641f976f0e@cornelisnetworks.com>
 <Y9ksq0qce6iopG83@nvidia.com>
 <cc1c9687-9537-b514-29e0-4fc764d93b09@cornelisnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc1c9687-9537-b514-29e0-4fc764d93b09@cornelisnetworks.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jan 31, 2023 at 11:57:22AM -0500, Dennis Dalessandro wrote:
> On 1/31/23 9:58 AM, Jason Gunthorpe wrote:
> > On Mon, Jan 30, 2023 at 04:57:56PM -0500, Dennis Dalessandro wrote:
> > 
> >> I didn't see this make it out yet. Can this still make it in for -rc? Based on
> >> Jason's reply [1] sounds like it will just work itself out in for-next.
> >>
> >> [1] https://lore.kernel.org/linux-rdma/Y8rSiD5s+ZFV666t@nvidia.com/
> > 
> > Well, it looks OK to me, you should do a test merge yourself and
> > confirm nothing got mangled
> 
> I tested this last week by cherry picking:
> 
> a479433a6b7a ("IB/hfi1: Assign npages earlier")
> 
> onto for-rc, then merged for-rc into for-next. Looks ok. No conflicts.

Jason took this patch to his wip/jgg-for-rc branch.

Thanks

> 
> -Denny
