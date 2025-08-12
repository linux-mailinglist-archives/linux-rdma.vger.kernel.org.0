Return-Path: <linux-rdma+bounces-12681-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA82B228D8
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Aug 2025 15:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 889607ACBE4
	for <lists+linux-rdma@lfdr.de>; Tue, 12 Aug 2025 13:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9746F284685;
	Tue, 12 Aug 2025 13:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p98iTFt3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0971283FF9;
	Tue, 12 Aug 2025 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005899; cv=none; b=UChV0doGEQt+d6IEHb02hyhGjQ7BtTewYfOKN4yXT+OKagixK/v8V+uIu2gcImVtxvHol4Bn4Wt7KVxib3b3JJvc3WTD18dsgDiZPI5aHpzvNEA2GmbMvSu+3orYXhEAyuXE3K5ztKIYMH5IXc7KMUZ6p9wOWOhN/zxUaWcHNPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005899; c=relaxed/simple;
	bh=imV7b4UP9YOqwMWeDPJrmKgiEYw5acjq79crUATKb88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U7cIFrSz3R8Iih7+28IJ8B5COD2XDqkoxj9GiTqAMtDqc60BI9d0QgID65rrYRk14pXy9cLpPtjmeDCx+wJt095AGO04bVYlTrySxALL2B3vsZ2nO8QwqTUudNFgeaEK8Z8NaUVfN+GsGnncvgV5IfZj5ZhLCT1GjPWQVUVXy2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=p98iTFt3; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDC0KD002299;
	Tue, 12 Aug 2025 13:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=Mv8SzysNn4x/kdJ4
	QzIJ1m2INGzhzbl9DhFwnVj399g=; b=p98iTFt31dPKEu7CsVZ9hWK797uKXZ5x
	1IoFCQjr6rxGnATIxAUh4H2XAqhxlJmqR89ThGIHyjDZ97h72mrCWzn/EDQgBBMG
	Q9tNRJ4oebj6hRI4M/FZ4dtDuRNEF8hpTEQihrxX27Q21lbdvTEz54P+9BrxWOAf
	VDcLVoPJN1wAceU5jg4ho2sMN28lo4+wcr+ukKLb/l9f2+OJf5gV85QLx3eTOIdi
	juS955ahKztFHYI7UUDh0r8uB4cjFfOJ8H67N8WmuI1wD1xBTnR7D9iYDWvDO7rA
	7fWoi6oosOxRGYixDNl5uIturxqyO5hC/XsZbVOvVoNcg5O972YN/A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvrfvqqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 13:37:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDHjdS006371;
	Tue, 12 Aug 2025 13:37:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs9s1j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 13:37:47 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57CDbkIi022945;
	Tue, 12 Aug 2025 13:37:47 GMT
Received: from lab61.no.oracle.com (lab61.no.oracle.com [10.172.144.82])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48dvs9s1gy-1;
	Tue, 12 Aug 2025 13:37:46 +0000
From: =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Chiara Meiohas <cmeiohas@nvidia.com>,
        Michael Guralnik <michaelgur@nvidia.com>,
        Mark Bloch <mbloch@nvidia.com>, Yuyu Li <liyuyu6@huawei.com>,
        Patrisious Haddad <phaddad@nvidia.com>,
        Zhu Yanjun <yanjun.zhu@linux.dev>, Yishai Hadas <yishaih@nvidia.com>,
        Parav Pandit <parav@nvidia.com>,
        "Dr. David Alan Gilbert" <linux@treblig.org>,
        Wang Liang <wangliang74@huawei.com>
Cc: stable@vger.kernel.org,
        =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>,
        Junxian Huang <huangjunxian6@hisilicon.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next 1/1] RDMA/core: Fix socket leak in rdma_dev_init_net
Date: Tue, 12 Aug 2025 15:37:38 +0200
Message-ID: <20250812133743.1788579-1-haakon.bugge@oracle.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508120131
X-Authority-Analysis: v=2.4 cv=B/S50PtM c=1 sm=1 tr=0 ts=689b43ac b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=M51BFTxLslgA:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=1hMgfw760xSgy0LFDooA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13600
X-Proofpoint-ORIG-GUID: V7HfTiv6DskZG_ntj5JElNyyJx_Wb_7U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDEzMSBTYWx0ZWRfX2XdYaSE+qS8f
 lw5BXDv2MVg65T/cT0SPQV/2u/v77hdmSxoncjm5pyRzd7mCYO/Xar+ylnXgPM/tXIvnwVzFW7/
 ES0Jve3gX7jnU+ojuzIm79aKyAtjPAhFwa4FoZHt2HO++5tnqNgYUoGSZ+uI6HqmlCKhu8xh3jP
 fLVHaeExDKSVSiuu3JuPEswsPq9gCUsGbSJ1MYB7b+ffjJZWVREDsxSdRR26nbYXLf1caOLy82t
 adpmQ3m6pT16QKBFgj4TKByZmZNePq8JKSoAFlw/0ke55OgHtYFv/p0iokA4ZoHdqnpFNrFbb3p
 r36biR3FUoSlV4PKfeKeVEGdhfbGp0hqws7vl0liQBXked7YxRJnCDhPRgoipaT88wnEa37pJ/c
 cDCIftraleanexPFbS1oh7q2gP4pXfxassoNqt0PnXHmnXzh8xwIDPZGKr3V/ANUENdITsAn
X-Proofpoint-GUID: V7HfTiv6DskZG_ntj5JElNyyJx_Wb_7U

If rdma_dev_init_net() has an early return because the supplied net is
the default init_net, we need to call rdma_nl_net_exit() before
returning.

Fixes: 4e0f7b907072 ("RDMA/core: Implement compat device/sysfs tree in net namespace")
Cc: stable@vger.kernel.org
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/core/device.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 3145cb34a1d20..ec5642e70c5db 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1203,8 +1203,10 @@ static __net_init int rdma_dev_init_net(struct net *net)
 		return ret;
 
 	/* No need to create any compat devices in default init_net. */
-	if (net_eq(net, &init_net))
+	if (net_eq(net, &init_net)) {
+		rdma_nl_net_exit(rnet);
 		return 0;
+	}
 
 	ret = xa_alloc(&rdma_nets, &rnet->id, rnet, xa_limit_32b, GFP_KERNEL);
 	if (ret) {
-- 
2.43.5


