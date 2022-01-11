Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 126EB48B24B
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Jan 2022 17:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241282AbiAKQfp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jan 2022 11:35:45 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:37824 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240478AbiAKQfp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 Jan 2022 11:35:45 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20BFECjF021137;
        Tue, 11 Jan 2022 16:35:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2021-07-09;
 bh=zPZ37CnGRIGmC1pOrutm9TbDdLVSK+W+vWtI5wNTSUA=;
 b=qbc/BpDcYaYIEYRF6gwAwYR7gXielgtPkI7FV5yjrM0zFXxD+kUyalBcdQc1oxeZi2Uq
 QZ42XYx0LcX786YLDNXwRCBfSckb79e6pWsMRGluntqJeX4CKRwK/M9HltAEM6xRJWrO
 XAsy/FmnO/lpjSMOzAAuysG1DLd19/R3Hp2717qWF29k+xGtA/Ow2dhguqxAMRxZvjrH
 lJ10kmGH8Wm/Tohw9jkFQ0mytWXlSNMgUUcU5y63e9AoqxatzNAhQjK238v8RZqs79li
 txfgpE65K55613bJTjWi5/QKb6vZmdgJigACAY6xek092L4QFmTdTmwSmu+LHiINo1kG 7w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgp7nkey2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jan 2022 16:35:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20BGUSuT007479;
        Tue, 11 Jan 2022 16:35:41 GMT
Received: from lab02.no.oracle.com (lab02.no.oracle.com [10.172.144.56])
        by aserp3030.oracle.com with ESMTP id 3df0ne8ydv-1;
        Tue, 11 Jan 2022 16:35:40 +0000
From:   =?UTF-8?q?H=C3=A5kon=20Bugge?= <haakon.bugge@oracle.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
        Or Gerlitz <ogerlitz@mellanox.com>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC for-rc] IB/mlx4: Fix the fix for reading flow-counters
Date:   Tue, 11 Jan 2022 17:35:38 +0100
Message-Id: <1641918938-10011-1-git-send-email-haakon.bugge@oracle.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201110093
X-Proofpoint-GUID: MJPzK6NrSnNUWFcqAkGaRIGGLFQTZe-5
X-Proofpoint-ORIG-GUID: MJPzK6NrSnNUWFcqAkGaRIGGLFQTZe-5
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

It is not logical to call iboe_process_mad() when the link-layer is
Infiniband. Nevertheless, the commit message in commit 43bfb9729ea8
("IB/mlx4: Fix use of flow-counters for process_mad") explicitly state
that iboe_process_mad() shall be called.

Without this fix, reading:

yields "Invalid argument", whereas with this commit, said counter can
be read.

Please note that mlx4_1 is a VF.

Fixes: 43bfb9729ea8 ("IB/mlx4: Fix use of flow-counters for process_mad")
Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
---
 drivers/infiniband/hw/mlx4/mad.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/mad.c b/drivers/infiniband/hw/mlx4/mad.c
index d13ecbd..cc83782 100644
--- a/drivers/infiniband/hw/mlx4/mad.c
+++ b/drivers/infiniband/hw/mlx4/mad.c
@@ -998,8 +998,8 @@ int mlx4_ib_process_mad(struct ib_device *ibdev, int mad_flags, u32 port_num,
 		     (in->mad_hdr.attr_id == IB_PMA_PORT_COUNTERS ||
 		      in->mad_hdr.attr_id == IB_PMA_PORT_COUNTERS_EXT ||
 		      in->mad_hdr.attr_id == IB_PMA_CLASS_PORT_INFO)))
-			return iboe_process_mad(ibdev, mad_flags, port_num,
-						in_wc, in_grh, in, out);
+			return ib_process_mad(ibdev, mad_flags, port_num,
+					      in_wc, in_grh, in, out);
 
 		return ib_process_mad(ibdev, mad_flags, port_num, in_wc, in_grh,
 				      in, out);
-- 
1.8.3.1

