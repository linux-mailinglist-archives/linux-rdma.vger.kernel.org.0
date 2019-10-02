Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3EDCC8B67
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 16:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbfJBOig convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Wed, 2 Oct 2019 10:38:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12360 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726000AbfJBOig (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 2 Oct 2019 10:38:36 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x92EMD4s099708
        for <linux-rdma@vger.kernel.org>; Wed, 2 Oct 2019 10:38:35 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.104])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vcuknvvdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Wed, 02 Oct 2019 10:38:35 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Wed, 2 Oct 2019 14:38:34 -0000
Received: from us1b3-smtp02.a3dr.sjc01.isc4sb.com (10.122.7.175)
        by smtp.notes.na.collabserv.com (10.122.47.44) with smtp.notes.na.collabserv.com ESMTP;
        Wed, 2 Oct 2019 14:38:27 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp02.a3dr.sjc01.isc4sb.com
          with ESMTP id 2019100214382718-518440 ;
          Wed, 2 Oct 2019 14:38:27 +0000 
In-Reply-To: <20191002133210.GD5855@unreal>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Leon Romanovsky" <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com, jgg@ziepe.ca,
        nirranjan@chelsio.com, krishna2@chelsio.com, bvanassche@acm.org
Date:   Wed, 2 Oct 2019 14:38:26 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20191002133210.GD5855@unreal>,<20191002131423.4181-1-bmt@zurich.ibm.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP57 August 05, 2019 at 12:42
X-KeepSent: 0EB68DD7:BD098844-00258487:005068D7;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 65023
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19100214-5525-0000-0000-000000F86860
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.013736
X-IBM-SpamModules-Versions: BY=3.00011877; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01269669; UDB=6.00672002; IPR=6.01051707;
 MB=3.00028915; MTD=3.00000008; XFM=3.00000015; UTC=2019-10-02 14:38:31
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-10-02 09:30:44 - 6.00010477
x-cbparentid: 19100214-5526-0000-0000-000062AF7268
Message-Id: <OF0EB68DD7.BD098844-ON00258487.005068D7-00258487.00506C97@notes.na.collabserv.com>
Subject: RE: [[PATCH v2 for-next]] RDMA/siw: Fix SQ/RQ drain logic
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-02_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Leon Romanovsky" <leon@kernel.org> wrote: -----

>To: "Bernard Metzler" <bmt@zurich.ibm.com>
>From: "Leon Romanovsky" <leon@kernel.org>
>Date: 10/02/2019 03:32PM
>Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com, jgg@ziepe.ca,
>nirranjan@chelsio.com, krishna2@chelsio.com, bvanassche@acm.org
>Subject: [EXTERNAL] Re: [[PATCH v2 for-next]] RDMA/siw: Fix SQ/RQ
>drain logic
>
>On Wed, Oct 02, 2019 at 03:14:23PM +0200, Bernard Metzler wrote:
>> Storage ULPs (e.g. iSER & NVMeOF) use ib_drain_qp() to
>> drain QP/CQ. Current SIW's own drain routines do not properly
>> wait until all SQ/RQ elements are completed and reaped
>> from the CQ. This may cause touch after free issues.
>> New logic relies on generic __ib_drain_sq()/__ib_drain_rq()
>> posting a final work request, which SIW immediately flushes
>> to CQ.
>>
>> Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
>> Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
>> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
>> ---
>>  drivers/infiniband/sw/siw/siw_main.c  |  20 -----
>>  drivers/infiniband/sw/siw/siw_verbs.c | 103
>+++++++++++++++++++++-----
>>  2 files changed, 86 insertions(+), 37 deletions(-)
>>
>
>I didn't follow after v1 discussion and will be glad to see
>changelog,
>what is the reason for v2?
>
Absolutely. Let me resend the patch with below change log.

Sorry & best regards,
Bernard.

v1 -> v2:
- Accept SQ and RQ work requests, if QP is in ERROR
  state. In that case, immediately flush WR's to CQ.
  This already provides needed functionality to
  support ib_drain_sq()/ib_drain_rq() without extra
  state checking in the fast path.

