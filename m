Return-Path: <linux-rdma+bounces-18899-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2N6FNjwXzWmMZwYAu9opvQ
	(envelope-from <linux-rdma+bounces-18899-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 15:01:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A29B37AE02
	for <lists+linux-rdma@lfdr.de>; Wed, 01 Apr 2026 15:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B81023113F6F
	for <lists+linux-rdma@lfdr.de>; Wed,  1 Apr 2026 12:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8903D402443;
	Wed,  1 Apr 2026 12:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gg/dunDc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810153FF8A8
	for <linux-rdma@vger.kernel.org>; Wed,  1 Apr 2026 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775045961; cv=none; b=mdPp+1Vs+UrjiV4nj4RVrnwLoxrNGQw18cFyqslDRands/6/ahjsF5DBPA4SJIhnFtw7nPXhR9hORCsgLUPml1gqRquXhPezW9sQVI0u/+HQhmVAacZS+1Z2cNyLTvAbJzvetdACGiWNWS/jBj/HHouraEmoKKfx5nIfcUbiyJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775045961; c=relaxed/simple;
	bh=x6WXeSZWVt4a2zYVs/4EbxVlbkdET5QdS7RBm52VSFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vda5t382maIaWzeL/ENpyS6iQ3ZtpT+0+If5l5LsM6zuO93hacAZkSX2ughRr6lekd47OrdUmrODEQ9GYe5ir86LPxQs9J22IHZSg3PpaaTeiKphZMqRZhSEbiaMoKS/kpA8fFizU+nQiAS8RmvCkdsPsF0K9E4Z4Zl+aSsfvFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gg/dunDc; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12776bebe9fso3571473c88.1
        for <linux-rdma@vger.kernel.org>; Wed, 01 Apr 2026 05:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775045956; x=1775650756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L1OiliMXENpNlUeXTkiwAk5fsKUJbcwISyUwh8pYldk=;
        b=gg/dunDc3RcSeSpL7I5i1H8m4yCyxGjBHO0Udd7ghkiTeIClGQcwa560BXOPa/oSUJ
         j//HOZKYYlxh1boky6ROwW/jpdzD9TzXzDR5a4ttRxl0im5Q8AYr/o5Kedw5dfukqVK9
         0TeRgMOwgE/uJPR1afQysnjMxIM010J02PPyUrUhx8/RieMYAqIld7iJzmXHakoy55Sr
         v80m1JUXrQlbT5EGnVcNTVV3AAs+dFOct2Ahwlfddm8gLMOw/JP4fwZYHxeWlceoRAlA
         tRTZPHUGUcSYaXoo0rpPsY2gTr0NxiW7eYWuuDNfz8owu0JU0gNi7cayNnMAcNmCOaOc
         gpyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775045956; x=1775650756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L1OiliMXENpNlUeXTkiwAk5fsKUJbcwISyUwh8pYldk=;
        b=f/j7C5C3OQ/EvJMp8wa4Opdu1VJz59I9rhpK69Xf1LDTPuorQX0CYucfPsfN6fPND7
         SZ1ezom775zuFlq5wQ1NUS2ggOKYzBvkgE0hqmmW3S7Lwx/Q5Bs0mCJUsFyNNbMd+GVh
         SZ24QHB7bEX4aLvwdKCcP8Ta2yOhCUAUzoTZA/gFbBAwbPNz9apM1Onm4GG2O3ZRGhIg
         1nHJtQxBKjjPzhmAxJVkaDdylfSRhOyECz0eWEWYPswzHXPjtz2DqccTkDiScksBThGu
         6vVYLDOEm76bn3NFN1GUGlO40M2tbXoKel1KW9OFPXrLQPnNMQXHTgjhj5mvGqWAjx2w
         RYtw==
X-Gm-Message-State: AOJu0Yzk3Bn5MGwbNUw4nEoT4Lw+KH4+jmJHXEonOHbolVHMm5HGQYEx
	rIvOXILIsYQofN+ln/4thU2l0qeaRWVXjCASgOV0rpldARlcpSUgkK39
X-Gm-Gg: ATEYQzy25WiTaD/PSPs9WKiiVsRe1PYIdm5GsOOdiDeFj6Bc+VNpUSrx82VxdTgzAxr
	d0Sm+/RF9RHRLGOWVc57nxp027EC7ok88wK9Pq3uMEMLGgMMGekx/r5DTd81bfELWEhHBTs8cNA
	WI3J0xpQAhAuHlqJBWoxKBRmyK9oMlVQSvagL0hvzCg43jcqtPpS63KBXnFs/FWfQEsHmr4A5F8
	GSm6rxXxNRkmW0Y5gdRoeS0syzJdONSS7+ZCjYC86c9I3STmP3pbWGv4l68iGe8MoS4Jyg9BTlT
	yvEBNjCkJrcVbmfjpoYITzjVb2c2Eaq64fUv4nX1NqHwagBaIJ75p+w/iTrM0fqNGcAfXAj3AlF
	CFtc9sDnYMWtWHkRu5YwkwwB1sIJA3Vc1SYuOwtFbzQAWfeIXA1IHf+vNCZWqENXkSHsdXBlPQA
	fp7kl3QITJ5nPMviRZd/PV3uhqRwKILz85rbFEUUNkUVyE8kIY7lOUUm0OEBgvuxNKEw==
X-Received: by 2002:a05:7301:1f04:b0:2c5:721d:99e2 with SMTP id 5a478bee46e88-2c93088eb63mr1783508eec.2.1775045956149;
        Wed, 01 Apr 2026 05:19:16 -0700 (PDT)
Received: from localhost.localdomain (104.194.93.216.16clouds.com. [104.194.93.216])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c8d8776dc0sm2851058eec.2.2026.04.01.05.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 05:19:15 -0700 (PDT)
From: hkbinbin <hkbinbinbin@gmail.com>
To: zyjzyj2000@gmail.com,
	jgg@ziepe.ca,
	leon@kernel.org,
	w@1wt.eu
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hkbinbin <hkbinbinbin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] RDMA: rxe: validate pad and ICRC before payload_size() in rxe_rcv
Date: Wed,  1 Apr 2026 12:19:07 +0000
Message-ID: <20260401121907.1468366-1-hkbinbinbin@gmail.com>
X-Mailer: git-send-email 2.51.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18899-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org,1wt.eu];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkbinbinbin@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A29B37AE02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rxe_rcv() currently checks only that the incoming packet is at least
header_size(pkt) bytes long before payload_size() is used.

