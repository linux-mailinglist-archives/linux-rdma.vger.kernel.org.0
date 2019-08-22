Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFD999160
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 12:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732378AbfHVKvC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 06:51:02 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:1420 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731964AbfHVKvC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Aug 2019 06:51:02 -0400
Received: from localhost (budha.blr.asicdesigners.com [10.193.185.4])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x7MAoer0007835;
        Thu, 22 Aug 2019 03:50:41 -0700
Date:   Thu, 22 Aug 2019 16:20:39 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Doug Ledford <dledford@redhat.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Nirranjan Kirubaharan <nirranjan@chelsio.com>
Subject: Re: Re: [PATCH for-rc] siw: fix for 'is_kva' flag issue in
 siw_tx_hdt()
Message-ID: <20190822105037.GA18600@chelsio.com>
References: <b2251973c16b336c4d48e8417ce50f0c55598a9b.camel@redhat.com>
 <20190819111338.9366-1-krishna2@chelsio.com>
 <OFB7456B6B.E1C4D049-ON0025845B.00533DDF-0025845B.00776B49@notes.na.collabserv.com>
 <OF1D1F6B77.321AEAB1-ON0025845D.004B601C-0025845D.004B6025@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF1D1F6B77.321AEAB1-ON0025845D.004B601C-0025845D.004B6025@notes.na.collabserv.com>
User-Agent: Mutt/1.9.3 (20180206.02d571c2)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wednesday, August 08/21/19, 2019 at 19:13:18 +0530, Bernard Metzler wrote:
> -----"Doug Ledford" <dledford@redhat.com> wrote: -----
> 
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>, "Krishnamraju Eraparaju"
> ><krishna2@chelsio.com>
> >From: "Doug Ledford" <dledford@redhat.com>
> >Date: 08/20/2019 07:56PM
> >Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
> >nirranjan@chelsio.com
> >Subject: [EXTERNAL] Re: [PATCH for-rc] siw: fix for 'is_kva' flag
> >issue in siw_tx_hdt()
> >
> >On Mon, 2019-08-19 at 21:44 +0000, Bernard Metzler wrote:
> >> Hi Krishna,
> >> That is a good catch. I was not aware of the possibility of mixed
> >> PBL and kernel buffer addresses in one SQE.
> >> 
> >> A correct fix must also handle the un-mapping of any kmap()'d
> >> buffers. The current TX code expects all buffers be either kmap()'d
> >or
> >> all not kmap()'d. So the fix is a little more complex, if we must
> >> handle mixed SGL's during un-mapping. I think I can provide it by
> >> tomorrow. It's almost midnight ;)
> >
> >I'll wait for a proper fix.  Dropping this patch.  Thanks.
> >
> Thanks Doug!
> 
> I have a fix ready but still have to test it with iSER. 
> Unfortunately I have a hard time to test iSER with siw, since
> both iSCSI-TCP target and iSER want to bind to the same
> TCP port. While this may be considered a bug in that code,
> siw is the first RDMA provider to take notice (since using
> kernel sockets and not offloaded, hitting a TCP port
> already bound).
Not sure if this will become a serious problem when a iSCSI target
is configured to serve both iSCSI-TCP & iSER connections simultaniously.
Because, offloaded iSER CM handles all the TCP SYN packets that were
destined to iSCSI-TCP.
> 
> I sent the patch to Chelsio folks and hope for
> the best. They know the trick to make it working.
I have tested your patch, it's working fine.
> 
> Thanks
> Bernard.
> 
