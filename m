Return-Path: <linux-rdma+bounces-17552-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPKyDIG5qWlEDAEAu9opvQ
	(envelope-from <linux-rdma+bounces-17552-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 18:12:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C950E215EE5
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 18:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8922431B1FEA
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 17:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E351332ED0;
	Thu,  5 Mar 2026 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZNhNle+c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AAC3DEAFD
	for <linux-rdma@vger.kernel.org>; Thu,  5 Mar 2026 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772730516; cv=none; b=TqgWxOvpcVZulnqMEq0dEwdI6Zi+cf6Nbzvtq0+sLrGqLe3hqrY4sm18ZoXKi2rqxVW7XnKxhxEjl3oBX71H8zDixfkiifsGxUFtZtAO2DVhqhXDp0gUoVv1MGyDsJBiqZJZPJkxVFVAHlTAhffDG7FyNVQmHnUFAPewbDNf7xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772730516; c=relaxed/simple;
	bh=iiHSYh74EhDhZtjWUHPF1amqPrsXipbb+u7csy4AaXs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QmW7/txDbtLrDXbaBXnupxBN1cIYUJUx7EWNS8cPVrBk3yy/h2rX6ivLVcTvMDXvhqi5B3vw61ZwoPAZh0mVlr/fONZJKAE7pe+edPVgYbis+N2wTymHFd8PLwSZjAtdAdnUSnP6dIrMl+p+7xQeBtsWzJJvZYqXh/oku7b5gWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZNhNle+c; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-794b240c0d3so203622627b3.0
        for <linux-rdma@vger.kernel.org>; Thu, 05 Mar 2026 09:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772730514; x=1773335314; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7D1XL1wNoim2MYMia7qkJqx1Lr9AWD+j9dgt2TgvPjc=;
        b=ZNhNle+cnFdIB4v48g7dbuP+LNSqny320E5EkDgd00iP7RhQk7R7X399stmGzH0gGV
         hFZ68OzBjYNYF9OO7YE9EWssuhGJhYdSgjvsjZBgyzJZVStk6tdw26tKxwK6b+RTqtEO
         0PP6mvkxvnEnN6SpicJ6fxs8FwhELWNRcHz+TUyAdWJ9zkNyBUOtjBn4/I7+UIXJ8IfR
         ue+wF8+NfUwGje4kJV1QhM5o+Mr3LBYJis2bPur2bRvt2DaFNl+i6bxhzb2+Q67ZrjAK
         DpV2Rk7LGLAjdmt3Mil0K3ngzOqYRcr5fg4UfOph3F9jyM69WrNn6U1+wdOb1TR4KQAV
         ZtBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772730514; x=1773335314;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7D1XL1wNoim2MYMia7qkJqx1Lr9AWD+j9dgt2TgvPjc=;
        b=w6E70QeEAPrmRP90nr5f/tPyZQmpWBiQ+o8hkp6TUEyONRiIr8zRQ8BaNgUzQVuFII
         AHBxCgXKItH3IDxYWcdQ6dGKi9ZiA/TMaWlIt8d6k6RsENrFp5Ls78+DoMaOw8NX4ipA
         uk4O4IGRvc4wcl2WbK0krA6gNewaBWkLJ2V3d0JRGUGdKTrnsh0Gnp2HcRrSWNsWJU02
         zEt91fLUyuaNGXmYuDF8sKF5c/mBmqkZ0RBWdgBDOKdBwssZ85ZwZnw1hLNl2KBYBB3M
         lHN+DWtex0v7y3cZsSaJdQFfZsEAKwOIYJ0G3nnEFjeE2fOmQ171xaYfKpFEUcaShHdE
         CQ6A==
X-Gm-Message-State: AOJu0YzeazRBPnLY7KQilg/MwbSvOXKlbSMA+x6l284/zQrH8cfxhXCK
	rZSE5E13s+FvaZdi2njIbcg7VZNqKCukh2ggrzKSVWj1yEnEbFG9lKByo3X2arkze2A3XW52hWl
	N6ohK0WCa1w==
X-Received: from ywcb16.prod.google.com ([2002:a05:690c:c3f0:b0:794:fc69:5cab])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:2030:b0:798:534e:4a0b
 with SMTP id 00721157ae682-798d1dee20emr20255357b3.15.1772730513822; Thu, 05
 Mar 2026 09:08:33 -0800 (PST)
Date: Thu,  5 Mar 2026 17:08:23 +0000
In-Reply-To: <20260305170826.3803155-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260305170826.3803155-1-jmoroni@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260305170826.3803155-3-jmoroni@google.com>
Subject: [PATCH rdma-next v3 2/5] RDMA/umem: Move umem dmabuf revoke logic
 into helper function
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com, jgg@ziepe.ca, 
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org, Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C950E215EE5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17552-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

This same logic will eventually be reused from within the
invalidate_mappings callback which already has the dma_resv_lock
held, so break it out into a separate function so it can be reused.

Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/core/umem_dmabuf.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index 0c0098285c38..9cf9cfc93006 100644
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
2.53.0.473.g4a7958ca14-goog


