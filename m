Return-Path: <linux-rdma+bounces-16430-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJJ6KuG2gWkrJAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16430-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 09:50:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F2ED660F
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 09:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9B153022063
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0B6396B63;
	Tue,  3 Feb 2026 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="yQPpU0+g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD64F396B65
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 08:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770108620; cv=none; b=bSglEtvKAq66soPHhFhK8MbWKQqbAiKFylCwJwt5/6I2dfJfaOzic5KlOiGPettc338/HXxa40yV6OYAEx5ZSl7QQ5MJ9Md/JJEj9PjmQxe+KcIs43aZ9B2qSh8+c09jm/hi4Ze53bf4vc3MouwH7MmeOREmzepLfM2BC5sqtYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770108620; c=relaxed/simple;
	bh=/0on0wlvDpCN60nvCUSm+9tdhzVHMZmOAOzTrJJBbNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XrWuAinaFKTgGp3ddVYDvngVJ5nGfG4o9/fCR8Vz6S60Rgz75Rh/tBVL4zioA8dl643v2HciefmUGZNLyFDiK3aQ/b86iZiKHGeOrC8R6pyAUbWCTtv3a0gJE2sCZV9shJJnhRWtsju8bFyPsXnL8LXHCyFmC37E6bWQTvGE+PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=yQPpU0+g; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4806b43beb6so39211165e9.3
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 00:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1770108617; x=1770713417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBDWSFvHCPkbqnMjbv7wogbWk10TYuEoc3WFye0YiZY=;
        b=yQPpU0+gROXNuhPuTIHdGzFynUU8qABzSi9WtsFJ6tyejOmCYBlchN08jIKYVBgSbP
         w4RgdDAzreZsj0tJLS7oujLdx7dgwdY6Kvnej03NUIi/QuwOqSqkWShdfmJbU4znFK1t
         AX+pHLkJm30NW9V39gTqZOKH5LnTny8CKH8iqH0ChfBxfdyb8oRfynsuaHFPdvFL5VCC
         Qve3GWWvLwMnuv9ElqvIAerI6tuNqZYtiqyuwbO4QomUz1EHTpjAvFL/q8SwmW7Pn7YE
         mhVtJFrO6rroWUJ2Bn/qqwzxycrSkzB3r2FeOomPdsA+PYLx0XEhVWolkgn5lcC6U7GS
         y4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770108617; x=1770713417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BBDWSFvHCPkbqnMjbv7wogbWk10TYuEoc3WFye0YiZY=;
        b=YPEHqi6ZqJ2de4wwiu00+TxJjLCEQHV/Fv3gQ2UjS1NYBaMifkhho2pIF7PWs+Gzet
         2HNjMij8kF50EnHV3rSzVqu9Xf+dQqlL/9Gr9kRbKllMQyfbTiNJf3jMvQcNUjkdnQxt
         szdYzC3Q5IEbBDP9AfRzbNAwnl8pCh8eCPalgSL7RVzKbUFNs11vd/yKWvHJsnPcDDAP
         QqSYztP6MK0CTWP6dZzYB7DJyEAvIKqd6jsM4hG+6tXuBOc57QVD0RMXk4PphVtm7BSq
         jOEVzSsNzxhbvAgBCg/+8nXEpkLFie4tba4q8KQqOpy9Dzf5+QPm5nu3KrJzPTB++4n7
         nriA==
X-Gm-Message-State: AOJu0YxEuFpXEddKqvznEGZFa/wgIoNw+E43zHxEMk4+npdo6mfT5HWr
	fsWqzjN8fWr3UOVxIffPOrZUwKCJ3x13BsK5wP9QFa0dNE6QetsKm+3+iKPrXtyOG/d3SJcuw/h
	Xak+y
X-Gm-Gg: AZuq6aLvD6cSYkvy3R2DJ1M0vyIfcC3tYW7a+L8yL3hwDayvvJOkvHnh2knb9anooxr
	eosYsesOb4by1xsEvxPlyglEEkvapqEDhxPj71sZRe3kIPo5lnSHEItbLh2qcmdB3Im4L18yK4o
	uCrAj9suZSlJnNxq6XVCCPH30j+jMHULVZpWwQzaE7QQVF20ugGznlHa5FysqJMtFvI8ESi4GAi
	D/O/j5u4pWPtOTV71QhWtgwPezdmP3EQFY1H9rQJWMYJCPGlf9TZfgvJlK4A2w/x8LzZ6NV1Ysr
	p/pZ6k2U59bRpKQdcH5K7XORWNwELKpXqT2UkN8zhzfyRUPgzdIo6VDs+pEhpdCbsdpeyExh0aG
	COUAIXccpzTa97l7gSa8DAWdZUp5+okQvaN0nPwzIROnPauYVZRrpD+a/WGNZ2W6uGa7YPCZTxE
	CpVw==
X-Received: by 2002:a05:600c:a01:b0:480:462e:d640 with SMTP id 5b1f17b1804b1-482db4b53f0mr189035855e9.36.1770108617098;
        Tue, 03 Feb 2026 00:50:17 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482db623407sm145807845e9.0.2026.02.03.00.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 00:50:16 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com,
	gal.pressman@linux.dev,
	sleybo@amazon.com,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yanjun.zhu@linux.dev,
	wangliang74@huawei.com,
	marco.crivellari@suse.com,
	roman.gushchin@linux.dev,
	phaddad@nvidia.com,
	lirongqing@baidu.com,
	ynachum@amazon.com,
	huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com,
	ohartoov@nvidia.com,
	michaelgur@nvidia.com,
	shayd@nvidia.com,
	edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: [PATCH rdma-next 10/10] RDMA/mlx5: Add external doorbell record umem support for QP
