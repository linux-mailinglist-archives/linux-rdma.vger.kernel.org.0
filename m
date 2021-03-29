Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1244034CB97
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Mar 2021 10:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhC2Iti (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Mar 2021 04:49:38 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15087 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbhC2ItI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Mar 2021 04:49:08 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F85mM0vzDz19Jt4;
        Mon, 29 Mar 2021 16:46:59 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Mon, 29 Mar 2021 16:48:52 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH for-next] MAINTAINERS: remove Xavier as maintainer of HISILICON ROCE DRIVER
Date:   Mon, 29 Mar 2021 16:46:24 +0800
Message-ID: <1617007584-39842-1-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Wei Hu(Xavier) has left Hisilicon and his email address is invalid now.
I'd be glad to add him back with another address if he wants to continue
maintain this module.

Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85c..b56e673 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8090,7 +8090,6 @@ F:	drivers/crypto/hisilicon/zip/
 
 HISILICON ROCE DRIVER
 M:	Lijun Ou <oulijun@huawei.com>
-M:	Wei Hu(Xavier) <huwei87@hisilicon.com>
 M:	Weihang Li <liweihang@huawei.com>
 L:	linux-rdma@vger.kernel.org
 S:	Maintained
-- 
2.8.1

