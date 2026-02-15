Return-Path: <linux-rdma+bounces-16892-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DPHAKVlxkWkTiwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16892-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 08:10:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C72E513E301
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 08:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 22804300383D
	for <lists+linux-rdma@lfdr.de>; Sun, 15 Feb 2026 07:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB7A277C9E;
	Sun, 15 Feb 2026 07:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRHWKqIA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D7717993
	for <linux-rdma@vger.kernel.org>; Sun, 15 Feb 2026 07:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771139411; cv=none; b=F85PVdgl+wr7zIVnnotL9ooDnaVdi25TFG+XHdPX7eWdYo6b6LfQNAhIkG/FgSmThwNZX1OfO3LH1dS5Hn2Pnl59R2VdH8VOKn31FsnPWVcKmDlZSqh8UQTrfbb09caAW1aAteW8FwPU3VxAXw/dpyHaJzi+U/1eJs+QwA50Yfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771139411; c=relaxed/simple;
	bh=48kQZ2ApYlekyRt0BAif+sMeREloJXMXGLg7PghooTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q1Ql20ITAH89Eh4NSeLARzlYjlNzzPkHFmSfA4U7qCn2QRaX46sQ1uaEjKmooPPmoTpW2lt04hoADOzZEtm6Lg5WR5qYM7RllO0J9pV923AdQaaRouW2ynNtwdYvSKvwlyFysi1ufiJC1zsKdPv+QA7Q1o1p2QLoGwDI7CDb91M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KRHWKqIA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a962230847so19352275ad.3
        for <linux-rdma@vger.kernel.org>; Sat, 14 Feb 2026 23:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771139409; x=1771744209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oiLAHDVjSxKvSNOVbOnL+dTEI9S7sddzZ4pZsSNgz2s=;
        b=KRHWKqIA+Hwig0I2wXjTU+5im9uiaI6UvWHqlorLRby60XvL9xeecMbX0rGZVYE2hB
         ZHEcSSiRWfVVf8TLkZP6hXvZCoJh31ufNfiWbOIvPDWUGCzOhlLO7Y/QY+TIwObn5qMX
         3bjGH+o7SkqovpUQJq1ZPrih3DTe8Bn59uz5I+TDVaBibDUJXxOZRI9yaYk6Tnftj7MM
         eELB4Or1lz4gn+oF5k0s6YomvsNEI9ZWo6y/YKQygCl8pRHvUJiWmOr6kJNbPqg01+rS
         0jNbR5CvE5byP3UrsR6gST/mnlXl4+R9HDZ94NgySffWmOsXJxri8BqfyBhT0bSrR89X
         zArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771139409; x=1771744209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiLAHDVjSxKvSNOVbOnL+dTEI9S7sddzZ4pZsSNgz2s=;
        b=HmCTSIS4tj24XucHlfH8swo5L7kX1KgjobyliazL0gToPJLNMNBUBBmlG9kIXNotc3
         LPxjnOTESOYD5DBhqhZzBtYsK8dOpLXkfJA3kp9M1hA4BXUptR7FpNeMOu4a/A0Sbogm
         iPHRwiGqLqzHWi8+4/JBD71cL7bZ0W1m1KYTy4oBh88yPNhr1fbSOI9xVQ2oD+nFnLha
         nZxD0NCYRk1VqLvDXZUPus5ULMlIQRBgTZrxx8+n/jjzHUCAosrsRFiwQKA+sdKt8dDR
         M1jH63bdgIvkGxelf+OlX5pLAEDXuULj43XM6amfJYf/Tq/gbY1Ph3H2BBU9ft8716O5
         mn2g==
X-Forwarded-Encrypted: i=1; AJvYcCVgJ3tBnJsb/fwh+jyr/9wbIJmFMHPJVSEQz0JGZCZBBPTMAv77KJnlTeuvtDV28kB+bM6gNiC1P9an@vger.kernel.org
X-Gm-Message-State: AOJu0YzLU3erxlFLcHQLQ0ASOG7MRXr41JcR01MgtSNKhH+9jCnTXa0s
	cRt13AlQ0AgAE6OZWRwKgrQ0wgEnWu43c+bRcW7z57TqQOVK0IRD3jFt
