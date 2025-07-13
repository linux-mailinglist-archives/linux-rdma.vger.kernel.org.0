Return-Path: <linux-rdma+bounces-12093-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5832FB03378
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 01:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DF9F17708A
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jul 2025 23:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA4D20C47C;
	Sun, 13 Jul 2025 23:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVum4HcV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D5E1F429C;
	Sun, 13 Jul 2025 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752449640; cv=none; b=fLNgATq1nYPX0z8leqRnS3P+3QNHFe6XT1HRMGnU+07vgQTSPkd5Wxdd8iVunPrvaJL2pS5BuA3kwgGHPOJo2YlxJKVvW5X6YhMRINGPJLu6JviM6egV1eN9QwsbnB1l/3G9tBU+uG78zaAvszz0iP2vjIhC7FptXVvpIz1tBfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752449640; c=relaxed/simple;
	bh=lOoncje2oUnyFV/y0B2u8ZzppYxKn2zAB68qVvRIoRk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uraJsEeOb1FSU7cTrbzAVx4aXBmxc9CHspXBu/yuUyZOBdGaXCsi7SFgsxnTMIdw/Btej2QfsEMK/NBcVOlODNPGArCGkTV4/Z1P/it+uYmoSbWwMInKBO012Hoiwwdsbz31OJz2jTMFbJpeThnkOPyCZ6o0Wkb+nPaBs2xJ87E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVum4HcV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 875BBC4CEF5;
	Sun, 13 Jul 2025 23:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752449639;
	bh=lOoncje2oUnyFV/y0B2u8ZzppYxKn2zAB68qVvRIoRk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=jVum4HcVcOplnBaigE3KTR8jdS1OHPTePhpwhK5MOsVDNFt1DDfeyftOTXGc66Gn9
	 VkNHMjlUzsxIjBRWT7vT3Yvb736eoMM9QT/IjAN84Nk3i8ZGZ42q3qtWurB9ShHyRl
	 wpHtfHA3sCL8poYwdKZWEwGLGJEVbBS+WOKpajQFphNCrhIM7QguPKZnSQkplIM1j5
	 yz3yqAWG+9qqFkBItpm9Sf4Y0fZlzNkP+Z8eVmOznyz50ixT8OVvfoieRzFZAw5Q+E
	 badTSbtsz7psw2SPfJlQSUN0YFIsJ6bwNsp5rkSupm0EH8LZ23g8ZXuEfpQYZfdYBg
	 nvRGabvA1DlMA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7793DC83F1A;
	Sun, 13 Jul 2025 23:33:59 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Subject: [PATCH net-next 0/2] net/mlx5: Avoid payload in skb's linear part
 for better GRO-processing
Date: Sun, 13 Jul 2025 16:33:05 -0700
Message-Id: <20250713-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v1-0-ecaed8c2844e@openai.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADFCdGgC/x3OQQqEMAyF4atI1hPQYhXnKsMsQhs1UNvSFlHEu
 1tcfpv/vQsyJ+EM3+aCxLtkCb6i+zRgVvILo9hqUK3S7dgpNJEomxXjjJMa0XPZ3KGR9iAWTYi
 n+AXLyhjpdIEslvByI+eCYYuUmHDQqp+6sdeaBqhbMfEsx/vjB7VZu0eB/30/m1TZQ6EAAAA=
X-Change-ID: 20250712-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-6524917455a6
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
 Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752449639; l=1053;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=lOoncje2oUnyFV/y0B2u8ZzppYxKn2zAB68qVvRIoRk=;
 b=ioSnehR5e7kuMAxE7uGeb0XuNvhZbFt+x+kCs6WgJ0hnHyokukeq66J0XA+CPcBqGtDJ9tYT3
 k5pJQM5vm0fAUzFjHKeHNyaJHwkiB3yLpaohwd75Qin5sDSaDHm6E4M
X-Developer-Key: i=cpaasch@openai.com; a=ed25519;
 pk=1HRHZlVUZPziMZvsAQFvP7n5+uEosTDAjXmNXykdxdg=
X-Endpoint-Received: by B4 Relay for cpaasch@openai.com/20250712 with
 auth_id=459
X-Original-From: Christoph Paasch <cpaasch@openai.com>
Reply-To: cpaasch@openai.com

When LRO is enabled on the MLX, mlx5e_skb_from_cqe_mpwrq_nonlinear
copies parts of the payload to the linear part of the skb.

This triggers suboptimal processing in GRO, causing slow throughput,...

This patch series addresses this by copying a lower-bound estimate of
the protocol headers - trying to avoid the payload part. This results in
a significant throughput improvement (detailled results in the specific
patch).

Signed-off-by: Christoph Paasch <cpaasch@openai.com>
---
Christoph Paasch (2):
      net/mlx5: Bring back get_cqe_l3_hdr_type
      net/mlx5: Avoid copying payload to the skb's linear part

 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 33 ++++++++++++++++++++++++-
 include/linux/mlx5/device.h                     | 12 ++++++++-
 2 files changed, 43 insertions(+), 2 deletions(-)
---
base-commit: a52f9f0d77f20efc285908a28b5697603b6597c7
change-id: 20250712-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-6524917455a6

Best regards,
-- 
Christoph Paasch <cpaasch@openai.com>



