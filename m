Return-Path: <linux-rdma+bounces-21956-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BpEfHSrIJmr6kQIAu9opvQ
	(envelope-from <linux-rdma+bounces-21956-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 15:48:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9013656CB0
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 15:48:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21956-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21956-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 83EAF301939E
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 13:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FD434CFC2;
	Mon,  8 Jun 2026 13:48:21 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C3F31E83B
	for <linux-rdma@vger.kernel.org>; Mon,  8 Jun 2026 13:48:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926501; cv=none; b=E7nspmk2un4LBrp0Cb5+Lcg1kYoIFx9vVbPM6Ia+nv8Q0KfM+kzxERwD6NLHfLBcvnpFB/0NWAAoMwD3s6nW1USpSAzLy3Qgn/KGVw4kU2LMOXSKM9heuTDc4vcPqbrCgJjeR/vz/+4nsR5NQkdjrF3hxds/V/dV+q0elMhCRqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926501; c=relaxed/simple;
	bh=wdMIaMAyWdu4S0DSYGF8WY9qDJK4dJUDqKeDSk483os=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PNHhslQogcbq8Zh9g7S6qAQ3nqGfrioLxvuiUSDNluc1se+1nuPet+s/LKHAdCotucxollksq/tv7bm5Yk9vl8Ietmji2G4CyasYU1sedUPHnG+1FGvzV+hkZYDvZeq9cT8lKiugti+y7B2RBeyPiX7EFoL0Eeld8gdr9soIh2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hackers.camp; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.50
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ef93a0b0fso255948f8f.2
        for <linux-rdma@vger.kernel.org>; Mon, 08 Jun 2026 06:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780926498; x=1781531298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DTMnrlV+pTN/lOUFBQDSTc1z3+qQ6zPVzMzDHtmZ+9o=;
        b=Gn2l9/0EfE37hBNO+Y/qkiLFHg//FC3bzH1rK3HH4/abm0fh0U13IuoMx+WJFVypaj
         mbLFydiBgh1adv4JIGyRXHLZ9wKL3Xij/ZW3+7XUWPFIoLmqpSV0JWWZz+4M3XoRPOnC
         lL188PDp+Amvt3nAqAhKkmq3DoDFwpO0AGd71XAbfmSr93cZKfhM3jNUm7bE1+bgdByJ
         oP64FBjv0Tuk/KQO1atb2p/Fxmgtx0KctK5dIf8N0WogiYyrJEpDDq4AAuLFotDLMcjL
         4HcoigJZa0wF/B3eZU9JFJlhh2/DnKg2Ghl18N1RJ0ys3ooFXWlGlXThqSzVkk0I0b0/
         fFfA==
X-Gm-Message-State: AOJu0Yz8xqtsxZ8xcR1UOI7VLb7QZO8Gb+yr3kIIy0iQLtN6I4t9jGpE
	YTEv+urBvS5VxOV4TiEnkgMXosLK965OoQs//ALUYXjIWIhr9vYJkR3FbIkIPsRh
X-Gm-Gg: Acq92OH4mlGW7NieEumoFNW0i/PLrUR2+KehYdWPbEcWIyFh4B3b94LGUeGYkKlRPT3
	H1HFsUyXTy1jlYjjvaDKQluFbazoTPMacjoJxbWgi/Fqdo6AyRvu0N44SfvLao30mRCLo3Mc7zs
	xD2F+e5bcQUFKFO5LENpz8GiKUYjS9YxbgC97aXIZqXX2VqfTWdVRS9URveZi874gCjvRtP9FpQ
	FKp4Via9P5ysPmhJen5jcDSJDHTvm+3zw/SGs3t5/KUzD9RI1FCI7hykPoU+zaS2rqlyAfMsSof
	8LVtrnzRxRTcAxUkq4wlc/qZXIN+cYZqCSFevCYdnzbwIF8FPuKjFdoAiCd6cb0gTrGE8tY4nR2
	C/tAmNVNPBMXr5a452MI5xWpQE2HVIJQ+hFGR3jlrwt5UJldb6xx+y5hZbp3JdNo9mFm3nDii06
	BDfyYPY9Yklsy23519Xy0XkW6k9DibR6eaKq/jBsuqNfZ5MFZYixM5uwlfAqvRQbJdwnYVkjYlW
	A==
X-Received: by 2002:a5d:5254:0:b0:450:4980:b4fe with SMTP id ffacd0b85a97d-460302f0b27mr7831225f8f.2.1780926498314;
        Mon, 08 Jun 2026 06:48:18 -0700 (PDT)
Received: from spartian.home ([2a01:cb1c:868:fa00:915c:e3c1:676e:553e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda3651sm41027148f8f.32.2026.06.08.06.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:48:17 -0700 (PDT)
From: Aurelien DESBRIERES <aurelien@hackers.camp>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	gregkh@linuxfoundation.org,
	Aurelien DESBRIERES <aurelien@hackers.camp>
Subject: [PATCH] RDMA/rtrs-srv: Fix integer underflow in process_read and process_write
Date: Mon,  8 Jun 2026 15:47:15 +0200
Message-ID: <20260608134802.5019-1-aurelien@hackers.camp>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21956-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[hackers.camp];
	FORGED_SENDER(0.00)[aurelien@hackers.camp,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:jgg@ziepe.ca,m:leon@kernel.org,m:haris.iqbal@ionos.com,m:jinpu.wang@ionos.com,m:gregkh@linuxfoundation.org,m:aurelien@hackers.camp,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aurelien@hackers.camp,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,hackers.camp:email,hackers.camp:mid,hackers.camp:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D9013656CB0

usr_len is read from a network-supplied message field (le16_to_cpu)
and used to compute data_len = off - usr_len without validating that
usr_len <= off. A malicious RDMA client can send usr_len > off causing
an integer underflow, resulting in data_len wrapping to a huge size_t
value which is then passed to the rdma_ev callback as a memory length,
leading to out-of-bounds memory access.

Fix by reading and validating usr_len <= off before rtrs_srv_get_ops_ids()
in both process_read() and process_write(), ensuring the early return
path acquires no reference and has no resource leak.

Reported-by: Aurelien DESBRIERES <aurelien@hackers.camp>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Aurelien DESBRIERES <aurelien@hackers.camp>
Assisted-by: Claude <claude-sonnet-4-6>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index 6482ad859..f2fd80c8a 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -1059,6 +1059,11 @@ static void process_read(struct rtrs_srv_con *con,
 			    "Processing read request failed, invalid message\n");
 		return;
 	}
+	usr_len = le16_to_cpu(msg->usr_len);
+	if (usr_len > off) {
+		pr_debug("rtrs-srv: Invalid usr_len %zu > off %u\n", usr_len, off);
+		return;
+	}
 	rtrs_srv_get_ops_ids(srv_path);
 	rtrs_srv_update_rdma_stats(srv_path->stats, off, READ);
 	id = srv_path->ops_ids[buf_id];
@@ -1066,7 +1071,6 @@ static void process_read(struct rtrs_srv_con *con,
 	id->dir		= READ;
 	id->msg_id	= buf_id;
 	id->rd_msg	= msg;
-	usr_len = le16_to_cpu(msg->usr_len);
 	data_len = off - usr_len;
 	data = page_address(srv->chunks[buf_id]);
 	ret = ctx->ops.rdma_ev(srv->priv, id, data, data_len,
@@ -1112,6 +1116,11 @@ static void process_write(struct rtrs_srv_con *con,
 			     rtrs_srv_state_str(srv_path->state));
 		return;
 	}
+	usr_len = le16_to_cpu(req->usr_len);
+	if (usr_len > off) {
+		pr_debug("rtrs-srv: Invalid usr_len %zu > off %u\n", usr_len, off);
+		return;
+	}
 	rtrs_srv_get_ops_ids(srv_path);
 	rtrs_srv_update_rdma_stats(srv_path->stats, off, WRITE);
 	id = srv_path->ops_ids[buf_id];
@@ -1119,7 +1128,6 @@ static void process_write(struct rtrs_srv_con *con,
 	id->dir    = WRITE;
 	id->msg_id = buf_id;
 
-	usr_len = le16_to_cpu(req->usr_len);
 	data_len = off - usr_len;
 	data = page_address(srv->chunks[buf_id]);
 	ret = ctx->ops.rdma_ev(srv->priv, id, data, data_len,
-- 
2.43.0


