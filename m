Return-Path: <linux-rdma+bounces-4117-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160C3941FBB
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 20:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B1C1C232AC
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 18:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCBE1A71E1;
	Tue, 30 Jul 2024 18:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfz5XL0N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2A318CC19;
	Tue, 30 Jul 2024 18:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364478; cv=none; b=Cz0HOK+aFmllaPHQRXODJhrs15Eb9IWERnWrh2Mhn0b63YUA60kBXCtwlVSkOG/87mxDYkKoi1XmVkfSJqZ4faJosP9M8NTOjY+0yNcfrFPuvvka4eoihoCsBJtqlEatRAX09nSBcLKlykfCqucld+7OhMtNfKVPHA1o0ZYH9AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364478; c=relaxed/simple;
	bh=dZhWibPkTPbRop+GGEjVuyTBB+ogvjd9DCdziISEp3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uU2bSahGsZN7yifDlqze+cq6qNmuZ9wD27mkWFmMUJyS3PCpOwxxl+HPudXIKE7KzLD/Y1KbXFGIYwsbcVUzzD/WgQP61hG45DEstsnw2MApj8B1ivqyL0UgAQmYdC0Y1b6zk495sNvLAC/vDZOJNkz7oy0En4QD48+q7zEW/Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfz5XL0N; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3db1e4219f8so2273829b6e.3;
        Tue, 30 Jul 2024 11:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722364476; x=1722969276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jmTnJaPNct0B9da0B3lTLwHU9zpeK3VMEGqtVtu680U=;
        b=nfz5XL0NDAgThVMXEgpftuiEineFQSvnTsxtzN8zkd/NEO36Pf2m7AMnYwrUT9WMvZ
         aSCxCjs67e4l4Dn1trzfzFx2LcdOQx44/tJWUNJsa12tIsluYfSi07wELcPwDGzhXpdN
         hCn0RJac2vjk/y5QJ7lUEpa4NlgzIMLOBbpsmrnmb/jdxOLQ9iDK0JSiyzdBHrSSoybn
         vXyHQbk/ySgyKRPTHr8LQh9koH3VwsziXa8bvYeht0NDXpxIrnUYhjANWABaSEEkf1Gz
         D/PLRu2DuK9B3Hb19PTGGjV6nj0psfdCqDPBzE6M405lviVu9zU8/PlTNEmeW51HKdgV
         OFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722364476; x=1722969276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jmTnJaPNct0B9da0B3lTLwHU9zpeK3VMEGqtVtu680U=;
        b=rB3FuYC8zaUkFs6Pbqp1tGGlz6Y0fs8qYXAmMvayzoPEjfyTA8bi14UWnArl0150v3
         X+YcLC0V4gqDQT4ctIwsUcWYasSGUUHpG+Y9blGWjuf+Mc2BguLJhX9z3XOHNuQ6HC3S
         bLPYNtCPSgJ8JvwXqCbDPqSCVHqsaX0wyjuMDmQXorfBZ/pBq+lXfvFgaZlVJ1lhtz3G
         vrz1vNLbYyfI1ir/NV0R9Z2X17oZJWMBZbcYrn7eEy0/6Cy00LXMN66SNegyOKaTyQo7
         o+mAJ6w81KDbvP7kFrpkZvhuLbzAQuxWECWchxCj7PaTaWn8TSdYJnvagOuqHJXOFrc/
         cUHA==
X-Forwarded-Encrypted: i=1; AJvYcCVpVnmsPBi3rUxEcfFNEaDZJ9RdggeGlHXDu8b+jN2i09eJ/XBdu6gckS9s3A+bastreG3Kl3IQ8nMuh/Ewm9QvgW7amCHhrCe4lLf7w3BK8qXyZiAJ5iYSYV9iwoDi6xEf9J2+BWbXw5nrgHtk1dCozu47OAbrXhUkAXi2cDx0sA==
X-Gm-Message-State: AOJu0Yz7uc5uoVMX1mI4SRyQtFRAI1BHhTpRh4BvrBPsIL9OsOkRvNYh
	1s+IcWt5An/eJ/Dj1GHKhb6PWJvVP95/CYlfgyKK7PS7kpU3rDpe
X-Google-Smtp-Source: AGHT+IFYUFqKUc8jAc7GUvLlfMHj0UGc0ym5A8KGJbdJ6mtN9viwatfMgejHOkaagSTYV+OLZvuSLw==
X-Received: by 2002:a05:6808:1520:b0:3da:a793:f10e with SMTP id 5614622812f47-3db238a2e47mr10615792b6e.18.1722364475751;
        Tue, 30 Jul 2024 11:34:35 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:f2df:af9:e1f6:390e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f817f5a2sm7837763a12.24.2024.07.30.11.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 11:34:35 -0700 (PDT)
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
	netdev@vger.kernel.org,
	Allen Pais <allen.lkml@gmail.com>
Subject: [net-next v3 10/15] net: hinic: Convert tasklet API to new bottom half workqueue mechanism
Date: Tue, 30 Jul 2024 11:33:58 -0700
Message-Id: <20240730183403.4176544-11-allen.lkml@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730183403.4176544-1-allen.lkml@gmail.com>
References: <20240730183403.4176544-1-allen.lkml@gmail.com>
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
 .../net/ethernet/huawei/hinic/hinic_hw_cmdq.c  |  2 +-
 .../net/ethernet/huawei/hinic/hinic_hw_eqs.c   | 18 +++++++++---------
 .../net/ethernet/huawei/hinic/hinic_hw_eqs.h   |  2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

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
index 045c47786a04..1aecc934039e 100644
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
@@ -968,9 +968,9 @@ void hinic_dump_ceq_info(struct hinic_hwdev *hwdev)
 		ci = hinic_hwif_read_reg(hwdev->hwif, addr);
 		addr = EQ_PROD_IDX_REG_ADDR(eq);
 		pi = hinic_hwif_read_reg(hwdev->hwif, addr);
-		dev_err(&hwdev->hwif->pdev->dev, "Ceq id: %d, ci: 0x%08x, sw_ci: 0x%08x, pi: 0x%x, tasklet_state: 0x%lx, wrap: %d, ceqe: 0x%x\n",
+		dev_err(&hwdev->hwif->pdev->dev, "Ceq id: %d, ci: 0x%08x, sw_ci: 0x%08x, pi: 0x%x, work_pending: %d, wrap: %d, ceqe: 0x%x\n",
 			q_id, ci, eq->cons_idx, pi,
-			eq->ceq_tasklet.state,
+			work_pending(&eq->ceq_bh_work),
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


