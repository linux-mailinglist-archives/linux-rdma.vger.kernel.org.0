Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3057D3DCAE1
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Aug 2021 11:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhHAJXM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 1 Aug 2021 05:23:12 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:55609 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231446AbhHAJXL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 1 Aug 2021 05:23:11 -0400
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AOwFzqay8Krp2i7N1pzyEKrPwxr1zdoMgy1kn?=
 =?us-ascii?q?xilNoRw8SK2lfqeV7ZMmPH7P+VAssR4b6LO90cW7Lk80lqQFhbX5X43SPjUO0V?=
 =?us-ascii?q?HAROoJgOffKlbbexEWmNQy6U4ZSdkaNDTvNykBse/KpBm/D807wMSKtIShheLl?=
 =?us-ascii?q?xX9rSg1wApsQlztRO0KKFFFsXglaCd4cHJqY3MBOoD2tYjA5dcK+b0N1JNTrlp?=
 =?us-ascii?q?nako78ex4aC1oC4AmKtzmh77n3CFy5834lIkpy/Ys=3D?=
X-IronPort-AV: E=Sophos;i="5.84,286,1620662400"; 
   d="scan'208";a="112191140"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 01 Aug 2021 17:22:53 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 8A2E64D0BA67;
        Sun,  1 Aug 2021 17:22:49 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 1 Aug 2021 17:22:50 +0800
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 1 Aug 2021 17:22:50 +0800
Received: from FNSTPC.g08.fujitsu.local (10.167.226.45) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 1 Aug 2021 17:22:49 +0800
From:   Li Zhijian <lizhijian@cn.fujitsu.com>
To:     <leon@kernel.org>, <dledford@redhat.com>, <jgg@ziepe.ca>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: [PATCH] RDMA/mlx5: return the EFAULT per ibv_advise_mr(3)
Date:   Sun, 1 Aug 2021 17:20:50 +0800
Message-ID: <20210801092050.6322-1-lizhijian@cn.fujitsu.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 8A2E64D0BA67.AFA37
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ibv_advise_mr(3) says:
EFAULT In one of the following: o When the range requested is out of the  MR  bounds,
       or  when  parts of it are not part of the process address space. o One of the
       lkeys provided in the scatter gather list is invalid or with wrong write access

Actually get_prefetchable_mr() will return NULL if it see above conditions

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 drivers/infiniband/hw/mlx5/odp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index d0d98e584ebc..8d2a626c87cf 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1791,7 +1791,7 @@ static int mlx5_ib_prefetch_sg_list(struct ib_pd *pd,
 
 		mr = get_prefetchable_mr(pd, advice, sg_list[i].lkey);
 		if (!mr)
-			return -ENOENT;
+			return -EFAULT;
 		ret = pagefault_mr(mr, sg_list[i].addr, sg_list[i].length,
 				   &bytes_mapped, pf_flags);
 		if (ret < 0) {
-- 
2.30.2



