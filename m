Return-Path: <linux-rdma+bounces-5220-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E49990A41
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 19:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FBE81C2231E
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Oct 2024 17:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77C01AA781;
	Fri,  4 Oct 2024 17:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="uGqUGIvJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59C51D9A64
	for <linux-rdma@vger.kernel.org>; Fri,  4 Oct 2024 17:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728063507; cv=none; b=Ev9rii2FPjlRIEmPJ6h8e+9UI9ilVsVL1sxiHV8HSNUs7GHbiN/hmBYNfpnXNnt5C6+qqvTj9Z3bypC26bnaJ7i7TSU8oTUHRaDf7svLo62G2Dytud3dF+Gut654PnarBrOAZ5gLiXjAc7HgZ50Vy1pl14vX/+inciWzWq20G3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728063507; c=relaxed/simple;
	bh=sJXDl7EsR4t7idJszBY6ELFcBfHMWenZF2RBoT5SWOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E5AI/P951EF16dFV3wuYvQDawpnoanxEfygS6Jl6vQTTAdd+sxxbgiGG7TUxWATBkpWYxyq2Mk0C7VKmi3uzFIZDe/UISXiRvQNOHwwkqqGiWjtIGRdJsFtn0hu0OvetLMveBlKWHyDoxZPyEboMO8d5QUmSp6of+PpjEvkqopU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=uGqUGIvJ; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XKwkM1bwcz6ClSq6;
	Fri,  4 Oct 2024 17:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:from:from:received:received; s=mr01; t=
	1728063493; x=1730655494; bh=B1dnS3EnHN0tHQiLsVN7LfAoz2zWK4ddUIW
	txf0GpqA=; b=uGqUGIvJ2msnktLOC1iXyW02gzx/CPWPBdKAfsbm5WpmPxntY51
	45Q1f9R5ne/6nyiqL8tZdJQpx/X25yfDg/8MX6toz1pEHSqsTCrFzWW3sXuIWMJw
	p4vacSvcZmBItRfPrUxiYHHdEHzBWQjRHRLUf/ZOyXmR1XhUxgFE0wMptYNu+BPy
	J2ciBt7BGbeQbKvs46n55LSAbbsYmKQHlFoABWRdvAX6vIrJl4u0JZuefrPJlvis
	kq3/zM/15Wauw814cMBiVimmOo6RQLSH/rgPk7xzQb5XjZ0GpDpBKrDIBYPw8IBQ
	nxHLptdz+OrzxTowmIfS6Ze05J5L+/fK6HA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 3rud-8pECClz; Fri,  4 Oct 2024 17:38:13 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XKwkD6W1Hz6ClSq3;
	Fri,  4 Oct 2024 17:38:12 +0000 (UTC)
From: Bart Van Assche <bvanassche@acm.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] RDMA/srpt: Make slab cache names unique
Date: Fri,  4 Oct 2024 10:37:30 -0700
Message-ID: <20241004173730.1932859-1-bvanassche@acm.org>
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
patch that makes cache names unique.

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/linux-block/xpe6bea7rakpyoyfvspvin2dsozjm=
jtjktpph7rep3h25tv7fb@ooz4cu5z6bq6/
Fixes: 5dabcd0456d7 ("RDMA/srpt: Add support for immediate data")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 32 ++++++++++++++++++++++-----
 drivers/infiniband/ulp/srpt/ib_srpt.h |  6 +++++
 2 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/u=
lp/srpt/ib_srpt.c
index 9632afbd727b..4cb462074f00 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -41,6 +41,7 @@
 #include <linux/string.h>
 #include <linux/delay.h>
 #include <linux/atomic.h>
+#include <linux/idr.h>
 #include <linux/inet.h>
 #include <rdma/ib_cache.h>
 #include <scsi/scsi_proto.h>
@@ -68,6 +69,7 @@ MODULE_LICENSE("Dual BSD/GPL");
 static u64 srpt_service_guid;
 static DEFINE_SPINLOCK(srpt_dev_lock);	/* Protects srpt_dev_list. */
 static LIST_HEAD(srpt_dev_list);	/* List of srpt_device structures. */
