Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3592D32A81F
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Mar 2021 18:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579817AbhCBRKW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Mar 2021 12:10:22 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:12670 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345703AbhCBMyF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Mar 2021 07:54:05 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DqcRt3dTPzlRyc;
        Tue,  2 Mar 2021 20:50:34 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Mar 2021 20:52:38 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <jgg@nvidia.com>, <leon@kernel.org>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@openeuler.org>
Subject: [PATCH rdma-core 1/5] Update kernel headers
Date:   Tue, 2 Mar 2021 20:50:20 +0800
Message-ID: <1614689424-27154-2-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1614689424-27154-1-git-send-email-liweihang@huawei.com>
References: <1614689424-27154-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To commit ?? ("RDMA/hns: Add support for XRC").

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 kernel-headers/rdma/hns-abi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel-headers/rdma/hns-abi.h b/kernel-headers/rdma/hns-abi.h
index 90b739d..42b1776 100644
--- a/kernel-headers/rdma/hns-abi.h
+++ b/kernel-headers/rdma/hns-abi.h
@@ -86,6 +86,8 @@ struct hns_roce_ib_create_qp_resp {
 struct hns_roce_ib_alloc_ucontext_resp {
 	__u32	qp_tab_size;
 	__u32	cqe_size;
+	__u32	srq_tab_size;
+	__u32	reserved;
 };
 
 struct hns_roce_ib_alloc_pd_resp {
-- 
2.8.1

