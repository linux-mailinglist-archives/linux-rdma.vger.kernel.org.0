Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E5A1F69B1
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2020 16:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgFKOL5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 11 Jun 2020 10:11:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18738 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726808AbgFKOL5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Jun 2020 10:11:57 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05BE5l4n152136
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2020 10:11:56 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.93])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31kmv6trrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2020 10:11:56 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Thu, 11 Jun 2020 14:11:55 -0000
Received: from us1a3-smtp01.a3.dal06.isc4sb.com (10.106.154.95)
        by smtp.notes.na.collabserv.com (10.106.227.39) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 11 Jun 2020 14:11:51 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp01.a3.dal06.isc4sb.com
          with ESMTP id 2020061114115053-592189 ;
          Thu, 11 Jun 2020 14:11:50 +0000 
In-Reply-To: <20200611113539.GV6578@ziepe.ca>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     "Tom Seewald" <tseewald@gmail.com>, linux-rdma@vger.kernel.org,
        "Doug Ledford" <dledford@redhat.com>
Date:   Thu, 11 Jun 2020 14:11:51 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20200611113539.GV6578@ziepe.ca>,<20200610175008.GU6578@ziepe.ca>
 <20200610174717.15932-1-tseewald@gmail.com>
 <OF2F6FD798.5AF6086F-ON00258584.00329A25-00258584.0038EE32@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-LLNOutbound: False
X-Disclaimed: 60307
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20061114-8889-0000-0000-000002E44A73
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.003026
X-IBM-SpamModules-Versions: BY=3.00013268; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01389993; UDB=6.00743732; IPR=6.01172266;
 MB=3.00032550; MTD=3.00000008; XFM=3.00000015; UTC=2020-06-11 14:11:54
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-06-11 08:08:35 - 6.00011470
x-cbparentid: 20061114-8890-0000-0000-0000668B4F70
Message-Id: <OFE9B278DF.7F90B863-ON00258584.004CDA7A-00258584.004DFD42@notes.na.collabserv.com>
Subject: RE: Re: [PATCH next] siw: Fix pointer-to-int-cast warning in siw_rx_pbl()
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-11_14:2020-06-11,2020-06-11 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 06/11/2020 01:35PM
>Cc: "Tom Seewald" <tseewald@gmail.com>, linux-rdma@vger.kernel.org,
>"Doug Ledford" <dledford@redhat.com>
>Subject: [EXTERNAL] Re: Re: [PATCH next] siw: Fix pointer-to-int-cast
>warning in siw_rx_pbl()
>
>On Thu, Jun 11, 2020 at 10:21:49AM +0000, Bernard Metzler wrote:
>> 
>> >To: "Tom Seewald" <tseewald@gmail.com>
>> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
>> >Date: 06/10/2020 07:50PM
>> >Cc: linux-rdma@vger.kernel.org, "Bernard Metzler"
>> ><bmt@zurich.ibm.com>, "Doug Ledford" <dledford@redhat.com>
>> >Subject: [EXTERNAL] Re: [PATCH next] siw: Fix pointer-to-int-cast
>> >warning in siw_rx_pbl()
>> >
>> >On Wed, Jun 10, 2020 at 12:47:17PM -0500, Tom Seewald wrote:
>> >> The variable buf_addr is type dma_addr_t, which may not be the
>same
>> >size
>> >> as a pointer.  To ensure it is the correct size, cast to a
>> >uintptr_t.
>> >> 
>> >> Signed-off-by: Tom Seewald <tseewald@gmail.com>
>> >>  drivers/infiniband/sw/siw/siw_qp_rx.c | 3 ++-
>> >>  1 file changed, 2 insertions(+), 1 deletion(-)
>> >> 
>> >> diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c
>> >b/drivers/infiniband/sw/siw/siw_qp_rx.c
>> >> index 650520244ed0..7271d705f4b0 100644
>> >> +++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
>> >> @@ -139,7 +139,8 @@ static int siw_rx_pbl(struct siw_rx_stream
>> >*srx, int *pbl_idx,
>> >>  			break;
>> >>  
>> >>  		bytes = min(bytes, len);
>> >> -		if (siw_rx_kva(srx, (void *)buf_addr, bytes) == bytes) {
>> >> +		if (siw_rx_kva(srx, (void *)(uintptr_t)buf_addr, bytes) ==
>> >> +		    bytes) {
>> >
>> >How is a dma_addr_t being cast to a void *? That can't be right?
>> >Bernard??
>> >
>> >Jason
>> >
>> Hi Tom, Hi Jason,
>> 
>> Thanks for looking into that.
>> 
>> siw_rx_kva() calls skb_copy_bits() to move data to its
>> kernel clients destination.  It expects a void * target
>> address. This is why I chose it for siw_rx_kva() as well.
>> One could say siw_rx_kva() should better get an uintptr_t
>> as target argument, which would probably make it look
>> more clean. And we rename it to siw_rx_kbuf(), and we
>> cast from uintptr_t to (void *) just for
>>  skb_copy_bits(skb *, off, (void *)dest, len)
>> 
>> This would avoid all those nasty (void *) casting at all (!)
>> the places we are calling siw_rx_kva().
>
>But where did the dma_addr_t come from?
>
It initially comes from the scatterlist provided by the
kernel user via drivers .map_mr_sg() method. There we get a
dma_addr_t describing the users buffer.

Thanks,
Bernard.

