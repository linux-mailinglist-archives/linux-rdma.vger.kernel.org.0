Return-Path: <linux-rdma+bounces-15003-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 125A3CBEC85
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 16:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8267B3001625
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Dec 2025 15:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D6D30B50A;
	Mon, 15 Dec 2025 15:56:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6117530AACC;
	Mon, 15 Dec 2025 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765814176; cv=none; b=VEnNLqEnmBKRm+Pi/ssa0/kZG/sPpkrfQQRrJx9XQAjzdkStuyeiuJE+Yhrd5l7bN/ynqudh6OzBNG4pQXRvJcYhVCwiPDbmliYHrxYHnTS3nsyrriumHDf61uBTZ0XMv+SyoMKhyRyu6wJyvNpmsr0w7Igm8hjcUt3ckcUvN8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765814176; c=relaxed/simple;
	bh=4iiaLV5bvH8bmJ282VRDMz+f7RUc5iq3/3XvqJmjIbg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PEKO4sGHr71b8wyeMtDJ1WJd96lol3wZhiz03vuYTE7bz+5/mfHQtXkmvHveZhFHSdSSxzy0NHQTxBOMvUzby+WACzDJupnvzrFibZpb4T01HGu4y/ZwvhweliAtq1CFbes5AjrQrlxLSsQb54ou79awOz5RxZTEb2CSf3zR7Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAD3GOCYL0BpDmjPAA--.57565S2;
	Mon, 15 Dec 2025 23:56:08 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: bharat@chelsio.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] RDMA/cxgb4: fix a memory leak in pass_accept_req() error path
Date: Mon, 15 Dec 2025 15:56:07 +0000
Message-Id: <20251215155607.1787217-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAD3GOCYL0BpDmjPAA--.57565S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFyDZrW7AF47CFWfCF18Grg_yoWDurg_CF
	W8tanrXrWjkFn2kwsrKFsxursFyw4jvw1rJwsFqa43J343tF1fZ39a9rn8uw17Zr45AFZ8
	GryDCw1xGr43GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRERA2lAI5sbIQAAsh

In the alloc_ep_skb_list() failure path, the c4iw_put_ep() is
incorrectly used instead of the kfree(). Since the child_ep's
reference count hasn't been properly established at this point,
the c4iw_put_ep() won't actually free the memory, resulting in
permanent memory leak.

Fix by releasing child_ep correctly in the fail path.

Fixes: 4a740838bf44 ("RDMA/iw_cxgb4: Low resource fixes for connection manager")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/infiniband/hw/cxgb4/cm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/cxgb4/cm.c b/drivers/infiniband/hw/cxgb4/cm.c
index b3b45c49077d..a09eeb48775f 100644
--- a/drivers/infiniband/hw/cxgb4/cm.c
+++ b/drivers/infiniband/hw/cxgb4/cm.c
@@ -2665,7 +2665,7 @@ static int pass_accept_req(struct c4iw_dev *dev, struct sk_buff *skb)
 	}
 	goto out;
 fail:
-	c4iw_put_ep(&child_ep->com);
+	kfree(child_ep);
 reject:
 	reject_cr(dev, hwtid, skb);
 out:
-- 
2.34.1


