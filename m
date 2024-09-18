Return-Path: <linux-rdma+bounces-4983-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E7297B970
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Sep 2024 10:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F3F91F25144
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Sep 2024 08:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C45317ADF6;
	Wed, 18 Sep 2024 08:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HoJZhTjy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E93C176FBD;
	Wed, 18 Sep 2024 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726648574; cv=none; b=rUgjselwXs7HNiPgmVnoVwmts85mGIlPDhHRld3P8XbwwQ/WV+w+1aFXM+40YyQ/bhZ4nm3eH18mFDCVNohpNfvk1Zjw/s+c5G+RfkNOKWyLF5JADfDhfSPXXR1P5dWxgfP9EzK5qWwMEbcPfvWnzq0HCrdFpjuyesW/rYEw0XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726648574; c=relaxed/simple;
	bh=paGxOo8rTLSZFeKKZm/jIgHewVqTk/eu33ao1YKPDTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRihUd9crutv2/jtlNSJ8yGmz0m7CHvURhqfB8P+mwK96ARuxEte00vw3cY1G+C66fuCKR852NedpjROURZFwq+vvq9pnAwHG06qKrAfQoVbhlrnRbnq7tVEShG8xMWH5cnOoLbrpJc2A4wpWwGDT7u/eygCrVh2FfvXGOB3OoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HoJZhTjy; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48I7u7qC022250;
	Wed, 18 Sep 2024 08:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type:content-transfer-encoding; s=
	corp-2023-11-20; bh=MlawQVvnOFoj7lyUkDcFz2aMZ6uq5jG66mYF94ynjaU=; b=
	HoJZhTjyVr7tiFRWtTwWa0RwmOUZOUQrqYllLcuL6d2CVfJrWvNInzvwR8e5UCg7
	xRYZUXUQnI4IvnJ9j1DKjMdCiskHhvNZT+fgc2jmJbH/pMuHORjbbjF+p3A6D4+B
	GyF+5jA4I3ETaYP+RZaEV8fVCBdHUbe04cqMbivDVYMRAUxVsDHblUdY7vamx8F6
	6g7bh4VI5cP1pKRwW2+LaNr0diAD5IF0UpX6F8/WwzGQpTTf+fqSITOqGQPuBlX5
	sGYAhriDP6apJ0/r0tzRdmNHNyNDI8SgrAERSZ7LO8VH7fO+giho+S3jMS5rqVCS
	i9lurrtWzf0bfFgIbp4Ahw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3sd0pap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 08:36:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48I7P6X0010398;
	Wed, 18 Sep 2024 08:36:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nyb7yt55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 08:36:03 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 48I8Zu4B022467;
	Wed, 18 Sep 2024 08:36:02 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 41nyb7ystx-3;
	Wed, 18 Sep 2024 08:36:02 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Allison Henderson <allison.henderson@oracle.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, rds-devel@oss.oracle.com
Subject: [MAINLINE 2/2] rds: ib: Add Dynamic Interrupt Moderation to CQs
Date: Wed, 18 Sep 2024 10:35:52 +0200
Message-ID: <20240918083552.77531-3-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240918083552.77531-1-haakon.bugge@oracle.com>
References: <20240918083552.77531-1-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-18_06,2024-09-16_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409180053
X-Proofpoint-ORIG-GUID: Er6aC43qNf_iuriETv9reMtU3vz_rDQJ
X-Proofpoint-GUID: Er6aC43qNf_iuriETv9reMtU3vz_rDQJ

With the support from ib_core to use Dynamic Interrupt Moderation
(DIM) from legacy ULPs, which uses ib_create_cq(), we enable that
feature for the receive and send CQs in RDS.

A set of rds-stress runs have been done. bcopy read + write for
payload 8448 and 16640 bytes and ack/req of 256 bytes. Number of QPs
varies from 8 to 128, number of threads (i.e. rds-stress processes)
from one to 16 and a depth of four. A limit has been applied such that
the number of processes times the number of QPs never exceeds 128. All
in all, 61 rds-stress runs.

For brevity, only the rows showing a +/- 3% deviation or larger from
base is listed. The geometric mean of the ratios (IOPS_test /
IOPS_base) is calculated for all 61 runs, and that gives the best
possible "average" impact of the commits.

In the following, "base" is v6.11-rc7. "test" is the same
kernel with the following two commits:

       * rds: ib: Add Dynamic Interrupt Moderation to CQs (this commit)
       * RDMA/core: Enable legacy ULPs to use RDMA DIM

