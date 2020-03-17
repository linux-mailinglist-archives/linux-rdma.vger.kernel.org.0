Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79A5018851B
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 14:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgCQNRR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 17 Mar 2020 09:17:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726112AbgCQNRR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Mar 2020 09:17:17 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02HD63NU028157
        for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2020 09:17:16 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.113])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yrr5f8x4v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2020 09:17:16 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 17 Mar 2020 13:17:16 -0000
Received: from us1b3-smtp04.a3dr.sjc01.isc4sb.com (10.122.203.161)
        by smtp.notes.na.collabserv.com (10.122.47.56) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 17 Mar 2020 13:17:10 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp04.a3dr.sjc01.isc4sb.com
          with ESMTP id 2020031713170927-504107 ;
          Tue, 17 Mar 2020 13:17:09 +0000 
In-Reply-To: <20200317124533.GB12316@lst.de>
Subject: Re: Re: broken CRCs at NVMeF target with SIW & NVMe/TCP transports
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Christoph Hellwig" <hch@lst.de>
Cc:     "Krishnamraju Eraparaju" <krishna2@chelsio.com>, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        "Nirranjan Kirubaharan" <nirranjan@chelsio.com>,
        "Potnuri Bharat Teja" <bharat@chelsio.com>
Date:   Tue, 17 Mar 2020 13:17:09 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20200317124533.GB12316@lst.de>,<20200316162008.GA7001@chelsio.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP62 November 04, 2019 at 09:47
X-KeepSent: ED8F9821:7106FFC4-0025852E:00476D8D;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 34119
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20031713-7691-0000-0000-000001A02844
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.000001
X-IBM-SpamModules-Versions: BY=3.00012764; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000293; SDB=6.01348975; UDB=6.00719454; IPR=6.01131383;
 MB=3.00031264; MTD=3.00000008; XFM=3.00000015; UTC=2020-03-17 13:17:15
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-03-17 10:34:30 - 6.00011129
x-cbparentid: 20031713-7692-0000-0000-000018A22AC9
Message-Id: <OFED8F9821.7106FFC4-ON0025852E.00476D8D-0025852E.0048FB79@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-17_04:2020-03-17,2020-03-17 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Christoph Hellwig" <hch@lst.de> wrote: -----

>To: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>From: "Christoph Hellwig" <hch@lst.de>
>Date: 03/17/2020 01:45PM
>Cc: "Bernard Metzler" <BMT@zurich.ibm.com>, sagi@grimberg.me,
>hch@lst.de, linux-nvme@lists.infradead.org,
>linux-rdma@vger.kernel.org, "Nirranjan Kirubaharan"
><nirranjan@chelsio.com>, "Potnuri Bharat Teja" <bharat@chelsio.com>
>Subject: [EXTERNAL] Re: broken CRCs at NVMeF target with SIW &
>NVMe/TCP transports
>
>On Mon, Mar 16, 2020 at 09:50:10PM +0530, Krishnamraju Eraparaju
>wrote:
>> 
>> I'm seeing broken CRCs at NVMeF target while running the below
>program
>> at host. Here RDMA transport is SoftiWARP, but I'm also seeing the
>> same issue with NVMe/TCP aswell.
>> 
>> It appears to me that the same buffer is being rewritten by the
>> application/ULP before getting the completion for the previous
>requests.
>> getting the completion for the previous requests. HW based
>> HW based trasports(like iw_cxgb4) are not showing this issue
>because
>> they copy/DMA and then compute the CRC on copied buffer.
>
>For TCP we can set BDI_CAP_STABLE_WRITES.  For RDMA I don't think
>that

Hmm, can you elaborate a little more here? I see that flag being
set for data digest enabled (e.g. nvme/host/core.c:nvme_alloc_ns()).
But enabling that data digest CRC is exactly when the NVMeF/TCP
target detects the issue and drops the frame and disconnects...?

The current situation for NVMeF/TCP is that the data digest is
not enabled per default and buffer changes are not detected then.

Krishna first detected it with using siw against hardware iWarp
target, since the CRC gets negotiated then.

>is a good idea as pretty much all RDMA block drivers rely on the
>DMA behavior above.  The answer is to bounce buffer the data in
>SoftiWARP / SoftRoCE.
>
>
Another extra copy of user data isn't really charming. Can we
somehow let the ULP have its fingers crossed until the buffer
got transferred, as signaled back?

Best,
Bernard.

