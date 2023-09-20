Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E007A7245
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Sep 2023 07:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232327AbjITFpC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Sep 2023 01:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjITFpC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Sep 2023 01:45:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BAE90
        for <linux-rdma@vger.kernel.org>; Tue, 19 Sep 2023 22:44:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E4EC433C8;
        Wed, 20 Sep 2023 05:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695188696;
        bh=3koQRzOAhvIivry4Ol2G54nlaJTC5CeXGqAO7KOqQxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RGQfYVzfoDHbZlxw2MWd+Wsp0B0cOciTFpJbo0JKrXX3TnHNdvB/JhYjwzoR/0aQJ
         JW3/MjPyyDmmLK8h2wlYdVQcIc7GZNscGQZvaNYpJ5JwHYmsMJb2dNmPGd1tLXIOkq
         h64LU4s9WD9TmH95oqaqOYjU/57QHbgNAdVjj20W6gA+CWxQewT7ZHcokUU3jOB8VK
         StVvwXfDIb2lwK4O387AcG/nCVDMAGRNe7JbCnYCXe1XusE9WabR++aZprD7Gz3lGo
         N01kUWSh8JbqCvFn5mTAwI/fzLQqg1WAHVF+py7G2VxfWLGQjgGZ83NAZgnIuQtquc
         cQS/XUfbtKmnA==
Date:   Wed, 20 Sep 2023 08:44:52 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Vitaly Mayatskikh <vitaly@enfabrica.net>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        linux-rdma@vger.kernel.org, David Ahern <dsahern@kernel.org>,
        Roland Dreier <roland@enfabrica.net>
Subject: Re: [PATCH] RDMA/core: use rdma_cap_iw_cm() in rdma_resolve_route()
Message-ID: <20230920054452.GH4494@unreal>
References: <20230918142700.12745-1-vitaly@enfabrica.net>
 <20230919072136.GB4494@unreal>
 <CAF0Wxh=YhKCLbOLZ+-b+_rmzRoWQtqoBGn6Bo9X3zR308Vm1zA@mail.gmail.com>
 <CAF0Wxhkxa1Lk76nnkTQbNL6_v_4amczVd=wodPt00iOU2WB6+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF0Wxhkxa1Lk76nnkTQbNL6_v_4amczVd=wodPt00iOU2WB6+w@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 19, 2023 at 04:08:38PM -0400, Vitaly Mayatskikh wrote:
> On Tue, Sep 19, 2023 at 4:06 PM Vitaly Mayatskikh <vitaly@enfabrica.net> wrote:
> >
> > On Tue, Sep 19, 2023 at 3:21 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > > I see that rdma_protocol_iwarp() is used in other places in cma.c too,
> > > Don't they need to be updated too?
> > >
> > > Also I see that we have check for protocol RoCE in else before the
> > > changed line, shouldn't all cma.c be changed to rdma_cap_*_cm() calls?
> > >
> > >   3376         else if (rdma_protocol_roce(id->device, id->port_num)) {
> >
> > I can't really judge, but looking around in the code it seems that
> > some if not all of
> > those cma.c functions that are checking for the protocol - they only
> > called from the
> > drivers that actually use the protocol. For example, iSER.

Just to make sure that we are using correct terminology - iSER is ULP
(upper layer protocol) and not driver. 

> >
> > Our driver does not support iWarp, but implements IW_CM callbacks. The patch has
> > the only fix that was needed to make it work w/o a full blown iWarp.

It is hard to say without having driver in-tree and seeing the result of
ib_device_check_mandatory() in regards of kverbs_provider variable.

Does any existing in-tree driver require the proposed change in rdma-cm?

Thanks

> 
> Ugh, adding everyone back...
