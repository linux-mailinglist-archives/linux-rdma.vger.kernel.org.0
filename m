Return-Path: <linux-rdma+bounces-21935-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z2gpOctLJmoQUgIAu9opvQ
	(envelope-from <linux-rdma+bounces-21935-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 06:57:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABA3652AA3
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 06:57:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=X5wuAm8T;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21935-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21935-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1886A3012254
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 04:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC2134E75E;
	Mon,  8 Jun 2026 04:57:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461682E1C4E
	for <linux-rdma@vger.kernel.org>; Mon,  8 Jun 2026 04:57:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780894659; cv=none; b=fUqErGiwtZ4rLNtxF2y4mshS7mPtDEckcObGvv4jPuMbroh1+RrtJRG7Ln0p/wfzD/oHzyq21SmCHdHToD7PbFrtvu1DQt9B9N/AZDQILfvUKTm9gOOG2nLohZ6NidmjQeISTzlhCtAKNpUREQQKrVfW3k3WW29+MqQbd/Ilhfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780894659; c=relaxed/simple;
	bh=0A3KHx2mKPHlSf40g8+U+xz+PqAjs3NFoDAZ6XUZO/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ET3IvGGrAzlbN1mEFJEIsJ0r/dQYjbh66Ile5NPn+SWt3j5W8QV4pZFAJheq5tVnxmUc52PgWhGzRZkwYZEulEOC1zKpha5R1ijT3rD+aP5IefwKHTkPCf6cK6BWhIhSafXmCkEip3AuQcWK1Dc6vbzTmR9uY/4gwzzrB634DoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X5wuAm8T; arc=none smtp.client-ip=95.215.58.172
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780894656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s+jscFRq0B8T5sj9vG4rO0OZX02mZxthqE09ofHdnO4=;
	b=X5wuAm8Tq8B5RpCjRyWcqusbA9JRQPUOxCr2D86zPMlS4IdEG7P39c1yXmMtOnszFBym8r
	uJ//XZzo5ec2X6vNkF7DiASviN44yEXc9RhuWgLDgd/zVeTcuYzNDxpC38GJ0mrKra7nRs
	+sbzOwHy845kj8jrNvf7Co+z7nWObTM=
From: Tao Cui <cui.tao@linux.dev>
To: leon@kernel.org,
	jgg@ziepe.ca,
	linux-rdma@vger.kernel.org
Cc: Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH rdma-next] RDMA/core: Fix FRMR handle leak on push_handle_to_queue_locked failure
Date: Mon,  8 Jun 2026 12:56:57 +0800
Message-ID: <20260608045657.2715472-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21935-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:leon@kernel.org,m:jgg@ziepe.ca,m:linux-rdma@vger.kernel.org,m:cuitao@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[cui.tao@linux.dev,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cui.tao@linux.dev,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:mid,linux.dev:from_mime,linux.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3ABA3652AA3

From: Tao Cui <cuitao@kylinos.cn>

In ib_frmr_pools_set_pinned(), after create_frmrs() successfully
allocates handles, the push loop may fail partway through due to
-ENOMEM from kzalloc in push_handle_to_queue_locked(). The remaining
created-but-unpushed handles are silently leaked as they are never
destroyed.

Call destroy_frmrs() for the remaining unpushed handles before returning
the error.

Fixes: ce5df0b891ed ("IB/core: Introduce FRMR pools")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 drivers/infiniband/core/frmr_pools.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/frmr_pools.c b/drivers/infiniband/core/frmr_pools.c
index 5e992ff3d7cf..d7906fab033f 100644
--- a/drivers/infiniband/core/frmr_pools.c
+++ b/drivers/infiniband/core/frmr_pools.c
@@ -443,6 +443,9 @@ int ib_frmr_pools_set_pinned(struct ib_device *device, struct ib_frmr_key *key,
 
 end:
 	spin_unlock(&pool->lock);
+	if (ret && i < needed_handles)
+		pools->pool_ops->destroy_frmrs(device, &handles[i],
+					       needed_handles - i);
 	kfree(handles);
 
 schedule_aging:
-- 
2.43.0


