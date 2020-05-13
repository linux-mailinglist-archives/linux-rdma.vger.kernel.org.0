Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBB71D05A9
	for <lists+linux-rdma@lfdr.de>; Wed, 13 May 2020 05:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgEMDuR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 May 2020 23:50:17 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:64427 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727902AbgEMDuR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 May 2020 23:50:17 -0400
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 04D3nrrh019073;
        Tue, 12 May 2020 20:49:58 -0700
Date:   Wed, 13 May 2020 09:19:52 +0530
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     faisal.latif@intel.com, shiraz.saleem@intel.com,
        mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com
Subject: Re: Re: Re: [RFC PATCH] RDMA/siw: Experimental e2e negotiation of
 GSO usage.
Message-ID: <20200513034950.GA19121@chelsio.com>
References: <20200507110651.GA19184@chelsio.com>
 <20200428200043.GA930@chelsio.com>
 <20200415105135.GA8246@chelsio.com>
 <20200414144822.2365-1-bmt@zurich.ibm.com>
 <OFA289A103.141EDDE1-ON0025854B.003ED42A-0025854B.0041DBD8@notes.na.collabserv.com>
 <OF0315D264.505117BA-ON0025855F.0039BD43-0025855F.003E3C2B@notes.na.collabserv.com>
 <OFF3B8551C.FB7A8965-ON00258565.0043E6E2-00258565.00550882@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFF3B8551C.FB7A8965-ON00258565.0043E6E2-00258565.00550882@notes.na.collabserv.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Monday, May 05/11/20, 2020 at 15:28:47 +0000, Bernard Metzler wrote:
> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----
> 
> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
> >Date: 05/07/2020 01:07PM
> >Cc: faisal.latif@intel.com, shiraz.saleem@intel.com,
> >mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
> >jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
> >nirranjan@chelsio.com
> >Subject: [EXTERNAL] Re: Re: [RFC PATCH] RDMA/siw: Experimental e2e
> >negotiation of GSO usage.
> >
> >Hi Bernard,
> >Thanks for the review comments. Replied in line.
> >
> >On Tuesday, May 05/05/20, 2020 at 11:19:46 +0000, Bernard Metzler
> >wrote:
> >> 
> >> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----
> >> 
> >> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
> >> >From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
> >> >Date: 04/28/2020 10:01PM
> >> >Cc: faisal.latif@intel.com, shiraz.saleem@intel.com,
> >> >mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
> >> >jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
> >> >nirranjan@chelsio.com
> >> >Subject: [EXTERNAL] Re: [RFC PATCH] RDMA/siw: Experimental e2e
> >> >negotiation of GSO usage.
> >> >
> >> >On Wednesday, April 04/15/20, 2020 at 11:59:21 +0000, Bernard
> >Metzler
> >> >wrote:
> >> >Hi Bernard,
> >> >
> >> >The attached patches enables the GSO negotiation code in SIW with
> >> >few modifications, and also allows hardware iwarp drivers to
> >> >advertise
> >> >their max length(in 16/32/64KB granularity) that they can accept.
> >> >The logic is almost similar to how TCP SYN MSS announcements works
> >> >while
> >> >3-way handshake.
> >> >
> >> >Please see if this approach works better for softiwarp <=>
> >hardiwarp
> >> >case.
> >> >
> >> >Thanks,
> >> >Krishna. 
> >> >
> >> Hi Krishna,
> >> 
> >> Thanks for providing this. I have a few comments:
> >> 
> >> It would be good if we can look at patches inlined in the
> >> email body, as usual.
> >Sure, will do that henceforth.
> >> 
> >> Before further discussing a complex solution as suggested
> >> here, I would like to hear comments from other iWarp HW
> >> vendors on their capabilities regarding GSO frame acceptance
> >> and potential preferences. 
> >> 
> >> The extension proposed here goes beyond what I initially sent
> >> as a proposed patch. From an siw point of view, it is straight
> >> forward to select using GSO or not, depending on the iWarp peer
> >> ability to process large frames. What is proposed here is a
> >> end-to-end negotiation of the actual frame size.
> >> 
> >> A comment in the patch you sent suggests adding a module
> >> parameter. Module parameters are deprecated, and I removed any
> >> of those from siw when it went upstream. I don't think we can
> >> rely on that mechanism.
> >> 
> >> siw has a compile time parameter (yes, that was a module
> >> parameter) which can set the maximum tx frame size (in multiples
> >> of MTU size). Any static setup of siw <-> Chelsio could make
> >> use of that as a work around.
> >> 
> >> I wonder if it would be a better idea to look into an extension
> >> of the rdma netlink protocol, which would allow setting driver
> >> specific parameters per port, or even per QP.
> >> I assume there are more potential use cases for driver private
> >> extensions of the rdma netlink interface?
> >
> >I think, the only problem with "configuring FPDU length via rdma
> >netlink" is the enduser might not feel comfortable in finding what
> >adapter
> >is installed at the remote endpoint and what length it supports. Any
> >thoughts on simplify this?
> 
> Nope. This would be 'out of band' information.
> 
> So we seem to have 3 possible solutions to the problem:
> 
> (1) detect if the peer accepts FPDUs up to current GSO size,
> this is what I initially proposed. (2) negotiate a max FPDU
> size with the peer, this is what you are proposing, or (3)
> explicitly set that max FPDU size per extended user interface.
> 
> My problem with (2) is the rather significant proprietary
> extension of MPA, since spare bits code a max value negotiation.
> 
> I proposed (1) for its simplicity - just a single bit flag,
> which de-/selects GSO size for FPDUs on TX. Since Chelsio
> can handle _some_ larger (up to 16k, you said) sizes, (1)
> might have to be extended to cap at hard coded max size.
> Again, it would be good to know what other vendors limits
> are.
> 
> Does 16k for siw  <-> Chelsio already yield a decent
> performance win?
yes, 3x performance gain with just 16K GSO, compared to GSO diabled
case. where MTU size is 1500.

Regarding the rdma netlink approach that you are suggesting, should it
be similar like below(?):

rdma link set iwp3s0f4/1 max_fpdu_len 102.1.1.6:16384, 102.5.5.6:32768


rdma link show iwp3s0f4/1 max_fpdu_len
        102.1.1.6:16384
        102.5.5.6:32768

where "102.1.1.6" is the destination IP address(such that the same max
fpdu length is taken for all the connections to this address/adapter).
And "16384" is max fdpu length.

> 
> Thanks,
> Bernard
> 
