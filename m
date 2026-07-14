Return-Path: <linux-rdma+bounces-23187-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Kjq0HygVVmquywAAu9opvQ
	(envelope-from <linux-rdma+bounces-23187-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 12:53:28 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0597539A9
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 12:53:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IdFSjpq+;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23187-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23187-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B4E93172A65
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 10:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BFB370D4F;
	Tue, 14 Jul 2026 10:50:22 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8B236AB5A;
	Tue, 14 Jul 2026 10:50:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026222; cv=none; b=TImyy/4QbhGJoBSytpEZn6mp7yF0KN7EZIWfUoXl6dOp6+f54PrUyOlL99NvV5io+gIgtvnYEHmz28x85hMJwe1g53zY/fyjLO9W5Sb8jHkaO9QM9MNDZoW0Yd/i0MvJBH6MC2nfHTxtL/JjvIMCOOO5LQx0Vkfd5BXUgkUclTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026222; c=relaxed/simple;
	bh=S1YKqLp+zeGdnEQ3DThuaaAsF/0SajHOAJfEczntfk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pMEsojLPagxNiLpUNV8XdIQDBojKUZQAfHWhqEz4o3EZrxXZTNa83IeBhErUcI+vAX/Rl/Be6TtFU3TkZJ6jejaIpjK7DtKJ9leK7+/vBImpm76W0PopZgGQ+Ft1vuN5ucZ57aVOWx+id+jcT5y+ntE9ewLIMAkvUk04AaMabNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdFSjpq+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A673A1F00A3A;
	Tue, 14 Jul 2026 10:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784026221;
	bh=sK4Lf3daq48rlYKbsi/uuM4qX0fuldUxbAOruMByj2I=;
	h=From:To:Cc:Subject:Date;
	b=IdFSjpq+iZbUbigDKMuP/34OfriXJUoRXBzdFlyZgWSb+Lha3vC5R7ihceuUXBvfw
	 0HZsNyXFOshDYPza7vhp/x/mrei/vgtY7dKS6HqTam90SNoZ3VDRKi3zHiXvs1rrnY
	 4Vy9LFphnQgtxyjtvUZmsHRpjNszzCL5MUqZ53CewuIzT+JxyqvRg6ueVzfOmf9pSu
	 4dUATU6E7EN1opDEzI/85plo1+XvyePtVVFXP3u0pdaoKy73hMDbi3pE5/UtfuPvXt
	 kzOSe3QHUcJD38KUjzttw/oypZFWpPiV5tZs65JnPfuIfZySKgUoxqP3nTUdk90ksQ
	 JdZ6++i7SVBpQ==
From: Leon Romanovsky <leon@kernel.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Jacob Moroni <jmoroni@google.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next v2] RDMA/bnxt_re: Validate udata before executing commands
Date: Tue, 14 Jul 2026 13:50:00 +0300
Message-ID: <20260714-fix-destroy-no-udata-v2-1-734fdcf667d5@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260712-fix-destroy-no-udata-dfa990b985ea
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23187-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:selvin.xavier@broadcom.com,m:kalesh-anakkur.purayil@broadcom.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:jmoroni@google.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC0597539A9

From: Leon Romanovsky <leonro@nvidia.com>=0D
=0D
The destroy callbacks currently zero the udata output after tearing down=0D
driver resources. If the userspace access fails, uverbs preserves the=0D
uobject and allows the destroy callback to run again, even though the=0D
driver resource has already been freed.=0D
=0D
Call ib_no_udata_io() before teardown so udata failures are detected=0D
while the resource is still intact, then return success after teardown=0D
completes.=0D
=0D
As part of this change, move ib_respond_empty_udata() to the start of=0D
the create and modify flows. While this is not strictly required for=0D
general create flows, as the core layer unwinds uobjects on failure, it=0D
is necessary for create AH. In _rdma_create_ah(), the HW object is=0D
otherwise leaked.=0D
=0D
Fixes: bed686d8dcd4 ("RDMA/bnxt_re: Use ib_respond_empty_udata()")=0D
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>=0D
---=0D
Jacob, Selvin=0D
=0D
I didn't add your tags, as this patch was slightly changed from the=0D
previous version.=0D
=0D
Thanks=0D
=0D
Changes in v2:=0D
- Changed create and modify paths too=0D
- Link to v1: https://patch.msgid.link/20260713-fix-destroy-no-udata-v1-0-f=
cca2e34fd57@nvidia.com=0D
---=0D
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 65 +++++++++++++++-------------=
----=0D
 1 file changed, 30 insertions(+), 35 deletions(-)=0D
=0D
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/=
hw/bnxt_re/ib_verbs.c=0D
index 90138d64adee..adc693736769 100644=0D
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c=0D
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c=0D
@@ -694,7 +694,7 @@ int bnxt_re_dealloc_pd(struct ib_pd *ib_pd, struct ib_u=
data *udata)=0D
 	struct bnxt_re_dev *rdev =3D pd->rdev;=0D
 	int ret;=0D
 =0D
