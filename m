Return-Path: <linux-rdma+bounces-3022-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90151901743
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jun 2024 19:35:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F8CEB20B6E
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jun 2024 17:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824514D8C8;
	Sun,  9 Jun 2024 17:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="FHLyEX5c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6CA4317C;
	Sun,  9 Jun 2024 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717954501; cv=none; b=WymV+QW403bsGLOOVBRt8TI4+tQiCVoJesqXWeQxs5t/Jw3Hj/9Op/vFY4XvwRa6I7tJ53WIOOyzrfgOcWOc3Q2rUewu92V87QzbPQcWWhFWXtjcZJd0EIwwAAKXKg4/7pfet1ygt+k7cnFqMAMKYjYZ/cocCplmRxmstcS7SWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717954501; c=relaxed/simple;
	bh=t6x1tv97EU9SAZz9jzRF2dm87Yph3Q6Qy9KKIp/7l64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HH9qi4MTSMCdtsZwtAbkfdzTIBKJalLGNKS67OKYDjGqaw8FqTJVIc8i0oRhDETdvPwMp95spCwn9vRpR/KsH6PrAeT11qoTzFOi6SBhfdt4Xoqz7/UmUc68nGLgZV0/mlaubWMr+X+neFSvNpGRo6fp4sW2BwAAy60PvpaJ8Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=FHLyEX5c; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id E2F77600B4;
	Sun,  9 Jun 2024 17:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1717954494;
	bh=t6x1tv97EU9SAZz9jzRF2dm87Yph3Q6Qy9KKIp/7l64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FHLyEX5cFRXCMaCxEXQ9Yb3NUuOeB8ZXuW2/sZ2EbA05SJnsXnG1jGXc3cRd27R3e
	 Lug9thFOPvT2s0r+YBLoZSIRjqW2OvQfyZVZ9BAwygRDnsCmCOi4y+T+WE24jZWUds
	 bvu+gLbyPhNKRb9LOrval2YJ5BVtVGn0G4/9W43d5GkqyKl4Wa9UMUcCHjI77gofxz
	 5NuCgagsobeK1WsbwJRfqaOYGdhYo+Z/P5y+mU78OfW8Mp5sS0d/yQL+oYWFPaYW2Q
	 eP2x/vS6LLYhYnqnr4wJQnfnMpw2aZwSYg/9cau9rdqW10Dr9qP6Vg34FZhwtVxkHi
	 UorT6YIktC1eA==
Received: by x201s (Postfix, from userid 1000)
	id 8C8052045EE; Sun, 09 Jun 2024 17:34:30 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Martin Habets <habetsm.xilinx@gmail.com>,
	linux-net-drivers@amd.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	intel-wired-lan@lists.osuosl.org,
	Louis Peens <louis.peens@corigine.com>,
	oss-drivers@corigine.com,
	linux-kernel@vger.kernel.org,
	Davide Caratti <dcaratti@redhat.com>,
	i.maximets@ovn.org
Subject: [PATCH net-next 4/5] nfp: flower: validate encapsulation control flags
Date: Sun,  9 Jun 2024 17:33:54 +0000
Message-ID: <20240609173358.193178-5-ast@fiberby.net>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240609173358.193178-1-ast@fiberby.net>
References: <20240609173358.193178-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Encapsulation control flags are currently not used anywhere,
so all flags are currently unsupported by all drivers.

This patch adds validation of this assumption, so that
encapsulation flags may be used in the future.

In case any encapsulation control flags are masked,
flow_rule_match_has_enc_control_flags() sets a NL extended
error message, and we return -EOPNOTSUPP.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/netronome/nfp/flower/offload.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/offload.c b/drivers/net/ethernet/netronome/nfp/flower/offload.c
index 8e0a890381b60..46ffc2c208930 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/offload.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/offload.c
@@ -321,6 +321,10 @@ nfp_flower_calculate_key_layers(struct nfp_app *app,
 
 		flow_rule_match_enc_control(rule, &enc_ctl);
 
+		if (flow_rule_has_enc_control_flags(enc_ctl.mask->flags,
+						    extack))
+			return -EOPNOTSUPP;
+
 		if (enc_ctl.mask->addr_type != 0xffff) {
 			NL_SET_ERR_MSG_MOD(extack, "unsupported offload: wildcarded protocols on tunnels are not supported");
 			return -EOPNOTSUPP;
-- 
2.45.1


