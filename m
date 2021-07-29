Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A3F3DA752
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jul 2021 17:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237389AbhG2PR5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 11:17:57 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:20008 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237737AbhG2PRz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Jul 2021 11:17:55 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TFBEIf028979;
        Thu, 29 Jul 2021 08:17:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=G+5f3YGPuu875ZaazSePfw3ajXiXY/s6jlXSfrHYBZs=;
 b=GTJt2+LuHfbQe9Kx27kKSN8ZHwJ+qeFv2iNjPeFiYKENerGI5N/QnDRxfxR63WTtuJfD
 urs8qBKvDZYjNkrlfdsryGlmI99vtHKFWrOM6lGFCf8aCZhcxdfxaSasPKEQoYNoprAa
 QbQKTLi1y6EaAAEo4C5uXApA7CNEER5enYs9MrgQKIF6DlLfQWBnX2qaWRbwNHytt/Yx
 VU37qcZcj9BSvGr2CMC4nidNYUFzv436w2rEXwr91V9+sSuOHqGWrfQB32VK/UVkoHZq
 7vBp6aR0RKm6tjm+wPM6Na7vQfF3j4YgkZQG2m1Md0ygUq2H+5oYB+xJesBDobKHxRUd 5g== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com with ESMTP id 3a35pr5ft9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 08:17:42 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 29 Jul
 2021 08:17:40 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Thu, 29 Jul 2021 08:17:37 -0700
From:   Prabhakar Kushwaha <pkushwaha@marvell.com>
To:     <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <jgg@nvidia.com>, <mkalderon@marvell.com>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <smalin@marvell.com>,
        <aelior@marvell.com>, <pkushwaha@marvell.com>,
        <prabhakar.pkin@gmail.com>, <malin1024@gmail.com>
Subject: [PATCH 1/2] qed: Use accurate error num in qed_cxt_dynamic_ilt_alloc
Date:   Thu, 29 Jul 2021 18:17:31 +0300
Message-ID: <20210729151732.30995-1-pkushwaha@marvell.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: YvvsA3W3xxhEzFdBA0Fj31-yNqt_QwN-
X-Proofpoint-GUID: YvvsA3W3xxhEzFdBA0Fj31-yNqt_QwN-
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_10:2021-07-29,2021-07-29 signatures=0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To have more accurate error return type use -EOPNOTSUPP instead
of -EINVAL.

Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
---
 drivers/net/ethernet/qlogic/qed/qed_cxt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_cxt.c b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
index 5a0a3cbcc1c1..cb0f2a3a1ac9 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_cxt.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_cxt.c
@@ -2226,8 +2226,8 @@ qed_cxt_dynamic_ilt_alloc(struct qed_hwfn *p_hwfn,
 		p_blk = &p_cli->pf_blks[CDUT_SEG_BLK(QED_CXT_ROCE_TID_SEG)];
 		break;
 	default:
-		DP_NOTICE(p_hwfn, "-EINVALID elem type = %d", elem_type);
-		return -EINVAL;
+		DP_NOTICE(p_hwfn, "-EOPNOTSUPP elem type = %d", elem_type);
+		return -EOPNOTSUPP;
 	}
 
 	/* Calculate line in ilt */
-- 
2.24.1

