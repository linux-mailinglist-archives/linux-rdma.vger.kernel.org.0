Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447802D0E01
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Dec 2020 11:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgLGK3Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Dec 2020 05:29:24 -0500
Received: from gentwo.org ([3.19.106.255]:41046 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgLGK3X (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Dec 2020 05:29:23 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 0064C3F11E; Mon,  7 Dec 2020 10:28:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id F19873EF63;
        Mon,  7 Dec 2020 10:28:32 +0000 (UTC)
Date:   Mon, 7 Dec 2020 10:28:32 +0000 (UTC)
From:   Christoph Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     =?ISO-8859-15?Q?H=E5kon_Bugge?= <haakon.bugge@oracle.com>
cc:     Honggang LI <honli@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Mark Haywood <mark.haywood@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: Is there a working cache for path record and lids etc for
 librdmacm?
In-Reply-To: <7812B8AB-7D26-4148-8C8C-E1241A1FC8CD@oracle.com>
Message-ID: <alpine.DEB.2.22.394.2012071021390.53970@www.lameter.com>
References: <alpine.DEB.2.22.394.2011170253150.206345@www.lameter.com> <20201117193329.GH244516@ziepe.ca> <alpine.DEB.2.22.394.2011201805000.248138@www.lameter.com> <6F632AE0-7921-4C5F-8455-F8E9390BD071@oracle.com> <alpine.DEB.2.22.394.2011221246230.261606@www.lameter.com>
 <801AE4A1-7AE8-4756-8F32-5F3BFD189E2B@oracle.com> <alpine.DEB.2.22.394.2011221919240.265127@www.lameter.com> <alpine.DEB.2.22.394.2011231244490.272074@www.lameter.com> <648D2533-E8E8-4248-AF2D-C5F1F60E5BFC@oracle.com> <alpine.DEB.2.22.394.2011241859340.286936@www.lameter.com>
 <20201125081057.GA547111@dhcp-128-72.nay.redhat.com> <alpine.DEB.2.22.394.2011251632300.298485@www.lameter.com> <E2349D8B-26AC-469C-8483-A2241B9B649A@oracle.com> <alpine.DEB.2.22.394.2011300811190.336472@www.lameter.com>
 <7812B8AB-7D26-4148-8C8C-E1241A1FC8CD@oracle.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


Looking at librdmacm/rdma_getaddrinfo():

It seems that the call to the IBACM via ucma_ib_resolve() is only done
after a regular getaddrinfo() was run. Is IBACM truly able to provide
address resolution or is it just some strange after processing if the main
resolution attempt fails?

AFACIT ucma_resolve() should run before getaddrinfo()?

Or is there some magic in getaddrinfo() that actually does another call to
the IBACM daemon?



What is also confusing is that the path record determination is part of
getaddrinfo() as well. So both the address and route lookup end up in
getaddrinfo(). Is IB therefore using the kernel to do the lookups?




