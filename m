Return-Path: <linux-rdma+bounces-17188-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8E87IJJkn2lRagQAu9opvQ
	(envelope-from <linux-rdma+bounces-17188-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 22:07:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 420A619D9F3
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 22:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39889305EBAA
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 21:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F6E30EF90;
	Wed, 25 Feb 2026 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ehEM1Lqe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218C630E0E4
	for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 21:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772053638; cv=none; b=A6Sz6DjM8sB0yD513LOfn4yBgl2ufyrdrbzBE9iGRfuT4VrFqjH0cjg7clLJzIfm8BnG1jpic6s/4jw8Jp4VD9K7CmOUtKFJhh2GilwARwAanIRoNBDMjr3pOOXXCNtD8TQwVhl4WcIzlc76a2jT/i7VaAM525JCP8fSxH5Dqnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772053638; c=relaxed/simple;
	bh=UPYFCVbwFTDL7hGS3fIidRXKasaxbyS03D9opOLO8k4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Rv9MxJZmB9CyZ/aPn9OU3preGQBbaXMG2N1gdI7aJNBlUfaiefOjkHu9LXL8n03n2Dc+gGRSXw17k4W8ZBJTmMSDerY4rDTsPCJknMJYL5+OaMD34+0U1P73ylP7pPmJKkLvQaDgsERLfQTPAhbxFNHQsWhsoWWY7aMOlWtqbIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ehEM1Lqe; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8cb4b8e9112so4257685a.2
        for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 13:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772053636; x=1772658436; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pzg6kb0WbmCmcd5n5AqU2GGwkjvVJmnFjfE2ePnlYqc=;
        b=ehEM1LqekPRiGGnOIP+hsfI65A9CkZSXxUOy07x0/5pPny486w5FOcCgBcY3JpKyNP
         8FVDqYwT84nS5kHSiDgLUFjYQDSoPUNbuv7sml7dJXvw0I/J9c2riTyiAzYLocpmPucH
         9HXx878RB2OgDIBQHH20htFnD7IDrNpQdd0uSHp7UE6JU6NWVUC4KJkNGxXNvgBPfNNT
         RNCC3KgBt6IMH32l1Yr68/OWTO8Q+PrT6rhfRBL4rRUQKLp/5zOkw8P+MEfOydWfaKjJ
         x7hZKEC6FRtgnbi0KHnGzEEjuEdgp4XQNwa7qDt/3nb1ec1RLCOu4UkgKDj8Ym/oeON7
         F4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772053636; x=1772658436;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pzg6kb0WbmCmcd5n5AqU2GGwkjvVJmnFjfE2ePnlYqc=;
        b=ejsF/VB57B/PNZJ3OIaUGV8jnLK0zfvKdS77OQ7SJ4plbpR74R+nKoRSC1caJkVPOL
         syQre05LuHuCbf01I0LseIrSxH/eYneQVjC7TXUicPbxEP6RssdVOrVdpnM4XbThFPxP
         LhUyIzFqByhXa+zuYqVA/P7eEMeTDgUm6EjQT8bfeTOZ7Yhpskx0Aa5d93LuNC+7pttA
         Zqu1g3VJzJX/rrK/ji6MPrKZejSNw5z5RJqCiUh2zgoSCxAAdEIe17mov1fY2bH0jqGF
         wpJcQywe44YfM2Pin981ev5UsRy2nD4z6DtK++GR3SO2/S7LDJ8g6rRuhXiVlgJZciIp
         Uq8w==
X-Gm-Message-State: AOJu0YwS4zyviCtFTFwcLF6tMMKvGwiFmo99s13v0OBRH6Su0hRT+J/I
	zfQ9w4IR1gVjBDUHvJ9UuoEe3JYAqzeoqO9Pxy2DL0DjruDZIJT06rmYzCsCKMxzNNp6toi6bgv
	GvRFkQtjhcA==
X-Received: from qvbpd2.prod.google.com ([2002:a05:6214:4902:b0:899:c320:3bbf])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:3197:b0:8c7:a84:d0e4
 with SMTP id af79cd13be357-8cb8c9fe78emr2261989385a.24.1772053635863; Wed, 25
 Feb 2026 13:07:15 -0800 (PST)
Date: Wed, 25 Feb 2026 21:07:03 +0000
In-Reply-To: <20260225210705.373126-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260225210705.373126-1-jmoroni@google.com>
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225210705.373126-3-jmoroni@google.com>
Subject: [PATCH rdma-next 2/4] RDMA/umem: Move umem dmabuf revoke logic into
 helper function
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com, jgg@ziepe.ca, 
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org, Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17188-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-rdma];
	BLOCKLISTDE_FAIL(0.00)[100.90.174.1:server fail,209.85.222.201:server fail,2600:3c04:e001:36c::12fc:5321:server fail];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 420A619D9F3
X-Rspamd-Action: no action

This same logic will eventually be reused from within the
invalidate_mappings callback which already has the dma_resv_lock
held, so break it out into a separate function so it can be reused.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/core/umem_dmabuf.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index 0c0098285..9cf9cfc93 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -195,6 +195,22 @@ static struct dma_buf_attach_ops ib_umem_dmabuf_attach_pinned_ops = {
 	.move_notify = ib_umem_dmabuf_unsupported_move_notify,
 };
 
+static void ib_umem_dmabuf_revoke_locked(struct dma_buf_attachment *attach)
+{
+	struct ib_umem_dmabuf *umem_dmabuf = attach->importer_priv;
+
+	dma_resv_assert_held(attach->dmabuf->resv);
+
+	if (umem_dmabuf->revoked)
+		return;
+	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
+	if (umem_dmabuf->pinned) {
+		dma_buf_unpin(umem_dmabuf->attach);
+		umem_dmabuf->pinned = 0;
+	}
+	umem_dmabuf->revoked = 1;
+}
+
 static struct ib_umem_dmabuf *
 ib_umem_dmabuf_get_pinned_and_lock(struct ib_device *device,
 				   struct device *dma_device,
@@ -262,15 +278,7 @@ void ib_umem_dmabuf_revoke(struct ib_umem_dmabuf *umem_dmabuf)
 	struct dma_buf *dmabuf = umem_dmabuf->attach->dmabuf;
 
 	dma_resv_lock(dmabuf->resv, NULL);
-	if (umem_dmabuf->revoked)
-		goto end;
-	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
-	if (umem_dmabuf->pinned) {
-		dma_buf_unpin(umem_dmabuf->attach);
-		umem_dmabuf->pinned = 0;
-	}
-	umem_dmabuf->revoked = 1;
-end:
+	ib_umem_dmabuf_revoke_locked(umem_dmabuf->attach);
 	dma_resv_unlock(dmabuf->resv);
 }
 EXPORT_SYMBOL(ib_umem_dmabuf_revoke);
-- 
2.53.0.414.gf7e9f6c205-goog


