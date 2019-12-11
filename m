Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87E4311A43F
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2019 06:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfLKF7y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 11 Dec 2019 00:59:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:33880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725800AbfLKF7y (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 11 Dec 2019 00:59:54 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D10272077B;
        Wed, 11 Dec 2019 05:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576043993;
        bh=AMQfvMUe50fmxFTfX8iP4OTXclYSPRTORX5GBphVd9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zxEiJ8F6WcKaorpbHOnxtoOfXh1XuoZyDa2XPlstb37EQzPfQtd3mgepvb33jUE/5
         hDZzPm6VXPrfZq0SwJob3M/iG3QDQNOd0NP8oNFQ+o45cLCZ1vlM0VMa161X6d2dzb
         S5xqdGumw5mrF5aGjJZkZ1KNKJ9nBc/F5sU2/Clo=
Date:   Wed, 11 Dec 2019 07:59:50 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Steve Wise <larrystevenwise@gmail.com>,
        linux-rdma@vger.kernel.org, 3100102071@zju.edu.cn
Subject: Re: [PATCH 2/2] rxe: correctly calculate iCRC for unaligned payloads
Message-ID: <20191211055950.GQ67461@unreal>
References: <20191203020319.15036-1-larrystevenwise@gmail.com>
 <20191203020319.15036-2-larrystevenwise@gmail.com>
 <a0003c88-10f5-c14a-220d-c100fa160163@acm.org>
 <0f8d9087c48e986d08cf85ef8b59bdca25425eaa.camel@redhat.com>
 <1aee0f71873a4c9da7f965c12419d81333f3a0b4.camel@redhat.com>
 <20191210065410.GK67461@unreal>
 <c20696208c239bd11621ad3101735255738bcc97.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c20696208c239bd11621ad3101735255738bcc97.camel@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Dec 10, 2019 at 11:24:21PM -0500, Doug Ledford wrote:
> On Tue, 2019-12-10 at 08:54 +0200, Leon Romanovsky wrote:
> > On Mon, Dec 09, 2019 at 02:07:06PM -0500, Doug Ledford wrote:
> > >
> > > I've taken these two patches into for-rc (with fixups to the commit
> > > message on the second, as well as adding a Fixes: tag on the
> > > second).
> > >
> > > I stand by what I said about not needing a compatibility flag or
> > > module
> > > option for the user to set.  However, that isn't to say that we
> > > can't
> > > autodetect old soft-RoCE peers.  If we get a packet that fails CRC
> > > and
> > > has pad bytes, then re-run the CRC without the pad bytes and see if
> > > it
> > > matches.  If it does, we could A) mark the current QP as being to an
> > > old
> > > soft-RoCE device (causing us to send without including the pad bytes
> > > in
> > > the CRC) and B) allocate a struct old_soft_roce_peer and save the
> > > guid
> > > into that struct and then put that struct on a list that we then
> > > search
> > > any time we are creating a new queue pair and if the new queue pair
> > > goes
> > > to a guid in the list, then we immediately flag that qp as being to
> > > an
> > > old soft roce device and get the right behavior.  It would slow down
> > > qp
> > > creation somewhat due to the list search, but probably not enough to
> > > worry about.  No one will be doing a 1,000 node cluster MPI job over
> > > soft-RoCE, so we should never notice the list length causing search
> > > problems.  A patch to do something like that would be welcome.
> >
> > Do you find this implementation needed? I see RXE as a development
> > platform and in my view it is unlikely that someone will run RXE in
> > production with mixture of different kernel versions, which requires
> > such compatibility fallback.
>
> It's not a requirement, that's why I took the patches as they were.  It
> would just be a "nice to have".

I see, thanks

>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD


