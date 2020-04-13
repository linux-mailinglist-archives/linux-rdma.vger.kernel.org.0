Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38171A67AA
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 16:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730456AbgDMOPu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 10:15:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730417AbgDMOPu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Apr 2020 10:15:50 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F6282075E;
        Mon, 13 Apr 2020 14:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586787350;
        bh=zN3vN7WBonFieA+BPcy1jwbRQQij1stUOhfFdKeuc8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=agkvJETU+COoICbrYwoe/ubOj/wtfrCedmHdodTjP7u8XldYRVSwGffFMZcpF0zwR
         XgaWPD4XyVYND2pwzX9kwP/Rn1ZDeq4IBA6d5LYQstC171BzcBtZ894UCG0SixHa/A
         tz9viXMbbGth2lRPc4WIfSzlApJfegG7pecCJosk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 2/7] RDMA/uapi: Add ECE definitions to UCMA
Date:   Mon, 13 Apr 2020 17:15:33 +0300
Message-Id: <20200413141538.935574-3-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200413141538.935574-1-leon@kernel.org>
References: <20200413141538.935574-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

ECE parameters are used to perform handshake between different
CMID nodes in order to allow extra connection setup supported
by those two nodes. The data is provided by rdma_connect()
for the client and rdma_get_events() for the server.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 include/uapi/rdma/rdma_user_cm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/uapi/rdma/rdma_user_cm.h b/include/uapi/rdma/rdma_user_cm.h
index e42940a215a3..150b3f075f99 100644
--- a/include/uapi/rdma/rdma_user_cm.h
+++ b/include/uapi/rdma/rdma_user_cm.h
@@ -206,10 +206,16 @@ struct rdma_ucm_ud_param {
 	__u8  reserved[7];
 };
 
+struct rdma_ucm_ece {
+	__u32 vendor_id;
+	__u32 attr_mod;
+};
+
 struct rdma_ucm_connect {
 	struct rdma_ucm_conn_param conn_param;
 	__u32 id;
 	__u32 reserved;
+	struct rdma_ucm_ece ece;
 };
 
 struct rdma_ucm_listen {
@@ -287,6 +293,7 @@ struct rdma_ucm_event_resp {
 		struct rdma_ucm_ud_param   ud;
 	} param;
 	__u32 reserved;
+	struct rdma_ucm_ece ece;
 };
 
 /* Option levels */
-- 
2.25.2

