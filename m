Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B627C46E8EB
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Dec 2021 14:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237698AbhLINUE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 9 Dec 2021 08:20:04 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43060 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237724AbhLINUD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 9 Dec 2021 08:20:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 369F3CE25B2;
        Thu,  9 Dec 2021 13:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94451C004DD;
        Thu,  9 Dec 2021 13:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639055786;
        bh=F3m5fBX84JidvrgmrY/pV9dmlTEPpKnxeK6GPMGoKrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=saSMYIv8cEjCLq+tS77bmSzDxE3ooJ+uFgb16Oa79OmL+yowGpmnzxm1ZBITjP9RX
         o8XqhtGkc7GXUZs58hnWzWVUm9n8FL0/cRdvcJDbnWZ2IYgqEX6SvHR37EN2UcXJAq
         AZitj/fSumCHv2hDs1+4WdZHAXSmhaNPErYele7QqsgVvRj/EqFY2l4n59IXvy2RzU
         LNJSPhi2j3Mv03Xbyl0iWbjjQsb4My7DGcFRcs5Se3v4auThQvFPZe+kRH6Xut1r1R
         MuZwwbAAUbLbbKO+WyGUnVlIQB0MRohMTvprGYqXcTOZtKmJ1Bfb6cD2Ezt8kSA7bk
         Fc0pUPTvpOtow==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Avihai Horon <avihaih@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Mark Zhang <markzhang@nvidia.com>
Subject: [PATCH rdma-next v1 3/3] RDMA/cma: Let cma_resolve_ib_dev() continue search even after empty entry
Date:   Thu,  9 Dec 2021 15:16:07 +0200
Message-Id: <b7346307e3bb396c43d67d924348c6c496493991.1639055490.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639055490.git.leonro@nvidia.com>
References: <cover.1639055490.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Avihai Horon <avihaih@nvidia.com>

Currently, when cma_resolve_ib_dev() searches for a matching GID it will
stop searching after encountering the first empty GID table entry. This
behavior is wrong since neither IB nor RoCE spec enforce tightly packed
GID tables.

For example, when the matching valid GID entry exists at index N, and if
a GID entry is empty at index N-1, cma_resolve_ib_dev() will fail to
find the matching valid entry.

Fix it by making cma_resolve_ib_dev() continue searching even after
encountering missing entries.

Fixes: f17df3b0dede ("RDMA/cma: Add support for AF_IB to rdma_resolve_addr()")
Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cma.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 8a98aa90956f..27a00ce2e101 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -766,6 +766,7 @@ static int cma_resolve_ib_dev(struct rdma_id_private *id_priv)
 	unsigned int p;
 	u16 pkey, index;
 	enum ib_port_state port_state;
+	int ret;
 	int i;
 
 	cma_dev = NULL;
@@ -784,9 +785,14 @@ static int cma_resolve_ib_dev(struct rdma_id_private *id_priv)
 
 			if (ib_get_cached_port_state(cur_dev->device, p, &port_state))
 				continue;
-			for (i = 0; !rdma_query_gid(cur_dev->device,
-						    p, i, &gid);
-			     i++) {
+
+			for (i = 0; i < cur_dev->device->port_data[p].immutable.gid_tbl_len;
+			     ++i) {
+				ret = rdma_query_gid(cur_dev->device, p, i,
+						     &gid);
+				if (ret)
+					continue;
+
 				if (!memcmp(&gid, dgid, sizeof(gid))) {
 					cma_dev = cur_dev;
 					sgid = gid;
-- 
2.33.1

