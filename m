Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E877766FF
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Aug 2023 20:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjHISLk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Aug 2023 14:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHISLj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Aug 2023 14:11:39 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD6C171D
        for <linux-rdma@vger.kernel.org>; Wed,  9 Aug 2023 11:11:38 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-63cf6b21035so719006d6.1
        for <linux-rdma@vger.kernel.org>; Wed, 09 Aug 2023 11:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691604698; x=1692209498;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lv1H6oQ+7H5r336g0LpKn+xrudtS7Ky51ho04nXIsK8=;
        b=aOD8aQUAebaDByFb4FYTNG5npoK6I5CiQzeFJXbGvSkjACNh95XQc9dhWZ1Gpbq6/b
         jVL7UGbdUCSrfio2F62MUTKLysw7yV8lhcNDo8LEvi9QsjvylAt+XJlUakEvIt+lWOty
         I1EBhqjnBtj55yo95b8DUQUQSZ86NFEmYPIpHxWhxZy9R7vt5OpxwNyLnTuHgM7plG4c
         Tr3dzw62eO8akEtIa/uf6/VEWFDZnnJRpRMxR+fC6BIX5boK/sWe2gqjxTLgEvBmanDS
         Qp/eHZdTK9P/t54ChyCPM11JSzNMezWxi1DsCj7Vhmh/lh4cgonW6YeO43n+mVIOJEyq
         CAoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691604698; x=1692209498;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lv1H6oQ+7H5r336g0LpKn+xrudtS7Ky51ho04nXIsK8=;
        b=ad+8+/baVQqKi7WLflU9ti8YA4gJEV4yO0f7po9/YeouNvvTqpQZU8iQyNcyS4VtOp
         U3EpDzIDINYi0vbqejYcSw6RrE2/JjTp5IhmRl7r1QXLu99uRFcswo0xdlTHmnOVuQCy
         OjepnX6kd4+Swgzq0gf3dKOtWN+MmAeNeu+lCLKIUiCnK2lFmswImj2yKewh9RKqckGD
         nYAh/8U3/I4JfyqHcevgd0XGxSmzjaE1AcpCvwIuAnb/PGgIzS0yz/dCkdyueA9T1dJN
         pJSX2wcXZLYhQliRi0tUNe7IfinE42+ioyCVxMLg7QM17mj2t6TXhaAFqD7zb7sx+xg2
         Y+mw==
X-Gm-Message-State: AOJu0YyL48L8FmMiiyi8EQyiKQPLeDXs/iyl4SUTpuUjisQEhqi3VIpR
        1ViyDxNDBEcUSmVeDckKtHm9Amo0+3umQkxM4qI=
X-Google-Smtp-Source: AGHT+IHIoFVFOiWtMzaKAO7ieIDTgggZLhoTsiHars7nnDMbWtONU8UEdrkYgjqquKwJEDVkQe4jEA==
X-Received: by 2002:ad4:4dc6:0:b0:63d:1573:c29b with SMTP id cw6-20020ad44dc6000000b0063d1573c29bmr3207373qvb.54.1691604697712;
        Wed, 09 Aug 2023 11:11:37 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id y10-20020a0cf14a000000b0063d038df3f3sm4610134qvl.52.2023.08.09.11.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 11:11:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qTnei-0055qy-6H;
        Wed, 09 Aug 2023 15:11:36 -0300
Date:   Wed, 9 Aug 2023 15:11:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com,
        Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH for-next v2] IB/core: Add more speed parsing in
 ib_get_width_and_speed()
Message-ID: <ZNPW2K1uF67+yN4c@ziepe.ca>
References: <1690966823-8159-1-git-send-email-selvin.xavier@broadcom.com>
 <20230803175842.GF53714@unreal>
 <CA+sbYW14vED8cHzvqO-=06yJegqBZqVd76uDma=w+d-Y+T+PsQ@mail.gmail.com>
 <20230807135250.GB7100@unreal>
 <CA+sbYW0nF3OqMVUyLkq68+R_beDyXuN0-PbhEru31Y+gMA3WaQ@mail.gmail.com>
 <20230809090601.GS94631@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230809090601.GS94631@unreal>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 09, 2023 at 12:06:01PM +0300, Leon Romanovsky wrote:
