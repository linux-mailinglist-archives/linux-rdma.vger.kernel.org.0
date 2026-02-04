Return-Path: <linux-rdma+bounces-16509-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBq+Gb8Rg2kPhQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16509-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 10:30:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C105AE3DC7
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Feb 2026 10:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B07CE3100A2B
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Feb 2026 09:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC013A4F39;
	Wed,  4 Feb 2026 09:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FsLoj7B+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3560C2D46A1
	for <linux-rdma@vger.kernel.org>; Wed,  4 Feb 2026 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770197166; cv=none; b=e+wCDwtf53PJsE+raZpIAY/D07baPTeHk+D5Qm4qhSpl1TMkaYjH9b4bdJP3BsOVl6G+mP+SNuObstvOhuU66y+WcmXWV+T4vAPr+0PVD6VA34rpd/Y2HeJ3QbwpfDEcjTSWbeCr81oBDzE87rfbvL4dT9e/yowP43uXUY43Xd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770197166; c=relaxed/simple;
	bh=G5P7z7+U5aroLYYVIY1+Plzx3mm1aFFzDDj+Ko9B+F8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ffunxExLAYDkeRvfVQqiKAsS0ujgvVM4bMUSI7tcBmDmh6/psrv992pWkqi0C/cUJfMxl2vjQLqCpcYJ0zIppKW9TkDSWToWimvlb3S7et1VwHrWokq2u6HxqBy6HaEsmHoUr18zoq0ocrIT6qv3s3nZ7cGSr4ZXvro6jZR7p7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FsLoj7B+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82318b640beso3733223b3a.0
        for <linux-rdma@vger.kernel.org>; Wed, 04 Feb 2026 01:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770197165; x=1770801965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9unXCrz3ty1ijbAz9f1KR463HyL93AkrrXxYNI8YoeM=;
        b=FsLoj7B+ycwrgBDvIhva0HZdPGaSvbSQ9K4QVIYxN0CnFZ9sZ0YWM18cRuHKYhJgzl
         /MpCVLQx4q9PRhmJKgsq0Q1ZmNBsEHgTtKX5MnAlCZvhwuEt9W9TjFER+vSKHVC2QKRK
         RomfV4iyv7jFZMnA2zLIJniZpe1MB9H5M6IQZkALeN3lxedP1U0LGUzrrH4qm1YRJy0r
         ppqw8GezN9/noYf7XdhntBuywKfapx5Id3qMwcz0A8/K6bduBGOiYWPT89rTGn7o0+jX
         YXMoc235jlcNElVDYw5Wb6+z1g4F4XwJ2Zya9JPbzbLMW/Jy8ZbLCq1yLZlPD11klOI4
         fkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770197165; x=1770801965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9unXCrz3ty1ijbAz9f1KR463HyL93AkrrXxYNI8YoeM=;
        b=IpsPUjvOWlYtspaguI/84UKCWjWpE3CqyLQqgBXKJXHmZjOTUkr8+I+ceDAPm9B9M/
         RH550lIAHK2BnvCZvw2ttpA1kiwguCIko7j0yh2gyRLHr12oLRWvUwSWHpAEWjeQV/OB
         Sfcm5y73xHdTTJKZkMSEshQsyk8ANvhuTWRAvL3o/XcYxZuPGB6hqXDL7CMOyfnn+1Fe
         omoebsQGq8s67ih6KqDJQpiq4S8DeDi57x0x89p8J/UoqWpzJ/neu5PHi0vI0KPhr7G4
         5OPMt3F8tflMP2ipfDGb5eb8cIJYPCzpGWiJeCA4aw85WWo4W3YyPXPkiXvWDYcyth2i
         KXmA==
X-Forwarded-Encrypted: i=1; AJvYcCVm08gSD/AEh0n1LdkiyHIWXT0FJQ7tt+ONlhIIgm0kbcKk3TUBetvjiUCf6iV5wuQGdr3PQvgHA3y3@vger.kernel.org
X-Gm-Message-State: AOJu0YwYd3vmU9fzu3kCqXDe44z34SpztpOouBhaHX5UZbKRcSngaOsr
	2bciGMAV+4PJ52vQC885Kob5ZKLcfq49CB/YiLyDq2FES/2b5R8I4PL7
