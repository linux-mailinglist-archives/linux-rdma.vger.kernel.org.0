Return-Path: <linux-rdma+bounces-3382-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E15911A06
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 07:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D171F2400E
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Jun 2024 05:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD98916B3AF;
	Fri, 21 Jun 2024 05:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhoUsYUp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A1415A49F;
	Fri, 21 Jun 2024 05:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718946351; cv=none; b=Zc+77LC3JIY8kqT70aYMIvG7wOowkVz7P0SUChfOFYKzAa21y6u9VDOaf+jsw4xZng+0mAfvlgGvCAc+97wJv0+lVIL12UwMNynaUEo7iAnGrlFNcJgCgfDLuUQSVbU2n9xmwg9N2Yi5zU7yXdxmb6rEGHLme/8ZV34G+tTxBH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718946351; c=relaxed/simple;
	bh=gI85TTQP7iKwQXoxekl9V3cWSZJ22aXkG4Y9tecNtfs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kyW2vziJ5RGPZsvn85qJrZ76wAbJc1iiVdYPY3ZYiuSXCOFlNCAERAItBKNoub2tbH0DXJ1ACuwN9yTT/Sdu11Kj8f5Nsg+FmqykJfI/lA3QCRcXPDgAak6XnAZndH7WPFtoJ9I2uxwPHEglfh/ToaUMCSohzkU8vep/i2nnVtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhoUsYUp; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-705b9a89e08so1435704b3a.1;
        Thu, 20 Jun 2024 22:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718946349; x=1719551149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9GhuL189NlsReo3FKcMODlZqu4R4eu4VKJPZNqH5aQ=;
        b=hhoUsYUpN+TMVxGCU8k7tCbj+Zrl3DMJaM2miS774GCmQAIvPshJiw8W+LOYQsfOfn
         ia3/zjrcb76+a/DiId6gXJOC1FKlazBMml+UBU3EG48wZC0AaQbtr18ycXmmqUAPp355
         +LwReFkQLp6jiVbx0q0334GiM0LG6ES+JQsKL4zvbM5WPdYEKh5xTSzwQi/H9Pxy0mkO
         1J4MsERS9RO2TUQQsR02YwVJKkTv8qlEII+fg1uxFFRJC56CqWl0g16D7pHM7wlVBfdw
         TEd8Oq+F35RC61wtexTMWVSaeXk8bgg2apyLmD77Mll/1E4x4vCfyTZedUzDth6RZiZH
         VhZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718946349; x=1719551149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9GhuL189NlsReo3FKcMODlZqu4R4eu4VKJPZNqH5aQ=;
        b=ckpMCQI6PyRglXdyRSkn6zjgLUQLNqLU+PN5A6Vz3GDD59aQqzKHxXKmbInoCHW/Ca
         bwvAY/mLGsUjqJyB1LWEvLY5tLW2oOAji8n35QVQM8mQQ+U5GnZWzheuXa9up96csizR
         erj9PNjRuWQBu8QPY1NympwCSpLl/vFAaeLhrjdQJlanG6Oz4D45RbjZGQPTUWVzX/Q8
         /py+rwfU2kBN0KHs3qIXQZU/aw9jwyMOqDn9Km2AYZdQeWpJU+xFGXOPx9L8N3CCgk8u
         qVEeoEChk9aGMy0eEAqmQv1OZbsrUNMMUSlXJ76PtxN7DzfChlF4QrCh4p/ko56ehROe
         Lwlw==
X-Forwarded-Encrypted: i=1; AJvYcCXb+LdC4aVMEtLLtp8i1f2JSd00wbROxKhkDurZmSUb6S0rgiHs0VDAv9zzIK09UIKAL4AIYt+dLzihm7BxvQQjlRP3AefD/rJclbg3bNYK24xJ2bLSin9GABlwOZubu9wLVyE6ru2MhTq++q8Ph0mzOqntk6SNlHSLYaW9AMUPnA==
X-Gm-Message-State: AOJu0YwhmRluIPfWdP6Il/pCNcz8qY1MkX9EzvGTbQpR7f2C2uKx0o2+
	W4FK44hgQIjynG5PdHg7pYWl/qA2T7ZWbm6ZEhp0uhJP63nmerjI
