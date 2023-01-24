Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9E36790F8
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Jan 2023 07:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjAXGcV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Jan 2023 01:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbjAXGcG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 24 Jan 2023 01:32:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9E93E61C
        for <linux-rdma@vger.kernel.org>; Mon, 23 Jan 2023 22:31:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B01BB810C6
        for <linux-rdma@vger.kernel.org>; Tue, 24 Jan 2023 06:31:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C94EC433D2;
        Tue, 24 Jan 2023 06:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674541897;
        bh=QnLGe+6JryCPjaOA/9npQgRjj6+bisrLN9YUpTBQpWQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pfZxwwK38iHqqVW6HKmdxVnE4P27rwZOdYGPW0OhsSmYhEOpxkViuHzbYOONcAOOv
         e08AOfntOM7D00RJcLPtMs22XSewgHU8IJb+yhfzQBlA1Skst/r1HE6jF05kt1CD8l
         NhR+YnxY1X3OTTxSeNgksi5lF74ih8HJtbdV25rzgyxfrG8AUOTa+iZgelwL+5LAqm
         2IsJLSsY9WDTXyomBmL0LJqf6WL1Gu5flCw5SPS0ZoD+dSZDXGj6v6e325dqQz++8E
         aYrN+TQ43Srx0WSbag7/eMAbDoZKtUUjMrlEiX2V0apGcrKapA93WtZvM2vOybTgmq
         f6moDZxNgJ39w==
Date:   Tue, 24 Jan 2023 08:27:09 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Dragos Tatulea <dtatulea@nvidia.com>, linux-rdma@vger.kernel.org,
        Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH rdma-rc v1] IB/IPoIB: Fix legacy IPoIB due to wrong
 number of queues
Message-ID: <Y896PRioqqz6nVCZ@unreal>
References: <752143b0eef72a966662ce94526b1ceb5ba4bbb3.1674234106.git.leon@kernel.org>
 <Y8r/BUdb7XMxwVN+@nvidia.com>
 <Y80vs3KQ1QfB+KBf@unreal>
 <Y87SpbbdYE3A+y46@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y87SpbbdYE3A+y46@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jan 23, 2023 at 02:32:05PM -0400, Jason Gunthorpe wrote:
> On Sun, Jan 22, 2023 at 02:44:35PM +0200, Leon Romanovsky wrote:
> 
> > > And the return of a really big number from ops->get_num_rx_queues is
> > > pretty ugly too, ideally that would be fixed to pass in some function
> > > arguments and obtain the ppriv so it can return the actual maximum
> > > number of queues and we don't waste a bunch of memory..
> > 
> > .get_num_rx_queues() is declared as void, so it can't have any complex
> > logic except returns some global define.
> 
> Well, yes, you'd have to add some arguments..

Jason, please be realistic.

We already were in this place, where we wanted to change netdev stack
for our IPoIB deadlock. As you probably remember, that didn't went well.

I see a little value to change bunch of netdev drivers just to save some
bytes in legacy IPoIB.

Thanks

>  
> Jason
