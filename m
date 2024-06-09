Return-Path: <linux-rdma+bounces-3019-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E5E90173B
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jun 2024 19:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BCAD1C20942
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jun 2024 17:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38B04AEC8;
	Sun,  9 Jun 2024 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="fyPN2pAj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99DF46421;
	Sun,  9 Jun 2024 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717954500; cv=none; b=k/NiwVXiWzY7m23g0L5hLMc/3UrE6XOLrQJvN/Szl3dyn0oOWC/nhHhg5WPkVbgKQstFXbaVVNJlR8lwh4gGQUO8qAn0kkP2y0A7so6tT4bu0zxsArCpxRHJq2WjXdr6A3aWmtQVErevJakSg6jSfOWEQLN8c4FgHqI1Ug34170=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717954500; c=relaxed/simple;
	bh=ZDyN6Vf+52VBTThrkt6kfLAKDIBCA/WrvNpGqsChE9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2jbl5B/pqor6y4zFPmmeP/3Ka1T6yStzYbSpJLFRZikt3M/ft4EMrlgUPAQ/qK2tPsuxH/LVQFhy/nJ5mudM1H7XMFbrmMd6av+tbiBYqNs8kAWPHE67C+z+4UFTGs6tCCUrHP6RYRXNojrWAfacuMh2yGUVulWDo9+E+GYEs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=fyPN2pAj; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 0B942600DC;
	Sun,  9 Jun 2024 17:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1717954494;
	bh=ZDyN6Vf+52VBTThrkt6kfLAKDIBCA/WrvNpGqsChE9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fyPN2pAjzXZRM/MlyRtHzCD15pnXfj/ao/uVpN1HhdM1z900W9DGQ/YlUM98+reJc
	 fdWBFXzsXYYkk9i3s+TxGzJOY1kE3yRx25Er6W/g8EMpZDXii5fWJdlT85RgH3Dh9X
	 BqIzlwaf0T02nIePnnuJzx7F3aLoZtK8sv38IZmBR9C1pLhyj1BqvnURatxHt7cdSN
	 h41YWCRZl0gp1Kxpr1y5F1OloHCyxAJyC7Mu82Ez4B9Fucc0epw1D5MwfFJGhi6c7T
	 fi+c7whaMwimgMKPAiP/w5wlkoj8wuyjMbWbtPLqKCxWRnlswfKPTJR3308q2Wxuhm
	 0Dl0NHsrTJFRQ==
Received: by x201s (Postfix, from userid 1000)
	id 2D227204695; Sun, 09 Jun 2024 17:34:31 +0000 (UTC)
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
Subject: [PATCH net-next 5/5] ice: flower: validate encapsulation control flags
Date: Sun,  9 Jun 2024 17:33:55 +0000
Message-ID: <20240609173358.193178-6-ast@fiberby.net>
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
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index 8bd24b33f3a67..e6923f8121a99 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -1353,6 +1353,7 @@ ice_parse_tunnel_attr(struct net_device *dev, struct flow_rule *rule,
 		      struct ice_tc_flower_fltr *fltr)
 {
 	struct ice_tc_flower_lyr_2_4_hdrs *headers = &fltr->outer_headers;
+	struct netlink_ext_ack *extack = fltr->extack;
 	struct flow_match_control enc_control;
 
 	fltr->tunnel_type = ice_tc_tun_get_type(dev);
@@ -1373,6 +1374,9 @@ ice_parse_tunnel_attr(struct net_device *dev, struct flow_rule *rule,
 
 	flow_rule_match_enc_control(rule, &enc_control);
 
+	if (flow_rule_has_enc_control_flags(enc_control.mask->flags, extack))
+		return -EOPNOTSUPP;
+
 	if (enc_control.key->addr_type == FLOW_DISSECTOR_KEY_IPV4_ADDRS) {
 		struct flow_match_ipv4_addrs match;
 
-- 
2.45.1


