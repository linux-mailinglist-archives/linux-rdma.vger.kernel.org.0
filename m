Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27BE5320B0B
	for <lists+linux-rdma@lfdr.de>; Sun, 21 Feb 2021 15:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhBUOpU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 21 Feb 2021 09:45:20 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1388 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhBUOpQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 21 Feb 2021 09:45:16 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B603271d40002>; Sun, 21 Feb 2021 06:44:36 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 21 Feb
 2021 14:44:35 +0000
Received: from dev-l-vrt-092.mtl.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 21 Feb 2021 14:44:34 +0000
From:   Alaa Hleihel <alaa@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     <leonro@nvidia.com>, <jgg@nvidia.com>
Subject: [PATCH rdma-core] kernel-boot: Fix VF lookup
Date:   Sun, 21 Feb 2021 16:44:19 +0200
Message-ID: <20210221144419.3265692-1-alaa@nvidia.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1613918676; bh=7ZAc8gQd0HxcPYSyZjK8cVBolMOX9ra5Rb9W1VuRA6k=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         X-NVConfidentiality:Content-Transfer-Encoding:Content-Type;
        b=BC/8yEEPyKX5sibRbvbnlxunK/USVSvHE7oMKWAkqqh5Diieq5IpAUr08TT90DrX3
         mLyICuCtl+6y3vd5NFZoOLVl9wiALxksRYwS6DMe/pZ4cC3a9txzb6npM5wQI/T0lw
         5YccJCyW/QPFDJo+ZbGQGnWJFNyVUIiReNAlfNXNU5NTVQL91v7xDg6mrRS19Da/63
         ayhIsgznQYMyVJTc1ROPjyx4MpIOFylIVx+kP9IrZriG2BHgqI4Dsw9HDuTZpRHB2l
         16dIXwJt2sEax4tJL3XF6BOWVEU9D80NOBByLu/intarY3xSTfZ8EmJqZdaqLrqS3M
         iw+KfvYcRYkGg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In function get_virtfn_info() we only compared the PCI function
number. That is not enough as we can match with wrong device.
This issue can be seen on systems with a large numbers of VFs.

Fix it by also comparing the PCI slot numbers.

Fixes: 72f852c72a78 ("kernel-boot: Separate PCI fill function")
Signed-off-by: Alaa Hleihel <alaa@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
Pull request at github: https://github.com/linux-rdma/rdma-core/pull/950
---
 kernel-boot/rdma_rename.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel-boot/rdma_rename.c b/kernel-boot/rdma_rename.c
index e1ec8b198780..4af9e4a396f2 100644
--- a/kernel-boot/rdma_rename.c
+++ b/kernel-boot/rdma_rename.c
@@ -338,7 +338,8 @@ static int get_virtfn_info(struct data *d, struct pci_i=
nfo *p)
 			ret =3D -ENOMEM;
 			goto err_dir;
 		}
-		if (vf.func =3D=3D v.func) {
+		if (vf.func =3D=3D v.func &&
+		    vf.slot =3D=3D v.slot) {
 			p->vf =3D atoi(&dent->d_name[6]);
 			break;
 		}
--=20
2.26.2

