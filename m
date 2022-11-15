Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0E56292BA
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Nov 2022 08:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiKOHw6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 02:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbiKOHw5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 02:52:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBAE20350
        for <linux-rdma@vger.kernel.org>; Mon, 14 Nov 2022 23:52:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CABC6155B
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 07:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189F6C433C1;
        Tue, 15 Nov 2022 07:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668498775;
        bh=YUFdmyn7CN5pJffxkxWQ3XTId3hCgsBRwK2vs4EniaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EzkGq8XcYFZREedhgy2i4Mcy7X3wEePWKSuYCAZPfwPcfDKOQ3gO4kpCfMQ2lYHZq
         y4+bIrm6O5q3na0Nr+SMs+8MdBzbWtotldmV+uMto7rDmx0Wbnq5owUBYfHnN5kDPk
         2A9VwaU0Kwa7vzoL1ma7XGofXSFTVT19Mr4J3qdzkkW2w9g/CNmQjiUz9oDzsSKGwX
         aH/m4MYx5V1o+hqyUkdIZI9CCE4Wi0NhmrMPAlHujd5t6zMpVLLTdickAAqPKex4X5
         QyUq5if5wUcWT6JV4RvHtpWtfNtSllIj3hnuIXQGdB4vbKumIb2XsZKPYmUldzkhtW
         aEt+iKtfm0Vsw==
Date:   Tue, 15 Nov 2022 09:52:51 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Or Har-Toov <ohartoov@nvidia.com>, linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>
Subject: Re: [PATCH rdma-next 1/4] RDMA/nldev: Use __nlmsg_put instead
 nlmsg_put
Message-ID: <Y3NFU68nSl1Gh9Pu@unreal>
References: <cover.1667810736.git.leonro@nvidia.com>
 <3d8fb9edbd41f122fda680158a80bac44e55e847.1667810736.git.leonro@nvidia.com>
 <Y2v8UsT015iiRuob@nvidia.com>
 <Y3Cany776/OrEpbY@unreal>
 <Y3JN6GVUgcjbHVv0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3JN6GVUgcjbHVv0@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 14, 2022 at 10:17:12AM -0400, Jason Gunthorpe wrote:
> On Sun, Nov 13, 2022 at 09:19:59AM +0200, Leon Romanovsky wrote:
> > On Wed, Nov 09, 2022 at 03:15:30PM -0400, Jason Gunthorpe wrote:
> > > On Mon, Nov 07, 2022 at 10:51:33AM +0200, Leon Romanovsky wrote:
> > > > From: Or Har-Toov <ohartoov@nvidia.com>
> > > > 
> > > > Using nlmsg_put causes static analysis tools to many
> > > > false positives of not checking the return value of nlmsg_put.
> > > > 
> > > > In all uses in nldev.c, payload parameter is 0 so NULL will never
> > > > be returned. So let's use __nlmsg_put function to silence the
> > > > warnings.
> > > 
> > > I'd rather just add useless checks for the errors than call a private
> > > function like this. Or add some nlmsg_put_no_payload() that can't fail
> > 
> > This is exactly what __nlmsg_put() means. Function that can't fail.
> 
> Er no, it is some internal function. A function that can't fail
> wouldn't accept the payload argument at all.

It is not internal to me, all users of __nlmsg_put() are outside of
netdev world.

Thanks

> 
> Jason
