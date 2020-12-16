Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95732DB8DC
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Dec 2020 03:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725765AbgLPCQf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Dec 2020 21:16:35 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:30976 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725710AbgLPCQf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Dec 2020 21:16:35 -0500
X-IronPort-AV: E=Sophos;i="5.78,423,1599494400"; 
   d="scan'208";a="102438805"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 16 Dec 2020 10:15:49 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 56AB24CE6018;
        Wed, 16 Dec 2020 10:15:48 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 16 Dec 2020 10:15:47 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.31) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Wed, 16 Dec 2020 10:15:46 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <leon@kernel.org>, Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH rdma-core] librdmacm: Make rdma_create_qp_ex() report proper errno
Date:   Wed, 16 Dec 2020 09:54:59 +0800
Message-ID: <20201216015459.78733-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 56AB24CE6018.AAB3D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Current rdma_create_qp_ex() reports fixed ENOMEM when calling
ibv_create_qp_ex() fails, so it's hard for user to know which
actual error happens on ibv_create_qp_ex().

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 librdmacm/cma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/librdmacm/cma.c b/librdmacm/cma.c
index 8c820ccf..20ee1e00 100644
--- a/librdmacm/cma.c
+++ b/librdmacm/cma.c
@@ -1662,7 +1662,7 @@ int rdma_create_qp_ex(struct rdma_cm_id *id,
 		attr->srq = id->srq;
 	qp = ibv_create_qp_ex(id->verbs, attr);
 	if (!qp) {
-		ret = ERR(ENOMEM);
+		ret = -1;
 		goto err1;
 	}
 
-- 
2.25.1



