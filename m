Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E53D63ED55
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 11:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbiLAKMh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 05:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiLAKMb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 05:12:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9289722BC8;
        Thu,  1 Dec 2022 02:12:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E96DB80B77;
        Thu,  1 Dec 2022 10:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678E6C433C1;
        Thu,  1 Dec 2022 10:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669889548;
        bh=84mbUFlPHlzj3D5sBUAYJJUyYWewmr2dNPatZ/juvE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ie8d7vzMdjmqxqCLS3Nm/+1gyn7AVoCWrZMptGVXiGptbqiV79Q6OhKqrXkZeodbG
         KbECWJG9tl8wufYzhfvM5AY7Q3nlyIcEI5Mx7qOF4TofoYiLSJT/iQfTbQGtm7zo/w
         nrzsM6JfFer5WCuFHrdcjdiP8bkLPD2FzSHGwBvsoO0fczAV9aN4/IY84Xzojw9JIt
         CLpUwfI0edbrBOadCGDkvsZZxHdUBUp4c5r3/WrwmqPINkYAzEYkeNreZSxG5eukLR
         s9AyPWkZ1lX1Wf0FYXKv0odcxHccjicJTw51ZhLuuefwFwA4iO6/7Lo2As/lbDGUEF
         FGo0sHw6QNtDg==
Date:   Thu, 1 Dec 2022 12:12:23 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
Subject: Re: [PATCH 1/2 v2] IB/qib: don't use qib_wc_x86_64 for UML
Message-ID: <Y4h+B7vEvkgbMbZ7@unreal>
References: <20221130200945.24459-1-rdunlap@infradead.org>
 <Y4hyPPzyQiI3i9jh@unreal>
 <9fdd6581efb75511f3259ca663cd1afaee4ae4ac.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fdd6581efb75511f3259ca663cd1afaee4ae4ac.camel@sipsolutions.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 01, 2022 at 10:28:18AM +0100, Johannes Berg wrote:
> On Thu, 2022-12-01 at 11:22 +0200, Leon Romanovsky wrote:
> > 
> > > +++ b/drivers/infiniband/hw/qib/Kconfig
> > > @@ -3,6 +3,7 @@ config INFINIBAND_QIB
> > >  	tristate "Intel PCIe HCA support"
> > >  	depends on 64BIT && INFINIBAND_RDMAVT
> > >  	depends on PCI
> > > +	depends on !UML
> > 
> > I would advocate to add this line to whole drivers/infiniband.
> > None of RDMA code makes sense for UML.
> > 
> 
> You could argue that one might want to eventually use kunit for some
> bits and pieces in there, so it'd make sense to be able to build the
> parts that _can_ be built, but I have no idea :)

But now, we don't have anyone in RDMA who uses kunit. Once it will be
needed, he/she will extend drivers/infiniband to support it.

Thanks

> 
> johannes
