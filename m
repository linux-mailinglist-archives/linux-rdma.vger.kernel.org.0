Return-Path: <linux-rdma+bounces-21573-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHDkCUdfHWojZwkAu9opvQ
	(envelope-from <linux-rdma+bounces-21573-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 12:30:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5493F61D6B6
	for <lists+linux-rdma@lfdr.de>; Mon, 01 Jun 2026 12:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2DDEA30515A3
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jun 2026 10:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682CF3A7F55;
	Mon,  1 Jun 2026 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="Pc6hM/6u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from outbound.baidu.com (mx13.baidu.com [220.181.3.100])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 7D1A839A4CF
	for <linux-rdma@vger.kernel.org>; Mon,  1 Jun 2026 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307844; cv=none; b=lybwBTsl5GvSYI0eXrErizeJMzhemZx03f4Y2RFJHKHVJ2gQ+h+bTmqocc4I1ZRgYjxZjXcRQ+KpM87E8HzsiPzmPLyXhB3Wy+oWsL0Ys1dsl4GflJxyiddzC872H/0Lj6iXaHTmKnIfCy1arZO2yZoNx0h19NGVLCFPz75kXdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307844; c=relaxed/simple;
	bh=qpJXazSakRU7EIBTCO+qdppk4tr5/Doy2JTZVTJEj5w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oPjxKP9sEzlTGgLj8CwNau1Q4fVTVwTNMxZ7KH0p5+x/NH/kXuoDo6/vcs24AgkTAUbnSOsl6CqQ7RMx7liyZ5SI6P6IhkcAS+ooFlgt6OdZmXwNSM0xNrXfsQl/Yqwpn6BSeCY8EGAv6CmbQm5hiVj542J6rJIGsKLrc/AHhk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=Pc6hM/6u; arc=none smtp.client-ip=220.181.3.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	<linux-rdma@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] RDMA/mlx5: Fix error propagation in __mlx5_ib_add
Date: Mon, 1 Jun 2026 05:56:54 -0400
Message-ID: <20260601095654.2178-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc2.internal.baidu.com (172.31.50.46) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1780307823;
	bh=4l1CL/YqsggT0VsTLVMEkwVa8lE5pSkOFNTvHeYUyCg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=Pc6hM/6uC1y6b+CdpMnEZpiIxfmxfwVSuEKAvsO4o+R2wZv5PbHgNkcI+gMnhoXvQ
	 a6UaoftBuAwbzBuTFl2kFu7m1El/oy3laW7rkrubViBGAPnowpuXZHlqNn3j+26z7q
	 aOAIT87AfFownVH9WJ2cdRU2sWy5Y7+zf6Keh4U6HlpOueY21PDDsnF1GjieeeRXiF
	 IYB1bHMOGvxCwnmv0YUpMw/rQ0ycBHztPduA46e0dhlGwTlRnd8pscSLD+JNRCm5Vj
	 8VD3U6XZIlX2l9qkHadGlW84ZjvSAV9MXPGtyCDs54kGpCvUnA4hMqd+mSyz7XVzGL
	 v5uw3wK1ArDSw==
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-21573-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[baidu.com:?];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lirongqing@baidu.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.898];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DMARC_DNSFAIL(0.00)[baidu.com : SPF/DKIM temp error,quarantine];
	R_DKIM_TEMPFAIL(0.00)[baidu.com:s=selector1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5493F61D6B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Li RongQing <lirongqing@baidu.com>

__mlx5_ib_add() currently returns -ENOMEM on any stage initialization
failure, losing the actual error code returned by the init function.
This makes it impossible for callers to distinguish between different
failure reasons (e.g. -EINVAL, -EIO, -EOPNOTSUPP) and leads to
misleading error handling.

Fix it by returning the actual error code stored in 'err'.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/infiniband/hw/mlx5/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 6107828..c7ae46e 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -5112,7 +5112,7 @@ int __mlx5_ib_add(struct mlx5_ib_dev *dev,
 		if (profile->stage[i].cleanup)
 			profile->stage[i].cleanup(dev);
 	}
-	return -ENOMEM;
+	return err;
 }
 
 static const struct mlx5_ib_profile pf_profile = {
-- 
2.9.4


