Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70B36A45D4
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Aug 2019 20:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfHaSzh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 31 Aug 2019 14:55:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:39476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbfHaSzh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 31 Aug 2019 14:55:37 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43BBF21874;
        Sat, 31 Aug 2019 18:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567277735;
        bh=Dm2LuS3jJLcO/GR8RHFx+M0nQrZnw8jNvMzb3VvO2AU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BOxvxdGxpdfDWyP2E1R+ihbS2MQPVLr4IAolpg8x7Gj00Z5KlzOIx4BqJOoRMPZWr
         d6Zmh8DG/taSyqS03bwzJ4lTUV9fQTySnGCWkKkgxbajjhKXbrEUSjSEZrstGzKXTz
         5AeTklR0oNg10yyr0wVtvxMBhBtik6AJsPPB9rmY=
Date:   Sat, 31 Aug 2019 21:55:21 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Michal Kalderon <Michal.Kalderon@cavium.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: qedr memory leak report
Message-ID: <20190831185521.GK12611@unreal>
References: <93085620-9DAA-47A3-ACE1-932F261674AC@oracle.com>
 <13F323F2-D618-46C3-BE1B-106FD2BEE7F4@oracle.com>
 <20190831073048.GH12611@unreal>
 <63286035eb752429fdb651750acf74765caecfe5.camel@redhat.com>
 <20190831151945.GJ12611@unreal>
 <ee70c5983baee6ed42bd74b7b3dacfdb8bd035af.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee70c5983baee6ed42bd74b7b3dacfdb8bd035af.camel@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Aug 31, 2019 at 01:17:05PM -0400, Doug Ledford wrote:
> On Sat, 2019-08-31 at 18:19 +0300, Leon Romanovsky wrote:
> > On Sat, Aug 31, 2019 at 10:33:13AM -0400, Doug Ledford wrote:
> > > On Sat, 2019-08-31 at 10:30 +0300, Leon Romanovsky wrote:
> > > > Doug,
> > > >
> > > > I think that it can be counted as good example why allowing memory
> > > > leaks
> > > > in drivers (HNS) is not so great idea.
> > >
> > > Crashing the machine is worse.
> >
> > The problem with it that you are "punishing" whole subsystem
> > because of some piece of crap which anyway users can't buy.
>
> No I'm not.  The patch in question was in the hns driver and only leaked
> resources assigned to the hns card when the hns card timed out in
> freeing those resources.  That doesn't punish the entire subsystem, it
> only punishes the users of that card, and then only if the card has
> flaked out.

Unfortunately, but you are.

Our model is based on the fact that destroy operations can't fail and
all allocations performed by IB/core should be released right after call
to relevant destroy callback. The fact that you are allowing to one
driver don't success in destroy, means that you will need to allow
to everyone chance to return errors and skip freeing resources.

>
> > If HNS wants to have memory leaks, they need to do it outside
> > of upstream kernel.
>
> Nope.
>
> > In general, if users buy shitty hardware, they need to be ready
> > to have kernel panics too. It works with faulty DRAM where kernel
> > doesn't hide such failures, so don't see any rationale to invent
> > something special for ib_device.
>
> What you are advocating for is not "shitty DRAM crashing the machine",
> you are advocating for "having ECC DRAM and then intentionally turning
> the ECC off and then crashing the machine".  Please repeat after me: WE
> DONT CRASH MACHINES.  PERIOD.  If it is avoidable, we avoid it.  That's
> why BUG_ONs have to go and why they piss Linus off so much.  If you
> crash the machine, people are left scratching their head and asking why.
> If you don't crash the machine, they have a chance to debug the issue
> and resolve it.  The entire idea that you are advocating for crashing
> the machine as being preferable to leaking a few resources is ludicrous.
> WE DONT CRASH MACHINES.  PERIOD.  Please repeat that until it fully
> sinks in.

I'm not advocating for that and I don't buy explanation that freeing
memory will cause for machine to crash, at the end, freed memory
means that user won't have access to such bad resource.

Thanks

>
> > Thanks
>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD


