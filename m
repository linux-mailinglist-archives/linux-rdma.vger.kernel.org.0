Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7AD1F7B2D
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2020 17:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgFLP4z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Fri, 12 Jun 2020 11:56:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10972 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726089AbgFLP4z (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Jun 2020 11:56:55 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05CF2PYs117703
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jun 2020 11:56:54 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.113])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31mb8mbcep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jun 2020 11:56:54 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Fri, 12 Jun 2020 15:56:54 -0000
Received: from us1b3-smtp03.a3dr.sjc01.isc4sb.com (10.122.7.173)
        by smtp.notes.na.collabserv.com (10.122.47.56) with smtp.notes.na.collabserv.com ESMTP;
        Fri, 12 Jun 2020 15:56:49 -0000
Received: from us1b3-mail163.a3dr.sjc03.isc4sb.com ([10.160.174.69])
          by us1b3-smtp03.a3dr.sjc01.isc4sb.com
          with ESMTP id 2020061215564932-572896 ;
          Fri, 12 Jun 2020 15:56:49 +0000 
In-Reply-To: <20200611170542.GY6578@ziepe.ca>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     "Tom Seewald" <tseewald@gmail.com>, linux-rdma@vger.kernel.org,
        "Doug Ledford" <dledford@redhat.com>
Date:   Fri, 12 Jun 2020 15:56:49 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20200611170542.GY6578@ziepe.ca>,<20200611142355.GX6578@ziepe.ca>
 <20200611113539.GV6578@ziepe.ca> <20200610175008.GU6578@ziepe.ca>
 <20200610174717.15932-1-tseewald@gmail.com>
 <OF2F6FD798.5AF6086F-ON00258584.00329A25-00258584.0038EE32@notes.na.collabserv.com>
 <OFE9B278DF.7F90B863-ON00258584.004CDA7A-00258584.004DFD42@notes.na.collabserv.com>
 <OFD3ED6A67.BCC6E1B8-ON00258584.00526201-00258584.0052F73E@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-KeepSent: 6E70C247:92CAB7FF-00258585:00560750;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 19475
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20061215-7691-0000-0000-00000D2C3F7A
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.001976
X-IBM-SpamModules-Versions: BY=3.00013274; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01390504; UDB=6.00744034; IPR=6.01172771;
 MB=3.00032560; MTD=3.00000008; XFM=3.00000015; UTC=2020-06-12 15:56:52
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-06-12 10:33:05 - 6.00011474
x-cbparentid: 20061215-7692-0000-0000-00001D78419C
Message-Id: <OF6E70C247.92CAB7FF-ON00258585.00560750-00258585.00579977@notes.na.collabserv.com>
Subject: RE: Re: [PATCH next] siw: Fix pointer-to-int-cast warning in siw_rx_pbl()
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-11_23:2020-06-11,2020-06-11 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 06/11/2020 07:05PM
>Cc: "Tom Seewald" <tseewald@gmail.com>, linux-rdma@vger.kernel.org,
>"Doug Ledford" <dledford@redhat.com>
>Subject: [EXTERNAL] Re: Re: [PATCH next] siw: Fix pointer-to-int-cast
>warning in siw_rx_pbl()
>
>On Thu, Jun 11, 2020 at 03:06:12PM +0000, Bernard Metzler wrote:
>> >> It initially comes from the scatterlist provided by the
>> >> kernel user via drivers .map_mr_sg() method. There we get a
>> >> dma_addr_t describing the users buffer.
>> >
>> >For the SW dma maps you have to convert the dma_addr_t to a kva
>using
>> >kmap, it cannot just be casted.
>> >
>> True for a real dma addr. But here the user initially came
>> with an address it got from dma_virt_ops.dma_virt_map_page(),
>> which provides the virtual address of the page referenced,
>> casted to dma_addr_t.
>
>Oh, that's curiously broken on highmem systems, but OK siw is fine
>with it like that, though I think it would have been better to have
>some helper function connected to dma_virt do this cast.
>
>Jason
>
With that, lets take Tom's simple patch for now.

Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>

