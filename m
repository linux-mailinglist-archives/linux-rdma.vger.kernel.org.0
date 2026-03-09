Return-Path: <linux-rdma+bounces-17834-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AYTHLBAr2mYSwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17834-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 22:50:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C65241E10
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 22:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33448302F696
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 21:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E3336C0D5;
	Mon,  9 Mar 2026 21:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUjyMEC3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7D5368946
	for <linux-rdma@vger.kernel.org>; Mon,  9 Mar 2026 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773093036; cv=none; b=qyKGpd6GV7qeBwqhgEBMiOmeSlVejbpcNLh1rWfgsG3Ya0ZFSgSsLQ5/ZIj6h3GSxekU4cK5QcKxCefWP4WriTSxJ1W8rgYQzQM/IwFoGoeUVym0ktsfvDzFh8SLsj8SfULn2/WP2sKATClA+mccvgkKzC85FigHqr/zerjMDuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773093036; c=relaxed/simple;
	bh=KJyXEet6xJj0/0csTgzMps3eqDK9IIlz5TUeb4D4J4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q/dUEUbEAUJlrH7LEyefeezICEfSmnUKcYB05hGH/+UvQtrmrJ54TB8zfoPZiV94RmbH/ng4u4GDbDxEP26klJvS7B+7631Y8PXEiyT5Oy3BcyaPBbK95yFpwjy7E5+8zaFU3ajq6ZwBF8JhLQaiXGrIjrHkkxqY2ic9J9fXoQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUjyMEC3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso52748605ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 09 Mar 2026 14:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773093035; x=1773697835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QTY4i7aeXKfbHquJ+rcm7OzJCRSbjkbZD8dGXcOQFQ8=;
        b=iUjyMEC32z4kNFjtq7nZeu7aDX/wnMpJ3/TUj4/dxpFlcoBtaDxom4/UIy8dSU3zzk
         Aov3oGsGBL4kMUBqa99GjsOE7j0VqVYLZiYQGchEyI66t+6gmBP4utUj1me+p7oq5oQj
         yHaE5yEcmjr1zMEeJG1v20byDWxmMht4LUxVnDTVPVcBWNdBfPyNU3r3EU/71INJ+MCG
         KdYb5F/RgIGFrG8tdBXxdBkICS5OXF2xC8ZEAhb+2AqGXb61qhaTYLan4tnEznhFQE3Q
         oW7QXyWbodoM35IuRIEaqNpb1OMzbZwoidFX6Rpok9AjppJYa2B9VYOyaHE+s/bsvLgL
         R5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773093035; x=1773697835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTY4i7aeXKfbHquJ+rcm7OzJCRSbjkbZD8dGXcOQFQ8=;
        b=PQBqC4doWeOBe6Pi8C4l4vY7V2E9sfrVnn149Dqw8RoBJwFQZOV6A8b3uWy8Wnzjyl
         h02i+rBwsrbpelf2zn+eL5TgIG6pSEwXMeG63k58KZeeJuOvqoUUkQe2o5EjOZHZL2Ej
         FgcssSME5L8ZmR0/F4vlRhFF8/zwiwlIv5sHJGfNgvbhpCfu3aeTFvNHD7oDvj4HT9LH
         7GGJuwv9pEsfhDzKM3HY0xlqGEkftMjbRjkYv86YDiWxNk9A5Lpm3tliTK4UezAumJkN
         SP9uejM6HG1Z+1TRXn9OTW3yY2NvcoNd6ixXx5syg/oZwTdTYucEcJvRElAL7y3g+HFO
         kNOA==
X-Gm-Message-State: AOJu0YweVThj/dXWAkH6XXMMq6FhBNDLtzAkoQjFltvVWTxJfIZ8XVDt
	Pw0rph58o/uxRqgMvKysLv5ngG1ZXAjaB4S61O4W7nPKXnIvHLXVxnMwZzn9+1tDwsY=
