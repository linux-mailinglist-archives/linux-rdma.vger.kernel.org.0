Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43AE24D465
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 18:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfFTQ7y convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 20 Jun 2019 12:59:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46238 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726562AbfFTQ7x (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 Jun 2019 12:59:53 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5KGvF1Y071553
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jun 2019 12:59:52 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2t8cg24akd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jun 2019 12:59:52 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Thu, 20 Jun 2019 16:59:51 -0000
Received: from us1b3-smtp06.a3dr.sjc01.isc4sb.com (10.122.203.184)
        by smtp.notes.na.collabserv.com (10.122.47.46) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 20 Jun 2019 16:59:47 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp06.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019062016594656-629168 ;
          Thu, 20 Jun 2019 16:59:46 +0000 
In-Reply-To: <f805a19d-256f-fa60-fc2d-dbc0939ed5cf@acm.org>
Subject: Re: Re: [PATCH v3 05/11] SIW application interface
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Bart Van Assche" <bvanassche@acm.org>
Cc:     linux-rdma@vger.kernel.org
Date:   Thu, 20 Jun 2019 16:59:46 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <f805a19d-256f-fa60-fc2d-dbc0939ed5cf@acm.org>,<20190620162133.13074-1-bmt@zurich.ibm.com>
 <20190620162133.13074-6-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-KeepSent: BA96FEB0:843F4F0C-0025841F:005C79FD;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 61643
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19062016-3017-0000-0000-0000002C790E
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.188667
X-IBM-SpamModules-Versions: BY=3.00011297; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01220783; UDB=6.00642223; IPR=6.01001922;
 MB=3.00027395; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-20 16:59:49
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-06-20 15:20:15 - 6.00010071
x-cbparentid: 19062016-3018-0000-0000-000000488419
Message-Id: <OFBA96FEB0.843F4F0C-ON0025841F.005C79FD-0025841F.005D5CFD@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-20_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Bart Van Assche" <bvanassche@acm.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>,
>linux-rdma@vger.kernel.org
>From: "Bart Van Assche" <bvanassche@acm.org>
>Date: 06/20/2019 06:33PM
>Subject: [EXTERNAL] Re: [PATCH v3 05/11] SIW application interface
>
>On 6/20/19 9:21 AM, Bernard Metzler wrote:
>> diff --git a/include/uapi/rdma/siw-abi.h
>b/include/uapi/rdma/siw-abi.h
>> new file mode 100644
>> index 000000000000..3dd8071ace7b
>> --- /dev/null
>> +++ b/include/uapi/rdma/siw-abi.h
>> @@ -0,0 +1,185 @@
>> +/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
>> +
>> +/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
>> +/* Copyright (c) 2008-2019, IBM Corporation */
>> +
>> +#ifndef _SIW_USER_H
>> +#define _SIW_USER_H
>> +
>> +#include <linux/types.h>
>> +
>> +#define SIW_NODE_DESC_COMMON "Software iWARP stack"
>
>How can the definition of a string like this be useful in an UAPI
>header
>file? If user space code doesn't need this string please move this
>definition away from include/uapi.


OK, I had that in as another possible check from user lib if the
kernel driver matches. Not really needed. I can remove it...

>
>> +#define SIW_ABI_VERSION 1
>
>Same question here: how can this definition be useful in an UAPI
>header
>file? As you know Linux user space APIs must be backwards compatible.

Don't get that one yet. The kernel driver announces its
abi version (via uverbs_abi_ver) and user land lib get's checked
if it is in range (between match_min_abi_version
and match_max_abi_version). See e.g. efa, pvrdma, mqedr, bnxt ....
other drivers. It's always in the shared abi file then.

Thanks,
Bernard.

