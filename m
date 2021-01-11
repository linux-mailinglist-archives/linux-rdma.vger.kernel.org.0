Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77C8A2F18FD
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Jan 2021 15:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbhAKO6m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Jan 2021 09:58:42 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12484 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730477AbhAKO6m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Jan 2021 09:58:42 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffc67790001>; Mon, 11 Jan 2021 06:58:01 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 11 Jan
 2021 14:58:01 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 11 Jan 2021 14:57:58 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <jgg@nvidia.com>, <leonro@nvidia.com>, <sagi@grimberg.me>
CC:     <oren@nvidia.com>, <nitzanc@nvidia.com>, <sergeygo@nvidia.com>,
        <ngottlieb@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>
Subject: [PATCH 1/4] IB/iser: remove unneeded semicolons
Date:   Mon, 11 Jan 2021 14:57:51 +0000
Message-ID: <20210111145754.56727-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210111145754.56727-1-mgurtovoy@nvidia.com>
References: <20210111145754.56727-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610377081; bh=Cxq5Vo4VtK6PtCOuj76w7m41WH+kNA3eYKTrnu26C+E=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        b=kUqz3qvMol7inVcDcZnbPNo3GQ7iqX54buLlq5WnwpU4vLwdkkviKUic9P6OBwQ61
         m7YtkAX7Z41/nRSqxnghqBFljyRdBRIB2UTUxU6XkQ/57KecYZG6pNQ86QUgftZ8YE
         hqBfAswQYJKEVq4UPF/m3rXytCjnjkmvC5yCDjIms0HQPz3VHTXmWYA/pV99g45MX+
         g20+hTjhwJFDo2QJGtgWlPLmbag1JgcX0kbDJP5rFW65lOgULGRt1zTembe3cfBkt8
         XR0EWVVzvUp6GMZRyX4dBMdA4uhb6/n6UTC+DCWbmDUqfCFORAy5EmLGs49nmf69m/
         Y/N1LHEHOmHeg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

No need to add semicolon after closing bracket.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/iser/iser_memory.c | 3 +--
 drivers/infiniband/ulp/iser/iser_verbs.c  | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iser_memory.c b/drivers/infiniband=
/ulp/iser/iser_memory.c
index d4e057fac219..afec40da9b58 100644
--- a/drivers/infiniband/ulp/iser/iser_memory.c
+++ b/drivers/infiniband/ulp/iser/iser_memory.c
@@ -169,7 +169,7 @@ iser_set_dif_domain(struct scsi_cmnd *sc, struct ib_sig=
_domain *domain)
 	domain->sig.dif.ref_escape =3D true;
 	if (sc->prot_flags & SCSI_PROT_REF_INCREMENT)
 		domain->sig.dif.ref_remap =3D true;
-};
+}
=20
 static int
 iser_set_sig_attrs(struct scsi_cmnd *sc, struct ib_sig_attrs *sig_attrs)
@@ -390,4 +390,3 @@ int iser_reg_mem_fastreg(struct iscsi_iser_task *task,
=20
 	return err;
 }
-
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/=
ulp/iser/iser_verbs.c
index 2bd18b006893..136f6c4492e0 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -685,7 +685,7 @@ static void iser_cleanup_handler(struct rdma_cm_id *cma=
_id,
 	iser_disconnected_handler(cma_id);
 	iser_free_ib_conn_res(iser_conn, destroy);
 	complete(&iser_conn->ib_completion);
-};
+}
=20
 static int iser_cma_handler(struct rdma_cm_id *cma_id, struct rdma_cm_even=
t *event)
 {
--=20
2.25.4

