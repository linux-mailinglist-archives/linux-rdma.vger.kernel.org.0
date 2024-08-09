Return-Path: <linux-rdma+bounces-4266-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FC994CC4B
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 10:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB3C1C21C71
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Aug 2024 08:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7F919049C;
	Fri,  9 Aug 2024 08:34:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E337161314;
	Fri,  9 Aug 2024 08:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723192448; cv=none; b=OXSH+HGzQ9M/sVVSFnHyHzHHWEPW82BnCKtv3SgHpO7ntX7Bk3dZmtXSSAbDaEqgkAezjRZpDcjNnHMYLV3yuAKUmhx57GwQe7E0YZazSAd5ywcrjq5WMZZFxCot9V2q/lFNzKQBUSD7AItPcXTL9fax3kX7us/yegWbx1OlC2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723192448; c=relaxed/simple;
	bh=EdHOUkQapbsYvW7Pa+mxJXDUYf7diS/nM8cKhTfa670=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G1JI/1UllCJFNKAevlZC8UTl5hexklUbcmiqzOILax4gKykwmAOvfN4dYda1HhcQOkfwITi4TYUGg9+Frlbtf23E9EGVRoDxMDW9LjNyqdOU/y9QESiPc78x65lFo8krjAA/hIAlXFsgyCKC+9Cu6zu2yygtgI7pIOnlrhvoH74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WgHBj6Yrcz1j6Nb;
	Fri,  9 Aug 2024 16:29:17 +0800 (CST)
Received: from kwepemg200003.china.huawei.com (unknown [7.202.181.30])
	by mail.maildlp.com (Postfix) with ESMTPS id 2DBFC1A0188;
	Fri,  9 Aug 2024 16:34:03 +0800 (CST)
Received: from huawei.com (10.175.101.6) by kwepemg200003.china.huawei.com
 (7.202.181.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 9 Aug
 2024 16:34:01 +0800
From: Liu Jian <liujian56@huawei.com>
To: <linux-rdma@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<netdev@vger.kernel.org>
CC: <jgg@ziepe.ca>, <leon@kernel.org>, <zyjzyj2000@gmail.com>,
	<wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<liujian56@huawei.com>
Subject: [PATCH net-next 4/4] RDMA/rxe: Set queue pair cur_qp_state when being queried
Date: Fri, 9 Aug 2024 16:31:48 +0800
Message-ID: <20240809083148.1989912-5-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809083148.1989912-1-liujian56@huawei.com>
References: <20240809083148.1989912-1-liujian56@huawei.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg200003.china.huawei.com (7.202.181.30)

Same with commit e375b9c92985 ("RDMA/cxgb4: Set queue pair state when
 being queried"). The API for ib_query_qp requires the driver to set
cur_qp_state on return, add the missing set.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 drivers/infiniband/sw/rxe/rxe_verbs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
index 5c18f7e342f2..699b4b315336 100644
--- a/drivers/infiniband/sw/rxe/rxe_verbs.c
+++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
@@ -634,6 +634,8 @@ static int rxe_query_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 	rxe_qp_to_init(qp, init);
 	rxe_qp_to_attr(qp, attr, mask);
 
+	attr->cur_qp_state = qp->attr.qp_state;
+
 	return 0;
 }
 
-- 
2.34.1


