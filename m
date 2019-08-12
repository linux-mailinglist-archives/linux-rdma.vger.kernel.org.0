Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 147D28A3E7
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Aug 2019 19:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfHLQ76 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Aug 2019 12:59:58 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:54150 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725843AbfHLQ76 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 12 Aug 2019 12:59:58 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from haimbo@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 12 Aug 2019 19:59:52 +0300
Received: from r-ufm115.mtr.labs.mlnx (r-ufm115.mtr.labs.mlnx [10.209.36.210])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x7CGxp4x002667;
        Mon, 12 Aug 2019 19:59:51 +0300
Received: from r-ufm115.mtr.labs.mlnx (localhost [127.0.0.1])
        by r-ufm115.mtr.labs.mlnx (8.14.7/8.14.7) with ESMTP id x7CGxpHk024846;
        Mon, 12 Aug 2019 16:59:51 GMT
Received: (from haimbo@localhost)
        by r-ufm115.mtr.labs.mlnx (8.14.7/8.14.7/Submit) id x7CGxpsa024845;
        Mon, 12 Aug 2019 16:59:51 GMT
From:   Haim Boozaglo <haimbo@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     Haim Boozaglo <haimbo@mellanox.com>
Subject: [PATCH] libibumad: Support 128 devices
Date:   Mon, 12 Aug 2019 16:59:48 +0000
Message-Id: <1565629188-24799-2-git-send-email-haimbo@mellanox.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1565629188-24799-1-git-send-email-haimbo@mellanox.com>
References: <1565629188-24799-1-git-send-email-haimbo@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Extend the maximum of available InfiniBand devices
by changing the macro from 32 to 128.

Signed-off-by: Haim Boozaglo <haimbo@mellanox.com>
---
 libibumad/umad.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libibumad/umad.h b/libibumad/umad.h
index 3cc551f..8e0c8c3 100644
--- a/libibumad/umad.h
+++ b/libibumad/umad.h
@@ -62,7 +62,7 @@ union umad_gid {
 	} global;
 } __attribute__((aligned(4))) __attribute__((packed));
 
-#define UMAD_MAX_DEVICES 32
+#define UMAD_MAX_DEVICES 128
 #define UMAD_ANY_PORT	0
 typedef struct ib_mad_addr {
 	__be32 qpn;
-- 
1.8.3.1

