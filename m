Return-Path: <linux-rdma+bounces-15002-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E8BCBEB1A
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 16:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66DC33038947
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 15:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5D223EA99;
	Mon, 15 Dec 2025 15:34:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA6A2957B6;
	Mon, 15 Dec 2025 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765812860; cv=none; b=enPVCdAQJplaA8vL+1yx1mXT12TIf/KoEJpjzA8iywDF41HnXvVNYrHcmLHMciB8LEvmNVph1rxZ/41KRKivVu7wJ8hD6HjokMOvn5EbYxFr8Hy/n7EQRWlaUhk4nc3/3tz28J7itOAWDNpNmBAJDkbkkVCFCYFUA6LmbC7yHbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765812860; c=relaxed/simple;
	bh=Hpb5NenCmNYUHqBJsM+HGc63FVYyGgcB/OUDgss2SF4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dMookDl7arG7cv4gqWmFraF2k4IlkD2/yX2UNP7uqLTPBtEwcsIysBCuY+WduB+kdty4yMdpB3yPCcGQNR3SopjXenoh/Am/9nqgJXaVXigHVR4nSkSme89hR7aOIjhl2Bdpna86wVnDB5Hai5nXFpbf2uMGoP0oFMnLpfttHXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowACHquFpKkBpHyLPAA--.57681S2;
	Mon, 15 Dec 2025 23:34:02 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: bharat@chelsio.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] RDMA/cxgb4: fix dst refcount leak in pass_accept_req() error path
Date: Mon, 15 Dec 2025 15:33:56 +0000
Message-Id: <20251215153356.1783489-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACHquFpKkBpHyLPAA--.57681S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XF4kGr18Xr45KFWUXF1UJrb_yoW3trX_Ga
	yj9FZrXrWjkFnYkw4DKFsxurWqyw4qq3WkJwnFqFy5J34agF1xA3ykuFn5uw17Xw45Grs5
	GryDGr18CF4xWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbs8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1lc2xSY4AK67AK6ryrMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
	ZEXa7VUUq2MUUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQ4RA2lAI5sQ7wAAs7

Add missing dst_release() when alloc_ep_skb_list() fails to prevent
reference count leak of the dst obtained from route lookup.

Fixes: 4a740838bf44 ("RDMA/iw_cxgb4: Low resource fixes for connection manager")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/infiniband/hw/cxgb4/cm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index b3b45c49077d..3490b8920cf0 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -2665,6 +2665,7 @@ static int pass_accept_req(struct c4iw_dev *dev, struct sk_buff *skb)
 	}
 	goto out;
 fail:
+	dst_release(dst);
 	c4iw_put_ep(&child_ep->com);
 reject:
 	reject_cr(dev, hwtid, skb);
-- 
2.34.1


