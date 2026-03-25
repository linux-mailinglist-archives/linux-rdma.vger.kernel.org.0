Return-Path: <linux-rdma+bounces-18626-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLEYLXX9w2lXvQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18626-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:21:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D634327CDF
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 16:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2611F3112F9F
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Mar 2026 15:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883A64014A8;
	Wed, 25 Mar 2026 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KiZFEGMm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05133F9F58
	for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450865; cv=none; b=Er558Uesyj3BqZakgrGtIsmsGGPE96X2oVnrdA/RmWX7Bi62KACgd+3sVBaI7nVY8RuPINWircB7kvzJsfO3jlYeau+xKtxdmJcCM/E7Xys0suyFJWlaV8DxrwkWn44x/hr2YZDuIOuT/7wSmQ0yL/n4AKBdvcKDyFbDdgAgNTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450865; c=relaxed/simple;
	bh=wmbch1K9E+kNCVw9n4GKC4MaMFBwMVSLpFwliJe9E38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m2MYfKx7WNrTLvlOylvo5qd1j5UTrnm/8a1CNBOQH8ggmTpWoTsiioT8RJ56Vw3PUdUyriqEM11uPXpQTRfKsyE//f0KcrK3XwV9BIWtrFi+RQYtPjbNcboq7nX/rInaZ1pVpJnw657Q29xbDVMiYuBw8hwatG/12PLwzKnXuMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=KiZFEGMm; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43b9144790dso82658f8f.1
        for <linux-rdma@vger.kernel.org>; Wed, 25 Mar 2026 08:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1774450862; x=1775055662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrQeHLNx+y1rnIXp+jvSKudl7h2oBXWememMMXvfaL8=;
        b=KiZFEGMmU+unkrSwDQOM2TR7RsHqLGeBogb9Ukrfkod/bAvmFa7KPfx0u9ksTZGDXn
         BIE1guYAib5sAjUXRwnS8XIYInqzZskkyJMnpCxoDsU4Cs7esYl/dw3SpLFq4w9435f/
         svqit+59ChXDKB/r90lodIOQDxUcqARTWqrDK5KUsIbiRWs594++5OfmljaA4E2ARVAG
         Bhrw32xZYLMK5f6AS3QlC9U99G5YchoOj1XydUZuvGnXIzJuzDuZyYahcYRpy06I42qN
         wIDNqZF3JfD98oCuBLgmFcjJwl707RqSrryNfWubd8rmXYU2bBZeouYDQ0Bx9LSPjdBz
         I0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774450862; x=1775055662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HrQeHLNx+y1rnIXp+jvSKudl7h2oBXWememMMXvfaL8=;
        b=UFpNO/Hw6V8+8p0f9k9rTQU2awXkKN5xhFq7zqxL548S/fvgXo97Q0FC8CtIOr69Do
         b2di4WZjVlFtSp/xZi143VXvd021NkN1q/dflTaMNWd8tO49MNEFx3mcKo0x8eEs42n6
         +DxrGV3DouXG4lFAM4msCckzG6xm2KwQ16QZYEWqqbTFmjT8BDteJY0h+8LJnItTeOQU
         w6poEEemodoWzg3/q6+Si+jLRh+eV1t4HgfuUP9ZW37Wt5RwaEjyhJxaaoFYMuB2H+YE
         KwIYlMQZGhX16gIyP6qHPvWnPs+TJjgkFAS9hef7uyOkE2A2aA7reZaYJlcJiFchxx8d
         0Utw==
X-Gm-Message-State: AOJu0Ywp5fYYzP1rGQ+/BY/CVUge0Vrdz4A5qX07hzCd94di9NWJbj5N
	di6iVk0mKI9VHQo8Baj6ex2VcgMcp+AWMWFY/hXjeisQXWx0JTItNlZqyEnXBw6uax6/g6o6Sk5
	lPKXD3HM=
X-Gm-Gg: ATEYQzz/Ydu6SS4em3Tg8+KER3/5O8/iLLUXSQEMBHR4g882CQ1QtFnwYyZV3z87aUE
	dXCdAynTw4XLdQqF8dyZWIMN9GeHPbZyed/OjYg328oD/c1HifYCj04/r9B1P5B7MdC+TwIa+eB
	Rg0XRII5vdLiIUT0ADviuvftc5Ot4LC9svx9bpk0zUDcMVTD0oESR/geXYnMPdTY3xAab9JgNlJ
	TnkxXBFxDf+Fwhl9f3lsuhlNwAjxC9yCZzxORgPP43Tv0+HILG5LQ/90Lcpy+mYFrs/YN5hTubr
	Xx1TEhgffZI0BWm6dhAEl9yEx3P7LqaBlrOMwYfaTyIv3RfvUrQ6qrV51OFkrDErLNQGvfO6sft
	Vjw6b7mk+FsVn/g24b8fIW0c0rCCPFD5f0qIWWGaNpvleMR5vPlqBXHwZU6j1i4w1Qthd9AD0/Z
	zAaLPk1EwPwyzRAg==
