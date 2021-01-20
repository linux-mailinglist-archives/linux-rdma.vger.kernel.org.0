Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880B32FD392
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jan 2021 16:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbhATPKf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jan 2021 10:10:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:58020 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390970AbhATPFc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Jan 2021 10:05:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611155085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BH6TNKHuW4gWUAVHtIkPg0PU0n7C2AiGMfwxIRrqI/s=;
        b=bk6uUIp4tttavYgnV2trr6CIlel0wEALUqNeqq9Io4Z2Hf1J6raZ+U5o4D82TFXwsMoxQ9
        esRsDedzgAKaIKav7XSxz+IOk/hj9HxvBtyAM9jbE9wRstpGmYzqpAvIDEmbJan2W7F9RP
        UYJntqmaclLaT0gkZtm0jCxYAC/aaRc=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 635ADAC85;
        Wed, 20 Jan 2021 15:04:45 +0000 (UTC)
Message-ID: <3c3c52c5a19beb1a22c0b51af8fd14297187e82c.camel@suse.com>
Subject: Re: Revert "RDMA/rxe: Remove VLAN code leftovers from RXE"
From:   Martin Wilck <mwilck@suse.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Mohammad Heib <goody698@gmail.com>
Date:   Wed, 20 Jan 2021 16:04:44 +0100
In-Reply-To: <CAD=hENfCoW9pqM3ACWyLaZhw9NhRr-yJz6LLqbwW2psz_SuWHw@mail.gmail.com>
References: <CAD=hENfPfgZpcs+JER9qijyo-D16n1X0q2oPqF-qo88GLkkBXw@mail.gmail.com>
         <411ad58698ea4fe8a6b80758de0039e98ba6a316.camel@suse.com>
         <CAD=hENfCoW9pqM3ACWyLaZhw9NhRr-yJz6LLqbwW2psz_SuWHw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 2021-01-20 at 22:44 +0800, Zhu Yanjun wrote:
> On Wed, Jan 20, 2021 at 10:30 PM Martin Wilck <mwilck@suse.com>
> wrote:
> > 
> > On Wed, 2021-01-20 at 13:33 +0800, Zhu Yanjun wrote:
> > > On Tue, 2021-01-19 at 20:10 +0800, Zhu Yanjun wrote:
> > > > On Tue, Jan 19, 2021 at 6:57 PM <mwilck@suse.com> wrote:
> > > > 
> > > 
> > > > My test scenario which is broken by your patch uses a script
> > > > that
> > > > does
> > > > roughly the following:
> > > 
> > > > # (set up eth0)
> > > > rdma link add rxe_eth0 type rxe netdev eth0
> > > > ip link add link eth0 name eth0.10 type vlan id 10
> > > > ip link set eth0.10 up
> > > > ip addr add 192.168.10.102/24 dev eth0.10
> > > 
> > > Thanks a lot.
> > > It seems that the vlan SKBs also enter RXE.
> > > 
> > > There are 3 hunks in the commit b2d2440430c0("RDMA/rxe: Remove
> > > VLAN
> > > code leftovers from RXE").
> > > 
> > > Can you make more research to find out which hunk causes this
> > > problem?
> > 
> > I'm positive they all need to be reverted. It's not much code
> > altogether that is removed, but this much is necessary to make
> > VLANs
> 
> RXE does not support VLAN now.

Yes, because of your patch. What else do you want to tell me with this
statement?

Anyway, Jason seems to agree with you that the way it worked until
5.10, which was fine as far as I could tell, was wrong. I'd still
appreciate some hints explaining what exactly was wrong with the old
code, and how you guys reckon it should work instead. In particular
considering Mohammad's statement I quoted further down. Was Mohammad
wrong?

What I got so far didn't help me much. I'd especially like to
understand how you think the high-level user experience should be. IOW
how would it be set up by the user, and what would the semantics be wrt
permissions, conneting to peers, etc. If I understood that, I might be
able to address the issues and test myself.

Regards,
Martin



> 
> > work.
> > 
> > > 
> > > From Jason, vlan is not supported now.
> > > If you want to make more work, the link
> > > https://www.spinics.net/lists/linux-rdma/msg94737.html can give
> > > some
> > > tips.
> > 
> > That's fd49ddaf7e26. Did you notice that I referenced that commit
> > in my
> > patch description and actually said it was "absolutely correct"?
> > 
> > Anyway, quoting from Mohammad's email: "therefore RXE must behave
> > the
> > same like HW-RoCE devices and create rxe device per real device
> > only".
> > This is exactly how the code behaved before your patch was applied.
> > Or what am I missing?
> > 
> > I have no experience with HW-RoCE. If it's true that RDMA is setup
> > only
> > "per real device only" there, why would the same thing be wrong for
> > SW-RoCE?
> > 
> > 
> > Martin
> > 
> > 
> 


