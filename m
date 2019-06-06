Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 036D937223
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 12:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfFFKyE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 06:54:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:54680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbfFFKyE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Jun 2019 06:54:04 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1268E20868;
        Thu,  6 Jun 2019 10:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559818443;
        bh=NN/5pnVJ+KuM9ruaU6IAJzN1bcF3ummm70hig0qptxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fJSAUlwYemQ+BSvfqdGQvucLSJy1jnN2+yXhnj2xXWWqOgvZJe+j+kyhTgtplRUeH
         GsojCsN6/+DacGo4l0TQJa34ZrDJo53W16VD4hCcfhlH0+AX1E5fieSEtcX1CnJD6a
         067Hw9eyAMJq4CpfeaX20NaSnqR8JVSRnnL02vDI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH rdma-next v3 01/17] net/mlx5: Add rts2rts_qp_counters_set_id field in hca cap
Date:   Thu,  6 Jun 2019 13:53:29 +0300
Message-Id: <20190606105345.8546-2-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606105345.8546-1-leon@kernel.org>
References: <20190606105345.8546-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

Add rts2rts_qp_counters_set_id field in hca cap so that RTS2RTS
qp modification can be used to change the counter of a QP.

Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Majd Dibbiny <majd@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 include/linux/mlx5/mlx5_ifc.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 5e74305e2e57..9c9979cf0fd5 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1023,7 +1023,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         cc_modify_allowed[0x1];
 	u8         start_pad[0x1];
 	u8         cache_line_128byte[0x1];
-	u8         reserved_at_165[0xa];
+	u8         reserved_at_165[0x4];
+	u8         rts2rts_qp_counters_set_id[0x1];
+	u8         reserved_at_16a[0x5];
 	u8         qcam_reg[0x1];
 	u8         gid_table_size[0x10];

--
2.20.1

