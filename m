Return-Path: <linux-rdma+bounces-17350-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHknLrnWpGnYtgUAu9opvQ
	(envelope-from <linux-rdma+bounces-17350-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 01:15:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D511D20A1
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Mar 2026 01:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1810D300E5CC
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Mar 2026 00:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21FF156677;
	Mon,  2 Mar 2026 00:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cdPKe5NZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f74.google.com (mail-yx1-f74.google.com [74.125.224.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4E2430B85
	for <linux-rdma@vger.kernel.org>; Mon,  2 Mar 2026 00:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772410550; cv=none; b=Z7SqnxW38CsQ169SANFq5YYhi9zP45Y1WmcKUITRgGtsr6iGygZkO7rFaIchaIE7barpSDwIAhoxrryR0anOrlq6erkumWFhVkJA+R8KuC78r6Gm8+3u12Aok2Un8T17zpiHFNMD8qcBRiC45tuiLTEAgR/gIi/z/ZZfp0eECL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772410550; c=relaxed/simple;
	bh=f9n2Z+MEgPahBFdlyhou+qv4aJ1EjwbhYYU6HC9KMuc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sdYqEYQyLJybf0OctCQzly0jLXSkoFy/cYMp5Of3HkF00f8FkJWoYzORvunomqX2Rhy0SycmY5EUiFaYW4GOD/zyg3QppkaD39UpT11QgFRz+noTNjdcRIU7zrzaWQrwY6PBlilHNXEquZ3dIh6jT+auGRO7h46XlH4ooGuVjG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cdPKe5NZ; arc=none smtp.client-ip=74.125.224.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-yx1-f74.google.com with SMTP id 956f58d0204a3-64956932a51so4509573d50.0
        for <linux-rdma@vger.kernel.org>; Sun, 01 Mar 2026 16:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772410548; x=1773015348; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HU8UNjFPi+zLQnas2YIAM3E+Ror57Bgh9TsOonH+FSY=;
        b=cdPKe5NZJsw+4xVm6+AQwa0wDKlUwowk28aa8hH4AfdMuSnseNCdj+ZSCO8gP28WOM
         SYxd6uKqVEIZ8D2Wehcmg0LbhwVZGy7dVIoVQJvtQ/kpJoJrARsFP/RZFtpgh6s+n0+K
         +ZclmUyw5MEv4IRzMVTMSFgBL5Fx76uTeHmP+sMSeRsXD3qR+4410TTOzfwylpgmrN6H
         3hUttrQZBnKO3DIIInLbVJV+yuGPwEOm579wfxu/EhbbbmwzwJfjtMCXOonKDgt8NQAw
         Qid6sF3fW9NLic5Bg2Q5o7nqG5ov13h/vg1qluhaxZj1FFNBei2crSLhrQXjp+Yv4Yo6
         2kHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772410548; x=1773015348;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HU8UNjFPi+zLQnas2YIAM3E+Ror57Bgh9TsOonH+FSY=;
        b=ZWii8M8PfbaRclcAJUP2kJDllB2jnqeufJCLlQZlPXWzOG0CiAedbkPqoK88arvul5
         QqEFb3/yYOhlEmMGw16ftaZrVvz63lGEtDAFyCDRfBp6cH2DtrStyS0NoXiqkssaGCXG
         gpMb/gyguUaFRVt7FzXEblLV6j7o2TerCgsjOmrHFbQzdGymY/zSG+LOJuzNVR5gV9jT
         pn2VEB1hzNmQ1ipyOa/tHyzzkGLJg7nxyH94mWRJQoXQRwyWbM/DZEwumI+zH/V0fcuq
         1pWvu0rPgFCwBrf6sJgjSptwwbD1JMNl4hxzpO6gWTFfUBOBs3QrGBzibqPrCdbPkpMm
         ehOA==
X-Gm-Message-State: AOJu0YyJFeEirpGXSqFsdlpmxPYiDF8Ja6ORIBqa2+/ifkDJouFU7InZ
	hze3ws/xvDrXmJprqpo+eOpIOHeRBwGjaPXzKcAdhq6C+LpBSaifzTNqbJHhWwKuggvyk5AKmrx
	tTYr3luCJyQ==
X-Received: from yxyq13.prod.google.com ([2002:a05:690e:d8d:b0:644:75dd:1eeb])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a53:b4cd:0:b0:646:eabb:3431
 with SMTP id 956f58d0204a3-64cc22e1a6bmr5785746d50.47.1772410548145; Sun, 01
 Mar 2026 16:15:48 -0800 (PST)
Date: Mon,  2 Mar 2026 00:15:36 +0000
In-Reply-To: <20260302001539.2275303-1-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260302001539.2275303-1-jmoroni@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260302001539.2275303-3-jmoroni@google.com>
Subject: [PATCH rdma-next v2 2/5] RDMA/umem: Move umem dmabuf revoke logic
 into helper function
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17350-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 37D511D20A1
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
2.53.0.473.g4a7958ca14-goog


