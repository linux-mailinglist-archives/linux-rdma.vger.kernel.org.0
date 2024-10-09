Return-Path: <linux-rdma+bounces-5342-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C566997724
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 23:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A42681F23003
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2024 21:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAF218FC86;
	Wed,  9 Oct 2024 21:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="2XXrNzom"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567C3188CDC
	for <linux-rdma@vger.kernel.org>; Wed,  9 Oct 2024 21:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507686; cv=none; b=pERPRYJfYOKMqC91BtiPILaJnxb/a+NbolO0HUfR7ONKwbGN29VzmEixXUmPx5I7M+WQHUWe2N2wXh4wrzAXVkUcE4R4wehaUpjZJDWi9vuvxPUAVCqqXbo9RCEhyahTehFlvJOvgREarT5MRKvrABHqc1Dzw6gUjX5TylJPG7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507686; c=relaxed/simple;
	bh=DS6QJqHIPaRZOohb7lTz4rEj3sq5vXe6CdkP2znLzY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WBbPURpYLRSjQT5cjGlMKp+xvlHWlnawGh+uHRVtIwgUDkO8OUJFboegDJBGGSEtS5xswHSAQvoE/Q0Xe48sxCraXwunt/YbdPkL0HzNPdQZkgomG99oyFGkVSvEwzQ0rnnpp9siXa3mKtfczmQ3/2sdj4P892mHhxXJRO//SPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=2XXrNzom; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XP50N4vGRz6CmM6d;
	Wed,  9 Oct 2024 21:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1728507678; x=1731099679; bh=zSNL49UorZGylL9UGJQEoPvoI6FHjvj+GRb
	uTjqG8TM=; b=2XXrNzomroz7xV4A0A8920IoZiGJ9DkgAB/gOcpkM7iZ1QBMie6
	aiVmvY3+kQgIWQchBYQR+eA/W0Ap/pHbPq0Z1v2FGjeg5j0/0pd35keZiq0S/xlc
	JZQgJuXaeEPPFpzf+CAMC1JEFyJosXLIAdX/Gwmlk5ncJI5BxKk4ixwJQYMdGUj2
	Ghmcr43/nGc+ooBR6sR0NQEiAzLJNlGDXENn6YL7/8fiDvi5lBeqJP7tmLCziic8
	Uqp69Vj5C7sfXnaax7GwIPPlr2ikXAfLud8Z8VvYKfbhPoRhTSzUWGvru4lZowG/
	giSVBpN6f9Yden4kJUCy1yPKToyFVFoPrnQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 8-bOFe2whKwd; Wed,  9 Oct 2024 21:01:18 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XP50D4ys3z6ClL95;
	Wed,  9 Oct 2024 21:01:16 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH v3] RDMA/srpt: Make slab cache names unique
