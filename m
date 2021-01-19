Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DB22FB8A1
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Jan 2021 15:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387430AbhASN0M (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 08:26:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:41510 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392912AbhASNOz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Jan 2021 08:14:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611062006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=evtmKTLSIqyRfQDYA8S2u8hWMWmpFcVladCMvE5eV5I=;
        b=NLZkl3TeMqhKi69zy2BHCKYyU52iyT9h51uDMshh/fZ13NrEzeC5rZiYlWEz19ZnufJtoX
        wrCSpcL8HK4b/iwYuuBkyiUJzry2C5fp+XonC82r1EwW2MexgjYYeYC1a+h2g9dOy+KXFK
        hRrK0F7FihypBhJdS4i6s7VnsnyLmqs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7D683AB7F;
        Tue, 19 Jan 2021 13:13:26 +0000 (UTC)
Message-ID: <23fce5aa875575b9a5446baa793a948cc393ca73.camel@suse.com>
Subject: Re: [PATCH] Revert "RDMA/rxe: Remove VLAN code leftovers from RXE"
From:   Martin Wilck <mwilck@suse.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Mohammad Heib <goody698@gmail.com>,
        Vijay Immanuel <vijayi@attalasystems.com>,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue, 19 Jan 2021 14:13:25 +0100
In-Reply-To: <CAD=hENfrUJGeUGUfb6t6o3d8J_5ONMPfx3Gae8=xwrhq0DBKwg@mail.gmail.com>
References: <20210119105644.2658-1-mwilck@suse.com>
         <CAD=hENfrUJGeUGUfb6t6o3d8J_5ONMPfx3Gae8=xwrhq0DBKwg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 2021-01-19 at 20:10 +0800, Zhu Yanjun wrote:
> On Tue, Jan 19, 2021 at 6:57 PM <mwilck@suse.com> wrote:
> > 
> > From: Martin Wilck <mwilck@suse.com>
> > 
> > This reverts commit b2d2440430c0fdd5e0cad3efd6d1c9e3d3d02e5b.
> > 
> > It's true that creating rxe on top of 802.1q interfaces doesn't
> > work.
> > Thus, commit fd49ddaf7e26 ("RDMA/rxe: prevent rxe creation on top
> > of vlan interface")
> > was absolutely correct.
> > 
> > But b2d2440430c0 was incorrect assuming that with this change,
> > RDMA and VLAN don't work togehter at all. It just has to be
> > set up differently. Rather than creating rxe on top of the VLAN
> > interface, rxe must be created on top of the physical interface.
> > RDMA then works just fine through VLAN interfaces on top of that
> > physical interface, via the "upper device" logic.
> 
> I read this commit log for several times. I can not get you.
> Can you show me by an example?

My test scenario which is broken by your patch uses a script that does
roughly the following:

# (set up eth0)
rdma link add rxe_eth0 type rxe netdev eth0
ip link add link eth0 name eth0.10 type vlan id 10
ip link set eth0.10 up
ip addr add 192.168.10.102/24 dev eth0.10

nvme discover -t rdma -a 192.168.10.101 -s 4420  

192.168.10.101 is another host that configures the network
and rxe the same way, and has some nvmet targets.

  => fails with your patch applied, works otherwise.

Regards,
Martin