> On Wed, Aug 09, 2023 at 02:24:22PM +0530, Selvin Xavier wrote:
> > On Mon, Aug 7, 2023 at 7:22 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Fri, Aug 04, 2023 at 09:43:28AM +0530, Selvin Xavier wrote:
> > > > On Thu, Aug 3, 2023 at 11:28 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > > >
> > > > > On Wed, Aug 02, 2023 at 02:00:23AM -0700, Selvin Xavier wrote:
> > > > > > From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > > > > >
> > > > > > When the Ethernet driver does not provide the number of lanes
> > > > > > in the __ethtool_get_link_ksettings() response, the function
> > > > > > ib_get_width_and_speed() does not take consideration of 50G,
> > > > > > 100G and 200G speeds while calculating the IB width and speed.
> > > > > > Update the width and speed for the above netdev speeds.
> > > > > >
> > > > > > Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> > > > > > Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> > > > > > ---
> > > > > > v1 - v2:
> > > > > >     - Rebased the patch based on the latest changes in ib_get_width_and_speed
> > > > > >     - removed the switch case and use the existing else if check
> > > > > > ---
> > > > > >  drivers/infiniband/core/verbs.c | 11 ++++++++++-
> > > > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> > > > > > index 25367bd..41ff559 100644
> > > > > > --- a/drivers/infiniband/core/verbs.c
> > > > > > +++ b/drivers/infiniband/core/verbs.c
> > > > > > @@ -1899,9 +1899,18 @@ static void ib_get_width_and_speed(u32 netdev_speed, u32 lanes,
> > > > > >               } else if (netdev_speed <= SPEED_40000) {
> > > > > >                       *width = IB_WIDTH_4X;
> > > > > >                       *speed = IB_SPEED_FDR10;
> > > > > > -             } else {
> > > > > > +             } else if (netdev_speed <= SPEED_50000) {
> > > > > > +                     *width = IB_WIDTH_2X;
> > > > > > +                     *speed = IB_SPEED_EDR;
> > > > > > +             } else if (netdev_speed <= SPEED_100000) {
> > > > > >                       *width = IB_WIDTH_4X;
> > > > > >                       *speed = IB_SPEED_EDR;
> > > > > > +             } else if (netdev_speed <= SPEED_200000) {
> > > > > > +                     *width = IB_WIDTH_4X;
> > > > > > +                     *speed = IB_SPEED_HDR;
> > > > >
> > > > >
> > > > > SPEED_50000, SPEED_100000 and SPEED_200000 depends on
> > > > > ClassPortInfo:CapabilityMask2.is* values.
> > > > >
> > > > > For example, SPEED_50000 can b IB_WIDTH_2X/IB_SPEED_EDR and IB_WIDTH_1X/IB_SPEED_HDR.
> > > > Agree with that.
> > > > This reporting can be achieved by the existing code, but the L2 driver
> > > > needs to report non zero values for lanes in
> > > > ethtool_ops->get_link_ksettings.
> > > > Caller of this modified function gets the speed and number of lanes
> > > > from ethtool_ops->get_link_ksettings.
> > > >
> > > > In this patch we are trying to handle the case where ethtool ops
> > > > doesn't provide the lanes.
> > >
> > > Almost all drivers don't support lanes reporting.
> > Agreed. But this patch will at least correct the overall speed
> > reporting. So it's an improvement from the current behavior.
> > If you still feel that this is not needed, you can drop the patch.
> 
> I'm ok with the implementation, just waiting to hear second opinion from Jason.

It seems fine, I think 4x is a reasonable place to default to.

Jason
