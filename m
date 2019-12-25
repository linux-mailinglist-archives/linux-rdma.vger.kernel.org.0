Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C98D12A69E
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Dec 2019 08:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbfLYHn1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Dec 2019 02:43:27 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41968 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfLYHn1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Dec 2019 02:43:27 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so22351555ljc.8
        for <linux-rdma@vger.kernel.org>; Tue, 24 Dec 2019 23:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p3Jo2WhqngdU3uaXfYiimr3zLCtuXWodFL59ONSarlQ=;
        b=rA4Hs+r06wTNVM15Np+OkvZMWtQnHygamymXUHNTtO/dMs2Qr/fbmxDwLFHsGeu2L4
         qaoWKHpaPB6vPHAvGTPVJdOxVJscg9d6Q5O+BcCQ4kEqIhxWDmaMFsPzDCa0RjhHQkcJ
         YZPfzGjSv5Rq5o3uACtkEZU5rDmPn0iy9PUBRWAFJxt/4HM4Fnsc+q0S6L6wnGQW69lM
         PcBDtQ7MmoihIEeqjTizyDI009hzTomNBTLyjMVAeh9fs1u+gWJEOi7pfMp/ZMWHgJdR
         ucREpvyHKhf7G89BgXxL/HslUdbD7o0wa3iGStGuBt+LtWjvui4Ioxs7R2oaXuIc4xbP
         q0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p3Jo2WhqngdU3uaXfYiimr3zLCtuXWodFL59ONSarlQ=;
        b=pxeRUjwchGBHrD03EMnRkFGm/MRoFFP2ZBu7mxsgcfMFI1H9feh+926eJMCP0XwKsx
         yOHGOH8M3n96IfczyrEVpr7Ks3SMpIhCx99dZPkFOEOSE3ksvxWVL2EyKE6CQikGPHba
         +FLLBeR8dAE648Sf+Tt2Zaw5o477OKGPTRfdOVLwmFyXq8z0xsM4cx1Rf7ZRnhFvMfZ/
         EIofM98wawewpjG2GuhUEjDkfWg+Cp+lbBR3vMGSwxgk5bgBVsR39xqtDedXLd6ok6R/
         d7sGqPZ825p4i0yP6D/e1mpL1D0DCfCvzvQFRiNq5buZw2CRQmpNRi470tiOVDSTsLOp
         R30Q==
X-Gm-Message-State: APjAAAUXvOSI75QRp9ELIQiGUTungAhOOd9tqYmehbcxVqtdTrheq/Eb
        Be5EMIrLHsZsDgl20HCAgCPymdTfqrjKzW/iPuY=
X-Google-Smtp-Source: APXvYqx5CNfiSeo06+uhqiaRcuqKK3DbSGDOD8i42PR2NW2my7IPdVG4TFj42e0b4KzEIFeJXv0M+3mLEsxGYWTw+8Q=
X-Received: by 2002:a2e:8946:: with SMTP id b6mr21054853ljk.1.1577259803293;
 Tue, 24 Dec 2019 23:43:23 -0800 (PST)
MIME-Version: 1.0
References: <CAKC_zSs=m_qPs06ZqxB-UJ_nHqhb+V2CBNKj3HsdJX+6eevqCA@mail.gmail.com>
 <20191225063256.GB212002@unreal> <CAKC_zSts5zdbM4LhUaPBWk8=uKGAKWX6vgd85cdKjOrZViiEJg@mail.gmail.com>
In-Reply-To: <CAKC_zSts5zdbM4LhUaPBWk8=uKGAKWX6vgd85cdKjOrZViiEJg@mail.gmail.com>
From:   Frank Huang <tigerinxm@gmail.com>
Date:   Wed, 25 Dec 2019 15:43:13 +0800
Message-ID: <CAKC_zStPUCpjaF3mJb01A9sPjB0t0GxfBqB=8zsto96dsaD5qQ@mail.gmail.com>
Subject: Re: rxe panic
To:     Leon Romanovsky <leon@kernel.org>
Cc:     linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

there is the patch what i used. :)


rdma_rxe(4.14.97) : has problems in dealing with disorderly messages
this patch transplant rdma_rxe module from linux-5.2.9 to fix this problems=
.
the fix only under linux-4.14.97/drivers/infiniband/sw/rxe. At
present, no impact on other modules has been found.

