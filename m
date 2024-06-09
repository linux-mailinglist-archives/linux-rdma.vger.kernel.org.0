Return-Path: <linux-rdma+bounces-3021-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B2B901741
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jun 2024 19:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BCF528112A
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jun 2024 17:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454C74D8AE;
	Sun,  9 Jun 2024 17:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="IFoy71mO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0526746544;
	Sun,  9 Jun 2024 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717954501; cv=none; b=j9+uEEdYVuIEWIVQLf4dkov23q6390zhLBkxiTH/GoJg6Tn3o0EXsrohSbm178w7J6pHFK/iT0o4+bBP1CDa1MYZhYNovD+IBZQnjcP1OY7E67gpf+zc3+9C3mlUouU4mXgg1EiX8YpQBnQfDyof1YVH8wm8wHup/UbwyMPjLRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717954501; c=relaxed/simple;
	bh=tui1WJ7baOGzKyf18IUbLIlkbfJr/Fu2MdHRU5e5qNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=diiHbVfMp7favAnWUAalg8bSx19OZLXKDHsvNEG80DkBi2MBp2SJXwxLYzn9Yzg08V5vBrIb1djoKdyLqC14L0KHws9+SYmXy7gbQaQObUCwONB5/6cGT9upJdAYDRhuNb483v0V9FhjesyDNja0T5IqHSBLhfvRZ9cTsoZK+oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=IFoy71mO; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 7C09B60178;
	Sun,  9 Jun 2024 17:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1717954497;
	bh=tui1WJ7baOGzKyf18IUbLIlkbfJr/Fu2MdHRU5e5qNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IFoy71mOjo5t2qezRI5PX4FHJW2kFybFXf5/hSM0TMqBk3kMP/sGNkGumIoCuFrQ5
	 TTo8C972eigjkbLLRB7h4DkMJTwVRzZQ7S6s+I6sggSi+/0tvaP8LHuw6EEdKGFNcm
	 Z70WS5KqgE03OhEl7ptaV1AUZ35Z1pHszJ3PbBQzxPJVaQEBIjOPZYjk8c2Bd5VsqJ
	 kZAX5tODRrt0M/mF1lJwNFWwAH0QyLTkk6JZ87x9qiFJnCxmWAwJ6ktFcX++2W0UpP
	 bF3s2XtuIx5J2aVFAL8jd5vcZyTASLLxRcn9D0kLK1/9oumNB5T5f3biD5Z736NZrw
	 /XZNnNR0YcVYQ==
Received: by x201s (Postfix, from userid 1000)
	id AF31C204548; Sun, 09 Jun 2024 17:34:29 +0000 (UTC)
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
Subject: [PATCH net-next 3/5] net/mlx5e: flower: validate encapsulation control flags
Date: Sun,  9 Jun 2024 17:33:53 +0000
Message-ID: <20240609173358.193178-4-ast@fiberby.net>
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
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
index 8dfb57f712b0d..721f35e597579 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
@@ -850,6 +850,12 @@ int mlx5e_tc_tun_parse(struct net_device *filter_dev,
 		flow_rule_match_enc_control(rule, &match);
 		addr_type = match.key->addr_type;
 
+		if (flow_rule_has_enc_control_flags(match.mask->flags,
+						    extack)) {
+			err = -EOPNOTSUPP;
+			goto out;
+		}
+
 		/* For tunnel addr_type used same key id`s as for non-tunnel */
 		if (addr_type == FLOW_DISSECTOR_KEY_IPV4_ADDRS) {
 			struct flow_match_ipv4_addrs match;
-- 
2.45.1


