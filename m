Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79D77A49E7
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Sep 2023 14:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbjIRMl5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Sep 2023 08:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240412AbjIRMla (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Sep 2023 08:41:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BD99F;
        Mon, 18 Sep 2023 05:41:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DCEC433C8;
        Mon, 18 Sep 2023 12:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695040884;
        bh=L0kx5zWcm3nLfzQqEDKgwBhllqI/l0iyZyQ1GJ/RMc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hnxoIlQalA9WBLb/+g0l4ZE42Oslamk1PsylnXOYXKwDy6+IO4pQAFwSBbjHvj5UX
         wHLpfQ5vUtOEOd57dH1GD8J/f/1NeSlzgo85xHswPejKHcbu8nxJPkcgCiPa4ShPgL
         azkergikZqdxrdsPKIRVeBhGGESO3ePD133FZHob8dqQtFDZjNhvdVGTigUSDAyxrU
         qZZ0T73uKBFPRXgYbcfRRpV5ExIm/DrCt6qQOiSQ0qhEJEZH/U6rRlvzKeQWC9DVeJ
         hbgAKxOZKiy3P63R3fx/QdaTdGEHfDWwYeXm6FDJQ3Rn+fy0etINQW8ElEw/JAGj7b
         jl4o1yKUIMxNw==
Date:   Mon, 18 Sep 2023 15:41:20 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] RDMA/core: Use size_{add,mul}() in calls to
 struct_size()
Message-ID: <20230918124120.GE103601@unreal>
References: <ZP+if342EMhModzZ@work>
 <202309142029.D432EEB8C@keescook>
 <2594c7ff-0301-90aa-d48c-6b4d674f850e@embeddedor.com>
 <20230918104938.GD13757@unreal>
 <4067fb33-2172-b132-e8c4-0ba21c31b42a@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4067fb33-2172-b132-e8c4-0ba21c31b42a@embeddedor.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 17, 2023 at 01:59:26PM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 9/18/23 04:49, Leon Romanovsky wrote:
> > On Fri, Sep 15, 2023 at 12:06:21PM -0600, Gustavo A. R. Silva wrote:
> > > 
> > > 
> > > On 9/14/23 21:29, Kees Cook wrote:
> > > > On Mon, Sep 11, 2023 at 05:27:59PM -0600, Gustavo A. R. Silva wrote:
> > > > > Harden calls to struct_size() with size_add() and size_mul().
> > > > 
> > > > Specifically, make sure that open-coded arithmetic cannot cause an
> > > > overflow/wraparound. (i.e. it will stay saturated at SIZE_MAX.)
> > > 
> > > Yep; I have another patch where I explain this in similar terms.
> > > 
> > > I'll send it, shortly.
> > 
> > You missed other places with similar arithmetic.
> > drivers/infiniband/core/device.c:       pdata_rcu = kzalloc(struct_size(pdata_rcu, pdata,
> > drivers/infiniband/core/device.c-                                       rdma_end_port(device) + 1),
> > drivers/infiniband/core/device.c-                           GFP_KERNEL);
> > 
> > drivers/infiniband/core/sa_query.c:     sa_dev = kzalloc(struct_size(sa_dev, port, e - s + 1), GFP_KERNEL);
> > drivers/infiniband/core/user_mad.c:     umad_dev = kzalloc(struct_size(umad_dev, ports, e - s + 1), GFP_KERNEL);
> 
> I haven't sent all my patches.

Please sent one patch for whole drivers/infiniband/core/ folder as your
title: "RDMA/core ..." suggests.

Thanks

> 
> --
> Gustavo
