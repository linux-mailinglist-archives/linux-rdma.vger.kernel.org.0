Return-Path: <linux-rdma+bounces-4119-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7C7941FC1
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 20:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE52EB20D91
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 18:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD481A7F7C;
	Tue, 30 Jul 2024 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5mHiHsC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E761A7F62;
	Tue, 30 Jul 2024 18:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364483; cv=none; b=cTu+PKdC3MCO3MLxMV0hJTmdDpNzDr7AIA1/GwoQj+jinBByRbnTEdphpAYDlnaA/r3yxDg+FlTbpnsuJaoV5sKKChGuwGJwCgAsRF4km6VMtbQ4NNaH9R1HanK/Bit5cz5tmaWB2tTyClQBwysWA4KeLMHLRa9SrQeDZZFPTes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364483; c=relaxed/simple;
	bh=zsn+RM0YFuxw4wHbUzBqNmfi+amnO1IxsFnwkeEF500=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LdRZhK200KbdyUuIzRb2AGwPtx0rmWoLm8NXQ6wjsjclSsLiE8inuOPu9MVn3e5SsVYWBHRt3m7vyB/chvoia2uChhm8Us6yn4G1q49zVYnJgxl0+XcwBKkPj/JbhQI0FtffQot2tgt+OYGilzezFXoQkOzZlXCiC2P6tFTpW1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5mHiHsC; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7b0c9bbddb4so939799a12.3;
        Tue, 30 Jul 2024 11:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722364481; x=1722969281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XJF28MhC2MiqvCUOHdECUHJyNP06dmnDOSRczPxFDXg=;
        b=G5mHiHsCDMiVsicyDrxoeBMEnCk5L4eyo9JBc51w3248L9zSReFm6MkIykk9KFk42O
         mOee6obyzQ3NDRwbDnytyt6YK22nnMxyVt+g8+XL2QVVlKrPzZE5AG7cuCo80ndPtQUs
         hqnwIEcGE9/75TfED7RkA1SrC2c/KgRtSQgqP2Kx04T74azO2Ur5n5+XSRBZJf07n59q
         3FTFksI3R/C6t3/rMtQmSaCctZH4c7hRu3Tpf3TnaSW+jYZreiRDJbBfZPH4fr30n/Cv
         GE++t8y8j3mBjdlGCp4KFIXhh9TbZSW59jRBQ7jHwbIVfNIyrxFDxay4PmzRhD0Om7RF
         GzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722364481; x=1722969281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XJF28MhC2MiqvCUOHdECUHJyNP06dmnDOSRczPxFDXg=;
        b=g2bvIyqWzddvH4Is4bDDoE0ktcgO51+644ZMfH59NaAk1w9mxcvIUQNXen98Yt+qvm
         /iQqrtnBoph1saj/7ElSNbk8SY+S7oC0dgSnGt5jkuK/32K6hn8aUXiz/L+EsGn1TIby
         KxOJbwB2NTR0xjxXFYqmw7kmc5Of+vlbLVdb6RMK9vz63W76OJutRDplxXYhDpK8S/4w
         3xGlDpO8lsDxfxU1pfVIX35xQ+J0CrLa58SUOI89IsBt3kqXXPFlUjKjmIhf8fsHxHNo
         PG+if++8qcCF7ueQH/AtLLpYrzeGLW/fH6JKZsse/e8mykG75Zgiq+ov+dGIlG8vH4+5
         OuLg==
X-Forwarded-Encrypted: i=1; AJvYcCXDTNVweLas2yiC2RzMsAPyySDkGHzAYiQ0Rh3jB8iJ2WyezZZXXQhH7N5/UgN76+4YhFS/pb4RNhtla2UR9wL5XXXay1UsX0NRDF4f8jwrRtlAN4qeJg7x+/tOOs7epodbbZyFSMAxL4L9lvjnk4ra18pZqB54qXVOrMnwIJ0oJQ==
X-Gm-Message-State: AOJu0YwJDnpYEPuw6xjQZj+becX9++4O0dHUuDl6Cdm63Hm7hVXiZZIh
	6VXJgVuYeK/Yd3z3nKEmKjr1XqA9IYAVDZyuC5UBW5YkgXQbq4Ue
X-Google-Smtp-Source: AGHT+IGo7lrGjbCeYJR8CgOHZdoGXq6ysooeIc5UeAEWFCJBQ9LFDG+NCFqdDOvXEN4PPr122ZUWMw==
X-Received: by 2002:a05:6a20:7347:b0:1c2:97cd:94d8 with SMTP id adf61e73a8af0-1c4a12cbcccmr11576550637.20.1722364481320;
        Tue, 30 Jul 2024 11:34:41 -0700 (PDT)
