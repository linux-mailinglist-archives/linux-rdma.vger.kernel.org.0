Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A69F2C7FC5
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Nov 2020 09:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgK3IZG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Nov 2020 03:25:06 -0500
Received: from gentwo.org ([3.19.106.255]:38460 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727529AbgK3IZF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 30 Nov 2020 03:25:05 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 45E1C3F001; Mon, 30 Nov 2020 08:24:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 432C13EFF6;
        Mon, 30 Nov 2020 08:24:14 +0000 (UTC)
Date:   Mon, 30 Nov 2020 08:24:14 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     =?ISO-8859-15?Q?H=E5kon_Bugge?= <haakon.bugge@oracle.com>
cc:     Honggang LI <honli@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Mark Haywood <mark.haywood@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: Is there a working cache for path record and lids etc for
 librdmacm?
In-Reply-To: <E2349D8B-26AC-469C-8483-A2241B9B649A@oracle.com>
Message-ID: <alpine.DEB.2.22.394.2011300811190.336472@www.lameter.com>
References: <alpine.DEB.2.22.394.2011170253150.206345@www.lameter.com> <20201117193329.GH244516@ziepe.ca> <alpine.DEB.2.22.394.2011201805000.248138@www.lameter.com> <6F632AE0-7921-4C5F-8455-F8E9390BD071@oracle.com> <alpine.DEB.2.22.394.2011221246230.261606@www.lameter.com>
 <801AE4A1-7AE8-4756-8F32-5F3BFD189E2B@oracle.com> <alpine.DEB.2.22.394.2011221919240.265127@www.lameter.com> <alpine.DEB.2.22.394.2011231244490.272074@www.lameter.com> <648D2533-E8E8-4248-AF2D-C5F1F60E5BFC@oracle.com> <alpine.DEB.2.22.394.2011241859340.286936@www.lameter.com>
 <20201125081057.GA547111@dhcp-128-72.nay.redhat.com> <alpine.DEB.2.22.394.2011251632300.298485@www.lameter.com> <E2349D8B-26AC-469C-8483-A2241B9B649A@oracle.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="531401748-1891282589-1606724654=:336472"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--531401748-1891282589-1606724654=:336472
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 27 Nov 2020, Håkon Bugge wrote:

> > Huh? When does it talk to a subnet manager (or the SA)?
>
> When resolving the route AND the option "route_prot" is set to "sa". If
> set to "acm", what Hong describes above applies.

My config has "route_prot" set to "sa"

> > If its get an IP address of an IB node that does not have ibacm then it
> > fails with a timeout ..... ? And leaves hanging kernel threads around by
> > design?
>
> Nop, the kernel falls back and uses the neighbour cache instead.

But ib_acme hangs? The main issue here is what the user space app does.
And we need ibacm to cache user space address resolutions.

> > So it only populates the cache from its local node information?
>
> No, if you use ibacm for address resolution the only protocol it has is
> "acm", which means the information comes from a peer ibacm.
>
> If you talk about the cache for routes, it comes either from the SA or a
> peer ibacm, depending on the "route_prot" setting.

I have always run it with that setting. How can I debug this issue and how
can we fix this?

>
> >> To resolve IPoIB address to PathRecord, you must:
> >> 1) The IPoIB interface must UP and RUNNING on the client and target
> >> side.
> >> 2) The ibacm service must RUNNING on the client and target.
> >
> > That is working if you want to resolve only the IP addresses of the IB
> > interfaces on the client and target. None else.
>
> That is why it is called IBacm, right?

Huh? IBACM is an address resolution service for IB. Somehow that only
includes addresses of hosts running IBACM?

>
> > Here is the description of ibacms function from the sources:
> >
> > "Conceptually, the ibacm service implements an ARP like protocol and
> > either uses IB multicast records to construct path record data or queries
> > the SA directly, depending on the selected route protocol. By default, the
> > ibacm services uses and caches SA path record queries."
> >
> > SA queries dont work. So its broken and cannot talk to the SM.
>
> Why do you say that? It works all the time for me which uses "sa" as "route_prot".

Not here and not in the tests that RH ran to verify the issue.

"route_prot" set to "sa" is the default config for the Redhat release of
IBACM.

However, the addr_prot is set to  "acm" by default. I set it to "sa" with
no effect.

--531401748-1891282589-1606724654=:336472--
