Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 731B817A864
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2020 16:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgCEPBX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Mar 2020 10:01:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:46734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgCEPBV (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Mar 2020 10:01:21 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD608208C3;
        Thu,  5 Mar 2020 15:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583420480;
        bh=N3jc9DmgF/SjQ/a5WtH6zbFWTS0A8rDYY1NzXJqs+b0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lCxsHJ26QmQFTxXWlKBM4plTavlJQWAnXopkwhOyR7HYLNSRpgsP4KkkYoImDDIDX
         u+BHiA05s5N8hr26XTibaW2pnjvImD88NQ9LWz3Uu7bwvGS8ZbuYPHYGfuLQX0PwGD
         nGLEU7yJDe2pud774pe1xEtNDBM9LUncA9buuq1c=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@mellanox.com>
Subject: [PATCH rdma-next 4/9] RDMA/uapi: Add ECE definitions to UCMA
Date:   Thu,  5 Mar 2020 17:01:00 +0200
Message-Id: <20200305150105.207959-5-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305150105.207959-1-leon@kernel.org>
References: <20200305150105.207959-1-leon@kernel.org>
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

Reviewed-by: Mark Zhang <markz@mellanox.com>
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
2.24.1

