Return-Path: <linux-rdma+bounces-7898-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A658CA3E1D2
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 18:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12601889062
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 17:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB80211A0E;
	Thu, 20 Feb 2025 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nj805fbH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310741C5F26
	for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071105; cv=none; b=H66loK6eOE87tNk8Byd1LzZjZ5Og3OUvEoLNmfe+MlJc3mn/bFELhYZmkHr6785hl+ygJA1yhiywPtWAD1bTZUlgqJV9z6Oiz39sQ2nNCBVqU1HFCBK17UluqZSUBHK/xsVLWRl9lTTKPwwoppLDtwjEvZAIWohHJXke0OfTfhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071105; c=relaxed/simple;
	bh=tS9DpWCfP661f9ZjNquRMVOvGqgDkFmFGl1BpiwUsA0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Z1Dkse/2AxmQtUCSe8nwGlIhRgwxmiXcET/OUjOmkE8kaAsQ0S6xCDnBhXw4nJTN1Gz0284mYLuHbkvqVW5rXQYo1xwvHmmmkKpop4cvT4wgRNvXlTuzK2srsMJMpNXKlgtXGVJUwKSQ0Qh1+5KCZkas8fPs60E/MNxquqGnJvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nj805fbH; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-546202d633dso1257874e87.2
        for <linux-rdma@vger.kernel.org>; Thu, 20 Feb 2025 09:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740071101; x=1740675901; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w6IitNC+QebIJlKnzH7o7ZIAKy2jh7qm8fmSJbrVPWE=;
        b=Nj805fbHokdW9CFM8xDj1ipKWVBxLGVfL4slpPOd5ZnuQjyFLn3A4jIIVW6gGWIn9l
         isXWtAgl4xoyb6PAs/44Frjkf37iwFYpcju7RBkZUzwHMOfyglpIAeC5CiHIbiDAAepK
         jwbLDVmRSGYbscfEC3RR7GD7lyP1FYMw16XDy6+yRHG09MXT2wqfwMfv1XXBL3pRERJc
         zjBtPGy7o0C7OOh92AVNfIngsFz/p4iiw08Rx/B59G+uoY7VFkG6nIYU+VG+d/3HC+LO
         HYt7mpxpG6vqkRn1QCXvFxfONL0kAc3iLdsyn7ZRixuETqgRz9U/t0zIjQPDA5tuZHhh
         DxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740071101; x=1740675901;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w6IitNC+QebIJlKnzH7o7ZIAKy2jh7qm8fmSJbrVPWE=;
        b=cTJ1BZirL9x2vqVkkXyjyURnZDsWKjTynlbQljmIoGmReKaa+ffx/y4QoAdeUesr7j
         GIqmCdrcNozucVGGd/h6RUs2M60YqswB2j3c8As1tFZ3onVAKQJNWVBrzy6pUIAEp7rn
         TM9j8rDO9GSPydlKBlvSX4Ue1vUXBS2VQvLLFXD6C++icXSRuXL5r1FnXCK5mwdK1wSK
         cVBrW8sSK7V/H2NtNIWUff4nCfatZ1dLgwG0IQIwBeoE5TEGs1QtXJYkmCEuoeM25cMZ
         UWFL2JGsAket4GD+NLAcOkLD1NKi4KGZX02/SoIVHozvhirIkes3Nw6tJ2BSLmf3kEpO
         bp7w==
X-Gm-Message-State: AOJu0YySdhCKFRo/UZ0HsJ9HGBFex929Vrykl/7/4hZc/pgIBPGXmiqG
	BxAL9JW0ukhxOMXkphX4dirFp+Y3HVtVBVtqvwvMq/pskn/NdqmQZU/HZKvrvfeqJgYCDG5bbwx
	zFAx1W/hEkEGxScCfX/1jnAoTnrM17BbC9bb9
X-Gm-Gg: ASbGnctTnyEyICuaAIk/xrK168VR1dZ6aZKQlZjAag/bogYQ9O7EFTr/zq3sB9GS3/C
	h+ScWsGgZw5NQto6CppCtzEpT0Qg51tuZAGXd1j5zx4rjsVUg5pfvKCKpDtu+kidvo7NkUcI0dw
	+WtgqFC4yXPis/iVLUQcYYv8e9Ww==
