Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB1317331
	for <lists+linux-rdma@lfdr.de>; Wed,  8 May 2019 10:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbfEHIIH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 8 May 2019 04:08:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37618 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725778AbfEHIIH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 8 May 2019 04:08:07 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4882mTb066148
        for <linux-rdma@vger.kernel.org>; Wed, 8 May 2019 04:08:05 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.90])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2sbu8g06dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 08 May 2019 04:08:04 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Wed, 8 May 2019 08:08:04 -0000
Received: from us1a3-smtp05.a3.dal06.isc4sb.com (10.146.71.159)
        by smtp.notes.na.collabserv.com (10.106.227.141) with smtp.notes.na.collabserv.com ESMTP;
        Wed, 8 May 2019 08:08:00 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp05.a3.dal06.isc4sb.com
          with ESMTP id 2019050808075988-200524 ;
          Wed, 8 May 2019 08:07:59 +0000 
In-Reply-To: <20190507170943.GI6201@ziepe.ca>
Subject: Re: [PATCH v8 02/12] SIW main include file
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     "Leon Romanovsky" <leon@kernel.org>, linux-rdma@vger.kernel.org
Date:   Wed, 8 May 2019 08:07:59 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190507170943.GI6201@ziepe.ca>,<20190505170956.GH6938@mtr-leonro.mtl.com>
 <20190428110721.GI6705@mtr-leonro.mtl.com>
 <20190426131852.30142-1-bmt@zurich.ibm.com>
 <20190426131852.30142-3-bmt@zurich.ibm.com>
 <OF713CDB64.D1B09740-ON002583F1.0050F874-002583F1.005CE977@notes.na.collabserv.com>
 <OF11D27C39.8647DC53-ON002583F3.005609DE-002583F3.0057694C@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1048) | IBM Domino Build
 SCN1812108_20180501T0841_FP38 April 10, 2019 at 11:56
X-LLNOutbound: False
X-Disclaimed: 65403
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19050808-9717-0000-0000-00000C0E615E
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.425523; ST=0; TS=0; UL=0; ISC=; MB=0.058300
X-IBM-SpamModules-Versions: BY=3.00011069; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000285; SDB=6.01200256; UDB=6.00629755; IPR=6.00981142;
 BA=6.00006303; NDR=6.00000001; ZLA=6.00000005; ZF=6.00000009; ZB=6.00000000;
 ZP=6.00000000; ZH=6.00000000; ZU=6.00000002; MB=3.00026784; XFM=3.00000015;
 UTC=2019-05-08 08:08:03
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-05-08 07:10:21 - 6.00009899
x-cbparentid: 19050808-9718-0000-0000-0000558AAEAC
Message-Id: <OFE6341395.7491F9CF-ON002583F4.002BAA7E-002583F4.002CAD7E@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-08_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 05/07/2019 07:09PM
>Cc: "Leon Romanovsky" <leon@kernel.org>, linux-rdma@vger.kernel.org
>Subject: Re: [PATCH v8 02/12] SIW main include file
>
>On Tue, May 07, 2019 at 03:54:45PM +0000, Bernard Metzler wrote:
>> 
>> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
>> >From: "Leon Romanovsky" <leon@kernel.org>
>> >Date: 05/05/2019 07:10PM
>> >Cc: linux-rdma@vger.kernel.org, "Bernard Metzler"
>> ><bmt@rims.zurich.ibm.com>
>> >Subject: Re: [PATCH v8 02/12] SIW main include file
>> >
>> >On Sun, May 05, 2019 at 04:54:50PM +0000, Bernard Metzler wrote:
>> >>
>> >> >To: "Bernard Metzler" <bmt@zurich.ibm.com>
>> >> >From: "Leon Romanovsky" <leon@kernel.org>
>> >> >Date: 04/28/2019 01:07PM
>> >> >Cc: linux-rdma@vger.kernel.org, "Bernard Metzler"
>> >> ><bmt@rims.zurich.ibm.com>
>> >> >Subject: Re: [PATCH v8 02/12] SIW main include file
>> >> >
>> >> >On Fri, Apr 26, 2019 at 03:18:42PM +0200, Bernard Metzler
>wrote:
>> >> >> From: Bernard Metzler <bmt@rims.zurich.ibm.com>
>> >> >>
>> >> >> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> >> >>  drivers/infiniband/sw/siw/siw.h | 733
>> >> >++++++++++++++++++++++++++++++++
>> >> >>  1 file changed, 733 insertions(+)
>> >> >>  create mode 100644 drivers/infiniband/sw/siw/siw.h
>> >> >>
>> >> >> diff --git a/drivers/infiniband/sw/siw/siw.h
>> >> >b/drivers/infiniband/sw/siw/siw.h
>> >> >> new file mode 100644
>> >> >> index 000000000000..9a3c2abbd858
>> >> >> +++ b/drivers/infiniband/sw/siw/siw.h
>> >> >> @@ -0,0 +1,733 @@
>> >> >> +/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
>> >> >> +
>> >> >> +/* Authors: Bernard Metzler <bmt@zurich.ibm.com> */
>> >> >> +/* Copyright (c) 2008-2019, IBM Corporation */
>> >> >> +
>> >> >> +#ifndef _SIW_H
>> >> >> +#define _SIW_H
>> >> >> +
>> >> >> +#include <linux/idr.h>
>> >> >> +#include <rdma/ib_verbs.h>
>> >> >> +#include <linux/socket.h>
>> >> >> +#include <linux/skbuff.h>
>> >> >> +#include <linux/in.h>
>> >> >> +#include <linux/fs.h>
>> >> >> +#include <linux/netdevice.h>
>> >> >> +#include <crypto/hash.h>
>> >> >> +#include <linux/resource.h> /* MLOCK_LIMIT */
>> >> >> +#include <linux/module.h>
>> >> >> +#include <linux/version.h>
>> >> >> +#include <linux/llist.h>
>> >> >> +#include <linux/mm.h>
>> >> >> +#include <linux/sched/signal.h>
>> >> >> +
>> >> >> +#include <rdma/siw_user.h>
>> >> >> +#include "iwarp.h"
>> >> >> +
>> >> >> +/* driver debugging enabled */
>> >> >> +#define DEBUG
>> >> >
>> >> >I clearly remember that we asked to remove this.
>> >>
>> >> Absolutely. Sorry, it sneaked in again since I did some
>> >> debugging. Will remove...
>> >> >
>> >> >> +	spinlock_t lock;
>> >> >> +
>> >> >> +	/* object management */
>> >> >> +	struct idr qp_idr;
>> >> >> +	struct idr mem_idr;
>> >> >
>> >> >Why IDR and not XArray?
>> >>
>> >> Memory access keys and QP IDs are generated as random
>> >> numbers, since both are exposed to the application.
>> >> Since XArray is not designed for sparsely distributed
>> >> id ranges, I am still in favor of IDR for these two
>> >> resources.
>
>IDR and xarray have identical underlying storage so this is nonsense
>
>No new idr's or radix tree users will be accepted into rdma.... Use
>xarray
>
Sounds good to me! I just came across that introductory video from Matthew,
where he explicitly stated that xarray will be not very efficient if the
indices are not densely clustered. But maybe this is all far beyond the
24bits of index space a memory key is in. So let me drop that IDR thing
completely, while handling randomized 24 bit memory keys.

Thanks
Bernard

