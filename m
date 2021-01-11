Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02F82F18FE
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Jan 2021 15:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731246AbhAKO6p (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Jan 2021 09:58:45 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8482 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730477AbhAKO6p (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Jan 2021 09:58:45 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffc677c0002>; Mon, 11 Jan 2021 06:58:04 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 11 Jan
 2021 14:58:04 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 11 Jan 2021 14:58:01 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <jgg@nvidia.com>, <leonro@nvidia.com>, <sagi@grimberg.me>
CC:     <oren@nvidia.com>, <nitzanc@nvidia.com>, <sergeygo@nvidia.com>,
        <ngottlieb@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>
Subject: [PATCH 2/4] IB/iser: protect iscsi_max_lun module param using callback
Date:   Mon, 11 Jan 2021 14:57:52 +0000
Message-ID: <20210111145754.56727-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210111145754.56727-1-mgurtovoy@nvidia.com>
References: <20210111145754.56727-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610377084; bh=bKoMCsnlxVBXhOpWl+UtP73JhQLZQJ9meXARfRubgYk=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        b=a+X8OWuipHJIyDz69LOgOxs7AIvxeUcfQ/e8sWWkWNL5oAEdfrFmum8NDXMz03rjQ
         TbxkoOnaqdbOiqVipzgIJy3aaoyBDhogPslRKGpINoToEJuv2AyWzCRprLH82rGuM2
         +kjiIONhB1nlZT0NdkzOMYHzjIvNStPC002gIIwN713MPaiF+5RTW9YOOm99unsl14
         5IH7f0MmCd2dyU5setl6CZShgewlxUkrtWReS5Gi2tzsuJUe73odfNd8lmtTHB4ykq
         46au9a4pTj/K53nP9NE9cwH4y4J9uA5vN3L8CkI06cvO+arQxM4nL+81BQAQXUJ8Xk
         Nj2fSsrg4kR/g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Remove the check from the module_init function.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/iser/iscsi_iser.c | 27 ++++++++++++++++++------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/=
ulp/iser/iscsi_iser.c
index 4792b9bf400f..906f52873d63 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -89,9 +89,15 @@ int iser_debug_level =3D 0;
 module_param_named(debug_level, iser_debug_level, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(debug_level, "Enable debug tracing if > 0 (default:disabl=
ed)");
=20
+static int iscsi_iser_set(const char *val, const struct kernel_param *kp);
+static const struct kernel_param_ops iscsi_iser_size_ops =3D {
+	.set =3D iscsi_iser_set,
+	.get =3D param_get_uint,
+};
+
 static unsigned int iscsi_max_lun =3D 512;
-module_param_named(max_lun, iscsi_max_lun, uint, S_IRUGO);
-MODULE_PARM_DESC(max_lun, "Max LUNs to allow per session (default:512");
+module_param_cb(max_lun, &iscsi_iser_size_ops, &iscsi_max_lun, S_IRUGO);
+MODULE_PARM_DESC(max_lun, "Max LUNs to allow per session, should > 0 (defa=
ult:512)");
=20
 unsigned int iser_max_sectors =3D ISER_DEF_MAX_SECTORS;
 module_param_named(max_sectors, iser_max_sectors, uint, S_IRUGO | S_IWUSR)=
;
@@ -110,6 +116,18 @@ int iser_pi_guard;
 module_param_named(pi_guard, iser_pi_guard, int, S_IRUGO);
 MODULE_PARM_DESC(pi_guard, "T10-PI guard_type [deprecated]");
=20
+static int iscsi_iser_set(const char *val, const struct kernel_param *kp)
+{
+	int ret;
+	unsigned int n =3D 0;
+
+	ret =3D kstrtouint(val, 10, &n);
+	if (ret !=3D 0 || n =3D=3D 0)
+		return -EINVAL;
+
+	return param_set_uint(val, kp);
+}
+
 /*
  * iscsi_iser_recv() - Process a successful recv completion
  * @conn:         iscsi connection
@@ -1009,11 +1027,6 @@ static int __init iser_init(void)
=20
 	iser_dbg("Starting iSER datamover...\n");
=20
-	if (iscsi_max_lun < 1) {
-		iser_err("Invalid max_lun value of %u\n", iscsi_max_lun);
-		return -EINVAL;
-	}
-
 	memset(&ig, 0, sizeof(struct iser_global));
=20
 	ig.desc_cache =3D kmem_cache_create("iser_descriptors",
--=20
2.25.4

