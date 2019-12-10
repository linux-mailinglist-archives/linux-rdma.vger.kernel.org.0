Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDBC1180D7
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2019 07:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfLJGyP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Dec 2019 01:54:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:41856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727184AbfLJGyP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Dec 2019 01:54:15 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B39C206D5;
        Tue, 10 Dec 2019 06:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575960854;
        bh=//7Ip7iY4FBehBxcivBMKKruXVFpoO62zclLTAehRvs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hDEL2pjzCcJJNvZQJwj5x2BZw4+fXamjd4M/dGyeaPr3PKxt8hVJmub+1caCmUJ2k
         KLsWPdwcpfgFKanGxuzreGLM3X3RvApygUKD0w+Lh0DepRmGgAOvDRynjgteOVNpjm
         WJny5DhVkAg70HT0wxP0/0hoSwePVOerNtdm9/Fc=
Date:   Tue, 10 Dec 2019 08:54:10 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Steve Wise <larrystevenwise@gmail.com>,
        linux-rdma@vger.kernel.org, 3100102071@zju.edu.cn
Subject: Re: [PATCH 2/2] rxe: correctly calculate iCRC for unaligned payloads
Message-ID: <20191210065410.GK67461@unreal>
References: <20191203020319.15036-1-larrystevenwise@gmail.com>
 <20191203020319.15036-2-larrystevenwise@gmail.com>
 <a0003c88-10f5-c14a-220d-c100fa160163@acm.org>
 <0f8d9087c48e986d08cf85ef8b59bdca25425eaa.camel@redhat.com>
 <1aee0f71873a4c9da7f965c12419d81333f3a0b4.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1aee0f71873a4c9da7f965c12419d81333f3a0b4.camel@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 09, 2019 at 02:07:06PM -0500, Doug Ledford wrote:
> On Tue, 2019-12-03 at 19:46 -0500, Doug Ledford wrote:
> > On Tue, 2019-12-03 at 08:25 -0800, Bart Van Assche wrote:
> > > On 12/2/19 6:03 PM, Steve Wise wrote:
> > > > If RoCE PDUs being sent or received contain pad bytes, then the
> > > > iCRC
> > > > is miscalculated resulting PDUs being emitted by RXE with an
> > > > incorrect
> > > > iCRC, as well as ingress PDUs being dropped due to erroneously
> > > > detecting
> > > > a bad iCRC in the PDU.  The fix is to include the pad bytes, if
> > > > any,
> > > > in iCRC computations.
> > >
> > > Should this description mention that this patch breaks
> > > compatibility
> > > with SoftRoCE drivers that do not include this fix? Do we need a
> > > kernel
> > > module parameter that allows to select either the old or the new
> > > behavior?
> >
> > No.  The original soft-RoCE driver was supposed to be compatible with
> > hardware devices.  Because of this bug, it obviously wasn't.  This is
> > a
> > bug fix, and we do not need to do anything to be compatible with the
> > broken behavior.  Instead, it just needs noting that the soft-RoCE
> > implementation in prior kernels has a known wire format bug that
> > impacts
> > communications with both fixed versions of the driver and real
> > hardware
> > devices.
>
> I've taken these two patches into for-rc (with fixups to the commit
> message on the second, as well as adding a Fixes: tag on the second).
>
> I stand by what I said about not needing a compatibility flag or module
> option for the user to set.  However, that isn't to say that we can't
> autodetect old soft-RoCE peers.  If we get a packet that fails CRC and
> has pad bytes, then re-run the CRC without the pad bytes and see if it
> matches.  If it does, we could A) mark the current QP as being to an old
> soft-RoCE device (causing us to send without including the pad bytes in
> the CRC) and B) allocate a struct old_soft_roce_peer and save the guid
> into that struct and then put that struct on a list that we then search
> any time we are creating a new queue pair and if the new queue pair goes
> to a guid in the list, then we immediately flag that qp as being to an
> old soft roce device and get the right behavior.  It would slow down qp
> creation somewhat due to the list search, but probably not enough to
> worry about.  No one will be doing a 1,000 node cluster MPI job over
> soft-RoCE, so we should never notice the list length causing search
> problems.  A patch to do something like that would be welcome.

Do you find this implementation needed? I see RXE as a development
platform and in my view it is unlikely that someone will run RXE in
production with mixture of different kernel versions, which requires
such compatibility fallback.

Thanks

>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD


