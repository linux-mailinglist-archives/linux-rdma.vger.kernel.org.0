Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22B849FE93
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 11:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfH1Jf5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 28 Aug 2019 05:35:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49030 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726326AbfH1Jf4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Aug 2019 05:35:56 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7S9Z1F0016646
        for <linux-rdma@vger.kernel.org>; Wed, 28 Aug 2019 05:35:56 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2unn0fvsq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 28 Aug 2019 05:35:56 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Wed, 28 Aug 2019 09:35:55 -0000
Received: from us1b3-smtp04.a3dr.sjc01.isc4sb.com (10.122.203.161)
        by smtp.notes.na.collabserv.com (10.122.47.46) with smtp.notes.na.collabserv.com ESMTP;
        Wed, 28 Aug 2019 09:35:50 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp04.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019082809354932-237045 ;
          Wed, 28 Aug 2019 09:35:49 +0000 
In-Reply-To: <20190828050248.GC4725@mtr-leonro.mtl.com>
Subject: Re: Re: [PATCH v3] RDMA/siw: Fix IPv6 addr_list locking
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, bvanassche@acm.org, jgg@ziepe.ca,
        dledford@redhat.com
Date:   Wed, 28 Aug 2019 09:35:49 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190828050248.GC4725@mtr-leonro.mtl.com>,<20190827220720.19581-1-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-KeepSent: 53DD86EF:89F32DAB-00258464:0034B7C6;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 55155
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19082809-3017-0000-0000-000000B06F80
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.000261
X-IBM-SpamModules-Versions: BY=3.00011671; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01253233; UDB=6.00661891; IPR=6.01034838;
 MB=3.00028369; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-28 09:35:53
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-28 05:21:22 - 6.00010339
x-cbparentid: 19082809-3018-0000-0000-000001199597
Message-Id: <OF53DD86EF.89F32DAB-ON00258464.0034B7C6-00258464.0034B7D3@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 08/28/2019 07:03AM
>Cc: linux-rdma@vger.kernel.org, bvanassche@acm.org, jgg@ziepe.ca,
>dledford@redhat.com
>Subject: [EXTERNAL] Re: [PATCH v3] RDMA/siw: Fix IPv6 addr_list
>locking
>
>On Wed, Aug 28, 2019 at 12:07:20AM +0200, Bernard Metzler wrote:
>> Walking the address list of an inet6_dev requires
>> appropriate locking. Since the called function
>> siw_listen_address() may sleep, we have to use
>> rtnl_lock() instead of read_lock_bh().
>>
>> Also introduces:
>> - sanity checks if we got a device from
>>   in_dev_get() or in6_dev_get().
>> - skipping IPv6 addresses flagged IFA_F_TENTATIVE
>>   or IFA_F_DEPRECATED
>>
>> Reported-by: Bart Van Assche <bvanassche@acm.org>
>> Fixes: 6c52fdc244b5 ("rdma/siw: connection management")
>> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> ---
>
>Bernand,
>
>Can you please post changelog along your patches?
>
Hi Leon,

Thanks, yes. Let me further try getting it alright ;)
I'll re-post v3.

Sorry!

Bernard.

