Return-Path: <linux-rdma+bounces-7870-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B5CA3CC9D
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 23:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570573AB39A
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 22:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCAB25A2D9;
	Wed, 19 Feb 2025 22:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V4ghLR0m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD68A2862A1;
	Wed, 19 Feb 2025 22:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005296; cv=none; b=rFYr9U4z65xnE9Tgj5g1+HLeXypwEcO3Ngb4Alc2je9EADB2ybj6m3Hx8lx/u/N8PMnqnkVTu8PJPXrDc+lMHr6pgfYN4MCHjhyEQ+b/5vTgcYpm1ciJOZVIJGArD27f87IT42Jm7+8ypo9noVMi2fKMx+kWrKbx0eEbJaGleYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005296; c=relaxed/simple;
	bh=fCP3McsTMgJpNvyO66Y1RDO2PBxT8DfXrv1mDnhT144=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tUC3uKap0APJQKd5ouPzk/NUuv9ZjGOUZT+o3hE+n9klLRNBQmIC9dlAp1rPJQD45x9jXniLM9U3YzIEqzbbd9Ie98l1gjGd7QkiS6iS3Wx9LO86+OPIQqafIHP737A4qdhOnpPqcdTMnDGomuB0oEfUpEudzvTNoeZjK2GNuHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V4ghLR0m; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740005290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FLdeIOJ0cVMGZIjfbYqeq+xUkR3G/JMvqLqXwcOF0l0=;
	b=V4ghLR0m45eDcc94yDrbhYON7qv99zvqE13vyqGrAiIomZ4mP3PlIEECjP1k4V7Kkt6YSR
	vppS57+aUj1hrXGxomSeMg7pT9LVl1UQ9/CNY3RHS/m3QHGwNZlEdcvegG4ty1hD3LZhPY
	bJnCb6ZGbv5BeNeLaofWA/L6uLVZrp8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Allison Henderson <allison.henderson@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net/rds: Replace deprecated strncpy() with strscpy_pad()
Date: Wed, 19 Feb 2025 23:47:31 +0100
Message-ID: <20250219224730.73093-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() is deprecated for NUL-terminated destination buffers. Use
strscpy_pad() instead and remove the manual NUL-termination.

Compile-tested only.

Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 net/rds/stats.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/rds/stats.c b/net/rds/stats.c
index 9e87da43c004..cb2e3d2cdf73 100644
--- a/net/rds/stats.c
+++ b/net/rds/stats.c
@@ -89,8 +89,7 @@ void rds_stats_info_copy(struct rds_info_iterator *iter,
 
 	for (i = 0; i < nr; i++) {
 		BUG_ON(strlen(names[i]) >= sizeof(ctr.name));
-		strncpy(ctr.name, names[i], sizeof(ctr.name) - 1);
-		ctr.name[sizeof(ctr.name) - 1] = '\0';
+		strscpy_pad(ctr.name, names[i]);
 		ctr.value = values[i];
 
 		rds_info_copy(iter, &ctr, sizeof(ctr));
-- 
2.48.1


