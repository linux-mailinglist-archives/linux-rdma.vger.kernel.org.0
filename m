Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5761E8272
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2020 17:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgE2Ps5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 29 May 2020 11:48:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726838AbgE2Ps4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 29 May 2020 11:48:56 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04TFWTj7185332
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 11:48:55 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.75])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31b4chhygu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 29 May 2020 11:48:55 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 29 May 2020 15:48:54 -0000
Received: from us1a3-smtp01.a3.dal06.isc4sb.com (10.106.154.95)
        by smtp.notes.na.collabserv.com (10.106.227.123) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 29 May 2020 15:48:47 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp01.a3.dal06.isc4sb.com
          with ESMTP id 2020052915484591-600318 ;
          Fri, 29 May 2020 15:48:45 +0000 
In-Reply-To: <9DD61F30A802C4429A01CA4200E302A7EE045C10@fmsmsx124.amr.corp.intel.com>
Subject: Re: RE: Re: Re: Re: [RFC PATCH] RDMA/siw: Experimental e2e negotiation of
 GSO usage.
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Saleem, Shiraz" <shiraz.saleem@intel.com>
Cc:     "Krishnamraju Eraparaju" <krishna2@chelsio.com>,
        "Latif, Faisal" <faisal.latif@intel.com>,
        "mkalderon@marvell.com" <mkalderon@marvell.com>,
        "aelior@marvell.com" <aelior@marvell.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "bharat@chelsio.com" <bharat@chelsio.com>,
        "nirranjan@chelsio.com" <nirranjan@chelsio.com>
Date:   Fri, 29 May 2020 15:48:45 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <9DD61F30A802C4429A01CA4200E302A7EE045C10@fmsmsx124.amr.corp.intel.com>,<20200515135802.GB15967@chelsio.com>,<20200507110651.GA19184@chelsio.com>
 <20200428200043.GA930@chelsio.com> <20200415105135.GA8246@chelsio.com>
 <20200414144822.2365-1-bmt@zurich.ibm.com>
 <OFA289A103.141EDDE1-ON0025854B.003ED42A-0025854B.0041DBD8@notes.na.collabserv.com>
 <OF0315D264.505117BA-ON0025855F.0039BD43-0025855F.003E3C2B@notes.na.collabserv.com>
 <OFF3B8551C.FB7A8965-ON00258565.0043E6E2-00258565.00550882@notes.na.collabserv.com>
 <OF8C4B32A9.212C6DC0-ON00258567.0031506F-00258567.003EBFFB@notes.na.collabserv.com>
 <OF5AE22DD2.A8A5C20E-ON00258568.004804AF-00258568.00481A8E@notes.na.collabserv.com>
 <20200515135038.GA15967@chelsio.com>
 <OFD36340BE.9065DAAE-ON00258574.0049B60E-00258574.004CA5BC@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-LLNOutbound: False
X-Disclaimed: 59255
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20052915-6875-0000-0000-000002AD7A2E
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000034
X-IBM-SpamModules-Versions: BY=3.00013188; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01383843; UDB=6.00740089; IPR=6.01166116;
 MB=3.00032375; MTD=3.00000008; XFM=3.00000015; UTC=2020-05-29 15:48:52
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-05-29 15:15:59 - 6.00011420
x-cbparentid: 20052915-6876-0000-0000-0000235891E3
Message-Id: <OF35E966AB.34915ADD-ON00258577.0056DC76-00258577.0056DC82@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-29_07:2020-05-28,2020-05-29 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Saleem, Shiraz" <shiraz.saleem@intel.com> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>, "Krishnamraju Eraparaju"
><krishna2@chelsio.com>
>From: "Saleem, Shiraz" <shiraz.saleem@intel.com>
>Date: 05/29/2020 05:21PM
>Cc: "Latif, Faisal" <faisal.latif@intel.com>, "mkalderon@marvell.com"
><mkalderon@marvell.com>, "aelior@marvell.com" <aelior@marvell.com>,
>"dledford@redhat.com" <dledford@redhat.com>, "jgg@ziepe.ca"
><jgg@ziepe.ca>, "linux-rdma@vger.kernel.org"
><linux-rdma@vger.kernel.org>, "bharat@chelsio.com"
><bharat@chelsio.com>, "nirranjan@chelsio.com" <nirranjan@chelsio.com>
>Subject: [EXTERNAL] RE: Re: Re: Re: [RFC PATCH] RDMA/siw:
>Experimental e2e negotiation of GSO usage.
>
>> Subject: RE: Re: Re: Re: [RFC PATCH] RDMA/siw: Experimental e2e
>negotiation
>> of GSO usage.
>> 
>> 
>> -----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----
>> 
>> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
>> >From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>> >Date: 05/15/2020 03:58PM
>> >Cc: faisal.latif@intel.com, shiraz.saleem@intel.com,
>> >mkalderon@marvell.com, aelior@marvell.com, dledford@redhat.com,
>> >jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
>> >nirranjan@chelsio.com
>> >Subject: [EXTERNAL] Re: Re: Re: Re: [RFC PATCH] RDMA/siw:
>> >Experimental e2e negotiation of GSO usage.
>> >
>> >Here is the rough prototype of iwpmd approach(only kernel part).
>> >Please take a look.
>> 
>> 
>> This indeed looks like a possible solution, which would not affect
>the wire
>> protocol.
>> 
>> Before we move ahead with that story in any direction, I would
>really really
>> appreciate to hear what other iWarp vendors have to say.
>> 
>> 0) would other vendors care about better performance
>>    in a mixed hardware/software iwarp setting?
>> 
>> 1) what are the capabilities of other adapters in that
>>    respect, e.g. what is the maximum FPDU length it
>>    can process?
>> 
>> 2) would other adapters be able to send larger FPDUs
>>    than MTU size?
>> 
>> 3) what would be the preferred solution - using spare
>>    MPA protocol bits to signal capabilities or
>>    extending the proprietary iwarp port mapper with that
>>    functionality?
>> 
>> Thanks very much!
>> Bernard.
>> 
>
>Hi Bernard -  If we receive larger FPDU than MTU its handled in
>software
>and therefore is a hit on perf. We do support jumbo packets but we do
>not
>transmit FPDUs greater than MTU size. I recommend we do not add
>unspec'd bits into the MPA protocol for gso negotiation. netlink
>based
>approach or iwpmd sounds more reasonable.
>
>Hope this helps.
>
It does!

Many thanks,
Bernard.
>Shiraz
>
>

