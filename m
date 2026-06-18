Return-Path: <linux-rdma+bounces-22339-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fPICNn1xM2qABgYAu9opvQ
	(envelope-from <linux-rdma+bounces-22339-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 06:18:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C1769D79C
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 06:18:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=V2voVSjV;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22339-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22339-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B77DC30342AF
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jun 2026 04:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7437374A01;
	Thu, 18 Jun 2026 04:18:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E288351C20
	for <linux-rdma@vger.kernel.org>; Thu, 18 Jun 2026 04:17:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781756280; cv=none; b=uXCyKQsb2AJhsD19Qv1mqw1LiKv82RUfx5ygGIDPdhwSyEMZHOELCHRiQy7XEWiY8MIP04w+uyqoKOERNsMotph9kF24R3sSiLDgcZqaX772Vgfo/XrZG3953NrX+uYSg2wG9/DfNPBzSvV+P7RdajAfV3yyTv2qxfMx3PeeggE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781756280; c=relaxed/simple;
	bh=6u7Foak+HYm4YNvp1NSRBYj8EWhdk24OG4yFL6eNabw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MPfdCcXoOb1mMnNrlAf5+LJZrpaTBErqzNItV8CxNnAcd2312V8AykGf2Qc0bcnoS555Ntlu2mxIl7G9vSmf2P4HD/mY7Zb+lxm8GPxcW+EBUOsbQymU1SOphAdNWrdqQe2rjVmnamsQK3SWIWDTKFxDCixRFq6/1WEvCi+R5VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2voVSjV; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c6bdb8a8bdso3018915ad.1
        for <linux-rdma@vger.kernel.org>; Wed, 17 Jun 2026 21:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781756279; x=1782361079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f9+4F23nRXmvcstAl7PKXowIyLqfAAv72bfzi1AI54M=;
        b=V2voVSjVhcJsGM1w7okvlUvaRkQ7ZDnGNsT/x4sH6xvGLt02Eb5WCfof7XEOB7uRpR
         KPggH+wC8UwcN3LpqZRdEAOhXH77QMOHdOxGVFuhRjxiBIKU8ZnGYEjDalB0RouwWBaX
         qBQ1eKq8Axs7V1dnb9hfG+0dIBsS7X+gu74hncFa+GXL3m16kMwSDnUlAJmRrRKgy4hj
         czC1LiDGbnJ9+Qnjxvl0Q34VYuz6e1KqZglwVl+OPcXRvJNbMekzNafHYQkwceJg2kCK
         xBvEER1joSNQUbRAe6T7a+n/Swyr7lcChop7CS9szrucXsALHLOdI9hc2W+WtsRJFh/z
         ZrUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781756279; x=1782361079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9+4F23nRXmvcstAl7PKXowIyLqfAAv72bfzi1AI54M=;
        b=OVE9wvSa83NROXOVk/XboPDL1APM5Y1bvYC3icCXHX5N7NzFTlKHh2dcCJ+JTMjv0y
         W6fP/BRcXLRTnXX9pClEJvIEOI06sM09jFxHfHHMIPY8wHRLo0bJOMs7Wgo8LFMewEM/
         I5bcxwdgSJKHrmGwLxUL7fSj25RZvdqwdEzdouior0b1JdjL6zRlJ1nNYxH7m3EcumlR
         CayMBn9cLM8HJDHzA086HZwFgh3D/WM19s1njjptdVthac/SpV4YAtgnYSti09uhEN//
         9nF29pg+p5z+3AQwIWYvZud6PQ63if8IiPPuu0YiOdps7ZHjVjvFGiyNsaOYWEK21Wdv
         qzpQ==
X-Forwarded-Encrypted: i=1; AFNElJ8MXve77Ns8bmHkc2JSd0pLFuHEkdE6eFEzJxZoVnt5vlGf1d3GgYYS4C7QZeRr3SyNsob77/h60NJm@vger.kernel.org
X-Gm-Message-State: AOJu0YxRLQL+MW0nhaxTfJM54cVM9aiDLNsszC14kzJG3zvA8H6OCGfa
	ifxH77VwVm+vYuYMX0zyN8ir+pYg4yEfU5a6dboqY3oyAoui1dWlATQ/
X-Gm-Gg: AfdE7cnIM6WuwJFMHJxK95K1XwEFWm3uk257OEUB2Au5MERwRd4uOzW0IopClpFxS1l
	nSWTcECf3tG+uOT47ZIQWa+I3I8KG+eO3dl9NOy8rwIwyRSfSlfOLcm+oWQp68/f+0BPJJ98Mh6
	jDxHdrpkWclkJEU7q9NRYLYYTO0MqidUZGxkncVgpo2jMUWIZlU5bObOFAqkoNjW78NMTIn1iI5
	Wt5MFN6Ui4xkceMLTCC1GU0zcUPgyvJlkZl1dbqCJqZ2gzK9NQairzg0XfjGhJnaTSWv1QmXO2r
	RKiRkuDKzcBnPSwoYHkCerlvnQEgabi5CHrShy2VkuiVa6yTH9uLe5bMVlCUSmaFq74OuS52V3e
	N2ZfD1QbTrF5FOmPF4Ni5kSzjr9L3FriSikSGuAq9zcrvZDCwsvRaru0q/UYB9rV33B/71U1nFn
	McS+Ah3YocXEkKrngxoliQ1FiSocCmLiwLAAEH5K4aJ98=
X-Received: by 2002:a17:902:e54a:b0:2c2:2a8a:af69 with SMTP id d9443c01a7336-2c6bc0c4a66mr66215135ad.9.1781756278676;
        Wed, 17 Jun 2026 21:17:58 -0700 (PDT)
Received: from haichao.tail057a43.ts.net ([2001:da8:e000:1206:c19d:3f9a:e9ce:93d4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6c4689ccfsm34516645ad.66.2026.06.17.21.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 21:17:58 -0700 (PDT)
From: Ruoyu Wang <ruoyuw560@gmail.com>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Cc: Cheng Xu <chengyou@linux.alibaba.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Long Li <longli@microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ruoyu Wang <ruoyuw560@gmail.com>
Subject: [PATCH v2 1/2] RDMA/erdma: initialize ret for empty receive WR lists
Date: Thu, 18 Jun 2026 12:17:51 +0800
Message-ID: <20260618041752.481193-1-ruoyuw560@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linux.alibaba.com,microsoft.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22339-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@nvidia.com,m:leonro@nvidia.com,m:chengyou@linux.alibaba.com,m:kaishen@linux.alibaba.com,m:longli@microsoft.com,m:kotaranov@microsoft.com,m:linux-rdma@vger.kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ruoyuw560@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ruoyuw560@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ruoyuw560@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 64C1769D79C

erdma_post_recv() returns ret after walking the receive work request list.
If the caller passes an empty list, the loop is skipped and ret is not
assigned.

Initialize ret to 0 so an empty receive work request list returns success
instead of stack data.

Fixes: 155055771704 ("RDMA/erdma: Add verbs implementation")
Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
---
v2:
- Split the erdma and mana_ib changes into separate patches.
- Add a driver-specific Fixes tag.

 drivers/infiniband/hw/erdma/erdma_qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/hw/erdma/erdma_qp.c
index 25f6c49aec779..e002343832f74 100644
--- a/drivers/infiniband/hw/erdma/erdma_qp.c
+++ b/drivers/infiniband/hw/erdma/erdma_qp.c
@@ -734,7 +734,7 @@ int erdma_post_recv(struct ib_qp *ibqp, const struct ib_recv_wr *recv_wr,
 	const struct ib_recv_wr *wr = recv_wr;
 	struct erdma_qp *qp = to_eqp(ibqp);
 	unsigned long flags;
-	int ret;
+	int ret = 0;
 
 	spin_lock_irqsave(&qp->lock, flags);
 
-- 
2.51.0