X-Gm-Gg: ATEYQzxcZma/ib3h7v3o04YMKP9yyLz8HYm1IKFpfUIEImdGCXsvqyDzJDFdiw5HQsD
	GXliPEDuDTAqTT4VQQ2rpg0Mip8lBXvYq+OBzIBMR4n8glIidZVinJTYkI4ehFjVwKkyKCUA9SF
	p3ogY4EIc7UGoBJ3Qthgr4s6vWTGdL04r0Ei/uto/ewvu7GjFBfrQCmJ8qtklJIhIsIbQcFQs29
	0K/uuGLjpe76yb7jNihday+BEtlj8t60M8YOwytBXIaa/WiQF+ByoFoa8mOIU6O2rWixmEW31xR
	CwNcxpL0vEa+yTOaOFcsUGacvX0f9xw2PxCrLgQlw1ao9jjhX5wn5D3QDI0JWXjOelP5L28Dbsw
	ThVSIk8nlmhWhbzNuvCDCMvWuS5G2t9zLQtYYJ141KdoM1C3scKziDK7K82PXsaqZwiz2AT1QEE
	SsicLKEnVLvOoJdO/bkn0qxUigH4taiepsjOE7TRvpIsA7JU7DvZ1T+UWMFLGy6P4W
X-Received: by 2002:a17:902:cec6:b0:2ae:5345:89ef with SMTP id d9443c01a7336-2ae82432e95mr135453295ad.26.1773093034825;
        Mon, 09 Mar 2026 14:50:34 -0700 (PDT)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae840ad74asm171963095ad.78.2026.03.09.14.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 14:50:34 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-rdma@vger.kernel.org
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-hardening@vger.kernel.org,
	gustavoars@kernel.org,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] IB/hfi1: kzalloc to kzalloc_flex
Date: Mon,  9 Mar 2026 14:50:17 -0700
Message-ID: <20260309215017.4753-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E4C65241E10
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17834-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Combine kzalloc and kcalloc with a flexible array member. Avoids having
to free separately.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: rebase
 drivers/infiniband/hw/hfi1/user_exp_rcv.c | 9 +--------
 drivers/infiniband/hw/hfi1/user_exp_rcv.h | 2 +-
 2 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.c b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
index a916fe0118b1..8b50a2ad792c 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.c
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.c
@@ -257,7 +257,7 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 	if (tinfo->length == 0)
 		return -EINVAL;

-	tidbuf = kzalloc_obj(*tidbuf);
+	tidbuf = kzalloc_flex(*tidbuf, psets, uctxt->expected_count);
 	if (!tidbuf)
 		return -ENOMEM;

@@ -265,11 +265,6 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 	tidbuf->vaddr = tinfo->vaddr;
 	tidbuf->length = tinfo->length;
 	tidbuf->npages = num_user_pages(tidbuf->vaddr, tidbuf->length);
-	tidbuf->psets = kzalloc_objs(*tidbuf->psets, uctxt->expected_count);
-	if (!tidbuf->psets) {
-		ret = -ENOMEM;
-		goto fail_release_mem;
-	}

 	if (fd->use_mn) {
 		ret = mmu_interval_notifier_insert(
@@ -447,7 +442,6 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 	if (fd->use_mn)
 		mmu_interval_notifier_remove(&tidbuf->notifier);
 	kfree(tidbuf->pages);
-	kfree(tidbuf->psets);
 	kfree(tidbuf);
 	kfree(tidlist);
 	return 0;
@@ -470,7 +464,6 @@ int hfi1_user_exp_rcv_setup(struct hfi1_filedata *fd,
 		unpin_rcv_pages(fd, tidbuf, NULL, 0, pinned, false);
 fail_release_mem:
 	kfree(tidbuf->pages);
-	kfree(tidbuf->psets);
 	kfree(tidbuf);
 	kfree(tidlist);
 	return ret;
diff --git a/drivers/infiniband/hw/hfi1/user_exp_rcv.h b/drivers/infiniband/hw/hfi1/user_exp_rcv.h
index 055726f7c139..b4a309a051f9 100644
--- a/drivers/infiniband/hw/hfi1/user_exp_rcv.h
+++ b/drivers/infiniband/hw/hfi1/user_exp_rcv.h
@@ -22,8 +22,8 @@ struct tid_user_buf {
 	unsigned long length;
 	unsigned int npages;
 	struct page **pages;
-	struct tid_pageset *psets;
 	unsigned int n_psets;
+	struct tid_pageset psets[];
 };

 struct tid_rb_node {
--
2.53.0


