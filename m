Return-Path: <linux-rdma+bounces-7900-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39D8A3E323
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 18:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02851189E3AA
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 17:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5F42139DB;
	Thu, 20 Feb 2025 17:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HHpp8ChP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE04213E9C
	for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 17:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074182; cv=none; b=DSLakCxxoa4U+qnbNOkNQs5nAOjdFT5tysrW+X68xVCtq7ldeeT4DznUaaqDd7U3oHfCZPy497DnRlmjC4a65twjt5e4hhVVM7mwu6OnaxRDHS6CVT6FwBdJV4FhoL4oLOVPWtk6nhU8oMTKTfDW2WBuBLdLkKtb82aaBW6m4oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074182; c=relaxed/simple;
	bh=G6vB9gcijeH3Lhb7cMd814srsxu9iv+Gk09PHvZZXC4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dkk8s5zQrD6bcm6l3Ymcvm9xHmpZbys9RzpHBN356oXeue5f4/ppgiL94w3xzU3uyqwiOtgfaAYdhYiim3yrbzTc0A0nVU+u9h7zKxqa0IhiOl41qhsbIjGZ/jWgaBURxg3WMcJqbuTsfSSMqhocDbT8TJ4RuQ/B5R3LyazZHSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HHpp8ChP; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7c0bb434620so176910085a.3
        for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 09:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740074180; x=1740678980; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+sc+fmJYIJboHhQ6A/akvF820PWgLsmVwEFqfkM50F0=;
        b=HHpp8ChPNDbNA4zyDzejTUa+Opq2Egq9dVM4Z5jiSPDy2VSNzOookyIOTNmUGQFtVJ
         qfQ0Dz28VrxKutx1Xnpxpy6N7YFy+z1wk7SG+wGaKiMyak4+IqToQvEXN/Sd/5skj61t
         jSxe1x0ZJ5NeRnnXCqn4w4RpKOkSlZdfGSARi4TjxNveuLdQWOBTfUHalzpLTVJFWoU0
         6qx8XzTFg8G2CV9Qx0PLQaugCINDT+HkNEQmkGS11XZTUPpOwvye693V9tcSPBsLD4yW
         TLK8yQZSWWRonwK9/gjQorAtBDqR3n5am4BCHXljFzLpVN50z3/zZR55OyK4DY8ScgTu
         nO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740074180; x=1740678980;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+sc+fmJYIJboHhQ6A/akvF820PWgLsmVwEFqfkM50F0=;
        b=MShBRDDh2X2PLhWCouwf31pLr74iS1Ji9QwxUl5i/d08dm03Cl0jHJZ9b0N49UEeNS
         +3sTt9wYJnAaTLVR6ubKGtIFlQUBkFvb00s2E77djR/zm8PBR25kci3RZ9x6VCBAYLss
         8qRT7hR0o8pJZrm3Swv4jAkz8jGI/y9tJ6uKItJrlUwDj3ssiCFL3+GV8W/RlclxE5Zo
         TKozWeb2HB2Pq4cPxKMJEEChGM3kJGSQM9tzM8ASkgIKUTVFCx6TFyoWwXisQdmOYUGX
         cqsbWjGybpvU9MY72ah5vHcgWEmSfEb0c79+UfGSVwWG/VBUNmyEuQjl3PfjEgq3Aj2b
         /kmg==
X-Gm-Message-State: AOJu0YzlHe1pA8hZzrBT83eZxT92S7ztYn9BEF1unwJsnVjNPElKDlMb
	/np1HtRmFQlSrtG9+A6GRFYs3qeQch6T7icYR/5/aPg1WYPL4EgoWJ2pMQe7zoGgwl0Aeh5ig/3
	wYene6A==
X-Google-Smtp-Source: AGHT+IEf+qel04YzloqoCBYrIsaHw1EpGoAjytQmR58Hbp+aKicJg+IofZOJyctbjzk5TjEE2x8JqnrOw30K
X-Received: from qkap13.prod.google.com ([2002:a05:620a:a90d:b0:7c0:a1c2:ac34])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:462c:b0:7c0:c3ea:696d
 with SMTP id af79cd13be357-7c0cef7bef2mr20633085a.55.1740074179796; Thu, 20
 Feb 2025 09:56:19 -0800 (PST)
