Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15B3469691
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 14:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243812AbhLFNR2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 08:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244163AbhLFNR1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Dec 2021 08:17:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1886C0613F8
        for <linux-rdma@vger.kernel.org>; Mon,  6 Dec 2021 05:13:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99DE0B810AA
        for <linux-rdma@vger.kernel.org>; Mon,  6 Dec 2021 13:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC59C341C5;
        Mon,  6 Dec 2021 13:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638796436;
        bh=r2z61fOsYfdIoWf0CxcJJvam6WD/fV4AyXUh7sj2gBA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SEElqajhgpMuDt5SiA7U7QeST/0TQUWPQBiWi10xdJp3rIegRK/fJord7N8t2Jg95
         nPfYIKqnQIdNvka7N2GcNgD6mf7BLib1p4O+IShrZpnVLX/aW3w2ElKHdgsnDtPWp3
         JSZ9hFriiEUKbVU51hZm+8u7N2DG4ShrXByH92o+jN3jlzf/ngWDYN7ix87CGk345f
         H8908mGHwAhJ1R27X0AMAqid8WIiVlXH229w04Bqgvh5qf/pbROVwZbpl7auF2fa2C
         uXAExa9SJk2pLNEIW2rZWfAK5utXQwD3NSRm8ztVSdZeLdiZ44eVm9NPQWS+ifWcGe
         n+UkE5jPbxtjg==
Date:   Mon, 6 Dec 2021 15:13:51 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [bug report]concurrent blktests nvme-rdma execution lead kernel
 null pointer
Message-ID: <Ya4MjzhZJi//VRo6@unreal>
References: <CAHj4cs8h3e_fY6cKb3XL9aEp8_MT3Po8-W6cL35kKEAvj6qs0Q@mail.gmail.com>
 <OF74AE32F7.7A787A6C-ON002587A0.003CDEF3-002587A0.003EEE89@ibm.com>
 <YaymumNuphhWiCc2@unreal>
 <BYAPR15MB26317A0F809FDAB6BC739937996D9@BYAPR15MB2631.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR15MB26317A0F809FDAB6BC739937996D9@BYAPR15MB2631.namprd15.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 06, 2021 at 11:10:52AM +0000, Bernard Metzler wrote:
> > -----Original Message-----
> > From: Leon Romanovsky <leon@kernel.org>
> > Sent: Sunday, 5 December 2021 12:47
> > To: Bernard Metzler <BMT@zurich.ibm.com>
> > Cc: Yi Zhang <yi.zhang@redhat.com>; RDMA mailing list <linux-
> > rdma@vger.kernel.org>
> > Subject: [EXTERNAL] Re: [bug report]concurrent blktests nvme-rdma
> > execution lead kernel null pointer
> > 
> > On Fri, Dec 03, 2021 at 11:27:22AM +0000, Bernard Metzler wrote:
> > > -----"Yi Zhang" <yi.zhang@redhat.com> wrote: -----
> > >
> > > >To: "RDMA mailing list" <linux-rdma@vger.kernel.org>
> > > >From: "Yi Zhang" <yi.zhang@redhat.com>
> > > >Date: 12/03/2021 03:20AM
> > > >Subject: [EXTERNAL] [bug report]concurrent blktests nvme-rdma
> > > >execution lead kernel null pointer
> > > >
> > > >Hello
> > > >With the concurrent blktests nvme-rdma execution with both rdma_rxe
> > > >and siw lead kernel BUG on 5.16.0-rc3, pls help check it, thanks.
> > > >
> > >
> > > The RDMA core currently does not prevent us from assigning  both siw
> > > and rxe to the same netdev. I think this is what is happening here.
> > > This setting is of no sense, but obviously not prohibited by the RDMA
> > > infrastructure. Behavior is undefined and a kernel panic not
> > > unexpected. Shall we prevent the privileged user from doing this type
> > > of experiments?
> > >
> > > A related question: should we also explicitly refuse to add software
> > > RDMA drivers to netdevs with RDMA hardware active?
> > > This is, while stupid and resulting behavior undefined, currently
> > > possible as well.
> > 
> > In old soft-RoCE manuals, I saw a request to unload mlx4_ib/mlx5_ib
> > modules before configuring RXE. This effectively "prevented" from running
> > with "RDMA hardware active".
> > 
> Right. Same for 'siw over Chelsio T5/6' etc: first unload the iw_cxgb4
> driver, which implements the iWarp protocol, before attaching siw to
> the network interface. But shouldn't the kernel just refuse that two
> instances of the _same_ ULP (e.g., one hardware iWarp, one software
> iWARP) can be attached to the same netdev, potentially sharing IP
> address and port space?

I think that users will get different rdma-cm ids for real HW and SW devices.
The rdma_getaddrinfo() should help here.

> 
> > So I'm not surprised that it doesn't work, but why do you think that this
> > behavior is stupid? RXE/SIW can be seen as ULP and as such it is ok to run
> > many ULPs on same netdev.
> 
> Hmm, from an rdma_cm perspective, I am not sure it is supported
> that two RDMA providers can share the same device and IP address.
> Without recreating it or looking into the code, I expect Yi's
> null pointer issue is caused by this unsupported setup. If it is
> unsupported, it should be impossible to setup.

I agree with you that it is the best solution here, just because it is
good enough for RXE/SIW.

Thanks

> 
> Thanks,
> Bernard.
