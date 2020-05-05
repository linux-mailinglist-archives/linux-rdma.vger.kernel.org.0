Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062941C5445
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2020 13:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgEELTz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 5 May 2020 07:19:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725766AbgEELTz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 5 May 2020 07:19:55 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 045B21iO113240
        for <linux-rdma@vger.kernel.org>; Tue, 5 May 2020 07:19:54 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.82])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30s4v7wx3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 05 May 2020 07:19:54 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 5 May 2020 11:19:53 -0000
Received: from us1a3-smtp06.a3.dal06.isc4sb.com (10.146.103.243)
        by smtp.notes.na.collabserv.com (10.106.227.105) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 5 May 2020 11:19:46 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp06.a3.dal06.isc4sb.com
          with ESMTP id 2020050511194631-333310 ;
          Tue, 5 May 2020 11:19:46 +0000 
In-Reply-To: <20200428200043.GA930@chelsio.com>
Subject: Re: Re: [RFC PATCH] RDMA/siw: Experimental e2e negotiation of GSO usage.
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Krishnamraju Eraparaju" <krishna2@chelsio.com>
Cc:     faisal.latif@intel.com, shiraz.saleem@intel.com,
        mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
        jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com
Date:   Tue, 5 May 2020 11:19:46 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20200428200043.GA930@chelsio.com>,<20200415105135.GA8246@chelsio.com>
 <20200414144822.2365-1-bmt@zurich.ibm.com>
 <OFA289A103.141EDDE1-ON0025854B.003ED42A-0025854B.0041DBD8@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-LLNOutbound: False
X-Disclaimed: 59427
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20050511-9463-0000-0000-000003281068
X-IBM-SpamModules-Scores: BY=0.129154; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.042408
X-IBM-SpamModules-Versions: BY=3.00013032; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000294; SDB=6.01372279; UDB=6.00733266; IPR=6.01154647;
 MB=3.00032012; MTD=3.00000008; XFM=3.00000015; UTC=2020-05-05 11:19:52
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-05-05 00:19:28 - 6.00011323
x-cbparentid: 20050511-9464-0000-0000-0000194C10C4
Message-Id: <OF0315D264.505117BA-ON0025855F.0039BD43-0025855F.003E3C2B@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-05_06:2020-05-04,2020-05-05 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


-----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>Date: 04/28/2020 10:01PM
>Cc: faisal.latif@intel.com, shiraz.saleem@intel.com,
>mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
>jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
>nirranjan@chelsio.com
>Subject: [EXTERNAL] Re: [RFC PATCH] RDMA/siw: Experimental e2e
>negotiation of GSO usage.
>
>On Wednesday, April 04/15/20, 2020 at 11:59:21 +0000, Bernard Metzler
>wrote:
>Hi Bernard,
>
>The attached patches enables the GSO negotiation code in SIW with
>few modifications, and also allows hardware iwarp drivers to
>advertise
>their max length(in 16/32/64KB granularity) that they can accept.
>The logic is almost similar to how TCP SYN MSS announcements works
>while
>3-way handshake.
>
>Please see if this approach works better for softiwarp <=> hardiwarp
>case.
>
>Thanks,
>Krishna. 
>
Hi Krishna,

Thanks for providing this. I have a few comments:

It would be good if we can look at patches inlined in the
email body, as usual.

Before further discussing a complex solution as suggested
here, I would like to hear comments from other iWarp HW
vendors on their capabilities regarding GSO frame acceptance
and potential preferences. 

The extension proposed here goes beyond what I initially sent
as a proposed patch. From an siw point of view, it is straight
forward to select using GSO or not, depending on the iWarp peer
ability to process large frames. What is proposed here is a
end-to-end negotiation of the actual frame size.

A comment in the patch you sent suggests adding a module
parameter. Module parameters are deprecated, and I removed any
of those from siw when it went upstream. I don't think we can
rely on that mechanism.

siw has a compile time parameter (yes, that was a module
parameter) which can set the maximum tx frame size (in multiples
of MTU size). Any static setup of siw <-> Chelsio could make
use of that as a work around.

I wonder if it would be a better idea to look into an extension
of the rdma netlink protocol, which would allow setting driver
specific parameters per port, or even per QP.
I assume there are more potential use cases for driver private
extensions of the rdma netlink interface?

Thanks a lot!
Bernard.

