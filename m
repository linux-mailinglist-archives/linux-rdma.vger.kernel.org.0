Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 968CC6D3328
	for <lists+linux-rdma@lfdr.de>; Sat,  1 Apr 2023 20:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbjDASbE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 1 Apr 2023 14:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDASbD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 1 Apr 2023 14:31:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1882C1BF50
        for <linux-rdma@vger.kernel.org>; Sat,  1 Apr 2023 11:31:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1D97B8092D
        for <linux-rdma@vger.kernel.org>; Sat,  1 Apr 2023 18:31:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6F9C433EF;
        Sat,  1 Apr 2023 18:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680373860;
        bh=w8PbYijx9uDYxaKhbcMtBfGAFKCywexDH2D1xFJkjnE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UmIPWQ99kqOLcAkjvAW9tSX/6zOdm/tBMsQDjoIMy/+low9wex6g3WYJoyhUrw0MP
         JjrT0aShhKS5CPgXxqEGW5W5sBHwYRT+N/rQ9Yi3pIFCbANV3jbHuqLwDn05uXFxR9
         TB8OfMSWOzhP/Af8wMIBcxE5UfnLm7Eo2PUSV0a8TPMNuZR1Oc5t9Btdjtsj9VfQun
         Bg6oQmVoKmNkZZ84yOzLwg88NqKYKDdPGlWJvKB85siQ1lpwkT4gCh/+V3QTAdhjz/
         FoNlkTcR7Q613V8W7LIGIesUmIilFu0n3Nmhih2AIuHbgzkvBLI1Ch/unvN1ZbtldY
         /Xf9uXo/IgvyQ==
Date:   Sat, 1 Apr 2023 21:30:56 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH] RDMA: don't ignore client->add() failures
Message-ID: <20230401183056.GB831478@unreal>
References: <ZCLQ0XVSKVHV1MB2@ziepe.ca>
 <ec025592-3390-cf4f-ed03-c3c6c43d9310@I-love.SAKURA.ne.jp>
 <ZCMTZWdY7D7mxJuE@ziepe.ca>
 <d2dfb901-50b1-8e34-8217-d29e63f421c7@I-love.SAKURA.ne.jp>
 <ZCRc5S9QGZqcZhNg@ziepe.ca>
 <9186f5f5-2f88-1247-2d24-61d090a1da83@I-love.SAKURA.ne.jp>
 <ZCYdo8pcS947JOgI@ziepe.ca>
 <747eaa78-5773-c2fd-5a8f-97998a0c9883@I-love.SAKURA.ne.jp>
 <ZCcJBPbOlmx0he9Y@ziepe.ca>
 <2e7a122d-78a9-efec-9140-6d21bceb7e04@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e7a122d-78a9-efec-9140-6d21bceb7e04@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Apr 01, 2023 at 04:30:08PM +0900, Tetsuo Handa wrote:
> On 2023/04/01 1:23, Jason Gunthorpe wrote:
> > On Sat, Apr 01, 2023 at 01:19:47AM +0900, Tetsuo Handa wrote:
> >> I guess that either dev_net(netdev) is not appropriately initialized or
> >> dev_net(netdev) != &init_net is too restrictive to call ib_unregister_device_queued().
> >> Where is dev_net(netdev) initialized?
> > 
> > Bernard? What is this net ns check for? It seems surprising this would
> > be here
> > 
> 
> Commit bdcf26bf9b3a ("rdma/siw: network and RDMA core interface") implemented
> siw_netdev_event() with
> 
> 	if (dev_net(netdev) != &init_net)
> 		return NOTIFY_OK;
> 
> check. But why this check is needed was not explained.
> Maybe ib_devices_shared_netns is relevant?
> 
> Since network devices created upon/after unshare(CLONE_NEWNET) have network
> namespace other than init_net, this check completely disables siw_netdev_event()
> after unshare(CLONE_NEWNET). Thus, removing this check looks reasonable.

I agree with Jason, this check is not supposed to be in siw in first place
and needs to be removed.

Thanks
