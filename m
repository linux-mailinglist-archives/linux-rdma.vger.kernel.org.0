Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E36F1CDEFB
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 17:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgEKP3A convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 11 May 2020 11:29:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729463AbgEKP27 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 11:28:59 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04BFHPF5159955
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 11:28:58 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.73])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30wry0hbv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2020 11:28:58 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 11 May 2020 15:28:57 -0000
Received: from us1a3-smtp04.a3.dal06.isc4sb.com (10.106.154.237)
        by smtp.notes.na.collabserv.com (10.106.227.90) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 11 May 2020 15:28:48 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp04.a3.dal06.isc4sb.com
          with ESMTP id 2020051115284709-616738 ;
          Mon, 11 May 2020 15:28:47 +0000 
In-Reply-To: <20200507110651.GA19184@chelsio.com>
Subject: Re: Re: Re: [RFC PATCH] RDMA/siw: Experimental e2e negotiation of GSO usage.
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Krishnamraju Eraparaju" <krishna2@chelsio.com>
Cc:     faisal.latif@intel.com, shiraz.saleem@intel.com,
        mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com
Date:   Mon, 11 May 2020 15:28:47 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20200507110651.GA19184@chelsio.com>,<20200428200043.GA930@chelsio.com>
 <20200415105135.GA8246@chelsio.com>
 <20200414144822.2365-1-bmt@zurich.ibm.com>
 <OFA289A103.141EDDE1-ON0025854B.003ED42A-0025854B.0041DBD8@notes.na.collabserv.com>
 <OF0315D264.505117BA-ON0025855F.0039BD43-0025855F.003E3C2B@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-LLNOutbound: False
X-Disclaimed: 45663
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20051115-8877-0000-0000-0000037F8FD7
X-IBM-SpamModules-Scores: BY=0.126836; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.051793
X-IBM-SpamModules-Versions: BY=3.00013072; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000294; SDB=6.01375241; UDB=6.00735019; IPR=6.01157598;
 MB=3.00032117; MTD=3.00000008; XFM=3.00000015; UTC=2020-05-11 15:28:54
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-05-11 13:24:25 - 6.00011349
x-cbparentid: 20051115-8878-0000-0000-0000A1C59A8A
Message-Id: <OFF3B8551C.FB7A8965-ON00258565.0043E6E2-00258565.00550882@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-11_07:2020-05-11,2020-05-11 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>Date: 05/07/2020 01:07PM
>Cc: faisal.latif@intel.com, shiraz.saleem@intel.com,
>mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
>jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
>nirranjan@chelsio.com
>Subject: [EXTERNAL] Re: Re: [RFC PATCH] RDMA/siw: Experimental e2e
>negotiation of GSO usage.
>
>Hi Bernard,
>Thanks for the review comments. Replied in line.
>
>On Tuesday, May 05/05/20, 2020 at 11:19:46 +0000, Bernard Metzler
>wrote:
>> 
>> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----
>> 
>> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
>> >From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>> >Date: 04/28/2020 10:01PM
>> >Cc: faisal.latif@intel.com, shiraz.saleem@intel.com,
>> >mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
>> >jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
>> >nirranjan@chelsio.com
>> >Subject: [EXTERNAL] Re: [RFC PATCH] RDMA/siw: Experimental e2e
>> >negotiation of GSO usage.
>> >
>> >On Wednesday, April 04/15/20, 2020 at 11:59:21 +0000, Bernard
>Metzler
>> >wrote:
>> >Hi Bernard,
>> >
>> >The attached patches enables the GSO negotiation code in SIW with
>> >few modifications, and also allows hardware iwarp drivers to
>> >advertise
>> >their max length(in 16/32/64KB granularity) that they can accept.
>> >The logic is almost similar to how TCP SYN MSS announcements works
>> >while
>> >3-way handshake.
>> >
>> >Please see if this approach works better for softiwarp <=>
>hardiwarp
>> >case.
>> >
>> >Thanks,
>> >Krishna. 
>> >
>> Hi Krishna,
>> 
>> Thanks for providing this. I have a few comments:
>> 
>> It would be good if we can look at patches inlined in the
>> email body, as usual.
>Sure, will do that henceforth.
>> 
>> Before further discussing a complex solution as suggested
>> here, I would like to hear comments from other iWarp HW
>> vendors on their capabilities regarding GSO frame acceptance
>> and potential preferences. 
>> 
>> The extension proposed here goes beyond what I initially sent
>> as a proposed patch. From an siw point of view, it is straight
>> forward to select using GSO or not, depending on the iWarp peer
>> ability to process large frames. What is proposed here is a
>> end-to-end negotiation of the actual frame size.
>> 
>> A comment in the patch you sent suggests adding a module
>> parameter. Module parameters are deprecated, and I removed any
>> of those from siw when it went upstream. I don't think we can
>> rely on that mechanism.
>> 
>> siw has a compile time parameter (yes, that was a module
>> parameter) which can set the maximum tx frame size (in multiples
>> of MTU size). Any static setup of siw <-> Chelsio could make
>> use of that as a work around.
>> 
>> I wonder if it would be a better idea to look into an extension
>> of the rdma netlink protocol, which would allow setting driver
>> specific parameters per port, or even per QP.
>> I assume there are more potential use cases for driver private
>> extensions of the rdma netlink interface?
>
>I think, the only problem with "configuring FPDU length via rdma
>netlink" is the enduser might not feel comfortable in finding what
>adapter
>is installed at the remote endpoint and what length it supports. Any
>thoughts on simplify this?

Nope. This would be 'out of band' information.

So we seem to have 3 possible solutions to the problem:

(1) detect if the peer accepts FPDUs up to current GSO size,
this is what I initially proposed. (2) negotiate a max FPDU
size with the peer, this is what you are proposing, or (3)
explicitly set that max FPDU size per extended user interface.

My problem with (2) is the rather significant proprietary
extension of MPA, since spare bits code a max value negotiation.

I proposed (1) for its simplicity - just a single bit flag,
which de-/selects GSO size for FPDUs on TX. Since Chelsio
can handle _some_ larger (up to 16k, you said) sizes, (1)
might have to be extended to cap at hard coded max size.
Again, it would be good to know what other vendors limits
are.

Does 16k for siw  <-> Chelsio already yield a decent
performance win?

Thanks,
Bernard

