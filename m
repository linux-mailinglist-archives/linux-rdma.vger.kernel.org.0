Return-Path: <linux-rdma+bounces-17217-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI0tKF1PoGmIiAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17217-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 14:49:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F0C1A6F38
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 14:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3AE6630B6086
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Feb 2026 13:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676E836C0DC;
	Thu, 26 Feb 2026 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+NGo0Y3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1DF36C0CA;
	Thu, 26 Feb 2026 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113459; cv=none; b=gznBIV9YfcHWRsdJaskXmsq2azxAr/PPaobRrWW4sxX1aFs4+1qb8AybNImbVCxYEE08UQ/wwSFt6DP4/si7iXeJB63ydlMF1b3pJKW+1542LBNIssGp82lg4164pZIqkB7MJD+bEKG7p8HjhfVM16pfiLIChSQGBOE1V8MbH1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113459; c=relaxed/simple;
	bh=cHS6qokxU5UVH3NX9uI9XkLBbebMoLfa94emZRUjZMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O6rozfk5bG5CULD5MxfwhFVAGE1CUh3RsoaFxyl2DiTN7sEB0rurPBLNQ4+d9V3nYDKZvK3InFOhe3Bn2iwjC2FeU+0aQwIQEZ1UInTNgSunbsMGgNuXa7JpaEIHOMrBjsz410qcVXmMQCRCKMt11aMImS9Z/LPBeiYBi9+XXA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J+NGo0Y3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92688C19423;
	Thu, 26 Feb 2026 13:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113459;
	bh=cHS6qokxU5UVH3NX9uI9XkLBbebMoLfa94emZRUjZMY=;
	h=From:To:Cc:Subject:Date:From;
	b=J+NGo0Y3OyMVOBvJJm1/UZw/OFvp3D/KgOxUdkpnBKp5JlBirF3UQ8ph3L5SFTYFa
	 B8CIS6A0Str9J8BpqF6Ab7FfanmnVGoOTbIswX4ThehudlRzsdgTkiKB15XT7m9KYX
	 rSK77HyVAC5Cnll6+x4pGZdipcxJo9dHcvqTzTflDYvQYLj3g4dD8i7/lXor+1yJd4
	 ziywhf/ztKS67OaYr9bzMWTv0DGQpZ21O5rDwp8BIzkZvdm0VXujL9OATQUXaY+djw
	 ZT9cYCYDo8/DthP/5oTBk2WFvMIT3OmHuosYKxxERn3gPvo9GyD9suL6BKJsjom69C
	 JIJNhSN1RfyKA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/core: Delete not-implemented get_vector_affinity
Date: Thu, 26 Feb 2026 15:44:12 +0200
Message-ID: <20260226-get_vector_affinity-v1-1-910a899c4e5d@nvidia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260226-get_vector_affinity-e9fd21f4b86e
X-Mailer: b4 0.15-dev-47773
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17217-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 47F0C1A6F38
X-Rspamd-Action: no action

From: Leon Romanovsky <leonro@nvidia.com>=0D
=0D
No drivers implement .get_vector_affinity(), and no callers invoke=0D
ib_get_vector_affinity(), so remove it.=0D
=0D
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>=0D
---=0D
 drivers/infiniband/core/device.c |  1 -=0D
 include/rdma/ib_verbs.h          | 23 -----------------------=0D
 2 files changed, 24 deletions(-)=0D
=0D
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/dev=
ice.c=0D
index c7b227e2e657..8b1ec1f9c5e4 100644=0D
--- a/drivers/infiniband/core/device.c=0D
+++ b/drivers/infiniband/core/device.c=0D
@@ -2749,7 +2749,6 @@ void ib_set_device_ops(struct ib_device *dev, const s=
truct ib_device_ops *ops)=0D
 	SET_DEVICE_OP(dev_ops, get_netdev);=0D
 	SET_DEVICE_OP(dev_ops, get_numa_node);=0D
 	SET_DEVICE_OP(dev_ops, get_port_immutable);=0D
-	SET_DEVICE_OP(dev_ops, get_vector_affinity);=0D
 	SET_DEVICE_OP(dev_ops, get_vf_config);=0D
 	SET_DEVICE_OP(dev_ops, get_vf_guid);=0D
 	SET_DEVICE_OP(dev_ops, get_vf_stats);=0D
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h=0D
index 1b77fd88d0fb..6e2e9019a540 100644=0D
--- a/include/rdma/ib_verbs.h=0D
+++ b/include/rdma/ib_verbs.h=0D
@@ -2420,8 +2420,6 @@ struct ib_device_ops {=0D
 	int (*modify_device)(struct ib_device *device, int device_modify_mask,=0D
 			     struct ib_device_modify *device_modify);=0D
 	void (*get_dev_fw_str)(struct ib_device *device, char *str);=0D
-	const struct cpumask *(*get_vector_affinity)(struct ib_device *ibdev,=0D
-						     int comp_vector);=0D
 	int (*query_port)(struct ib_device *device, u32 port_num,=0D
 			  struct ib_port_attr *port_attr);=0D
 	int (*query_port_speed)(struct ib_device *device, u32 port_num,=0D
@@ -4826,27 +4824,6 @@ static inline __be16 ib_lid_be16(u32 lid)=0D
 	return cpu_to_be16((u16)lid);=0D
 }=0D
 =0D
-/**=0D
- * ib_get_vector_affinity - Get the affinity mappings of a given completio=
n=0D
- *   vector=0D
- * @device:         the rdma device=0D
- * @comp_vector:    index of completion vector=0D
- *=0D
- * Returns NULL on failure, otherwise a corresponding cpu map of the=0D
- * completion vector (returns all-cpus map if the device driver doesn't=0D
- * implement get_vector_affinity).=0D
- */=0D
-static inline const struct cpumask *=0D
-ib_get_vector_affinity(struct ib_device *device, int comp_vector)=0D
-{=0D
-	if (comp_vector < 0 || comp_vector >=3D device->num_comp_vectors ||=0D
-	    !device->ops.get_vector_affinity)=0D
-		return NULL;=0D
-=0D
-	return device->ops.get_vector_affinity(device, comp_vector);=0D
-=0D
-}=0D
-=0D
 /**=0D
  * rdma_roce_rescan_device - Rescan all of the network devices in the syst=
em=0D
  * and add their gids, as needed, to the relevant RoCE devices.=0D
=0D
---=0D
base-commit: 4c97e6bb1f2311be3146d5f999702392fc17f91f=0D
change-id: 20260226-get_vector_affinity-e9fd21f4b86e=0D
=0D
Best regards,=0D
--  =0D
Leon Romanovsky <leonro@nvidia.com>=0D
=0D

