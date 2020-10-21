Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C832B294C00
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Oct 2020 13:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410912AbgJULu7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Oct 2020 07:50:59 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:26282 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2410911AbgJULu7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Oct 2020 07:50:59 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09LBolmu012184;
        Wed, 21 Oct 2020 04:50:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=YiEaMm8muwDtauaTP8/+XQijlaZ3wh1U8I8Gk9Jx788=;
 b=gVCtSBlOGmJC31NQW4QYwSXp1Z0K8B7zGH76jWGcWWFuBKMaAUNcsC9zMzN6VStth+BO
 Ta5ufHUSrlAif0FM96gEOZQNfuKWZr74c0aDHNgRDoNQN0cARD+Ilo9AqehvTXnsSRLi
 L3Edvq/u0+B/er7ZBwTi7elKzwm9V6skBNT3OlBOFOyZHmhi0esWBmrD4dArs2Vetw7a
 Lptl/BgiFHSzoKi1kEyL7h4YCqS8A6WUBsVQV8jzmO0mZw/JQIYX5OrgUIeDC7gbyCWk
 a6saqOuO9hNLUGid44qWmelCE2bZB82OWMu4oB+l2IWDIyMkkWIEbTWOFDpSlZkQD+qf bQ== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 347wyqd12w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 21 Oct 2020 04:50:56 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 21 Oct
 2020 04:50:55 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 21 Oct
 2020 04:50:55 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 21 Oct 2020 04:50:55 -0700
Received: from alpha-dell-r720.punelab.qlogic.com032qlogic.org032qlogic.com032mv.qlogic.com032av.na (unknown [10.30.45.91])
        by maili.marvell.com (Postfix) with ESMTP id AB86D3F7041;
        Wed, 21 Oct 2020 04:50:52 -0700 (PDT)
From:   Alok Prasad <palok@marvell.com>
To:     <jgg@ziepe.ca>, <dledford@redhat.com>
CC:     <michal.kalderon@marvell.com>, <ariel.elior@marvell.com>,
        <linux-rdma@vger.kernel.org>, <palok@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>
Subject: [PATCH rdma-next] RDMA/qedr: Fix memory leak in iWARP cm
Date:   Wed, 21 Oct 2020 11:50:08 +0000
Message-ID: <20201021115008.28138-1-palok@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-21_05:2020-10-20,2020-10-21 signatures=0
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes memory leak in iWARP cm

Fixes: e411e0587e0d ("RDMA/qedr: Add iWARP connection management functions")
Signed-off-by: Michal Kalderon <michal.kalderon@marvell.com>
Signed-off-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: Alok Prasad <palok@marvell.com>
---
 drivers/infiniband/hw/qedr/qedr_iw_cm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/qedr/qedr_iw_cm.c b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
index c7169d2c69e5..c4bc58736e48 100644
--- a/drivers/infiniband/hw/qedr/qedr_iw_cm.c
+++ b/drivers/infiniband/hw/qedr/qedr_iw_cm.c
@@ -727,6 +727,7 @@ int qedr_iw_destroy_listen(struct iw_cm_id *cm_id)
 						    listener->qed_handle);
 
 	cm_id->rem_ref(cm_id);
+	kfree(listener);
 	return rc;
 }
 
-- 
2.17.1

