Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84342CFDA4
	for <lists+linux-rdma@lfdr.de>; Sat,  5 Dec 2020 19:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgLESmR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 5 Dec 2020 13:42:17 -0500
Received: from gentwo.org ([3.19.106.255]:40830 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgLESmM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 5 Dec 2020 13:42:12 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 2B21B3EF63; Sat,  5 Dec 2020 11:50:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 286733E8D6;
        Sat,  5 Dec 2020 11:50:30 +0000 (UTC)
Date:   Sat, 5 Dec 2020 11:50:30 +0000 (UTC)
From:   Christoph Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     =?ISO-8859-15?Q?H=E5kon_Bugge?= <haakon.bugge@oracle.com>
cc:     Honggang LI <honli@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Mark Haywood <mark.haywood@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: Is there a working cache for path record and lids etc for
 librdmacm?
In-Reply-To: <7812B8AB-7D26-4148-8C8C-E1241A1FC8CD@oracle.com>
Message-ID: <alpine.DEB.2.22.394.2012051145380.41487@www.lameter.com>
References: <alpine.DEB.2.22.394.2011170253150.206345@www.lameter.com> <20201117193329.GH244516@ziepe.ca> <alpine.DEB.2.22.394.2011201805000.248138@www.lameter.com> <6F632AE0-7921-4C5F-8455-F8E9390BD071@oracle.com> <alpine.DEB.2.22.394.2011221246230.261606@www.lameter.com>
 <801AE4A1-7AE8-4756-8F32-5F3BFD189E2B@oracle.com> <alpine.DEB.2.22.394.2011221919240.265127@www.lameter.com> <alpine.DEB.2.22.394.2011231244490.272074@www.lameter.com> <648D2533-E8E8-4248-AF2D-C5F1F60E5BFC@oracle.com> <alpine.DEB.2.22.394.2011241859340.286936@www.lameter.com>
 <20201125081057.GA547111@dhcp-128-72.nay.redhat.com> <alpine.DEB.2.22.394.2011251632300.298485@www.lameter.com> <E2349D8B-26AC-469C-8483-A2241B9B649A@oracle.com> <alpine.DEB.2.22.394.2011300811190.336472@www.lameter.com>
 <7812B8AB-7D26-4148-8C8C-E1241A1FC8CD@oracle.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="531401748-840076553-1607169030=:41487"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--531401748-840076553-1607169030=:41487
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 4 Dec 2020, Håkon Bugge wrote:

> >> Nop, the kernel falls back and uses the neighbour cache instead.
> >
> > But ib_acme hangs? The main issue here is what the user space app does.
> > And we need ibacm to cache user space address resolutions.
>
> I got the impression that you are debugging this with Honggang. If you want me to help, I need, to start with, an strace of ib_acme and ditto of ibacm.

Ok will do that. Do you have access to the RH case on this one?

> >>>> To resolve IPoIB address to PathRecord, you must:
> >>>> 1) The IPoIB interface must UP and RUNNING on the client and target
> >>>> side.
> >>>> 2) The ibacm service must RUNNING on the client and target.
> >>>
> >>> That is working if you want to resolve only the IP addresses of the IB
> >>> interfaces on the client and target. None else.
> >>
> >> That is why it is called IBacm, right?
> >
> > Huh? IBACM is an address resolution service for IB. Somehow that only
> > includes addresses of hosts running IBACM?
>
> Yes. As Honggang explained, ibacmn's address resolution protocol is
> based on IB multicast, as such, the peer must have ibacm running in
> order to send a unicast response back with the L2 addr.

What is the point of the route_prot and addr_prot then?

> >>> Here is the description of ibacms function from the sources:
> >>>
> >>> "Conceptually, the ibacm service implements an ARP like protocol and
> >>> either uses IB multicast records to construct path record data or queries
> >>> the SA directly, depending on the selected route protocol. By default, the
> >>> ibacm services uses and caches SA path record queries."
> >>>
> >>> SA queries dont work. So its broken and cannot talk to the SM.
> >>
> >> Why do you say that? It works all the time for me which uses "sa" as "route_prot".
> >
> > Not here and not in the tests that RH ran to verify the issue.
> >
> > "route_prot" set to "sa" is the default config for the Redhat release of
> > IBACM.
> >
> > However, the addr_prot is set to  "acm" by default. I set it to "sa" with
> > no effect.
>
> OK. Understood. As stated above, let me know if you want me to debug this.

Well whats the point to debug this if its only doing address resolution
via multicast and not via the SA?

Is there a particular issue with usiing the SA? The route information may
contain process specific information?

--531401748-840076553-1607169030=:41487--