Date: Thu, 20 Feb 2025 17:56:12 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250220175612.2763122-1-jmoroni@google.com>
Subject: [PATCH] IB/cm: use rwlock for MAD agent lock
From: Jacob Moroni <jmoroni@google.com>
To: jgg@ziepe.ca, leon@kernel.org, markzhang@nvidia.com
Cc: linux-rdma@vger.kernel.org, edumazet@google.com, 
	Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"

In workloads where there are many processes establishing
connections using RDMA CM in parallel (large scale MPI),
there can be heavy contention for mad_agent_lock in
cm_alloc_msg.

This contention can occur while inside of a spin_lock_irq
region, leading to interrupts being disabled for extended
durations on many cores. Furthermore, it leads to the
serialization of rdma_create_ah calls, which has negative
performance impacts for NICs which are capable of processing
multiple address handle creations in parallel.

The end result is the machine becoming unresponsive, hung
task warnings, netdev TX timeouts, etc.

Since the lock appears to be only for protection from
cm_remove_one, it can be changed to a rwlock to resolve
these issues.

Reproducer:

Server:
  for i in $(seq 1 512); do
    ucmatose -c 32 -p $((i + 5000)) &
  done

Client:
  for i in $(seq 1 512); do
    ucmatose -c 32 -p $((i + 5000)) -s 10.2.0.52 &
  done

Fixes: 76039ac9095f5ee5 ("IB/cm: Protect cm_dev, cm_ports and mad_agent with kref and lock")
Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/core/cm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 142170473e75..effa53dd6800 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -167,7 +167,7 @@ struct cm_port {
 struct cm_device {
 	struct kref kref;
 	struct list_head list;
-	spinlock_t mad_agent_lock;
+	rwlock_t mad_agent_lock;
 	struct ib_device *ib_device;
 	u8 ack_delay;
 	int going_down;
@@ -285,7 +285,7 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
 	if (!cm_id_priv->av.port)
 		return ERR_PTR(-EINVAL);
 
-	spin_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
+	read_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
 	mad_agent = cm_id_priv->av.port->mad_agent;
 	if (!mad_agent) {
 		m = ERR_PTR(-EINVAL);
@@ -311,7 +311,7 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct cm_id_private *cm_id_priv)
 	m->ah = ah;
 
 out:
-	spin_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
+	read_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
 	return m;
 }
 
@@ -1297,10 +1297,10 @@ static __be64 cm_form_tid(struct cm_id_private *cm_id_priv)
 	if (!cm_id_priv->av.port)
 		return cpu_to_be64(low_tid);
 
-	spin_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
+	read_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
 	if (cm_id_priv->av.port->mad_agent)
 		hi_tid = ((u64)cm_id_priv->av.port->mad_agent->hi_tid) << 32;
-	spin_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
+	read_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
 	return cpu_to_be64(hi_tid | low_tid);
 }
 
@@ -4378,7 +4378,7 @@ static int cm_add_one(struct ib_device *ib_device)
 		return -ENOMEM;
 
 	kref_init(&cm_dev->kref);
-	spin_lock_init(&cm_dev->mad_agent_lock);
+	rwlock_init(&cm_dev->mad_agent_lock);
 	cm_dev->ib_device = ib_device;
 	cm_dev->ack_delay = ib_device->attrs.local_ca_ack_delay;
 	cm_dev->going_down = 0;
@@ -4494,9 +4494,9 @@ static void cm_remove_one(struct ib_device *ib_device, void *client_data)
 		 * The above ensures no call paths from the work are running,
 		 * the remaining paths all take the mad_agent_lock.
 		 */
-		spin_lock(&cm_dev->mad_agent_lock);
+		write_lock(&cm_dev->mad_agent_lock);
 		port->mad_agent = NULL;
-		spin_unlock(&cm_dev->mad_agent_lock);
+		write_unlock(&cm_dev->mad_agent_lock);
 		ib_unregister_mad_agent(mad_agent);
 		ib_port_unregister_client_groups(ib_device, i,
 						 cm_counter_groups);
-- 
2.48.1.601.g30ceb7b040-goog


