Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6356567029
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 15:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfGLNfL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 12 Jul 2019 09:35:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22014 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726466AbfGLNfL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Jul 2019 09:35:11 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CDRjNl048958
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 09:35:10 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.91])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tpsvfm19u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 09:35:09 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 12 Jul 2019 13:35:08 -0000
Received: from us1a3-smtp02.a3.dal06.isc4sb.com (10.106.154.159)
        by smtp.notes.na.collabserv.com (10.106.227.143) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 12 Jul 2019 13:35:00 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp02.a3.dal06.isc4sb.com
          with ESMTP id 2019071213350016-511577 ;
          Fri, 12 Jul 2019 13:35:00 +0000 
In-Reply-To: <20190712131930.GT3419@hirez.programming.kicks-ass.net>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Peter Zijlstra" <peterz@infradead.org>
Cc:     "Jason Gunthorpe" <jgg@ziepe.ca>, "Arnd Bergmann" <arnd@arndb.de>,
        "Doug Ledford" <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 12 Jul 2019 13:35:00 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190712131930.GT3419@hirez.programming.kicks-ass.net>,<20190712120328.GB27512@ziepe.ca>
 <20190712085212.3901785-1-arnd@arndb.de>
 <OF05C1A780.433E36D1-ON00258435.003381DA-00258435.003F847E@notes.na.collabserv.com>
 <OF36428621.B839DE8B-ON00258435.00461748-00258435.0047E413@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 51895
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19071213-9951-0000-0000-00000D416317
X-IBM-SpamModules-Scores: BY=0.032547; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.011778
X-IBM-SpamModules-Versions: BY=3.00011415; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01231113; UDB=6.00648510; IPR=6.01012397;
 BA=6.00006355; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00027691; XFM=3.00000015;
 UTC=2019-07-12 13:35:06
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-07-12 09:00:41 - 6.00010155
x-cbparentid: 19071213-9952-0000-0000-00003D8869F8
Message-Id: <OFFCB81001.A5C81FEB-ON00258435.0049DC1C-00258435.004A9DA0@notes.na.collabserv.com>
Subject: Re:  Re: Re: [PATCH] rdma/siw: avoid smp_store_mb() on a u64
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Peter Zijlstra" <peterz@infradead.org> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Peter Zijlstra" <peterz@infradead.org>
>Date: 07/12/2019 03:19PM
>Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "Arnd Bergmann"
><arnd@arndb.de>, "Doug Ledford" <dledford@redhat.com>,
>linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
>Subject: [EXTERNAL] Re: Re: [PATCH] rdma/siw: avoid smp_store_mb() on
>a u64
>
>On Fri, Jul 12, 2019 at 01:05:14PM +0000, Bernard Metzler wrote:
>> @@ -1131,6 +1131,10 @@ int siw_poll_cq(struct ib_cq *base_cq, int
>num_cqe, struct ib_wc *wc)
>>   *   number of not reaped CQE's regardless of its notification
>>   *   type and current or new CQ notification settings.
>>   *
>> + * This function gets called only by kernel consumers.
>> + * Notification state must immediately become visible to all
>> + * associated kernel producers (QP's).
>
>No amount of memory barriers can achieve that goal.
>
>
Oh right, that is correct. And it is not needed. This statement
is to bold. We simply want it asap. Actually, per API semantics, there is
no ordering guarantee between creating a completion queue event and
concurrently arming/disarming the completion queue. Since it is
not possible.
I use the barrier to minimize the likelihood a CQ event is missed
since the CQ is not yet visible to be re-armed to all producers.
But it can happen. This is what this optional
IB_CQ_REPORT_MISSED_EVENTS right below the re-arming is for.

Would be OK if we just adapt the comment from 'must immediately become visible'
to 'shall become visible asap'. That would reflect the intention.

Thanks very much!
Bernard.

int siw_req_notify_cq(struct ib_cq *base_cq, enum ib_cq_notify_flags flags)
{
        struct siw_cq *cq = to_siw_cq(base_cq);

        siw_dbg_cq(cq, "flags: 0x%02x\n", flags);

        if ((flags & IB_CQ_SOLICITED_MASK) == IB_CQ_SOLICITED)
                /*
                 * Enable CQ event for next solicited completion.
                 * and make it visible to all associated producers.
                 */
                smp_store_mb(cq->notify->flags, SIW_NOTIFY_SOLICITED);
        else
                /*
                 * Enable CQ event for any signalled completion.
                 * and make it visible to all associated producers.
                 */
                smp_store_mb(cq->notify->flags, SIW_NOTIFY_ALL);

        if (flags & IB_CQ_REPORT_MISSED_EVENTS)
                return cq->cq_put - cq->cq_get;

        return 0;
}