Received: from apais-devbox.. ([2001:569:766d:6500:f2df:af9:e1f6:390e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f817f5a2sm7837763a12.24.2024.07.30.11.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 11:34:40 -0700 (PDT)
From: Allen Pais <allen.lkml@gmail.com>
To: kuba@kernel.org,
	Haren Myneni <haren@linux.ibm.com>,
	Rick Lindsley <ricklind@linux.ibm.com>,
	Nick Child <nnac123@linux.ibm.com>,
	Thomas Falcon <tlfalcon@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: jes@trained-monkey.org,
	kda@linux-powerpc.org,
	cai.huoqing@linux.dev,
	dougmill@linux.ibm.com,
	aneesh.kumar@kernel.org,
	naveen.n.rao@linux.ibm.com,
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
	Allen Pais <allen.lkml@gmail.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [net-next v3 12/15] net: ibmvnic: Convert tasklet API to new bottom half workqueue mechanism
Date: Tue, 30 Jul 2024 11:34:00 -0700
Message-Id: <20240730183403.4176544-13-allen.lkml@gmail.com>
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
APIs throughout the ibmvnic driver. This transition ensures compatibility
with the latest design and enhances performance.

Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 24 ++++++++++++------------
 drivers/net/ethernet/ibm/ibmvnic.h |  2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 23ebeb143987..0156efeff96a 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2737,7 +2737,7 @@ static const char *reset_reason_to_string(enum ibmvnic_reset_reason reason)
 /*
  * Initialize the init_done completion and return code values. We
  * can get a transport event just after registering the CRQ and the
- * tasklet will use this to communicate the transport event. To ensure
+ * bh work will use this to communicate the transport event. To ensure
  * we don't miss the notification/error, initialize these _before_
  * regisering the CRQ.
  */
@@ -4447,7 +4447,7 @@ static void send_request_cap(struct ibmvnic_adapter *adapter, int retry)
 	int cap_reqs;
 
 	/* We send out 6 or 7 REQUEST_CAPABILITY CRQs below (depending on
-	 * the PROMISC flag). Initialize this count upfront. When the tasklet
+	 * the PROMISC flag). Initialize this count upfront. When the bh work
 	 * receives a response to all of these, it will send the next protocol
 	 * message (QUERY_IP_OFFLOAD).
 	 */
@@ -4983,7 +4983,7 @@ static void send_query_cap(struct ibmvnic_adapter *adapter)
 	int cap_reqs;
 
 	/* We send out 25 QUERY_CAPABILITY CRQs below.  Initialize this count
-	 * upfront. When the tasklet receives a response to all of these, it
+	 * upfront. When the bh work receives a response to all of these, it
 	 * can send out the next protocol messaage (REQUEST_CAPABILITY).
 	 */
 	cap_reqs = 25;
@@ -5495,7 +5495,7 @@ static int handle_login_rsp(union ibmvnic_crq *login_rsp_crq,
 	int i;
 
 	/* CHECK: Test/set of login_pending does not need to be atomic
-	 * because only ibmvnic_tasklet tests/clears this.
+	 * because only ibmvnic_bh_work tests/clears this.
 	 */
 	if (!adapter->login_pending) {
 		netdev_warn(netdev, "Ignoring unexpected login response\n");
@@ -6081,13 +6081,13 @@ static irqreturn_t ibmvnic_interrupt(int irq, void *instance)
 {
 	struct ibmvnic_adapter *adapter = instance;
 
-	tasklet_schedule(&adapter->tasklet);
+	queue_work(system_bh_wq, &adapter->bh_work);
 	return IRQ_HANDLED;
 }
 
-static void ibmvnic_tasklet(struct tasklet_struct *t)
+static void ibmvnic_bh_work(struct work_struct *work)
 {
-	struct ibmvnic_adapter *adapter = from_tasklet(adapter, t, tasklet);
+	struct ibmvnic_adapter *adapter = from_work(adapter, work, bh_work);
 	struct ibmvnic_crq_queue *queue = &adapter->crq;
 	union ibmvnic_crq *crq;
 	unsigned long flags;
@@ -6168,7 +6168,7 @@ static void release_crq_queue(struct ibmvnic_adapter *adapter)
 
 	netdev_dbg(adapter->netdev, "Releasing CRQ\n");
 	free_irq(vdev->irq, adapter);
-	tasklet_kill(&adapter->tasklet);
+	cancel_work_sync(&adapter->bh_work);
 	do {
 		rc = plpar_hcall_norets(H_FREE_CRQ, vdev->unit_address);
 	} while (rc == H_BUSY || H_IS_LONG_BUSY(rc));
@@ -6219,7 +6219,7 @@ static int init_crq_queue(struct ibmvnic_adapter *adapter)
 
 	retrc = 0;
 
-	tasklet_setup(&adapter->tasklet, (void *)ibmvnic_tasklet);
+	INIT_WORK(&adapter->bh_work, (void *)ibmvnic_bh_work);
 
 	netdev_dbg(adapter->netdev, "registering irq 0x%x\n", vdev->irq);
 	snprintf(crq->name, sizeof(crq->name), "ibmvnic-%x",
@@ -6241,12 +6241,12 @@ static int init_crq_queue(struct ibmvnic_adapter *adapter)
 	spin_lock_init(&crq->lock);
 
 	/* process any CRQs that were queued before we enabled interrupts */
-	tasklet_schedule(&adapter->tasklet);
+	queue_work(system_bh_wq, &adapter->bh_work);
 
 	return retrc;
 
 req_irq_failed:
-	tasklet_kill(&adapter->tasklet);
+	cancel_work_sync(&adapter->bh_work);
 	do {
 		rc = plpar_hcall_norets(H_FREE_CRQ, vdev->unit_address);
 	} while (rc == H_BUSY || H_IS_LONG_BUSY(rc));
@@ -6639,7 +6639,7 @@ static int ibmvnic_resume(struct device *dev)
 	if (adapter->state != VNIC_OPEN)
 		return 0;
 
-	tasklet_schedule(&adapter->tasklet);
+	queue_work(system_bh_wq, &adapter->bh_work);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/ibm/ibmvnic.h b/drivers/net/ethernet/ibm/ibmvnic.h
index 94ac36b1408b..b65b210a8059 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.h
+++ b/drivers/net/ethernet/ibm/ibmvnic.h
@@ -1036,7 +1036,7 @@ struct ibmvnic_adapter {
 	u32 cur_rx_buf_sz;
 	u32 prev_rx_buf_sz;
 
-	struct tasklet_struct tasklet;
+	struct work_struct bh_work;
 	enum vnic_state state;
 	/* Used for serialization of state field. When taking both state
 	 * and rwi locks, take state lock first.
-- 
2.34.1


