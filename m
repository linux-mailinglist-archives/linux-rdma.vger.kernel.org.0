Return-Path: <linux-rdma+bounces-18722-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODfzGjTzxWnbEgUAu9opvQ
	(envelope-from <linux-rdma+bounces-18722-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 04:02:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E485433EA04
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 04:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DB147307C2F0
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 03:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E943347539;
	Fri, 27 Mar 2026 03:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imD886q+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66E6346FD0
	for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 03:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774580476; cv=none; b=aSfvx4I9jRlCjI3HM8u4TaslQyRXxrONegZcoEUUWP+bxITXhrbG2984SLQLkvf6x3TaJ6WiTo+pUUD9aFuyQ+B5mSdDxQ42Xa+Fk5IP9Ztdv2hOABoqSoX93sdd0SBXk+gKo82UtCV16n6E5+6f68rf4NlKuD5gFku/MRMRcWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774580476; c=relaxed/simple;
	bh=7DMNlTY2jlvefaXB7B3i5KgnD7WNmdQteQy2H9okiIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NepFuy4wiioMDQwaQDO4lEa9CevTLbPIyJg2kOMSoDFWZ1Kykz2ecOMdfpNsFXRu6rmvcjQVlDZ98t2IdKa+V7TvQhj4/MHKeqj7NkBDK21XphorDu/gRheiyG+BpjuEDQe9nssofAQk4Ggs6lemaoouYWJmM7+vF2hQhZnpnhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imD886q+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-354a18c48b5so1591205a91.1
        for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2026 20:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774580475; x=1775185275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S7z3iVejW0eNJULH3BGqY9g0Ns0Iw/ol1WcBG/Retfc=;
        b=imD886q+1s5JTCjrcJpGHKEZSiWtilgh9E+NGwJr1y0JnreRRuZhQIoCawOyv5W0dX
         EPVWrxPoJTruA7voAJms3txBxBZRCI/kdakYtzwc3W0bjFbWZkvO/ODxIQQtS1OzwOVe
         wcOAYI9siQj661vs62i6++owhGkMLdGYy4EYUZ0sCyg/SRCcIvtmLrG8KdBK06Tcyfqm
         DZ8PZ74fpIuD9akYi4zvWFf4Cc/tsfygZurC/f9rcEdGgWSgOrfSwi0D4gXotM5HytPd
         GE/NI0wLBCDX2FGPBBI/NWPMBTl4354KLG2NpTew6ngdPJstwSEgZ13IOgZrY4eGqEJ+
         lxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774580475; x=1775185275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7z3iVejW0eNJULH3BGqY9g0Ns0Iw/ol1WcBG/Retfc=;
        b=mlV3JCNXtV5/LTrv2R3Z9mMS2+NsG0Jw4B0GRs8DOBcA0rJWHYYYqH0r+EtR/E12HD
         arK7cAXVM/s0t8iYz1AiiGcHXIlutKq/G1K+ozXJap57+Qn65dkBGHdXZaZiKO9DMNw6
         lei0lPC1B9Wbo6J/46z82V3CekXUYNcUAIiZ1PXY+OhenDSdStGzzdwfuNdPz7kA8LuH
         +gXCMZHnKLBe1VNr4YbqXs50p2iKXg99mi+HFYcZBt7mlwpei3uKMGYHwfH2VoM9VSHh
         1ksDnYAfIAOUfe1NTG0OWw80R7XdDcunF2yQLlMVm4ZwK9M7No4uTfBU4AQDr68+wo6S
         IvAQ==
X-Gm-Message-State: AOJu0YyoLzeniXkgFX3ukWwbxjbdZC5L6g/Nm+HCtFj6t++L2bq7i9Id
	OEGXo71LrYKLqz2YfiQOtB0Di8d60Sf3LDWbzizl6bXTy5+Fa+0tWsVLaHWY+fcL
X-Gm-Gg: ATEYQzxKxDL800+OLgc9t30tWtGjE48C2VR/hYL5trByUbSj3kW3zhy0Sje3SUKiA11
	HliSPhk2F0B+8yqfYm36UfhJtDuyhAazT5aVlIO9vUZKGUvYCvNAdmMdp5DI69uLSVRxYF6ckW5
	HSL/QwYyDAO/xQ+avF6bLoylC/rSX55lbtqbbsnoZsmaegkAwYx3SEbveDbDTu8eXwo6YoyfOD3
	syv9CgW6MjQLL+I2y9OYrUAcd1PDk4KtyNXdcmWPQ2eWeY3aoaV9n3gthaYzjwFzYZmbr44eAqO
	fx3jsOx+jFD/fwMHO5UMzb9cIxJQy8Ena4XHUsTUVFFr1+yI9YeD0HNP+QXK0FZXrPu0EtwF2Gs
	a2A7xoDHUistsnejFg1o/nMLj7ptgAY1x+EYoaoWI8yVfhHMEtacwBYiEY53GlePLRPs+YL1m4V
	jAdP54LwJTEozma1V4YevnBbDYZlvXBpbMepuArSzDLrqEqpfRtNoYOmY=
X-Received: by 2002:a17:902:d4c5:b0:2b0:c451:ae8a with SMTP id d9443c01a7336-2b0cdc239ecmr9754325ad.13.1774580474707;
        Thu, 26 Mar 2026 20:01:14 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0cbfd17d9sm9331985ad.25.2026.03.26.20.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 20:01:14 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-rdma@vger.kernel.org
Cc: Bernard Metzler <bernard.metzler@linux.dev>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] RDMA/siw: use kzalloc_flex
Date: Thu, 26 Mar 2026 20:00:56 -0700
Message-ID: <20260327030056.8321-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18722-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E485433EA04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Simplifies allocations by using a flexible array member in this struct.

