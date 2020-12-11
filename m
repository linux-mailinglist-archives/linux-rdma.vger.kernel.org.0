Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA2F2D70C1
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Dec 2020 08:23:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403821AbgLKHUv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Dec 2020 02:20:51 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:2142 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2436799AbgLKHUc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 11 Dec 2020 02:20:32 -0500
X-IronPort-AV: E=Sophos;i="5.78,410,1599494400"; 
   d="scan'208";a="102301081"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Dec 2020 15:19:44 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id B1E844CE600D
        for <linux-rdma@vger.kernel.org>; Fri, 11 Dec 2020 15:19:43 +0800 (CST)
Received: from G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Fri, 11 Dec 2020 15:19:43 +0800
Received: from Fedora-31.g08.fujitsu.local (10.167.220.31) by
 G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) with Microsoft SMTP Server
 id 15.0.1497.2 via Frontend Transport; Fri, 11 Dec 2020 15:19:42 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
To:     <linux-rdma@vger.kernel.org>
CC:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH rdma-core] rdma_server: Add '-s' option in rdma_server's manual
Date:   Fri, 11 Dec 2020 14:59:10 +0800
Message-ID: <20201211065910.1473270-1-yangx.jy@cn.fujitsu.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: B1E844CE600D.A9FE7
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Fixes: 519d8d7aa965 ("librdmacm: Add command line option to specify server")
Fixes: cdea72a1e7e6 ("librdmacm: Change server default address to any address.")
Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 librdmacm/man/rdma_server.1 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/librdmacm/man/rdma_server.1 b/librdmacm/man/rdma_server.1
index ada25649..f83633e0 100644
--- a/librdmacm/man/rdma_server.1
+++ b/librdmacm/man/rdma_server.1
@@ -13,6 +13,10 @@ two nodes.  This example is intended to provide a very simple coding
 example of how to use RDMA.
 .SH "OPTIONS"
 .TP
+\-s server_address
+Specifies the address that the rdma_server listens on.  By default the
+server listens on any address(0.0.0.0).
+.TP
 \-p port
 Changes the port number that the server listens on.  By default the server
 listens on port 7471.
-- 
2.23.0



