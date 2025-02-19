Return-Path: <linux-rdma+bounces-7853-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70220A3C0E0
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 15:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2279E3BA392
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 13:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71871EA7FC;
	Wed, 19 Feb 2025 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mD5MLQeP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5241E0B61;
	Wed, 19 Feb 2025 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739973078; cv=none; b=GLEPOUl3o2C7Rel+nughXjOszdSu3JhEkaeoEtMJ8RtxoDUiONKKlFpPZsG9nFdpYx/qFFPyTQMWy+GSxPXLmWJOWTak6ZJ8GxrvaT+tzCCPrNYBBJRl84p07+jn3B0GecAiajCUIFfyYf2sxC77Hxk7EwyR9jzzyIVOx0gg72k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739973078; c=relaxed/simple;
	bh=Djbf4KqW2xY32dbdHluYN/2ezxhAVFXdhkJiMbQukAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kul+UoEGCclB5Z4KAWfkF73ZSTrBVJ77RzHHpzVplWXzUjICl4IaMNIuG6pSKMy7THBjFTA1cRGSyQ5dlcQEDmxXLvQb4bv2DRLNnc2ADNGMRbgPC53YTajOOUI9m34uvScaHjzcjEHnedyVMQ7SOtt4fDEt/1J0GWlCz+cbpm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mD5MLQeP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E0BC4CED1;
	Wed, 19 Feb 2025 13:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739973075;
	bh=Djbf4KqW2xY32dbdHluYN/2ezxhAVFXdhkJiMbQukAs=;
	h=From:To:Cc:Subject:Date:From;
	b=mD5MLQePuBA3co7TadcIZ8FuyExS1Lu4iYTWa60nIag6zE2hYC52thT8jM2Gj6tu3
	 hVh8PKwTv/tDG15CmaV+vkbjSozCeA4I8ZIpCZdfYrcwUEyynZsdSDEHgQ9fCg7jFi
	 vho8y3/8vL7jXXhOssH43yIVifxpiXMlFfobO82kU1gKxw9PKD5SEyXTgeNUUgYbAM
	 jz30tXTEaj25NZlLA/ZzpxsK/I/GkfiH6FA/pW69h2Azkg8L0AQtC51qQ4CIAcmmG+
	 9qV8vj8B43sPhHqS+unafmJU+I7Oz3YpZ3PUD4azxX2iSkuL/g4NNbyzD5HPXiHV97
	 9qUnQ/jwX+0pg==
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Ayush Sawal <ayush.sawal@chelsio.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Eric Dumazet <edumazet@google.com>,
	Geetha sowjanya <gakula@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	intel-wired-lan@lists.osuosl.org,
	Jakub Kicinski <kuba@kernel.org>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Louis Peens <louis.peens@corigine.com>,
	netdev@vger.kernel.org,
	oss-drivers@corigine.com,
	Paolo Abeni <pabeni@redhat.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Bharat Bhushan <bharatb.linux@gmail.com>
Subject: [PATCH ipsec-next v1 0/5] Support PMTU in tunnel mode for packet offload
Date: Wed, 19 Feb 2025 15:50:56 +0200
Message-ID: <cover.1739972570.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changelog:
v1:
 * Changed signature and names of functions which set and clear type_offload
 * Fixed typos
 * Add Zhu's ROB tag
v0: https://lore.kernel.org/all/cover.1738778580.git.leon@kernel.org

Hi,

This series refactors the xdo_dev_offload_ok() to be global place for
drivers to check if their offload can perform encryption for xmit
packets.

Such common place gives us an option to check MTU and PMTU at one place.

Thanks

Leon Romanovsky (5):
  xfrm: delay initialization of offload path till its actually requested
  xfrm: simplify SA initialization routine
  xfrm: rely on XFRM offload
  xfrm: provide common xdo_dev_offload_ok callback implementation
  xfrm: check for PMTU in tunnel mode for packet offload

 Documentation/networking/xfrm_device.rst      |  3 +-
 drivers/net/bonding/bond_main.c               | 16 ++----
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   | 21 --------
 .../inline_crypto/ch_ipsec/chcr_ipsec.c       | 16 ------
 .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    | 21 --------
 drivers/net/ethernet/intel/ixgbevf/ipsec.c    | 21 --------
 .../marvell/octeontx2/nic/cn10k_ipsec.c       | 15 ------
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 16 ------
 .../net/ethernet/netronome/nfp/crypto/ipsec.c | 11 ----
 drivers/net/netdevsim/ipsec.c                 | 11 ----
 drivers/net/netdevsim/netdevsim.h             |  1 -
 include/net/xfrm.h                            | 21 +++++++-
 net/xfrm/xfrm_device.c                        | 46 ++++++++++++-----
 net/xfrm/xfrm_output.c                        |  6 ++-
 net/xfrm/xfrm_state.c                         | 50 ++++++++-----------
 net/xfrm/xfrm_user.c                          |  2 +-
 16 files changed, 87 insertions(+), 190 deletions(-)

-- 
2.48.1


