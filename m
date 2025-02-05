Return-Path: <linux-rdma+bounces-7455-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57159A298A0
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 19:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E407016838E
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 18:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035661FCD1F;
	Wed,  5 Feb 2025 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqYWYkcM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3081779AE;
	Wed,  5 Feb 2025 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738779639; cv=none; b=LRxTEDutNwRzeA6X+7qdvgcVn1msjQqoxRtN0Ht3HGq36VC/i1j+MLpmUvwoQyn/Q3d2jiFOj4V34j73r8+aA2A9rsp/vPzIxB21l225ZkvKzH5TKEXNy+Vbt0mOW1QPWDkZEoZEu8CD84JyvjajUzjA/HEzp55QiF+WuJd+kcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738779639; c=relaxed/simple;
	bh=WM5rllHSSQ5cLPRxWaqxDpADFHh0zDNaSDIlvDY+JxM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G/zPOyZ9STYpHH/vvSpJ9TgkbdqrkB9B9GAJ1tzlfL4gmFhoebv5Abosc9WFaZZb8+bxfIV9akYPNEh8OlHqpzKplP+ktUTIlAdPhJGhJ7TyBOiyOxM6KC0UMRP8B+noU2hSAjmQtygWWD4SnDFWmlRy3K+/UCDf/qJUMDHNsJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqYWYkcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721CFC4CED1;
	Wed,  5 Feb 2025 18:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738779639;
	bh=WM5rllHSSQ5cLPRxWaqxDpADFHh0zDNaSDIlvDY+JxM=;
	h=From:To:Cc:Subject:Date:From;
	b=YqYWYkcMGa0v+i6qaCS/cxhsjs4s4RDlavCy7IPsxr/13fNNjaqsjdG+GqcLg0/QR
	 zSb/XWRMn9OMnJBALnM2Q8lzvwcI9LB4Zf+Nj3w8Y06sEBw/sy/EjcU0c6M55i59YW
	 +92U3VZ5zLxvddUmf3jttdkvpR9kwL6QiS1tRvgzy2QigC8Mmz2etLa6s0L3zwQVd3
	 /BVOQW4Z0rg9jdx1nD1L7+83vYJn1/Qx9xwNpvHt482RlpryJ4nktXh/omVrtu7WA3
	 laI4LnePfKcr2UYtxAgK65FYzeoRXBT2I5iZy3KAWO2VGkY8jRwXgCNsJ7MGeWOxly
	 tEYCJTOThuLtw==
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
	Ilia Lin <ilia.lin@kernel.org>
Subject: [PATCH ipsec-next 0/5] Support PTMU in tunnel mode for packet offload 
Date: Wed,  5 Feb 2025 20:20:19 +0200
Message-ID: <cover.1738778580.git.leon@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series refactors the xdo_dev_offload_ok() to be global place for
drivers to check if their offload can perform encryption for xmit packets.

Such common place gives us an option to check MTU and PMTU at one place.

Thanks

Leon Romanovsky (5):
  xfrm: delay initialization of offload path till its actually requested
  xfrm: simplify SA initialization routine
  xfrm: rely on XFRM offload
  xfrm: provide common xdo_dev_offload_ok callback implementation
  xfrm: check for PMTU in tunnel mode for packet offload

 Documentation/networking/xfrm_device.rst      |  3 +-
 drivers/net/bonding/bond_main.c               | 16 ++-----
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   | 21 ---------
 .../inline_crypto/ch_ipsec/chcr_ipsec.c       | 16 -------
 .../net/ethernet/intel/ixgbe/ixgbe_ipsec.c    | 21 ---------
 drivers/net/ethernet/intel/ixgbevf/ipsec.c    | 21 ---------
 .../marvell/octeontx2/nic/cn10k_ipsec.c       | 15 ------
 .../mellanox/mlx5/core/en_accel/ipsec.c       | 16 -------
 .../net/ethernet/netronome/nfp/crypto/ipsec.c | 11 -----
 drivers/net/netdevsim/ipsec.c                 | 11 -----
 drivers/net/netdevsim/netdevsim.h             |  1 -
 include/net/xfrm.h                            | 22 ++++++++-
 net/xfrm/xfrm_device.c                        | 47 ++++++++++++++-----
 net/xfrm/xfrm_output.c                        |  6 ++-
 net/xfrm/xfrm_state.c                         | 40 +++++++---------
 net/xfrm/xfrm_user.c                          |  2 +-
 16 files changed, 84 insertions(+), 185 deletions(-)

-- 
2.48.1