Add __counted_by to get extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/infiniband/sw/siw/siw.h     |  2 +-
 drivers/infiniband/sw/siw/siw_mem.c | 12 +++---------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index f5fd71717b80..2b327a899a1c 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -119,9 +119,9 @@ struct siw_page_chunk {
 
 struct siw_umem {
 	struct ib_umem *base_mem;
-	struct siw_page_chunk *page_chunk;
 	int num_pages;
 	u64 fp_addr; /* First page base address */
+	struct siw_page_chunk page_chunk[] __counted_by(num_pages);
 };
 
 struct siw_pble {
diff --git a/drivers/infiniband/sw/siw/siw_mem.c b/drivers/infiniband/sw/siw/siw_mem.c
index 98c802b3ed72..08047fcf0df1 100644
--- a/drivers/infiniband/sw/siw/siw_mem.c
+++ b/drivers/infiniband/sw/siw/siw_mem.c
@@ -50,7 +50,6 @@ void siw_umem_release(struct siw_umem *umem)
 		kfree(umem->page_chunk[i].plist);
 		num_pages -= PAGES_PER_CHUNK;
 	}
-	kfree(umem->page_chunk);
 	kfree(umem);
 }
 
@@ -347,16 +346,12 @@ struct siw_umem *siw_umem_get(struct ib_device *base_dev, u64 start,
 	num_pages = PAGE_ALIGN(start + len - first_page_va) >> PAGE_SHIFT;
 	num_chunks = (num_pages >> CHUNK_SHIFT) + 1;
 
-	umem = kzalloc_obj(*umem);
+	umem = kzalloc_flex(*umem, page_chunk, num_chunks);
 	if (!umem)
 		return ERR_PTR(-ENOMEM);
 
-	umem->page_chunk =
-		kzalloc_objs(struct siw_page_chunk, num_chunks);
-	if (!umem->page_chunk) {
-		rv = -ENOMEM;
-		goto err_out;
-	}
+	umem->num_pages = num_pages;
+
 	base_mem = ib_umem_get(base_dev, start, len, rights);
 	if (IS_ERR(base_mem)) {
 		rv = PTR_ERR(base_mem);
@@ -385,7 +380,6 @@ struct siw_umem *siw_umem_get(struct ib_device *base_dev, u64 start,
 		umem->page_chunk[i].plist = plist;
 		while (nents--) {
 			*plist = sg_page_iter_page(&sg_iter);
-			umem->num_pages++;
 			num_pages--;
 			plist++;
 			if (!__sg_page_iter_next(&sg_iter))
-- 
2.53.0


