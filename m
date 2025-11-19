Return-Path: <linux-rdma+bounces-14609-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3F3C6C707
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 03:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9CD8634EE56
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 02:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEA32D0608;
	Wed, 19 Nov 2025 02:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aMeaE7X8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852CE24A047
	for <linux-rdma@vger.kernel.org>; Wed, 19 Nov 2025 02:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763520642; cv=none; b=NCvrJa7+7bZt9PtGmfmlBb43lBqcI/UCqb2slg1A4eNty5e/+3v6HhUk2XecDhNomAhL/FBIl8hUsqCCY1pEFWISN5jj+GwXk0SIeGIv2bIJKzCpVt+Ftxb0p5OuKw8Mnh4a/qDq3PdoSTVNhfwq3Kqjx4lL0OGTh4uKbWVQT94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763520642; c=relaxed/simple;
	bh=oASI8lZvOzwQn6SpNUuGmAnjqOmTkocC/M3zGkdECog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FP97jOcPQHLSPLRbqHB38sDJ3ZnOwEp137k6/4ZGtcQZKMxtWDla9gFxhebOJaIeWM2k9AlwEDOe4ff2I6/EpxW4tuaODAHu145lrRTjDgRWrCtvm84xqKtybyNNtPNaF0M5/y9A9seIK8L9qPOR561+VLUYJbRYfyHnJ0tjsOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aMeaE7X8; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-787e84ceaf7so69635797b3.2
        for <linux-rdma@vger.kernel.org>; Tue, 18 Nov 2025 18:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763520639; x=1764125439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V2piU0LZ9m4ZEPcYM7zXazGE2L2mQPsKP360MC0AEh4=;
        b=aMeaE7X8bqmwdKMmeZQmJFA3LmQ1tC8w5E4WX24TwTDXBngMLmn6vyqvemq63Asq+S
         eM6qgfM89koSAHo2HoRmZoNTEIHcgX+FLRl2snXLg51XZE05PB1Hmtvhw8RAMr+fjK2w
         9O9TzTN3qkK9dm57ALCJzOO2mH9wVMqAZPSLT/s56eOZaWX94wVktRp0VsBBgdVvA1H/
         06HyuwM8Yj5fZmJlC8J+LgjWR3bRCVZOO7s0SrATbZS7Ngf/y34X3+R5HimYo3BfKVbN
         C+M0yso8XyOLw1/ko2RQmyIKAChnM0f3xv6wSQ1N3liWAsMrxxsF2zSalfYmWIYz6AjN
         IsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763520639; x=1764125439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2piU0LZ9m4ZEPcYM7zXazGE2L2mQPsKP360MC0AEh4=;
        b=ouN3SH1ziKcRgNkCa9mqbUqjtDt4lBnr6Lr6mAva2p/rciI6kCsZORhAFO+QyUxZgk
         1GDBi5e+0UzGUEy4g9Iq/7+uXvG2bq6uZ6Gvt1SwHnn3oZWbOUKO2t5XSN83iVe7vKnr
         hMeuBYX3V3f4r4n9T/KaZMVHWYr0rp7QAI3XxOeSFlSrpeUwDrf92Dix/Jf73PcnwjPh
         JoiicRmr6Rh04KYK7YH/rsuLqRWmXTUxaLwP7qvUW5mWJGtM1gM+PuSMYKHTBzArLR7u
         u0K5G8ow09cyYSp4SlqpiNXaRWQxdEN5zatNWJMNaktpBgzAgL3a//08Laqkyt+aHhk+
         A+Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVMV4KypP5ZbTKzjlxQonFNAdkWmW6NkGdI0kX7YPDV6wu+Isz/fCQG1YfstAZacplhh4myAWcGGjyd@vger.kernel.org
X-Gm-Message-State: AOJu0YwpNLPc5CLpzMEZYKhhsvdT/8N8kOPh7h49SFCeQf5z2gYsXy71
	nNbi/ypw0gkOULQzf6uIRdjXRywIVj+AiJzc6j8TGWS/38O78y0iBYZw
