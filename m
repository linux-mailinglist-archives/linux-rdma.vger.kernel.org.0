Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E80E22C59
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 08:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbfETGyt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 02:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:38932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfETGyt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 02:54:49 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 314DE2081C;
        Mon, 20 May 2019 06:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558335288;
        bh=Bv93vET2Ea4EXLM3mWW5TzHWuW7mjs6o/oQ0wP9zmis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aXCLrG6s78x1imVBa7XaRQ9tbs6NSMiuCSaNkLTpsEw03FYZu/NRG/AvWYt2FVnw8
         uzSs9CN+vTYmTXa4Tewc9bUBAtTwaIlVeeDhiAly7q8nfjUFtPvmXbclpxNJKOrMtL
         aYHWhewdjDzMOe1qkQo4HIUlypzLAqmD9etgFKso=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Glenn Streiff <gstreiff@neteffect.com>,
        Steve Wise <swise@opengridcomputing.com>
Subject: [PATCH rdma-next 03/15] RDMA/core: Make ib_destroy_cq() void
Date:   Mon, 20 May 2019 09:54:21 +0300
Message-Id: <20190520065433.8734-4-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520065433.8734-1-leon@kernel.org>
References: <20190520065433.8734-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Kernel destroy CQ flows can't fail and the returned value
of ib_destroy_cq() is not interested in those flows.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 include/rdma/ib_verbs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index c475bfb832e7..f54260018b69 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3887,9 +3887,9 @@ int ib_destroy_cq_user(struct ib_cq *cq, struct ib_udata *udata);
  *
  * NOTE: for user cq use ib_destroy_cq_user with valid udata!
  */
-static inline int ib_destroy_cq(struct ib_cq *cq)
+static inline void ib_destroy_cq(struct ib_cq *cq)
 {
-	return ib_destroy_cq_user(cq, NULL);
+	ib_destroy_cq_user(cq, NULL);
 }
 
 /**
-- 
2.20.1