diff -ur linux-4.14.97/drivers/infiniband/sw/rxe/rxe_comp.c
linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe_comp.c
--- linux-4.14.97/drivers/infiniband/sw/rxe/rxe_comp.c 2019-01-31
15:13:48.000000000 +0800
+++ linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe_comp.c 2019-09-17
16:00:39.168896560 +0800
@@ -191,6 +191,7 @@
 {
  qp->comp.retry_cnt =3D qp->attr.retry_cnt;
  qp->comp.rnr_retry =3D qp->attr.rnr_retry;
+ qp->comp.started_retry =3D 0;
 }

 static inline enum comp_state check_psn(struct rxe_qp *qp,
@@ -253,6 +254,17 @@
  case IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE:
  if (pkt->opcode !=3D IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE &&
      pkt->opcode !=3D IB_OPCODE_RC_RDMA_READ_RESPONSE_LAST) {
+ /* read retries of partial data may restart from
+ * read response first or response only.
+ */
+ if ((pkt->psn =3D=3D wqe->first_psn &&
+      pkt->opcode =3D=3D
+      IB_OPCODE_RC_RDMA_READ_RESPONSE_FIRST) ||
+     (wqe->first_psn =3D=3D wqe->last_psn &&
+      pkt->opcode =3D=3D
+      IB_OPCODE_RC_RDMA_READ_RESPONSE_ONLY))
+ break;
+
  return COMPST_ERROR;
  }
  break;
@@ -270,8 +282,8 @@
  if ((syn & AETH_TYPE_MASK) !=3D AETH_ACK)
  return COMPST_ERROR;

- /* Fall through (IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE
- * doesn't have an AETH)
+ /* fall through */
+ /* (IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE doesn't have an AETH)
  */
  case IB_OPCODE_RC_RDMA_READ_RESPONSE_MIDDLE:
  if (wqe->wr.opcode !=3D IB_WR_RDMA_READ &&
@@ -501,11 +513,11 @@
     struct rxe_pkt_info *pkt,
     struct rxe_send_wqe *wqe)
 {
- qp->comp.opcode =3D -1;
-
- if (pkt) {
- if (psn_compare(pkt->psn, qp->comp.psn) >=3D 0)
- qp->comp.psn =3D (pkt->psn + 1) & BTH_PSN_MASK;
+ if (pkt && wqe->state =3D=3D wqe_state_pending) {
+ if (psn_compare(wqe->last_psn, qp->comp.psn) >=3D 0) {
+ qp->comp.psn =3D (wqe->last_psn + 1) & BTH_PSN_MASK;
+ qp->comp.opcode =3D -1;
+ }

  if (qp->req.wait_psn) {
  qp->req.wait_psn =3D 0;
@@ -662,7 +674,6 @@
      qp->qp_timeout_jiffies)
  mod_timer(&qp->retrans_timer,
    jiffies + qp->qp_timeout_jiffies);
- WARN_ON_ONCE(skb);
  goto exit;

  case COMPST_ERROR_RETRY:
@@ -676,10 +687,23 @@

  /* there is nothing to retry in this case */
  if (!wqe || (wqe->state =3D=3D wqe_state_posted)) {
- WARN_ON_ONCE(skb);
  goto exit;
  }

+ /* if we've started a retry, don't start another
+ * retry sequence, unless this is a timeout.
+ */
+ if (qp->comp.started_retry &&
+     !qp->comp.timeout_retry) {
+ if (pkt) {
+ rxe_drop_ref(pkt->qp);
+ kfree_skb(skb);
+ skb =3D NULL;
+ }
+
+ goto done;
+ }
+
  if (qp->comp.retry_cnt > 0) {
  if (qp->comp.retry_cnt !=3D 7)
  qp->comp.retry_cnt--;
@@ -696,6 +720,7 @@
  rxe_counter_inc(rxe,
  RXE_CNT_COMP_RETRY);
  qp->req.need_retry =3D 1;
+ qp->comp.started_retry =3D 1;
  rxe_run_task(&qp->req.task, 1);
  }

@@ -705,8 +730,7 @@
  skb =3D NULL;
  }

- WARN_ON_ONCE(skb);
- goto exit;
+ goto done;

  } else {
  rxe_counter_inc(rxe, RXE_CNT_RETRY_EXCEEDED);
@@ -749,7 +773,6 @@
  skb =3D NULL;
  }

- WARN_ON_ONCE(skb);
  goto exit;
  }
  }
