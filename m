Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4AF5188A41
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2020 17:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgCQQ3h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Tue, 17 Mar 2020 12:29:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65288 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726082AbgCQQ3h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 17 Mar 2020 12:29:37 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02HGMJQx116816
        for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2020 12:29:36 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.66])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yrsdshmgm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Tue, 17 Mar 2020 12:29:36 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Tue, 17 Mar 2020 16:29:35 -0000
Received: from us1a3-smtp03.a3.dal06.isc4sb.com (10.106.154.98)
        by smtp.notes.na.collabserv.com (10.106.227.127) with smtp.notes.na.collabserv.com ESMTP;
        Tue, 17 Mar 2020 16:29:28 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp03.a3.dal06.isc4sb.com
          with ESMTP id 2020031716292879-851182 ;
          Tue, 17 Mar 2020 16:29:28 +0000 
In-Reply-To: <a8e7b61a-b238-2cc3-d3c8-743ad1f8c8ee@grimberg.me>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Sagi Grimberg" <sagi@grimberg.me>
Cc:     "Christoph Hellwig" <hch@lst.de>,
        "Krishnamraju Eraparaju" <krishna2@chelsio.com>,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        "Nirranjan Kirubaharan" <nirranjan@chelsio.com>,
        "Potnuri Bharat Teja" <bharat@chelsio.com>
Date:   Tue, 17 Mar 2020 16:29:28 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <a8e7b61a-b238-2cc3-d3c8-743ad1f8c8ee@grimberg.me>,<20200316162008.GA7001@chelsio.com>
 <20200317124533.GB12316@lst.de>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP62 November 04, 2019 at 09:47
X-LLNOutbound: False
X-Disclaimed: 32371
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20031716-4409-0000-0000-000002410316
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.000002
X-IBM-SpamModules-Versions: BY=3.00012765; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000293; SDB=6.01349039; UDB=6.00719492; IPR=6.01131448;
 MB=3.00031266; MTD=3.00000008; XFM=3.00000015; UTC=2020-03-17 16:29:34
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-03-17 09:56:09 - 6.00011129
x-cbparentid: 20031716-4410-0000-0000-000057BC6368
Message-Id: <OFB2589549.AD31F8B8-ON0025852E.005A969A-0025852E.005A96A3@notes.na.collabserv.com>
Subject: RE: broken CRCs at NVMeF target with SIW & NVMe/TCP transports
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-17_06:2020-03-17,2020-03-17 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Sagi Grimberg" <sagi@grimberg.me> wrote: -----

>To: "Christoph Hellwig" <hch@lst.de>, "Krishnamraju Eraparaju"
><krishna2@chelsio.com>
>From: "Sagi Grimberg" <sagi@grimberg.me>
>Date: 03/17/2020 05:04PM
>Cc: "Bernard Metzler" <BMT@zurich.ibm.com>,
>linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
>"Nirranjan Kirubaharan" <nirranjan@chelsio.com>, "Potnuri Bharat
>Teja" <bharat@chelsio.com>
>Subject: [EXTERNAL] Re: broken CRCs at NVMeF target with SIW &
>NVMe/TCP transports
>
>> On Mon, Mar 16, 2020 at 09:50:10PM +0530, Krishnamraju Eraparaju
>wrote:
>>>
>>> I'm seeing broken CRCs at NVMeF target while running the below
>program
>>> at host. Here RDMA transport is SoftiWARP, but I'm also seeing the
>>> same issue with NVMe/TCP aswell.
>>>
>>> It appears to me that the same buffer is being rewritten by the
>>> application/ULP before getting the completion for the previous
>requests.
>>> getting the completion for the previous requests. HW based
>>> HW based trasports(like iw_cxgb4) are not showing this issue
>because
>>> they copy/DMA and then compute the CRC on copied buffer.
>> 
>> For TCP we can set BDI_CAP_STABLE_WRITES.  For RDMA I don't think
>that
>> is a good idea as pretty much all RDMA block drivers rely on the
>> DMA behavior above.  The answer is to bounce buffer the data in
>> SoftiWARP / SoftRoCE.
>
>We already do, see nvme_alloc_ns.
>
>

Krishna was getting the issue when testing TCP/NVMeF with -G
during connect. That enables data digest and STABLE_WRITES
I think. So to me it seems we don't get stable pages, but
pages which are touched after handover to the provider.