Date: Wed,  9 Oct 2024 14:00:48 -0700
Message-ID: <20241009210048.4122518-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since commit 4c39529663b9 ("slab: Warn on duplicate cache names when
DEBUG_VM=3Dy"), slab complains about duplicate cache names. Hence this
patch. The approach is as follows:
- Maintain an xarray with the slab size as index and a reference count
  and a kmem_cache pointer as contents. Use srpt-${slab_size} as kmem
  cache name.
- Use 512-byte alignment for all slabs instead of only for some of the
  slabs.
- Increment the reference count instead of calling kmem_cache_create().
- Decrement the reference count instead of calling kmem_cache_destroy().

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/linux-block/xpe6bea7rakpyoyfvspvin2dsozjm=
jtjktpph7rep3h25tv7fb@ooz4cu5z6bq6/
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Fixes: 5dabcd0456d7 ("RDMA/srpt: Add support for immediate data")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---

Changes compared to v2:
 - Use xa_is_err() instead of IS_ERR() to check the xa_store() result.
 - Removed a WARN_ON_ONCE() statement that would never trigger a warning.

Changes compared to v1:
 - Instead of using an ida to make slab names unique, maintain an xarray
   with the slab size as index and the slab pointer and a reference count=
 as
   contents.

 drivers/infiniband/ulp/srpt/ib_srpt.c | 80 +++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/u=
lp/srpt/ib_srpt.c
index 9632afbd727b..5dfb4644446b 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -68,6 +68,8 @@ MODULE_LICENSE("Dual BSD/GPL");
 static u64 srpt_service_guid;
 static DEFINE_SPINLOCK(srpt_dev_lock);	/* Protects srpt_dev_list. */
 static LIST_HEAD(srpt_dev_list);	/* List of srpt_device structures. */
+static DEFINE_MUTEX(srpt_mc_mutex);	/* Protects srpt_memory_caches. */
+static DEFINE_XARRAY(srpt_memory_caches); /* See also srpt_memory_cache_=
entry */
=20
 static unsigned srp_max_req_size =3D DEFAULT_MAX_REQ_SIZE;
 module_param(srp_max_req_size, int, 0444);
@@ -105,6 +107,63 @@ static void srpt_recv_done(struct ib_cq *cq, struct =
ib_wc *wc);
 static void srpt_send_done(struct ib_cq *cq, struct ib_wc *wc);
 static void srpt_process_wait_list(struct srpt_rdma_ch *ch);
=20
+/* Type of the entries in srpt_memory_caches. */
+struct srpt_memory_cache_entry {
+	refcount_t ref;
+	struct kmem_cache *c;
+};
+
+static struct kmem_cache *srpt_cache_get(unsigned int object_size)
+{
+	struct srpt_memory_cache_entry *e;
+	char name[32];
+	void *res;
+
+	guard(mutex)(&srpt_mc_mutex);
+	e =3D xa_load(&srpt_memory_caches, object_size);
+	if (e) {
+		refcount_inc(&e->ref);
+		return e->c;
+	}
+	snprintf(name, sizeof(name), "srpt-%u", object_size);
+	e =3D kmalloc(sizeof(*e), GFP_KERNEL);
+	if (!e)
+		return NULL;
+	refcount_set(&e->ref, 1);
+	e->c =3D kmem_cache_create(name, object_size, /*align=3D*/512, 0, NULL)=
;
+	if (!e->c)
+		goto free_entry;
+	res =3D xa_store(&srpt_memory_caches, object_size, e, GFP_KERNEL);
+	if (xa_is_err(res))
+		goto destroy_cache;
+	return e->c;
+
+destroy_cache:
+	kmem_cache_destroy(e->c);
+
+free_entry:
+	kfree(e);
+	return NULL;
+}
+
+static void srpt_cache_put(struct kmem_cache *c)
+{
+	struct srpt_memory_cache_entry *e =3D NULL;
+	unsigned long object_size;
+
+	guard(mutex)(&srpt_mc_mutex);
+	xa_for_each(&srpt_memory_caches, object_size, e)
+		if (e->c =3D=3D c)
+			break;
+	if (WARN_ON_ONCE(!e))
+		return;
+	if (!refcount_dec_and_test(&e->ref))
+		return;
+	WARN_ON_ONCE(xa_erase(&srpt_memory_caches, object_size) !=3D e);
+	kmem_cache_destroy(e->c);
+	kfree(e);
+}
+
 /*
  * The only allowed channel state changes are those that change the chan=
nel
  * state into a state with a higher numerical value. Hence the new > pre=
v test.
@@ -2119,13 +2178,13 @@ static void srpt_release_channel_work(struct work=
_struct *w)
 			     ch->sport->sdev, ch->rq_size,
 			     ch->rsp_buf_cache, DMA_TO_DEVICE);
=20
-	kmem_cache_destroy(ch->rsp_buf_cache);
+	srpt_cache_put(ch->rsp_buf_cache);
=20
 	srpt_free_ioctx_ring((struct srpt_ioctx **)ch->ioctx_recv_ring,
 			     sdev, ch->rq_size,
 			     ch->req_buf_cache, DMA_FROM_DEVICE);
=20
-	kmem_cache_destroy(ch->req_buf_cache);
+	srpt_cache_put(ch->req_buf_cache);
=20
 	kref_put(&ch->kref, srpt_free_ch);
 }
@@ -2245,8 +2304,7 @@ static int srpt_cm_req_recv(struct srpt_device *con=
st sdev,
 	INIT_LIST_HEAD(&ch->cmd_wait_list);
 	ch->max_rsp_size =3D ch->sport->port_attrib.srp_max_rsp_size;
=20
-	ch->rsp_buf_cache =3D kmem_cache_create("srpt-rsp-buf", ch->max_rsp_siz=
e,
-					      512, 0, NULL);
+	ch->rsp_buf_cache =3D srpt_cache_get(ch->max_rsp_size);
 	if (!ch->rsp_buf_cache)
 		goto free_ch;
=20
@@ -2280,8 +2338,7 @@ static int srpt_cm_req_recv(struct srpt_device *con=
st sdev,
 		alignment_offset =3D round_up(imm_data_offset, 512) -
 			imm_data_offset;
 		req_sz =3D alignment_offset + imm_data_offset + srp_max_req_size;
-		ch->req_buf_cache =3D kmem_cache_create("srpt-req-buf", req_sz,
-						      512, 0, NULL);
+		ch->req_buf_cache =3D srpt_cache_get(req_sz);
 		if (!ch->req_buf_cache)
 			goto free_rsp_ring;
=20
@@ -2478,7 +2535,7 @@ static int srpt_cm_req_recv(struct srpt_device *con=
st sdev,
 			     ch->req_buf_cache, DMA_FROM_DEVICE);
=20
 free_recv_cache:
-	kmem_cache_destroy(ch->req_buf_cache);
+	srpt_cache_put(ch->req_buf_cache);
=20
 free_rsp_ring:
 	srpt_free_ioctx_ring((struct srpt_ioctx **)ch->ioctx_ring,
@@ -2486,7 +2543,7 @@ static int srpt_cm_req_recv(struct srpt_device *con=
st sdev,
 			     ch->rsp_buf_cache, DMA_TO_DEVICE);
=20
 free_rsp_cache:
-	kmem_cache_destroy(ch->rsp_buf_cache);
+	srpt_cache_put(ch->rsp_buf_cache);
=20
 free_ch:
 	if (rdma_cm_id)
@@ -3055,7 +3112,7 @@ static void srpt_free_srq(struct srpt_device *sdev)
 	srpt_free_ioctx_ring((struct srpt_ioctx **)sdev->ioctx_ring, sdev,
 			     sdev->srq_size, sdev->req_buf_cache,
 			     DMA_FROM_DEVICE);
-	kmem_cache_destroy(sdev->req_buf_cache);
+	srpt_cache_put(sdev->req_buf_cache);
 	sdev->srq =3D NULL;
 }
=20
@@ -3082,8 +3139,7 @@ static int srpt_alloc_srq(struct srpt_device *sdev)
 	pr_debug("create SRQ #wr=3D %d max_allow=3D%d dev=3D %s\n", sdev->srq_s=
ize,
 		 sdev->device->attrs.max_srq_wr, dev_name(&device->dev));
=20
-	sdev->req_buf_cache =3D kmem_cache_create("srpt-srq-req-buf",
-						srp_max_req_size, 0, 0, NULL);
+	sdev->req_buf_cache =3D srpt_cache_get(srp_max_req_size);
 	if (!sdev->req_buf_cache)
 		goto free_srq;
=20
@@ -3105,7 +3161,7 @@ static int srpt_alloc_srq(struct srpt_device *sdev)
 	return 0;
=20
 free_cache:
-	kmem_cache_destroy(sdev->req_buf_cache);
+	srpt_cache_put(sdev->req_buf_cache);
=20
 free_srq:
 	ib_destroy_srq(srq);

