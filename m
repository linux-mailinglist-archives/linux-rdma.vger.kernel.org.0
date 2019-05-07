Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9863416738
	for <lists+linux-rdma@lfdr.de>; Tue,  7 May 2019 17:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfEGPyz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 7 May 2019 11:54:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726438AbfEGPyz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 May 2019 11:54:55 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x47FnUeQ078887
        for <linux-rdma@vger.kernel.org>; Tue, 7 May 2019 11:54:54 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.112])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sbcdft362-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 07 May 2019 11:54:53 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 7 May 2019 15:54:53 -0000
Received: from us1b3-smtp03.a3dr.sjc01.isc4sb.com (10.122.7.173)
        by smtp.notes.na.collabserv.com (10.122.47.54) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 7 May 2019 15:54:46 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp03.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019050715544588-715236 ;
          Tue, 7 May 2019 15:54:45 +0000 
In-Reply-To: <20190505170956.GH6938@mtr-leonro.mtl.com>
Subject: Re: [PATCH v8 02/12] SIW main include file
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Date:   Tue, 7 May 2019 15:54:45 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190505170956.GH6938@mtr-leonro.mtl.com>,<20190428110721.GI6705@mtr-leonro.mtl.com>
 <20190426131852.30142-1-bmt@zurich.ibm.com>
 <20190426131852.30142-3-bmt@zurich.ibm.com>
 <OF713CDB64.D1B09740-ON002583F1.0050F874-002583F1.005CE977@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1048) | IBM Domino Build
 SCN1812108_20180501T0841_FP38 April 10, 2019 at 11:56
X-KeepSent: 11D27C39:8647DC53-002583F3:005609DE;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 50731
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19050715-0163-0000-0000-0000062E7456
X-IBM-SpamModules-Scores: BY=0.275305; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.415104; ST=0; TS=0; UL=0; ISC=; MB=0.231836
X-IBM-SpamModules-Versions: BY=3.00011066; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01199936; UDB=6.00629560; IPR=6.00980818;
 BA=6.00006300; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00026771; XFM=3.00000015;
 UTC=2019-05-07 15:54:51
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-05-07 15:19:53 - 6.00009896
x-cbparentid: 19050715-0164-0000-0000-00000F468D4D
Message-Id: <OF11D27C39.8647DC53-ON002583F3.005609DE-002583F3.0057694C@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-07_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 05/05/2019 07:10PM
>Cc: linux-rdma@vger.kernel.org, "Bernard Metzler"
><bmt@rims.zurich.ibm.com>
>Subject: Re: [PATCH v8 02/12] SIW main include file
>
>On Sun, May 05, 2019 at 04:54:50PM +0000, Bernard Metzler wrote:
>> -----"Leon Romanovsky" <leon@kernel.org> wrote: -----
>>
>> >To: "Bernard Metzler" <bmt@zurich.ibm.com>
>> >From: "Leon Romanovsky" <leon@kernel.org>
>> >Date: 04/28/2019 01:07PM
>> >Cc: linux-rdma@vger.kernel.org, "Bernard Metzler"
>> ><bmt@rims.zurich.ibm.com>
>> >Subject: Re: [PATCH v8 02/12] SIW main include file
>> >
>> >On Fri, Apr 26, 2019 at 03:18:42PM +0200, Bernard Metzler wrote:
>> >> From: Bernard Metzler <bmt@rims.zurich.ibm.com>
>> >>
>> >> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> >> ---
>> >>  drivers/infiniband/sw/siw/siw.h | 733
>> >++++++++++++++++++++++++++++++++
>> >>  1 file changed, 733 insertions(+)
>> >>  create mode 100644 drivers/infiniband/sw/siw/siw.h
>> >>
>> >> diff --git a/drivers/infiniband/sw/siw/siw.h
>> >b/drivers/infiniband/sw/siw/siw.h
>> >> new file mode 100644
>> >> index 000000000000..9a3c2abbd858
>> >> --- /dev/null
>> >> +++ b/drivers/infiniband/sw/siw/siw.h
>> >> @@ -0,0 +1,733 @@
>> >> +/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
>> >> +
>> >> +/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
>> >> +/* Copyright (c) 2008-2019, IBM Corporation */
>> >> +
>> >> +#ifndef _SIW_H
>> >> +#define _SIW_H
>> >> +
>> >> +#include <linux/idr.h>
>> >> +#include <rdma/ib_verbs.h>
>> >> +#include <linux/socket.h>
>> >> +#include <linux/skbuff.h>
>> >> +#include <linux/in.h>
>> >> +#include <linux/fs.h>
>> >> +#include <linux/netdevice.h>
>> >> +#include <crypto/hash.h>
>> >> +#include <linux/resource.h> /* MLOCK_LIMIT */
>> >> +#include <linux/module.h>
>> >> +#include <linux/version.h>
>> >> +#include <linux/llist.h>
>> >> +#include <linux/mm.h>
>> >> +#include <linux/sched/signal.h>
>> >> +
>> >> +#include <rdma/siw_user.h>
>> >> +#include "iwarp.h"
>> >> +
>> >> +/* driver debugging enabled */
>> >> +#define DEBUG
>> >
>> >I clearly remember that we asked to remove this.
>>
>> Absolutely. Sorry, it sneaked in again since I did some
>> debugging. Will remove...
>> >
>> >> +	spinlock_t lock;
>> >> +
>> >> +	/* object management */
>> >> +	struct idr qp_idr;
>> >> +	struct idr mem_idr;
>> >
>> >Why IDR and not XArray?
>>
>> Memory access keys and QP IDs are generated as random
>> numbers, since both are exposed to the application.
>> Since XArray is not designed for sparsely distributed
>> id ranges, I am still in favor of IDR for these two
>> resources.
>
>Why do those number need to be "sparsely distributed"?
>Isn't this ID to query in some internal object database?
>
>At lease QP number is for sure can be sequential, there is no extra
>value of creating it to be random.
>
Yes, I can drop that for QP's. At the other hand, those
QP numbers are used by the application to reference the
right QP during siw_accept and siw_connect. So for
the application it becomes easy to guess amd hijack
a valid QP number, if it is not random. I am not sure
if the RDMA midlayer takes care if the application uses
the right QP number during accept/connect. I can add
checks into siw (e.g. right PD or some such).