Date: Tue,  3 Feb 2026 09:50:02 +0100
Message-ID: <20260203085003.71184-11-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260203085003.71184-1-jiri@resnulli.us>
References: <20260203085003.71184-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16430-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20230601.gappssmtp.com:dkim,resnulli.us:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 72F2ED660F
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Extend the mlx5 QP creation path to support externally provided
doorbell record (DBR) umem buffers. This enables userspace to pass
pre-pinned DBR memory for QP creation.

Note that a single doorbell is shared between SQ and RQ for raw-QPs.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Change-Id: I641f6412ad99b48f6633da742bf169df2bd1edf3
---
 drivers/infiniband/hw/mlx5/qp.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index 79d30e68b4cb..f8c24f66fef5 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -944,7 +944,8 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 			   struct mlx5_ib_create_qp_resp *resp, int *inlen,
 			   struct mlx5_ib_qp_base *base,
 			   struct mlx5_ib_create_qp *ucmd,
-			   struct ib_umem *ext_umem)
+			   struct ib_umem *ext_umem,
+			   struct ib_umem *ext_dbr_umem)
 {
 	struct mlx5_ib_ucontext *context;
 	struct mlx5_ib_ubuffer *ubuffer = &base->ubuffer;
@@ -1064,7 +1065,7 @@ static int _create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		resp->bfreg_index = MLX5_IB_INVALID_BFREG;
 	qp->bfregn = bfregn;
 
-	err = mlx5_ib_db_map_user(context, ucmd->db_addr, NULL, &qp->db);
+	err = mlx5_ib_db_map_user(context, ucmd->db_addr, ext_dbr_umem, &qp->db);
 	if (err) {
 		mlx5_ib_dbg(dev, "map failed\n");
 		goto err_free;
@@ -1744,6 +1745,7 @@ struct mlx5_create_qp_params {
 	struct mlx5_ib_create_qp_resp resp;
 	struct ib_umem *sq_ext_umem;
 	struct ib_umem *rq_ext_umem;
+	struct ib_umem *rq_dbr_ext_umem;
 };
 
 static int create_rss_raw_qp_tir(struct mlx5_ib_dev *dev, struct ib_pd *pd,
@@ -2158,7 +2160,7 @@ static int create_dci(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 		return ts_format;
 
 	err = _create_user_qp(dev, pd, qp, udata, init_attr, &in, &params->resp,
-			      &inlen, base, ucmd, NULL);
+			      &inlen, base, ucmd, NULL, NULL);
 	if (err)
 		return err;
 
@@ -2326,7 +2328,8 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
 	}
 
 	err = _create_user_qp(dev, pd, qp, udata, init_attr, &in, &params->resp,
-			      &inlen, base, ucmd, params->rq_ext_umem);
+			      &inlen, base, ucmd, params->rq_ext_umem,
+			      params->rq_dbr_ext_umem);
 	if (err)
 		return err;
 
@@ -3290,7 +3293,8 @@ static int check_ucmd_data(struct mlx5_ib_dev *dev,
 
 static int __mlx5_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 			       struct ib_udata *udata,
-			       struct ib_umem *sq_umem, struct ib_umem *rq_umem)
+			       struct ib_umem *sq_umem, struct ib_umem *rq_umem,
+			       struct ib_umem *rq_dbr_umem)
 {
 	struct mlx5_create_qp_params params = {};
 	struct mlx5_ib_dev *dev = to_mdev(ibqp->device);
@@ -3317,6 +3321,7 @@ static int __mlx5_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 	params.is_rss_raw = !!attr->rwq_ind_tbl;
 	params.sq_ext_umem = sq_umem;
 	params.rq_ext_umem = rq_umem;
+	params.rq_dbr_ext_umem = rq_dbr_umem;
 
 	if (udata) {
 		err = process_udata_size(dev, &params);
@@ -3394,7 +3399,7 @@ static int __mlx5_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 int mlx5_ib_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 		      struct ib_udata *udata)
 {
-	return __mlx5_ib_create_qp(ibqp, attr, udata, NULL, NULL);
+	return __mlx5_ib_create_qp(ibqp, attr, udata, NULL, NULL, NULL);
 }
 
 int mlx5_ib_create_qp_umem(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
@@ -3402,7 +3407,9 @@ int mlx5_ib_create_qp_umem(struct ib_qp *ibqp, struct ib_qp_init_attr *attr,
 			   struct ib_umem *sq_dbr_umem, struct ib_umem *rq_dbr_umem,
 			   struct ib_udata *udata)
 {
-	return __mlx5_ib_create_qp(ibqp, attr, udata, sq_umem, rq_umem);
+	/* Single DBR umem for both SQ and RQ. */
+	return __mlx5_ib_create_qp(ibqp, attr, udata, sq_umem, rq_umem,
+				   rq_dbr_umem);
 }
 
 int mlx5_ib_destroy_qp(struct ib_qp *qp, struct ib_udata *udata)
-- 
2.51.1


