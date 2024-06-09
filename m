Return-Path: <linux-rdma+bounces-3018-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C734901735
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jun 2024 19:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C54521F21153
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jun 2024 17:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A4C481BD;
	Sun,  9 Jun 2024 17:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="Ic9e9W4Y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0273F9D5;
	Sun,  9 Jun 2024 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717954500; cv=none; b=BFz20hREUo7svrgKugHH8UZC+5G3SRAbFxSCIKO2Gn9MMX+qVK1lLXYy4QUSXPbyXNF/T67TtFE9tivLIHw+AKd60EjlbhwpjNTT8LjVuRHC8pAqi13xiKFKOIrCVoWTA803FZCXyvHp+I4XoyL2sns3/q3jt1WafPYOxXXBrQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717954500; c=relaxed/simple;
	bh=hm2q1pAYas67Ju2iLNfJUJWg0g77JqWi5aqqeOyq2mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VhxE12K2Z31bCjz1rLEU8WJ8ul5RYExcFtS/2cpMVZQd+hQxCqqdQxgPwHg5RAPH0csXDsVt1mLNdeTIycuwHeDle9zcu5gtE0vuBQKEPanIu3whvinZ9A7/WBxsTsu65xVTpefbQCSX1fA/cQKoEE3NagqKp8Gk+/CTD+f+3O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=Ic9e9W4Y; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 50297600ED;
	Sun,  9 Jun 2024 17:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1717954494;
	bh=hm2q1pAYas67Ju2iLNfJUJWg0g77JqWi5aqqeOyq2mU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ic9e9W4Y8BjmcpDTY9+Q/CkfT38xO7CLBYrSEE9ZmBawTBHOQ2yNggOM+d4ggtFJA
	 LIR7Q8oPjCNLzjg255uXIRFOwfApHPJlvjbJ7K0+FYdn2Vao1F64Bo22O4BA7hVqHk
	 emdKR5eEiSDKS972m9zuaYZrBIQhAdlDGWljsp+cvO+Gk4/LZE6D67/ZsIpsYsXNgj
	 ffZKUp0RW417VvfICK/LPjth0X+i3otkZWAjmp5QZLKxp6GxM8KFbEe8J3tj+96luS
	 grFhSSuuWzGMgY6uw8LPhp4/x0Z6drNOKqjAFWHss8fmaPGcOhKeR1jI1IlU1950uW
	 U222SYsz2lEnA==
Received: by x201s (Postfix, from userid 1000)
	id B0B4D204266; Sun, 09 Jun 2024 17:34:28 +0000 (UTC)
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
Subject: [PATCH net-next 2/5] sfc: use flow_rule_is_supp_enc_control_flags()
Date: Sun,  9 Jun 2024 17:33:52 +0000
Message-ID: <20240609173358.193178-3-ast@fiberby.net>
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

Change the existing check for unsupported encapsulation control flags,
to use the new helper flow_rule_is_supp_enc_control_flags().

No functional change, only compile tested.

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 drivers/net/ethernet/sfc/tc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sfc/tc.c b/drivers/net/ethernet/sfc/tc.c
index 9d140203e273a..0d93164988fc6 100644
--- a/drivers/net/ethernet/sfc/tc.c
+++ b/drivers/net/ethernet/sfc/tc.c
@@ -387,11 +387,8 @@ static int efx_tc_flower_parse_match(struct efx_nic *efx,
 		struct flow_match_control fm;
 
 		flow_rule_match_enc_control(rule, &fm);
-		if (fm.mask->flags) {
-			NL_SET_ERR_MSG_FMT_MOD(extack, "Unsupported match on enc_control.flags %#x",
-					       fm.mask->flags);
+		if (flow_rule_has_enc_control_flags(fm.mask->flags, extack))
 			return -EOPNOTSUPP;
-		}
 		if (!IS_ALL_ONES(fm.mask->addr_type)) {
 			NL_SET_ERR_MSG_FMT_MOD(extack, "Unsupported enc addr_type mask %u (key %u)",
 					       fm.mask->addr_type,
-- 
2.45.1


