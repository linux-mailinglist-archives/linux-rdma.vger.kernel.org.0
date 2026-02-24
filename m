Return-Path: <linux-rdma+bounces-17134-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEzQDos3nmm1UAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17134-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 00:43:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 549D218E2BC
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 00:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C04D53027CAB
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 23:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11F4363C77;
	Tue, 24 Feb 2026 23:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3aWL1YUa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FE334DCE2
	for <linux-rdma@vger.kernel.org>; Tue, 24 Feb 2026 23:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771976581; cv=none; b=sJWKEonA8CvuQrT255tNfZ+qnt+LupITZv5KJysI8pTnc28ed6mWS2Ue3OS5nBwQ01F/2yl37CBkZfUjrgoQv6m8QSKZyRr4dpsc+P9eJmuC+GmbtiG2tGlsz+hQ6T5mAniXaoQrEQexsNRuWyoisURSv1JfHAoqxcEnqxqJybw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771976581; c=relaxed/simple;
	bh=lNr6pbm93PyO05ZW8d/GWplyPEufUBb6+n/onR6ykr4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=iDsDJilmw7N1lZdn4cWRzeS4u9+XGAOLj0apD9uJA3rcs10/5l/yAZZbcgcHqFeIOa/UwYq9vatbTKYbMtvuuJ0cj4YHdApP7/eb/d2BIFRJjnDkcGSBXeDPj97wa+YLznfUNOe1Ztq6viG9q/Wdg/celbTrxQbKO7rr0IPrt7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3aWL1YUa; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50336ebabe0so16939341cf.1
        for <linux-rdma@vger.kernel.org>; Tue, 24 Feb 2026 15:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771976579; x=1772581379; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LF/DUcDuwp0jCRxDUUyAE6CO9Jt9qOMqhlOTt+9VT7U=;
        b=3aWL1YUa/Izqwe9QxgfhBFN9Z436O3feBQv7fLTw+cvUFwi+qd6+9fd+IhH1+tZt7t
         sT14OXvYGSdCxWeQsTdM8/yt1bdzpilKtvvOgLjpkWxxD+3CkhubCieynpDVqQHmtYdU
         NWbwFE1I0TadQbbUKscU1GPQDlTwF4E3jwWUHo55Zz3To7i4PkFHc9dcZ/aCccdrdp4E
         +3jXXZkMrhMI1lWQplCPvEFXRdd6CMoQkudPDKClGSSZSPJXg/P3sT2CeRyX5pU8lU20
         JjHC8wlcYJaoTwErZCAhRrtQp/w4lA2mp2BmErcN+qw+uOVSnAyLk8rPUIuwBkgCrSPt
         AubQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771976579; x=1772581379;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LF/DUcDuwp0jCRxDUUyAE6CO9Jt9qOMqhlOTt+9VT7U=;
        b=fSEuYrs2hEaH5MnG/j7//9MbRjh+eo6VgcBmZB5NVXNwGBDkXMays8KRYepyv6sz8e
         MM8Wvxp+kkhPoWl77CQLdDwYFTvICCy3jFkUi1YTrUR1Fm9caMRgtXQugK/HXoUJeDjT
         TM65hYlu+Cft9+e0fkvyUnVLvIGdI2ysUYns1/JNUyUtjj8K0367F+DDn6rg86gL+X/s
         2y78sSrDCc3a84oaFBAbrvvp9ntvv9CQgAWITRJ8mG80IOMmsG0yGNzik2pXMtuX+jM5
         RdM1heleWBSsr8sQeoA8xOl1HBi7IZTBPcxEntMhtqP6pbY9tr1HCwhICOvN1wMZVGfC
         cFrw==
X-Gm-Message-State: AOJu0YzCfxEFSoD+3fPEV+XKmmQphm7K9wJHdIBdm7kzWFPryBsdi+Pt
	51xgDbamr5rUJonG/xbppNcZuq+b4Zy0/UaCDC9b/EOlYW7aMLkEUtc8ES36kDzxpB+I3LSdwoK
	buAWeWtcmug==
X-Received: from qvblu13.prod.google.com ([2002:a05:6214:5a0d:b0:896:f4fc:3f82])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:ac8:7d8d:0:b0:501:51d4:df30
 with SMTP id d75a77b69052e-507364e40efmr25539221cf.8.1771976579244; Tue, 24
 Feb 2026 15:42:59 -0800 (PST)
Date: Tue, 24 Feb 2026 23:41:53 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260224234153.1207849-1-jmoroni@google.com>
Subject: [PATCH v2] RDMA/umem: Fix double dma_buf_unpin in failure path
From: Jacob Moroni <jmoroni@google.com>
To: galpress@amazon.com, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17134-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 549D218E2BC
X-Rspamd-Action: no action

In ib_umem_dmabuf_get_pinned_with_dma_device(), the call to
ib_umem_dmabuf_map_pages() can fail. If this occurs, the dmabuf
is immediately unpinned but the umem_dmabuf->pinned flag is still
set. Then, when ib_umem_release() is called, it calls
ib_umem_dmabuf_revoke() which will call dma_buf_unpin() again.

Fix this by removing the immediate unpin upon failure and just let
the ib_umem_release/revoke path handle it. This also ensures the
proper unmap-unpin unwind ordering if the dmabuf_map_pages call
happened to fail due to dma_resv_wait_timeout (and therefore has
a non-NULL umem_dmabuf->sgt).

Fixes: 1e4df4a21c5a ("RDMA/umem: Allow pinned dmabuf umem usage")
Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
v1 -> v2:
- Removed an accidental blank line.

 drivers/infiniband/core/umem_dmabuf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index f5298c33e..d30f24b90 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -218,13 +218,11 @@ ib_umem_dmabuf_get_pinned_with_dma_device(struct ib_device *device,
 
 	err = ib_umem_dmabuf_map_pages(umem_dmabuf);
 	if (err)
-		goto err_unpin;
+		goto err_release;
 	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
 
 	return umem_dmabuf;
 
-err_unpin:
-	dma_buf_unpin(umem_dmabuf->attach);
 err_release:
 	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
 	ib_umem_release(&umem_dmabuf->umem);
-- 
2.53.0.414.gf7e9f6c205-goog