X-Received: by 2002:a05:6000:609:b0:43b:498f:dcf0 with SMTP id ffacd0b85a97d-43b8899d671mr6037518f8f.9.1774450862173;
        Wed, 25 Mar 2026 08:01:02 -0700 (PDT)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919cf2b2sm345389f8f.18.2026.03.25.08.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 08:01:00 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: linux-rdma@vger.kernel.org
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	mrgolin@amazon.com,
	gal.pressman@linux.dev,
	sleybo@amazon.com,
	parav@nvidia.com,
	mbloch@nvidia.com,
	yanjun.zhu@linux.dev,
	wangliang74@huawei.com,
	marco.crivellari@suse.com,
	roman.gushchin@linux.dev,
	phaddad@nvidia.com,
	lirongqing@baidu.com,
	ynachum@amazon.com,
	huangjunxian6@hisilicon.com,
	kalesh-anakkur.purayil@broadcom.com,
	ohartoov@nvidia.com,
	michaelgur@nvidia.com,
	shayd@nvidia.com,
	edwards@nvidia.com,
	sriharsha.basavapatna@broadcom.com,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com
Subject: [PATCH rdma-next 07/15] RDMA/mlx4: Use umem_list for user CQ buffer
Date: Wed, 25 Mar 2026 16:00:40 +0100
Message-ID: <20260325150048.168341-8-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260325150048.168341-1-jiri@resnulli.us>
References: <20260325150048.168341-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18626-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[24];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 4D634327CDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jiri Pirko <jiri@nvidia.com>

Use ib_umem_list_load_or_get() and ib_umem_list_replace() to work
with umem instead of ibcq->umem.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/infiniband/hw/mlx4/cq.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx4/cq.c b/drivers/infiniband/hw/mlx4/cq.c
index b391883aa400..9db58d9bb8ab 100644
--- a/drivers/infiniband/hw/mlx4/cq.c
+++ b/drivers/infiniband/hw/mlx4/cq.c
@@ -152,6 +152,7 @@ int mlx4_ib_create_user_cq(struct ib_cq *ibcq,
 	int shift;
 	int n;
 	int err;
+	struct ib_umem *umem;
 	struct mlx4_ib_ucontext *context = rdma_udata_to_drv_context(
 		udata, struct mlx4_ib_ucontext, ibucontext);
 
@@ -175,16 +176,16 @@ int mlx4_ib_create_user_cq(struct ib_cq *ibcq,
 
 	buf_addr = (void *)(unsigned long)ucmd.buf_addr;
 
-	if (!ibcq->umem)
-		ibcq->umem = ib_umem_get(&dev->ib_dev, ucmd.buf_addr,
-					 entries * cqe_size,
-					 IB_ACCESS_LOCAL_WRITE);
-	if (IS_ERR(ibcq->umem)) {
-		err = PTR_ERR(ibcq->umem);
+	umem = ib_umem_list_load_or_get(ibcq->umem_list, UVERBS_BUF_CQ_BUF,
+					&dev->ib_dev, ucmd.buf_addr,
+					entries * cqe_size,
+					IB_ACCESS_LOCAL_WRITE);
+	if (IS_ERR(umem)) {
+		err = PTR_ERR(umem);
 		goto err_cq;
 	}
 
-	shift = mlx4_ib_umem_calc_optimal_mtt_size(cq->ibcq.umem, 0, &n);
+	shift = mlx4_ib_umem_calc_optimal_mtt_size(umem, 0, &n);
 	if (shift < 0) {
 		err = shift;
 		goto err_cq;
@@ -194,7 +195,7 @@ int mlx4_ib_create_user_cq(struct ib_cq *ibcq,
 	if (err)
 		goto err_cq;
 
-	err = mlx4_ib_umem_write_mtt(dev, &cq->buf.mtt, cq->ibcq.umem);
+	err = mlx4_ib_umem_write_mtt(dev, &cq->buf.mtt, umem);
 	if (err)
 		goto err_mtt;
 
@@ -467,7 +468,8 @@ int mlx4_ib_resize_cq(struct ib_cq *ibcq, unsigned int entries,
 	if (ibcq->uobject) {
 		cq->buf      = cq->resize_buf->buf;
 		cq->ibcq.cqe = cq->resize_buf->cqe;
-		ib_umem_release(cq->ibcq.umem);
+		ib_umem_list_replace(ibcq->umem_list, UVERBS_BUF_CQ_BUF,
+				     cq->resize_umem);
 		cq->ibcq.umem     = cq->resize_umem;
 
 		kfree(cq->resize_buf);
-- 
2.51.1


