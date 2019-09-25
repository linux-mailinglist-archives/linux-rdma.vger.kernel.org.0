Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF022BDCDF
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2019 13:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390818AbfIYLTL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Sep 2019 07:19:11 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:63264 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727194AbfIYLTL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Sep 2019 07:19:11 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8PBEfi7019941;
        Wed, 25 Sep 2019 04:19:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0818;
 bh=Py7+XpEDGdnQhnz0F2dAKTBgfZYzYwzrt7CD8Q+R81E=;
 b=rjxlBv6sz5UgsKy6RzHke+r83aLnUT+i2m0XSg68yVTU4wuT+Xu6Y/l74QoTQUfnIRYd
 uy7aRhK61ozYB3yTS+UxHsT/eh6OlDSaeLuXz6Dxbh0cvp46B17qLk47PO7S1AovOIwT
 IGo5w0i24b1Y1Fk0VuHVNgxJ8b5Nxw+h4s4agwh9ek+PyB5pXiv1YE0+XwHtnhDcWkRH
 g+lr+Yro4+aD2S/+zMngL0dKERrt4jyNUx1Vsy43yvm0dM91aj+FbWokMSdQIPkzxdp4
 EvD1VdCnuevuiPHJvg6hoHy3679sbuJVLB5O5lpcBa78BRRlyU2sgytb9h0cbIWRuLhU yg== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2v876180sh-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 25 Sep 2019 04:19:08 -0700
Received: from SC-EXCH01.marvell.com (10.93.176.81) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 25 Sep
 2019 04:18:50 -0700
Received: from maili.marvell.com (10.93.176.43) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Wed, 25 Sep 2019 04:18:50 -0700
Received: from lb-tlvb-ybason.il.qlogic.org (unknown [10.5.221.176])
        by maili.marvell.com (Postfix) with ESMTP id 0E9DB3F703F;
        Wed, 25 Sep 2019 04:18:47 -0700 (PDT)
From:   Yuval Basson <ybason@marvell.com>
To:     <dledford@redhat.com>, <jgg@ziepe.ca>
CC:     <leon@kernel.org>, <mkalderon@marvell.com>,
        <linux-rdma@vger.kernel.org>, Yuval Basson <ybason@marvell.com>,
        Ariel Elior <aelior@marvell.com>
Subject: [PATCH rdma-next] RDMA/core: Fix find_gid_index to use the proper API to retrieve the vlan ID 
Date:   Wed, 25 Sep 2019 14:23:01 +0300
Message-ID: <20190925112301.10440-1-ybason@marvell.com>
X-Mailer: git-send-email 2.14.5
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-25_05:2019-09-23,2019-09-25 signatures=0
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When working over a macvlan device which was itself
created over a vlan device, the roce CM traffic should use
the vlan from the lower vlan device, but instead it simply queries
the macvlan device as to whether it is itself a vlan device. 
Since it is not, the roce CM traffic is sent without any vlan, which
causes it not to be accepted by the peer which is running directly
over a vlan device, and will thus only accept roce CM traffic carrying
the vlan.

Fixes: dbf727de7440 ("Use GID table in AH creation and dmac resolution")
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Yuval Basson <ybason@marvell.com>
---
 drivers/infiniband/core/verbs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index f974b68..1d2d9be0 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -662,13 +662,13 @@ static bool find_gid_index(const union ib_gid *gid,
 			   void *context)
 {
 	struct find_gid_index_context *ctx = context;
+	u16 vlan_id;
 
 	if (ctx->gid_type != gid_attr->gid_type)
 		return false;
 
-	if ((!!(ctx->vlan_id != 0xffff) == !is_vlan_dev(gid_attr->ndev)) ||
-	    (is_vlan_dev(gid_attr->ndev) &&
-	     vlan_dev_vlan_id(gid_attr->ndev) != ctx->vlan_id))
+	rdma_read_gid_l2_fields(gid_attr, &vlan_id, NULL);
+	if (ctx->vlan_id != vlan_id)
 		return false;
 
 	return true;
-- 
1.8.3.1