X-Gm-Gg: AZuq6aIbWFZlOIvr7yC10pGdOLVSH0xhIpBYVFI+1g3edCinsILQun7pCjmTXYFuXpS
	yNx/5CmqY86Vu//WN6RBdntLm023axm7wrsRfF/BAecFjti+5lJjVmDu8LXXYso0Bbo0tIfccpp
	kHW3EXfeSro0M1+I4u+UmQZgACPm7CdF9l20sh6p+U0Y/mFEtXkVRcZGZlQw4zBOQ3NLlJS00Jn
	9JS3wfp6pOlswE6/FbPaHu13+8r34yI/FTcIXavu5H5BkfJqlV/MbQsASPvWMcs9/OsPIYRlsOn
	Cs+XENBg/JET26spxdoQFin7qlNXyuUe2dH61w5NgyTpukquXNMTqNkab2I7hFq5xeTNkhanM5S
	+X3g1PKTLwlhL3X/R5J2mIMXimR+/qmHQxO9ZSr4Ux5mGRWNxURZMZFcY0KRi8b3Wz/g5UDhuCy
	ysti0wpRaRo18fUcoOkKAOVvEXTGA/tzPh
X-Received: by 2002:a05:6a00:1256:b0:81c:92ec:ccf3 with SMTP id d2e1a72fcca58-8241c255569mr2447051b3a.19.1770197165254;
        Wed, 04 Feb 2026 01:26:05 -0800 (PST)
Received: from user-System-Product-Name.. ([210.121.152.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d163850sm2299757b3a.2.2026.02.04.01.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 01:26:04 -0800 (PST)
From: YunJe Shin <yjshin0438@gmail.com>
X-Google-Original-From: YunJe Shin <ioerts@kookmin.ac.kr>
To: bernard.metzler@linux.dev,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: joonkyoj@yonsei.ac.kr,
	ioerts@kookmin.ac.kr,
	linux-rdma@vger.kernel.org,
	yjshin0438@gmail.com
Subject: [PATCH v2] RDMA/siw: Fix potential NULL pointer dereference in header processing
Date: Wed,  4 Feb 2026 18:24:57 +0900
Message-ID: <20260204092546.489842-1-ioerts@kookmin.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16509-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_CC(0.00)[yonsei.ac.kr,kookmin.ac.kr,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yjshin0438@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kookmin.ac.kr:mid,kookmin.ac.kr:email]
X-Rspamd-Queue-Id: C105AE3DC7
X-Rspamd-Action: no action


If siw_get_hdr() returns -EINVAL before set_rx_fpdu_context(),
qp->rx_fpdu can be NULL. The error path in siw_tcp_rx_data()
dereferences qp->rx_fpdu->more_ddp_segs without checking, which
may lead to a NULL pointer deref. Only check more_ddp_segs when
rx_fpdu is present.

KASAN splat:
[  101.384271] KASAN: null-ptr-deref in range [0x00000000000000c0-0x00000000000000c7]
[  101.385869] RIP: 0010:siw_tcp_rx_data+0x13ad/0x1e50

Fixes: 8b6a361b8c48 ("rdma/siw: receive path")
Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>

v2:
- keep srx->state > SIW_GET_HDR completion path intact
- guard qp->rx_fpdu before checking more_ddp_segs
---
 drivers/infiniband/sw/siw/siw_qp_rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index a10820e33887..e8a88b378d51 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -1435,7 +1435,8 @@ int siw_tcp_rx_data(read_descriptor_t *rd_desc, struct sk_buff *skb,
 		}
 		if (unlikely(rv != 0 && rv != -EAGAIN)) {
 			if ((srx->state > SIW_GET_HDR ||
-			     qp->rx_fpdu->more_ddp_segs) && run_completion)
+			     (qp->rx_fpdu && qp->rx_fpdu->more_ddp_segs)) &&
+			    run_completion)
 				siw_rdmap_complete(qp, rv);
 
 			siw_dbg_qp(qp, "rx error %d, rx state %d\n", rv,
-- 
2.43.0


