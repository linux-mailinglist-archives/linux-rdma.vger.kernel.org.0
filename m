Return-Path: <linux-rdma+bounces-14310-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 288E5C419AB
	for <lists+linux-rdma@lfdr.de>; Fri, 07 Nov 2025 21:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4A4714E46A7
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Nov 2025 20:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4A430EF9A;
	Fri,  7 Nov 2025 20:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/EUxcwY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1EA30E859
	for <linux-rdma@vger.kernel.org>; Fri,  7 Nov 2025 20:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762548232; cv=none; b=XcgVSRLfjKP9W7r9iaLQTzL3w+B0uTxaMQW8uIxSc3FwSM/1x3lPvlPCTWqziQXOta9Uzf51NUYadml6tXfgAZOoUWNEDy0oD7hcH3Lcl264WNYC4lEilvnNx7KxCFlizrsr6hEt1A0OMX+kJ4+c9uao9ZZoikcwM8i7frKV69w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762548232; c=relaxed/simple;
	bh=qFvHlFClaLB3SpilbePUPYNZu398dyd+SrzdKJ5UzVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ud4GnYeW6MOmffyWDNSWqmVqUtc3tVo4zNbGpK0NeSqI+OP6C2EyRMyIIibxcJsBdm6PtQH4grBCXlVJ/MJ+hiCWKdWtiad3CkLRUC58JyK2O4N4RUYHPEILY8xskS1DlXuZj06oLv4M6mILrgtyRwZeP2qYbpG70tB6L5R2kaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/EUxcwY; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63f976ef4bdso1083585d50.1
        for <linux-rdma@vger.kernel.org>; Fri, 07 Nov 2025 12:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762548229; x=1763153029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hiMcVVi9rEIv/j5eQ05ENk15pvqtAPzV3c3AT9Vw3fI=;
        b=P/EUxcwYNFj3smgfH3m7jnXYnCZVlsnr615JUTpLxM9QGQ9uvSNW7Sz1H0G1GzNRum
         0b2Q2DdYwbZAWRB8JrzzPWGOe75JjYFaWKtLvhcZMnDwuGZfwO5a+HSUb29rHO9bNjIQ
         t9yG0sgt8IZSRy+mX1ZBnuBfzQwU9AYZ2QdEo+kNntSGTfmNeRUwSnUFLxtkqsXA94El
         +ON80Ojrdp7CgimyWwUcD2ItF2PEmV8aui1pWFqKR47Qn43a0M+oxK/rzLgQfaeDE0tA
         ib+oA12Ytw3XRDYp6HffpyYxODXX8Zrh699RkXPXErP6KN6J4trQZkJRkOaLbvtbM6IH
         ZVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762548229; x=1763153029;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hiMcVVi9rEIv/j5eQ05ENk15pvqtAPzV3c3AT9Vw3fI=;
        b=m+wYkQDWofBjwkGAGYrDFdCpjMbtcpJO0mioCCr7cxYm/gjl8q/wHGSi32Cy+IN3Ua
         MZAxyk+3DAwV5yygn8Zwf8ruRGTAYonGxEuGAZ3+54K4wIKhaLsvXa6T93jhnQ5Q6Jh+
         Ch1Mu8PrvE5mSOnd1OVhw+sqmAQ05YiVeGex5kN/n76rWj3ylOeOf02FvNXFT+zbnTWr
         22KGTpI4AKzVWvWVk6cs0Bk3XEUBv2oxnTltSIZjjk6Ej2cdkkYH5Jpt9ckPLZIofVaw
         svdsuFm5B4eOFZtKFcwmxWiIWVAzn+c8jlP8pbST+VmjD6JZRKkssGarncII0MPEUeNF
         5U2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxQ2baeoVK4kZ2E1AvwPgyWQ52gxwOEwNsBBqm7i08Y5FywXMgnMkJipNJNYKWa/OvhELvbxsj6d4V@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0xLawfdyLHycXMvvGxWZHMZmy+aAL+aNgis4/xF0qYg8MyEFU
	vMoGmhjD6Q+scK4Tkkj6BFK50W4AfqPwXVM/270jfRUUoCz47QMjARVA
