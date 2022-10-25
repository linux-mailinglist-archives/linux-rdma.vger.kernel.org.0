Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F42A60D1A1
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Oct 2022 18:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJYQ3M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Oct 2022 12:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiJYQ3L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Oct 2022 12:29:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD7DBA257
        for <linux-rdma@vger.kernel.org>; Tue, 25 Oct 2022 09:29:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E398C61A08
        for <linux-rdma@vger.kernel.org>; Tue, 25 Oct 2022 16:29:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5003AC433D6;
        Tue, 25 Oct 2022 16:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666715350;
        bh=TiMMmOGI3nVLRELapsEtdHX0+6aGOLdig87GSdfHekE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=m7qnxpygvJbVvHfYLVAyBz6OO+7RUjwNLo9vSm5WFd2zl3xy2tyH0wHmVptTSIlSh
         eTdz1AyU9qqhMv8wHaQg+mTkYojnOxfhCTuZtDvP+3JJvMmMZkqY6BxpoSrAbT53l8
         waQmGRFmXkfcXJ/FU2XhuAlgm5JeoFAwOcebb9KcizkC9yX9hdIWCPJQK7mz5eMmMI
         7JF8aqgkKNAgnam6gBSeezgM8JIRiC2SKwSGWneA/iy8RW6DS148Ii7JliynFlixjH
         /LYMkT7sgqWmNa0gKHl72l+PU1uVShAuBZqftz3FDiKN3V8OeWAGpoisIW4HWCs1ST
         QGWCvDXIxStxw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EE1D95C05FD; Tue, 25 Oct 2022 09:29:09 -0700 (PDT)
Date:   Tue, 25 Oct 2022 09:29:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yonghong Song <yhs@fb.com>, Leon Romanovsky <leonro@nvidia.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/core: Remove rcu attr for
 uverbs_api_ioctl_method.handler
Message-ID: <20221025162909.GG5600@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221025152420.198036-1-yhs@fb.com>
 <Y1gIAnr5jFRn74c8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1gIAnr5jFRn74c8@nvidia.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 25, 2022 at 01:00:02PM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 25, 2022 at 08:24:20AM -0700, Yonghong Song wrote:
> > The current uverbs_api_ioctl_method definition:
> >   struct uverbs_api_ioctl_method {
> >         int(__rcu *handler)(struct uverbs_attr_bundle *attrs);
> >         DECLARE_BITMAP(attr_mandatory, UVERBS_API_ATTR_BKEY_LEN);
> >         ...
> >   };
> > The struct member 'handler' is marked with __rcu. But unless
> > the function body pointed by 'handler' is changing (e.g., jited)
> > during runtime, there is no need with __rcu.
> 
> Huh? This is a sparse marker, it says that the pointer must always be
> loaded with rcu_dereference
> 
> It has nothing to do with JIT, this patch is not correct

OK, I will bite...

This is a pointer to a function.  Given that this function's code is
generated at compile time, what sequence of changes is rcu_dereference()
protecting against?

							Thanx, Paul
