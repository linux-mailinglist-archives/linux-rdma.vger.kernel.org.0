Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF89A7D9B7
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 12:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbfHAK4s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-rdma@lfdr.de>); Thu, 1 Aug 2019 06:56:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46248 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726783AbfHAK4s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Aug 2019 06:56:48 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x71ArAlw034533
        for <linux-rdma@vger.kernel.org>; Thu, 1 Aug 2019 06:56:46 -0400
Received: from smtp.notes.na.collabserv.com (smtp.notes.na.collabserv.com [192.155.248.67])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u3uc3s9jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-rdma@vger.kernel.org>; Thu, 01 Aug 2019 06:56:46 -0400
Received: from localhost
        by smtp.notes.na.collabserv.com with smtp.notes.na.collabserv.com ESMTP
        for <linux-rdma@vger.kernel.org> from <BMT@zurich.ibm.com>;
        Thu, 1 Aug 2019 10:56:45 -0000
Received: from us1a3-smtp07.a3.dal06.isc4sb.com (10.146.103.14)
        by smtp.notes.na.collabserv.com (10.106.227.16) with smtp.notes.na.collabserv.com ESMTP;
        Thu, 1 Aug 2019 10:56:39 -0000
Received: from us1a3-mail162.a3.dal06.isc4sb.com ([10.146.71.4])
          by us1a3-smtp07.a3.dal06.isc4sb.com
          with ESMTP id 2019080110563357-323722 ;
          Thu, 1 Aug 2019 10:56:33 +0000 
In-Reply-To: <20190731103310.23199-1-krishna2@chelsio.com>
From:   "Bernard Metzler" <BMT@zurich.ibm.com>
To:     "Krishnamraju Eraparaju" <krishna2@chelsio.com>
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com, krishn2@chelsio.com
Date:   Thu, 1 Aug 2019 10:56:33 +0000
MIME-Version: 1.0
Sensitivity: 
Importance: Normal
X-Priority: 3 (Normal)
References: <20190731103310.23199-1-krishna2@chelsio.com>
X-Mailer: IBM iNotes ($HaikuForm 1054) | IBM Domino Build
 SCN1812108_20180501T0841_FP55 May 22, 2019 at 11:09
X-LLNOutbound: False
X-Disclaimed: 7047
X-TNEFEvaluated: 1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
x-cbid: 19080110-7279-0000-0000-000000150626
X-IBM-SpamModules-Scores: BY=0; FL=0; FP=0; FZ=0; HX=0; KW=0; PH=0;
 SC=0.40962; ST=0; TS=0; UL=0; ISC=; MB=0.261513
X-IBM-SpamModules-Versions: BY=3.00011534; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01240500; UDB=6.00654154; IPR=6.01021924;
 MB=3.00027993; MTD=3.00000008; XFM=3.00000015; UTC=2019-08-01 10:56:43
X-IBM-AV-DETECTION: SAVI=unsuspicious REMOTE=unsuspicious XFE=unused
X-IBM-AV-VERSION: SAVI=2019-08-01 04:49:17 - 6.00010234
x-cbparentid: 19080110-7280-0000-0000-000000200604
Message-Id: <OF4DB6F345.7C76F976-ON00258449.00392FF3-00258449.003C1BFB@notes.na.collabserv.com>
Subject: Re:  [PATCH for-rc] siw: MPA Reply handler tries to read beyond MPA message
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-01_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-----"Krishnamraju Eraparaju" <krishna2@chelsio.com> wrote: -----

>To: jgg@ziepe.ca, bmt@zurich.ibm.com
>From: "Krishnamraju Eraparaju" <krishna2@chelsio.com>
>Date: 07/31/2019 12:34PM
>Cc: linux-rdma@vger.kernel.org, bharat@chelsio.com,
>nirranjan@chelsio.com, krishn2@chelsio.com, "Krishnamraju Eraparaju"
><krishna2@chelsio.com>
>Subject: [EXTERNAL] [PATCH for-rc] siw: MPA Reply handler tries to
>read beyond MPA message
>
>while processing MPA Reply, SIW driver is trying to read extra 4
>bytes
>than what peer has advertised as private data length.
>
>If a FPDU data is received before even siw_recv_mpa_rr() completed
>reading MPA reply, then ksock_recv() in siw_recv_mpa_rr() could also
>read FPDU, if "size" is larger than advertised MPA reply length.
>
> 501 static int siw_recv_mpa_rr(struct siw_cep *cep)
> 502 {
>          .............
> 572
> 573         if (rcvd > to_rcv)
> 574                 return -EPROTO;   <----- Failure here
>
>Looks like the intention here is to throw an ERROR if the received
>data
>is more than the total private data length advertised by the peer.
>But
>reading beyond MPA message causes siw_cm to generate
>RDMA_CM_EVENT_CONNECT_ERROR event when TCP socket recv buffer is
>already
>queued with FPDU messages.
>
>Hence, this function should only read upto private data length.
>
>Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
>---
> drivers/infiniband/sw/siw/siw_cm.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/infiniband/sw/siw/siw_cm.c
>b/drivers/infiniband/sw/siw/siw_cm.c
>index a7cde98e73e8..8dc8cea2566c 100644
>--- a/drivers/infiniband/sw/siw/siw_cm.c
>+++ b/drivers/infiniband/sw/siw/siw_cm.c
>@@ -559,13 +559,13 @@ static int siw_recv_mpa_rr(struct siw_cep *cep)
> 	 * A private data buffer gets allocated if hdr->params.pd_len != 0.
> 	 */
> 	if (!cep->mpa.pdata) {
>-		cep->mpa.pdata = kmalloc(pd_len + 4, GFP_KERNEL);
>+		cep->mpa.pdata = kmalloc(pd_len, GFP_KERNEL);
> 		if (!cep->mpa.pdata)
> 			return -ENOMEM;
> 	}
> 	rcvd = ksock_recv(
> 		s, cep->mpa.pdata + cep->mpa.bytes_rcvd - sizeof(struct mpa_rr),
>-		to_rcv + 4, MSG_DONTWAIT);
>+		to_rcv, MSG_DONTWAIT);
> 
> 	if (rcvd < 0)
> 		return rcvd;
>-- 
>2.23.0.rc0
>
>

The intention of this code is to make sure the
peer does not violates the MPA handshake rules.
The initiator MUST NOT send extra data after its
MPA request and before receiving the MPA reply.
So, for the MPA request case, this code is needed
to check for protocol correctness.
You are right for the MPA reply case - if we are
_not_ in peer2peer mode, the peer can immediately
start sending data in RDMA mode after its MPA Reply.
So we shall add appropriate code to be more specific
For an error, we are (1) processing an MPA Request,
OR (2) processing an MPA Reply AND we are not expected
to send an initial READ/WRITE/Send as negotiated with
the peer (peer2peer mode MPA handshake).

Just removing this check would make siw more permissive,
but to a point where peer MPA protocol errors are
tolerated. I am not in favor of that level of
forgiveness.

If possible, please provide an appropriate patch
or (if it causes current issues with another peer
iWarp implementation) just run in MPA peer2peer mode,
where the current check is appropriate.
Otherwise, I would provide an appropriate fix by Monday
(I am still out of office this week).


Many thanks and best regards,
Bernard.

