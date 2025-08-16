Return-Path: <linux-rdma+bounces-12790-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D39A4B28F3C
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Aug 2025 17:39:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FF0FAE6B7C
	for <lists+linux-rdma@lfdr.de>; Sat, 16 Aug 2025 15:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD6561A262D;
	Sat, 16 Aug 2025 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIP7IQGF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EAC19006B;
	Sat, 16 Aug 2025 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755358744; cv=none; b=N7Jf4bpVHGvnAh+eahfN87F9sIu5TEZWC4yIveR5GJu9YVRefcDVYlTVfKPXiS7YnHsHzuSBhx2PPUNwPXPwzT3/WbhnzBGFyjFBbgyNJwzThekXE+VXhIt0HVACANABnjlQUoIITS+X2bWZ4Z068EZlzY3Xuzl8rG860cCQ8rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755358744; c=relaxed/simple;
	bh=o+rHkyCjmB4hkyP7M3HLqZNJrf+AJVoFYhkrqijhjZg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CYPf3UQHt6Hu166XFmITdeT3/ZNYa5EnALz0fVSr+SCyfiumbwDDqtR8vbaiqNj/DXLSIDolcQn/Ap8CzQYf8+VsxivbOG2bRuIbujFIUGh1n3D2O08oKSmjTLQeqAbQxELeyZJfR1kCu8rjWPcGOUghfCYt+7U4fiPcCG0iROQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIP7IQGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36932C4CEEF;
	Sat, 16 Aug 2025 15:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755358744;
	bh=o+rHkyCjmB4hkyP7M3HLqZNJrf+AJVoFYhkrqijhjZg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=QIP7IQGF2hmBnfEh2M61I2ssKMLsuh66UT1q1iAnLHW11ZwEe8HUcto5Vz8p+MaL3
	 tpTnY5yx17q6x3grmNF4r52al8bf6mp611i+AdGGYMuRxyanb+M2tS/ornqxJOINin
	 565YjTcnwDNvsPuZ1UXAaMEnVTNnx02K90htm1OJ3Wsz46HsgzUIaPrNHY4nTwU4bQ
	 t44mnwMc0mbf4p3XreMKM1holZ82XzpGHz4mY0j2caj6ckSgkt20siFwYGBOMA8RMI
	 dEBgv/ZoT8botwMXgMtxjx4ZF72XghO2VNam7R+0xN8T63ixhm6pZFDIHDk0oA1uUz
	 X6izhWfvraHiQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CECCA0EE9;
	Sat, 16 Aug 2025 15:39:04 +0000 (UTC)
From: Christoph Paasch via B4 Relay <devnull+cpaasch.openai.com@kernel.org>
Subject: [PATCH net-next v2 0/2] net/mlx5: Avoid payload in skb's linear
 part for better GRO-processing
Date: Sat, 16 Aug 2025 08:39:02 -0700
Message-Id: <20250816-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v2-0-b11b30bc2d10@openai.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABamoGgC/62OQYrDMAxFr1K0rkrixk3b1dxj6ELYaiNILGObk
 BBy95owR5jl48H/b4PMSTjD87RB4lmyaKhgzidwA4UPo/jKYBpjm7416CJRdgPGNz5Mj4HLNC4
 WaVbx6DSuEj5YBsZI66jkseiBE42jOvZIiQlv1nSPtu+spRvUr5j4LcvR8Qt1s+4uBV7VDJKLp
 vUInNvD/7Vc/6llbrFBdsT+7sy96/hHIweSi9MJXvu+fwGiyscgJQEAAA==
X-Change-ID: 20250712-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-6524917455a6
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Gal Pressman <gal@nvidia.com>
Cc: linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
 Christoph Paasch <cpaasch@openai.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755358743; l=1531;
 i=cpaasch@openai.com; s=20250712; h=from:subject:message-id;
 bh=o+rHkyCjmB4hkyP7M3HLqZNJrf+AJVoFYhkrqijhjZg=;
 b=l+5SKjfiweJsliNW8BZ12uhSvZ3HCGFk0I44HeHLd7jk2KjiqBT2AVdISiC4cm3l8R0KQFZGD
 m8zotkOOwA+DIhQHVSicGgyv/ql/sM4st0Ck+gYjidoBBKPkOB+V3r2
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
Changes in v2:
- Refine commit-message with more info and testing data
- Make mlx5e_cqe_get_min_hdr_len() return MLX5E_RX_MAX_HEAD when l3_type
  is neither IPv4 nor IPv6. Same for the l4_type. That way behavior is
  unchanged for other traffic types.
- Rename mlx5e_cqe_get_min_hdr_len to mlx5e_cqe_estimate_hdr_len
- Link to v1: https://lore.kernel.org/r/20250713-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v1-0-ecaed8c2844e@openai.com

---
Christoph Paasch (2):
      net/mlx5: Bring back get_cqe_l3_hdr_type
      net/mlx5: Avoid copying payload to the skb's linear part

 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 37 ++++++++++++++++++++++++-
 include/linux/mlx5/device.h                     | 12 +++++++-
 2 files changed, 47 insertions(+), 2 deletions(-)
---
base-commit: bab3ce404553de56242d7b09ad7ea5b70441ea41
change-id: 20250712-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-6524917455a6

Best regards,
-- 
Christoph Paasch <cpaasch@openai.com>



