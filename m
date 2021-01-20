Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534FF2FD2BC
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Jan 2021 15:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388178AbhATOdG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Jan 2021 09:33:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:49618 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390512AbhATOb2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Jan 2021 09:31:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1611153040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uPmNf8a4yNU2e+6vFfQO/A1jRABZsaZ/pP9PdP2ZmfQ=;
        b=qdpo9fQRwNiKU+kDfGERLe4pXCOKiXW5/BZznLyUVf4bBcN7cDT0um+1Xlibhl1gMiRokZ
        2MsRH4NtMkxcruPpuJj7EkNGLe6fmQnedKtSISjokKYaM/NOzrqD++bhxR0et8SuGjWiOi
        o+cUzjUQxiPNJSP+weSqcwgEAk97zzE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 396C0AAAE;
        Wed, 20 Jan 2021 14:30:40 +0000 (UTC)
Message-ID: <411ad58698ea4fe8a6b80758de0039e98ba6a316.camel@suse.com>
Subject: Re: Revert "RDMA/rxe: Remove VLAN code leftovers from RXE"
From:   Martin Wilck <mwilck@suse.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leon@kernel.org>
Date:   Wed, 20 Jan 2021 15:30:39 +0100
In-Reply-To: <CAD=hENfPfgZpcs+JER9qijyo-D16n1X0q2oPqF-qo88GLkkBXw@mail.gmail.com>
References: <CAD=hENfPfgZpcs+JER9qijyo-D16n1X0q2oPqF-qo88GLkkBXw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 2021-01-20 at 13:33 +0800, Zhu Yanjun wrote:
> On Tue, 2021-01-19 at 20:10 +0800, Zhu Yanjun wrote:
> > On Tue, Jan 19, 2021 at 6:57 PM <mwilck@suse.com> wrote:
> > 
> 
> > My test scenario which is broken by your patch uses a script that
> > does
> > roughly the following:
> 
> > # (set up eth0)
> > rdma link add rxe_eth0 type rxe netdev eth0
> > ip link add link eth0 name eth0.10 type vlan id 10
> > ip link set eth0.10 up
> > ip addr add 192.168.10.102/24 dev eth0.10
> 
> Thanks a lot.
> It seems that the vlan SKBs also enter RXE.
> 
> There are 3 hunks in the commit b2d2440430c0("RDMA/rxe: Remove VLAN
> code leftovers from RXE").
> 
> Can you make more research to find out which hunk causes this
> problem?

I'm positive they all need to be reverted. It's not much code
altogether that is removed, but this much is necessary to make VLANs
work. 

> 
> From Jason, vlan is not supported now.
> If you want to make more work, the link
> https://www.spinics.net/lists/linux-rdma/msg94737.html can give some
> tips.

That's fd49ddaf7e26. Did you notice that I referenced that commit in my
patch description and actually said it was "absolutely correct"?

Anyway, quoting from Mohammad's email: "therefore RXE must behave the
same like HW-RoCE devices and create rxe device per real device only".
This is exactly how the code behaved before your patch was applied.
Or what am I missing?

I have no experience with HW-RoCE. If it's true that RDMA is setup only
"per real device only" there, why would the same thing be wrong for 
SW-RoCE?


Martin


