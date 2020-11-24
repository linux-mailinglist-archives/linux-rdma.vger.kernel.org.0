Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112292C305E
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Nov 2020 20:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389340AbgKXTB2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Nov 2020 14:01:28 -0500
Received: from gentwo.org ([3.19.106.255]:37726 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389285AbgKXTB1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Nov 2020 14:01:27 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id ABC653ED63; Tue, 24 Nov 2020 19:01:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id A975A3EA56;
        Tue, 24 Nov 2020 19:01:25 +0000 (UTC)
Date:   Tue, 24 Nov 2020 19:01:25 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     =?ISO-8859-15?Q?H=E5kon_Bugge?= <haakon.bugge@oracle.com>
cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Mark Haywood <mark.haywood@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: Is there a working cache for path record and lids etc for
 librdmacm?
In-Reply-To: <648D2533-E8E8-4248-AF2D-C5F1F60E5BFC@oracle.com>
Message-ID: <alpine.DEB.2.22.394.2011241859340.286936@www.lameter.com>
References: <alpine.DEB.2.22.394.2011170253150.206345@www.lameter.com> <20201117193329.GH244516@ziepe.ca> <alpine.DEB.2.22.394.2011201805000.248138@www.lameter.com> <6F632AE0-7921-4C5F-8455-F8E9390BD071@oracle.com> <alpine.DEB.2.22.394.2011221246230.261606@www.lameter.com>
 <801AE4A1-7AE8-4756-8F32-5F3BFD189E2B@oracle.com> <alpine.DEB.2.22.394.2011221919240.265127@www.lameter.com> <alpine.DEB.2.22.394.2011231244490.272074@www.lameter.com> <648D2533-E8E8-4248-AF2D-C5F1F60E5BFC@oracle.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="531401748-1636915408-1606244485=:286936"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--531401748-1636915408-1606244485=:286936
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Mon, 23 Nov 2020, Håkon Bugge wrote:

> > Got version 33.0 from Redhat with the option. Set it but ibacm still times
> > out when trying to contact the SM.
>
> Contact the peer ibacm, that is. Is it started?


It can contact the peer ibacm if its running on a particular host. Then
the resolution succeeds. But we want ibacm to talk to the subnet manager.

> And, ib_acme bypasses the kernel_only check. I assume a real app (e.g.,
> qperf <destination_ip> -cm1 rc_bw) would work, but incur an excess delay
> due to the ibacm timeout, before failing back to the kernel neighbour
> cache.

Ok. But what does it matter?


How do I figure out why ibacm is not talking to the subnet manager?
--531401748-1636915408-1606244485=:286936--
