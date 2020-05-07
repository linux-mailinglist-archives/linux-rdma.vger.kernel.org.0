Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737D81C878D
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2020 13:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbgEGLHH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 7 May 2020 07:07:07 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:14359 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgEGLHH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 7 May 2020 07:07:07 -0400
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 047B6rAQ028010;
        Thu, 7 May 2020 04:06:54 -0700
Date:   Thu, 7 May 2020 16:36:53 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     faisal.latif@intel.com, shiraz.saleem@intel.com,
        mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com
Subject: Re: Re: [RFC PATCH] RDMA/siw: Experimental e2e negotiation of GSO
 usage.
Message-ID: <20200507110651.GA19184@chelsio.com>
References: <20200428200043.GA930@chelsio.com>
 <20200415105135.GA8246@chelsio.com>
 <20200414144822.2365-1-bmt@zurich.ibm.com>
 <OFA289A103.141EDDE1-ON0025854B.003ED42A-0025854B.0041DBD8@notes.na.collabserv.com>
 <OF0315D264.505117BA-ON0025855F.0039BD43-0025855F.003E3C2B@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF0315D264.505117BA-ON0025855F.0039BD43-0025855F.003E3C2B@notes.na.collabserv.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Bernard,
Thanks for the review comments. Replied in line.

On Tuesday, May 05/05/20, 2020 at 11:19:46 +0000, Bernard Metzler wrote:
> 
> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----
> 
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
> >Date: 04/28/2020 10:01PM
> >Cc: faisal.latif@intel.com, shiraz.saleem@intel.com,
> >mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
> >jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
> >nirranjan@chelsio.com
> >Subject: [EXTERNAL] Re: [RFC PATCH] RDMA/siw: Experimental e2e
> >negotiation of GSO usage.
> >
> >On Wednesday, April 04/15/20, 2020 at 11:59:21 +0000, Bernard Metzler
> >wrote:
> >Hi Bernard,
> >
> >The attached patches enables the GSO negotiation code in SIW with
> >few modifications, and also allows hardware iwarp drivers to
> >advertise
> >their max length(in 16/32/64KB granularity) that they can accept.
> >The logic is almost similar to how TCP SYN MSS announcements works
> >while
> >3-way handshake.
> >
> >Please see if this approach works better for softiwarp <=> hardiwarp
> >case.
> >
> >Thanks,
> >Krishna. 
> >
> Hi Krishna,
> 
> Thanks for providing this. I have a few comments:
> 
> It would be good if we can look at patches inlined in the
> email body, as usual.
Sure, will do that henceforth.
> 
> Before further discussing a complex solution as suggested
> here, I would like to hear comments from other iWarp HW
> vendors on their capabilities regarding GSO frame acceptance
> and potential preferences. 
> 
> The extension proposed here goes beyond what I initially sent
> as a proposed patch. From an siw point of view, it is straight
> forward to select using GSO or not, depending on the iWarp peer
> ability to process large frames. What is proposed here is a
> end-to-end negotiation of the actual frame size.
> 
> A comment in the patch you sent suggests adding a module
> parameter. Module parameters are deprecated, and I removed any
> of those from siw when it went upstream. I don't think we can
> rely on that mechanism.
> 
> siw has a compile time parameter (yes, that was a module
> parameter) which can set the maximum tx frame size (in multiples
> of MTU size). Any static setup of siw <-> Chelsio could make
> use of that as a work around.
> 
> I wonder if it would be a better idea to look into an extension
> of the rdma netlink protocol, which would allow setting driver
> specific parameters per port, or even per QP.
> I assume there are more potential use cases for driver private
> extensions of the rdma netlink interface?

I think, the only problem with "configuring FPDU length via rdma
netlink" is the enduser might not feel comfortable in finding what adapter
is installed at the remote endpoint and what length it supports. Any
thoughts on simplify this?

Thanks,
Krishna.
> 
> Thanks a lot!
> Bernard.
> 
