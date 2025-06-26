Return-Path: <linux-rdma+bounces-11658-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0040BAE9865
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 10:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107963A8426
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 08:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED243293C7F;
	Thu, 26 Jun 2025 08:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="T1lz9gJs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AABB25F964
	for <linux-rdma@vger.kernel.org>; Thu, 26 Jun 2025 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750926857; cv=none; b=k2stnoKt6xul/UIt11xcSrhxa+UfdS/iQPg/cWDgv6wBYZFIRCr3iZdMAUMJtImq05ygtglJovmGxsQmn6aUg3Q30NOb2EEjkynuD/WkTOnezkygHaOjjeVLJUl6g/WA44+2wlFtuXmYGPdOUZ0OAasENEEMBLa/zHP1QxTM7hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750926857; c=relaxed/simple;
	bh=FN1dmMdntBApB4y6/lfPGkEMnKeVudcZ2z+5Sc1rh8g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Wfq75lt8TUjIX8TtGxwHZf1/CcMiO5ZAFS7dojrpvgCz8JRUci6d/38lg5Hax56XUELup56OiUbiFNWsHjokmw32ckFX1CCBzSWxTlR1c9TuR/9320jScFh+Z8cYzTElf5tdCj+6jBN0SNR9vsI1XRErz/RzEuy05nvqkz2PBb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=T1lz9gJs; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uUi3d-00GcBY-Lt; Thu, 26 Jun 2025 10:34:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From; bh=kS9LXDq20z8OjgHj2ryQ3q5/7FnNSMm+rTcaXVSxdds=
	; b=T1lz9gJsk8zFyeAhFYB2uaRG7kvg2I2GXBqbJsBUFauEBt6USYg8ciFGXIwrakSzFLTNDgAyB
	hLJs9UEkj0zI71O909fgdqe8jxMjhNTOmOAGKMENaNNhbL0leyu2vS1UwNdBhpQ15nUWK2v98ok72
	Hfwvn5mKxPusU9WxYayJzc1EW8b2Nmv7PKu8h1Q15tlhU2FK4Qu0AKvbCdpT0/F2UVP0s1srsmiCf
	qR5gUB+nPSsBCohEN6Z64SC08JXc+BQZ/9CyVJ1r0KijPqEi5XJ7zMFS1L1MndamwU9VOkoIrUAmM
	IkiVhsNFlJRQ0Dgnj/Zk1hsXTAGb3cgWDIIjBQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uUi3d-0004q4-7F; Thu, 26 Jun 2025 10:34:09 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uUi3K-009Fh5-AG; Thu, 26 Jun 2025 10:33:50 +0200
From: Michal Luczaj <mhal@rbox.co>
Subject: [PATCH net-next v2 0/9] net: Remove unused function parameters in
 skbuff.c
Date: Thu, 26 Jun 2025 10:33:33 +0200
Message-Id: <20250626-splice-drop-unused-v2-0-3268fac1af89@rbox.co>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN0FXWgC/22NQQrDIBBFrxJm3Skq1kpXvUfJwuqkGSgqmoSUk
 LtX0m2Xj8d/f4NKhanCrdug0MKVU2ygTh340cUXIYfGoIS6CCMt1vxmTxhKyjjHuVJAQZqcdVI
 ZK6ENc6GB1yP6gEgTRlon6JsZuU6pfI63RR7+F1b6X3iRKNAPRktnriYIfS/PtJ59gn7f9y/MT
 HecvAAAAA==
X-Change-ID: 20250618-splice-drop-unused-0e4ea8a12681
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
 "D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
 Wen Gu <guwen@linux.alibaba.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
 Michal Luczaj <mhal@rbox.co>
X-Mailer: b4 0.14.2

Couple of cleanup patches to get rid of unused function parameters around
skbuff.c, plus little things spotted along the way.

Offshoot of my question in [1], but way more contained. Found by adding
"-Wunused-parameter -Wno-error" to KBUILD_CFLAGS and grepping for specific
skbuff.c warnings.

[1]: https://lore.kernel.org/netdev/972af569-0c90-4585-9e1f-f2266dab6ec6@rbox.co/

Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
Changes in v2:
- Fix typos in commit messages
- Remove one more unused parameter in skbuff.c (patch 9)
- Collect R-b, add a one-line cleanup of smc_rx_splice() (patch 7) [Simon]
- Link to v1: https://lore.kernel.org/r/20250624-splice-drop-unused-v1-0-cf641a676d04@rbox.co

---
Michal Luczaj (9):
      net: splice: Drop unused @pipe
      net: splice: Drop unused @flags
      tcp: Drop tcp_splice_state::flags
      af_unix: Drop unix_stream_read_state::splice_flags
      net: splice: Drop unused @gfp
      net: splice: Drop nr_pages_max initialization
      net/smc: Drop nr_pages_max initialization
      net: skbuff: Drop unused @skb
      net: skbuff: Drop unused @skb

 .../chelsio/inline_crypto/chtls/chtls_io.c         |  3 +-
 include/linux/skbuff.h                             |  5 ++-
 net/core/skbuff.c                                  | 37 ++++++++--------------
 net/ipv4/ip_output.c                               |  3 +-
 net/ipv4/tcp.c                                     |  7 ++--
 net/ipv6/ip6_output.c                              |  3 +-
 net/kcm/kcmsock.c                                  |  5 ++-
 net/smc/smc_rx.c                                   |  1 -
 net/tls/tls_sw.c                                   |  2 +-
 net/unix/af_unix.c                                 |  7 ++--
 10 files changed, 26 insertions(+), 47 deletions(-)
---
base-commit: a9b24b3583ae1da7dbda031f141264f2da260219
change-id: 20250618-splice-drop-unused-0e4ea8a12681

Best regards,
-- 
Michal Luczaj <mhal@rbox.co>


