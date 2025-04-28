Return-Path: <linux-rdma+bounces-9903-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A460CA9F9BC
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Apr 2025 21:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05AFE46451B
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Apr 2025 19:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB622298CB5;
	Mon, 28 Apr 2025 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEKO+NAz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A046D298CA9;
	Mon, 28 Apr 2025 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745869040; cv=none; b=cQzseyvqdLbPYA6FYgmIf64cQI17+CvSqOpWSye9/nrzA0DaCwuocmMWkvjSpwEDsdtd0VlIevU40tjjnbdPAqjz2qlqanXkAGm1cgFPAEM3ULQwWIaIoGtDzuxw7axydxLdz1z6B7S7B72g6L1ysDDl1kQjFXKt19Ev0P7UF28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745869040; c=relaxed/simple;
	bh=FdNOVqM2wufEPTEaMYSY2Fe1aFMSrIIMSjSawo4+CJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIyVsQc6h+bp/4NqGERG6YQSTspbPwb4ZUMEghxJvPXPoNvnptfoQRBbGCWOcl2deOpgOtX85zkB/4AaTegP4LP+y+W7JLgAhwSG687mPRqUySOFa7ChPZhi4pKdHoNkGujCFZULQ++8VxcutASgy9IVdw14VxSjwQdTStqmcII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEKO+NAz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9E9C4CEEE;
	Mon, 28 Apr 2025 19:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745869040;
	bh=FdNOVqM2wufEPTEaMYSY2Fe1aFMSrIIMSjSawo4+CJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MEKO+NAzFHe0wsy8xP5tZ6Qe/Qc6UUeiMRGSUKkO/nWcZcmZRJHPvYq+C/+QvMq6F
	 O4GFkyZd8JcmLyflUaqS6QQM7Lpg54dzb5qkHs+UJPzuhqzYMMt5DrzDxCDRTn0MV8
	 1K6C9CW4TeIWzrDeCyglQ27/ogF3s5rekmn8xCrudmOhse76s1ZEErkdBZ8fMJK2sR
	 58qYGFKw8hT43FbNKPOfeXNoMxf2w7mSd/RuyjeTZgBam5LJ+PtRGcW7kL+uBNujno
	 Hy6u0Am0AGFZZKQLpGX07rKje9X3lGGP9gYU5qAJkiOlTY6hlG0v6ZzunN2syKglxk
	 QDe4sQhEGq3jQ==
From: cel@kernel.org
To: NeilBrown <neil@brown.name>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Anna Schumaker <anna@kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v4 14/14] SUNRPC: Bump the maximum payload size for the server
Date: Mon, 28 Apr 2025 15:37:02 -0400
Message-ID: <20250428193702.5186-15-cel@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428193702.5186-1-cel@kernel.org>
References: <20250428193702.5186-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Increase the maximum server-side RPC payload to 4MB. The default
remains at 1MB.

To adjust the operational maximum, shut down the NFS server. Then
echo a new value into:

  /proc/fs/nfsd/max_block_size

And restart the NFS server.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index e27bc051ec67..b449eb02e00a 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -119,14 +119,14 @@ void svc_destroy(struct svc_serv **svcp);
  * Linux limit; someone who cares more about NFS/UDP performance
  * can test a larger number.
  *
- * For TCP transports we have more freedom.  A size of 1MB is
- * chosen to match the client limit.  Other OSes are known to
- * have larger limits, but those numbers are probably beyond
- * the point of diminishing returns.
+ * For non-UDP transports we have more freedom.  A size of 4MB is
+ * chosen to accommodate clients that support larger I/O sizes.
  */
-#define RPCSVC_MAXPAYLOAD	(1*1024*1024u)
-#define RPCSVC_MAXPAYLOAD_TCP	RPCSVC_MAXPAYLOAD
-#define RPCSVC_MAXPAYLOAD_UDP	(32*1024u)
+enum {
+	RPCSVC_MAXPAYLOAD	= 4 * 1024 * 1024,
+	RPCSVC_MAXPAYLOAD_TCP	= RPCSVC_MAXPAYLOAD,
+	RPCSVC_MAXPAYLOAD_UDP	= 32 * 1024,
+};
 
 extern u32 svc_max_payload(const struct svc_rqst *rqstp);
 
-- 
2.49.0


