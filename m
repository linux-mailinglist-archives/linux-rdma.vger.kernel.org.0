Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F40C117223
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2019 17:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfLIQuc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 9 Dec 2019 11:50:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49750 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726354AbfLIQuc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Dec 2019 11:50:32 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB9Glh6K042966
        for <linux-rdma@vger.kernel.org>; Mon, 9 Dec 2019 11:50:30 -0500
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.91])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wrt59k7ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 09 Dec 2019 11:50:30 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 9 Dec 2019 16:50:30 -0000
Received: from us1a3-smtp08.a3.dal06.isc4sb.com (10.146.103.57)
        by smtp.notes.na.collabserv.com (10.106.227.143) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 9 Dec 2019 16:50:25 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp08.a3.dal06.isc4sb.com
          with ESMTP id 2019120916502316-737080 ;
          Mon, 9 Dec 2019 16:50:23 +0000 
In-Reply-To: <20191209160701.GD3790@ziepe.ca>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, krishna2@chelsio.com, leon@kernel.org
Date:   Mon, 9 Dec 2019 16:50:23 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20191209160701.GD3790@ziepe.ca>,<20191129162509.26576-1-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP62 November 04, 2019 at 09:47
X-LLNOutbound: False
X-Disclaimed: 7195
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19120916-2475-0000-0000-000001ADF9F6
X-IBM-SpamModules-Scores: BY=0.004; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.015419
X-IBM-SpamModules-Versions: BY=3.00012214; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01301911; UDB=6.00691372; IPR=6.01084197;
 MB=3.00029905; MTD=3.00000008; XFM=3.00000015; UTC=2019-12-09 16:50:29
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-12-09 14:56:11 - 6.00010746
x-cbparentid: 19120916-2476-0000-0000-000047BE17A9
Message-Id: <OF3F5E9911.A6946CC7-ON002584CB.0059DED2-002584CB.005C8103@notes.na.collabserv.com>
Subject: RE: [PATCH for-next] RDMA/siw: Simplify QP representation.
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-09_04:2019-12-09,2019-12-09 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 12/09/2019 05:07PM
>Cc: linux-rdma@vger.kernel.org, krishna2@chelsio.com, leon@kernel.org
>Subject: [EXTERNAL] Re: [PATCH for-next] RDMA/siw: Simplify QP
>representation.
>
>On Fri, Nov 29, 2019 at 05:25:09PM +0100, Bernard Metzler wrote:
>> Change siw_qp to contain ib_qp. Use ib_qp's uobject pointer
>> to distinguish kernel level and user level applications.
>> Apply same mechanism for kerne/user level application
>> detection to shared receive queues and completion queues.
>
>Drivers should not touch the uobject. If I recall you can use
>restrack
>to tell if it is kernel or user created
>
'bool res->user' would probably be it, but I stumbled
upon this comment (e.g. in struct ib_qp):

        /*
         * Implementation details of the RDMA core, don't use in drivers:
         */
        struct rdma_restrack_entry     res;


So we shall not use restrack information in drivers..?
Shall restrack better export a query such as
'rdma_restrack_is_user(resource)'?


After a quick investigation, current drivers do have
their own solution for the issue:

mlx5, mlx4, mthca, hns, cxgb4, qedr:
tests ib_xx->uobject as I proposed here for siw as well.

bnxt_re, qedr, hfi, i40iw, vmw_pvrdma:
use their own local resource flag ('is_user', 'is_kernel',
whatever), as siw does it until now, and what is not
preferred as well. How shall we proceed?

Thanks,
Bernard.

