Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4713DA45F
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jul 2021 15:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237452AbhG2Nbb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jul 2021 09:31:31 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:9348 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237549AbhG2Nbb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 29 Jul 2021 09:31:31 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16TDU4kH018980;
        Thu, 29 Jul 2021 06:31:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=sdo3gzy5zsmbEpKsRRdihbLdh1QXHGc6LTCAHmfFeNM=;
 b=elMiIAIDQj0W5aoOePxCSsEBesdshUmCbn1vqokOgNZA538ASNw/3Ef9eydCJitk8c2f
 oGgUVdjpASmc9PoEw+hCFtgn9v0XwqmDBIi3iAmB2WQHTF9EX/kgnEHpDo+lRyR8nCfu
 lr+JKPutIb/4ZNEG/bcjBv+eaM9lQtK9LGdlBHKd65FIRAj2am7l/TjRuNlrRw9K903C
 anNWObr/mjRp15IEV5eIH9lFMr+d7s9w+LGbpLN/GQAHvj44wRuNwdysaEjk2AMcchZd
 PZT/kBfVV3sZHwyfVMiZDPtXrtyYW1I3/+STGfBna9ln2K0whAsFKyfzsRn2AO2xmsyh Ag== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 3a3w5kr1ug-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 29 Jul 2021 06:31:23 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 29 Jul
 2021 06:30:49 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Thu, 29 Jul 2021 06:30:46 -0700
From:   Shai Malin <smalin@marvell.com>
To:     <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <jgg@nvidia.com>, <mkalderon@marvell.com>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <smalin@marvell.com>,
        <aelior@marvell.com>, <pkushwaha@marvell.com>,
        <prabhakar.pkin@gmail.com>, <malin1024@gmail.com>
Subject: [PATCH for-next 3/3] qedr: Use grh layer traffic_class as RDMA CM TOS
Date:   Thu, 29 Jul 2021 16:30:32 +0300
Message-ID: <20210729133032.26278-4-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20210729133032.26278-1-smalin@marvell.com>
References: <20210729133032.26278-1-smalin@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: 4cUGCO3tFGFXkm6YJXtTaO4VKrWETWgQ
X-Proofpoint-ORIG-GUID: 4cUGCO3tFGFXkm6YJXtTaO4VKrWETWgQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-29_10:2021-07-29,2021-07-29 signatures=0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Prabhakar Kushwaha <pkushwaha@marvell.com>

Instead of grh flow label use grh layer traffic_class as RDMA CM TOS.

Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
---
 drivers/infiniband/hw/qedr/qedr_roce_cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/qedr/qedr_roce_cm.c b/drivers/infiniband/hw/qedr/qedr_roce_cm.c
index eb7d24742664..1fa7415117e5 100644
--- a/drivers/infiniband/hw/qedr/qedr_roce_cm.c
+++ b/drivers/infiniband/hw/qedr/qedr_roce_cm.c
@@ -477,7 +477,7 @@ static inline int qedr_gsi_build_header(struct qedr_dev *dev,
 		u32 ipv4_addr;
 
 		udh->ip4.protocol = IPPROTO_UDP;
-		udh->ip4.tos = htonl(grh->flow_label);
+		udh->ip4.tos = grh->traffic_class;
 		udh->ip4.frag_off = htons(IP_DF);
 		udh->ip4.ttl = grh->hop_limit;
 
-- 
2.24.1

