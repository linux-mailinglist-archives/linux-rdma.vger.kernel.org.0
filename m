Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9CE94F726
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Jun 2019 18:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfFVQrS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sat, 22 Jun 2019 12:47:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726276AbfFVQrS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 22 Jun 2019 12:47:18 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5MGkgdq005862
        for <linux-rdma@vger.kernel.org>; Sat, 22 Jun 2019 12:47:17 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t9g70ake7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Sat, 22 Jun 2019 12:47:16 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Sat, 22 Jun 2019 16:47:15 -0000
Received: from us1b3-smtp07.a3dr.sjc01.isc4sb.com (10.122.203.198)
        by smtp.notes.na.collabserv.com (10.122.47.46) with smtp.notes.na.collabserv.com ESMTP;
        Sat, 22 Jun 2019 16:47:12 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp07.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019062216471143-314667 ;
          Sat, 22 Jun 2019 16:47:11 +0000 
In-Reply-To: <9a894290bb24d0190e2a302f9d8e934f3dff7e1b.camel@redhat.com>
Subject: Re: Re: [PATCH v3 05/11] SIW application interface
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Doug Ledford" <dledford@redhat.com>
Cc:     "Bart Van Assche" <bvanassche@acm.org>, linux-rdma@vger.kernel.org
Date:   Sat, 22 Jun 2019 16:47:11 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <9a894290bb24d0190e2a302f9d8e934f3dff7e1b.camel@redhat.com>,<20190620162133.13074-1-bmt@zurich.ibm.com>
 <20190620162133.13074-6-bmt@zurich.ibm.com>
 <f805a19d-256f-fa60-fc2d-dbc0939ed5cf@acm.org>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-KeepSent: 25CD8093:43AEF2B8-00258421:005C35E9;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 41431
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19062216-3017-0000-0000-000000302BC3
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.008982
X-IBM-SpamModules-Versions: BY=3.00011309; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01221739; UDB=6.00642797; IPR=6.01002878;
 MB=3.00027423; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-22 16:47:15
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-06-22 16:20:42 - 6.00010079
x-cbparentid: 19062216-3018-0000-0000-0000004E2DA2
Message-Id: <OF25CD8093.43AEF2B8-ON00258421.005C35E9-00258421.005C3600@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-22_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Doug Ledford" <dledford@redhat.com> wrote: -----

>To: "Bart Van Assche" <bvanassche@acm.org>, "Bernard Metzler"
><bmt@zurich.ibm.com>, linux-rdma@vger.kernel.org
>From: "Doug Ledford" <dledford@redhat.com>
>Date: 06/22/2019 12:28AM
>Subject: [EXTERNAL] Re: [PATCH v3 05/11] SIW application interface
>
>On Thu, 2019-06-20 at 09:33 -0700, Bart Van Assche wrote:
>> On 6/20/19 9:21 AM, Bernard Metzler wrote:
>> > diff --git a/include/uapi/rdma/siw-abi.h b/include/uapi/rdma/siw-
>> > abi.h
>> > new file mode 100644
>> > index 000000000000..3dd8071ace7b
>> > --- /dev/null
>> > +++ b/include/uapi/rdma/siw-abi.h
>> > @@ -0,0 +1,185 @@
>> > +/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
>> > +
>> > +/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
>> > +/* Copyright (c) 2008-2019, IBM Corporation */
>> > +
>> > +#ifndef _SIW_USER_H
>> > +#define _SIW_USER_H
>> > +
>> > +#include <linux/types.h>
>> > +
>> > +#define SIW_NODE_DESC_COMMON "Software iWARP stack"
>> 
>> How can the definition of a string like this be useful in an UAPI
>> header
>> file? If user space code doesn't need this string please move this
>> definition away from include/uapi.
>> 
>> > +#define SIW_ABI_VERSION 1
>> 
>> Same question here: how can this definition be useful in an UAPI
>> header
>> file? As you know Linux user space APIs must be backwards
>compatible.
>
>I moved both of these to sw/siw/siw.h instead of the uapi header.
>

Thanks Doug!

Bernard.
>-- 
>Doug Ledford <dledford@redhat.com>
>    GPG KeyID: B826A3330E572FDD
>    Fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
>
[attachment "signature.asc" removed by Bernard Metzler/Zurich/IBM]

