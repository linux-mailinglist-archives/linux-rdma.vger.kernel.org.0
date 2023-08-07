Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CD07726BE
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Aug 2023 15:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjHGNyv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Aug 2023 09:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjHGNxH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Aug 2023 09:53:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509C81701
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 06:52:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E107261ACF
        for <linux-rdma@vger.kernel.org>; Mon,  7 Aug 2023 13:52:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FF9C433C7;
        Mon,  7 Aug 2023 13:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691416374;
        bh=HUxL2xCwz0rw74+xULJz36jPMAfTiUl6sbM/Y/39uCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L+hkaqDv5IFh4xFhbiQypmYIXewGkRbCUgJ+ycCnK9B9bwP9s3Ne/H3X73JLfEFYe
         lWbThcaRiu7vFQ6R8Hl2ZWBn1USkwp2oP4740UJXSqNNWD69b7kdHpYhyOfF0e6ibM
         nsjDqhpP+TqacUfXIfA3Wak2/OC5+Gz+dgroxgWA2+DjGNN4mhK6WfIQpcOoHgOhS/
         W3aYPxh0jravDpoM64IjFDOcgQb+fUyawkhCuS13HFmXR/A5ss3ofu5FZakCTZkwJh
         uUwamfUe4SN7NZFSIeEvYwBH64vOvT68QJ616ctOkjD26GIFCVSEKkXcz0TeUHy7lW
         C9QlVT99LhlIQ==
Date:   Mon, 7 Aug 2023 16:52:50 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH for-next v2] IB/core: Add more speed parsing in
 ib_get_width_and_speed()
Message-ID: <20230807135250.GB7100@unreal>
References: <1690966823-8159-1-git-send-email-selvin.xavier@broadcom.com>
 <20230803175842.GF53714@unreal>
 <CA+sbYW14vED8cHzvqO-=06yJegqBZqVd76uDma=w+d-Y+T+PsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+sbYW14vED8cHzvqO-=06yJegqBZqVd76uDma=w+d-Y+T+PsQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Aug 04, 2023 at 09:43:28AM +0530, Selvin Xavier wrote:
> On Thu, Aug 3, 2023 at 11:28 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Wed, Aug 02, 2023 at 02:00:23AM -0700, Selvin Xavier wrote:
> > > From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > >
> > > When the Ethernet driver does not provide the number of lanes
> > > in the __ethtool_get_link_ksettings() response, the function
> > > ib_get_width_and_speed() does not take consideration of 50G,
> > > 100G and 200G speeds while calculating the IB width and speed.
> > > Update the width and speed for the above netdev speeds.
> > >
> > > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > ---
> > > v1 - v2:
> > >     - Rebased the patch based on the latest changes in ib_get_width_and_speed
> > >     - removed the switch case and use the existing else if check
> > > ---
> > >  drivers/infiniband/core/verbs.c | 11 ++++++++++-
> > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> > > index 25367bd..41ff559 100644
> > > --- a/drivers/infiniband/core/verbs.c
> > > +++ b/drivers/infiniband/core/verbs.c
> > > @@ -1899,9 +1899,18 @@ static void ib_get_width_and_speed(u32 netdev_speed, u32 lanes,
> > >               } else if (netdev_speed <= SPEED_40000) {
> > >                       *width = IB_WIDTH_4X;
> > >                       *speed = IB_SPEED_FDR10;
> > > -             } else {
> > > +             } else if (netdev_speed <= SPEED_50000) {
> > > +                     *width = IB_WIDTH_2X;
> > > +                     *speed = IB_SPEED_EDR;
> > > +             } else if (netdev_speed <= SPEED_100000) {
> > >                       *width = IB_WIDTH_4X;
> > >                       *speed = IB_SPEED_EDR;
> > > +             } else if (netdev_speed <= SPEED_200000) {
> > > +                     *width = IB_WIDTH_4X;
> > > +                     *speed = IB_SPEED_HDR;
> >
> >
> > SPEED_50000, SPEED_100000 and SPEED_200000 depends on
> > ClassPortInfo:CapabilityMask2.is* values.
> >
> > For example, SPEED_50000 can b IB_WIDTH_2X/IB_SPEED_EDR and IB_WIDTH_1X/IB_SPEED_HDR.
> Agree with that.
> This reporting can be achieved by the existing code, but the L2 driver
> needs to report non zero values for lanes in
> ethtool_ops->get_link_ksettings.
> Caller of this modified function gets the speed and number of lanes
> from ethtool_ops->get_link_ksettings.
> 
> In this patch we are trying to handle the case where ethtool ops
> doesn't provide the lanes.  

Almost all drivers don't support lanes reporting.

> We can  default to some value so that we
> dont report wrong total link speed (width * speed) for any speed more
> than 40G.
> >
> > Thanks
> >
> > > +             } else {
> > > +                     *width = IB_WIDTH_4X;
> > > +                     *speed = IB_SPEED_NDR;
> > >               }
> > >
> > >               return;
> > > --
> > > 2.5.5
> > >
> >
> >


