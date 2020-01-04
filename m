Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE1FC1303C0
	for <lists+linux-rdma@lfdr.de>; Sat,  4 Jan 2020 18:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgADRZP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Sat, 4 Jan 2020 12:25:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35252 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726004AbgADRZP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 4 Jan 2020 12:25:15 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 004HJD5Y137141
        for <linux-rdma@vger.kernel.org>; Sat, 4 Jan 2020 12:25:13 -0500
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.114])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xamgw5nvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Sat, 04 Jan 2020 12:25:13 -0500
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Sat, 4 Jan 2020 17:25:12 -0000
Received: from us1b3-smtp07.a3dr.sjc01.isc4sb.com (10.122.203.198)
        by smtp.notes.na.collabserv.com (10.122.47.58) with smtp.notes.na.collabserv.com ESMTP;
        Sat, 4 Jan 2020 17:25:08 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp07.a3dr.sjc01.isc4sb.com
          with ESMTP id 2020010417250835-263125 ;
          Sat, 4 Jan 2020 17:25:08 +0000 
In-Reply-To: <20200103231512.GA27516@ziepe.ca>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     "zhengbin" <zhengbin13@huawei.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org
Date:   Sat, 4 Jan 2020 17:25:07 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20200103231512.GA27516@ziepe.ca>,<1577176812-2238-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP62 November 04, 2019 at 09:47
X-KeepSent: 3EA6B761:92B1FEB3-002584E5:005F3E03;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 49111
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20010417-1639-0000-0000-0000013527A1
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.001320
X-IBM-SpamModules-Versions: BY=3.00012338; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000292; SDB=6.01314319; UDB=6.00698788; IPR=6.01096643;
 MB=3.00030198; MTD=3.00000008; XFM=3.00000015; UTC=2020-01-04 17:25:11
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-01-04 15:37:31 - 6.00010845
x-cbparentid: 20010417-1640-0000-0000-000056B92B4D
Message-Id: <OF3EA6B761.92B1FEB3-ON002584E5.005F3E03-002584E5.005FAF19@notes.na.collabserv.com>
Subject: RE: [PATCH 0/5] RDMA: use true,false for bool variable
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2020-01-04_04:2020-01-02,2020-01-04 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "zhengbin" <zhengbin13@huawei.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 01/04/2020 12:15AM
>Cc: bmt@zurich.ibm.com, dledford@redhat.com,
>linux-rdma@vger.kernel.org
>Subject: [EXTERNAL] Re: [PATCH 0/5] RDMA: use true,false for bool
>variable
>
>On Tue, Dec 24, 2019 at 04:40:07PM +0800, zhengbin wrote:
>> zhengbin (5):
>>   RDMA/siw: use true,false for bool variable
>>   IB/hfi1: use true,false for bool variable
>>   IB/iser: use true,false for bool variable
>>   RDMA/mlx4: use true,false for bool variable
>>   RDMA/mlx5: use true,false for bool variable
>
>Applied to for-next, but Leon seems right about the funny
>relaxed_ird_negotiation that is never set, is that debugging or
>something?
>

Sorry for not coming back earlier. I had a quite severe
bicycle accident which has put me completely off for the
last two and a half weeks.

This flag was introduced with a change to the MPA setup
sequence. While siw originally insisted in correct peer
behavior (not sending data in RDMA mode until handshake
completed), this led to issues with another iWarp 
implementation, which under certain circumstances brakes
the correct setup sequence. So we allowed that peer behavior,
while it brakes the spec.
If we agree that this 'permissive' behavior to be the only
behavior we want to support, we can simply remove that flag
and related code, maybe just leaving a comment at the right
place stating we are permissive?

Thanks
Bernard.

