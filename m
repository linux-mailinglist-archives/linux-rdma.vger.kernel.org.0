Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC11846E8E9
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Dec 2021 14:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbhLINUA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Dec 2021 08:20:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237698AbhLINT7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Dec 2021 08:19:59 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3706BC061353;
        Thu,  9 Dec 2021 05:16:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 060AECE25C0;
        Thu,  9 Dec 2021 13:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60937C004DD;
        Thu,  9 Dec 2021 13:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639055782;
        bh=KOc8BLRYSBi58zVClsB+iA6Q32lJlqn/y4JFjjNo/k8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ah/s36ihTb2pYmOxYdPsDIo1IztQbwi5FiRcdgMafFzleYb1SQuIfXWwyFV0SFVBs
         mG2AlRRJh4T6q4eMbVJswSshewGwhOTcUgKnh7iTlJmcAD9tZ2JbFt4+XnZjpnUp8U
         ydPUeUxgwsC0Co+vx3oze1mnHfWsT/IqccRYUqksf139VZIyPMhQa2wXyV8B9ndRiy
         RZO+F/wjDWFlGGxoPUfDqAqF+eulYKhb+k9a/GSQMAwHZeoGS5GtTpu89T6SGEedDp
         md2P16VITWl1mlkwti2eBHOiSbEqCEcQxRqZ5pWOwIURVDOjrl8oF0ceK88YoWdf+E
         of2qdGu+LuWXA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Avihai Horon <avihaih@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next v1 2/3] RDMA/core: Let ib_find_gid() continue search even after empty entry
Date:   Thu,  9 Dec 2021 15:16:06 +0200
Message-Id: <e55d331b96cecfc2cf19803d16e7109ea966882d.1639055490.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639055490.git.leonro@nvidia.com>
References: <cover.1639055490.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Avihai Horon <avihaih@nvidia.com>

Currently, ib_find_gid() will stop searching after encountering the
first empty GID table entry. This behavior is wrong since neither IB
nor RoCE spec enforce tightly packed GID tables.

For example, when a valid GID entry exists at index N, and if a GID
entry is empty at index N-1, ib_find_gid() will fail to find the valid
entry.

Fix it by making ib_find_gid() continue searching even after
encountering missing entries.

Fixes: 5eb620c81ce3 ("IB/core: Add helpers for uncached GID and P_Key searches")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 22a4adda7981..a311df07b1bd 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -2461,7 +2461,8 @@ int ib_find_gid(struct ib_device *device, union ib_gid *gid,
 		     ++i) {
 			ret = rdma_query_gid(device, port, i, &tmp_gid);
 			if (ret)
-				return ret;
+				continue;
+
 			if (!memcmp(&tmp_gid, gid, sizeof *gid)) {
 				*port_num = port;
 				if (index)
-- 
2.33.1