+static DEFINE_IDA(cache_ida);
=20
 static unsigned srp_max_req_size =3D DEFAULT_MAX_REQ_SIZE;
 module_param(srp_max_req_size, int, 0444);
@@ -2120,12 +2122,14 @@ static void srpt_release_channel_work(struct work=
_struct *w)
 			     ch->rsp_buf_cache, DMA_TO_DEVICE);
=20
 	kmem_cache_destroy(ch->rsp_buf_cache);
+	ida_free(&cache_ida, ch->rsp_buf_cache_idx);
=20
 	srpt_free_ioctx_ring((struct srpt_ioctx **)ch->ioctx_recv_ring,
 			     sdev, ch->rq_size,
 			     ch->req_buf_cache, DMA_FROM_DEVICE);
=20
 	kmem_cache_destroy(ch->req_buf_cache);
+	ida_free(&cache_ida, ch->req_buf_cache_idx);
=20
 	kref_put(&ch->kref, srpt_free_ch);
 }
@@ -2164,6 +2168,7 @@ static int srpt_cm_req_recv(struct srpt_device *con=
st sdev,
 	u32 it_iu_len;
 	int i, tag_num, tag_size, ret;
 	struct srpt_tpg *stpg;
+	char cache_name[32];
=20
 	WARN_ON_ONCE(irqs_disabled());
=20
@@ -2245,8 +2250,11 @@ static int srpt_cm_req_recv(struct srpt_device *co=
nst sdev,
 	INIT_LIST_HEAD(&ch->cmd_wait_list);
 	ch->max_rsp_size =3D ch->sport->port_attrib.srp_max_rsp_size;
=20
-	ch->rsp_buf_cache =3D kmem_cache_create("srpt-rsp-buf", ch->max_rsp_siz=
e,
-					      512, 0, NULL);
+	ch->rsp_buf_cache_idx =3D ida_alloc(&cache_ida, GFP_KERNEL);
+	snprintf(cache_name, sizeof(cache_name), "srpt-rsp-buf-%u",
+		 ch->rsp_buf_cache_idx);
+	ch->rsp_buf_cache =3D
+		kmem_cache_create(cache_name, ch->max_rsp_size, 512, 0, NULL);
 	if (!ch->rsp_buf_cache)
 		goto free_ch;
=20
@@ -2280,8 +2288,11 @@ static int srpt_cm_req_recv(struct srpt_device *co=
nst sdev,
 		alignment_offset =3D round_up(imm_data_offset, 512) -
 			imm_data_offset;
 		req_sz =3D alignment_offset + imm_data_offset + srp_max_req_size;
-		ch->req_buf_cache =3D kmem_cache_create("srpt-req-buf", req_sz,
-						      512, 0, NULL);
+		ch->req_buf_cache_idx =3D ida_alloc(&cache_ida, GFP_KERNEL);
+		snprintf(cache_name, sizeof(cache_name), "srpt-req-buf-%u",
+			 ch->req_buf_cache_idx);
+		ch->req_buf_cache =3D
+			kmem_cache_create(cache_name, req_sz, 512, 0, NULL);
 		if (!ch->req_buf_cache)
 			goto free_rsp_ring;
=20
@@ -2479,6 +2490,7 @@ static int srpt_cm_req_recv(struct srpt_device *con=
st sdev,
=20
 free_recv_cache:
 	kmem_cache_destroy(ch->req_buf_cache);
+	ida_free(&cache_ida, ch->req_buf_cache_idx);
=20
 free_rsp_ring:
 	srpt_free_ioctx_ring((struct srpt_ioctx **)ch->ioctx_ring,
@@ -2487,6 +2499,7 @@ static int srpt_cm_req_recv(struct srpt_device *con=
st sdev,
=20
 free_rsp_cache:
 	kmem_cache_destroy(ch->rsp_buf_cache);
+	ida_free(&cache_ida, ch->rsp_buf_cache_idx);
=20
 free_ch:
 	if (rdma_cm_id)
@@ -3056,6 +3069,7 @@ static void srpt_free_srq(struct srpt_device *sdev)
 			     sdev->srq_size, sdev->req_buf_cache,
 			     DMA_FROM_DEVICE);
 	kmem_cache_destroy(sdev->req_buf_cache);
+	ida_free(&cache_ida, sdev->req_buf_cache_idx);
 	sdev->srq =3D NULL;
 }
=20
@@ -3070,6 +3084,7 @@ static int srpt_alloc_srq(struct srpt_device *sdev)
 	};
 	struct ib_device *device =3D sdev->device;
 	struct ib_srq *srq;
+	char cache_name[32];
 	int i;
=20
 	WARN_ON_ONCE(sdev->srq);
@@ -3082,8 +3097,11 @@ static int srpt_alloc_srq(struct srpt_device *sdev=
)
 	pr_debug("create SRQ #wr=3D %d max_allow=3D%d dev=3D %s\n", sdev->srq_s=
ize,
 		 sdev->device->attrs.max_srq_wr, dev_name(&device->dev));
=20
-	sdev->req_buf_cache =3D kmem_cache_create("srpt-srq-req-buf",
-						srp_max_req_size, 0, 0, NULL);
+	sdev->req_buf_cache_idx =3D ida_alloc(&cache_ida, GFP_KERNEL);
+	snprintf(cache_name, sizeof(cache_name), "srpt-srq-req-buf-%u",
+		 sdev->req_buf_cache_idx);
+	sdev->req_buf_cache =3D
+		kmem_cache_create(cache_name, srp_max_req_size, 0, 0, NULL);
 	if (!sdev->req_buf_cache)
 		goto free_srq;
=20
@@ -3106,6 +3124,7 @@ static int srpt_alloc_srq(struct srpt_device *sdev)
=20
 free_cache:
 	kmem_cache_destroy(sdev->req_buf_cache);
+	ida_free(&cache_ida, sdev->req_buf_cache_idx);
=20
 free_srq:
 	ib_destroy_srq(srq);
@@ -3926,6 +3945,7 @@ static void __exit srpt_cleanup_module(void)
 		rdma_destroy_id(rdma_cm_id);
 	ib_unregister_client(&srpt_client);
 	target_unregister_template(&srpt_template);
+	ida_destroy(&cache_ida);
 }
=20
 module_init(srpt_init_module);
diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.h b/drivers/infiniband/u=
lp/srpt/ib_srpt.h
index 4c46b301eea1..6d10cd7c9f21 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.h
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.h
@@ -276,6 +276,8 @@ enum rdma_ch_state {
  * @state:         channel state. See also enum rdma_ch_state.
  * @using_rdma_cm: Whether the RDMA/CM or IB/CM is used for this channel=
.
  * @processing_wait_list: Whether or not cmd_wait_list is being processe=
d.
+ * @rsp_buf_cache_idx: @rsp_buf_cache index for slab.
+ * @req_buf_cache_idx: @req_buf_cache index for slab.
  * @rsp_buf_cache: kmem_cache for @ioctx_ring.
  * @ioctx_ring:    Send ring.
  * @req_buf_cache: kmem_cache for @ioctx_recv_ring.
@@ -316,6 +318,8 @@ struct srpt_rdma_ch {
 	u16			imm_data_offset;
 	spinlock_t		spinlock;
 	enum rdma_ch_state	state;
+	int			rsp_buf_cache_idx;
+	int			req_buf_cache_idx;
 	struct kmem_cache	*rsp_buf_cache;
 	struct srpt_send_ioctx	**ioctx_ring;
 	struct kmem_cache	*req_buf_cache;
@@ -443,6 +447,7 @@ struct srpt_port {
  * @srq_size:      SRQ size.
  * @sdev_mutex:	   Serializes use_srq changes.
  * @use_srq:       Whether or not to use SRQ.
+ * @req_buf_cache_idx: @req_buf_cache index for slab.
  * @req_buf_cache: kmem_cache for @ioctx_ring buffers.
  * @ioctx_ring:    Per-HCA SRQ.
  * @event_handler: Per-HCA asynchronous IB event handler.
@@ -459,6 +464,7 @@ struct srpt_device {
 	int			srq_size;
 	struct mutex		sdev_mutex;
 	bool			use_srq;
+	int			req_buf_cache_idx;
 	struct kmem_cache	*req_buf_cache;
 	struct srpt_recv_ioctx	**ioctx_ring;
 	struct ib_event_handler	event_handler;

