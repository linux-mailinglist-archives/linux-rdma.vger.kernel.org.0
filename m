Return-Path: <linux-rdma+bounces-18706-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKBTHnIoxWkU7QQAu9opvQ
	(envelope-from <linux-rdma+bounces-18706-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 13:37:06 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B12D3354B4
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 13:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6B0630B5A3D
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 12:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E6A3F99CD;
	Thu, 26 Mar 2026 12:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g52yV3Hs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3974634752A
	for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2026 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528354; cv=none; b=nPgiGk20uQGBONbohU6U899N/XmsAtdMlSvfaTjrNkHCUVj/FsqDjQ/zSIT9CexM6XZy7wkyeJOQb4+Iecef0oWcvC0DiiRMSL6gfKLUiPJybh/9ihTEZNKnPnTLG1VSepA1psTo1qQESFwxRFp/cDqo/av3AKAgtSEsGgMUHd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528354; c=relaxed/simple;
	bh=KwQq7eyM0mQVqNtiIXpVpzQjQ6XV2ioWYBG3yYG4oHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fTGDQvMxRWagcVGTJ6m1uyo8PPxaN1hyA0QOk+bsL3nFpwhDbLM2NUlNXZIyOC3eRbK0Txg0FHJJUiBU1qhyZIolmsJiQ0IwJ0cr5ypKNVknEsVtRflfnWNKbddtP2aNTsivKzRm1vvteuS8QHsxAxRIlVFuwxJojdIAbIblXAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g52yV3Hs; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-485345e2fdfso5270255e9.2
        for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2026 05:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774528352; x=1775133152; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=44Rl4IuwAjVXDZrVO8Bc7181pdJEclCn1gduNsTGsBw=;
        b=g52yV3HsuZmXhXLr0i1orfxC2PFUp6xQNsLcFFLUBcB7xbZhq9fFing+SUs+qpJDHM
         Y+TQVYvC2BeAR5rvqG5WQBSjfpHB4GY/0O8fTS+KveaAvcqnJXKuDPLtt6ddClxPuJn7
         IOQhtxiBpFDKRbnGIo/Uv9ppSbS/X/4ApV0ePlsUR+LAgz6HZaZ8HgiE4jKFFtXacGqC
         kUKrN7jAwtEFQdXrupWgXyDClPuTENt+i2Ra7f0UglAC0y1FcdhJ6GCfzKEYHKyEhH+M
         RSjqgmAJZVh4u4xCfhdYNLDL0AY2093BITU39TTHGYSBUdrIkQKRATlyJIoPisp9/eaw
         IEYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774528352; x=1775133152;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=44Rl4IuwAjVXDZrVO8Bc7181pdJEclCn1gduNsTGsBw=;
        b=K41n9oePpBT7eXTW3yULiVb7CRDkQV9lXNyqjKp5gxUosOSyEihNFFeRjB6mKSc/eT
         rLwUd227DGNlDDquuxZ6FmJz4XJYxwR/rNTubgI5xRE1g+gdoKc+cTQx2/zQ7p8tjk1U
         lDMdseAmmdiqJ6FCpd/UBVZK2Kf9Slz3AE9kbgCogPzs3hejDOuJQreTubixQ6PrE/iJ
         Slvyp1YMIk17VBSy0DDUVny27+kYlS2EEi6pFm+ysMrxBHVkG3RTi047xJ2iJgGadK4e
         wsWqbD/CTLwLlmLiBtyxloeotKc9fOgRWvldDiHktBM3i+tny8QHyjKS7GViR0Vx0+i0
         VmxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8ZietOtLvxl/8DV/HibxKouISf4uzRaJ4YhsMwTCPMnXASYIMYxGvEYSba7LOravcd02QflrBLMWZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwcJKebFnt8F3I0gbRXjU/FiHmw7JvFvNCG7IcL3t+XD/sxumTH
	f8k04MDzqD3kiT4/y7pUw6UUSxbRhOYJWb4CKlzu/SJt85HJBMXIiY6ygv2V3Y81hILK4RRNkDm
	AtcQZgn8sgNy86w==
X-Received: from wmcq12.prod.google.com ([2002:a05:600c:c10c:b0:487:247f:cb9e])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5296:b0:483:7783:537b with SMTP id 5b1f17b1804b1-4871605bde7mr108915255e9.24.1774528351509;
 Thu, 26 Mar 2026 05:32:31 -0700 (PDT)
Date: Thu, 26 Mar 2026 12:31:58 +0000
In-Reply-To: <20260326-gfp64-v2-0-d916021cecdf@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260326-gfp64-v2-0-d916021cecdf@google.com>
X-Mailer: b4 0.14.3
Message-ID: <20260326-gfp64-v2-2-d916021cecdf@google.com>
Subject: [PATCH v2 2/4] iwlegacy: 3945-mac: Fixup allocation failure log
From: Brendan Jackman <jackmanb@google.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Stanislaw Gruszka <stf_xl@wp.pl>, Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Allison Henderson <allison.henderson@oracle.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18706-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,wp.pl,google.com,linux-foundation.org,oracle.com,davemloft.net,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jackmanb@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B12D3354B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix 2 issues spotted by AI[0]:

1. Missing space after the full stop.

2. Wrong GFP flags are printed.

And also switch to %pGg for the GFP flags. This produces nice readable
output and decouples the format string from the size of gfp_t.

[0] https://sashiko.dev/#/patchset/20260319-gfp64-v1-0-2c73b8d42b7f%40google.com

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 drivers/net/wireless/intel/iwlegacy/3945-mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/3945-mac.c b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
index c148654aa9533..88b31e0b9568c 100644
--- a/drivers/net/wireless/intel/iwlegacy/3945-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/3945-mac.c
@@ -1002,9 +1002,9 @@ il3945_rx_allocate(struct il_priv *il, gfp_t priority)
 				D_INFO("Failed to allocate SKB buffer.\n");
 			if (rxq->free_count <= RX_LOW_WATERMARK &&
 			    net_ratelimit())
-				IL_ERR("Failed to allocate SKB buffer with %0x."
+				IL_ERR("Failed to allocate SKB buffer with %pGg. "
 				       "Only %u free buffers remaining.\n",
-				       priority, rxq->free_count);
+				       &gfp_mask, rxq->free_count);
 			/* We don't reschedule replenish work here -- we will
 			 * call the restock method and if it still needs
 			 * more buffers it will schedule replenish */

-- 
2.51.2