diff -ur linux-4.14.97/drivers/infiniband/sw/rxe/rxe.h
linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe.h
--- linux-4.14.97/drivers/infiniband/sw/rxe/rxe.h 2019-01-31
15:13:48.000000000 +0800
+++ linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe.h 2019-09-17
16:00:39.169896565 +0800
@@ -74,7 +74,6 @@
  SHASH_DESC_ON_STACK(shash, rxe->tfm);

  shash->tfm =3D rxe->tfm;
- shash->flags =3D 0;
  *(u32 *)shash_desc_ctx(shash) =3D crc;
  err =3D crypto_shash_update(shash, next, len);
  if (unlikely(err)) {
diff -ur linux-4.14.97/drivers/infiniband/sw/rxe/rxe_hdr.h
linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe_hdr.h
--- linux-4.14.97/drivers/infiniband/sw/rxe/rxe_hdr.h 2019-01-31
15:13:48.000000000 +0800
+++ linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe_hdr.h 2019-09-17
16:00:39.169896565 +0800
@@ -643,7 +643,7 @@
  __be32 rkey;
  __be64 swap_add;
  __be64 comp;
-} __attribute__((__packed__));
+} __packed;

 static inline u64 __atmeth_va(void *arg)
 {
diff -ur linux-4.14.97/drivers/infiniband/sw/rxe/rxe_hw_counters.c
linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe_hw_counters.c
--- linux-4.14.97/drivers/infiniband/sw/rxe/rxe_hw_counters.c
2019-01-31 15:13:48.000000000 +0800
+++ linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe_hw_counters.c
2019-09-17 16:00:39.169896565 +0800
@@ -37,11 +37,11 @@
  [RXE_CNT_SENT_PKTS]           =3D  "sent_pkts",
  [RXE_CNT_RCVD_PKTS]           =3D  "rcvd_pkts",
  [RXE_CNT_DUP_REQ]             =3D  "duplicate_request",
- [RXE_CNT_OUT_OF_SEQ_REQ]      =3D  "out_of_sequence",
+ [RXE_CNT_OUT_OF_SEQ_REQ]      =3D  "out_of_seq_request",
  [RXE_CNT_RCV_RNR]             =3D  "rcvd_rnr_err",
  [RXE_CNT_SND_RNR]             =3D  "send_rnr_err",
  [RXE_CNT_RCV_SEQ_ERR]         =3D  "rcvd_seq_err",
- [RXE_CNT_COMPLETER_SCHED]     =3D  "ack_deffered",
+ [RXE_CNT_COMPLETER_SCHED]     =3D  "ack_deferred",
  [RXE_CNT_RETRY_EXCEEDED]      =3D  "retry_exceeded_err",
  [RXE_CNT_RNR_RETRY_EXCEEDED]  =3D  "retry_rnr_exceeded_err",
  [RXE_CNT_COMP_RETRY]          =3D  "completer_retry_err",
diff -ur linux-4.14.97/drivers/infiniband/sw/rxe/rxe_loc.h
linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe_loc.h
--- linux-4.14.97/drivers/infiniband/sw/rxe/rxe_loc.h 2019-01-31
15:13:48.000000000 +0800
+++ linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe_loc.h 2019-09-17
16:00:39.170896570 +0800
@@ -268,7 +268,8 @@

  if (pkt->mask & RXE_LOOPBACK_MASK) {
  memcpy(SKB_TO_PKT(skb), pkt, sizeof(*pkt));
- err =3D rxe_loopback(skb);
+ rxe_loopback(skb);
+ err =3D 0;
  } else {
  err =3D rxe_send(rxe, pkt, skb);
  }
diff -ur linux-4.14.97/drivers/infiniband/sw/rxe/rxe_mmap.c
linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe_mmap.c
--- linux-4.14.97/drivers/infiniband/sw/rxe/rxe_mmap.c 2019-01-31
15:13:48.000000000 +0800
+++ linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe_mmap.c 2019-09-17
16:00:39.170896570 +0800
@@ -146,6 +146,8 @@
     void *obj)
 {
  struct rxe_mmap_info *ip;
+    if (!context)
+     return ERR_PTR(-EINVAL);

  ip =3D kmalloc(sizeof(*ip), GFP_KERNEL);
  if (!ip)
diff -ur linux-4.14.97/drivers/infiniband/sw/rxe/rxe_pool.c
linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe_pool.c
--- linux-4.14.97/drivers/infiniband/sw/rxe/rxe_pool.c 2019-01-31
15:13:48.000000000 +0800
+++ linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe_pool.c 2019-09-17
16:00:39.171896575 +0800
@@ -112,6 +112,20 @@
  return rxe_type_info[pool->type].cache;
 }

