Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F81D5F6B7E
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Oct 2022 18:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiJFQV7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Oct 2022 12:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiJFQV6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Oct 2022 12:21:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536819D50E
        for <linux-rdma@vger.kernel.org>; Thu,  6 Oct 2022 09:21:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F35CAB8060E
        for <linux-rdma@vger.kernel.org>; Thu,  6 Oct 2022 16:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D6E7C433C1;
        Thu,  6 Oct 2022 16:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665073311;
        bh=musQq9WcpZHXxzOBhPwoWOSO70/fZsAvrSw0qUXgsTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xd+KVYtGBvFkeN8swsjb1rucOvxL4UTyat1zh4SkGbvZI5bSPzzEyNLPrNgvReYwf
         Racjt3FNWKnzRn4wKWe54HOKmbejXhUAljINiHL9spTkf61W2DmEZ423AdlLVrkJyT
         mAesKL0FgjtLtn2xcdaNgI9tHVVjbu2/QDip194+MehTNEliuKLAgMzVUgy+XuVhGu
         DV+TNglR3uPdC+j6H6yjKaYjBmhw6UH1aEqGLg0Cbi3wZRlATp0txP84IxTMEAxA2l
         00iKiAtPuuxObHGs4LSwv1XUVY4dYZIKIMjcbeFiz0bsApm3T6lPBP4KXdulfJYAZ4
         u4sDFsxKJYz+g==
Date:   Thu, 6 Oct 2022 19:21:39 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     Leon Romanovsky <leo@kernel.org>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com
Subject: Re: [PATCH] rdma: not display the rdma link in other net namespace
Message-ID: <Yz8Ak/Pxz13fP4zE@unreal>
References: <20220926024033.284341-1-yanjun.zhu@linux.dev>
 <YzLRvzAH9MqqtSGk@unreal>
 <4e5d49fe-38a3-4891-3755-3decf8ffebda@linux.dev>
 <YzPkAGs60Kk4QCck@unreal>
 <fb230416-d336-cca2-24c3-5b804c50a10e@linux.dev>
 <Yz7PsMhkWMH0HXjt@unreal>
 <99a4b7ea-64df-7de4-2d7a-52e797644e71@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99a4b7ea-64df-7de4-2d7a-52e797644e71@linux.dev>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 06, 2022 at 10:26:33PM +0800, Yanjun Zhu wrote:
> 
> 在 2022/10/6 20:53, Leon Romanovsky 写道:
> > On Fri, Sep 30, 2022 at 03:25:00PM +0800, Yanjun Zhu wrote:
> > > 在 2022/9/28 14:04, Leon Romanovsky 写道:
> > > > On Tue, Sep 27, 2022 at 06:58:50PM +0800, Yanjun Zhu wrote:
> > > > > 在 2022/9/27 18:34, Leon Romanovsky 写道:
> > > > > > On Sun, Sep 25, 2022 at 10:40:33PM -0400, yanjun.zhu@linux.dev wrote:
> > > > > > > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > <...>
> > 
> > > Is it better to append "exclusive" or "shared" in the end of the line?
> > No, exclusive/shared is global property, applied to all links.
> 
> OK.
> 
> When running "rdma link show", there is no difference between shared and
> exclusive.
> 
> Is it acceptable?

exclusive/shared is ib_core module parameter, so or all links are shared
or all links are exclusive. They can't be both at the same time.

> 
> 
> And in exclusive mode, a rdma link that can not be accessed in net namespace
> A still
> 
> appears in net namespace A when running "rdma link show" in net namespace A.
> 
> The above is different from others in net namespace.
> 
> For example, in net namespace, if net device NIC0 is moved to net namespace
> B from net namespace A,
> 
> this NIC0 will not appear in net namespace A when running "ip link" command
> in net namespace A.
> 
> Is it a problem?

rdmatool presents IB devices. It has no logic that decides if that
device is usable/operable or not.

Thanks

> 
> 
> Zhu Yanjun
> 
> > 
> > Thanks
