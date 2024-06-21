Return-Path: <linux-rdma+bounces-3387-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D6F911A15
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 07:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC782B2440B
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 05:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7CF16D4EF;
	Fri, 21 Jun 2024 05:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="US0l0Dtt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E0A16D33A;
	Fri, 21 Jun 2024 05:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718946361; cv=none; b=ogfWFtr9dh0DuC/DFnpt2BaYYSBPbutZV8ZKUAInFTY1Rv7wVPLjdXmJws5raIvBZ1fdsefTqNdC3P1LdsJPF4pC6aYrkWsPwAyN12GravMLizlhHdrG4+idHo16VuhTOUwxTd6St13ne4uRvbyabfxfoA3Vlk1zsoMRinIBhqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718946361; c=relaxed/simple;
	bh=zSy815pDO1WbtvQlDxRmFtHqhoClMQgl+qNaM0qSTdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bl1+SaTKtjhwCZO2KVVBNt9p2H2Ndh2mBjobtcxmNYD+rcyUmtpnSZSGOVfE3tCsH8MMO/n6t6DxMrvPRy9m4PMhhAyqbWY5NMtwgrAtrwJF0ino4UzM7D+PF4cFFlwiBxQ6GDmmJsIKXkZBUoRxc7KTSQ6Cbsp3+EjRnQASkzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=US0l0Dtt; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5bb041514c1so874816eaf.0;
        Thu, 20 Jun 2024 22:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718946358; x=1719551158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lx2TLXT5aNJZ79dehWaykAutPRc+hLUEunig8hxU8YM=;
        b=US0l0DttBofAPbq/sKJEw3oMMqtihZps6nPvSmnPm7dUb+2RZ5e4FG6JZKcxSGFqIu
         Vfe6rJCXxIh043RICE3pJMHE2B7+3+/+a4hMC/PTd+RNOEmzoIyzObNCjB+kxOvVWzRw
         HJtwCEs+xv9PCLEgCqgrRKVb2lft6kZ0ktRl+XQlLP9/5k9RW1ohq5OjDtnInBH72HNg
         uAPq/mSdsnRSOTsW1tYXCHLLw+Yzb6DEiL3hLLqknd8vBG51GYPfISq3V5U9cFpa7LtO
         xroFHEz4dhoxvZiJpCJ804aUVc0A5z4Xlyx0lW6NUqbRqON8Cg3dIqRcLV/A3UiHCURm
         I7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718946358; x=1719551158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lx2TLXT5aNJZ79dehWaykAutPRc+hLUEunig8hxU8YM=;
        b=PoOWKqjk9BlZX/5Sesoh7Dtq/9Mpm63DgZNqA700e3yGs9dqMnKuqZjbrdD1j+QF3O
         MNj0n72NNZt2S/1Qz/GjqGS5/T+jVPimDZVzxbTQTYhaFjCbGQMKFiBCNmHBTipmVunR
         B1oLhFzBU0qu/LLc8XjruVeu+l8MLpLH/eit8geP8zF6HH0xwYIFrlxMIpxv6MXYU83q
         nWNIIFhHzrsIQ6+ib+FghZ6kQz0bnwo2XK9nJflZuvRb/swV6tCbZHR3pklEzrGlgvTw
         JR/xmzqBAakkShE1N6l+O4HGSG5Ny9+SejtrCq5MJA7/+xNKxCTmPRYGxgP07N1bQumy
         jEkw==
X-Forwarded-Encrypted: i=1; AJvYcCX+4TqOio52JxY54f/5psc9EypEU1Z8d4QRSZP2SnkrM0ouzR/sEX9cGn4UusFccAocU4/pbYp8zCBeEYFGzCCucP+nErw9Q2/WKkUI1JaySVKf2KV56i8fM000isygqtl7S+jsXGY4FyykFHAMLttw7x6xNoAE7kTVbo7VkwNW7Q==
X-Gm-Message-State: AOJu0YwUG0xawb1s9GMPmWR2RS4A8w7Vp6aryp055thlm4plya9X5QyA
	5z6v1gKakVIVqL1651VFJfymsKHyFS5B6ikliHW2yv/LVhPF4ZWD
X-Google-Smtp-Source: AGHT+IFsloJi4lcSbB91bbm5zeI31FHR+XREEpqaM3BX4NY1sLxjxwnbe9vu5NBXWUhyl+ydsqrBXA==
X-Received: by 2002:a05:6359:5fa9:b0:19f:3355:d300 with SMTP id e5c5f4694b2df-1a1fd55965emr948922755d.25.1718946358477;
        Thu, 20 Jun 2024 22:05:58 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716c950d71asm371308a12.62.2024.06.20.22.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 22:05:58 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: kuba@kernel.org,
	Cai Huoqing <cai.huoqing@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: jes@trained-monkey.org,
	kda@linux-powerpc.org,
	dougmill@linux.ibm.com,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com,
	nnac123@linux.ibm.com,
	tlfalcon@linux.ibm.com,
	cooldavid@cooldavid.org,
	marcin.s.wojtas@gmail.com,
	mlindner@marvell.com,
	stephen@networkplumber.org,
	nbd@nbd.name,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	lorenzo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	borisp@nvidia.com,
	bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com,
	louis.peens@corigine.com,
	richardcochran@gmail.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acenic@sunsite.dk,
	linux-net-drivers@amd.com,
	Allen Pais <allen.lkml@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH 10/15] net: hinic: Convert tasklet API to new bottom half workqueue mechanism
