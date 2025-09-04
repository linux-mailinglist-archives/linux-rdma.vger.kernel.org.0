Return-Path: <linux-rdma+bounces-13090-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A48B43FD7
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 17:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439041BC417F
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 15:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EEA305043;
	Thu,  4 Sep 2025 15:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n8DQcUVM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7661DF75A;
	Thu,  4 Sep 2025 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998085; cv=none; b=uZ2KVSsI1ojVPcG8ImoFhER7WxEVSNWiTmRsrpigpI5VuV4kMJ4JpjXFErLxrsbj6qQGKk22p/CS+A2Ub8pRZGrC0C47mokhdexwfRw0CR+qAd+tHjPhbMMvQtAzm2VJbf4tXyuzJGoe/RtY3ebc67dAlEriyhXH0RyQeTeNIes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998085; c=relaxed/simple;
	bh=l9JRa4X4F7x+/30IpIHfnpxeHKhZluyQDJO44iIji0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gFA1QHD6iZF+/lSDIDsBFQd28YzkNKT3F30ykqMWnAmKqLD9fmGLQE4pVAEON7wlq/HFngvN5XZqe74Uc1gUHlvOcRS1jYqa8NRKr4kWKCmWZ3TPlu5tkjl4OGthR2kgr/nffKxfJpjHTHeXkxaj1yNjr/GvZs1uPLgnPOQQ6P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n8DQcUVM; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584EtqXm027829;
	Thu, 4 Sep 2025 15:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=mbD0BssDocPQ0T17
	ewmMm3en4cOLmF13gbBhmgWv6Mk=; b=n8DQcUVMLwqvHRrYWtALWg+XhHdizsnV
	hkMjIgLpbQvJnujFu43kytIq9UTQOv+DLXtfbr/k690ZzHxcv9W8GGvjM4v1zdlg
	CqnuTb9sUq9SE5+MRyHnZFuvr8Pb/yi783FO4Iobjqhi8PkXG1XRjwZV+C7wcZZI
	PC5/6aJTXATuyCVM7ErCmRzcPfJ2ImeKls+FksRpViDMNDQtw2EcP+Fedtuo7mQp
	6BaQ+pZHqoPuxS1nlz3pNMQEDP/eNzK5ky+mowVkI9IRyXoN7nPjt+lEsVbyhOOU
	xuLBN40M/Jz9ZtV3PbUCRRZS8QHgdBuzx/6jWCTVAyKu4kJmiT47SQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ycgn02q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 15:01:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 584EFIAl036336;
	Thu, 4 Sep 2025 15:01:10 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrbnj2s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Sep 2025 15:01:10 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 584EwW3A013524;
	Thu, 4 Sep 2025 15:01:09 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqrbnj17-1;
	Thu, 04 Sep 2025 15:01:09 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Allison Henderson <allison.henderson@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] rds: ib: Remove unused extern definition
Date: Thu,  4 Sep 2025 17:01:04 +0200
Message-ID: <20250904150105.3954918-1-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_05,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509040148
X-Authority-Analysis: v=2.4 cv=evbfzppX c=1 sm=1 tr=0 ts=68b9a9b7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=M51BFTxLslgA:10 a=yPCof4ZbAAAA:8
 a=VwQbUJbxAAAA:8 a=vqxsdnOqdfS0dGDShygA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5fHTU7woyNNIbJUHD3puzsjcJ9uiBguW
X-Proofpoint-ORIG-GUID: 5fHTU7woyNNIbJUHD3puzsjcJ9uiBguW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE0MiBTYWx0ZWRfX+Qe8yCiPCWUX
 UIZ2GJzZmM10cTk1G7HEVzdcT1PbFUofpd6EvxEpbVAwIth+mX0iZz6KALbXECxu31Ghd6MUpfq
 8RqL9uilOlBZHm+3nJEw8W30I26usWpoIbVOjHwEUn/vve7sfCrWwDbbFmuxCsHKw6njaz+moOd
 /YVGQDm09NzniIxJAJNSpDh3swS52Hq7bQmwrG/35surzkx+WH30PySk+QBxY125Nc8jmw0tECR
 Lw6Wsh9ERkFWigRBJWx+ogrnj0uH7TSCnX4HJJbEyScOoJdWUKokzRQcMXi0oHpxJu3z1jyxXV3
 IBD1nTGeyzQLxeq4OTNCp5O9U9g8iLkO/yXk6aiOk/VTKz3UVTYOO5x3LFsHVLNIuRsjfKAQaxT
 tmHpaEhR

In the old days, RDS used FMR (Fast Memory Registration) to register
IB MRs to be used by RDMA. A newer and better verbs based
registration/de-registration method called FRWR (Fast Registration
Work Request) was added to RDS by commit 1659185fb4d0 ("RDS: IB:
Support Fastreg MR (FRMR) memory registration mode") in 2016.

Detection and enablement of FRWR was done in commit 2cb2912d6563
("RDS: IB: add Fastreg MR (FRMR) detection support"). But said commit
added an extern bool prefer_frmr, which was not used by said commit -
nor used by later commits. Hence, remove it.

Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>

---

	v2 -> v3:
	      * As per Jakub's request, removed Cc: and Fixes: tags
	      * Subject to net-next (instead of net)

	v1 -> v2:
	      * Added commit message
	      * Added Cc: stable@vger.kernel.org
---
 net/rds/ib_mr.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/rds/ib_mr.h b/net/rds/ib_mr.h
index ea5e9aee4959e..5884de8c6f45b 100644
--- a/net/rds/ib_mr.h
+++ b/net/rds/ib_mr.h
@@ -108,7 +108,6 @@ struct rds_ib_mr_pool {
 };
 
 extern struct workqueue_struct *rds_ib_mr_wq;
-extern bool prefer_frmr;
 
 struct rds_ib_mr_pool *rds_ib_create_mr_pool(struct rds_ib_device *rds_dev,
 					     int npages);
-- 
2.43.5


