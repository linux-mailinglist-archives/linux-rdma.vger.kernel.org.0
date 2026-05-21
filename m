Return-Path: <linux-rdma+bounces-21109-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHmaJ3QND2qSEgYAu9opvQ
	(envelope-from <linux-rdma+bounces-21109-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 15:49:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7885A6442
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 15:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8EA432F8F59
	for <lists+linux-rdma@lfdr.de>; Thu, 21 May 2026 13:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C0B3D7D67;
	Thu, 21 May 2026 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqEqJ8Ec"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8060A3B2FC7
	for <linux-rdma@vger.kernel.org>; Thu, 21 May 2026 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369652; cv=none; b=l9cs4idfZ/7Gq4Qb2cyj0KGRtUPOKurzVAb2KW1cv0Z04xEVqDmGFg0+ZSBq/Op3opSvBkEC2efu9ccz5G7WskAuHEnCts/73/8X1y+dt7c3UzKlcznS5qeg5z0nSmQ67tRPDHQd17psTnS4YQ2PFIWWaS7CT3Vy/C3eXi39DyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369652; c=relaxed/simple;
	bh=ubQU2oquEa++COtDSqD7OVoJAyfvJd89jAtOAgPP+tA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mppK7vfPIxRlvjknk2Z9T1diwWl62BATbj/O3/9GFu333Nlx6dxuXv0TWctRCTXPoKueYhJJuGq19TjPFSx5TyWfiouavLFIhGI0DkkEyNr1iBWfymS7rWWdcTOdLqpnyEgI03Q4MhMzHtP5TTzfm7XiBk3w64JcPgLbzuh/gqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RqEqJ8Ec; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36974221f93so3319111a91.2
        for <linux-rdma@vger.kernel.org>; Thu, 21 May 2026 06:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779369650; x=1779974450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TRFTEKHYtfPaeIVYcQrFvfCGX7kREmXkMBppsc46oO8=;
        b=RqEqJ8EcPQgStAQ5gh+/7Lv999QLWG+8/HXVmFi+wRQXPMp2fzdA+06ke0BzfTp4je
         i2Cv/zu42t+edkMXY0xixLsDo65kTlbno7q8WS3Y9mlLdGos2a51oUNcmEfBLCJ7icdr
         cTaK7rpzLBj1Y3jbddL25EBtQMgrDTXDDXVU0lE/xVMlTdQfSr5gdFW/oS2gg1QPTPVI
         ZhwXPGw5it4coRrbe7JagaCQzak1MItQekQ13CFrtHFsehfcCxHM2afv5CPYR8tf0oTn
         1UQy6qyqWii5kzNdinnAKbwLrurFbUEA9Th/qB2mFKQC98PqNsO+IY9sNlxO+TNoP0Eh
         J5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779369650; x=1779974450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRFTEKHYtfPaeIVYcQrFvfCGX7kREmXkMBppsc46oO8=;
        b=PkSFFe+lCAVomm8KC9QyNre8tOsbr2SCEtYS04v9WFG7smEX6wNk1M6pzczQs9R3sf
         VpQo10A4gi1FkEvWGytzDIYU3R5CQ1hcC9X1LcgvOpceR6/oknH1LbbbFDgzP/viHJt+
         AT0nNaiNt4ch4nh7bNBOR7uzQPjUjJXcMCKt6sr3WQd6ykycml9QDxaZ3CO6uR4HJkId
         JKKi698lspZ2k6wRl/Lv3CzDPi2HPBRFPvMljd19PE1PASw6AxhylkueazvoO7M/lnKL
         Z4rJ26BljhgwmIsFZb3EOTP2CvVavJsBfY2sY3Zhlyspcu+bSFhMvJguMD00u1bAmWFz
         i9fQ==
X-Forwarded-Encrypted: i=1; AFNElJ8j2ibsRAQvt9pjxarAriKuCpHOCq/pSZ8FUIkj9EQ0HE2dHJLPEjzAZNuc4eGkNP4gdLooaJ48udNj@vger.kernel.org
X-Gm-Message-State: AOJu0YzhJOt3nu930zfBjOVl16ZcVVHqrjU80NAku17C4Qx0uVAn45Oe
	hbDLWA+wB48THpcqjS6DAw4vqSNSIi+WAKCV08cnxgvB2WAx8pG5LH1u
X-Gm-Gg: Acq92OGL5Ij0ZBYVq1Hmlx6i98pPaAOndJk45l+XuFQqG/ZnBnm8LNOUc31OIeaaiQQ
	6Rqiy4Qh/+rH0HgYtcE0C2TMQPDim90vZjXZDdz9+uOu+wyP07vJrj8FbGeXVJDpRKCMrFo4vn9
	i9pgJoGwImcqz0o4GrCnZXt8YnWusjoVp2y/pox2zi+2fBnuuCXJV4xYQychvhkHuooKOTywE9s
	qyO17ki9a5xXHwtfLtxXg9aRPi55Ji0WYIBkrF7AEZtVtG3muVezkDVQnnKH0Aq7SZKvfH0NTHs
	KuHg5clC3763hV+gdxR338Rje1aVoExYPAVDsw+/Oone33X7ltDt/O/o5nbVY8Lvg/pHGkLC/HK
	KAbOYQjCopRJ1wPhKd1n6jb4q2MpM/nYorGSpmxA82xOqapg+LNxZ9tpUU1HjRVdnz3s9aCNhh1
	MElQD3jM87axDcal21rAm5vkt8XRBrGBiR1ars8pY3jZ8vnTtq
X-Received: by 2002:a17:90b:3505:b0:368:9da3:c496 with SMTP id 98e67ed59e1d1-36a4575e8acmr2887160a91.24.1779369649745;
        Thu, 21 May 2026 06:20:49 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a45757364sm843594a91.5.2026.05.21.06.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 06:20:49 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/hns: fix dead empty check on head->root in setup_root_hem()
Date: Thu, 21 May 2026 21:20:45 +0800
Message-Id: <20260521132045.3430906-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21109-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,linux-rdma@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1C7885A6442
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

setup_root_hem() reads head->root with list_first_entry() and then
tests the returned pointer against NULL. list_first_entry() never
returns NULL. On an empty list it returns container_of(&head->root,
struct hns_roce_hem_item, list), which equals &head->root because
list is the first member. The -ENOMEM early return is dead code.

If head->root is ever empty here, the aliased root_hem points at
&head->root. root_hem->addr and root_hem->dma_addr then read past
the end of struct hns_roce_hem_head into adjacent memory. The
garbage value is handed to the hardware as a DMA base address.

Use list_first_entry_or_null() so the empty case returns NULL and the
-ENOMEM early return runs.

The same shape has been cleaned up elsewhere, for example in
commit fbb8bc408027 ("net: qed: Remove redundant NULL checks after list_first_entry()"),
commit c708d3fad421 ("crypto: atmel - use list_first_entry_or_null to simplify find_dev"),
and commit 10379171f346 ("ksmbd: use list_first_entry_or_null for opinfo_get_list()").
This hns site was missed by those cleanups.

Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/infiniband/hw/hns/hns_roce_hem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hem.c b/drivers/infiniband/hw/hns/hns_roce_hem.c
index e7c9e30ad2d8..12ac9ba6b312 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hem.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hem.c
@@ -1267,8 +1267,8 @@ setup_root_hem(struct hns_roce_dev *hr_dev, struct hns_roce_hem_list *hem_list,
 	int i, total;
 	int ret;
 
-	root_hem = list_first_entry(&head->root,
-				    struct hns_roce_hem_item, list);
+	root_hem = list_first_entry_or_null(&head->root,
+					    struct hns_roce_hem_item, list);
 	if (!root_hem)
 		return -ENOMEM;
 
-- 
2.34.1


