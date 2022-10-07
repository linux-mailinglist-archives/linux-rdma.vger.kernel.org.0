Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07AD5F7429
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Oct 2022 08:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJGGVk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Oct 2022 02:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJGGVj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 7 Oct 2022 02:21:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5CDBBE25
        for <linux-rdma@vger.kernel.org>; Thu,  6 Oct 2022 23:21:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8ABDDB81BAD
        for <linux-rdma@vger.kernel.org>; Fri,  7 Oct 2022 06:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF011C433D6;
        Fri,  7 Oct 2022 06:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665123695;
        bh=+/N4OHOff79EL3wBApp88ZsTCN6xqoJ9fJyIl6fLRM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iswOAsafRMCuYr+xQ98gbCm3fvBYL6KyY9YbXj0LfbixAeN28/i9NF54SyG0Z6yoD
         qvB5K5dPp7ibJjGhlwWLH1BMpHPukV6AryyAEEzDx+RftwjZFfl14Y/JNrt4YZv5/l
         dTXX46OTDoqnKC7o4LNZXcnLrBmPgw47Fo/L+SmsDIi3f5nDbi7sxp0Lj0D36F3E0Z
         nNoiSyYmYa2TiUI6M9qNR/3uK3sRdVnOCDM9McSNy4I/uNHZUschOL/+LpfqbIZitD
         2VZajCXXjJjW4i6R9lDIDoD9i0qTFfxdErdAUre+hv34fTcWeTF7hcB0hFNOGifQHP
         k8v8N/GHSqg2w==
Date:   Fri, 7 Oct 2022 09:21:30 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        Leon Romanovsky <leo@kernel.org>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] rdma: not display the rdma link in other net namespace
Message-ID: <Yz/FaiYZO5Y0R7QP@unreal>
References: <20220926024033.284341-1-yanjun.zhu@linux.dev>
 <YzLRvzAH9MqqtSGk@unreal>
 <4e5d49fe-38a3-4891-3755-3decf8ffebda@linux.dev>
 <YzPkAGs60Kk4QCck@unreal>
 <fb230416-d336-cca2-24c3-5b804c50a10e@linux.dev>
 <Yz7PsMhkWMH0HXjt@unreal>
 <99a4b7ea-64df-7de4-2d7a-52e797644e71@linux.dev>
 <Yz8Ak/Pxz13fP4zE@unreal>
 <Yz8A6az2rIjEDEGk@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yz8A6az2rIjEDEGk@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 06, 2022 at 01:23:05PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 06, 2022 at 07:21:39PM +0300, Leon Romanovsky wrote:
> 
> > > And in exclusive mode, a rdma link that can not be accessed in net namespace
> > > A still
> > > 
> > > appears in net namespace A when running "rdma link show" in net namespace A.
> > > 
> > > The above is different from others in net namespace.
> > > 
> > > For example, in net namespace, if net device NIC0 is moved to net namespace
> > > B from net namespace A,
> > > 
> > > this NIC0 will not appear in net namespace A when running "ip link" command
> > > in net namespace A.
> > > 
> > > Is it a problem?
> > 
> > rdmatool presents IB devices. It has no logic that decides if that
> > device is usable/operable or not.
> 
> It should really not report an IB device that is not in the net
> namespace..

It is kernel (nldev.c) job to hide such IB devices and it seems like it
does. For devices with help of ib_enum_all_devs() and for links with
ib_device_get_by_index().

They both checks netns - rdma_dev_access_netns(device, net).

Thanks
