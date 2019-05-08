Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6D4317BBC
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 16:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfEHOlB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 8 May 2019 10:41:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52016 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727354AbfEHOlB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 May 2019 10:41:01 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x48EbcFG172036
        for <linux-rdma@vger.kernel.org>; Wed, 8 May 2019 10:40:59 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.109])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sbxx4ydnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 08 May 2019 10:40:59 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Wed, 8 May 2019 14:40:57 -0000
Received: from us1b3-smtp03.a3dr.sjc01.isc4sb.com (10.122.7.173)
        by smtp.notes.na.collabserv.com (10.122.47.48) with smtp.notes.na.collabserv.com ESMTP;
        Wed, 8 May 2019 14:40:52 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp03.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019050814405118-568302 ;
          Wed, 8 May 2019 14:40:51 +0000 
In-Reply-To: <20190508142229.GD6938@mtr-leonro.mtl.com>
Subject: Re: [PATCH v8 02/12] SIW main include file
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     "Jason Gunthorpe" <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Date:   Wed, 8 May 2019 14:40:51 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190508142229.GD6938@mtr-leonro.mtl.com>,<20190508130834.GA32282@ziepe.ca>
 <20190507170943.GI6201@ziepe.ca> <20190505170956.GH6938@mtr-leonro.mtl.com>
 <20190428110721.GI6705@mtr-leonro.mtl.com>
 <20190426131852.30142-1-bmt@zurich.ibm.com>
 <20190426131852.30142-3-bmt@zurich.ibm.com>
 <OF713CDB64.D1B09740-ON002583F1.0050F874-002583F1.005CE977@notes.na.collabserv.com>
 <OF11D27C39.8647DC53-ON002583F3.005609DE-002583F3.0057694C@notes.na.collabserv.com>
 <OFE6341395.7491F9CF-ON002583F4.002BAA7E-002583F4.002CAD7E@notes.na.collabserv.com>
 <OF21EE5DBF.E508AFF5-ON002583F4.004B49A6-002583F4.004D764A@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1048) | IBM Domino Build
 SCN1812108_20180501T0841_FP38 April 10, 2019 at 11:56
X-KeepSent: 1CA5BFE0:6D66DBE9-002583F4:004FF860;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 3907
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19050814-3721-0000-0000-000006766823
X-IBM-SpamModules-Scores: BY=0.02142; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.415104; ST=0; TS=0; UL=0; ISC=; MB=0.229341
X-IBM-SpamModules-Versions: BY=3.00011071; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01200387; UDB=6.00629834; IPR=6.00981273;
 BA=6.00006304; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00026792; XFM=3.00000015;
 UTC=2019-05-08 14:40:55
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-05-08 12:17:34 - 6.00009900
x-cbparentid: 19050814-3722-0000-0000-0000FDDA744F
Message-Id: <OF1CA5BFE0.6D66DBE9-ON002583F4.004FF860-002583F4.0050A50F@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-08_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 05/08/2019 04:22PM
>Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
>Subject: Re: [PATCH v8 02/12] SIW main include file
>
>On Wed, May 08, 2019 at 02:06:05PM +0000, Bernard Metzler wrote:
>> -----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----
>>
>> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
>> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
>> >Date: 05/08/2019 03:08PM
>> >Cc: "Leon Romanovsky" <leon@kernel.org>,
>linux-rdma@vger.kernel.org
>> >Subject: Re: [PATCH v8 02/12] SIW main include file
>> >
>> >On Wed, May 08, 2019 at 08:07:59AM +0000, Bernard Metzler wrote:
>> >> >> >> Memory access keys and QP IDs are generated as random
>> >> >> >> numbers, since both are exposed to the application.
>> >> >> >> Since XArray is not designed for sparsely distributed
>> >> >> >> id ranges, I am still in favor of IDR for these two
>> >> >> >> resources.
>> >> >
>> >> >IDR and xarray have identical underlying storage so this is
>> >nonsense
>> >> >
>> >> >No new idr's or radix tree users will be accepted into rdma....
>> >Use
>> >> >xarray
>> >> >
>> >> Sounds good to me! I just came across that introductory video
>from
>> >Matthew,
>> >> where he explicitly stated that xarray will be not very
>efficient
>> >if the
>> >> indices are not densely clustered. But maybe this is all far
>beyond
>> >the
>> >> 24bits of index space a memory key is in. So let me drop that
>IDR
>> >thing
>> >> completely, while handling randomized 24 bit memory keys.
>> >
>> >xarray/idr is a poor choice to store highly unclustered random
>data
>> >
>> >I'm not sure why this is a problem, shouldn't the driver be in
>> >control
>> >of mkey assignment? Just use xa_alloc_cyclic and it will be
>> >sufficiently clustered to be efficient.
>> >
>>
>> It is a recommendation to choose a hard to predict memory
>> key (to make it hard for an attacker to guess it). From
>> RFC 5040, sec 8.1.1:
>>
>>   An RNIC MUST choose the value of STags in a way difficult to
>>   predict.  It is RECOMMENDED to sparsely populate them over the
>>   full available range.
>
>Nice, security by obscurity, this recommendation is nonsense in real
>life,
>protection should be done by separating PDs and not by hiding stags.
>
Not sure about that one. Randomizing peer visible references of local
protocol state isn't something invented just here. Think of TCP's ISN
randomization etc.

Maybe best, in the near future, I'll do some RB tree thing for more
efficiency. 

>>
>> Since I did not want to roll my own bug-prone key based lookup,
>> I chose idr. If you tell me xarray is just as inefficient as
>> idr for sparse index distributions, I'll take xarray.
>>
>> Thanks,
>> Bernard.
>>
>
>

