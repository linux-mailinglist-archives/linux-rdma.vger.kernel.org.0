Return-Path: <linux-rdma+bounces-20003-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDjVOTOi+WnR+QIAu9opvQ
	(envelope-from <linux-rdma+bounces-20003-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 09:54:27 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9284C851D
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 09:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C72D300DF78
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 07:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419403E3DB6;
	Tue,  5 May 2026 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxkl77qW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A583D16E9
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777967624; cv=none; b=tX78XMw+u4+BQ2XSs0wDMFfS3IKjItkPdQBGaAGo/sQ6JVK8bszbHXDpplRU8T2GCZVlZx/w1Jt1CXT/4T75f7jdzU4YwXJqn09XFwIn5YJDItET849nWonPFbBfoVDAkvUg3uD6f0grmhkun65mHNSLYEtQ1nLksLsQwisXO2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777967624; c=relaxed/simple;
	bh=G7NQ9xK87Vy25GZpSkQxeaDpn5ozStN9LaYzBBcTLRs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jWi8qwCzSzGtoZqkTe1M1m/PD4sXDBLC8y+fcpLzdh1rDOuxFclfEpfwbhefDpWP5MXqTwFzUShXiuDx33V0tvoI+DWrpsz9CGPLO+XWM1EuaGYUk5zMVXkeOV8NeqFZjOGEmIOxmFMrwYOaUO7ngWtkoztDjyIChwvYJ04i4OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pxkl77qW; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c80167f5716so939185a12.2
        for <linux-rdma@vger.kernel.org>; Tue, 05 May 2026 00:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777967622; x=1778572422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ERQqOrOMLsG822WUo4beOA7hvczmubAvpN48ynoq3gs=;
        b=pxkl77qWtbjt/pna5ILWZEmxesit7pO+v2bGRXuxF47qrWtzptjggUPpaVOw9fgiS6
         UaLMg1QxCB9xys8dM/U51dBm1eww5cVQYUydPRP/IBpDkdzRfQcqF9atPFvFysO+p7JI
         ChdU5fLBZ/D78yj76hK8kqXX4RTYISjsN0JcML8h5dmTFXpYXDr/T20fydA82CElF3ug
         DlTcYlU3RfZWlBbCBuKzr/oZt1MBnkbopNIX/QwuWAaZ1tzb0tW9TvI1rIMn7efIC1rL
         uG3ZBoavd9BeFdbSYzUETyNwXfP8qn2xF4HCNps2dX8u22lN5SuOBAf3LMvZbOvRskCL
         TRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777967622; x=1778572422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERQqOrOMLsG822WUo4beOA7hvczmubAvpN48ynoq3gs=;
        b=oZcEje9HDowZm7vH+Am/HLj01Mjvf/ABKhuSlWNbDrkJKUzLYLr/j/QfSFVyfrN4Ei
         nH1P7j20HkyLvxreSda0DEOrARTeNjQaYsEY4vnyAYHzKlap9F4rrnuYNoKHFrJcHYaF
         322XLc25YtOX3kJBuRmGOW2VqJhiYdIegeAPcGodGbe4lXJbQAN+el+sP/6SV/0uTEIv
         U23L53z7iRkIByveNLgv/8KWyK42w4b84+FQMumfNUvkBXjGGfaaMZgCA9gZJruV3ltd
         4A2oqT0ZW+9PFIjZFUUHWlYkfbyeME6CDN+uHQklLNMsiG1niSW9ELLhPhvAOPAggORm
         RQgQ==
X-Forwarded-Encrypted: i=1; AFNElJ/LRosCv1vQblNZGQqi6kaoM5vTr89AXVrTthysZqZ7InXsohEBvDCkjOEcZCQoaKV8dWCtkuaJ/Myf@vger.kernel.org
X-Gm-Message-State: AOJu0YyleWnHhxJRtBBzfS4CJHKYd/ddoCJpboO0cwfhGqQRlscbJ/Eq
	gH2k7cgMJytas7E6FhcR/Lv3F5XXlq5upbi/Gk9ns1hRf2Vq62z0q3AG
X-Gm-Gg: AeBDievrQVYhBazGTiAcl+5UsTxGKmMxCyBeYhh3UJthg0QeZtbMFtOTZTtNojaWxyy
	vz54xhiF+XgmcRTr2zbv4LwVME6Axa79FliGHnMcC840MHMR8ULMw8+5XjDy5400JgiRNqZEcK/
	pB/wr+Sl4zZHcROcv3S4cN+RFgkme4T3ocIaC4YGcK+cxBVh6BpT9ojNBA36e1bmHjQ1k5WpogN
	0Co0B9Qn3XFARC1eiH+dIlKeyLgEUotkf8ktiH9bpHbZvciuJOzIPqndAm7y9YTDKxVeAIkBPPo
	RZPNEzYcdUO1tYLmfdwQkb2dys09K7Q2hFPG3CIThGvd6xyD+5VKFRY5bhCJFnXt1L+UPxdNedw
	zPhOb8BEIVLwt1M20G3i0atS+w2omZnKFMrXSS830sDm5Y1gcEv4mR2fJjCOqXSByeu9guWBnSv
	k5HBK7I1EHGwrStFOFyw0SAO9k
X-Received: by 2002:a05:6a20:6a09:b0:34f:14d6:15f5 with SMTP id adf61e73a8af0-3a7f1bf6293mr13539826637.29.1777967622024;
        Tue, 05 May 2026 00:53:42 -0700 (PDT)
Received: from dev.. ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbc6f66dsm11921069a12.15.2026.05.05.00.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 00:53:41 -0700 (PDT)
From: Rohit Chavan <roheetchavan@gmail.com>
To: yishaih@nvidia.com,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] RDMA/mlx4: Use secs_to_jiffies() instead of open-coding
Date: Tue,  5 May 2026 13:23:07 +0530
Message-Id: <20260505075308.1754861-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6E9284C851D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-20003-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roheetchavan@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The conversion from seconds to jiffies is currently performed by
multiplying the value by 1000 and passing it to msecs_to_jiffies().

Use the more direct secs_to_jiffies() helper instead. This simplifies the
code, improves readability, and avoids the manual multiplication step
by using the dedicated kernel API.

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
 drivers/infiniband/hw/mlx4/alias_GUID.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx4/alias_GUID.c b/drivers/infiniband/hw/mlx4/alias_GUID.c
index c6e1b9e4122a..fc23960cf1fd 100644
--- a/drivers/infiniband/hw/mlx4/alias_GUID.c
+++ b/drivers/infiniband/hw/mlx4/alias_GUID.c
@@ -437,7 +437,7 @@ static void aliasguid_query_handler(int status,
 		queue_delayed_work(dev->sriov.alias_guid.ports_guid[port_index].wq,
 				   &dev->sriov.alias_guid.ports_guid[port_index].
 				   alias_guid_work,
-				   msecs_to_jiffies(resched_delay_sec * 1000));
+				   secs_to_jiffies(resched_delay_sec));
 	}
 	if (cb_ctx->sa_query) {
 		list_del(&cb_ctx->list);
-- 
2.34.1