+static void rxe_cache_clean(size_t cnt)
+{
+ int i;
+ struct rxe_type_info *type;
+
+ for (i =3D 0; i < cnt; i++) {
+ type =3D &rxe_type_info[i];
+ if (!(type->flags & RXE_POOL_NO_ALLOC)) {
+ kmem_cache_destroy(type->cache);
+ type->cache =3D NULL;
+ }
+ }
+}
+
 int rxe_cache_init(void)
 {
  int err;
@@ -136,24 +150,14 @@
  return 0;

 err1:
- while (--i >=3D 0) {
- kmem_cache_destroy(type->cache);
- type->cache =3D NULL;
- }
+ rxe_cache_clean(i);

  return err;
 }

 void rxe_cache_exit(void)
 {
- int i;
- struct rxe_type_info *type;
-
- for (i =3D 0; i < RXE_NUM_TYPES; i++) {
- type =3D &rxe_type_info[i];
- kmem_cache_destroy(type->cache);
- type->cache =3D NULL;
- }
+ rxe_cache_clean(RXE_NUM_TYPES);
 }

 static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
@@ -207,7 +211,7 @@

  kref_init(&pool->ref_cnt);

- spin_lock_init(&pool->pool_lock);
+ rwlock_init(&pool->pool_lock);

  if (rxe_type_info[type].flags & RXE_POOL_INDEX) {
  err =3D rxe_pool_init_index(pool,
@@ -222,7 +226,7 @@
  pool->key_size =3D rxe_type_info[type].key_size;
  }

- pool->state =3D rxe_pool_valid;
+ pool->state =3D RXE_POOL_STATE_VALID;

 out:
  return err;
@@ -232,7 +236,7 @@
 {
  struct rxe_pool *pool =3D container_of(kref, struct rxe_pool, ref_cnt);

- pool->state =3D rxe_pool_invalid;
+ pool->state =3D RXE_POOL_STATE_INVALID;
  kfree(pool->table);
 }

@@ -245,12 +249,12 @@
 {
  unsigned long flags;

- spin_lock_irqsave(&pool->pool_lock, flags);
- pool->state =3D rxe_pool_invalid;
+ write_lock_irqsave(&pool->pool_lock, flags);
+ pool->state =3D RXE_POOL_STATE_INVALID;
  if (atomic_read(&pool->num_elem) > 0)
  pr_warn("%s pool destroyed with unfree'd elem\n",
  pool_name(pool));
- spin_unlock_irqrestore(&pool->pool_lock, flags);
+ write_unlock_irqrestore(&pool->pool_lock, flags);

  rxe_pool_put(pool);

@@ -336,10 +340,10 @@
  struct rxe_pool *pool =3D elem->pool;
  unsigned long flags;

- spin_lock_irqsave(&pool->pool_lock, flags);
+ write_lock_irqsave(&pool->pool_lock, flags);
  memcpy((u8 *)elem + pool->key_offset, key, pool->key_size);
  insert_key(pool, elem);
- spin_unlock_irqrestore(&pool->pool_lock, flags);
+ write_unlock_irqrestore(&pool->pool_lock, flags);
 }

 void rxe_drop_key(void *arg)
@@ -348,9 +352,9 @@
  struct rxe_pool *pool =3D elem->pool;
  unsigned long flags;

- spin_lock_irqsave(&pool->pool_lock, flags);
+ write_lock_irqsave(&pool->pool_lock, flags);
  rb_erase(&elem->node, &pool->tree);
- spin_unlock_irqrestore(&pool->pool_lock, flags);
+ write_unlock_irqrestore(&pool->pool_lock, flags);
 }

 void rxe_add_index(void *arg)