-	ret =3D ib_is_udata_in_empty(udata);=0D
+	ret =3D ib_no_udata_io(udata);=0D
 	if (ret)=0D
 		return ret;=0D
 =0D
@@ -711,7 +711,7 @@ int bnxt_re_dealloc_pd(struct ib_pd *ib_pd, struct ib_u=
data *udata)=0D
 					   &pd->qplib_pd))=0D
 			atomic_dec(&rdev->stats.res.pd_count);=0D
 	}=0D
-	return ib_respond_empty_udata(udata);=0D
+	return 0;=0D
 }=0D
 =0D
 int bnxt_re_alloc_pd(struct ib_pd *ibpd, struct ib_udata *udata)=0D
@@ -843,7 +843,7 @@ int bnxt_re_create_ah(struct ib_ah *ib_ah, struct rdma_=
ah_init_attr *init_attr,=0D
 	u8 nw_type;=0D
 	int rc;=0D
 =0D
-	rc =3D ib_is_udata_in_empty(udata);=0D
+	rc =3D ib_no_udata_io(udata);=0D
 	if (rc)=0D
 		return rc;=0D
 =0D
@@ -900,7 +900,7 @@ int bnxt_re_create_ah(struct ib_ah *ib_ah, struct rdma_=
ah_init_attr *init_attr,=0D
 	if (active_ahs > rdev->stats.res.ah_watermark)=0D
 		rdev->stats.res.ah_watermark =3D active_ahs;=0D
 =0D
-	return ib_respond_empty_udata(udata);=0D
+	return 0;=0D
 }=0D
 =0D
 int bnxt_re_query_ah(struct ib_ah *ib_ah, struct rdma_ah_attr *ah_attr)=0D
@@ -1014,7 +1014,7 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib=
_udata *udata)=0D
 	unsigned int flags;=0D
 	int rc;=0D
 =0D
-	rc =3D ib_is_udata_in_empty(udata);=0D
+	rc =3D ib_no_udata_io(udata);=0D
 	if (rc)=0D
 		return rc;=0D
 =0D
@@ -1063,7 +1063,7 @@ int bnxt_re_destroy_qp(struct ib_qp *ib_qp, struct ib=
_udata *udata)=0D
 	if (scq_nq !=3D rcq_nq)=0D
 		bnxt_re_synchronize_nq(rcq_nq);=0D
 =0D
-	return ib_respond_empty_udata(udata);=0D
+	return 0;=0D
 }=0D
 =0D
 static u8 __from_ib_qp_type(enum ib_qp_type type)=0D
@@ -2147,7 +2147,7 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct=
 ib_udata *udata)=0D
 	struct bnxt_qplib_srq *qplib_srq =3D &srq->qplib_srq;=0D
 	int ret;=0D
 =0D
-	ret =3D ib_is_udata_in_empty(udata);=0D
+	ret =3D ib_no_udata_io(udata);=0D
 	if (ret)=0D
 		return ret;=0D
 =0D
@@ -2158,7 +2158,7 @@ int bnxt_re_destroy_srq(struct ib_srq *ib_srq, struct=
 ib_udata *udata)=0D
 		free_page((unsigned long)srq->uctx_srq_page);=0D
 	ib_umem_release(srq->umem);=0D
 	atomic_dec(&rdev->stats.res.srq_count);=0D