X-Google-Smtp-Source: AGHT+IEv3cV3Pjzbd3vVGjS0F79kwb67UpI/NMnza4M9VbrtGrrmgrMSiAYMtkKkZ0/+AjZeNQahHBXAbR/Ab2iWJZs=
X-Received: by 2002:a05:6512:ba6:b0:545:8f7:8597 with SMTP id
 2adb3069b0e04-5452fe45dfemr10431690e87.16.1740071100640; Thu, 20 Feb 2025
 09:05:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jacob Moroni <jmoroni@google.com>
Date: Thu, 20 Feb 2025 12:04:49 -0500
X-Gm-Features: AWEUYZmO1Sl-xsGgILaXxG1Fm5CKXu2KQyNWEeahVM4GVYdRJgTW6g31YrK47Lo
Message-ID: <CAHYDg1Sdi0UZXzMzWo=HkWzJx9jp6HF23oGSO_kgobs0=JyEcw@mail.gmail.com>
Subject: [PATCH] IB/cm: use rwlock for MAD agent lock
To: jgg@ziepe.ca, leon@kernel.org, markzhang@nvidia.com
Cc: linux-rdma@vger.kernel.org, Eric Dumazet <edumazet@google.com>
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

Fixes: 76039ac9095f5ee5 ("IB/cm: Protect cm_dev, cm_ports and
mad_agent with kref and lock")
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
- spinlock_t mad_agent_lock;
+ rwlock_t mad_agent_lock;
  struct ib_device *ib_device;
  u8 ack_delay;
  int going_down;
@@ -285,7 +285,7 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct
cm_id_private *cm_id_priv)
  if (!cm_id_priv->av.port)
  return ERR_PTR(-EINVAL);

- spin_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
+ read_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
  mad_agent = cm_id_priv->av.port->mad_agent;
  if (!mad_agent) {
  m = ERR_PTR(-EINVAL);
@@ -311,7 +311,7 @@ static struct ib_mad_send_buf *cm_alloc_msg(struct
cm_id_private *cm_id_priv)
  m->ah = ah;

 out:
- spin_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
+ read_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
  return m;
 }

@@ -1297,10 +1297,10 @@ static __be64 cm_form_tid(struct cm_id_private
*cm_id_priv)
  if (!cm_id_priv->av.port)
  return cpu_to_be64(low_tid);

- spin_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
+ read_lock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
  if (cm_id_priv->av.port->mad_agent)
  hi_tid = ((u64)cm_id_priv->av.port->mad_agent->hi_tid) << 32;
- spin_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
+ read_unlock(&cm_id_priv->av.port->cm_dev->mad_agent_lock);
  return cpu_to_be64(hi_tid | low_tid);
 }

@@ -4378,7 +4378,7 @@ static int cm_add_one(struct ib_device *ib_device)
  return -ENOMEM;

  kref_init(&cm_dev->kref);
- spin_lock_init(&cm_dev->mad_agent_lock);
+ rwlock_init(&cm_dev->mad_agent_lock);
  cm_dev->ib_device = ib_device;
  cm_dev->ack_delay = ib_device->attrs.local_ca_ack_delay;
  cm_dev->going_down = 0;
@@ -4494,9 +4494,9 @@ static void cm_remove_one(struct ib_device
*ib_device, void *client_data)
  * The above ensures no call paths from the work are running,
  * the remaining paths all take the mad_agent_lock.
  */
- spin_lock(&cm_dev->mad_agent_lock);
+ write_lock(&cm_dev->mad_agent_lock);
  port->mad_agent = NULL;
- spin_unlock(&cm_dev->mad_agent_lock);
+ write_unlock(&cm_dev->mad_agent_lock);
  ib_unregister_mad_agent(mad_agent);
  ib_port_unregister_client_groups(ib_device, i,
  cm_counter_groups);
-- 
2.48.1.601.g30ceb7b040-goog