@@ -359,10 +363,10 @@
  struct rxe_pool *pool =3D elem->pool;
  unsigned long flags;

- spin_lock_irqsave(&pool->pool_lock, flags);
+ write_lock_irqsave(&pool->pool_lock, flags);
  elem->index =3D alloc_index(pool);
  insert_index(pool, elem);
- spin_unlock_irqrestore(&pool->pool_lock, flags);
+ write_unlock_irqrestore(&pool->pool_lock, flags);
 }

 void rxe_drop_index(void *arg)
@@ -371,10 +375,10 @@
  struct rxe_pool *pool =3D elem->pool;
  unsigned long flags;

- spin_lock_irqsave(&pool->pool_lock, flags);
+ write_lock_irqsave(&pool->pool_lock, flags);
  clear_bit(elem->index - pool->min_index, pool->table);
  rb_erase(&elem->node, &pool->tree);
- spin_unlock_irqrestore(&pool->pool_lock, flags);
+ write_unlock_irqrestore(&pool->pool_lock, flags);
 }

 void *rxe_alloc(struct rxe_pool *pool)
@@ -384,13 +388,13 @@

  might_sleep_if(!(pool->flags & RXE_POOL_ATOMIC));

- spin_lock_irqsave(&pool->pool_lock, flags);
- if (pool->state !=3D rxe_pool_valid) {
- spin_unlock_irqrestore(&pool->pool_lock, flags);
+ read_lock_irqsave(&pool->pool_lock, flags);
+ if (pool->state !=3D RXE_POOL_STATE_VALID) {
+ read_unlock_irqrestore(&pool->pool_lock, flags);
  return NULL;
  }
  kref_get(&pool->ref_cnt);
- spin_unlock_irqrestore(&pool->pool_lock, flags);
+ read_unlock_irqrestore(&pool->pool_lock, flags);

  kref_get(&pool->rxe->ref_cnt);

@@ -436,9 +440,9 @@
  struct rxe_pool_entry *elem =3D NULL;
  unsigned long flags;

- spin_lock_irqsave(&pool->pool_lock, flags);
+ read_lock_irqsave(&pool->pool_lock, flags);

- if (pool->state !=3D rxe_pool_valid)
+ if (pool->state !=3D RXE_POOL_STATE_VALID)
  goto out;

  node =3D pool->tree.rb_node;
@@ -450,15 +454,14 @@
  node =3D node->rb_left;
  else if (elem->index < index)
  node =3D node->rb_right;
- else
+ else {
+ kref_get(&elem->ref_cnt);
  break;
+ }
  }

- if (node)
- kref_get(&elem->ref_cnt);
-
 out:
- spin_unlock_irqrestore(&pool->pool_lock, flags);
+ read_unlock_irqrestore(&pool->pool_lock, flags);
  return node ? elem : NULL;
 }

@@ -469,9 +472,9 @@
  int cmp;
  unsigned long flags;

- spin_lock_irqsave(&pool->pool_lock, flags);
+ read_lock_irqsave(&pool->pool_lock, flags);

- if (pool->state !=3D rxe_pool_valid)
+ if (pool->state !=3D RXE_POOL_STATE_VALID)
  goto out;

  node =3D pool->tree.rb_node;
@@ -494,6 +497,6 @@
  kref_get(&elem->ref_cnt);

 out:
- spin_unlock_irqrestore(&pool->pool_lock, flags);
+ read_unlock_irqrestore(&pool->pool_lock, flags);
  return node ? elem : NULL;
 }
diff -ur linux-4.14.97/drivers/infiniband/sw/rxe/rxe_pool.h
linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe_pool.h
--- linux-4.14.97/drivers/infiniband/sw/rxe/rxe_pool.h 2019-01-31
15:13:48.000000000 +0800
+++ linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe_pool.h 2019-09-17
16:00:39.171896575 +0800
@@ -41,6 +41,7 @@
  RXE_POOL_ATOMIC =3D BIT(0),
  RXE_POOL_INDEX =3D BIT(1),
  RXE_POOL_KEY =3D BIT(2),
