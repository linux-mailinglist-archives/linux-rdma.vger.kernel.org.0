Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC841F6A99
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2020 17:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgFKPGT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 11 Jun 2020 11:06:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728414AbgFKPGS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Jun 2020 11:06:18 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05BF37Vi041209
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2020 11:06:17 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [158.85.210.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31kgrycsep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 11 Jun 2020 11:06:17 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Thu, 11 Jun 2020 15:06:16 -0000
Received: from us1b3-smtp01.a3dr.sjc01.isc4sb.com (10.122.7.174)
        by smtp.notes.na.collabserv.com (10.122.47.46) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 11 Jun 2020 15:06:13 -0000
Received: from us1b3-mail162.a3dr.sjc03.isc4sb.com ([10.160.174.187])
          by us1b3-smtp01.a3dr.sjc01.isc4sb.com
          with ESMTP id 2020061115061191-601105 ;
          Thu, 11 Jun 2020 15:06:11 +0000 
In-Reply-To: <20200611142355.GX6578@ziepe.ca>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Jason Gunthorpe" <jgg@ziepe.ca>
Cc:     "Tom Seewald" <tseewald@gmail.com>, linux-rdma@vger.kernel.org,
        "Doug Ledford" <dledford@redhat.com>
Date:   Thu, 11 Jun 2020 15:06:12 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20200611142355.GX6578@ziepe.ca>,<20200611113539.GV6578@ziepe.ca>
 <20200610175008.GU6578@ziepe.ca> <20200610174717.15932-1-tseewald@gmail.com>
 <OF2F6FD798.5AF6086F-ON00258584.00329A25-00258584.0038EE32@notes.na.collabserv.com>
 <OFE9B278DF.7F90B863-ON00258584.004CDA7A-00258584.004DFD42@notes.na.collabserv.com>
X-Mailer: IBM iNotes ($HaikuForm 1054.1) | IBM Domino Build
 SCN1812108_20180501T0841_FP65 April 15, 2020 at 09:48
X-KeepSent: D3ED6A67:BCC6E1B8-00258584:00526201;
 type=4; name=$KeepSent
X-LLNOutbound: False
X-Disclaimed: 4483
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 20061115-3017-0000-0000-000002F33AC6
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.399202; ST=0; TS=0; UL=0; ISC=; MB=0.003026
X-IBM-SpamModules-Versions: BY=3.00013268; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000295; SDB=6.01390012; UDB=6.00743743; IPR=6.01172285;
 MB=3.00032551; MTD=3.00000008; XFM=3.00000015; UTC=2020-06-11 15:06:15
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2020-06-11 07:21:51 - 6.00011470
x-cbparentid: 20061115-3018-0000-0000-00000FCE3C56
Message-Id: <OFD3ED6A67.BCC6E1B8-ON00258584.00526201-00258584.0052F73E@notes.na.collabserv.com>
Subject: RE: Re: [PATCH next] siw: Fix pointer-to-int-cast warning in siw_rx_pbl()
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-11_15:2020-06-11,2020-06-11 signatures=0
X-Proofpoint-Spam-Reason: orgsafe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Jason Gunthorpe" <jgg@ziepe.ca> wrote: -----

>To: "Bernard Metzler" <BMT@zurich.ibm.com>
>From: "Jason Gunthorpe" <jgg@ziepe.ca>
>Date: 06/11/2020 04:24PM
>Cc: "Tom Seewald" <tseewald@gmail.com>, linux-rdma@vger.kernel.org,
>"Doug Ledford" <dledford@redhat.com>
>Subject: [EXTERNAL] Re: Re: [PATCH next] siw: Fix pointer-to-int-cast
>warning in siw_rx_pbl()
>
>On Thu, Jun 11, 2020 at 02:11:51PM +0000, Bernard Metzler wrote:
>> 
>> >To: "Bernard Metzler" <BMT@zurich.ibm.com>
>> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
>> >Date: 06/11/2020 01:35PM
>> >Cc: "Tom Seewald" <tseewald@gmail.com>,
>linux-rdma@vger.kernel.org,
>> >"Doug Ledford" <dledford@redhat.com>
>> >Subject: [EXTERNAL] Re: Re: [PATCH next] siw: Fix
>pointer-to-int-cast
>> >warning in siw_rx_pbl()
>> >
>> >On Thu, Jun 11, 2020 at 10:21:49AM +0000, Bernard Metzler wrote:
>> >> 
>> >> >To: "Tom Seewald" <tseewald@gmail.com>
>> >> >From: "Jason Gunthorpe" <jgg@ziepe.ca>
>> >> >Date: 06/10/2020 07:50PM
>> >> >Cc: linux-rdma@vger.kernel.org, "Bernard Metzler"
>> >> ><bmt@zurich.ibm.com>, "Doug Ledford" <dledford@redhat.com>
>> >> >Subject: [EXTERNAL] Re: [PATCH next] siw: Fix
>pointer-to-int-cast
>> >> >warning in siw_rx_pbl()
>> >> >
>> >> >On Wed, Jun 10, 2020 at 12:47:17PM -0500, Tom Seewald wrote:
>> >> >> The variable buf_addr is type dma_addr_t, which may not be
>the
>> >same
>> >> >size
>> >> >> as a pointer.  To ensure it is the correct size, cast to a
>> >> >uintptr_t.
>> >> >> 
>> >> >> Signed-off-by: Tom Seewald <tseewald@gmail.com>
>> >> >>  drivers/infiniband/sw/siw/siw_qp_rx.c | 3 ++-
>> >> >>  1 file changed, 2 insertions(+), 1 deletion(-)
>> >> >> 
>> >> >> diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c
>> >> >b/drivers/infiniband/sw/siw/siw_qp_rx.c
>> >> >> index 650520244ed0..7271d705f4b0 100644
>> >> >> +++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
>> >> >> @@ -139,7 +139,8 @@ static int siw_rx_pbl(struct
>siw_rx_stream
>> >> >*srx, int *pbl_idx,
>> >> >>  			break;
>> >> >>  
>> >> >>  		bytes = min(bytes, len);
>> >> >> -		if (siw_rx_kva(srx, (void *)buf_addr, bytes) == bytes) {
>> >> >> +		if (siw_rx_kva(srx, (void *)(uintptr_t)buf_addr, bytes) ==
>> >> >> +		    bytes) {
>> >> >
>> >> >How is a dma_addr_t being cast to a void *? That can't be
>right?
>> >> >Bernard??
>> >> >
>> >> >Jason
>> >> >
>> >> Hi Tom, Hi Jason,
>> >> 
>> >> Thanks for looking into that.
>> >> 
>> >> siw_rx_kva() calls skb_copy_bits() to move data to its
>> >> kernel clients destination.  It expects a void * target
>> >> address. This is why I chose it for siw_rx_kva() as well.
>> >> One could say siw_rx_kva() should better get an uintptr_t
>> >> as target argument, which would probably make it look
>> >> more clean. And we rename it to siw_rx_kbuf(), and we
>> >> cast from uintptr_t to (void *) just for
>> >>  skb_copy_bits(skb *, off, (void *)dest, len)
>> >> 
>> >> This would avoid all those nasty (void *) casting at all (!)
>> >> the places we are calling siw_rx_kva().
>> >
>> >But where did the dma_addr_t come from?
>> >
>> It initially comes from the scatterlist provided by the
>> kernel user via drivers .map_mr_sg() method. There we get a
>> dma_addr_t describing the users buffer.
>
>For the SW dma maps you have to convert the dma_addr_t to a kva using
>kmap, it cannot just be casted.
>

True for a real dma addr. But here the user initially came
with an address it got from dma_virt_ops.dma_virt_map_page(),
which provides the virtual address of the page referenced,
casted to dma_addr_t. So we mimic some great dma_addr_t stuff
we do not need for a SW driver and in the end we even have
to call heavy kmap_atomic() to just get the very same addr again.
This I don't want. It's why I just casted it back to void *.
hmmm.

Thanks,
Bernard.

