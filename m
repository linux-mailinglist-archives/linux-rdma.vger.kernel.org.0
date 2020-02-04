Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0A915165C
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 08:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgBDHRn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 02:17:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:55442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgBDHRn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Feb 2020 02:17:43 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD7A921582;
        Tue,  4 Feb 2020 07:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580800662;
        bh=NHpe00tocpgpDFOjW1dvsb+cFxImQoC9dj2jGu7gdJs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q+FB0Iaue+Y3ZB79r/cAxCVhNE2GOZQGLD/e6fxht7FXQ2X/kMUCawGj0kQNwLHSy
         WALD2Fuz3rzpYva74lFUDgYtAsvWhn7tzv+dB+C9foDL0FT7g0nm6VcjA5O/604Wh9
         E1ZJpSs92TXL/SFweh9xPBdmk37TM3IczBSlVRns=
Date:   Tue, 4 Feb 2020 09:17:39 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Parav Pandit <parav@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH v5] libibverbs: display gid type in ibv_devinfo
Message-ID: <20200204071739.GV414821@unreal>
References: <1580752324-24742-1-git-send-email-devesh.sharma@broadcom.com>
 <20200203175317.GQ23346@mellanox.com>
 <CANjDDBh_Xv0BNhTYZ1xaaOCQ8-ijHUMqDE68_J4aqRF-EnT2Zg@mail.gmail.com>
 <20200203180405.GR23346@mellanox.com>
 <AM0PR05MB486694589EA1CBC66F598066D1030@AM0PR05MB4866.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR05MB486694589EA1CBC66F598066D1030@AM0PR05MB4866.eurprd05.prod.outlook.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 04, 2020 at 04:27:45AM +0000, Parav Pandit wrote:
>
>
> > From: Jason Gunthorpe <jgg@mellanox.com>
> > Sent: Monday, February 3, 2020 11:34 PM
> >
> > On Mon, Feb 03, 2020 at 11:31:06PM +0530, Devesh Sharma wrote:
> > > On Mon, Feb 3, 2020 at 11:23 PM Jason Gunthorpe <jgg@mellanox.com>
> > wrote:
> > > >
> > > > On Mon, Feb 03, 2020 at 12:52:04PM -0500, Devesh Sharma wrote:
> > > > > It becomes difficult to make out from the output of ibv_devinfo if
> > > > > a particular gid index is RoCE v2 or not.
> > > > >
> > > > > Adding a string to the output of ibv_devinfo -v to display the gid
> > > > > type at the end of gid.
> > > > >
> > > > > The output would look something like below:
> > > > > $ ibv_devinfo -v -d bnxt_re2
> > > > > hca_id: bnxt_re2
> > > > >  transport:             InfiniBand (0)
> > > > >  fw_ver:                216.0.220.0
> > > > >  node_guid:             b226:28ff:fed3:b0f0
> > > > >  sys_image_guid:        b226:28ff:fed3:b0f0
> > > > >   .
> > > > >   .
> > > > >   .
> > > > >   .
> > > > >        phys_state:      LINK_UP (5)
> > > > >        GID[  0]:               fe80::b226:28ff:fed3:b0f0, IB/RoCE v1
> > > > >        GID[  1]:               fe80::b226:28ff:fed3:b0f0, RoCE v2
> > > > >        GID[  2]:               ::ffff:192.170.1.101, IB/RoCE v1
> > > > >        GID[  3]:               ::ffff:192.170.1.101, RoCE v2
> > > >
> > > > v1 GIDs are GIDs and should never be formed as IPv6 addreses..
> > > So, V1 gids would fall back to old style of display and there will be
> > > one more check for gid-type inside the loop...
> >
> > Yes
> >
> > Parav should we show both the v6 and classic format for a v2 GID? ie
> >
> >         GID[  3]:               0000:0000:0000:ffff:xxxx:xxxx:xxxx, RoCE v2
> >                                 ::ffff:192.170.1.101
> >
> Due to lack of support of GID's netdev, v1/v2 type info in ibv_devinfo output, most users that I know of are using non upstream show_gids script.
> So changing format here shouldn't break the existing users scripts.
> There may be some scripts that may find this format different.
> So I think printing both is likely a more safer option.

I don't understand this argument. Output from example tool (ibv_devinfo)
inside libibverbs can't be considered API and we can't live in constant
fear that some user script will break. Of course, we will try to keep it
stable, but there is no such promise.

Thanks

>
> > Lets also supress the 'IB/RoCE v1' string on !roce device. IB only has one GID
> > type, there is no reason to print anything
> >
> > Jason
