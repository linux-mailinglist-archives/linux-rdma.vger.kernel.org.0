Return-Path: <linux-rdma+bounces-18723-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IpNGJH0xWnbEgUAu9opvQ
	(envelope-from <linux-rdma+bounces-18723-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 04:08:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C542133EACD
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 04:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 166CF30459DE
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Mar 2026 03:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29C7348879;
	Fri, 27 Mar 2026 03:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTdW/sg8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0A7347517
	for <linux-rdma@vger.kernel.org>; Fri, 27 Mar 2026 03:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774580504; cv=none; b=kBzAS8DrJzFle6JlHSoIZgzuMtgnnKHk7P56PxfcjDpGbHc9PniOmMPf29FecUD/7WNS8sB7c9PD3Q5cO9+qUA8xx2QHR9/uv1yyNmBsV881JcrG79XJ49p2R0jqOXW69PvLkhyo3qqeXNKm1PO7JYrqHlZ2f5aftP9ZXx3HfcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774580504; c=relaxed/simple;
	bh=VHq0T2QBVW1p5Prt7mcDtEz31yyWzofOyZqE5hZN2Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aKQDOz+2z42vuVI/yBoW24+qbNauwz7vvMA8eJaEjUAcfJ+Ls0WzCuvvza26R5imu5FbxiONXfBm+7eL3gB+W8XGZcAIJCPmOA7GQAJsFVDUmR5xqbgsevyXy7g2R7oxxcClpELsT3dLc76x3rImj4sujP/Wm2ZQ5fOXQJz0A3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTdW/sg8; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so1099975a91.0
        for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2026 20:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774580502; x=1775185302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lYnk1jno8htp2F2GI4xAOL67IOVcynZ8tz2xKscYSYM=;
        b=hTdW/sg8UJho5IaEI+giCWMySJ3kMNQJnQSTkdslI23aU0tyOeehRguvxpx1diZmby
         3O7ILBVmL05J06idPLqa+PcUnce1EYGgg4Bs77lQK0/weCeLq8BP2/amo8wfqVldUECQ
         3HH7qd30fjkFS4HvXWM40+6Ub9sL9QplSHzqlaEZodBpz0GxybytmJVmJE4xdl2xRjlA
         3uUwSzjJ1AvH9Wg9sR4f/ilY4ut8PF5RH+EI/yla9WN3It/c/oKzG1a7YQPl0osnkBFM
         HrCgXjf+PqtJL+7v3y3BJND1OHnto0kZjn96U2Fic1ydu7h5fIVrmKrm29r8Ms2+KWWh
         TrpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774580502; x=1775185302;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lYnk1jno8htp2F2GI4xAOL67IOVcynZ8tz2xKscYSYM=;
        b=Kd/7P44RLPKAlfvmtstggc+Gh4akTdBoyJJeU9lwn0g78I9NbfsaJ6nPgrtt4DdTOA
         HPSK3Q4GuGFlNbVuVPjFjzv8TmnK15Zu5ruw3bFOaIBfR3o0h9/0T4zHCHKJF3F69bJ/
         e8BookfdtW9UmcYOjsWbsV41KH4YTeLAU89kZLFz2ZPADj7KAE6sUEsryEa9dgnGsBNc
         eEcV/fApogBw8O1jFdBEG3w5xhZr4RA6zNTVMafsJmC9aQfGePcGewRrsW+pqtRYXVFc
         Q1tr1NRhX0J9qdqFGUBp9rQr1453ovo8rz2v6ODSdYDpWexm1xxqjMtxCLXTAtF03FUE
         9xhw==
X-Gm-Message-State: AOJu0Yw8FSczxaNC6DTSgLhQ01fDUAaVm0RO3hDaIHxySweUZmpzaVPB
	LZUhaKyrsmKTKVle86Ilg/GFbIrIxLmmZn7qVsgxootbrw2ITSzDEGpLiV7oW4dh
X-Gm-Gg: ATEYQzwXk8oKH3aGu1IsZcc+1F+Qqg2i5fkMpV2sswxWYLwP30/B9oNA1McrbPm8vqj
	LuiO6K4rqqmbfbi6xF+6ZWS0ObEW1/0R7ICvDVPHSzugNhEgVqhUSZIcIGifzwUsBXQp4QJhElj
	mJD23usf4377nbxnIpkU13LpitNLmrQzvEjdzKdejbkK1Nb9Hx6vzqDmzMU11CWabOcwlbME+Rf
	yj4eq9wBGOkWAYV/lpz0N36zB9zMF8+LgJwmQzu/sTWhUVWNkcHGi5qMJ625TrvE9ihvhP5UZ6A
	fZWNt1eB14/6Phe9rBLSWMdzvg9Q8d/qHsIIMeOiB+URt+1H4cEBjT1k/BOMxhNnQYtP3RIvc0J
	dw2+ZlKvXIstMcZpfjh5hxDGeaLM4TN1dwm0X9y9T/odrUvUWF8pNVPkblXePjpmHtzEWUbaCQx
	weZQQrukt4l8VmYH2+MGZpik9D4AcdYBbUplRCMOaehr9t0Cf2iwRxzjs=
X-Received: by 2002:a17:90b:394f:b0:35c:f09:a4fe with SMTP id 98e67ed59e1d1-35c30146e81mr837202a91.31.1774580502174;
        Thu, 26 Mar 2026 20:01:42 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22a54ebfsm3208675a91.4.2026.03.26.20.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 20:01:41 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-rdma@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] RDMA/core: use kzalloc_flex
Date: Thu, 26 Mar 2026 20:01:24 -0700
Message-ID: <20260327030124.8385-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18723-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C542133EACD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Simplifies allocations by using a flexible array member in this struct.

Add __counted_by to get extra runtime analysis.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/infiniband/core/cache.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
index ee4a2bc68fb2..896486fa6185 100644
--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -116,9 +116,9 @@ struct ib_gid_table {
 	/* rwlock protects data_vec[ix]->state and entry pointer.
 	 */
 	rwlock_t			rwlock;
-	struct ib_gid_table_entry	**data_vec;
 	/* bit field, each bit indicates the index of default GID */
 	u32				default_gid_indices;
+	struct ib_gid_table_entry	*data_vec[] __counted_by(sz);
 };
 
 static void dispatch_gid_change_event(struct ib_device *ib_dev, u32 port)
@@ -770,24 +770,16 @@ const struct ib_gid_attr *rdma_find_gid_by_filter(
 
 static struct ib_gid_table *alloc_gid_table(int sz)
 {
-	struct ib_gid_table *table = kzalloc_obj(*table);
+	struct ib_gid_table *table = kzalloc_flex(*table, data_vec, sz);
 
 	if (!table)
 		return NULL;
 
-	table->data_vec = kzalloc_objs(*table->data_vec, sz);
-	if (!table->data_vec)
-		goto err_free_table;
+	table->sz = sz;
 
 	mutex_init(&table->lock);
-
-	table->sz = sz;
 	rwlock_init(&table->rwlock);
 	return table;
-
-err_free_table:
-	kfree(table);
-	return NULL;
 }
 
 static void release_gid_table(struct ib_device *device,
-- 
2.53.0


