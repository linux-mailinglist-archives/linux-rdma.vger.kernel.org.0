Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7158F2F0698
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Jan 2021 12:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbhAJLTs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Jan 2021 06:19:48 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:18091 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbhAJLTr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Jan 2021 06:19:47 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffae2ab0000>; Sun, 10 Jan 2021 03:19:07 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 10 Jan
 2021 11:19:06 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Sun, 10 Jan 2021 11:19:04 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <jgg@nvidia.com>, <leonro@nvidia.com>, <sagi@grimberg.me>
CC:     <oren@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>
Subject: [PATCH 1/3] IB/isert: remove unneeded new lines
Date:   Sun, 10 Jan 2021 11:19:01 +0000
Message-ID: <20210110111903.486681-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610277547; bh=rc1VKP2/YGZ8ioiFUhEambBaOc8oB8trEDLsWHSG2MM=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         Content-Transfer-Encoding:Content-Type;
        b=g7qx8holiaU+uFN6VLMnzc6+v7PFxl61R8UOn1dbOwKOyEkM7CcaQJRRFv1zyPagm
         7uthoy3AF2VGV/B6MlG09acaWAAu2dFTrw5eUQMkH2WEigqfZU/I1LCxESSr8Zli2C
         BeSFov8cYXe4vb7v5Je5ePKLmyXHXFFEHqWqYx4jO8WBuxaVUwrSa1mTBxvPT+s82Y
         twg6MyT9vd5OsMY3AojVIS5PG8he/T5BO5Z8i+SejqBA8OT00fNp+/3Vwfgjmkgbvj
         5ZCVOdDj9BkkW+nvSjO2pgRyqPQQBAGcV1fkqRWYo2saYmJB6wdCcs+etQ1ZJVBF4+
         aAOUJt2khgZjA==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The Linux convention is to have only 1 new line between functions.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/u=
lp/isert/ib_isert.c
index 2ba27221ea85..5958929b7dec 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -71,7 +71,6 @@ static int isert_sg_tablesize_set(const char *val, const =
struct kernel_param *kp
 	return param_set_int(val, kp);
 }
=20
-
 static inline bool
 isert_prot_cmd(struct isert_conn *conn, struct se_cmd *cmd)
 {
@@ -79,7 +78,6 @@ isert_prot_cmd(struct isert_conn *conn, struct se_cmd *cm=
d)
 		cmd->prot_op !=3D TARGET_PROT_NORMAL);
 }
=20
-
 static void
 isert_qp_event_callback(struct ib_event *e, void *context)
 {
--=20
2.25.4

