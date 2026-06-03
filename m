Return-Path: <linux-rdma+bounces-21674-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EQzLKAL/H2oNtwAAu9opvQ
	(envelope-from <linux-rdma+bounces-21674-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 12:16:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01EBB63679D
	for <lists+linux-rdma@lfdr.de>; Wed, 03 Jun 2026 12:16:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cJzjaf5N;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21674-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21674-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B04F330BC7FC
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Jun 2026 10:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8315E44B68E;
	Wed,  3 Jun 2026 10:09:45 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AC7221FB4
	for <linux-rdma@vger.kernel.org>; Wed,  3 Jun 2026 10:09:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780481385; cv=none; b=UExwYpW6h2ET+HsGujkefF1K3rTp2/vaxJoDXNgbsP/TcAfVllpo20X93qwThdQxTeiyt4n/kE1EORSaKQBXhUedMwNGkVc0Bji9KMSfGdtq3RMElyGbASyvyOLfKUrSNC7NaJOHpCfzPs6nx32dS6nmnYgGoxeXekr8DfYW3Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780481385; c=relaxed/simple;
	bh=HuETMB4PLYYz65jC3yyMI47575oQkI0xm1Txko0El1g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ND3CCdOePEILJi5k5i6CawY0AJ0bsT8rOPKOccWAYKKM5GJ0sJOo6fOFklwqPpV36P0M972gGxEZsGuHWXiTtSjFG+611uOD8a7nrVPi9RmVTDu1f55BWrpTlDrnlC9vsBPRsw+yKYvWrjlKjKdgbuwRrIFn8eCJQBVKWc6ZWoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJzjaf5N; arc=none smtp.client-ip=74.125.82.193
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-304f0039c02so9758933eec.1
        for <linux-rdma@vger.kernel.org>; Wed, 03 Jun 2026 03:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780481383; x=1781086183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=03ieKC9B6pSYMZB8yCD7Lxz2rXtF0I/QZ/gfZx53cXw=;
        b=cJzjaf5NPeboaHSDqvAoLj4FKXXTWrck7G5rKtM4zmulJdC+QhAEm3ZOjl9sQ/qZNx
         40IeTyzkYB4rt+37wsbI+K/ueuVapx2yUnOVCudWsmkgdzMmCEflvQ4CJZpp7dw6dRdM
         TUJ5roHKmqlqueSsaQUgNPCl/BLOXo6XE9QyUHj5AXZpkQgyfC7GntBD1rDRnz1i8kTU
         uFxC07iDvrk5uKXzJoIufeb78ZWNvjckxmLQpW6rC1FUEkWUuHepmtG3XOKsV7TK/Ajt
         uPuJvighm2XtiRUWysoOv/VMeqIN1EL/AoHZuiH0cGIqJXaXiv8JCUlK76Bc3FUbCaYo
         CJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780481383; x=1781086183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=03ieKC9B6pSYMZB8yCD7Lxz2rXtF0I/QZ/gfZx53cXw=;
        b=qg4njlKIhGSvAzqkFnAaRvUa902NOEmz5WiROzUM/aZHFZLKt7mRQyn+nfU2DWiFvI
         sgwAVVZ8qjGArGBsShkJUkwlJ+kQERKkCuMpIFnVQ4NgtcqaMoLdgCwKzDBDXec1zjqP
         8SZimNIYFNf+GkPAkYgmYx4LJJ6pkblzcfDRuDhB8oX/+Ruyfw2EbzIFZ7nm7Mh6jk5h
         4/p7fRrW0De5Y8tldx8N4WHDMOei4DAPJUh3HsZ0+DwZ4d3mjXD0NMCdJQZ35sh3fMzO
         SsA3oA3wGV3vKWZhfLI0GltwtxO9J3t9OxIx3Xlkf2WeYgpir/lI4Dhsq/M2v4SHWEZW
         WaHA==
X-Gm-Message-State: AOJu0Yw7ghrDxylY8Gx/3yiTmZhOTb0k51U8rlsl5u58GhEoNWPFmrfD
	VSvOq37f7BKJaGch2y8pVnnHF8KgRHCVFabDfuWpqY5Jp1QM6zx53F7Z+XN67WXiWU9v
X-Gm-Gg: Acq92OHjqlVFPfuwrnW9wF9iENDG/U3+X3PPXlLFt9aPpsYPWkU1M9uSkMKGiNAapak
	AGIKM0H3AhtmuIpEeL/msB14QwDgYCCqmjsWyX/Izt8YGi1yGPW485bMNN06YkafM6V3atOLsc1
	IGj01uIMMsmA2HFQrjEdlH62dsq/5WbyjC/J82cClDDm3aPGkUR68iJhXJtS0wzdgkIRrQ8Q2BA
	j7FT4OJrHoS7ZsR91ocozlv1JcRMbS/vs9hvGizfp3HkgROi1Lt01srLybz4XVva4ek/DxU0Q13
	z2ieWJk1LchTHGKwa2wQu2Wu4PMcUgJpc4uuw8QEfH24P5JYonc3mqeZF1u0wrO3AQUD/4QbKd3
	ywh2LeylwSIPzbh8VrpozP9zaxOkPGEKNypmkKkvkLq26G6Jr7FNLAH5opv+YBTp+egW0qdPpW1
	AOnq8sIOJB4suGjbre6eNuSWQM8SIBWVHUj0RargR9ALxd8l/DVILcswM2GsSyJts=
X-Received: by 2002:a05:693c:380a:b0:304:8366:7456 with SMTP id 5a478bee46e88-3074fa52a93mr1364400eec.3.1780481382593;
        Wed, 03 Jun 2026 03:09:42 -0700 (PDT)
Received: from rainbow (static-23-234-72-105.cust.tzulo.com. [23.234.72.105])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db56697sm2091177eec.2.2026.06.03.03.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 03:09:42 -0700 (PDT)
From: Jordan Walters <jaggyaur@gmail.com>
To: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/rxe: Fix use-after-free of netdev in smc_ib_port_event_work
Date: Wed,  3 Jun 2026 06:09:19 -0400
Message-ID: <20260603100919.268055-1-jaggyaur@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21674-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[jaggyaur@gmail.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jaggyaur@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01EBB63679D

rxe_net_del() drops its reference to the underlying net_device
via dev_put() but does not clear the netdev pointer from the
ib_device. This leaves a dangling pointer that the async
smc_ib_port_event_work worker can dereference after the
net_device has been freed, causing a use-after-free in
__ethtool_get_link_ksettings().

An unprivileged user can trigger this via user namespaces
by creating a dummy interface, binding it to rdma_rxe, and
immediately destroying the namespace before the worker fires.

Clear the netdev pointer via ib_device_set_netdev() before
releasing the reference. Downstream callers such as
ib_get_eth_speed() already handle a NULL netdev safely.

Note: this is a distinct issue from the socket TOCTOU race
fixed by Zhu Yanjun in [1]. That patch addresses a race on
the pernet socket pointers (rxe_sk4/sk6) leading to a NULL
deref in kernel_sock_shutdown(). This patch fixes a dangling
netdev pointer leading to a UAF in
__ethtool_get_link_ksettings via smc_ib_port_event_work.

Link: https://lore.kernel.org/all/20260519023541.8594-1-yanjun.zhu@linux.dev/ [1]

Signed-off-by: Jordan Walters <jaggyaur@gmail.com>
---
 drivers/infiniband/sw/rxe/rxe_net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
index 50a2cb5405e2..a8f91d6e3b17 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -663,6 +663,7 @@ void rxe_net_del(struct ib_device *dev)
 	if (sk)
 		rxe_sock_put(sk, rxe_ns_pernet_set_sk6, net);
 
+	ib_device_set_netdev(dev, NULL, 1);
 	dev_put(ndev);
 }
 
-- 
2.49.0

