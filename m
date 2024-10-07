Return-Path: <linux-rdma+bounces-5286-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3F2993866
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 22:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 613F71F22D22
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 20:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE70F1DE4FD;
	Mon,  7 Oct 2024 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="0sQ/x+2F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFECC1DE88C
	for <linux-rdma@vger.kernel.org>; Mon,  7 Oct 2024 20:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333477; cv=none; b=eW2HHK1FoRLb2iDPnPBwnRyQ1p885R4rncze2ot78WbOYbBmAKnd0D19py06umwh3p41cpWxKHBf7Eb4LX5rWXTTyvO96t2IbQFNWOT3BgRhXqKaqHKYPp7nZx125zq2xkKelVG/aie4ALIwo8b77dTcDf4VmdudNRJ9RbZ0Aho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333477; c=relaxed/simple;
	bh=weGsx732vc0vmXDwh+xaxGjpKmrCF0cMopDVJPROwhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aLct3Pv03zdpu74dC3+loSzDsJJIIck//a13VRSQYJFeXf99noYZukfktMGqi3Oo5/rlI64//xJC9VZ92vClC7JlyCWOjyTmW2jQQ9uLlLn1DAuO5qJIt+1IUVgRz656boEY2NuO01HX7t9LMdf3PH/4IHIz39ERBbpUAf8m484=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=0sQ/x+2F; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XMrZC09CdzlgTWP;
	Mon,  7 Oct 2024 20:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1728333470; x=1730925471; bh=vJWIWXoyY7Kii01ntszmCpMosxsq97U4o64
	PFF99Dx0=; b=0sQ/x+2FrifOiJJHGuwmTPdqdy8H4LaygpkcG1JJe8/E2zRUPEs
	c/3DnpxmKveFZql7YGONDVd1I8CbrjeMbUlKvY8n/P3o9Zr4qJ/zzIngmiIDDp6t
	sVelgnmGu2mDuTqPi0snS0nnTw8t/+uMCCfZHY1d5qK3rilnwR/CU++0WKu8l9es
	sUBndMTL1AQLDrOG8YOw7CURWg0HZmGIBd0PVwct/owW4j8AFNGCgRwm9FcaT8vv
	/Pap4aPokW7sLgEXWU6uOkjaIfqQhBvBvSjg18zUFaOADtsQfQr31aL7j6Vtpc6Q
	L71Yjw6zVIq1+UsiuMsdxZnfxwWimbhxzmw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Xdg9v8Ub3R8n; Mon,  7 Oct 2024 20:37:50 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XMrZ560qczlgTWM;
	Mon,  7 Oct 2024 20:37:49 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH v2] RDMA/srpt: Make slab cache names unique
Date: Mon,  7 Oct 2024 13:37:26 -0700
Message-ID: <20241007203726.3076222-1-bvanassche@acm.org>
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
 drivers/infiniband/ulp/srpt/ib_srpt.c | 79 +++++++++++++++++++++++----
 1 file changed, 67 insertions(+), 12 deletions(-)

Changes compared to v1:
 - Instead of using an ida to make slab names unique, maintain an xarray
   with the slab size as index and the slab pointer and a reference count=
 as
   contents.

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/u=
lp/srpt/ib_srpt.c
index 9632afbd727b..cc18179693bf 100644
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
@@ -105,6 +107,62 @@ static void srpt_recv_done(struct ib_cq *cq, struct =
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
+	if (IS_ERR(xa_store(&srpt_memory_caches, object_size, e, GFP_KERNEL)))
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
+	WARN_ON_ONCE(e->c !=3D c);
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
@@ -2119,13 +2177,13 @@ static void srpt_release_channel_work(struct work=
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
@@ -2245,8 +2303,7 @@ static int srpt_cm_req_recv(struct srpt_device *con=
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
@@ -2280,8 +2337,7 @@ static int srpt_cm_req_recv(struct srpt_device *con=
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
@@ -2478,7 +2534,7 @@ static int srpt_cm_req_recv(struct srpt_device *con=
st sdev,
 			     ch->req_buf_cache, DMA_FROM_DEVICE);
=20
 free_recv_cache:
-	kmem_cache_destroy(ch->req_buf_cache);
+	srpt_cache_put(ch->req_buf_cache);
=20
 free_rsp_ring:
 	srpt_free_ioctx_ring((struct srpt_ioctx **)ch->ioctx_ring,
@@ -2486,7 +2542,7 @@ static int srpt_cm_req_recv(struct srpt_device *con=
st sdev,
 			     ch->rsp_buf_cache, DMA_TO_DEVICE);
=20
 free_rsp_cache:
-	kmem_cache_destroy(ch->rsp_buf_cache);
+	srpt_cache_put(ch->rsp_buf_cache);
=20
 free_ch:
 	if (rdma_cm_id)
@@ -3055,7 +3111,7 @@ static void srpt_free_srq(struct srpt_device *sdev)
 	srpt_free_ioctx_ring((struct srpt_ioctx **)sdev->ioctx_ring, sdev,
 			     sdev->srq_size, sdev->req_buf_cache,
 			     DMA_FROM_DEVICE);
-	kmem_cache_destroy(sdev->req_buf_cache);
+	srpt_cache_put(sdev->req_buf_cache);
 	sdev->srq =3D NULL;
 }
=20
@@ -3082,8 +3138,7 @@ static int srpt_alloc_srq(struct srpt_device *sdev)
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
@@ -3105,7 +3160,7 @@ static int srpt_alloc_srq(struct srpt_device *sdev)
 	return 0;
=20
 free_cache:
-	kmem_cache_destroy(sdev->req_buf_cache);
+	srpt_cache_put(sdev->req_buf_cache);
=20
 free_srq:
 	ib_destroy_srq(srq);

