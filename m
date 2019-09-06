Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 914D6ABAB8
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Sep 2019 16:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404639AbfIFOUw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 6 Sep 2019 10:20:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38374 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732020AbfIFOUw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 6 Sep 2019 10:20:52 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x86EFqiA131828
        for <linux-rdma@vger.kernel.org>; Fri, 6 Sep 2019 10:20:51 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.67])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uus2ng7s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 06 Sep 2019 10:20:51 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 6 Sep 2019 14:20:50 -0000
Received: from us1a3-smtp08.a3.dal06.isc4sb.com (10.146.103.57)
        by smtp.notes.na.collabserv.com (10.106.227.16) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 6 Sep 2019 14:20:44 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp08.a3.dal06.isc4sb.com
          with ESMTP id 2019090614204341-504063 ;
          Fri, 6 Sep 2019 14:20:43 +0000 
In-Reply-To: <bd025563-e1e0-4d87-2150-b4cb7fc5a816@amazon.com>
Subject: Re: Re: [PATCH] RDMA/siw: Fix page address mapping in TX path
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Gal Pressman" <galpress@amazon.com>
Cc:     <linux-rdma@vger.kernel.org>, <krishna2@chelsio.com>,
        <dledford@redhat.com>
Date:   Fri, 6 Sep 2019 14:20:44 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <bd025563-e1e0-4d87-2150-b4cb7fc5a816@amazon.com>,<20190906084544.26103-1-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-LLNOutbound: False
X-Disclaimed: 32259
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19090614-7279-0000-0000-0000007299F8
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000000
X-IBM-SpamModules-Versions: BY=3.00011726; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01257550; UDB=6.00664537; IPR=6.01039243;
 MB=3.00028505; MTD=3.00000008; XFM=3.00000015; UTC=2019-09-06 14:20:48
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-09-06 07:49:49 - 6.00010375
x-cbparentid: 19090614-7280-0000-0000-000000AABA03
Message-Id: <OF58606028.B27F2B6B-ON0025846D.004ECD6C-0025846D.004ECD79@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-06_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Gal Pressman" <galpress@amazon.com> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Gal Pressman" <galpress@amazon.com>
>Date: 09/06/2019 04:04PM
>Cc: <linux-rdma@vger.kernel.org>, <krishna2@chelsio.com>,
><dledford@redhat.com>
>Subject: [EXTERNAL] Re: [PATCH] RDMA/siw: Fix page address mapping in
>TX path
>
>On 06/09/2019 11:45, Bernard Metzler wrote:
>> Use the correct kmap()/kunmap() flow to determine page
>> address used for CRC computation. Using page_address()
>> is wrong, since page might be in highmem.
>> 
>> Reported-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
>> Fixes: b9be6f18cf9e rdma/siw: transmit path
>
>Hi Bernard,
>The format of the fixes line should be:
>Fixes: b9be6f18cf9e ("rdma/siw: transmit path")
>
>
I knew it!! Thanks Gal. I'll resend...