-	return ib_respond_empty_udata(udata);=0D
+	return 0;=0D
 }=0D
 =0D
 static int bnxt_re_init_user_srq(struct bnxt_re_dev *rdev,=0D
@@ -2296,34 +2296,25 @@ int bnxt_re_modify_srq(struct ib_srq *ib_srq, struc=
t ib_srq_attr *srq_attr,=0D
 {=0D
 	struct bnxt_re_srq *srq =3D container_of(ib_srq, struct bnxt_re_srq,=0D
 					       ib_srq);=0D
-	struct bnxt_re_dev *rdev =3D srq->rdev;=0D
 	int ret;=0D
 =0D
-	ret =3D ib_is_udata_in_empty(udata);=0D
+	ret =3D ib_no_udata_io(udata);=0D
 	if (ret)=0D
 		return ret;=0D
 =0D
-	switch (srq_attr_mask) {=0D
-	case IB_SRQ_MAX_WR:=0D
-		/* SRQ resize is not supported */=0D
+	if (srq_attr_mask !=3D IB_SRQ_LIMIT)=0D
 		return -EINVAL;=0D
-	case IB_SRQ_LIMIT:=0D
-		/* Change the SRQ threshold */=0D
-		if (srq_attr->srq_limit > srq->qplib_srq.max_wqe)=0D
-			return -EINVAL;=0D
 =0D
-		srq->qplib_srq.threshold =3D srq_attr->srq_limit;=0D
-		bnxt_qplib_srq_arm_db(&srq->qplib_srq.dbinfo, srq->qplib_srq.threshold);=
=0D
-=0D
-		/* On success, update the shadow */=0D
-		srq->srq_limit =3D srq_attr->srq_limit;=0D
-		/* No need to Build and send response back to udata */=0D
-		return ib_respond_empty_udata(udata);=0D
-	default:=0D
-		ibdev_err(&rdev->ibdev,=0D
-			  "Unsupported srq_attr_mask 0x%x", srq_attr_mask);=0D
+	if (srq_attr->srq_limit > srq->qplib_srq.max_wqe)=0D
 		return -EINVAL;=0D
-	}=0D
+=0D
+	srq->qplib_srq.threshold =3D srq_attr->srq_limit;=0D
+	bnxt_qplib_srq_arm_db(&srq->qplib_srq.dbinfo, srq->qplib_srq.threshold);=
=0D
+=0D
+	/* On success, update the shadow */=0D
+	srq->srq_limit =3D srq_attr->srq_limit;=0D
+	/* No need to Build and send response back to udata */=0D
+	return 0;=0D
 }=0D
 =0D
 int bnxt_re_query_srq(struct ib_srq *ib_srq, struct ib_srq_attr *srq_attr)=
=0D
@@ -2436,7 +2427,7 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_=
qp_attr *qp_attr,=0D
 	unsigned int flags;=0D
 	u8 nw_type;=0D
 =0D
-	rc =3D ib_is_udata_in_empty(udata);=0D
+	rc =3D ib_no_udata_io(udata);=0D
 	if (rc)=0D
 		return rc;=0D
 =0D
@@ -2688,7 +2679,7 @@ int bnxt_re_modify_qp(struct ib_qp *ib_qp, struct ib_=
qp_attr *qp_attr,=0D
 		if (rc)=0D
 			return rc;=0D
 	}=0D
-	return ib_respond_empty_udata(udata);=0D
+	return 0;=0D
 }=0D
 =0D
 int bnxt_re_query_qp(struct ib_qp *ib_qp, struct ib_qp_attr *qp_attr,=0D
@@ -3470,7 +3461,7 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib=
_udata *udata)=0D
 	nq =3D cq->qplib_cq.nq;=0D
 	cctx =3D rdev->chip_ctx;=0D
 =0D
-	ret =3D ib_is_udata_in_empty(udata);=0D
+	ret =3D ib_no_udata_io(udata);=0D
 	if (ret)=0D
 		return ret;=0D
 =0D
@@ -3485,7 +3476,7 @@ int bnxt_re_destroy_cq(struct ib_cq *ib_cq, struct ib=
_udata *udata)=0D
 	atomic_dec(&rdev->stats.res.cq_count);=0D
 	kfree(cq->cql);=0D
 	ib_umem_release(cq->umem);=0D
-	return ib_respond_empty_udata(udata);=0D
+	return 0;=0D
 }=0D
 =0D
 int bnxt_re_create_user_cq(struct ib_cq *ibcq, const struct ib_cq_init_att=
r *attr,=0D
@@ -3687,6 +3678,10 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, unsigned i=
nt cqe,=0D
 	if (rc)=0D
 		goto fail;=0D
 =0D
+	rc =3D ib_respond_empty_udata(udata);=0D
+	if (rc)=0D
+		goto fail;=0D
+=0D
 	cq->resize_umem =3D ib_umem_get_va(&rdev->ibdev, req.cq_va,=0D
 					 entries * sizeof(struct cq_base),=0D
 					 IB_ACCESS_LOCAL_WRITE);=0D
@@ -3716,7 +3711,7 @@ int bnxt_re_resize_cq(struct ib_cq *ibcq, unsigned in=
t cqe,=0D
 	cq->ib_cq.cqe =3D cq->resize_cqe;=0D
 	atomic_inc(&rdev->stats.res.resize_count);=0D
 =0D
-	return ib_respond_empty_udata(udata);=0D
+	return 0;=0D
 =0D
 fail:=0D
 	if (cq->resize_umem) {=0D
@@ -4448,7 +4443,7 @@ int bnxt_re_dereg_mr(struct ib_mr *ib_mr, struct ib_u=
data *udata)=0D
 	struct bnxt_re_dev *rdev =3D mr->rdev;=0D
 	int rc;=0D
 =0D
-	rc =3D ib_is_udata_in_empty(udata);=0D
+	rc =3D ib_no_udata_io(udata);=0D
 	if (rc)=0D
 		return rc;=0D
 =0D
@@ -4471,7 +4466,7 @@ int bnxt_re_dereg_mr(struct ib_mr *ib_mr, struct ib_u=
data *udata)=0D
 	atomic_dec(&rdev->stats.res.mr_count);=0D
 	if (rc)=0D
 		return rc;=0D
-	return ib_respond_empty_udata(udata);=0D
+	return 0;=0D
 }=0D
 =0D
 static int bnxt_re_set_page(struct ib_mr *ib_mr, u64 addr)=0D
=0D
---=0D
base-commit: eeb9697db6c16d9bb2ce7b7ddf95aa20305aa9f2=0D
change-id: 20260712-fix-destroy-no-udata-dfa990b985ea=0D
=0D
Best regards,=0D
--  =0D
Leon Romanovsky <leon@kernel.org>=0D
=0D

