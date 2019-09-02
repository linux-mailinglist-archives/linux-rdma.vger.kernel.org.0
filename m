Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB08AA5479
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Sep 2019 12:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbfIBKzM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 2 Sep 2019 06:55:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726273AbfIBKzM (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 2 Sep 2019 06:55:12 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x82ApsVw146185
        for <linux-rdma@vger.kernel.org>; Mon, 2 Sep 2019 06:55:11 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2us11chaxe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 02 Sep 2019 06:55:10 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 2 Sep 2019 10:55:09 -0000
Received: from us1b3-smtp03.a3dr.sjc01.isc4sb.com (10.122.7.173)
        by smtp.notes.na.collabserv.com (10.122.47.52) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 2 Sep 2019 10:55:01 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp03.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019090210550115-268648 ;
          Mon, 2 Sep 2019 10:55:01 +0000 
In-Reply-To: <MN2PR18MB31820E898CC0C39E7A347B62A1BE0@MN2PR18MB3182.namprd18.prod.outlook.com>
Subject: Re: RE: RE: [EXT] Re: [PATCH v8 rdma-next 4/7] RDMA/siw: Use the common
 mmap_xa helpers
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Michal Kalderon" <mkalderon@marvell.com>
Cc:     "Ariel Elior" <aelior@marvell.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Date:   Mon, 2 Sep 2019 10:55:00 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <MN2PR18MB31820E898CC0C39E7A347B62A1BE0@MN2PR18MB3182.namprd18.prod.outlook.com>,<MN2PR18MB318291264841FC40885F4B42A1BD0@MN2PR18MB3182.namprd18.prod.outlook.com>,<20190827132846.9142-5-michal.kalderon@marvell.com>,<20190827132846.9142-1-michal.kalderon@marvell.com>
 <OFED447099.CC1C35E8-ON00258466.003FD3A8-00258466.0042A33D@notes.na.collabserv.com>
 <OFDCD94E77.5EF5EBC2-ON00258466.0048FF97-00258466.00493280@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-KeepSent: EAE262CD:F8E217E7-00258469:0031FA1F;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 62315
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19090210-3633-0000-0000-0000008A0481
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.025673
X-IBM-SpamModules-Versions: BY=3.00011702; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01255599; UDB=6.00663343; IPR=6.01037258;
 MB=3.00028431; MTD=3.00000008; XFM=3.00000015; UTC=2019-09-02 10:55:07
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-09-02 05:33:40 - 6.00010359
x-cbparentid: 19090210-3634-0000-0000-00000C0B0493
Message-Id: <OFEAE262CD.F8E217E7-ON00258469.0031FA1F-00258469.003BF7C9@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-02_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Michal Kalderon" <mkalderon@marvell.com> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Michal Kalderon" <mkalderon@marvell.com>
>Date: 09/02/2019 10:01AM
>Cc: "Ariel Elior" <aelior@marvell.com>, "jgg@ziepe.ca"
><jgg@ziepe.ca>, "dledford@redhat.com" <dledford@redhat.com>,
>"galpress@amazon.com" <galpress@amazon.com>, "sleybo@amazon.com"
><sleybo@amazon.com>, "leon@kernel.org" <leon@kernel.org>,
>"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
>Subject: [EXTERNAL] RE: RE: [EXT] Re: [PATCH v8 rdma-next 4/7]
>RDMA/siw: Use the common mmap_xa helpers
>
>> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
>> owner@vger.kernel.org> On Behalf Of Bernard Metzler
>> 
>> -----"Michal Kalderon" <mkalderon@marvell.com> wrote: -----
>> 
>> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
>> >From: "Michal Kalderon" <mkalderon@marvell.com>
>> >Date: 08/30/2019 02:42PM
>> >Cc: "Ariel Elior" <aelior@marvell.com>, "jgg@ziepe.ca"
>> ><jgg@ziepe.ca>, "dledford@redhat.com" <dledford@redhat.com>,
>> >"galpress@amazon.com" <galpress@amazon.com>,
>> "sleybo@amazon.com"
>> ><sleybo@amazon.com>, "leon@kernel.org" <leon@kernel.org>,
>> >"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "Ariel
>> >Elior" <aelior@marvell.com>
>> >Subject: [EXTERNAL] RE: [EXT] Re: [PATCH v8 rdma-next 4/7]
>RDMA/siw:
>> >Use the common mmap_xa helpers
>> >
>> >> From: Bernard Metzler <BMT@zurich.ibm.com>
>> >> Sent: Friday, August 30, 2019 3:08 PM
>> >>
>> >> External Email
>> >>
>> >>
>>
>>--------------------------------------------------------------------
>-
>> >-
>> >> -----"Michal Kalderon" <michal.kalderon@marvell.com> wrote:
>-----
>> >>
>> >> Hi Michael,
>> >>
>> >> I tried this patch. It unfortunately panics immediately when siw
>> >gets used. I'll
>> >> investigate further. Some comments in line.
>> >Thanks for testing,
>> >
>> >>
>> >> Thanks
>> >> Bernard.
>> >>
>> >> >To: <mkalderon@marvell.com>, <aelior@marvell.com>,
>> <jgg@ziepe.ca>,
>> >> ><dledford@redhat.com>, <bmt@zurich.ibm.com>,
>> >> <galpress@amazon.com>,
>> >> ><sleybo@amazon.com>, <leon@kernel.org>
>> >> >From: "Michal Kalderon" <michal.kalderon@marvell.com>
>> >> >Date: 08/27/2019 03:31PM
>> >> >Cc: <linux-rdma@vger.kernel.org>, "Michal Kalderon"
>> >> ><michal.kalderon@marvell.com>, "Ariel Elior"
>> >> ><ariel.elior@marvell.com>
>> >> >Subject: [EXTERNAL] [PATCH v8 rdma-next 4/7] RDMA/siw: Use the
>> >> common
>> >> >mmap_xa helpers
>> >> >
>> >> >Remove the functions related to managing the mmap_xa database.
>> >> >This code is now common in ib_core. Use the common API's
>instead.
>> >> >
>> >> >Signed-off-by: Ariel Elior <ariel.elior@marvell.com>
>> >> >Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
>> >> >---
>> >> > drivers/infiniband/sw/siw/siw.h       |  20 ++-
>> >> > drivers/infiniband/sw/siw/siw_main.c  |   1 +
>> >> > drivers/infiniband/sw/siw/siw_verbs.c | 223
>> >> >+++++++++++++++++++---------------
>> >> > drivers/infiniband/sw/siw/siw_verbs.h |   1 +
>> >> > 4 files changed, 144 insertions(+), 101 deletions(-)
>> >> >
>> >> >+			/* If entry was inserted successfully, qp->sendq
>> >> >+			 * will be freed by siw_mmap_free
>> >> >+			 */
>> >> >+			qp->sendq = NULL;
>> >>
>> >> qp->sendq points to the SQ array. Zeroing this pointer will
>leave
>> >> siw with no idea where the WQE's are. It will panic
>de-referencing
>> >[NULL +
>> >> current position in ring buffer]. Same for RQ, SRQ and CQ.
>> >Qp->sendq is only used in kernel mode, and only set to NULL is
>> >user-space mode
>> >Where it is allocated and mapped in user, so the user will be the
>one
>> >accessing the rings And not kernel, unless I'm missing something.
>> 
>> These pointers are pointing to the allocated work queues.
>> These queues/arrays are holding the actual send/recv/complete/srq
>work
>> queue elements. It is a shared array. That is why we need mmap at
>all.
>> 
>> e.g.,
>> 
>> struct siw_sqe *sqe = &qp->sendq[qp->sq_get % qp->attrs.sq_size];
>> 
>> 
>Ok got it, I'm HW oriented... so user chains and kernel are totally
>separated. 
>Will add a flag whether to free or not and remove setting to NULL. 
>Thanks,
>Michal
>
Michael,
I even think there is an underlying design decision I am
questioning. The provider allocates the resource to be mmapped,
and there is no reason to have the mmapping service freeing
that resource at any point in time. I simply don't understand
why the mmap service wants to free the mmapped resource at all,
if it did not allocate it. The aim of the service
should be limited to provide mmapping bookkeeping.

The new mmap helper framework already defines a callback
for unmapping. The provider may use it to free the
resource, if appropriate. E.g., siw will not destroy a 
currently used CQ, only because the user land application
calls munmap on it.

Best regards,
Bernard.

