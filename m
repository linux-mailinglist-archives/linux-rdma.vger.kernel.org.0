Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CA62C4582
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Nov 2020 17:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730405AbgKYQnw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Nov 2020 11:43:52 -0500
Received: from gentwo.org ([3.19.106.255]:37858 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730115AbgKYQnw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Nov 2020 11:43:52 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id A839A3F13D; Wed, 25 Nov 2020 16:43:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id A5EF63F001;
        Wed, 25 Nov 2020 16:43:51 +0000 (UTC)
Date:   Wed, 25 Nov 2020 16:43:51 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Honggang LI <honli@redhat.com>
cc:     =?ISO-8859-15?Q?H=E5kon_Bugge?= <haakon.bugge@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mark Haywood <mark.haywood@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: Is there a working cache for path record and lids etc for
 librdmacm?
In-Reply-To: <20201125081057.GA547111@dhcp-128-72.nay.redhat.com>
Message-ID: <alpine.DEB.2.22.394.2011251632300.298485@www.lameter.com>
References: <alpine.DEB.2.22.394.2011170253150.206345@www.lameter.com> <20201117193329.GH244516@ziepe.ca> <alpine.DEB.2.22.394.2011201805000.248138@www.lameter.com> <6F632AE0-7921-4C5F-8455-F8E9390BD071@oracle.com> <alpine.DEB.2.22.394.2011221246230.261606@www.lameter.com>
 <801AE4A1-7AE8-4756-8F32-5F3BFD189E2B@oracle.com> <alpine.DEB.2.22.394.2011221919240.265127@www.lameter.com> <alpine.DEB.2.22.394.2011231244490.272074@www.lameter.com> <648D2533-E8E8-4248-AF2D-C5F1F60E5BFC@oracle.com> <alpine.DEB.2.22.394.2011241859340.286936@www.lameter.com>
 <20201125081057.GA547111@dhcp-128-72.nay.redhat.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, 25 Nov 2020, Honggang LI wrote:

> > How do I figure out why ibacm is not talking to the subnet manager?
>
> No, you can't talking to subnet manager, if you resolve IPoIB IP address
> or hostname to PathRecord. The query MAD packets will be send to one
> multicast group all ibacm service attached.

Huh? When does it talk to a subnet manager (or the SA)?

If its get an IP address of an IB node that does not have ibacm then it
fails with a timeout ..... ? And leaves hanging kernel threads around by
design?

So it only populates the cache from its local node information?

> To resolve IPoIB address to PathRecord, you must:
> 1) The IPoIB interface must UP and RUNNING on the client and target
> side.
> 2) The ibacm service must RUNNING on the client and target.

That is working if you want to resolve only the IP addresses of the IB
interfaces on the client and target. None else.

Here is the description of ibacms function from the sources:

"Conceptually, the ibacm service implements an ARP like protocol and
either uses IB multicast records to construct path record data or queries
the SA directly, depending on the selected route protocol. By default, the
ibacm services uses and caches SA path record queries."

SA queries dont work. So its broken and cannot talk to the SM.


