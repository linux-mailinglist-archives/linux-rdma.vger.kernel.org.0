Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA0D9500A
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 23:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbfHSVod convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Mon, 19 Aug 2019 17:44:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728283AbfHSVod (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 17:44:33 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JLb91O041245
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 17:44:30 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ug39us7y8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Mon, 19 Aug 2019 17:44:30 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Mon, 19 Aug 2019 21:44:29 -0000
Received: from us1a3-smtp07.a3.dal06.isc4sb.com (10.146.103.14)
        by smtp.notes.na.collabserv.com (10.106.227.158) with smtp.notes.na.collabserv.com ESMTP;
        Mon, 19 Aug 2019 21:44:23 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp07.a3.dal06.isc4sb.com
          with ESMTP id 2019081921442256-980298 ;
          Mon, 19 Aug 2019 21:44:22 +0000 
In-Reply-To: <20190819111338.9366-1-krishna2@chelsio.com>
Subject: Re: [PATCH for-rc] siw: fix for 'is_kva' flag issue in siw_tx_hdt()
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Krishnamraju Eraparaju" <krishna2@chelsio.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com
Date:   Mon, 19 Aug 2019 21:44:22 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190819111338.9366-1-krishna2@chelsio.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 21575
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19081921-1335-0000-0000-00000112C828
X-IBM-SpamModules-Scores: BY=0.002683; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.425523; ST=0; TS=0; UL=0; ISC=; MB=0.007096
X-IBM-SpamModules-Versions: BY=3.00011620; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01249232; UDB=6.00659451; IPR=6.01030767;
 MB=3.00028239; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-19 21:44:27
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-19 19:17:40 - 6.00010305
x-cbparentid: 19081921-1336-0000-0000-000002BC0C39
Message-Id: <OFB7456B6B.E1C4D049-ON0025845B.00533DDF-0025845B.00776B49@notes.na.collabserv.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----

>To: jgg@ziepe.ca, bmt@zurich.ibm.com
>From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>Date: 08/19/2019 01:14PM
>Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com,
>nirranjan@chelsio.com, "Krishnamraju Eraparaju"
><krishna2@chelsio.com>
>Subject: [EXTERNAL] [PATCH for-rc] siw: fix for 'is_kva' flag issue
>in siw_tx_hdt()
>
>"is_kva" variable in siw_tx_hdt() is not currently being updated for
>each while loop iteration(the loop which walks the list of SGE's).
>
>Usecase:
>
>say a WQE has two SGE's :
> - first with "assigned kernel buffer", so not MR allocated.
> - second with PBL memory region, so mem_obj == PBL.
>
>Now while processing first SGE, in iteration 1, "is_kva" is set to
>"1"
>because there is no MR allocated.
>And while processing the second SGE in iteration 2, since mem_obj is
>PBL, the statement "if (!mem->mem_obj)" becomes false but is_kva is
>still "1"(previous state). Thus, the PBL memory is handled as "direct
>assigned kernel virtual memory", which eventually results in PAGE
>FAULTS, MPA CRC issues.
>
>                if (!(tx_flags(wqe) & SIW_WQE_INLINE)) {
>                        mem = wqe->mem[sge_idx];
>                        if (!mem->mem_obj)
>                                is_kva = 1;
>                } else {
>                        is_kva = 1;
>                }
>

Hi Krishna,
That is a good catch. I was not aware of the possibility of mixed
PBL and kernel buffer addresses in one SQE.

A correct fix must also handle the un-mapping of any kmap()'d
buffers. The current TX code expects all buffers be either kmap()'d or
all not kmap()'d. So the fix is a little more complex, if we must
handle mixed SGL's during un-mapping. I think I can provide it by
tomorrow. It's almost midnight ;)

Thanks!
Bernard.

>Note that you need to set MTU size more than the PAGESIZE to recreate
>this issue(as the address of "PBL index 0" and "assigned kernel
>virtual memory" are always same for SIW). In my case, I used SIW
>as ISER initiator with MTU 9000, issue occurs with
>SCSI WRITE operation.
>
>Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
>---
> drivers/infiniband/sw/siw/siw_qp_tx.c | 2 ++
> 1 file changed, 2 insertions(+)
>
>diff --git a/drivers/infiniband/sw/siw/siw_qp_tx.c
>b/drivers/infiniband/sw/siw/siw_qp_tx.c
>index 43020d2040fc..e2175a08269a 100644
>--- a/drivers/infiniband/sw/siw/siw_qp_tx.c
>+++ b/drivers/infiniband/sw/siw/siw_qp_tx.c
>@@ -465,6 +465,8 @@ static int siw_tx_hdt(struct siw_iwarp_tx *c_tx,
>struct socket *s)
> 			mem = wqe->mem[sge_idx];
> 			if (!mem->mem_obj)
> 				is_kva = 1;
>+			else
>+				is_kva = 0;
> 		} else {
> 			is_kva = 1;
> 		}
>-- 
>2.23.0.rc0
>
>