+ RXE_POOL_NO_ALLOC =3D BIT(4),
 };

 enum rxe_elem_type {
@@ -74,8 +75,8 @@
 extern struct rxe_type_info rxe_type_info[];

 enum rxe_pool_state {
- rxe_pool_invalid,
- rxe_pool_valid,
+ RXE_POOL_STATE_INVALID,
+ RXE_POOL_STATE_VALID,
 };

 struct rxe_pool_entry {
@@ -90,7 +91,7 @@

 struct rxe_pool {
  struct rxe_dev *rxe;
- spinlock_t              pool_lock; /* pool spinlock */
+ rwlock_t pool_lock; /* protects pool add/del/search */
  size_t elem_size;
  struct kref ref_cnt;
  void (*cleanup)(struct rxe_pool_entry *obj);
diff -ur linux-4.14.97/drivers/infiniband/sw/rxe/rxe_qp.c
linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe_qp.c
--- linux-4.14.97/drivers/infiniband/sw/rxe/rxe_qp.c 2019-01-31
15:13:48.000000000 +0800
+++ linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe_qp.c 2019-09-17
16:00:39.172896580 +0800
@@ -235,6 +235,16 @@
  return err;
  qp->sk->sk->sk_user_data =3D qp;

+ /* pick a source UDP port number for this QP based on
+ * the source QPN. this spreads traffic for different QPs
+ * across different NIC RX queues (while using a single
+ * flow for a given QP to maintain packet order).
+ * the port number must be in the Dynamic Ports range
+ * (0xc000 - 0xffff).
+ */
+ qp->src_port =3D RXE_ROCE_V2_SPORT +
+ (hash_32_generic(qp_num(qp), 14) & 0x3fff);
+
  qp->sq.max_wr =3D init->cap.max_send_wr;
  qp->sq.max_sge =3D init->cap.max_send_sge;
  qp->sq.max_inline =3D init->cap.max_inline_data;
diff -ur linux-4.14.97/drivers/infiniband/sw/rxe/rxe_req.c
linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe_req.c
--- linux-4.14.97/drivers/infiniband/sw/rxe/rxe_req.c 2019-01-31
15:13:48.000000000 +0800
+++ linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe_req.c 2019-09-17
16:00:39.172896580 +0800
@@ -73,9 +73,6 @@
  int npsn;
  int first =3D 1;

- wqe =3D queue_head(qp->sq.queue);
- npsn =3D (qp->comp.psn - wqe->first_psn) & BTH_PSN_MASK;
-
  qp->req.wqe_index =3D consumer_index(qp->sq.queue);
  qp->req.psn =3D qp->comp.psn;
  qp->req.opcode =3D -1;
@@ -107,11 +104,17 @@
  if (first) {
  first =3D 0;

- if (mask & WR_WRITE_OR_SEND_MASK)
+ if (mask & WR_WRITE_OR_SEND_MASK) {
+ npsn =3D (qp->comp.psn - wqe->first_psn) &
+ BTH_PSN_MASK;
  retry_first_write_send(qp, wqe, mask, npsn);
+ }

- if (mask & WR_READ_MASK)
+ if (mask & WR_READ_MASK) {
+ npsn =3D (wqe->dma.length - wqe->dma.resid) /
+ qp->mtu;
  wqe->iova +=3D npsn * qp->mtu;
+ }
  }

  wqe->state =3D wqe_state_posted;
@@ -435,7 +438,7 @@
  if (pkt->mask & RXE_RETH_MASK) {
  reth_set_rkey(pkt, ibwr->wr.rdma.rkey);
  reth_set_va(pkt, wqe->iova);
- reth_set_len(pkt, wqe->dma.length);
+ reth_set_len(pkt, wqe->dma.resid);
  }

  if (pkt->mask & RXE_IMMDT_MASK)
@@ -713,6 +716,7 @@

  if (fill_packet(qp, wqe, &pkt, skb, payload)) {
  pr_debug("qp#%d Error during fill packet\n", qp_num(qp));
+ kfree_skb(skb);
  goto err;
  }

@@ -744,7 +748,6 @@
  goto next_wqe;

 err:
- kfree_skb(skb);
  wqe->status =3D IB_WC_LOC_PROT_ERR;
  wqe->state =3D wqe_state_error;
  __rxe_do_task(&qp->comp.task);
diff -ur linux-4.14.97/drivers/infiniband/sw/rxe/rxe_resp.c
linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe_resp.c
--- linux-4.14.97/drivers/infiniband/sw/rxe/rxe_resp.c 2019-01-31
15:13:48.000000000 +0800
+++ linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe_resp.c 2019-09-17
16:00:39.173896585 +0800
@@ -124,12 +124,9 @@
  struct sk_buff *skb;

  if (qp->resp.state =3D=3D QP_STATE_ERROR) {
- skb =3D skb_dequeue(&qp->req_pkts);
- if (skb) {
- /* drain request packet queue */
+ while ((skb =3D skb_dequeue(&qp->req_pkts))) {
  rxe_drop_ref(qp);
  kfree_skb(skb);
- return RESPST_GET_REQ;
  }

  /* go drain recv wr queue */
@@ -435,6 +432,7 @@
  qp->resp.va =3D reth_va(pkt);
  qp->resp.rkey =3D reth_rkey(pkt);
  qp->resp.resid =3D reth_len(pkt);
+ qp->resp.length =3D reth_len(pkt);
  }
  access =3D (pkt->mask & RXE_READ_MASK) ? IB_ACCESS_REMOTE_READ
       : IB_ACCESS_REMOTE_WRITE;
@@ -860,7 +858,9 @@
  pkt->mask & RXE_WRITE_MASK) ?
  IB_WC_RECV_RDMA_WITH_IMM : IB_WC_RECV;
  wc->vendor_err =3D 0;
- wc->byte_len =3D wqe->dma.length - wqe->dma.resid;
+ wc->byte_len =3D (pkt->mask & RXE_IMMDT_MASK &&
+ pkt->mask & RXE_WRITE_MASK) ?
+ qp->resp.length : wqe->dma.length - wqe->dma.resid;

  /* fields after byte_len are different between kernel and user
  * space
diff -ur linux-4.14.97/drivers/infiniband/sw/rxe/rxe_verbs.c
linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe_verbs.c
--- linux-4.14.97/drivers/infiniband/sw/rxe/rxe_verbs.c 2019-01-31
15:13:48.000000000 +0800
+++ linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe_verbs.c 2019-09-17
16:00:39.174896590 +0800
@@ -644,6 +644,7 @@
  switch (wr->opcode) {
  case IB_WR_RDMA_WRITE_WITH_IMM:
  wr->ex.imm_data =3D ibwr->ex.imm_data;
+ /* fall through */
  case IB_WR_RDMA_READ:
  case IB_WR_RDMA_WRITE:
  wr->wr.rdma.remote_addr =3D rdma_wr(ibwr)->remote_addr;
@@ -774,7 +775,6 @@
  unsigned int mask;
  unsigned int length =3D 0;
  int i;
- int must_sched;

  while (wr) {
  mask =3D wr_opcode_mask(wr->opcode, qp);
@@ -804,14 +804,7 @@
  wr =3D wr->next;
  }

- /*
- * Must sched in case of GSI QP because ib_send_mad() hold irq lock,
- * and the requester call ip_local_out_sk() that takes spin_lock_bh.
- */
- must_sched =3D (qp_type(qp) =3D=3D IB_QPT_GSI) ||
- (queue_count(qp->sq.queue) > 1);
-
- rxe_run_task(&qp->req.task, must_sched);
+ rxe_run_task(&qp->req.task, 1);
  if (unlikely(qp->req.state =3D=3D QP_STATE_ERROR))
  rxe_run_task(&qp->comp.task, 1);

diff -ur linux-4.14.97/drivers/infiniband/sw/rxe/rxe_verbs.h
linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe_verbs.h
--- linux-4.14.97/drivers/infiniband/sw/rxe/rxe_verbs.h 2019-01-31
15:13:48.000000000 +0800
+++ linux-4.14.97-rxe/drivers/infiniband/sw/rxe/rxe_verbs.h 2019-09-17
16:00:39.174896590 +0800
@@ -160,6 +160,7 @@
  int opcode;
  int timeout;
  int timeout_retry;
+ int started_retry;
  u32 retry_cnt;
  u32 rnr_retry;
  struct rxe_task task;
@@ -214,6 +215,7 @@
  struct rxe_mem *mr;
  u32 resid;
  u32 rkey;
+ u32 length;
  u64 atomic_orig;

  /* SRQ only */
@@ -252,6 +254,7 @@

  struct socket *sk;
  u32 dst_cookie;
+ u16 src_port;

  struct rxe_av pri_av;
  struct rxe_av alt_av;

On Wed, Dec 25, 2019 at 3:23 PM Frank Huang <tigerinxm@gmail.com> wrote:
>
> hi leon
>
> I can not get what you means, do you say the rxe_add_ref(qp) is not neede=
d?
> My kernel is old, and I found some bugs of rxe on 4.14.97, especially
> the rnr errors.
> I can not upgrade whole kernel because there are many dependencies.
> Finally , I sync the fixed from newest kernel version to the 4.14.97.
>
> When I compare my rxe_resp.c with kernel 5.2.9 , I found the snippet
> of duplicate_request is changed.
> and rxe_xmit_packet will call rxe_send=EF=BC=8Center the log "rdma_rxe:
> Unknown layer 3 protocol: 0"
>
>   1137 } else {
>   1138 struct resp_res *res;
>   1139
>   1140 /* Find the operation in our list of responder resources. */
>   1141 res =3D find_resource(qp, pkt->psn);
>   1142 if (res) {
>   1143 struct sk_buff *skb_copy;
>   1144
>   1145 skb_copy =3D skb_clone(res->atomic.skb, GFP_ATOMIC);
>   1146 if (skb_copy) {
>   1147 rxe_add_ref(qp); /* for the new SKB */
>   1148 } else {
>   1149 pr_warn("Couldn't clone atomic resp\n");
>   1150 rc =3D RESPST_CLEANUP;
>   1151 goto out;
>   1152 }
>   1153
>   1154 /* Resend the result. */
>   1155 rc =3D rxe_xmit_packet(to_rdev(qp->ibqp.device), qp,
>   1156      pkt, skb_copy);
>   1157 if (rc) {
>   1158 pr_err("Failed resending result. This flow is not handled - skb
> ignored\n");
>   1159 rxe_drop_ref(qp);
>   1160 rc =3D RESPST_CLEANUP;
>   1161 goto out;
>   1162 }
>   1163 }
>   1164
>   1165 /* Resource not found. Class D error. Drop the request. */
>   1166 rc =3D RESPST_CLEANUP;
>   1167 goto out;
>   1168 }
>   1169 out:
>   1170 return rc;
>   1171 }
>
> On Wed, Dec 25, 2019 at 2:33 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Wed, Dec 25, 2019 at 12:55:35PM +0800, Frank Huang wrote:
> > > hi, there is a panic on rdma_rxe module when the restart
> > > network.service or shutdown the switch.
> > >
> > > it looks like a use-after-free error.
> > >
> > > everytime it happens, there is the log "rdma_rxe: Unknown layer 3 pro=
tocol: 0"
> >
> > The error print itself is harmless.
> > >
> > > is it a known error?
> > >
> > > my kernel version is 4.14.97
> >
> > Your kernel is old enough and doesn't include refcount,
> > so I can't say for sure that it is the case, but the
> > following code is not correct and with refcount debug
> > it will be seen immediately.
> >
> > 1213 int rxe_responder(void *arg)
> > 1214 {
> > 1215         struct rxe_qp *qp =3D (struct rxe_qp *)arg;
> > 1216         struct rxe_dev *rxe =3D to_rdev(qp->ibqp.device);
> > 1217         enum resp_states state;
> > 1218         struct rxe_pkt_info *pkt =3D NULL;
> > 1219         int ret =3D 0;
> > 1220
> > 1221         rxe_add_ref(qp); <------ USE-AFTER-FREE
> > 1222
> > 1223         qp->resp.aeth_syndrome =3D AETH_ACK_UNLIMITED;
> > 1224
> > 1225         if (!qp->valid) {
> > 1226                 ret =3D -EINVAL;
> > 1227                 goto done;
> > 1228         }
> >
> > Thanks
