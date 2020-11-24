Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F272C34B4
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Nov 2020 00:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388981AbgKXXel (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 24 Nov 2020 18:34:41 -0500
Received: from nat-hk.nvidia.com ([203.18.50.4]:17064 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbgKXXel (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 24 Nov 2020 18:34:41 -0500
Received: from HKMAIL101.nvidia.com (Not Verified[10.18.92.77]) by nat-hk.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fbd988e0000>; Wed, 25 Nov 2020 07:34:39 +0800
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 24 Nov
 2020 23:34:38 +0000
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 24 Nov 2020 23:34:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrQyXlLDafkR/SWIQ9LspMs8C+n7RMvooUZN/kFT8cHSr6UFM3wOjIqEorTav1w4AJh2r/6ytOWTlBhp8Mb/6s4MWm9HRqiAuGqYYFWQvfPYKjcgZhBJ10KAQ+Wj+stevBnEnhrkspbMjZHEsh2evgNXjYHlbPVnLEAmzKChIURum9HxK7R/7P5VX/rq/moUsbXCuFyYDwndClXy56NNoYx20UwvXcpLOoeN+r2J0B67uF5wObelxv8DJ5pZCieKTo8EyhGQqaqeCWg6NgO/oRGMI3kBJfiemV/3a9diNaQiKrFMrFCPFhR0EUVFasI4SUigOEvZLiLQC05S8Bk4Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwVNP9MmoYgUM5Ng1T6mu03+gtQKaiEUyvH6DZlZl2A=;
 b=en6CZco1S80KeRA5ccFNYrQhrgdRaEp59gaLkkgrN1cf6mvFydmP6F1q2FmryX4LW6tFiu3eVOy9a5RhwW/1RHwcd78Ue0nsa/28TccuL58K7YxfAjveiMm8UzF9WGrvB+AdMQlzPj1YTVRpHwoXyy0OtuLGWZvhTtiYejSgdupKBIvYbkQSCneuhPeAinjngkeC+/sSZHF6qqMAeKDrpIqSVO/yitMusIYSZJvp4CUcxoRv4T4drEdn+dWoDe/K+rBXzZ9VsCAnrC4weMYjj083M7bdpC4RwNlNDhybCbdn7HdVPQFVBN2eZeWJTouSgp0W+mymlBl02gpRa6vmow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3402.namprd12.prod.outlook.com (2603:10b6:5:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.29; Tue, 24 Nov
 2020 23:34:34 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::e40c:730c:156c:2ef9%7]) with mapi id 15.20.3589.022; Tue, 24 Nov 2020
 23:34:34 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     Leon Romanovsky <leonro@mellanox.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH] RDMA/mlx5: Check for ERR_PTR from uverbs_zalloc()
Date:   Tue, 24 Nov 2020 19:34:33 -0400
Message-ID: <0-v1-4d05ccc1c223+173-devx_err_ptr_jgg@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:208:2d::21) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by BL0PR03CA0008.namprd03.prod.outlook.com (2603:10b6:208:2d::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Tue, 24 Nov 2020 23:34:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1khhpR-0010WV-Ch; Tue, 24 Nov 2020 19:34:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1606260879; bh=MH9Hh9HQ2frngCFObaq+9/y7ABNKpboZELwh6zrx6I8=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         CC:Subject:Date:Message-ID:Content-Transfer-Encoding:Content-Type:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType;
        b=HeI1qCEi6Xn2Y4e0kV8fBX02yJGEHAViDVzTkwaLtTG5DgnwRv/lXXQHhJUgzhiF7
         JI/UW2fZN3tiQ2Ip2O8SAWj88tU8p2Iv+W2oCPe37jDHCPGZL9Nc7JwJbI+qM6pwx0
         7naT6+hMfIYzuR2h6zYqsSEz7hQyGjvbjyVvf5nlhzgYK9ZdSrKOJ9QQOhlBWOgN6y
         oYQmKXAk9k4cu6abdCM0E5BfuajL40H7j+h1qfuucRFKJstdfZ4TGBd5NtC2GTj24r
         PvxeyXS384I2onYYdFd1dKOQX2B/qV4vzt+tAjikQ/GDoQ3KiO69Sxd66EEldTIHn1
         YXF40xma86Wwg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The return code from uverbs_zalloc() was wrongly checked, it is ERR_PTR
not NULL like other allocators:

drivers/infiniband/hw/mlx5/devx.c:2110 devx_umem_reg_cmd_alloc() warn: pass=
ing zero to 'PTR_ERR'

Fixes: 878f7b31c3a7 ("RDMA/mlx5: Use ib_umem_find_best_pgsz() for devx")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/hw/mlx5/devx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5=
/devx.c
index 7c3eefba619716..ad0173f62c0e95 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -2106,7 +2106,7 @@ static int devx_umem_reg_cmd_alloc(struct mlx5_ib_dev=
 *dev,
 		     (MLX5_ST_SZ_BYTES(mtt) *
 		      ib_umem_num_dma_blocks(obj->umem, page_size));
 	cmd->in =3D uverbs_zalloc(attrs, cmd->inlen);
-	if (!cmd->in)
+	if (IS_ERR(cmd->in))
 		return PTR_ERR(cmd->in);
=20
 	umem =3D MLX5_ADDR_OF(create_umem_in, cmd->in, umem);
--=20
2.29.2

