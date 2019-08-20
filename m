Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1F49674F
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Aug 2019 19:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfHTRTE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 20 Aug 2019 13:19:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27648 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725971AbfHTRTD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Aug 2019 13:19:03 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7KHGthU131171
        for <linux-rdma@vger.kernel.org>; Tue, 20 Aug 2019 13:19:03 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.75])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ugjk0yugv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 20 Aug 2019 13:19:02 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 20 Aug 2019 17:19:02 -0000
Received: from us1a3-smtp03.a3.dal06.isc4sb.com (10.106.154.98)
        by smtp.notes.na.collabserv.com (10.106.227.123) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 20 Aug 2019 17:18:56 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp03.a3.dal06.isc4sb.com
          with ESMTP id 2019082017185586-882446 ;
          Tue, 20 Aug 2019 17:18:55 +0000 
In-Reply-To: <20190820132255.GD29246@ziepe.ca>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, geert@linux-m68k.org
Date:   Tue, 20 Aug 2019 17:18:56 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190820132255.GD29246@ziepe.ca>,<20190820131442.26466-1-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 48943
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19082017-6875-0000-0000-0000001F7B6B
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000006
X-IBM-SpamModules-Versions: BY=3.00011624; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01249605; UDB=6.00659682; IPR=6.01031155;
 MB=3.00028248; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-20 17:19:00
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-20 14:18:49 - 6.00010308
x-cbparentid: 19082017-6876-0000-0000-0000002D02C4
Message-Id: <OFA69D73EE.9895368F-ON0025845C.005F1E2E-0025845C.005F1E33@notes.na.collabserv.com>
Subject: RE: [PATCH] siw: fix 64/32bit pointer inconsistency.
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-20_07:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 08/20/2019 03:23PM
>Cc: linux-rdma@vger.kernel.org, geert@linux-m68k.org
>Subject: [EXTERNAL] Re: [PATCH] siw: fix 64/32bit pointer
>inconsistency.
>
>On Tue, Aug 20, 2019 at 03:14:42PM +0200, Bernard Metzler wrote:
>>  		} else if (c_tx->in_syscall) {
>> -			if (copy_from_user((void *)paddr,
>> -					   (const void __user *)sge->laddr,
>> -					   bytes))
>> +			if (copy_from_user(paddr,
>> +				(const void __user *)(uintptr_t)sge->laddr,
>> +				bytes))
>
>This pattern should be written u64_to_user_ptr(), in fact every
>place that treats a user sourced u64 should use it.
>
>

Thanks Jason,
I will re-post.

