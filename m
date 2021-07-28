Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3063D8D2E
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jul 2021 13:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbhG1LxQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Jul 2021 07:53:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:51130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234638AbhG1LxQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Jul 2021 07:53:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EE9EE60F93;
        Wed, 28 Jul 2021 11:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627473194;
        bh=CoNlbWpxRqirEoDfSJZQuE/rJKRJRkJbDQtxblx8y/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N4X8/seBx5tSFnAnIyJLJI10ENk7bXQOdVr+PPAqkagKbnrCtWNsmOVodpb0xZB0l
         71385HPI51FlX+0xE9EFSV0ciqXkLdF8pQWH0wgyvCa5Qw9WMIsTfqY/dddfspKJqo
         qvWme+ckDE8bXCkzeRM2lI7RUOkiVa3zWUV0mre8MxGL3Ex5bx2qIpRN91BivlP914
         IFhZyxGYG71ND7XuEsVMgeFcQWuXLVFMfLAvbavp7ZJsBFjqbIo54Qyp2wcEnb33w7
         jHmpudTHtOPRsEDwgVICGNYyf+J4EPD74FG95kFFwuSePyRqaOZU1JACLmIFZoVE0H
         4R5P99/h73jYQ==
Date:   Wed, 28 Jul 2021 14:53:10 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next] docs: Fix infiniband uverbs minor number
Message-ID: <YQFFJgMXFSN8IcjC@unreal>
References: <a1213ef6064911aa3499322691bc465482818a3a.1626936170.git.leonro@nvidia.com>
 <YPrJorr7r9Kd2IzA@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPrJorr7r9Kd2IzA@unreal>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Jason ????

On Fri, Jul 23, 2021 at 04:52:34PM +0300, Leon Romanovsky wrote:
> + RDMA
> 
> On Thu, Jul 22, 2021 at 09:45:07AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Starting from the introduction of infiniband subsystem, the uverbs
> > char devices started from 192 as a minor number, see 
> > commit bc38a6abdd5a ("[PATCH] IB uverbs: core implementation"), but
> > the documentation was slightly different.
> > 
> > This patch updates the admin guide documentation to reflect it.
> > 
> > Fixes: 9d85025b0418 ("docs-rst: create an user's manual book")
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  Documentation/admin-guide/devices.txt | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
> > index 9c2be821c225..922c23bb4372 100644
> > --- a/Documentation/admin-guide/devices.txt
> > +++ b/Documentation/admin-guide/devices.txt
> > @@ -2993,10 +2993,10 @@
> >  		65 = /dev/infiniband/issm1     Second InfiniBand IsSM device
> >  		  ...
> >  		127 = /dev/infiniband/issm63    63rd InfiniBand IsSM device
> > -		128 = /dev/infiniband/uverbs0   First InfiniBand verbs device
> > -		129 = /dev/infiniband/uverbs1   Second InfiniBand verbs device
> > +		192 = /dev/infiniband/uverbs0   First InfiniBand verbs device
> > +		193 = /dev/infiniband/uverbs1   Second InfiniBand verbs device
> >  		  ...
> > -		159 = /dev/infiniband/uverbs31  31st InfiniBand verbs device
> > +		223 = /dev/infiniband/uverbs31  31st InfiniBand verbs device
> >  
> >   232 char	Biometric Devices
> >  		0 = /dev/biometric/sensor0/fingerprint	first fingerprint sensor on first device
> > -- 
> > 2.31.1
> > 
