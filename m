Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBDA279849
	for <lists+linux-rdma@lfdr.de>; Sat, 26 Sep 2020 12:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgIZKT7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 26 Sep 2020 06:19:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:36258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIZKT7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 26 Sep 2020 06:19:59 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A70C2238E2;
        Sat, 26 Sep 2020 10:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601115598;
        bh=FmsXUvsU+oKtquDtvVu6BoxcxqvS8mVdGxNfKJVCpMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fd1MGIUgJKX+R1Zf/5vcWDHBy6kbW26tzs0Lf1vO/FDiKT+Pr3Ezwt1+lFO/CyFBg
         nZNaBAx0WNxZS2gJm9uthjPCHVw5HmKZs7wntDS/69KUMOMVqibMtvqHF0yVbIClrV
         p4vLL3cvLVMS3vZEzghajEuiEfaPKH04TYkEoGXU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v3 5/9] RDMA/cma: Be strict with attaching to CMA device
Date:   Sat, 26 Sep 2020 13:19:34 +0300
Message-Id: <20200926101938.2964394-6-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200926101938.2964394-1-leon@kernel.org>
References: <20200926101938.2964394-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The RDMA-CM code wasn't consistent in flows that attached to cma_dev,
this caused to situations where a failure during attach to listen on such
device leaves RDMA-CM in a non-consistent state.

Change the _cma_attach_to_dev to return an error in case of failure,
so listen/attach flows will deal correctly with the failures.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c | 42 +++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 84c7f2f60a6a..9d32572c514a 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -444,8 +444,8 @@ static int cma_igmp_send(struct net_device *ndev, union ib_gid *mgid, bool join)
 	return (in_dev) ? 0 : -ENODEV;
 }
 
-static void _cma_attach_to_dev(struct rdma_id_private *id_priv,
-			       struct cma_device *cma_dev)
+static int _cma_attach_to_dev(struct rdma_id_private *id_priv,
+			      struct cma_device *cma_dev)
 {
 	cma_dev_get(cma_dev);
 	id_priv->cma_dev = cma_dev;
@@ -456,15 +456,22 @@ static void _cma_attach_to_dev(struct rdma_id_private *id_priv,
 	rdma_restrack_add(&id_priv->res);
 
 	trace_cm_id_attach(id_priv, cma_dev->device);
+	return 0;
 }
 
-static void cma_attach_to_dev(struct rdma_id_private *id_priv,
-			      struct cma_device *cma_dev)
+static int cma_attach_to_dev(struct rdma_id_private *id_priv,
+			     struct cma_device *cma_dev)
 {
-	_cma_attach_to_dev(id_priv, cma_dev);
+	int ret;
+
+	ret = _cma_attach_to_dev(id_priv, cma_dev);
+	if (ret)
+		return ret;
+
 	id_priv->gid_type =
 		cma_dev->default_gid_type[id_priv->id.port_num -
 					  rdma_start_port(cma_dev->device)];
+	return 0;
 }
 
 static void cma_release_dev(struct rdma_id_private *id_priv)
@@ -629,8 +636,7 @@ static int cma_acquire_dev_by_src_ip(struct rdma_id_private *id_priv)
 			if (!IS_ERR(sgid_attr)) {
 				id_priv->id.port_num = port;
 				cma_bind_sgid_attr(id_priv, sgid_attr);
-				cma_attach_to_dev(id_priv, cma_dev);
-				ret = 0;
+				ret = cma_attach_to_dev(id_priv, cma_dev);
 				goto out;
 			}
 		}
@@ -659,6 +665,7 @@ static int cma_ib_acquire_dev(struct rdma_id_private *id_priv,
 	const struct ib_gid_attr *sgid_attr;
 	enum ib_gid_type gid_type;
 	union ib_gid gid;
+	int ret;
 
 	if (dev_addr->dev_type != ARPHRD_INFINIBAND &&
 	    id_priv->id.ps == RDMA_PS_IPOIB)
@@ -684,9 +691,9 @@ static int cma_ib_acquire_dev(struct rdma_id_private *id_priv,
 	 * cma_process_remove().
 	 */
 	mutex_lock(&lock);
-	cma_attach_to_dev(id_priv, listen_id_priv->cma_dev);
+	ret = cma_attach_to_dev(id_priv, listen_id_priv->cma_dev);
 	mutex_unlock(&lock);
-	return 0;
+	return ret;
 }
 
 static int cma_iw_acquire_dev(struct rdma_id_private *id_priv,
@@ -741,7 +748,7 @@ static int cma_iw_acquire_dev(struct rdma_id_private *id_priv,
 
 out:
 	if (!ret)
-		cma_attach_to_dev(id_priv, cma_dev);
+		ret = cma_attach_to_dev(id_priv, cma_dev);
 
 	mutex_unlock(&lock);
 	return ret;
@@ -758,7 +765,7 @@ static int cma_resolve_ib_dev(struct rdma_id_private *id_priv)
 	unsigned int p;
 	u16 pkey, index;
 	enum ib_port_state port_state;
-	int i;
+	int i, ret;
 
 	cma_dev = NULL;
 	addr = (struct sockaddr_ib *) cma_dst_addr(id_priv);
@@ -801,8 +808,10 @@ static int cma_resolve_ib_dev(struct rdma_id_private *id_priv)
 	return -ENODEV;
 
 found:
-	cma_attach_to_dev(id_priv, cma_dev);
+	ret = cma_attach_to_dev(id_priv, cma_dev);
 	mutex_unlock(&lock);
+	if (ret)
+		return ret;
 	addr = (struct sockaddr_ib *)cma_src_addr(id_priv);
 	memcpy(&addr->sib_addr, &sgid, sizeof(sgid));
 	cma_translate_ib(addr, &id_priv->id.route.addr.dev_addr);
@@ -2513,7 +2522,9 @@ static int cma_listen_on_dev(struct rdma_id_private *id_priv,
 	memcpy(cma_src_addr(dev_id_priv), cma_src_addr(id_priv),
 	       rdma_addr_size(cma_src_addr(id_priv)));
 
-	_cma_attach_to_dev(dev_id_priv, cma_dev);
+	ret = _cma_attach_to_dev(dev_id_priv, cma_dev);
+	if (ret)
+		goto err_attach;
 	list_add_tail(&dev_id_priv->listen_list, &id_priv->listen_list);
 	cma_id_get(id_priv);
 	dev_id_priv->internal_id = 1;
@@ -2527,6 +2538,7 @@ static int cma_listen_on_dev(struct rdma_id_private *id_priv,
 	return 0;
 err_listen:
 	list_del(&id_priv->listen_list);
+err_attach:
 	dev_warn(&cma_dev->device->dev, "RDMA CMA: %s, error %d\n", __func__, ret);
 	rdma_destroy_id(&dev_id_priv->id);
 	return ret;
@@ -3121,7 +3133,9 @@ static int cma_bind_loopback(struct rdma_id_private *id_priv)
 	rdma_addr_set_sgid(&id_priv->id.route.addr.dev_addr, &gid);
 	ib_addr_set_pkey(&id_priv->id.route.addr.dev_addr, pkey);
 	id_priv->id.port_num = p;
-	cma_attach_to_dev(id_priv, cma_dev);
+	ret = cma_attach_to_dev(id_priv, cma_dev);
+	if (ret)
+		goto out;
 	cma_set_loopback(cma_src_addr(id_priv));
 out:
 	mutex_unlock(&lock);
-- 
2.26.2

