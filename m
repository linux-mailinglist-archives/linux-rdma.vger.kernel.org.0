Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 097F271243
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 09:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfGWHES (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 03:04:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:44716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbfGWHER (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jul 2019 03:04:17 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C17D206B8;
        Tue, 23 Jul 2019 07:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563865457;
        bh=GHDOoCtT2aT4xK0hvjKuQV1nFdVqXqgb/ilhneUh8ck=;
        h=From:To:Cc:Subject:Date:From;
        b=yx+5EH6pYLTIaGGjw/qSe4qqG3kcmUOyn1SCWfQ2iWmyQ+GlLyiwDKEQMvcNZf3ls
         XisqsWKBnelNuyI5+fXt3yMkmmgIVySXNkP0TnNZGVRiWUk1TNp5j6kcAAkn4rrHKN
         bqmPgOkpHkpYwJApKKnkBNP6BoAp7Df5EPrBnFik=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Max Gurtovoy <maxg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-next] IB/mlx5: Add CREATE_PSV/DESTROY_PSV for devx interface
Date:   Tue, 23 Jul 2019 10:04:12 +0300
Message-Id: <20190723070412.6385-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Max Gurtovoy <maxg@mellanox.com>

Limit the number of PSV's created through devx to 1, to create a symmetry
between create/destroy cmds. In the kernel, one can create up to 4 PSV's
using CREATE_PSV cmd but the destruction is one by one. Add a protection
for this a-symmetric definition for devx.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index ec4370f99381..a527cf7f01ac 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -776,6 +776,14 @@ static bool devx_is_obj_create_cmd(const void *in, u16 *opcode)
 			return true;
 		return false;
 	}
+	case MLX5_CMD_OP_CREATE_PSV:
+	{
+		u8 num_psv = MLX5_GET(create_psv_in, in, num_psv);
+
+		if (num_psv == 1)
+			return true;
+		return false;
+	}
 	default:
 		return false;
 	}
@@ -1215,6 +1223,12 @@ static void devx_obj_build_destroy_cmd(void *in, void *out, void *din,
 	case MLX5_CMD_OP_ALLOC_XRCD:
 		MLX5_SET(general_obj_in_cmd_hdr, din, opcode, MLX5_CMD_OP_DEALLOC_XRCD);
 		break;
+	case MLX5_CMD_OP_CREATE_PSV:
+		MLX5_SET(general_obj_in_cmd_hdr, din, opcode,
+			 MLX5_CMD_OP_DESTROY_PSV);
+		MLX5_SET(destroy_psv_in, din, psvn,
+			 MLX5_GET(create_psv_out, out, psv0_index));
+		break;
 	default:
 		/* The entry must match to one of the devx_is_obj_create_cmd */
 		WARN_ON(true);
--
2.20.1

