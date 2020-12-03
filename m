Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1A52CDE7E
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Dec 2020 20:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbgLCTIJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Dec 2020 14:08:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729260AbgLCTIJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Dec 2020 14:08:09 -0500
From:   Leon Romanovsky <leon@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Zhu Yanjun <yanjunz@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next] MAINTAINERS: SOFT-ROCE: Change Zhu Yanjun's email address
Date:   Thu,  3 Dec 2020 21:06:59 +0200
Message-Id: <20201203190659.126932-1-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjunz@nvidia.com>

Change Zhu's working email to his private one.

Signed-off-by: Zhu Yanjun <yanjunz@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index d9fb83d67055..22831c2991ab 100644
--- a/.mailmap
+++ b/.mailmap
@@ -341,3 +341,4 @@ Wolfram Sang <wsa@kernel.org> <w.sang@pengutronix.de>
 Wolfram Sang <wsa@kernel.org> <wsa@the-dreams.de>
 Yakir Yang <kuankuan.y@gmail.com> <ykk@rock-chips.com>
 Yusuke Goda <goda.yusuke@renesas.com>
+Zhu Yanjun <zyjzyj2000@gmail.com> <yanjunz@nvidia.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 2daa6ee673f7..73e53207c920 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16195,7 +16195,7 @@ F:	drivers/infiniband/sw/siw/
 F:	include/uapi/rdma/siw-abi.h

 SOFT-ROCE DRIVER (rxe)
-M:	Zhu Yanjun <yanjunz@nvidia.com>
+M:	Zhu Yanjun <zyjzyj2000@gmail.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
 F:	drivers/infiniband/sw/rxe/
--
2.28.0

