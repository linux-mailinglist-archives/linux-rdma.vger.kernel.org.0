Return-Path: <linux-rdma+bounces-22282-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 39qMOJWAMWo9lAUAu9opvQ
	(envelope-from <linux-rdma+bounces-22282-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 18:57:57 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DE76929EF
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 18:57:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cnJTTwrj;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22282-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22282-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59EFF3056644
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 16:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329D235DA6A;
	Tue, 16 Jun 2026 16:54:59 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B023044CAF5
	for <linux-rdma@vger.kernel.org>; Tue, 16 Jun 2026 16:54:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628899; cv=none; b=mTA7Nzo9xsmrDnoYXN+gsmos2aiqU2Koh3BQ4p7ZpTM92Rfzd9ZtBg7WjXZcxY5uhNr6YNLFl/k8IdrWiVZ+GZVV/u2ySxXYXgJnlL9YowS5LGc2IDJgqkIzKOZlw9djXoCTnKDvDovzkqsDvA0T1c6DXO+ChovIgrnHjTkLTmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628899; c=relaxed/simple;
	bh=6hat5+8vR6sH5hwpRtclSnvBpCW++LLkr0Bw3mrJ7YE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B62XxKVWuUfornxWkJ6h+NJpdl5CwRZnzJhuC/YaKiJuUODFH6RzeD4iICpOdwFoO3DtkTy/TCYeA9NaXRB2G3RtMdd3xln4u5T/D6jUDX2i0qha8FLM6XmFKZZkPQiPbYDDlW7kc3cXk5AVllogOy1UemoZM1FQWRjqhRxtjuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnJTTwrj; arc=none smtp.client-ip=209.85.214.169
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2bf125989f2so35865115ad.3
        for <linux-rdma@vger.kernel.org>; Tue, 16 Jun 2026 09:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781628897; x=1782233697; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pJhUJyY1o94pDseZLihc3mmdqQnwkfgxQLMjsWZTRYA=;
        b=cnJTTwrjBqHkTIfF882c6M0EH3YcLdV9TtokEvxlXgLlnTTFiLp9Qx8kWryHDrCEaA
         U6lWLYiy9dilJgdNLOob827YOnJnxbQtm4yXZywrg5mLgb0yiKHyyz5xSL2dMYrkTeNC
         p91cH1zPl4JSPrZXpn+ARCMA0CgWgQ1jqXh9bXljGJsMCqdPhERqcVhB5jhiKZHVTpqj
         HLniqlNN2IhPFjCXiKwKqOXp3619lQOmZe+TKUeHQz2F1WSIg6pC+9HzYpfPl0iJwzkc
         QLzDcSu/UDU3bsxNuYJvxE3InK39OGC8CEln80+MAG0SBIukU7E4Z6pSLnWFdvB1ICVO
         FaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781628897; x=1782233697;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJhUJyY1o94pDseZLihc3mmdqQnwkfgxQLMjsWZTRYA=;
        b=Y4cVgmjhUwlyOcsTtk5B0VygzNi8OOUFdWOqFORrDaLgmfMVtJIbb+f7YbEria6tx2
         z2Oz7qSkRYkMISKu+2BM6sBMkCt68PPHpLFj7bsq2qx6Vof5Bnfyp+IpYgxUveX1v3ME
         yi8mzk31s4myFh4FIpjWwr3thJIH90I+E5fo8plcjA58PPrY3wGLL2TUWkbXPhzQQjoN
         i/HChiQxQo5T6gnZytXKLoxc578FLjtwI1VXtzJj3xeR3SKhh5DOa1skvH+2Ldrwym5k
         TvaVfbf7X0sR6Q++QjHgdtsq2grlRtjVWK5037zqBjvxobtMJIz6pf7RoxSDvQYvli8W
         TpwQ==
X-Forwarded-Encrypted: i=1; AFNElJ9kF2cIxt9858BWJoOz0ZzR4a+RKFIhfk/gQiO3H06M9egytI7SxHKsRY0sylBzBOeULKcjVRGcn25C@vger.kernel.org
X-Gm-Message-State: AOJu0YyE954seQDcy7RZR2mGiSBxj8LYGiLCdWDCberrTxbEz3QweUsr
	HsR+0ARTUf895HIjurMFi+hE+u+krL/OBHKFrbfD2KGNj0SXzrW40SmL
X-Gm-Gg: Acq92OGT9wqr9WG9uMEugwJFs1rItXcwWsFeT5OYaew1ApuFrGmJywu2GYvqPdvCp/Z
	5woLyiy6Vuhr4cRQWlLY8twef6iLDhSX7lLQTCWRaRNMwuWh40vpi2a24HtfMWce3+88UphHRVp
	wfj2oX4N9gm/38OYvlcbSXCgcSp0QTdynpC5R6v7y3xADdleRedkGlQoO5Ixzjcd+Spg50AsvmV
	0GanGXPZM6V69to1VsOHTVbOPlwiIgfCP+39zizaTWtyimkAIkNfH4wQKiCYmfn8YF2qxednVrL
	b+P23mr5F17soUHD5ZX3uQw2ZrwuI2ylSKDAohfTw1KxJociJbZ/zRFJhigPuKWubUEMd+r29tF
	aGGanw74NwuFj/ohiGb2P1kY3nr0nSz6j5UrVKiR5Kuh058vpdh/gxkrwirPJYJOwapen3GiOFF
	3cQen1J3NkbdhjBul/xGD82jGN5Ys4jpfgxqhOY+U=
X-Received: by 2002:a17:903:1448:b0:2c6:a99a:52b5 with SMTP id d9443c01a7336-2c6a99a54b8mr20399395ad.12.1781628897049;
        Tue, 16 Jun 2026 09:54:57 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([36.21.199.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432c8dd4bsm144760795ad.60.2026.06.16.09.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 09:54:56 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Wed, 17 Jun 2026 00:52:00 +0800
Subject: [PATCH] RDMA/rtrs-srv: Reject usr_len larger than off in
 process_{read,write}
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-rtrs-srv-usr-len-underflow-v1-1-942e6414150a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAC9/MWoC/yXMwQqDMAwA0F+RnBdoC7ZuvzJ22DTViNSRWDcQ/
 926Hd/lbaAkTAq3agOhlZXnVGAvFbTDM/WE3BWDM84bbwPKIooqK2YVnChhTh1JnOYPUm1NcDH
 4a1NDCd5Ckb+//P74W/NrpHY5R9j3A9lCw15+AAAA
X-Change-ID: 20260617-rtrs-srv-usr-len-underflow-e51072f76985
To: "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
 Jack Wang <jinpu.wang@ionos.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Leon Romanovsky <leon@kernel.org>, 
 Danil Kipnis <danil.kipnis@cloud.ionos.com>
Cc: Jack Wang <jinpu.wang@cloud.ionos.com>, linux-rdma@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781628889; l=2659;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=6hat5+8vR6sH5hwpRtclSnvBpCW++LLkr0Bw3mrJ7YE=;
 b=I8094tBOYajXXPZzC8+1/pMMZbaGFlrDenRIxKdBWd0C2vZYoxSpKP1mNCIbI6fvxZiN/QbOn
 lAYI0xZ5xY7BlItEoc25kudLN+Rnk39imls5jdM7lhZc86C35DWMjyr
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22282-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[cloud.ionos.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[whi4ed0g@gmail.com,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:haris.iqbal@ionos.com,m:jinpu.wang@ionos.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:danil.kipnis@cloud.ionos.com,m:jinpu.wang@cloud.ionos.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:danisjiang@gmail.com,m:stable@vger.kernel.org,m:whi4ed0g@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[whi4ed0g@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3DE76929EF

process_read() and process_write() derive the data length of an I/O
request as:

	usr_len = le16_to_cpu(req->usr_len);
	data_len = off - usr_len;

off comes from the RDMA-Write-with-imm immediate and is only bounded
above (off < max_chunk_size) in rtrs_srv_rdma_done(). usr_len is read
from the chunk buffer the remote peer fills over RDMA, so it is peer
controlled over the full u16 range and is not checked against off.

If a peer sends usr_len > off, the size_t subtraction underflows and
the pointer data + data_len passed to the ->rdma_ev() callback points
before the chunk. The in-tree consumer rnbd_srv_rdma_ev() dereferences
it as the message header (le16_to_cpu(hdr->type)) before validating it;
this is an out-of-bounds read reachable from a remote peer.

Reject usr_len > off before computing data_len in both paths, via the
existing send_err_msg path. For a well-formed request off is the total
length data_len + usr_len, so usr_len <= off holds and valid requests
are unaffected.

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 6482ad859bd1..ec3f6c2fb0b9 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1067,6 +1067,13 @@ static void process_read(struct rtrs_srv_con *con,
 	id->msg_id	= buf_id;
 	id->rd_msg	= msg;
 	usr_len = le16_to_cpu(msg->usr_len);
+	if (usr_len > off) {
+		rtrs_err_rl(s,
+			    "Processing read request failed, invalid usr_len %zu > off %u\n",
+			    usr_len, off);
+		ret = -EINVAL;
+		goto send_err_msg;
+	}
 	data_len = off - usr_len;
 	data = page_address(srv->chunks[buf_id]);
 	ret = ctx->ops.rdma_ev(srv->priv, id, data, data_len,
@@ -1120,6 +1127,13 @@ static void process_write(struct rtrs_srv_con *con,
 	id->msg_id = buf_id;
 
 	usr_len = le16_to_cpu(req->usr_len);
+	if (usr_len > off) {
+		rtrs_err_rl(s,
+			    "Processing write request failed, invalid usr_len %zu > off %u\n",
+			    usr_len, off);
+		ret = -EINVAL;
+		goto send_err_msg;
+	}
 	data_len = off - usr_len;
 	data = page_address(srv->chunks[buf_id]);
 	ret = ctx->ops.rdma_ev(srv->priv, id, data, data_len,

---
base-commit: a48671671df5158a0b8e564cd509e04a090a941b
change-id: 20260617-rtrs-srv-usr-len-underflow-e51072f76985

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>


