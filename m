Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEAE52D26C0
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Dec 2020 10:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgLHJA2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Dec 2020 04:00:28 -0500
Received: from gentwo.org ([3.19.106.255]:41208 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728362AbgLHJA2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Dec 2020 04:00:28 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 1C3873ED63; Tue,  8 Dec 2020 08:59:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 19FBF3EC13;
        Tue,  8 Dec 2020 08:59:42 +0000 (UTC)
Date:   Tue, 8 Dec 2020 08:59:42 +0000 (UTC)
From:   Christoph Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Mark Haywood <mark.haywood@oracle.com>
cc:     =?ISO-8859-15?Q?H=E5kon_Bugge?= <haakon.bugge@oracle.com>,
        Honggang LI <honli@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: Is there a working cache for path record and lids etc for
 librdmacm?
In-Reply-To: <cd066540-1085-62e8-0995-e1fbd12ddd26@oracle.com>
Message-ID: <alpine.DEB.2.22.394.2012080855490.64081@www.lameter.com>
References: <alpine.DEB.2.22.394.2011170253150.206345@www.lameter.com> <20201117193329.GH244516@ziepe.ca> <alpine.DEB.2.22.394.2011201805000.248138@www.lameter.com> <6F632AE0-7921-4C5F-8455-F8E9390BD071@oracle.com> <alpine.DEB.2.22.394.2011221246230.261606@www.lameter.com>
 <801AE4A1-7AE8-4756-8F32-5F3BFD189E2B@oracle.com> <alpine.DEB.2.22.394.2011221919240.265127@www.lameter.com> <alpine.DEB.2.22.394.2011231244490.272074@www.lameter.com> <648D2533-E8E8-4248-AF2D-C5F1F60E5BFC@oracle.com> <alpine.DEB.2.22.394.2011241859340.286936@www.lameter.com>
 <20201125081057.GA547111@dhcp-128-72.nay.redhat.com> <alpine.DEB.2.22.394.2011251632300.298485@www.lameter.com> <E2349D8B-26AC-469C-8483-A2241B9B649A@oracle.com> <alpine.DEB.2.22.394.2011300811190.336472@www.lameter.com> <7812B8AB-7D26-4148-8C8C-E1241A1FC8CD@oracle.com>
 <alpine.DEB.2.22.394.2012071021390.53970@www.lameter.com> <cd066540-1085-62e8-0995-e1fbd12ddd26@oracle.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 7 Dec 2020, Mark Haywood wrote:

> On 12/7/20 5:28 AM, Christoph Lameter wrote:
> > Looking at librdmacm/rdma_getaddrinfo():
> >
> > It seems that the call to the IBACM via ucma_ib_resolve() is only done
> > after a regular getaddrinfo() was run. Is IBACM truly able to provide
> > address resolution or is it just some strange after processing if the main
> > resolution attempt fails?
>
>
>
> getaddrinfo() is called only if 'node' or 'service' are set. Otherwise,
> 'hints' are set and used.

Right. It calls the function that does an RPC to ibacm *after*
getaddrinfo. This is confusing. I would have expected this to happen
*before* getaddrinfo and that getaddrinfo would be skipped if ibacm
returns a hit in the cache.

If node is set then we want something to be resolved. So it *first* should
check with ibacm. No?

> ucma_set_ib_route() (called from rdma_resolve_route()) calls
> rdma_getaddrinfo() with 'hints' set.

That in turn calls getaddrinfo.

> Increasing the ibacm log level and then using cmtime(1), I see log messages
> that indicate that ibacm is resolving addresses.

Well it does that under certain circumstances. What kind of addresses are
you resolving?

