Return-Path: <linux-rdma+bounces-3023-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2216901748
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jun 2024 19:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B351C20885
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jun 2024 17:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388CE54662;
	Sun,  9 Jun 2024 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Wwg+YYBt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64221DDBD;
	Sun,  9 Jun 2024 17:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717954502; cv=none; b=WY/IphA9K95zY9V6y1s9KmYZehH96z4bp3HznCbnSH0jrYhL1rFvMJt9BWWJLZKSSkUmsjSKhlpL1ShH1gPX9MR1+k0MPjAUcvXYQxrxeq86EOGAHusCp/eFGGUffv4wxrE2+1OHTgx/Vjj97R9/DBseOF3iY9TEGiAV1O9X0ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717954502; c=relaxed/simple;
	bh=cl0aiIt/dZ9YtxYR73dSSBkiTYMjyEA8XSxLZyngtK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VqRX9UYiBDs/wqN/BqpW/VHGdE9K58RJpiJBG5c4sjtvjPQjmjTOUz6Rb/yAVlx/HEzu+TIaXJ71CsXn/A9QcFsWL3WYonDOKOS+JslO/EhEdQtFzsthVIpHA3s8IKgS8uh9NkZSAedGogNjfxQryOgSlkD0/v4G/vImZmjJvFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Wwg+YYBt; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 09296600B7;
	Sun,  9 Jun 2024 17:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1717954494;
	bh=cl0aiIt/dZ9YtxYR73dSSBkiTYMjyEA8XSxLZyngtK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wwg+YYBtm2XkgMY8PmuH/t/5FPrAPDtG/4EAGWw0yHJp/rJevS53Cz3wAgOV2AkS6
	 6twxiIYhYjrC5317y6NvKdibxyILjacUAJMlXy1Xh3H4iyVYokzkpzq84FA9EFBWgS
	 Jv4NwEjxTX+fZQhja2sbyI4M8WjmfPe6+T+QcjiIcf5WIQr/tzYhyNZMH/KtIVki71
	 EOX1xjQ5+z0b7A1HGkfWK1F+Ws3lrAPgZiaobkokOhKLcD3BBybjnIkAAIsc/6ia1d
	 +OjOOKU9n7UdLP5hCQ+nw0F3TfiKCR0FwFzC5HnK/7kUkkWLE27Q1IRdrStBGjqfyt
	 Wn7llF2lrlppQ==
Received: by x201s (Postfix, from userid 1000)
	id D566D204209; Sun, 09 Jun 2024 17:34:26 +0000 (UTC)
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
Subject: [PATCH net-next 1/5] flow_offload: add encapsulation control flag helpers
Date: Sun,  9 Jun 2024 17:33:51 +0000
Message-ID: <20240609173358.193178-2-ast@fiberby.net>
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

This patch adds two new helper functions:
  flow_rule_is_supp_enc_control_flags()
  flow_rule_has_enc_control_flags()

They are intended to be used for validating encapsulation control
flags, and compliment the similar helpers without "enc_" in the name.

The only difference is that they have their own error message,
to make it obvious if an unsupported flag error is related to
FLOW_DISSECTOR_KEY_CONTROL or FLOW_DISSECTOR_KEY_ENC_CONTROL.

flow_rule_has_enc_control_flags() is for drivers supporting
FLOW_DISSECTOR_KEY_ENC_CONTROL, but not supporting any
encapsulation control flags.
(Currently all 4 drivers fits this category)

flow_rule_is_supp_enc_control_flags() is currently only used
for the above helper, but should also be used by drivers once
they implement at least one encapsulation control flag.

There is AFAICT currently no need for an "enc_" variant of
flow_rule_match_has_control_flags(), as all drivers currently
supporting FLOW_DISSECTOR_KEY_ENC_CONTROL, are already calling
flow_rule_match_enc_control() directly.

Only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 include/net/flow_offload.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/include/net/flow_offload.h b/include/net/flow_offload.h
index ec9f80509f60c..292cd8f4b762a 100644
--- a/include/net/flow_offload.h
+++ b/include/net/flow_offload.h
@@ -471,6 +471,28 @@ static inline bool flow_rule_is_supp_control_flags(const u32 supp_flags,
 	return false;
 }
 
+/**
+ * flow_rule_is_supp_enc_control_flags() - check for supported control flags
+ * @supp_enc_flags: encapsulation control flags supported by driver
+ * @enc_ctrl_flags: encapsulation control flags present in rule
+ * @extack: The netlink extended ACK for reporting errors.
+ *
+ * Return: true if only supported control flags are set, false otherwise.
+ */
+static inline bool flow_rule_is_supp_enc_control_flags(const u32 supp_enc_flags,
+						       const u32 enc_ctrl_flags,
+						       struct netlink_ext_ack *extack)
+{
+	if (likely((enc_ctrl_flags & ~supp_enc_flags) == 0))
+		return true;
+
+	NL_SET_ERR_MSG_FMT_MOD(extack,
+			       "Unsupported match on enc_control.flags %#x",
+			       enc_ctrl_flags);
+
+	return false;
+}
+
 /**
  * flow_rule_has_control_flags() - check for presence of any control flags
  * @ctrl_flags: control flags present in rule
@@ -484,6 +506,19 @@ static inline bool flow_rule_has_control_flags(const u32 ctrl_flags,
 	return !flow_rule_is_supp_control_flags(0, ctrl_flags, extack);
 }
 
+/**
+ * flow_rule_has_enc_control_flags() - check for presence of any control flags
+ * @enc_ctrl_flags: encapsulation control flags present in rule
+ * @extack: The netlink extended ACK for reporting errors.
+ *
+ * Return: true if control flags are set, false otherwise.
+ */
+static inline bool flow_rule_has_enc_control_flags(const u32 enc_ctrl_flags,
+						   struct netlink_ext_ack *extack)
+{
+	return !flow_rule_is_supp_enc_control_flags(0, enc_ctrl_flags, extack);
+}
+
 /**
  * flow_rule_match_has_control_flags() - match and check for any control flags
  * @rule: The flow_rule under evaluation.
-- 
2.45.1


