Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9F721E7885
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2020 10:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgE2Ijq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 May 2020 04:39:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56832 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbgE2Ijq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 29 May 2020 04:39:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04T8WDEK005493;
        Fri, 29 May 2020 08:39:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=QXQ0dLWmK6e1aUy7NvBTylP5psS1De0O1FjtrTY9oGs=;
 b=N5UCrS/Cu6XuvAt1OvheLOICtMb3pl6CjcdE4gO5ThTl9Pfja8uEE5issET/u7D8JR2o
 5BftZGYlYsA4c0kIssYVHIiGAaRIWKeBEDKOVEUD4lj9zARmhQCxfj6k/ZLIZQ9Hi8gY
 sQasTlCfUrw/be0qzFEs9BFqmoaYQBnT9PbqFTRZjExCCoPKj3Nuo5rpw4ao4OLeaOgA
 RWMS1jIcDzYCeUKqC/mTfN/YCq0ugoovsmhKVuBgqkGZ+NUtmVgaSyMAtXEsxh/1EsjB
 rEMzY46G6Sfxc8t2rGbssm0kWlyfN3MoF5+RSFeFmro5TqY2fmGGTZeeL0jjnwLSFFPI +g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 318xe1s5ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 May 2020 08:39:31 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04T8XhW5011061;
        Fri, 29 May 2020 08:39:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 31a9ktwqf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 May 2020 08:39:30 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04T8dQxP015801;
        Fri, 29 May 2020 08:39:27 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 May 2020 01:39:26 -0700
Date:   Fri, 29 May 2020 11:39:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Lijun Ou <oulijun@huawei.com>, Xi Wang <wangxi11@huawei.com>
Cc:     "Wei Hu(Xavier)" <huwei87@hisilicon.com>,
        Weihang Li <liweihang@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] RDMA/hns: Uninitialized variable in modify_qp_init_to_rtr()
Message-ID: <20200529083918.GA1298465@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290068
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 cotscore=-2147483648 mlxscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290068
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The "dmac" variable is used before it is initialized.

Fixes: 494c3b312255 ("RDMA/hns: Refactor the QP context filling process related to WQE buffer configure")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 6454ac4ad06f0..c597d7281629b 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4030,6 +4030,7 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	port = (attr_mask & IB_QP_PORT) ? (attr->port_num - 1) : hr_qp->port;
 
 	smac = (u8 *)hr_dev->dev_addr[port];
+	dmac = (u8 *)attr->ah_attr.roce.dmac;
 	/* when dmac equals smac or loop_idc is 1, it should loopback */
 	if (ether_addr_equal_unaligned(dmac, smac) ||
 	    hr_dev->loop_idc == 0x1) {
@@ -4053,7 +4054,6 @@ static int modify_qp_init_to_rtr(struct ib_qp *ibqp,
 	roce_set_field(qpc_mask->byte_20_smac_sgid_idx,
 		       V2_QPC_BYTE_20_SGID_IDX_M, V2_QPC_BYTE_20_SGID_IDX_S, 0);
 
-	dmac = (u8 *)attr->ah_attr.roce.dmac;
 	memcpy(&(context->dmac), dmac, sizeof(u32));
 	roce_set_field(context->byte_52_udpspn_dmac, V2_QPC_BYTE_52_DMAC_M,
 		       V2_QPC_BYTE_52_DMAC_S, *((u16 *)(&dmac[4])));
-- 
2.26.2

