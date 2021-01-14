Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8731C2F5A77
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Jan 2021 06:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbhANFep (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Jan 2021 00:34:45 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:33465 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725841AbhANFeo (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Jan 2021 00:34:44 -0500
X-IronPort-AV: E=Sophos;i="5.79,346,1602518400"; 
   d="scan'208";a="103468559"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Jan 2021 13:33:53 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id C82BC4CE6798;
        Thu, 14 Jan 2021 13:33:52 +0800 (CST)
Received: from G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Thu, 14 Jan 2021 13:33:54 +0800
Received: from Fedora-30.g08.fujitsu.local (10.167.220.106) by
 G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Thu, 14 Jan 2021 13:33:53 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <leon@kernel.org>, <leonro@nvidia.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH rdma-core] verbs: Replace SQ with RQ in max_recv_sge's documents
Date:   Thu, 14 Jan 2021 13:23:37 +0800
Message-ID: <20210114052337.32316-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: C82BC4CE6798.A9AE3
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes: 9845a77c8812 ("Add remaining libibverbs manpages")
Fixes: 058c67977dad ("XRC man pages")
Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 libibverbs/man/ibv_create_qp.3    | 2 +-
 libibverbs/man/ibv_create_qp_ex.3 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libibverbs/man/ibv_create_qp.3 b/libibverbs/man/ibv_create_qp.3
index 1cdf2474..dfbd245f 100644
--- a/libibverbs/man/ibv_create_qp.3
+++ b/libibverbs/man/ibv_create_qp.3
@@ -40,7 +40,7 @@ struct ibv_qp_cap {
 uint32_t                max_send_wr;    /* Requested max number of outstanding WRs in the SQ */
 uint32_t                max_recv_wr;    /* Requested max number of outstanding WRs in the RQ */
 uint32_t                max_send_sge;   /* Requested max number of scatter/gather (s/g) elements in a WR in the SQ */
-uint32_t                max_recv_sge;   /* Requested max number of s/g elements in a WR in the SQ */
+uint32_t                max_recv_sge;   /* Requested max number of s/g elements in a WR in the RQ */
 uint32_t                max_inline_data;/* Requested max number of data (bytes) that can be posted inline to the SQ, otherwise 0 */
 .in -8
 };
diff --git a/libibverbs/man/ibv_create_qp_ex.3 b/libibverbs/man/ibv_create_qp_ex.3
index 277e9fa0..30928126 100644
--- a/libibverbs/man/ibv_create_qp_ex.3
+++ b/libibverbs/man/ibv_create_qp_ex.3
@@ -49,7 +49,7 @@ struct ibv_qp_cap {
 uint32_t                max_send_wr;    /* Requested max number of outstanding WRs in the SQ */
 uint32_t                max_recv_wr;    /* Requested max number of outstanding WRs in the RQ */
 uint32_t                max_send_sge;   /* Requested max number of scatter/gather (s/g) elements in a WR in the SQ */
-uint32_t                max_recv_sge;   /* Requested max number of s/g elements in a WR in the SQ */
+uint32_t                max_recv_sge;   /* Requested max number of s/g elements in a WR in the RQ */
 uint32_t                max_inline_data;/* Requested max number of data (bytes) that can be posted inline to the SQ, otherwise 0 */
 .in -8
 };
-- 
2.21.0



