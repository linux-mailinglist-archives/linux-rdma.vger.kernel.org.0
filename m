Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F872F069A
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Jan 2021 12:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbhAJLTx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Jan 2021 06:19:53 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19510 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbhAJLTu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Jan 2021 06:19:50 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffae2ae0000>; Sun, 10 Jan 2021 03:19:10 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 10 Jan
 2021 11:19:09 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Sun, 10 Jan 2021 11:19:07 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <jgg@nvidia.com>, <leonro@nvidia.com>, <sagi@grimberg.me>
CC:     <oren@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>
Subject: [PATCH 2/3] IB/isert: remove unneeded semicolon
Date:   Sun, 10 Jan 2021 11:19:02 +0000
Message-ID: <20210110111903.486681-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210110111903.486681-1-mgurtovoy@nvidia.com>
References: <20210110111903.486681-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610277550; bh=TNSYOmBkaDlRr0JXmtL0QACJKjSaAgcBwquzdgSX4ss=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        b=U2tB0wAjEgzo0bPdtWuonFnSwOuwXWuLl7MJ8d+HOWNcuHa0KEc4DGXN6d7myhW28
         5NTIL8UjcJbbUVdcjU8isgOf+REeofs/0ULvrcM5aXdD0IxkS3RhKV+5XZNSHdxIYF
         fyEKV6BS3l3Tg9HvwLqxgAqRTxWLxN+MTjtrVvoy6m/z9itV96J62DTK3ONCCx5K04
         KWlA2xzCcMPMFLMBi1nvkI4uN8PTHflF7vWuLOFN6qC3KgmhnWKMuhC2TK6UYlSCDH
         2hZQJgnRYp/W6rIJIi8G5xPTSAK6GS8nF9704+J3XGytM9+eGM3lqgfL8n69oqAWGV
         fDukHXlFgRTJw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

No need to add semicolon after closing bracket.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/u=
lp/isert/ib_isert.c
index 5958929b7dec..96514f675427 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -1991,7 +1991,7 @@ isert_set_dif_domain(struct se_cmd *se_cmd, struct ib=
_sig_domain *domain)
 	if (se_cmd->prot_type =3D=3D TARGET_DIF_TYPE1_PROT ||
 	    se_cmd->prot_type =3D=3D TARGET_DIF_TYPE2_PROT)
 		domain->sig.dif.ref_remap =3D true;
-};
+}
=20
 static int
 isert_set_sig_attrs(struct se_cmd *se_cmd, struct ib_sig_attrs *sig_attrs)
--=20
2.25.4

