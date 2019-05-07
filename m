Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF4251673C
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 17:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfEGP4L convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 7 May 2019 11:56:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726438AbfEGP4L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 11:56:11 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x47FnnoY115895
        for <linux-rdma@vger.kernel.org>; Tue, 7 May 2019 11:56:10 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.112])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sbbw6ku1j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 07 May 2019 11:56:10 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 7 May 2019 15:56:09 -0000
Received: from us1b3-smtp02.a3dr.sjc01.isc4sb.com (10.122.7.175)
        by smtp.notes.na.collabserv.com (10.122.47.54) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 7 May 2019 15:56:06 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp02.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019050715560540-721950 ;
          Tue, 7 May 2019 15:56:05 +0000 
In-Reply-To: <20190507154401.GG6201@ziepe.ca>
Subject: Re: [PATCH v8 04/12] SIW connection management
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     "Leon Romanovsky" <leon@kernel.org>, linux-rdma@vger.kernel.org
Date:   Tue, 7 May 2019 15:56:06 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190507154401.GG6201@ziepe.ca>,<20190428164954.GP6705@mtr-leonro.mtl.com>
 <20190426131852.30142-1-bmt@zurich.ibm.com>
 <20190426131852.30142-5-bmt@zurich.ibm.com>
 <OF63ED2654.B14EF197-ON002583F3.00529A34-002583F3.00545CFD@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1048) | IBM Domino Build
 SCN1812108_20180501T0841_FP38 April 10, 2019 at 11:56
X-KeepSent: EC75C556:23D7641D-002583F3:0057889C;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 58003
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19050715-0163-0000-0000-0000062E74B5
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.003726
X-IBM-SpamModules-Versions: BY=3.00011066; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01199936; UDB=6.00629561; IPR=6.00980818;
 BA=6.00006300; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00026771; XFM=3.00000015;
 UTC=2019-05-07 15:56:08
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-05-07 15:19:53 - 6.00009896
x-cbparentid: 19050715-0164-0000-0000-00000F468DCD
Message-Id: <OFEC75C556.23D7641D-ON002583F3.0057889C-002583F3.0057889F@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-07_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 05/07/2019 05:44PM
>Cc: "Leon Romanovsky" <leon@kernel.org>, linux-rdma@vger.kernel.org
>Subject: Re: [PATCH v8 04/12] SIW connection management
>
>On Tue, May 07, 2019 at 03:21:28PM +0000, Bernard Metzler wrote:
>
>> >> +void siw_cep_put(struct siw_cep *cep)
>> >> +{
>> >> +	siw_dbg_cep(cep, "new refcount: %d\n", kref_read(&cep->ref) -
>1);
>> >> +
>> >> +	WARN_ON(kref_read(&cep->ref) < 1);
>> >> +	kref_put(&cep->ref, __siw_cep_dealloc);
>> >> +}
>> >> +
>> >> +void siw_cep_get(struct siw_cep *cep)
>> >> +{
>> >> +	kref_get(&cep->ref);
>> >> +	siw_dbg_cep(cep, "new refcount: %d\n", kref_read(&cep->ref));
>> >> +}
>> >
>> >Another kref_get/put wrappers, unlikely needed.
>> >
>> It just avoids writing down the free routine in each
>> put call, and I used it to add some debug info for
>> tracking status. So I would remove it if it you tell me it's
>> bad style...
>
>It is common to have a put wrapper and thus usually a symetrically
>named get wrapepr - this is so the free function is done consistently
>
>The debugging might be over doing it
>

Yes, agreed, I am going to drop that debugging stuff.

