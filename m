Return-Path: <linux-rdma+bounces-20530-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLudFxmiA2qe8QEAu9opvQ
	(envelope-from <linux-rdma+bounces-20530-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 23:56:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7C652AAD0
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 23:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 353C930ED401
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 21:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34546397691;
	Tue, 12 May 2026 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dp5/9DON"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980D6396D09
	for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 21:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622939; cv=none; b=tRNna67ONcWmh3lmD2+RT5PXEumlu/gprwUxRVYI/Uqp+4ko8Lfq7Rt/6+BmAyLdJqCFtj8TWzRQVF7VsXWGnxjykT8w9UA48wyb3p7x6pH+aaLNm4lTHPJRrSrefMrZyR8vfA7fO/csH6czVmBw/oDzVCy2p6Op3JQyWtgfom8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622939; c=relaxed/simple;
	bh=TfUOE0sRmfRl4WaBLqCiwhevWqhrNiAtWeKBAdeEEFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Whhi6F6+to0zKfLThytDspLMpRp5SExxCtvhFGMev9Myr6qhkJe9yHPjB+BjbsmaV6vr5N7QTHVX9uzDUuxYFqAeaA96Q58erGCf8RMNNjRbd4YHYifJP3Gg8VsI9WOX2J7X8GLerm/j39VofUctw8Oz4Kk+8pE1LbAECQuWNWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dp5/9DON; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82748257f5fso4441512b3a.1
        for <linux-rdma@vger.kernel.org>; Tue, 12 May 2026 14:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778622938; x=1779227738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ya6QFCZNOXzUKI88H0bBRc+s+eKBTyGQU2y8sYXv9o=;
        b=dp5/9DONYIGw6HZi07IarNl/mwDilc192b7C+fJZs+cdloEuuscOfTbOZjGVXaJ460
         s7EnWBQU+oqsFOOQjGkPnocf8mN17mhzmC193yr1h1h78aAGLzQzNiCKZZIN4dZVJJwY
         8SBSJVd7GqWNt1ENIVMi0ak7KeQkoKOaW1ccD9T0ZeT7LcfwnUqwcSq/u5DdZTuZDUzc
         qLjoIBEP2zOMT2ZenNfwwMdNHnjyWmMdsgaKMKMM5n2g5phSNnl2zvWeTKEZG7AM1Gfw
         QWgIhB6RlvROZSEItKVDEBZaRe3i8LLvEy8bLvhISz6lo6SMuWoWmmKWq4JUvLLuFHR2
         iMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778622938; x=1779227738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ya6QFCZNOXzUKI88H0bBRc+s+eKBTyGQU2y8sYXv9o=;
        b=jHTTg0Ewy05XAc6feGEwJ8GPPisRUPNC8fh0ylD0UW0brCOpYNTXuAQC/z5VT+psLE
         SXvpbMRXBVExiJU7mYULCfhizvYcwuPTuI8BqF8h9qOIN8sLJHiHjFY2zMxHCoMny28N
         Igrx0nP09Pa8hasPGhvmBdcRVAVfgehx45Ab6HjF3JAZ6RqCW6lEvUB/mg3UFBKSSxtS
         aCyIAKUbyDFJ5t+mS+3J4LGQVI9mcMvxHttDCtPzTKHl3ZVhpy3fah+iCGzvfSU8hFc8
         zo487mFY69UPdBMQuVfxwhjfOTkuypLbMGh9P0/tWyUSWxlEBHv5ePxjpi6VY7J4evnM
         v1Dg==
X-Forwarded-Encrypted: i=1; AFNElJ/DbYoOh9RJtSZL6AyC9nE27w2ufFtjnFFpOfQEymtjnNLnqNPppqRarWGG/hfi7i2i32NYhfOZt15l@vger.kernel.org
X-Gm-Message-State: AOJu0YxdZXJ71n8Iw7EVVN3qBK5ewGBwvsJ3Yobn7gP5j7BhN290pwko
	14RgPY7qVUKRPdTy/sMS733YET8TcOxHbPlu6sOh0s/sANE9pq4Rqx96
X-Gm-Gg: Acq92OHV2WW6n/3vgDSDXJ5hIYYfdo8Uv5m5krwuCnq0eyStv524noSBTK4t4kx2vXa
	nJErsBXLa1U6zW6LtYaqvmiJpL0ug5HWoY8xZfzsMFjUFGKyCO+gsFvauZPYznCTQDw1bIVyuwz
	Q9XE7tCsYdtFYgwCBRSXQ1NW/a4ELK7IVh+vOutuS3+tuE/qxzXPU6B3VBIPIU8r8aOdL8Ws8On
	lUrNhP9DLidViVKsdBKYN2TeKo5zQo07TTyIZdcnk1kUgkjFTJD1NI+dZeVyu/ie1F+r+L6E+jw
	8PsgwsNPxnNgrnklmdv2O5wI6f+rKMPfuQa1ywBthDjNuwawz0FWI2+Tu4r2GLJZwmVQUN/J5ue
	wGxKXrCF56GjSljPzRKp0s1pm2VbTMnZvRJLrTFo/xdth3JtzP4gpNSEDZuIrAbc1yd1kDSp4E5
	QQJAc4tQHoJqz7zJgLp2y9c6fvXvBKppuSvqlD4UoKzunf1Hnk3ZU5QIU2SPkyav+kk9grR6hQ
X-Received: by 2002:a05:6a00:3a14:b0:835:447b:a2ac with SMTP id d2e1a72fcca58-83ee82d6237mr5485143b3a.5.1778622937778;
        Tue, 12 May 2026 14:55:37 -0700 (PDT)
Received: from r912.lan.4v1.in ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682abd39sm25100038b3a.52.2026.05.12.14.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:55:37 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: netdev@vger.kernel.org
Cc: achender@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] rds: tcp_listen: fix typos in comments
Date: Wed, 13 May 2026 03:25:31 +0530
Message-ID: <20260512215531.1988662-1-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BC7C652AAD0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[avinashduduskar@gmail.com,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-20530-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Two typos in comments:

- "reconneect" -> "reconnect" (block comment above
  rds_tcp_accept_one_path()).
- "acccepted" -> "accepted" (block comment inside
  rds_tcp_conn_slots_available()).

Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
---
 net/rds/tcp_listen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 08a506aa7ce7..a3db9b057084 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -69,7 +69,7 @@ rds_tcp_get_peer_sport(struct socket *sock)
 
 /* rds_tcp_accept_one_path(): if accepting on cp_index > 0, make sure the
  * client's ipaddr < server's ipaddr. Otherwise, close the accepted
- * socket and force a reconneect from smaller -> larger ip addr. The reason
+ * socket and force a reconnect from smaller -> larger ip addr. The reason
  * we special case cp_index 0 is to allow the rds probe ping itself to itself
  * get through efficiently.
  */
@@ -143,7 +143,7 @@ void rds_tcp_conn_slots_available(struct rds_connection *conn, bool fan_out)
 	 *
 	 * Doing so is necessary to address the case where an
 	 * incoming connection on "rds_tcp_listen_sock" is ready
-	 * to be acccepted prior to a free slot being available:
+	 * to be accepted prior to a free slot being available:
 	 * the -ENOBUFS case in "rds_tcp_accept_one".
 	 */
 	rds_tcp_accept_work(rtn);

base-commit: 73d587ae684d176fac9db94173f77d78a794ea4f
-- 
2.54.0


