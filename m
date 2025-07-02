Return-Path: <linux-rdma+bounces-11829-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E65AAF598B
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 15:39:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4546216C34B
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jul 2025 13:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58C7280A51;
	Wed,  2 Jul 2025 13:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="uOsqb9wO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC56F280025;
	Wed,  2 Jul 2025 13:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751463527; cv=none; b=sP7La/pv4CdMEQbo67jpwonHzm+f91m0XZuBmXk0XVy7LAodAfeBdXq3tVts7+ldnPCUdLoyNgnKUD6iNPVRfo3D875rMelPQdaKD6/EV0OYmhPj7iwDAU4jbEWgaF3VmFF7B4oIRJ18w0+TrzGi5b297DWdyKxVenSNUZ7afFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751463527; c=relaxed/simple;
	bh=9UXv6Lv8Mgx5xwLb6Alh24jufOJ2+q7DhT8Nl4HXuvY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eL8mvjIBO/pT8ugQEzO2fKX4IurUqRJXTucp6EKWK1yTWaVKj1J+KvpeUZJ9MNsrDzKoVAzswRgI9ptM/YgXEjP+QRVE0WDd6wsdY5anXp/5nEX6GFRwJlbhyH8n9mufuYUq8XzGBOQKZtkoE5+D5/vR53WhZJO78PmwyOh6vEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=uOsqb9wO; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uWxfV-00GxOo-Ac; Wed, 02 Jul 2025 15:38:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=rLI/a9ECryxZRQ9J4BCJbHJwt0Oclm9wiohMCVJ1XXA=
	; b=uOsqb9wOvgHeZuau00vHqMtqAy75L00axpt98nL9aqznLT7tk/UllZTTi8Vx4Rcz1+oPLzxVs
	fcP7sVuf77kt4ektZYfHpFoXJ3u98QpDFVZJjT0egF0xzhusweqXBoMUDRqtK6XTLzTp3o6ZgC4jK
	ihLtc6Jt5ReVmJ/ktfEH/wUFUhVqalFfhO2/xynWTdNwQN6mQ2kE5As6MCPBdqfpaau3thNFuOAWp
	g/jHEkaI8rgC4R9cHXlnEnEmOygn7QzbL+WFmlbb7VAq76GS7pndcPvL1oJ0s+6wO3Om5LuKcEUoo
	v2ZoioVJq1Wy6WRsAPmVM65aio0kR06jgVUT/A==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uWxfT-0006EX-TZ; Wed, 02 Jul 2025 15:38:32 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uWxfC-009LCR-Li; Wed, 02 Jul 2025 15:38:14 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net-next v3 0/6] net: Remove unused function parameters in
 skbuff.c
Date: Wed, 02 Jul 2025 15:38:06 +0200
Message-Id: <20250702-splice-drop-unused-v3-0-55f68b60d2b7@rbox.co>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD82ZWgC/23OQQ7CIBAF0KuYWYsBioiuvIdxgTBYEgMNtKSm6
 d0luNBFlz8/8/4skDF5zHDZLZCw+OxjqKHb78D0OjyReFszcMqPVDJF8vDyBolNcSBTmDJaQlG
 gVppxqRjUwyGh83NDbxBwJAHnEe616X0eY3q3tcJa/4W52IILI5QYJwXT8iQtFdf0iPPBxIYV/
 g/ITYBXoKt/OW2Ydur8A9Z1/QB6xmzK/QAAAA==
X-Change-ID: 20250618-splice-drop-unused-0e4ea8a12681
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 David Ahern <dsahern@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
 Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, 
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>, Sidraya Jayagond <sidraya@linux.ibm.com>, 
 Dust Li <dust.li@linux.alibaba.com>
X-Mailer: b4 0.14.2

Couple of cleanup patches to get rid of unused function parameters around
skbuff.c, plus little things spotted along the way.

Offshoot of my question in [1], but way more contained. Found by adding
"-Wunused-parameter -Wno-error" to KBUILD_CFLAGS and grepping for specific
skbuff.c warnings.

[1]: https://lore.kernel.org/netdev/972af569-0c90-4585-9e1f-f2266dab6ec6@rbox.co/

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v3:
- Keep skb_splice_bits() @flags [Jakub, Paolo]
- Link to v2: https://lore.kernel.org/r/20250626-splice-drop-unused-v2-0-3268fac1af89@rbox.co

Changes in v2:
- Fix typos in commit messages
- Remove one more unused parameter in skbuff.c (patch 9)
- Collect R-b, add a one-line cleanup of smc_rx_splice() (patch 7) [Simon]
- Link to v1: https://lore.kernel.org/r/20250624-splice-drop-unused-v1-0-cf641a676d04@rbox.co

---
Michal Luczaj (6):
      net: splice: Drop unused @pipe
      net: splice: Drop unused @gfp
      net: splice: Drop nr_pages_max initialization
      net/smc: Drop nr_pages_max initialization
      net: skbuff: Drop unused @skb
      net: skbuff: Drop unused @skb

 .../chelsio/inline_crypto/chtls/chtls_io.c         |  3 +-
 include/linux/skbuff.h                             |  2 +-
 net/core/skbuff.c                                  | 34 +++++++++-------------
 net/ipv4/ip_output.c                               |  3 +-
 net/ipv4/tcp.c                                     |  3 +-
 net/ipv6/ip6_output.c                              |  3 +-
 net/kcm/kcmsock.c                                  |  3 +-
 net/smc/smc_rx.c                                   |  1 -
 net/unix/af_unix.c                                 |  3 +-
 9 files changed, 20 insertions(+), 35 deletions(-)
---
base-commit: e96ee511c906c59b7c4e6efd9d9b33917730e000
change-id: 20250618-splice-drop-unused-0e4ea8a12681

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