X-Gm-Gg: AZuq6aJAZ3OW/fGHC8jjcuYNUFz9xRXI9deMJkMuOWw36jMxQ+oSD3Gfc5A0ssQYSWx
	MuWMDfOsvXtQyoPRiUbaq6HEZLCAjWqys+FkJPcDVNdW3GUjohYInfoHvI/bWsVwzHZ9rLxQOPD
	3I+L/wFAuMuW7bgQ/BhlupQytka8CCful7eObZWlcPkXKIIlURAgo3HBLa+BfZM8uxsLlWpgC6r
	TwR0qqzWWta0+FQVJVhTdMS27DQ27a/Pvq8Oc4YokO/d8gLfjbiLikRh1c1Ghd1m74Fhdk9KT75
	LUPdc0mhw5SZrOL+1jCZzzl87RpLA5mPnSKYlmEeuDmRdEXnVqk695RwgxZxu85fvf9R+pSq/Xj
	BlQy8C9Ty6pSHpdOwPCedRnHwZxN94QSESKFnLFE7Fa//y79jAqBAYc0U+z3KRzTfIqOIjD0aUZ
	tmhBk7nKWuiem9tPuhKAGKnkIh6qiL66gsfLPfgzgBrZGMrfAU+v6v/Gl2dYMf+QkFCtZCf9i2
X-Received: by 2002:a17:903:1aa8:b0:2ab:3ac6:8cf4 with SMTP id d9443c01a7336-2ab50598c3amr85915995ad.31.1771139409427;
        Sat, 14 Feb 2026 23:10:09 -0800 (PST)
Received: from tabrez-VivoBook-ASUSLaptop-X513UA-KM513UA.. ([2401:4900:93c4:3183:ba57:8db4:ce19:5f69])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5bd3sm35445595ad.44.2026.02.14.23.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 23:10:09 -0800 (PST)
From: Tabrez Ahmed <tabreztalks@gmail.com>
To: allison.henderson@oracle.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tabrez Ahmed <tabreztalks@gmail.com>,
	syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com
Subject: [PATCH net] rds: tcp: fix uninit-value in __inet_bind
Date: Sun, 15 Feb 2026 12:39:50 +0530
Message-ID: <20260215070951.213341-1-tabreztalks@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-16892-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabreztalks@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma,aae646f09192f72a68dc];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: C72E513E301
X-Rspamd-Action: no action

KMSAN reported an uninit-value access in __inet_bind() when binding an RDS TCP socket.
The uninitialized memory originates from rds_tcp_conn_alloc(), which uses kmem_cache_alloc() to allocate the rds_tcp_connection structure.

The structure is not zero-initialized, leaving random data in its fields.
When the networking stack later tries to bind the socket using these dirty values, KMSAN flags the uninitialized access.

Fix this by using kmem_cache_zalloc() instead of kmem_cache_alloc() to ensure the structure is zeroed out upon allocation.

Reported-by: syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=aae646f09192f72a68dc
Tested-by: syzbot+aae646f09192f72a68dc@syzkaller.appspotmail.com
Fixes: 70041088e3b9 ("RDS: Add TCP transport to RDS")

Signed-off-by: Tabrez Ahmed <tabreztalks@gmail.com>
---
This is my first patch. Any feedback is appreciated!

 net/rds/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index 45484a93d75f..04f310255692 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -373,7 +373,7 @@ static int rds_tcp_conn_alloc(struct rds_connection *conn, gfp_t gfp)
 	int ret = 0;
 
 	for (i = 0; i < RDS_MPATH_WORKERS; i++) {
-		tc = kmem_cache_alloc(rds_tcp_conn_slab, gfp);
+		tc = kmem_cache_zalloc(rds_tcp_conn_slab, gfp);
 		if (!tc) {
 			ret = -ENOMEM;
 			goto fail;
-- 
2.43.0


