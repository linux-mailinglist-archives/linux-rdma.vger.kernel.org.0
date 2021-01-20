Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA232FD40D
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jan 2021 16:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733197AbhATPcE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jan 2021 10:32:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:53756 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390792AbhATP3g (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Jan 2021 10:29:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611156524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UmSs9fCOQGu/NCEVPa+zLvRiAIvJjddygMHbFlky2xU=;
        b=ZC8/6V69btWOJM/ZWaJcWLKKqca1kWM8SQt+D2TjSs+b0KIWYEOIfZqjtDnmXaJ59Kqpy9
        qrRRE8OROROsq4qSOWB0RA8oWj8VK4M7ODfdheji5PsYlQaLQhzlI+TuWRStb+eR5GL8dm
        pNRZlDcup0I8t6PeRWi3tT3imjEmUV8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 088FCAB7F;
        Wed, 20 Jan 2021 15:28:44 +0000 (UTC)
Message-ID: <9ae3161750dfc8500b68b68c94a092d10ae785f4.camel@suse.com>
Subject: Re: Revert "RDMA/rxe: Remove VLAN code leftovers from RXE"
From:   Martin Wilck <mwilck@suse.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Mohammad Heib <goody698@gmail.com>
Date:   Wed, 20 Jan 2021 16:28:43 +0100
In-Reply-To: <20210120151920.GT4147@nvidia.com>
References: <CAD=hENfPfgZpcs+JER9qijyo-D16n1X0q2oPqF-qo88GLkkBXw@mail.gmail.com>
         <411ad58698ea4fe8a6b80758de0039e98ba6a316.camel@suse.com>
         <CAD=hENfCoW9pqM3ACWyLaZhw9NhRr-yJz6LLqbwW2psz_SuWHw@mail.gmail.com>
         <3c3c52c5a19beb1a22c0b51af8fd14297187e82c.camel@suse.com>
         <20210120151920.GT4147@nvidia.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 2021-01-20 at 11:19 -0400, Jason Gunthorpe wrote:
> On Wed, Jan 20, 2021 at 04:04:44PM +0100, Martin Wilck wrote:
> > Anyway, Jason seems to agree with you that the way it worked until
> > 5.10, which was fine as far as I could tell, was wrong. I'd still
> > appreciate some hints explaining what exactly was wrong with the
> > old
> > code, and how you guys reckon it should work instead. In particular
> > considering Mohammad's statement I quoted further down. Was
> > Mohammad
> > wrong?
> 
> In RDMA vlan support revolves around the gid_attr
> 
> To have vlan support the device must copy the vlan from the gid_attrs
> associated with every tx packet, and match the gid_attr table on
> every
> rx, including the vlan.
> 
> For instance, rxe never calls rdma_read_gid_l2_fields to get the
> gid_attr for tx, so it doesn't support vlan, at all.
> 
> > What I got so far didn't help me much. I'd especially like to
> > understand how you think the high-level user experience should be. 
> 
> A single rxe device created on the physical netdev. The core code gid
> table stuff should import vlan entries of upper vlan net devices and
> the general machinery should select those gid table entries when a
> vlan is required.
> 
> rxe should not be creatable on upper vlan net devices to emulate how
> real HW works.
> 
> If your use case that work was creating a rxe on a upper vlan device
> and relying on the tx of vlan layer to stuff the vlan, then the
> problem is how the core code manages the gid table.

My use case was creating RXE on the physical device, creating VLANs on
top of the same physical device, and create RDMA connections over these
VLANs. This is what used to work. I have never observed e.g.
interference between RDMA connections over two different VLANs on the
same physical device, or RDMA connections directly on the physical
device.

Thanks for the explanations, anyway.

Regards,
Martin