Date: Thu, 20 Jun 2024 22:05:20 -0700
Message-Id: <20240621050525.3720069-11-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621050525.3720069-1-allen.lkml@gmail.com>
References: <20240621050525.3720069-1-allen.lkml@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Migrate tasklet APIs to the new bottom half workqueue mechanism. It
replaces all occurrences of tasklet usage with the appropriate workqueue
APIs throughout the huawei hinic driver. This transition ensures
compatibility with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 .../net/ethernet/huawei/hinic/hinic_hw_cmdq.c   |  2 +-
 .../net/ethernet/huawei/hinic/hinic_hw_eqs.c    | 17 ++++++++---------
 .../net/ethernet/huawei/hinic/hinic_hw_eqs.h    |  2 +-
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_cmdq.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_cmdq.c
index d39eec9c62bf..f54feae40ef8 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_cmdq.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_cmdq.c
@@ -344,7 +344,7 @@ static int cmdq_sync_cmd_direct_resp(struct hinic_cmdq *cmdq,
 	struct hinic_hw_wqe *hw_wqe;
 	struct completion done;
 
-	/* Keep doorbell index correct. bh - for tasklet(ceq). */
+	/* Keep doorbell index correct. For bh_work(ceq). */
 	spin_lock_bh(&cmdq->cmdq_lock);
 
 	/* WQE_SIZE = WQEBB_SIZE, we will get the wq element and not shadow*/
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c
index 045c47786a04..381ced8f3c93 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.c
@@ -368,12 +368,12 @@ static void eq_irq_work(struct work_struct *work)
 }
 
 /**
- * ceq_tasklet - the tasklet of the EQ that received the event
- * @t: the tasklet struct pointer
+ * ceq_bh_work - the bh_work of the EQ that received the event
+ * @work: the work struct pointer
  **/
-static void ceq_tasklet(struct tasklet_struct *t)
+static void ceq_bh_work(struct work_struct *work)
 {
-	struct hinic_eq *ceq = from_tasklet(ceq, t, ceq_tasklet);
+	struct hinic_eq *ceq = from_work(ceq, work, ceq_bh_work);
 
 	eq_irq_handler(ceq);
 }
@@ -413,7 +413,7 @@ static irqreturn_t ceq_interrupt(int irq, void *data)
 	/* clear resend timer cnt register */
 	hinic_msix_attr_cnt_clear(ceq->hwif, ceq->msix_entry.entry);
 
-	tasklet_schedule(&ceq->ceq_tasklet);
+	queue_work(system_bh_wq, &ceq->ceq_bh_work);
 
 	return IRQ_HANDLED;
 }
@@ -782,7 +782,7 @@ static int init_eq(struct hinic_eq *eq, struct hinic_hwif *hwif,
 
 		INIT_WORK(&aeq_work->work, eq_irq_work);
 	} else if (type == HINIC_CEQ) {
-		tasklet_setup(&eq->ceq_tasklet, ceq_tasklet);
+		INIT_WORK(&eq->ceq_bh_work, ceq_bh_work);
 	}
 
 	/* set the attributes of the msix entry */
@@ -833,7 +833,7 @@ static void remove_eq(struct hinic_eq *eq)
 		hinic_hwif_write_reg(eq->hwif,
 				     HINIC_CSR_AEQ_CTRL_1_ADDR(eq->q_id), 0);
 	} else if (eq->type == HINIC_CEQ) {
-		tasklet_kill(&eq->ceq_tasklet);
+		cancel_work_sync(&eq->ceq_bh_work);
 		/* clear ceq_len to avoid hw access host memory */
 		hinic_hwif_write_reg(eq->hwif,
 				     HINIC_CSR_CEQ_CTRL_1_ADDR(eq->q_id), 0);
@@ -968,9 +968,8 @@ void hinic_dump_ceq_info(struct hinic_hwdev *hwdev)
 		ci = hinic_hwif_read_reg(hwdev->hwif, addr);
 		addr = EQ_PROD_IDX_REG_ADDR(eq);
 		pi = hinic_hwif_read_reg(hwdev->hwif, addr);
-		dev_err(&hwdev->hwif->pdev->dev, "Ceq id: %d, ci: 0x%08x, sw_ci: 0x%08x, pi: 0x%x, tasklet_state: 0x%lx, wrap: %d, ceqe: 0x%x\n",
+		dev_err(&hwdev->hwif->pdev->dev, "Ceq id: %d, ci: 0x%08x, sw_ci: 0x%08x, pi: 0x%x, wrap: %d, ceqe: 0x%x\n",
 			q_id, ci, eq->cons_idx, pi,
-			eq->ceq_tasklet.state,
 			eq->wrapped, be32_to_cpu(*(__be32 *)(GET_CURR_CEQ_ELEM(eq))));
 	}
 }
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.h b/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.h
index 2f3222174fc7..8fed3155f15c 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.h
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_eqs.h
@@ -193,7 +193,7 @@ struct hinic_eq {
 
 	struct hinic_eq_work    aeq_work;
 
-	struct tasklet_struct   ceq_tasklet;
+	struct work_struct	ceq_bh_work;
 };
 
 struct hinic_hw_event_cb {
-- 
2.34.1