>>
>> >
>> >> +	/* active objects statistics */
>> >
>> >refcount_t please
>> >
>> >> +	atomic_t num_qp;
>> >> +	atomic_t num_cq;
>> >> +	atomic_t num_pd;
>> >> +	atomic_t num_mr;
>> >> +	atomic_t num_srq;
>> >> +	atomic_t num_cep;
>> >> +	atomic_t num_ctx;
>> >> +
>> >
>>
>> These counters are only used to limit the amount of
>> resources allocated to their max values per device.
>>
>> Since there is no equivalent for atomic_inc_return()
>> for refcounters I'd suggest to stay with atomic_t:
>>
>>         refcount_inc(&sdev->num_mr);
>>         if (refcount_read(&sdev->num_mr) > SIW_MAX_MR) {
>>                 siw_dbg_pd(pd, "too many mr's\n");
>>                 rv = -ENOMEM;
>>                 goto err_out;
>>         }
>> vs.
>>         if (atomic_inc_return(&sdev->num_mr) > SIW_MAX_MR) {
>>                 siw_dbg_pd(pd, "too many mr's\n");
>>                 rv = -ENOMEM;
>>                 goto err_out;
>>         }
>>
>
>No problem, anyway we are planning to generalize it and remove from
>all drivers.
>
Okay
>>
>>
>> ><...>
>> >
>> >> +/*
>> >> + * Generic memory representation for registered siw memory.
>> >> + * Memory lookup always via higher 24 bit of STag (STag index).
>> >> + * Object relates to memory window if embedded mr pointer is
>valid
>> >> + */
>> >> +struct siw_mem {
>> >> +	struct siw_device *sdev;
>> >> +	struct kref ref;
>> >
>> ><...>
>> >
>> >> +struct siw_qp {
>> >> +	struct ib_qp base_qp;
>> >> +	struct siw_device *sdev;
>> >> +	struct kref ref;
>> >
>> >I wonder if kref is needed in driver code.
>> >
>> ><...>
>>
>> Memory and QP objects are, while generally maintained
>> by the RDMA midlayer, also guarded against deallocation
>> while still in use by the driver. The code tries to avoid
>> taking resource locks for operations like in flight RDMA reads
>> on a memory object. So it makes use of the release function
>> in kref_put().
>
>krefs are not replacing the locks, but protect from release
>during the operation on that object. I don't understand
>the connection that your draw here between RDMA midlayer
>and in-flight operations.

An in flight RDMA Read/Write to/from a memory must finish before
the memory gets invalidated. I avoid spinlocking + irq
disabling each time memory gets accessed.

>
>> >
>> >> +/* Varia */
>> >
>> >????
>> >
>> right, will remove useless comment.
>>
>> >> +extern void siw_cq_flush(struct siw_cq *cq);
>> >> +extern void siw_sq_flush(struct siw_qp *qp);
>> >> +extern void siw_rq_flush(struct siw_qp *qp);
>> >> +extern int siw_reap_cqe(struct siw_cq *cq, struct ib_wc *wc);
>> >> +extern void siw_print_hdr(union iwarp_hdr *hdr, int qp_id, char
>> >*string);
>> >> +#endif
>> >> --
>> >> 2.17.2
>> >>
>> >
>> >
>>
>
>

