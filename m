Return-Path: <linux-rdma+bounces-3020-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BC790173F
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jun 2024 19:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF111F2129E
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jun 2024 17:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A70F4D8A5;
	Sun,  9 Jun 2024 17:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="EdXQqAH7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C83D2E5;
	Sun,  9 Jun 2024 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717954500; cv=none; b=mfnQTM/XkSY/DTv2Spb1B2qrTYtBqW7zOdVnDaBu39NrCxJIASdK49hF32P+0TOuVaY9qovfs+nRh03QGhCyscK3KCvboX85k9HI7XYwKJgaWJbIRXTKsGAK0940uVqfH9/o18aQxDIPA4hHZXEVpwwL/prNjJ3Vq83wWhYV76U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717954500; c=relaxed/simple;
	bh=JkrJak/o4liAaLBMuPCt9zcaNAf1wkkZu0Qot3yV6wg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tPp87dB7qJUlnF/gCcPWLgFWbVXDv4y4+aFnydeTtDokvhqmCfeWKmA6k9sPe81s09dNpY0zv68AFkOqxDaMbBDRV/UiUah8GY2miAZJs5eY8rzAgWgDHNHk1AHXp1zItffDnm7COFBf9U0f2Ec4+gm99BnvBSY08MUhwVFwpgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=EdXQqAH7; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id DE3E4600B1;
	Sun,  9 Jun 2024 17:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1717954494;
	bh=JkrJak/o4liAaLBMuPCt9zcaNAf1wkkZu0Qot3yV6wg=;
	h=From:To:Cc:Subject:Date:From;
	b=EdXQqAH7a3qGW2gZRnfJJiAl70D1KwnUMbIefvkUaBBW79a5LcPm2PPvDwjOgGtpF
	 nW2eIz5JrhxlPCkcB12sd2bqWz8zm+KB2lHJXfINxhQc+aXZBmBvD37CqzD5xr23eH
	 5haAvzvvdeM0JbwSzDTDwLEX7Vwi2unAgwNrjB8O4cXhz2mBYsx8LrtxrmiHtnLgkE
	 ZgA1C5BrRNuQN5HFjihLedleg9fEqnFF7alBEFvz69z1SDwsBOMXiLVIr5hDJCROa3
	 zONw2GyEI7FqiCMlSKbYJphr6KSLN6e2Aq4QbryqRP3jLSkYXbj6oHbLNI50VyZXC+
	 PcC8O0/pko9GQ==
Received: by x201s (Postfix, from userid 1000)
	id BD5A520407A; Sun, 09 Jun 2024 17:34:24 +0000 (UTC)
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
Subject: [PATCH net-next 0/5] net: flower: validate encapsulation control flags
Date: Sun,  9 Jun 2024 17:33:50 +0000
Message-ID: <20240609173358.193178-1-ast@fiberby.net>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now that all drivers properly rejects unsupported flower control flags
used with FLOW_DISSECTOR_KEY_CONTROL, then time has come to add similar
checks to the drivers supporting FLOW_DISSECTOR_KEY_ENC_CONTROL.

There are currently just 4 drivers supporting this key, and
3 of those currently doesn't validate encapsulated control flags.

Encapsulation control flags may currently be unused, but they should
still be validated by the drivers, so that drivers will properly
reject any new flags when they are introduced.

This series adds some helper functions, and implements them in all
4 drivers.

NB: It is currently discussed[1] to use encapsulation control flags
for tunnel flags instead of the new FLOW_DISSECTOR_KEY_ENC_FLAGS.

[1] https://lore.kernel.org/netdev/ZmFuxElwZiYJzBkh@dcaratti.users.ipa.redhat.com/

Asbjørn Sloth Tønnesen (5):
  flow_offload: add encapsulation control flag helpers
  sfc: use flow_rule_is_supp_enc_control_flags()
  net/mlx5e: flower: validate encapsulation control flags
  nfp: flower: validate encapsulation control flags
  ice: flower: validate encapsulation control flags

 drivers/net/ethernet/intel/ice/ice_tc_lib.c   |  4 +++
 .../ethernet/mellanox/mlx5/core/en/tc_tun.c   |  6 ++++
 .../ethernet/netronome/nfp/flower/offload.c   |  4 +++
 drivers/net/ethernet/sfc/tc.c                 |  5 +--
 include/net/flow_offload.h                    | 35 +++++++++++++++++++
 5 files changed, 50 insertions(+), 4 deletions(-)

-- 
2.45.1


