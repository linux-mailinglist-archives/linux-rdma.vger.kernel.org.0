Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4BD6094D7
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Oct 2022 18:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbiJWQqJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 23 Oct 2022 12:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiJWQqI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 23 Oct 2022 12:46:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8774F4A805
        for <linux-rdma@vger.kernel.org>; Sun, 23 Oct 2022 09:46:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2BB4B8085C
        for <linux-rdma@vger.kernel.org>; Sun, 23 Oct 2022 16:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C8CC433C1;
        Sun, 23 Oct 2022 16:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666543563;
        bh=RzeqC9VDZaY4bGecMRel89F8ayScKr1j2xmnnPsbDTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tK2F7Fl+Ae5m14uQwE2XpFya8UfU+hAs32NbgrzsCN2HnWGmsTjplP3KkMP4hQW3I
         YZeGqzbu7J/G7JrVYGLEHHpMmYEIB5I23FW7Z1LgVS+9mDZHVY6h3NABNpxXjFMk5o
         M0ZNfiPAHDlgURmas2T1Nzq/1RpODtYGNZUvZhqd2LvEoxmfJJ60nbPbLaC25wCW8z
         N2GsR8CsylH7oOhTITxkUXTwVVsRNUi5ZtUGdf0Cv4w/eH9E9SB9qzxzBhq6oREPSR
         0rGpKUlV6k0c0LUo2DPrCo1rJQvaU3JMNip2ua6y4kUIOAqV/8syuy8LdC34BCl5AF
         8E2vrY5VCvu+w==
Date:   Sun, 23 Oct 2022 19:45:58 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yanjun Zhu <yanjun.zhu@linux.dev>
Cc:     Zhu Yanjun <yanjun.zhu@intel.com>, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH 0/3] RDMA net namespace
Message-ID: <Y1VvxqPNy7bmZ2ZR@unreal>
References: <20221023220450.2287909-1-yanjun.zhu@intel.com>
 <Y1U7w+6emBqrQnkI@unreal>
 <ac6228a7-52a6-3b80-6b22-c4444b67d360@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac6228a7-52a6-3b80-6b22-c4444b67d360@linux.dev>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 23, 2022 at 09:42:00PM +0800, Yanjun Zhu wrote:
> 
> 在 2022/10/23 21:04, Leon Romanovsky 写道:
> > On Sun, Oct 23, 2022 at 06:04:47PM -0400, Zhu Yanjun wrote:
> > > From: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > 
> > > There are shared and exclusive modes in RDMA net namespace. After
> > > discussion with Leon, the above modes are compatible with legacy IB
> > > device.
> > > 
> > > To the RoCE and iWARP devices, the ib devices should be in the same net
> > > namespace with the related net devices regardless of in shared or
> > > exclusive mode.
> > > 
> > > In the first commit, when the net devices are moved to a new net
> > > namespace, the related ib devices are also moved to the same net
> > > namespace.
> > I think that rdma_dev_net_ops are supposed to handle this.
> 
> Yes. rdma_dev_net_ops can move ib devices from one net to another net.
> 
> But these functions are called by a netlink command "rdma dev...".

rdma_dev_net_ops are called when you move netdevice from one netlink to
another.

However you raised an interesting question if it is correct behaviour to
move IB device after moved netdevice.

I don't know an answer for that.

Thanks
