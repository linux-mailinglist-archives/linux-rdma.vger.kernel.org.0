Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05292FC574
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jan 2021 01:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbhATAM1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Jan 2021 19:12:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:39640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389912AbhASNtw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 19 Jan 2021 08:49:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611064145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dTDTirzfFXcMbl0I90q8K9Ib3F4tQLxtj/OWpsZ76Nk=;
        b=kvVXfSg0KbaT3grQ7Ilgy7BXXi4i9EARkJ9ZA7W0jZ7TN1wUnvAm2n8TK6VYu3qrw5ReRG
        yEdTMVKJtdqYJ7XWH5H+kxA4Ylw6wmOABO1gFElCMubv+c89k+KyBPD7Zlbjh1RmdyBMJ6
        +ZERChMNCsEg2Zvva76EXCT40FpDNRY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0F463AB7F;
        Tue, 19 Jan 2021 13:49:05 +0000 (UTC)
Message-ID: <437bed090fc9af02aaaf46a5841874ca31cc9d36.camel@suse.com>
Subject: Re: [PATCH] Revert "RDMA/rxe: Remove VLAN code leftovers from RXE"
From:   Martin Wilck <mwilck@suse.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Mohamed._. Heib" <goody698@gmail.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Vijay Immanuel <vijayi@attalasystems.com>,
        Nicolas Morey-Chaisemartin <nmoreychaisemartin@suse.com>
Date:   Tue, 19 Jan 2021 14:49:04 +0100
In-Reply-To: <20210119130102.GO4147@nvidia.com>
References: <20210119105644.2658-1-mwilck@suse.com>
         <CAD=hENfrUJGeUGUfb6t6o3d8J_5ONMPfx3Gae8=xwrhq0DBKwg@mail.gmail.com>
         <CANRB76_kkvfX9Us0rSynaNxYuVdYT-SLxEmhp+ijSeP+++HGdA@mail.gmail.com>
         <20210119130102.GO4147@nvidia.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 2021-01-19 at 09:01 -0400, Jason Gunthorpe wrote:
> On Tue, Jan 19, 2021 at 02:40:52PM +0200, Mohamed._. Heib wrote:
> >    Hi,
> >    As far as i remember the traffic still can be encapsulated over
> > the
> >    vlan interface with vlan tag
> >    by specifying the vlan interface gid index that mapped to the
> > vlan ip
> >    on the vlan parent interface gids table.
> >    And by removing the vlan related functionality on rxe (commit:
> >    b2d2440430c0) the rxe still can send traffic via vlan interface
> >    but can't receive from vlan interface and that will break the
> > vlan
> >    functionality on rxe so i think you need keep the vlan related
> > code on
> >    rxe.
> 
> That may be, but the code here is still wrong.
> 
> Incoming packets are supposed to be matched to the gid table, which
> specifies the allowed vlans, it can't just be taken raw from the skb
> like this.

I lack the deep understanding of the RDMA stack to fully understand.
Are you saying it's a permission problem? Do you see a security issue?
Or is it not compliant with some spec? Which?

> If someone wants to add vlan support to rxe it needs to be done
> right,
> currently it doesn't support vlan.

Hm. As a matter of fact, it has "worked" this way in mainline since
v5.0, when 43c9fc509fa5 ("rdma_rxe: make rxe work over 802.1q VLAN
devices") had been merged. The code that deals with VLANs in RXE, which
was fixed by that commit, is older. AFAICS it dates back to the first
merge of the rxe driver.

Just ripping the code out causes a regression, after 10 kernel minor
releases during which it "worked" in practice (as far as I can judge).
I suppose there are only a few users of this feature, but I fail to see
why keeping this code in until a clean implementation is available
would do any harm.

I'd like to fix this for good, but I lack the knowledge to do this, at
least in the short term. I've asked back in 2018 how RXE+VLAN was
intended to work, but never got an answer.

Regards,
Martin


