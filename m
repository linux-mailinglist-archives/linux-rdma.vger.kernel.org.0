Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEFF1D30A5
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2020 15:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgENNHo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 14 May 2020 09:07:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11360 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbgENNHn (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 14 May 2020 09:07:43 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04ED2BEb151209
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2020 09:07:43 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3111wgsjbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 14 May 2020 09:07:43 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Thu, 14 May 2020 13:07:42 -0000
Received: from us1b3-smtp07.a3dr.sjc01.isc4sb.com (10.122.203.198)
        by smtp.notes.na.collabserv.com (10.122.47.48) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 14 May 2020 13:07:35 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp07.a3dr.sjc01.isc4sb.com
          with ESMTP id 2020051413073372-424755 ;
          Thu, 14 May 2020 13:07:33 +0000 
In-Reply-To: <20200514111700.GA26990@chelsio.com>
Subject: Re: Re: Re: Re: [RFC PATCH] RDMA/siw: Experimental e2e negotiation of GSO
 usage.
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Krishnamraju Eraparaju" <krishna2@chelsio.com>
Cc:     faisal.latif@intel.com, shiraz.saleem@intel.com,
        mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com
Date:   Thu, 14 May 2020 13:07:33 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20200514111700.GA26990@chelsio.com>,<20200513034950.GA19121@chelsio.com>
 <20200507110651.GA19184@chelsio.com> <20200428200043.GA930@chelsio.com>
 <20200415105135.GA8246@chelsio.com>
 <20200414144822.2365-1-bmt@zurich.ibm.com>
 <OFA289A103.141EDDE1-ON0025854B.003ED42A-0025854B.0041DBD8@notes.na.collabserv.com>
 <OF0315D264.505117BA-ON0025855F.0039BD43-0025855F.003E3C2B@notes.na.collabserv.com>
 <OFF3B8551C.FB7A8965-ON00258565.0043E6E2-00258565.00550882@notes.na.collabserv.com>
 <OF8C4B32A9.212C6DC0-ON00258567.0031506F-00258567.003EBFFB@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-KeepSent: 5AE22DD2:A8A5C20E-00258568:004804AF;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 6607
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20051413-1429-0000-0000-000001FB23D9
X-IBM-SpamModules-Scores: BY=0.1247; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.198077
X-IBM-SpamModules-Versions: BY=3.00013091; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000294; SDB=6.01376625; UDB=6.00735844; IPR=6.01158976;
 MB=3.00032162; MTD=3.00000008; XFM=3.00000015; UTC=2020-05-14 13:07:41
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-05-14 11:14:12 - 6.00011362
x-cbparentid: 20051413-1430-0000-0000-0000A4412861
Message-Id: <OF5AE22DD2.A8A5C20E-ON00258568.004804AF-00258568.00481A8E@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_03:2020-05-14,2020-05-14 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>Date: 05/14/2020 01:17PM
>Cc: faisal.latif@intel.com, shiraz.saleem@intel.com,
>mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
>jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
>nirranjan@chelsio.com
>Subject: [EXTERNAL] Re: Re: Re: [RFC PATCH] RDMA/siw: Experimental
>e2e negotiation of GSO usage.
>
>On Wednesday, May 05/13/20, 2020 at 11:25:23 +0000, Bernard Metzler
>wrote:
>> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----
>> 
>> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
>> >From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>> >Date: 05/13/2020 05:50AM
>> >Cc: faisal.latif@intel.com, shiraz.saleem@intel.com,
>> >mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
>> >jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
>> >nirranjan@chelsio.com
>> >Subject: [EXTERNAL] Re: Re: Re: [RFC PATCH] RDMA/siw: Experimental
>> >e2e negotiation of GSO usage.
>> >
>> >On Monday, May 05/11/20, 2020 at 15:28:47 +0000, Bernard Metzler
>> >wrote:
>> >> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote:
>-----
>> >> 
>> >> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
>> >> >From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>> >> >Date: 05/07/2020 01:07PM
>> >> >Cc: faisal.latif@intel.com, shiraz.saleem@intel.com,
>> >> >mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
>> >> >jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
>> >> >nirranjan@chelsio.com
>> >> >Subject: [EXTERNAL] Re: Re: [RFC PATCH] RDMA/siw: Experimental
>e2e
>> >> >negotiation of GSO usage.
>> >> >
>> >> >Hi Bernard,
>> >> >Thanks for the review comments. Replied in line.
>> >> >
>> >> >On Tuesday, May 05/05/20, 2020 at 11:19:46 +0000, Bernard
>Metzler
>> >> >wrote:
>> >> >> 
>> >> >> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote:
>> >-----
>> >> >> 
>> >> >> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
>> >> >> >From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>> >> >> >Date: 04/28/2020 10:01PM
>> >> >> >Cc: faisal.latif@intel.com, shiraz.saleem@intel.com,
>> >> >> >mkalderon@marvell.com, aelior@marvell.com,
>dledford@redhat.com,
>> >> >> >jgg@ziepe.ca, linux-rdma@vger.kernel.org,
>bharat@chelsio.com,
>> >> >> >nirranjan@chelsio.com
>> >> >> >Subject: [EXTERNAL] Re: [RFC PATCH] RDMA/siw: Experimental
>e2e
>> >> >> >negotiation of GSO usage.
>> >> >> >
>> >> >> >On Wednesday, April 04/15/20, 2020 at 11:59:21 +0000,
>Bernard
>> >> >Metzler
>> >> >> >wrote:
>> >> >> >Hi Bernard,
>> >> >> >
>> >> >> >The attached patches enables the GSO negotiation code in SIW
>> >with
>> >> >> >few modifications, and also allows hardware iwarp drivers to
>> >> >> >advertise
>> >> >> >their max length(in 16/32/64KB granularity) that they can
>> >accept.
>> >> >> >The logic is almost similar to how TCP SYN MSS announcements
>> >works
>> >> >> >while
>> >> >> >3-way handshake.
>> >> >> >
>> >> >> >Please see if this approach works better for softiwarp <=>
>> >> >hardiwarp
>> >> >> >case.
>> >> >> >
>> >> >> >Thanks,
>> >> >> >Krishna. 
>> >> >> >
>> >> >> Hi Krishna,
>> >> >> 
>> >> >> Thanks for providing this. I have a few comments:
>> >> >> 
>> >> >> It would be good if we can look at patches inlined in the
>> >> >> email body, as usual.
>> >> >Sure, will do that henceforth.
>> >> >> 
>> >> >> Before further discussing a complex solution as suggested
>> >> >> here, I would like to hear comments from other iWarp HW
>> >> >> vendors on their capabilities regarding GSO frame acceptance
>> >> >> and potential preferences. 
>> >> >> 
>> >> >> The extension proposed here goes beyond what I initially sent
>> >> >> as a proposed patch. From an siw point of view, it is
>straight
>> >> >> forward to select using GSO or not, depending on the iWarp
>peer
>> >> >> ability to process large frames. What is proposed here is a
>> >> >> end-to-end negotiation of the actual frame size.
>> >> >> 
>> >> >> A comment in the patch you sent suggests adding a module
>> >> >> parameter. Module parameters are deprecated, and I removed
>any
>> >> >> of those from siw when it went upstream. I don't think we can
>> >> >> rely on that mechanism.
>> >> >> 
>> >> >> siw has a compile time parameter (yes, that was a module
>> >> >> parameter) which can set the maximum tx frame size (in
>multiples
>> >> >> of MTU size). Any static setup of siw <-> Chelsio could make
>> >> >> use of that as a work around.
>> >> >> 
>> >> >> I wonder if it would be a better idea to look into an
>extension
>> >> >> of the rdma netlink protocol, which would allow setting
>driver
>> >> >> specific parameters per port, or even per QP.
>> >> >> I assume there are more potential use cases for driver
>private
>> >> >> extensions of the rdma netlink interface?
>> >> >
>> >> >I think, the only problem with "configuring FPDU length via
>rdma
>> >> >netlink" is the enduser might not feel comfortable in finding
>what
>> >> >adapter
>> >> >is installed at the remote endpoint and what length it
>supports.
>> >Any
>> >> >thoughts on simplify this?
>> >> 
>> >> Nope. This would be 'out of band' information.
>> >> 
>> >> So we seem to have 3 possible solutions to the problem:
>> >> 
>> >> (1) detect if the peer accepts FPDUs up to current GSO size,
>> >> this is what I initially proposed. (2) negotiate a max FPDU
>> >> size with the peer, this is what you are proposing, or (3)
>> >> explicitly set that max FPDU size per extended user interface.
>> >> 
>> >> My problem with (2) is the rather significant proprietary
>> >> extension of MPA, since spare bits code a max value negotiation.
>> >> 
>> >> I proposed (1) for its simplicity - just a single bit flag,
>> >> which de-/selects GSO size for FPDUs on TX. Since Chelsio
>> >> can handle _some_ larger (up to 16k, you said) sizes, (1)
>> >> might have to be extended to cap at hard coded max size.
>> >> Again, it would be good to know what other vendors limits
>> >> are.
>> >> 
>> >> Does 16k for siw  <-> Chelsio already yield a decent
>> >> performance win?
>> >yes, 3x performance gain with just 16K GSO, compared to GSO
>diabled
>> >case. where MTU size is 1500.
>> >
>> 
>> That is a lot. At the other hand, I would suggest to always
>> increase MTU size to max (9k) for adapters siw attaches to.
>> With a page size of 4k, anything below 4k MTU size hurts,
>> while 9k already packs two consecutive pages into one frame,
>> if aligned.
>> 
>> Would 16k still gain a significant performance win if we have
>> set max MTU size for the interface?
>> 
>> >Regarding the rdma netlink approach that you are suggesting,
>should
>> >it
>> >be similar like below(?):
>> >
>> >rdma link set iwp3s0f4/1 max_fpdu_len 102.1.1.6:16384,
>> >102.5.5.6:32768
>> >
>> >
>> >rdma link show iwp3s0f4/1 max_fpdu_len
>> >        102.1.1.6:16384
>> >        102.5.5.6:32768
>> >
>> >where "102.1.1.6" is the destination IP address(such that the same
>> >max
>> >fpdu length is taken for all the connections to this
>> >address/adapter).
>> >And "16384" is max fdpu length.
>> >
>> Yes, that would be one way of doing it. Unfortunately we
>> would end up with maintaining additional permanent in kernel
>> state per peer we ever configured.
>> 
>> So, would it make sense to combine it with the iwpmd,
>> which then may cache peers, while setting max_fpdu per
>> new connection? This would probably include extending the
>> proprietary port mapper protocol, to exchange local
>> preferences with the peer. Local capabilities might
>> be queried from the device (extending enum ib_mtu to
>> more than 4k, and using ibv_query_port()). And the
>> iw_cm_id to be extended to carry that extra parameter
>> down to the driver... Sounds complicated.
>If I understand you right, client/server advertises their Max FPDU
>len
>in Res field of PMReq/PMAccept frames.
>typedef struct iwpm_wire_msg {
>        __u8    magic;
>        __u8    pmtime;
>        __be16  reserved;
>Then after Portmapper negotiation, the fpdu len is propagated to SIW
>qp
>strucutre from userspace iwpmd.
>		
>If we weigh up the pros and cons of using PortMapper Res field vs MPA
>Res feild, then looks like using MPA is less complicated, considering
>the lines of changes and modules invovled in changes. Not sure my
>analysis is right here?
>
One important difference IMHO is that one approach would touch an
established IETF communication protocol (MPA), the other a
proprietary application (iwpmd).


>Between, looks like the existing SIW GSO code needs a logic to limit
>"c_tx->tcp_seglen" to 64K-1, as MPA len is only 16bit. Say, in future
>to
>best utilize 400G Ethernet, if Linux TCP stack has increased
>GSO_MAX_SIZE to 128K, then SIW will cast 18bit value to 16bit MPA
>len.
>
Isn't GSO bound to IP fragmentation?

Thanks,
Bernard

