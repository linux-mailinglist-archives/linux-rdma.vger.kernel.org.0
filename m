Return-Path: <linux-rdma+bounces-13067-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D168B426F7
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 18:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E76127AA5A3
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Sep 2025 16:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0047307AFC;
	Wed,  3 Sep 2025 16:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iOk1j/60"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA851A9FBE;
	Wed,  3 Sep 2025 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756917118; cv=none; b=S5eZZqZkBzfd3HuOg+nEn5kC4FVFj4tD2XyDpK7cdBefavKQPYIxmZgn5ltr3GPuaWFdMdlbuJ/iWptGbgboOcBQjifzVmbDdox/aXtqBZkOHIw5QOOAK8sP78g4urhBElHfrVNoYaq3K5f5mJRi3gJpahGdgRWBqUW2Sz17yg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756917118; c=relaxed/simple;
	bh=wwIoG7RxiK1rQPRRf6jNppPnqD9cOvuFBLmAMqqLa2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFhL9Zy1OO3ToSLSuJFQhCk7yg55CRjQcGVjNezkXsdCjzRoRB6xsQ5cmhsXNk80E+jROfOtLmY7OWqbK+z/86sv1f5Yehw938dCMQi4dXuL0MIXehLIZlCm04fFvio5QladtLtTdnHeEmWtFZXxSKL23HNdRpKxxaLUqhCoSEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iOk1j/60; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5839MmGV015847;
	Wed, 3 Sep 2025 16:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=uetujjfiFH+oVH/K3yB+je2XLEdDgTeM+7aBa+uNr4s=; b=
	iOk1j/602DlVHP9hoYEDXUaDt5bdVAdKWmBpKIhKnzstdWdUFVP7mxobrAl0mOca
	AbcD3TL7XA+tTek2+1ElSv5L/xVa8VP00ScBvIbE4D76fPfZ/dwliwyy7x098P9j
	scB37far0Yk5oP9WyzTXF7h1a6GrmpmbM4BH96IOpRTcCfH/QQLKN8ro5NJFvS0S
	w8LUipQa2tU2nmczgkrEilqnVu4dIRKidoEbyiQoiAeM5VfqnGQqZ8txhdi5/8cB
	d+LKRzXTaTcW6QiP0B/B6oolAW+U1PZ0sCdq8AsDtXx7qX5NlB8YCnIJe0YTvByL
	PYXvhgMkLpcRoDfDkLdoIw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usm9pwn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 16:31:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 583FvB07036197;
	Wed, 3 Sep 2025 16:31:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrahj04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 16:31:49 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 583GViLm024971;
	Wed, 3 Sep 2025 16:31:48 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqrahht8-2;
	Wed, 03 Sep 2025 16:31:48 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Allison Henderson <allison.henderson@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: stable@vger.kernel.org,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] rds: ib: Remove unused extern definition
Date: Wed,  3 Sep 2025 18:31:37 +0200
Message-ID: <20250903163140.3864215-2-haakon.bugge@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250903163140.3864215-1-haakon.bugge@oracle.com>
References: <20250903163140.3864215-1-haakon.bugge@oracle.com>
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
 definitions=2025-09-03_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509030166
X-Proofpoint-GUID: qOaf8KRoQ79qIhyAEqeLlWPp45D69iY-
X-Authority-Analysis: v=2.4 cv=I7xlRMgg c=1 sm=1 tr=0 ts=68b86d76 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=M51BFTxLslgA:10 a=yPCof4ZbAAAA:8
 a=8vYhr0Zxtxouu-exVa4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX5VAg4Olda5Py
 DrEBxPNonwy1BIDsKv8ApyKUkuBbqFf0rEZkFevhIoPhrQwaE0h/dhcVZfwOoZFl6JbFl4dIkqt
 7ENWSKMRRolxXd+9NUlISsoA+7h5eIFf6WVqc26pvaWXqu9LWcnhAsTo80TBlYef8YjKTq8NqmY
 WAeXZgCGdwphbjUXHE6uLnoM0OXuprnaGtw2OoeIUEJ4/cV1hOVBiGd5A8wvwHDUpqkQeGt0UtH
 8nZAXVkLqXHFPkI9ccGWX5VknRnjhDtHRB8dlU8ocXD0hUIoOetdnUHv+FgwUrFcLTtTYknk1zf
 D3oaRxHqOG4BiYjwZxp53dOsP3ORZ+GiHuZBsKxRxSKGS4G3Ze7ZgS3cS0ScN4lqFCi1c5hpfCy
 TKn7AocQ
X-Proofpoint-ORIG-GUID: qOaf8KRoQ79qIhyAEqeLlWPp45D69iY-

Fixes: 2cb2912d6563 ("RDS: IB: add Fastreg MR (FRMR) detection support")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
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