X-Gm-Gg: ASbGnctJZ4Eqrkw+F2uMJXVgMcoXOcJ4jKC1VDYyU3JT5Hkj04SRqNMreZ/fo8uV1S/
	acWsoViLRbzhIn7D/jhQfIZuOGXw6LtJykGcusvulctJCldUxq3pMKRZjFm54W9lYol4TcFX4U7
	bdq7fOn9mMjUqA4sP2R1N9yXhBiA6/Hd88Iop0fU68gU5JmudLYxO8PCAc+BLXEQQEbRrQy2kxB
	E3ad8VG3w0QMA3UwU7pfO1Xl9hFFpLeO9D+zHavI52IcLnRzMWF207bVNalfOZofS3Lk4W1Vzyr
	J/KmvBxqABdEQnFkWlrwzkxTr3txzlXapN6QPSHVFuzbUaC2GfXZj05jydTeGKGBOUW47dygLGg
	I33pgW02dxePrvTLIoPY6kZs/RjLtZwP5+VW213XRCUNNnP59Njd7fMGQgopmHMmnseyBr9pTfE
	v41A6J2On+JPstPmFEZK4E
X-Google-Smtp-Source: AGHT+IHmPfuA1AfzD47/iHwlrM3QKsLm8uiu8WFR1L4/8ZeMuu0e/fGVu7V4aOsTJ5TB7osUk7vFCA==
X-Received: by 2002:a05:690c:6610:b0:787:d0a2:1cb1 with SMTP id 00721157ae682-78929f16b05mr167103887b3.53.1763520639152;
        Tue, 18 Nov 2025 18:50:39 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:53::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7882214a45fsm58420747b3.41.2025.11.18.18.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 18:50:38 -0800 (PST)
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
	linux-rdma@vger.kernel.org
Subject: [PATCH net-next v5 0/6] devlink: net/mlx5: implement swp_l4_csum_mode via devlink params
Date: Tue, 18 Nov 2025 18:50:30 -0800
Message-ID: <20251119025038.651131-1-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces a new devlink feature for querying param
default values, and resetting params to their default values. This
feature is then used to implement a new mlx5 driver param.

The series starts with two pure refactor patches: one that passes
through the extack to devlink_param::get() implementations. And a
second small refactor that prepares the netlink tlv handling code in
the devlink_param::get() path to better handle default parameter
values.

The third patch introduces the uapi and driver api for default
parameter values. The driver api is opt-in, and both the uapi and
driver api preserve existing behavior when not used by drivers or
userspace.

The fourth patch introduces a new mlx5 driver param, swp_l4_csum_mode,
for controlling tx csum behavior. The "l4_only" value of this param is
a dependency for PSP initialization on CX7 NICs.

Lastly, the series introduces a new driver param with cmode runtime to
netdevsim, and then uses this param in a new testcase for netdevsim
devlink params.

Here are some examples of using the default param uapi with the devlink
cli. Note the devlink cli binary I am using has changes which I am
posting in accompanying series targeting iproute2-next:

  # netdevsim
./devlink dev param show netdevsim/netdevsim0
netdevsim/netdevsim0:
  name max_macs type generic
    values:
      cmode driverinit value 32 default 32
  name test1 type driver-specific
    values:
      cmode driverinit value true default true

  # set to false
./devlink dev param set netdevsim/netdevsim0 name test1 value false cmode driverinit
./devlink dev param show netdevsim/netdevsim0
netdevsim/netdevsim0:
  name max_macs type generic
    values:
      cmode driverinit value 32 default 32
  name test1 type driver-specific
    values:
      cmode driverinit value false default true

  # set back to default
./devlink dev param set netdevsim/netdevsim0 name test1 default cmode driverinit
./devlink dev param show netdevsim/netdevsim0
netdevsim/netdevsim0:
  name max_macs type generic
    values:
      cmode driverinit value 32 default 32
  name test1 type driver-specific
    values:
      cmode driverinit value true default true

 # mlx5 params on cx7
./devlink dev param show pci/0000:01:00.0
pci/0000:01:00.0:
  name max_macs type generic
    values:
      cmode driverinit value 128 default 128
...
  name swp_l4_csum_mode type driver-specific
    values:
      cmode permanent value default default default

  # set to l4_only