This is executed between two X8-2 with CX-5 using fw 16.35.3502. These
BM systems were instantiated with one VF, which were used for the
test:

                                 base     test
   ACK    REQ  QPS  THR  DEP     IOPS     IOPS  Percent
   256   8448    8    1    4   634463   658162      3.7
   256   8448    8    2    4   862648   997358     15.6
   256   8448    8    4    4   950458  1113991     17.2
   256   8448    8    8    4   932120  1127024     20.9
   256   8448    8   16    4   944977  1133885     20.0
  8448    256    8    2    4   858663   975563     13.6
  8448    256    8    4    4   934884  1098854     17.5
  8448    256    8    8    4   928247  1116015     20.2
  8448    256    8   16    4   938864  1123455     19.7
   256   8448   64    1    4   965985   918445     -4.9
  8448    256   64    1    4   963280   918239     -4.7
   256  16640    8    2    4   544670   582330      6.9
   256  16640    8    4    4   554873   597553      7.7
   256  16640    8    8    4   551799   597479      8.3
   256  16640    8   16    4   553041   597898      8.1
 16640    256    8    2    4   544644   578331      6.2
 16640    256    8    4    4   553944   594627      7.3
 16640    256    8    8    4   551388   594737      7.9
 16640    256    8   16    4   552986   596581      7.9
Geometric mean of ratios: 1.03

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 net/rds/ib_cm.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/rds/ib_cm.c b/net/rds/ib_cm.c
index 26b069e1999df..79603d86b6c02 100644
--- a/net/rds/ib_cm.c
+++ b/net/rds/ib_cm.c
@@ -259,6 +259,7 @@ static void rds_ib_cq_comp_handler_recv(struct ib_cq *cq, void *context)
 static void poll_scq(struct rds_ib_connection *ic, struct ib_cq *cq,
 		     struct ib_wc *wcs)
 {
+	int ncompleted = 0;
 	int nr, i;
 	struct ib_wc *wc;
 
@@ -276,7 +277,10 @@ static void poll_scq(struct rds_ib_connection *ic, struct ib_cq *cq,
 				rds_ib_mr_cqe_handler(ic, wc);
 
 		}
+		ncompleted += nr;
 	}
+	if (cq->dim)
+		rdma_dim(cq->dim, ncompleted);
 }
 
 static void rds_ib_tasklet_fn_send(unsigned long data)
@@ -304,6 +308,7 @@ static void poll_rcq(struct rds_ib_connection *ic, struct ib_cq *cq,
 		     struct ib_wc *wcs,
 		     struct rds_ib_ack_state *ack_state)
 {
+	int ncompleted = 0;
 	int nr, i;
 	struct ib_wc *wc;
 
@@ -316,7 +321,10 @@ static void poll_rcq(struct rds_ib_connection *ic, struct ib_cq *cq,
 
 			rds_ib_recv_cqe_handler(ic, wc, ack_state);
 		}
+		ncompleted += nr;
 	}
+	if (cq->dim)
+		rdma_dim(cq->dim, ncompleted);
 }
 
 static void rds_ib_tasklet_fn_recv(unsigned long data)
@@ -542,6 +550,7 @@ static int rds_ib_setup_qp(struct rds_connection *conn)
 	ic->i_scq_vector = ibdev_get_unused_vector(rds_ibdev);
 	cq_attr.cqe = ic->i_send_ring.w_nr + fr_queue_space + 1;
 	cq_attr.comp_vector = ic->i_scq_vector;
+	cq_attr.flags |= IB_CQ_MODERATE;
 	ic->i_send_cq = ib_create_cq(dev, rds_ib_cq_comp_handler_send,
 				     rds_ib_cq_event_handler, conn,
 				     &cq_attr);
@@ -556,6 +565,7 @@ static int rds_ib_setup_qp(struct rds_connection *conn)
 	ic->i_rcq_vector = ibdev_get_unused_vector(rds_ibdev);
 	cq_attr.cqe = ic->i_recv_ring.w_nr;
 	cq_attr.comp_vector = ic->i_rcq_vector;
+	cq_attr.flags |= IB_CQ_MODERATE;
 	ic->i_recv_cq = ib_create_cq(dev, rds_ib_cq_comp_handler_recv,
 				     rds_ib_cq_event_handler, conn,
 				     &cq_attr);
-- 
2.43.5


