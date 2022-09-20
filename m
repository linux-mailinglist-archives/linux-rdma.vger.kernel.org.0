Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68DBD5BDF90
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Sep 2022 10:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiITIN5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Sep 2022 04:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiITINS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Sep 2022 04:13:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AC8A453
        for <linux-rdma@vger.kernel.org>; Tue, 20 Sep 2022 01:12:29 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K7g0lx007303;
        Tue, 20 Sep 2022 08:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=F4ULou7gFTA2xj7rJyi2/MERhISSyduJUBBr6Va3cMk=;
 b=S/HTqbeqkTpVE7xw5JBkE/oqz0shFPRn33g9X+kOBsOeIEnxzyV7t6g8Cz7gUtQVKaVl
 fQpGq1zBVb3TqdciR1qEwmw7T/BnDCyl0yA0wxgaciwWkOL6yIzAKO1YZNO2YQ/mXGHz
 B1JqcfNdwS7es1gSeP7UvnIS7QbDAmu6uuaI3ZNcHHWUQ7rYji0hJ64Qv0CH4subCH8I
 JA6V5ib4nzFYAr1v+lsqUywl6sguuDKOHyqBMGLInroIinLCHO4YYCqARRlaPT8cYuQR
 LoHxDIKN7tds6Fbk6mBeEON+Jw7rrmca2v7jJD31GeywuBQX4Tp26xrkMtkWyImbPmCy pg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jq9br8yuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 08:12:26 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28K869Zn019055;
        Tue, 20 Sep 2022 08:12:24 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3jn5v8jkhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 08:12:23 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28K88NRR40829190
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 08:08:23 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAAA742042;
        Tue, 20 Sep 2022 08:12:21 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D3C84203F;
        Tue, 20 Sep 2022 08:12:21 +0000 (GMT)
Received: from rims.zurich.ibm.com (unknown [9.4.69.56])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 20 Sep 2022 08:12:21 +0000 (GMT)
From:   Bernard Metzler <bmt@zurich.ibm.com>
To:     linux-rdma@vger.kernel.org
Cc:     jgg@nvidia.com, leonro@nvidia.com,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Olga Kornievskaia <kolga@netapp.com>
Subject: [PATCH] RDMA/siw: Always consume all skbuf data in sk_data_ready() upcall.
Date:   Tue, 20 Sep 2022 10:12:02 +0200
Message-Id: <20220920081202.223629-1-bmt@zurich.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sFL4RPperYt4x0XSNW8Vh6ZZNWM8KokM
X-Proofpoint-ORIG-GUID: sFL4RPperYt4x0XSNW8Vh6ZZNWM8KokM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_02,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

For header and trailer/padding processing, siw did not consume new
skb data until minimum amount present to fill current header or trailer
structure, including potential payload padding. Not consuming any
data during upcall may cause a receive stall, since tcp_read_sock()
is not upcalling again if no new data arrive.
A NFSoRDMA client got stuck at RDMA Write reception of unaligned
payload, if the current skb did contain only the expected 3 padding
bytes, but not the 4 bytes CRC trailer. Expecting 4 more bytes already
arrived in another skb, and not consuming those 3 bytes in the current
upcall left the Write incomplete, waiting for the CRC forever.

Fixes: 8b6a361b8c48 ("rdma/siw: receive path")

Reported-by: Olga Kornievskaia <kolga@netapp.com>
Tested-by: Olga Kornievskaia <kolga@netapp.com>
Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
---
 drivers/infiniband/sw/siw/siw_qp_rx.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index 875ea6f1b04a..fd721cc19682 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -961,27 +961,28 @@ int siw_proc_terminate(struct siw_qp *qp)
 static int siw_get_trailer(struct siw_qp *qp, struct siw_rx_stream *srx)
 {
 	struct sk_buff *skb = srx->skb;
+	int avail = min(srx->skb_new, srx->fpdu_part_rem);
 	u8 *tbuf = (u8 *)&srx->trailer.crc - srx->pad;
 	__wsum crc_in, crc_own = 0;
 
 	siw_dbg_qp(qp, "expected %d, available %d, pad %u\n",
 		   srx->fpdu_part_rem, srx->skb_new, srx->pad);
 
-	if (srx->skb_new < srx->fpdu_part_rem)
-		return -EAGAIN;
-
-	skb_copy_bits(skb, srx->skb_offset, tbuf, srx->fpdu_part_rem);
+	skb_copy_bits(skb, srx->skb_offset, tbuf, avail);
 
-	if (srx->mpa_crc_hd && srx->pad)
-		crypto_shash_update(srx->mpa_crc_hd, tbuf, srx->pad);
+	srx->skb_new -= avail;
+	srx->skb_offset += avail;
+	srx->skb_copied += avail;
+	srx->fpdu_part_rem -= avail;
 
-	srx->skb_new -= srx->fpdu_part_rem;
-	srx->skb_offset += srx->fpdu_part_rem;
-	srx->skb_copied += srx->fpdu_part_rem;
+	if (srx->fpdu_part_rem)
+		return -EAGAIN;
 
 	if (!srx->mpa_crc_hd)
 		return 0;
 
+	if (srx->pad)
+		crypto_shash_update(srx->mpa_crc_hd, tbuf, srx->pad);
 	/*
 	 * CRC32 is computed, transmitted and received directly in NBO,
 	 * so there's never a reason to convert byte order.
@@ -1083,10 +1084,9 @@ static int siw_get_hdr(struct siw_rx_stream *srx)
 	 * completely received.
 	 */
 	if (iwarp_pktinfo[opcode].hdr_len > sizeof(struct iwarp_ctrl_tagged)) {
-		bytes = iwarp_pktinfo[opcode].hdr_len - MIN_DDP_HDR;
+		int hdrlen = iwarp_pktinfo[opcode].hdr_len;
 
-		if (srx->skb_new < bytes)
-			return -EAGAIN;
+		bytes = min_t(int, hdrlen - MIN_DDP_HDR, srx->skb_new);
 
 		skb_copy_bits(skb, srx->skb_offset,
 			      (char *)c_hdr + srx->fpdu_part_rcvd, bytes);
@@ -1096,6 +1096,9 @@ static int siw_get_hdr(struct siw_rx_stream *srx)
 		srx->skb_new -= bytes;
 		srx->skb_offset += bytes;
 		srx->skb_copied += bytes;
+
+		if (srx->fpdu_part_rcvd < hdrlen)
+			return -EAGAIN;
 	}
 
 	/*
-- 
2.32.0