./devlink dev param set pci/0000:01:00.0 name swp_l4_csum_mode value l4_only cmode permanent
./devlink dev param show pci/0000:01:00.0 name swp_l4_csum_mode
pci/0000:01:00.0:
  name swp_l4_csum_mode type driver-specific
    values:
      cmode permanent value l4_only default default

  # reset to default
./devlink dev param set pci/0000:01:00.0 name swp_l4_csum_mode default cmode permanent
./devlink dev param show pci/0000:01:00.0 name swp_l4_csum_mode
pci/0000:01:00.0:
  name swp_l4_csum_mode type driver-specific
    values:
      cmode permanent value default default default

CHANGES:
v5:
  - use define instead of magic value for test2 param default handlers
v4: https://lore.kernel.org/netdev/20251118002433.332272-1-daniel.zahka@gmail.com/
  - add test case for default params.
  - add new cmode runtime test param to netdevsim.
  - introduce uapi and driver api for supporting default param values.
  - rename device_default to default in mlx5 patch.
v3: https://lore.kernel.org/netdev/20251107204347.4060542-1-daniel.zahka@gmail.com/
  - fix warnings about undocumented param in intel ice driver
v2: https://lore.kernel.org/netdev/20251103194554.3203178-1-daniel.zahka@gmail.com/
  - fix indentation issue in new mlx5.rst entry
  - use extack in mlx5_nv_param_devlink_swp_l4_csum_mode_get()
  - introduce extack patch.
v1: https://lore.kernel.org/netdev/20251022190932.1073898-1-daniel.zahka@gmail.com/

Daniel Zahka (6):
  devlink: pass extack through to devlink_param::get()
  devlink: refactor devlink_nl_param_value_fill_one()
  devlink: support default values for param-get and param-set
  net/mlx5: implement swp_l4_csum_mode via devlink params
  netdevsim: register a new devlink param with default value interface
  selftest: netdevsim: test devlink default params

 Documentation/netlink/specs/devlink.yaml      |   9 +
 .../networking/devlink/devlink-params.rst     |  10 +
 Documentation/networking/devlink/mlx5.rst     |  14 ++
 .../marvell/octeontx2/otx2_cpt_devlink.c      |   6 +-
 drivers/net/ethernet/amd/pds_core/core.h      |   3 +-
 drivers/net/ethernet/amd/pds_core/devlink.c   |   3 +-
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   6 +-
 .../net/ethernet/intel/i40e/i40e_devlink.c    |   3 +-
 .../net/ethernet/intel/ice/devlink/devlink.c  |  14 +-
 .../marvell/octeontx2/af/rvu_devlink.c        |  15 +-
 .../marvell/octeontx2/nic/otx2_devlink.c      |   6 +-
 drivers/net/ethernet/mellanox/mlx4/main.c     |   6 +-
 .../net/ethernet/mellanox/mlx5/core/devlink.h |   3 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   3 +-
 .../mellanox/mlx5/core/eswitch_offloads.c     |   3 +-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |   3 +-
 .../ethernet/mellanox/mlx5/core/fw_reset.c    |   3 +-
 .../mellanox/mlx5/core/lib/nv_param.c         | 238 +++++++++++++++++-
 .../mellanox/mlxsw/spectrum_acl_tcam.c        |   3 +-
 .../ethernet/netronome/nfp/devlink_param.c    |   3 +-
 drivers/net/ethernet/qlogic/qed/qed_devlink.c |   3 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |   3 +-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      |   3 +-
 drivers/net/ethernet/ti/cpsw_new.c            |   6 +-
 drivers/net/netdevsim/dev.c                   |  56 +++++
 drivers/net/netdevsim/netdevsim.h             |   1 +
 drivers/net/wwan/iosm/iosm_ipc_devlink.c      |   3 +-
 include/net/devlink.h                         |  45 +++-
 include/net/dsa.h                             |   3 +-
 include/uapi/linux/devlink.h                  |   3 +
 net/devlink/netlink_gen.c                     |   5 +-
 net/devlink/param.c                           | 180 +++++++++----
 net/dsa/devlink.c                             |   3 +-
 .../drivers/net/netdevsim/devlink.sh          | 116 ++++++++-
 34 files changed, 693 insertions(+), 91 deletions(-)

-- 
2.47.3


