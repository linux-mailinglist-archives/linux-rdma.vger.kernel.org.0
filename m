Return-Path: <linux-rdma+bounces-20513-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BYQIyV4A2pY6AEAu9opvQ
	(envelope-from <linux-rdma+bounces-20513-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 20:57:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4965284BE
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 20:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E22C4313D85B
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 18:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E89132BF41;
	Tue, 12 May 2026 18:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HC35Wb8m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5682F8E9B
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778611136; cv=none; b=NfZL+yuxqHWk1BQnJrjogZ5eUmQ9NRXaGTINgAnuoc8lMhA0IBaUZg3NHQzFVQ/JmiRt8CwcIoYYx1CHTvG7D3BjRUhwPVQC8Y1/C1Cf8G84zB/pnspDEI8Xkmw9R3SwKewBDFoJ1ubaCeIX4ndcCS9HEfSyG2RnQNYHi4jqnqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778611136; c=relaxed/simple;
	bh=I09O73/fy7BUccU0qJpAKW+nk+Ww74ueKo+uP9HGI4U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FkGdPHdqtgJZBYS0Atx7PONM6879BhoYyEPvR1yD/IpifveynBdmtEbFBgfwmtrXcvmmzhgfykQKler27+Dusu3TnW0LL0ZXcg3Ykcvvz2y97gn8We/GtjDzaR5rZ/YZStMOSH1cgOFiV+MdlCND9zPO7BHg0mTJR52xhL1KzMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HC35Wb8m; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmoroni.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-514cbe73d00so43201601cf.1
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 11:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778611133; x=1779215933; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+DeT0rZ95QMZL9Xy3fdGQtSdSrj1lRMj5LlMafFEKQk=;
        b=HC35Wb8m+r7H7SXDUh75+Y04D8pBDTrwerYLVtT2AahkustFokbPQ/BwKzarip12DC
         2UcW5h876IIYO1hB9nYakDSUiJSBOsDlcYvptFlB0x66CiIaF5O976Ao9bEi7L3RsfH3
         eIgHqqIbtegjX+v3yqPW74fUufX9+4IU7ZyI+dT7xByiHfJ8z1+ivF40gA+coUlp5xdM
         +QAeSuyXeLERLugSxvBz5Wdubpj+yZ2V+WxplBMXmGd6tvx1aMWota56csGm19b//FM+
         kjkUPDzWS8dC1TAWXwxhhJWV7k4b/DH8+YIjPq4R5tD8IjvvI/4v2Fa78cYFVSV3Nhsx
         aYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778611133; x=1779215933;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+DeT0rZ95QMZL9Xy3fdGQtSdSrj1lRMj5LlMafFEKQk=;
        b=feL826HuG/kFmaaq/xGGyzfbUEH+BD8I8m5we2eW8WdngXyJgPG9x7VT63QP7v6D3W
         DA8Y7BqR8OdpXaJbLEiLnQZ+jSvK14uKHemnlgZNclVX4XeeAXVzLbePO7rjFUokIFs0
         Rf3Au2+aFjcqUS5Rsb83G0IkkLYxdi1Xw7K6NROj1UTljbOOwrub6YQuiM4HOGaHEom4
         ACqHc1P8CLsP8GHjDivJZ42Wz44Zbnte8Z6MscOl1JEQb6zMr14VrMyd/HG27BOMwRz3
         urOs+P4MOioV9UnvuLCTrYcTyFCbaEZN82Tmzf3ZHJELYPVcE08JkgVRPIn2vUOhoEo8
         WgeA==
X-Gm-Message-State: AOJu0Ywid6m2GXCZoCCK0G+IS7klef24rNanAx7ddatj43c2kYn2sWDn
	ZhYIklUWKopwQv8sEOOqePJXx9YZgquuvaLntFT5DulP7X4ACAY2Ya1m4Vf6bWggxwYCHRtV/iS
	Eifa2nkoe9Q==
X-Received: from qvbgf2.prod.google.com ([2002:a05:6214:2502:b0:89c:df02:4050])
 (user=jmoroni job=prod-delivery.src-stubby-dispatcher) by 2002:a05:622a:1e14:b0:50e:2b1e:9d14
 with SMTP id d75a77b69052e-5148e94fe9dmr237123461cf.29.1778611133110; Tue, 12
 May 2026 11:38:53 -0700 (PDT)
Date: Tue, 12 May 2026 18:38:52 +0000
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512183852.614045-1-jmoroni@google.com>
Subject: [PATCH] RDMA/irdma: Fix out-of-bounds write in irdma_copy_user_pgaddrs
From: Jacob Moroni <jmoroni@google.com>
To: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com, jgg@ziepe.ca, 
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org, Jacob Moroni <jmoroni@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 0A4965284BE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20513-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The irdma_copy_user_pgaddrs function loops through all of the umem DMA
blocks to populate the PBLEs and will stop when either the last DMA
block is reached or palloc->total_cnt is reached. The issue is that
the logic for checking palloc->total_cnt would only work for non-zero
values.

When irdma_setup_pbles is called with lvl==0, it
calls irdma_copy_user_pgaddrs with palloc->total_cnt==0, which means
the only way to break out of the loop is to reach the last umem DMA
block, which means it could end up going beyond the fixed size of 4
iwmr->pgaddrmem array that is used in the lvl==0 case.

In the case of QP/CQ/SRQ rings, the value of lvl is determined by a
separate input (for example, req.cq_pages in the case of a CQ). So,
we must perform explicit checking to ensure we don't overflow the
pgaddrmem array if the user provides a umem that consists of more
blocks than their provided req.cq_pages.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Jacob Moroni <jmoroni@google.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 17086048d2d7..b30e81d2b933 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2781,10 +2781,11 @@ static inline u64 *irdma_next_pbl_addr(u64 *pbl, struct irdma_pble_info **pinfo,
  * irdma_copy_user_pgaddrs - copy user page address to pble's os locally
  * @iwmr: iwmr for IB's user page addresses
  * @pbl: ple pointer to save 1 level or 0 level pble
+ * @pbl_len: Max number of PBL entries to populate
  * @level: indicated level 0, 1 or 2
  */
 static void irdma_copy_user_pgaddrs(struct irdma_mr *iwmr, u64 *pbl,
-				    enum irdma_pble_level level)
+				    u32 pbl_len, enum irdma_pble_level level)
 {
 	struct ib_umem *region = iwmr->region;
 	struct irdma_pbl *iwpbl = &iwmr->iwpbl;
@@ -2792,7 +2793,9 @@ static void irdma_copy_user_pgaddrs(struct irdma_mr *iwmr, u64 *pbl,
 	struct irdma_pble_info *pinfo;
 	struct ib_block_iter biter;
 	u32 idx = 0;
-	u32 pbl_cnt = 0;
+
+	if (!pbl_len)
+		return;
 
 	pinfo = (level == PBLE_LEVEL_1) ? NULL : palloc->level2.leaf;
 
@@ -2801,7 +2804,7 @@ static void irdma_copy_user_pgaddrs(struct irdma_mr *iwmr, u64 *pbl,
 
 	rdma_umem_for_each_dma_block(region, &biter, iwmr->page_size) {
 		*pbl = rdma_block_iter_dma_address(&biter);
-		if (++pbl_cnt == palloc->total_cnt)
+		if (!--pbl_len)
 			break;
 		pbl = irdma_next_pbl_addr(pbl, &pinfo, &idx);
 	}
@@ -2877,6 +2880,7 @@ static int irdma_setup_pbles(struct irdma_pci_f *rf, struct irdma_mr *iwmr,
 	u64 *pbl;
 	int status;
 	enum irdma_pble_level level = PBLE_LEVEL_1;
+	u32 pbl_len;
 
 	if (lvl) {
 		status = irdma_get_pble(rf->pble_rsrc, palloc, iwmr->page_cnt,
@@ -2884,16 +2888,18 @@ static int irdma_setup_pbles(struct irdma_pci_f *rf, struct irdma_mr *iwmr,
 		if (status)
 			return status;
 
+		pbl_len = palloc->total_cnt;
 		iwpbl->pbl_allocated = true;
 		level = palloc->level;
 		pinfo = (level == PBLE_LEVEL_1) ? &palloc->level1 :
 						  palloc->level2.leaf;
 		pbl = pinfo->addr;
 	} else {
+		pbl_len = IRDMA_MAX_SAVED_PHY_PGADDR;
 		pbl = iwmr->pgaddrmem;
 	}
 
-	irdma_copy_user_pgaddrs(iwmr, pbl, level);
+	irdma_copy_user_pgaddrs(iwmr, pbl, pbl_len, level);
 
 	if (lvl)
 		iwmr->pgaddrmem[0] = *pbl;
-- 
2.54.0.563.g4f69b47b94-goog


