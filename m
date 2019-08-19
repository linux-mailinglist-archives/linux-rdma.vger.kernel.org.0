Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF3CD9264B
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 16:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbfHSOPs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 19 Aug 2019 10:15:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726751AbfHSOPr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 10:15:47 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JEEGCZ084481
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 10:15:46 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.74])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ufwbm84aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 10:15:45 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 19 Aug 2019 14:15:44 -0000
Received: from us1a3-smtp08.a3.dal06.isc4sb.com (10.146.103.57)
        by smtp.notes.na.collabserv.com (10.106.227.92) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 19 Aug 2019 14:15:37 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp08.a3.dal06.isc4sb.com
          with ESMTP id 2019081914153630-526618 ;
          Mon, 19 Aug 2019 14:15:36 +0000 
In-Reply-To: <20190819135213.GF5058@ziepe.ca>
Subject: Re: Re: Re: [PATCH] RDMA/siw: Fix compiler warnings on 32-bit due to
 u64/pointer abuse
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Doug Ledford" <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 19 Aug 2019 14:15:36 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190819135213.GF5058@ziepe.ca>,<20190819122456.GB5058@ziepe.ca>
 <20190819100526.13788-1-geert@linux-m68k.org>
 <OF7DB4AD51.C58B8A8B-ON0025845B.004A0CF6-0025845B.004AB95C@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 45899
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19081914-3165-0000-0000-000000B78A98
X-IBM-SpamModules-Scores: BY=0.002883; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000027
X-IBM-SpamModules-Versions: BY=3.00011618; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01249093; UDB=6.00659363; IPR=6.01030620;
 MB=3.00028233; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-19 14:15:42
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-19 08:30:55 - 6.00010303
x-cbparentid: 19081914-3166-0000-0000-00001BBF9869
Message-Id: <OFD7D2994B.750F3146-ON0025845B.004D965D-0025845B.004E5577@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 08/19/2019 03:52PM
>Cc: "Geert Uytterhoeven" <geert@linux-m68k.org>, "Doug Ledford"
><dledford@redhat.com>, linux-rdma@vger.kernel.org,
>linux-kernel@vger.kernel.org
>Subject: [EXTERNAL] Re: Re: [PATCH] RDMA/siw: Fix compiler warnings
>on 32-bit due to u64/pointer abuse
>
>On Mon, Aug 19, 2019 at 01:36:11PM +0000, Bernard Metzler wrote:
>> >If the value is really a kernel pointer, then it ought to be
>printed
>> >with %p. We have been getting demanding on this point lately in
>RDMA
>> >to enforce the ability to keep kernel pointers secret.
>> >
>> >> -			wqe->sqe.sge[0].laddr = (u64)&wqe->sqe.sge[1];
>> >> +			wqe->sqe.sge[0].laddr = (uintptr_t)&wqe->sqe.sge[1];
>> >
>> >[..]
>> >
>> >>  			rv = siw_rx_kva(srx,
>> >> -					(void *)(sge->laddr + frx->sge_off),
>> >> +					(void *)(uintptr_t)(sge->laddr + frx->sge_off),
>> >>  					sge_bytes);
>> >
>> >Bernard, this is nonsense, what is going on here with sge->laddr
>that
>> >it can't be a void *?
>> >
>> siw_sge is defined in siw-abi.h. We make the address u64 to keep
>the ABI
>> arch independent.
>
>Eh? How does the siw-abi.h store a kernel pointer? Sounds like kernel
>and user types are being mixed.
>

siw-abi.h defines the work queue elements of a siw send queue.
For user land, the send queue is mmapped. Kernel or user land
clients write to its send queue when posting work
(SGE: buffer address, length, local key). 

Thanks,
Bernard.