X-Google-Smtp-Source: AGHT+IH/7s09xv7VzYI4kG7aQgM/agVLY4vyVwDy64jVJQOC9aLZ2gYrLJ2yU43J9Xyj0jq3fHSCig==
X-Received: by 2002:a05:6a20:5007:b0:1b7:175a:6756 with SMTP id adf61e73a8af0-1bcbb653e31mr7261907637.50.1718946349067;
        Thu, 20 Jun 2024 22:05:49 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:fb4e:6cf3:3ec6:9292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716c950d71asm371308a12.62.2024.06.20.22.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 22:05:48 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: kuba@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: jes@trained-monkey.org,
	kda@linux-powerpc.org,
	cai.huoqing@linux.dev,
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
Subject: [PATCH 05/15] net: cavium/liquidio: Convert tasklet API to new bottom half workqueue mechanism
Date: Thu, 20 Jun 2024 22:05:15 -0700
Message-Id: <20240621050525.3720069-6-allen.lkml@gmail.com>
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
APIs throughout the cavium/liquidio driver. This transition ensures
compatibility with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 .../net/ethernet/cavium/liquidio/lio_core.c   |  4 ++--
 .../net/ethernet/cavium/liquidio/lio_main.c   | 24 +++++++++----------
 .../ethernet/cavium/liquidio/lio_vf_main.c    | 10 ++++----
 .../ethernet/cavium/liquidio/octeon_droq.c    |  4 ++--
 .../ethernet/cavium/liquidio/octeon_main.h    |  4 ++--
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_core.c b/drivers/net/ethernet/cavium/liquidio/lio_core.c
index 674c54831875..37307e02a6ff 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_core.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_core.c
@@ -925,7 +925,7 @@ int liquidio_schedule_msix_droq_pkt_handler(struct octeon_droq *droq, u64 ret)
 			if (OCTEON_CN23XX_VF(oct))
 				dev_err(&oct->pci_dev->dev,
 					"should not come here should not get rx when poll mode = 0 for vf\n");
-			tasklet_schedule(&oct_priv->droq_tasklet);
+			queue_work(system_bh_wq, &oct_priv->droq_bh_work);
 			return 1;
 		}
 		/* this will be flushed periodically by check iq db */
@@ -975,7 +975,7 @@ static void liquidio_schedule_droq_pkt_handlers(struct octeon_device *oct)
 				droq->ops.napi_fn(droq);
 				oct_priv->napi_mask |= BIT_ULL(oq_no);
 			} else {
-				tasklet_schedule(&oct_priv->droq_tasklet);
+				queue_work(system_bh_wq, &oct_priv->droq_bh_work);
 			}
 		}
 	}
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 1d79f6eaa41f..d348656c2f38 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -150,12 +150,12 @@ static int liquidio_set_vf_link_state(struct net_device *netdev, int vfidx,
 static struct handshake handshake[MAX_OCTEON_DEVICES];
 static struct completion first_stage;
 
-static void octeon_droq_bh(struct tasklet_struct *t)
+static void octeon_droq_bh(struct work_struct *work)
 {
 	int q_no;
 	int reschedule = 0;
-	struct octeon_device_priv *oct_priv = from_tasklet(oct_priv, t,
-							  droq_tasklet);
+	struct octeon_device_priv *oct_priv = from_work(oct_priv, work,
+							  droq_bh_work);
 	struct octeon_device *oct = oct_priv->dev;
 
 	for (q_no = 0; q_no < MAX_OCTEON_OUTPUT_QUEUES(oct); q_no++) {
@@ -180,7 +180,7 @@ static void octeon_droq_bh(struct tasklet_struct *t)
 	}
 
 	if (reschedule)
-		tasklet_schedule(&oct_priv->droq_tasklet);
+		queue_work(system_bh_wq, &oct_priv->droq_bh_work);
 }
 
 static int lio_wait_for_oq_pkts(struct octeon_device *oct)
@@ -199,7 +199,7 @@ static int lio_wait_for_oq_pkts(struct octeon_device *oct)
 		}
 		if (pkt_cnt > 0) {
 			pending_pkts += pkt_cnt;
-			tasklet_schedule(&oct_priv->droq_tasklet);
+			queue_work(system_bh_wq, &oct_priv->droq_bh_work);
 		}
 		pkt_cnt = 0;
 		schedule_timeout_uninterruptible(1);
@@ -1130,7 +1130,7 @@ static void octeon_destroy_resources(struct octeon_device *oct)
 		break;
 	}                       /* end switch (oct->status) */
 
-	tasklet_kill(&oct_priv->droq_tasklet);
+	cancel_work_sync(&oct_priv->droq_bh_work);
 }
 
 /**
@@ -1234,7 +1234,7 @@ static void liquidio_destroy_nic_device(struct octeon_device *oct, int ifidx)
 	list_for_each_entry_safe(napi, n, &netdev->napi_list, dev_list)
 		netif_napi_del(napi);
 
-	tasklet_enable(&oct_priv->droq_tasklet);
+	enable_and_queue_work(system_bh_wq, &oct_priv->droq_bh_work);
 
 	if (atomic_read(&lio->ifstate) & LIO_IFSTATE_REGISTERED)
 		unregister_netdev(netdev);
@@ -1770,7 +1770,7 @@ static int liquidio_open(struct net_device *netdev)
 	int ret = 0;
 
 	if (oct->props[lio->ifidx].napi_enabled == 0) {
-		tasklet_disable(&oct_priv->droq_tasklet);
+		disable_work_sync(&oct_priv->droq_bh_work);
 
 		list_for_each_entry_safe(napi, n, &netdev->napi_list, dev_list)
 			napi_enable(napi);
@@ -1896,7 +1896,7 @@ static int liquidio_stop(struct net_device *netdev)
 		if (OCTEON_CN23XX_PF(oct))
 			oct->droq[0]->ops.poll_mode = 0;
 
-		tasklet_enable(&oct_priv->droq_tasklet);
+		enable_and_queue_work(system_bh_wq, &oct_priv->droq_bh_work);
 	}
 
 	dev_info(&oct->pci_dev->dev, "%s interface is stopped\n", netdev->name);
@@ -4204,9 +4204,9 @@ static int octeon_device_init(struct octeon_device *octeon_dev)
 		}
 	}
 
-	/* Initialize the tasklet that handles output queue packet processing.*/
-	dev_dbg(&octeon_dev->pci_dev->dev, "Initializing droq tasklet\n");
-	tasklet_setup(&oct_priv->droq_tasklet, octeon_droq_bh);
+	/* Initialize the bh work that handles output queue packet processing.*/
+	dev_dbg(&octeon_dev->pci_dev->dev, "Initializing droq bh work\n");
+	INIT_WORK(&oct_priv->droq_bh_work, octeon_droq_bh);
 
 	/* Setup the interrupt handler and record the INT SUM register address
 	 */
