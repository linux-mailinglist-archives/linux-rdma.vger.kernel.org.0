Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3C02F1900
	for <lists+linux-rdma@lfdr.de>; Mon, 11 Jan 2021 15:59:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbhAKO6v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 Jan 2021 09:58:51 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12517 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbhAKO6v (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 11 Jan 2021 09:58:51 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffc67830000>; Mon, 11 Jan 2021 06:58:11 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 11 Jan
 2021 14:58:10 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 11 Jan 2021 14:58:07 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <jgg@nvidia.com>, <leonro@nvidia.com>, <sagi@grimberg.me>
CC:     <oren@nvidia.com>, <nitzanc@nvidia.com>, <sergeygo@nvidia.com>,
        <ngottlieb@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
        Israel Rukshin <israelr@nvidia.com>
Subject: [PATCH 4/4] IB/iser: simplify prot_caps setting
Date:   Mon, 11 Jan 2021 14:57:54 +0000
Message-ID: <20210111145754.56727-5-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210111145754.56727-1-mgurtovoy@nvidia.com>
References: <20210111145754.56727-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610377091; bh=3VIYVMTHUD5m49q/OBQcV8Xbxrj7Ghhec155GhmOVaA=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
         References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        b=qFezsqPlerpeW8Bu5OLuXMVqIfnQnp04jiBqYP4JhoX7SiQvU4lrTBmkv3a/0q9eq
         BtvLRo+DK4mMJogiywcraC4XL8ioAvf4DmfZl4cjjBwuLwE2nWcndLRZb2OQbar8Ti
         AsgN4P8sIF55acebWU9N8BCJv0UBbagp6Vr1FlGUrhHeAM86OpJNbApyXrPWBJG02J
         Ryi/doSdtBNE1sVt4KqpmFWGkdas3G5dU4WqfAVJy2pyEZ/VNljIbOLXYe30Lx45CD
         k69umMN8Vhb8+1ECdMKACLsQMIXM4l1Z/k+7G0ooc6vfcalyEPABKNYK/k3c6FQtmB
         0wQi0EeIqsw0g==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reduce the number of instructions made for setting protection caps. No
need to do bitwise OR with 0 since we can zero the return value in the
beginning of the function.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/infiniband/ulp/iser/iscsi_iser.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/=
ulp/iser/iscsi_iser.c
index fcfdeb5dea42..8fcaa1136f2c 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -590,13 +590,20 @@ iscsi_iser_session_destroy(struct iscsi_cls_session *=
cls_session)
 static inline unsigned int
 iser_dif_prot_caps(int prot_caps)
 {
-	return ((prot_caps & IB_PROT_T10DIF_TYPE_1) ?
-		SHOST_DIF_TYPE1_PROTECTION | SHOST_DIX_TYPE0_PROTECTION |
-		SHOST_DIX_TYPE1_PROTECTION : 0) |
-	       ((prot_caps & IB_PROT_T10DIF_TYPE_2) ?
-		SHOST_DIF_TYPE2_PROTECTION | SHOST_DIX_TYPE2_PROTECTION : 0) |
-	       ((prot_caps & IB_PROT_T10DIF_TYPE_3) ?
-		SHOST_DIF_TYPE3_PROTECTION | SHOST_DIX_TYPE3_PROTECTION : 0);
+	int ret =3D 0;
+
+	if (prot_caps & IB_PROT_T10DIF_TYPE_1)
+		ret |=3D SHOST_DIF_TYPE1_PROTECTION |
+		       SHOST_DIX_TYPE0_PROTECTION |
+		       SHOST_DIX_TYPE1_PROTECTION;
+	if (prot_caps & IB_PROT_T10DIF_TYPE_2)
+		ret |=3D SHOST_DIF_TYPE2_PROTECTION |
+		       SHOST_DIX_TYPE2_PROTECTION;
+	if (prot_caps & IB_PROT_T10DIF_TYPE_3)
+		ret |=3D SHOST_DIF_TYPE3_PROTECTION |
+		       SHOST_DIX_TYPE3_PROTECTION;
+
+	return ret;
 }
=20
 /**
--=20
2.25.4