X-Gm-Gg: ASbGncsbzsC1pBc1/ZH6gX61pAb4vHt4hxEPcCw9bKJAsIaGZS2G5VYjfa5MKIjGTWw
	tsUehGBv71+lQy77+snYChNPDB6lLt4uxhAU2ntlzgjd1m86i8D/T6DJXAgX5zZ3GTtrZZwPit5
	GDFpnozcuASGiFY6cwX17W2FyHV/YzVr/Hh1kYVZsnXOIqz0E39qYhfxa3E8Kh3gfagTO8SW94r
	A2BEinXeymH0Cm9GqVl4oMKCQ9os77OVctzYL7vm2Rr0ef3UBbsSNg4BB7UlJ9efCiSOsd6KU2t
	gn3Wk1pGDgZe/Wj5RqjR1YSKAnk3UUaSFODSrfPEvUv6ntnO0swhCCVFa+xSOBbg0J4n1iebfWu
	BIa6s82idPP3/e/0gavlV13RfqWm+qeg2jJrUdUisvqxsEQd4viPlXldj5uBW3F6vaplqQSDN7k
	0WXIWKleyM9C37heT449g=
X-Google-Smtp-Source: AGHT+IFI8VG0P0n7qrm0zcp7SSN4eaMEgytqB19PsfLf5CxPVrAGvs9YLrEVD7m3nAlBeq12jFghtw==
X-Received: by 2002:a05:690e:160f:b0:63f:a4d7:b523 with SMTP id 956f58d0204a3-640d45527c6mr354482d50.28.1762548228918;
        Fri, 07 Nov 2025 12:43:48 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:b::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-640b5d81427sm2087281d50.18.2025.11.07.12.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 12:43:48 -0800 (PST)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Brett Creeley <brett.creeley@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Mark Bloch <mbloch@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Manish Chopra <manishc@marvell.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Vladimir Oltean <olteanv@gmail.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Dave Ertman <david.m.ertman@intel.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-omap@vger.kernel.org
Subject: [PATCH net-next v3 0/2] devlink: net/mlx5: implement swp_l4_csum_mode via devlink params
Date: Fri,  7 Nov 2025 12:43:44 -0800
Message-ID: <20251107204347.4060542-1-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains two patches. The first is a pure refactor that
passes through the extack to devlink_param::get() implementations. The
second introduces a permanent devlink param to the mlx5 driver for
controlling tx csum behavior.

Enabling extack for devlink_param::get() allows drivers to provide
more information in cases when reading parameters from hardware can
result in errors or unexpected values.

The mlx5 swp_l4_csum_mode devlink param is necessary for initializing
PSP on CX7 NICs.

CHANGES:
v3:
  - fix warnings about undocumented param in intel ice driver
v2: https://lore.kernel.org/netdev/20251103194554.3203178-1-daniel.zahka@gmail.com/
  - fix indentation issue in new mlx5.rst entry
  - use extack in mlx5_nv_param_devlink_swp_l4_csum_mode_get()
  - introduce extack patch.
v1: https://lore.kernel.org/netdev/20251022190932.1073898-1-daniel.zahka@gmail.com/

Daniel Zahka (2):
  devlink: pass extack through to devlink_param::get()
  net/mlx5: implement swp_l4_csum_mode via devlink params

 Documentation/networking/devlink/mlx5.rst     |   9 +
 .../marvell/octeontx2/otx2_cpt_devlink.c      |   6 +-
 drivers/net/ethernet/amd/pds_core/core.h      |   3 +-
 drivers/net/ethernet/amd/pds_core/devlink.c   |   3 +-
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   6 +-
 .../net/ethernet/intel/ice/devlink/devlink.c  |  14 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |  15 +-
 .../marvell/octeontx2/nic/otx2_devlink.c      |   6 +-
 drivers/net/ethernet/mellanox/mlx4/main.c     |   6 +-
 .../net/ethernet/mellanox/mlx5/core/devlink.h |   3 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   3 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |   3 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |   3 +-
 .../ethernet/mellanox/mlx5/core/fw_reset.c    |   3 +-
 .../mellanox/mlx5/core/lib/nv_param.c         | 170 +++++++++++++++++-
 .../mellanox/mlxsw/spectrum_acl_tcam.c        |   3 +-
 .../ethernet/netronome/nfp/devlink_param.c    |   3 +-
 drivers/net/ethernet/qlogic/qed/qed_devlink.c |   3 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   3 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      |   3 +-
 drivers/net/ethernet/ti/cpsw_new.c            |   6 +-
 drivers/net/wwan/iosm/iosm_ipc_devlink.c      |   3 +-
 include/net/devlink.h                         |   3 +-
 include/net/dsa.h                             |   3 +-
 net/devlink/param.c                           |  19 +-
 net/dsa/devlink.c                             |   3 +-
 26 files changed, 259 insertions(+), 46 deletions(-)

-- 
2.47.3