diff --git a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
index 62c2eadc33e3..04117625f388 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_vf_main.c
@@ -87,7 +87,7 @@ static int lio_wait_for_oq_pkts(struct octeon_device *oct)
 		}
 		if (pkt_cnt > 0) {
 			pending_pkts += pkt_cnt;
-			tasklet_schedule(&oct_priv->droq_tasklet);
+			queue_work(system_bh_wq, &oct_priv->droq_bh_work);
 		}
 		pkt_cnt = 0;
 		schedule_timeout_uninterruptible(1);
@@ -584,7 +584,7 @@ static void octeon_destroy_resources(struct octeon_device *oct)
 		break;
 	}
 
-	tasklet_kill(&oct_priv->droq_tasklet);
+	cancel_work_sync(&oct_priv->droq_bh_work);
 }
 
 /**
@@ -687,7 +687,7 @@ static void liquidio_destroy_nic_device(struct octeon_device *oct, int ifidx)
 	list_for_each_entry_safe(napi, n, &netdev->napi_list, dev_list)
 		netif_napi_del(napi);
 
-	tasklet_enable(&oct_priv->droq_tasklet);
+	enable_and_queue_work(system_bh_wq, &oct_priv->droq_bh_work);
 
 	if (atomic_read(&lio->ifstate) & LIO_IFSTATE_REGISTERED)
 		unregister_netdev(netdev);
@@ -911,7 +911,7 @@ static int liquidio_open(struct net_device *netdev)
 	int ret = 0;
 
 	if (!oct->props[lio->ifidx].napi_enabled) {
-		tasklet_disable(&oct_priv->droq_tasklet);
+		disable_work_sync(&oct_priv->droq_bh_work);
 
 		list_for_each_entry_safe(napi, n, &netdev->napi_list, dev_list)
 			napi_enable(napi);
@@ -986,7 +986,7 @@ static int liquidio_stop(struct net_device *netdev)
 
 		oct->droq[0]->ops.poll_mode = 0;
 
-		tasklet_enable(&oct_priv->droq_tasklet);
+		enable_and_queue_work(system_bh_wq, &oct_priv->droq_bh_work);
 	}
 
 	cancel_delayed_work_sync(&lio->stats_wk.work);
diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_droq.c b/drivers/net/ethernet/cavium/liquidio/octeon_droq.c
index eef12fdd246d..4e5f8bbc891b 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_droq.c
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_droq.c
@@ -96,7 +96,7 @@ u32 octeon_droq_check_hw_for_pkts(struct octeon_droq *droq)
 	last_count = pkt_count - droq->pkt_count;
 	droq->pkt_count = pkt_count;
 
-	/* we shall write to cnts  at napi irq enable or end of droq tasklet */
+	/* we shall write to cnts  at napi irq enable or end of droq bh_work */
 	if (last_count)
 		atomic_add(last_count, &droq->pkts_pending);
 
@@ -764,7 +764,7 @@ octeon_droq_process_packets(struct octeon_device *oct,
 				(u16)rdisp->rinfo->recv_pkt->rh.r.subcode));
 	}
 
-	/* If there are packets pending. schedule tasklet again */
+	/* If there are packets pending. schedule bh_work again */
 	if (atomic_read(&droq->pkts_pending))
 		return 1;
 
diff --git a/drivers/net/ethernet/cavium/liquidio/octeon_main.h b/drivers/net/ethernet/cavium/liquidio/octeon_main.h
index 5b4cb725f60f..a8f2a0a7b08e 100644
--- a/drivers/net/ethernet/cavium/liquidio/octeon_main.h
+++ b/drivers/net/ethernet/cavium/liquidio/octeon_main.h
@@ -24,6 +24,7 @@
 #define  _OCTEON_MAIN_H_
 
 #include <linux/sched/signal.h>
+#include <linux/workqueue.h>
 
 #if BITS_PER_LONG == 32
 #define CVM_CAST64(v) ((long long)(v))
@@ -36,8 +37,7 @@
 #define DRV_NAME "LiquidIO"
 
 struct octeon_device_priv {
-	/** Tasklet structures for this device. */
-	struct tasklet_struct droq_tasklet;
+	struct work_struct droq_bh_work;
 	unsigned long napi_mask;
 	struct octeon_device *dev;
 };
-- 
2.34.1