However, payload_size() subtracts both the attacker-controlled BTH pad
field and RXE_ICRC_SIZE from pkt->paylen:

  payload_size = pkt->paylen - offset[RXE_PAYLOAD] - bth_pad(pkt)
                 - RXE_ICRC_SIZE

This means a short packet can still make payload_size() underflow even
if it includes enough bytes for the fixed headers. Simply requiring
header_size(pkt) + RXE_ICRC_SIZE is not sufficient either, because a
packet with a forged non-zero BTH pad can still leave payload_size()
negative and pass an underflowed value to later receive-path users.

Fix this by validating pkt->paylen against the full minimum length
required by payload_size(): header_size(pkt) + bth_pad(pkt) +
RXE_ICRC_SIZE.

Fixes: 8700e3e7c485 ("Soft RoCE driver")
Cc: stable@vger.kernel.org
Signed-off-by: hkbinbin <hkbinbinbin@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_recv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_recv.c b/drivers/infiniband/sw/rxe/rxe_recv.c
index 5861e4244049..f79214738c2b 100644
--- a/drivers/infiniband/sw/rxe/rxe_recv.c
+++ b/drivers/infiniband/sw/rxe/rxe_recv.c
@@ -330,7 +330,8 @@ void rxe_rcv(struct sk_buff *skb)
 	pkt->qp = NULL;
 	pkt->mask |= rxe_opcode[pkt->opcode].mask;
 
-	if (unlikely(skb->len < header_size(pkt)))
+	if (unlikely(pkt->paylen < header_size(pkt) + bth_pad(pkt) +
+		       RXE_ICRC_SIZE))
 		goto drop;
 
 	err = hdr_check(pkt);
-- 
2.49.0

