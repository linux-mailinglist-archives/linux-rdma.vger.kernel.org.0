Return-Path: <linux-rdma+bounces-5383-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4368599AB5C
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2024 20:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4B5AB2357E
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2024 18:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B11501CFEBB;
	Fri, 11 Oct 2024 18:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="N53s+6K3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219BE1CF7BC
	for <linux-rdma@vger.kernel.org>; Fri, 11 Oct 2024 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672340; cv=none; b=FKCz2WIQnGV+NCjA7z8vJVWq4dxA5BUfNqwru/BLXSyiSk5pkQ5f/IrldvTj6Veevl76HEqUYMBF9pqCBtNpPyv+sNoNowZxb0s29SEjzrGUhD6Vyw7NcocEgh5kOul0bEvVBcCCsUDgrbLM2mMnvQlg0gIhDlECpdgcaUpS07I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672340; c=relaxed/simple;
	bh=m4zEurLSIowkG1BU89Y09hG0IQtU4YZ8ThO2HacCs2o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JplM14xTEaVASXlDbR6U/ZWqwbvumupBQ4ohzmOufwacMqcnqvnsA+JdoTkBHKU2joNR0wFfXkguteYC23NJDDwFyrxI7brCnDf6WbXQh7Y7Nk3PWSupQGlOmRO/v8x2qMu5yWw+89gRPU1nX5kca57vOlas7VGzrkzwyFsZN/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=N53s+6K3; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2a97c2681so1853671a91.2
        for <linux-rdma@vger.kernel.org>; Fri, 11 Oct 2024 11:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728672336; x=1729277136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oKmvUl58ZL67PwG/wy6wWDWK+27fZtS0ajIATHzarmE=;
        b=N53s+6K3p/qQ3DbaE95Qh2del0+r96Hzkm+QmRsn/hkNjW0/gvTUceq5DFQFwitg/T
         XiIPAYnFkFFDu+ZTc+ZngjyZ6BO3YiJ1ysR7ntmMMtvmNXW66gkpKs5R4ic86deloG9m
         ebUnv/zohzOeP6RzaxlzfjSwBSr7XKBcQJ9mY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672336; x=1729277136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKmvUl58ZL67PwG/wy6wWDWK+27fZtS0ajIATHzarmE=;
        b=KQUFYaCBrXeF0kggyxzRjklDajFzXli8S+32mRota5SIIVIn8jvXlPwo3JCzJ3Uw1D
         DEgrByqBE7xkNC/L44PhlY+JyujidNJrM5BNUIzRDZm5rxlHMYhDgvjUKQJgW8H2JGKU
         5E4Tht6olIW60wcDdm6OcSZnEuoLHkfS2em6S2TTrR294/zzRIw+8a+4dE25FovasN9k
         aA6bL9zU3KisctuGZ0p4a9z0eymajcEt2w4lvcobkmp/ua/3zYIT3e89NUVpbFu3i6DJ
         9F3iY59AOGIy+r6fxgu/h/7yR0BcK7rGNCbEhh1lgQL54impCvY/XCMDOeQqAgnrPXtL
         VH4w==
X-Forwarded-Encrypted: i=1; AJvYcCUPpoyT9T1Tqn+aTRotvtcPAFT3WxVE7hGiMXG9Xf/TvAz489GbhxRw7lwUPAtAFNjUy1vgVbHrypq/@vger.kernel.org
X-Gm-Message-State: AOJu0YwLmHNRXSDZBnkoBqHV5/DYbnkKO9wcDrzwdePZ93LJBd5PIPmL
	Z6gPHyq30h7fc2wyI4CvYQwM3fakKNRGheseiYK5OMz4iyyH32zZZVik/NBftdQ=
X-Google-Smtp-Source: AGHT+IFKjtvecdtTFBqd8QVRtstOnijts0k4i3j92lQmJyypvtoQbMfzHGaxSfKHNfnYBFCF3FEb1g==
X-Received: by 2002:a17:90b:218c:b0:2e2:b46f:d92a with SMTP id 98e67ed59e1d1-2e2f0a98b0cmr3925325a91.14.1728672336379;
        Fri, 11 Oct 2024 11:45:36 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e30d848e1csm687625a91.42.2024.10.11.11.45.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:45:35 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	edumazet@google.com,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Daniel Jurgens <danielj@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver),
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Mina Almasry <almasrymina@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tariq Toukan <tariqt@nvidia.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [net-next v6 0/9] Add support for per-NAPI config via netlink
Date: Fri, 11 Oct 2024 18:44:55 +0000
Message-Id: <20241011184527.16393-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to v6. Minor changes from v5 [1], please see changelog below.

There were no explicit comments from reviewers on the call outs in my
v5, so I'm retaining them from my previous cover letter just in case :)

A few important call outs for reviewers:

  1. This revision seems to work (see below for a full walk through). I
     think this is the behavior we talked about, but please let me know if
     a use case is missing.
  
  2. Re a previous point made by Stanislav regarding "taking over a NAPI
     ID" when the channel count changes: mlx5 seems to call napi_disable
     followed by netif_napi_del for the old queues and then calls
     napi_enable for the new ones. In this RFC, the NAPI ID generation is
     deferred to napi_enable. This means we won't end up with two of the
     same NAPI IDs added to the hash at the same time.

     Can we assume all drivers will napi_disable the old queues before
     napi_enable the new ones?
       - If yes: we might not need to worry about a NAPI ID takeover
       	 function.
       - If no: I'll need to make a change so that the NAPI ID generation
       	 is deferred only for drivers which have opted into the config
       	 space via calls to netif_napi_add_config

  3. I made the decision to remove the WARN_ON_ONCE that (I think?)
     Jakub previously suggested in alloc_netdev_mqs (WARN_ON_ONCE(txqs
     != rxqs);) because this was triggering on every kernel boot with my
     mlx5 NIC.

  4. I left the "maxqs = max(txqs, rxqs);" in alloc_netdev_mqs despite
     thinking this is a bit strange. I think it's strange that we might
     be short some number of NAPI configs, but it seems like most people
     are in favor of this approach, so I've left it. 

I'd appreciate thoughts from reviewers on the above items, if at all
possible.

Now, on to the implementation.

Firstly, this implementation moves certain settings to napi_struct so that
they are "per-NAPI", while taking care to respect existing sysfs
parameters which are interface wide and affect all NAPIs:
  - NAPI ID
  - gro_flush_timeout
  - defer_hard_irqs

Furthermore:
   - NAPI ID generation and addition to the hash is now deferred to
     napi_enable, instead of during netif_napi_add
   - NAPIs are removed from the hash during napi_disable, instead of
     netif_napi_del.
   - An array of "struct napi_config" is allocated in net_device.

IMPORTANT: The above changes affect all network drivers.

Optionally, drivers may opt-in to using their config space by calling
netif_napi_add_config instead of netif_napi_add.

If a driver does this, the NAPI being added is linked with an allocated
"struct napi_config" and the per-NAPI settings (including NAPI ID) are
persisted even as hardware queues are destroyed and recreated.

To help illustrate how this would end up working, I've added patches for
3 drivers, of which I have access to only 1:
  - mlx5 which is the basis of the examples below
  - mlx4 which has TX only NAPIs, just to highlight that case. I have
    only compile tested this patch; I don't have this hardware.
  - bnxt which I have only compiled tested. I don't have this
    hardware.

NOTE: I only tested this on mlx5; I have no access to the other hardware
for which I provided patches. Hopefully other folks can help test :)

Here's how it works when I test it on my mlx5 system:

# start with 2 queues

$ ethtool -l eth4 | grep Combined | tail -1
Combined:       2

First, output the current NAPI settings:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 7}'
[{'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 345,
  'ifindex': 7,
  'irq': 527},
 {'defer-hard-irqs': 0,
  'gro-flush-timeout': 0,
  'id': 344,
  'ifindex': 7,
  'irq': 327}]

Now, set the global sysfs parameters:

$ sudo bash -c 'echo 20000 >/sys/class/net/eth4/gro_flush_timeout'
$ sudo bash -c 'echo 100 >/sys/class/net/eth4/napi_defer_hard_irqs'

Output current NAPI settings again:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 7}'
[{'defer-hard-irqs': 100,
  'gro-flush-timeout': 20000,
  'id': 345,
  'ifindex': 7,
  'irq': 527},
 {'defer-hard-irqs': 100,
  'gro-flush-timeout': 20000,
  'id': 344,
  'ifindex': 7,
  'irq': 327}]

Now set NAPI ID 345, via its NAPI ID to specific values:

$ sudo ./tools/net/ynl/cli.py \
          --spec Documentation/netlink/specs/netdev.yaml \
          --do napi-set \
          --json='{"id": 345,
                   "defer-hard-irqs": 111,
                   "gro-flush-timeout": 11111}'
None

Now output current NAPI settings again to ensure only NAPI ID 345
changed:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 7}'

[{'defer-hard-irqs': 111,
  'gro-flush-timeout': 11111,
  'id': 345,
  'ifindex': 7,
  'irq': 527},
 {'defer-hard-irqs': 100,
  'gro-flush-timeout': 20000,
  'id': 344,
  'ifindex': 7,
  'irq': 327}]

Now, increase gro-flush-timeout only:

$ sudo ./tools/net/ynl/cli.py \
       --spec Documentation/netlink/specs/netdev.yaml \
       --do napi-set --json='{"id": 345,
                              "gro-flush-timeout": 44444}'
None

Now output the current NAPI settings once more:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 7}'
[{'defer-hard-irqs': 111,
  'gro-flush-timeout': 44444,
  'id': 345,
  'ifindex': 7,
  'irq': 527},
 {'defer-hard-irqs': 100,
  'gro-flush-timeout': 20000,
  'id': 344,
  'ifindex': 7,
  'irq': 327}]

Now set NAPI ID 345 to have gro_flush_timeout of 0:

$ sudo ./tools/net/ynl/cli.py \
       --spec Documentation/netlink/specs/netdev.yaml \
       --do napi-set --json='{"id": 345,
                              "gro-flush-timeout": 0}'
None

Check that NAPI ID 345 has a value of 0:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 7}'

[{'defer-hard-irqs': 111,
  'gro-flush-timeout': 0,
  'id': 345,
  'ifindex': 7,
  'irq': 527},
 {'defer-hard-irqs': 100,
  'gro-flush-timeout': 20000,
  'id': 344,
  'ifindex': 7,
  'irq': 327}]

Change the queue count, ensuring that NAPI ID 345 retains its settings:

$ sudo ethtool -L eth4 combined 4

Check that the new queues have the system wide settings but that NAPI ID
345 remains unchanged:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 7}'

[{'defer-hard-irqs': 100,
  'gro-flush-timeout': 20000,
  'id': 347,
  'ifindex': 7,
  'irq': 529},
 {'defer-hard-irqs': 100,
  'gro-flush-timeout': 20000,
  'id': 346,
  'ifindex': 7,
  'irq': 528},
 {'defer-hard-irqs': 111,
  'gro-flush-timeout': 0,
  'id': 345,
  'ifindex': 7,
  'irq': 527},
 {'defer-hard-irqs': 100,
  'gro-flush-timeout': 20000,
  'id': 344,
  'ifindex': 7,
  'irq': 327}]

Now reduce the queue count below where NAPI ID 345 is indexed:

$ sudo ethtool -L eth4 combined 1

Check the output:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 7}'
[{'defer-hard-irqs': 100,
  'gro-flush-timeout': 20000,
  'id': 344,
  'ifindex': 7,
  'irq': 327}]

Re-increase the queue count to ensure NAPI ID 345 is re-assigned the same
values:

$ sudo ethtool -L eth4 combined 2

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 7}'
[{'defer-hard-irqs': 111,
  'gro-flush-timeout': 0,
  'id': 345,
  'ifindex': 7,
  'irq': 527},
 {'defer-hard-irqs': 100,
  'gro-flush-timeout': 20000,
  'id': 344,
  'ifindex': 7,
  'irq': 327}]

Create new queues to ensure the sysfs globals are used for the new NAPIs
but that NAPI ID 345 is unchanged:

$ sudo ethtool -L eth4 combined 8

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 7}'
[...]
 {'defer-hard-irqs': 100,
  'gro-flush-timeout': 20000,
  'id': 346,
  'ifindex': 7,
  'irq': 528},
 {'defer-hard-irqs': 111,
  'gro-flush-timeout': 0,
  'id': 345,
  'ifindex': 7,
  'irq': 527},
 {'defer-hard-irqs': 100,
  'gro-flush-timeout': 20000,
  'id': 344,
  'ifindex': 7,
  'irq': 327}]

Last, but not least, let's try writing the sysfs parameters to ensure
all NAPIs are rewritten:

$ sudo bash -c 'echo 33333 >/sys/class/net/eth4/gro_flush_timeout'
$ sudo bash -c 'echo 222 >/sys/class/net/eth4/napi_defer_hard_irqs'

Check that worked:

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
                         --dump napi-get --json='{"ifindex": 7}'

[...]
 {'defer-hard-irqs': 222,
  'gro-flush-timeout': 33333,
  'id': 346,
  'ifindex': 7,
  'irq': 528},
 {'defer-hard-irqs': 222,
  'gro-flush-timeout': 33333,
  'id': 345,
  'ifindex': 7,
  'irq': 527},
 {'defer-hard-irqs': 222,
  'gro-flush-timeout': 33333,
  'id': 344,
  'ifindex': 7,
  'irq': 327}]

Thanks,
Joe

[1]: https://lore.kernel.org/netdev/20241009005525.13651-1-jdamato@fastly.com/

v6:
  - Added Jakub's Reviewed-by to all commit messages
  - Added Eric's Reviewed-by to the commits for which he provided his
    review (i.e. all patches except 4, 5, and 6)
  - Updated the netlink doc for gro_flush_timeout in patch 4
  - Added WARN_ON_ONCE to napi_hash_add_with_id as suggested by Eric
    Dumazet to patch 5

v5: https://lore.kernel.org/netdev/20241009005525.13651-1-jdamato@fastly.com/
  - Converted from an RFC to a PATCH
  - Moved defer_hard_irqs above control-fields comment in napi_struct in
    patch 1
  - Moved gro_flush_timeout above control-fields comment in napi_struct in
    patch 3
  - Removed unnecessary idpf changes from patch 3
  - Removed unnecessary kdoc in patch 5 for a parameter removed in an
    earlier revision
  - Removed unnecessary NULL check in patch 5
  - Used tooling to autogenerate code for patch 6, which fixed the type and
    range of NETDEV_A_NAPI_DEFER_HARD_IRQ.

rfcv4: https://lore.kernel.org/lkml/20241001235302.57609-1-jdamato@fastly.com/
  - Updated commit messages of most patches
  - Renamed netif_napi_add_storage to netif_napi_add_config in patch 5
  - Added a NULL check in netdev_set_defer_hard_irqs and
    netdev_set_gro_flush_timeout for netdev->napi_config in patch 5
  - Removed the WARN_ON_ONCE suggested in an earlier revision
    in alloc_netdev_mqs from patch 5; it triggers every time on my mlx5
    machine at boot and needlessly spams the log
  - Added a locking adjustment suggested by Stanislav to patch 6 to
    protect napi_id in patch 5
  - Removed napi_hash_del from netif_napi_del in patch 5. netif_napi_del
    calls __netif_napi_del which itself calls napi_hash_del. The
    original code thus resulted in two napi_hash_del calls, which is
    incorrect.
  - Removed the napi_hash_add from netif_napi_add_weight in patch 5.
    NAPIs are added to the hash when napi_enable is called, instead.
  - Moved the napi_restore_config to the top of napi_enable in patch 5.
  - Simplified the logic in __netif_napi_del and removed napi_hash_del.
    NAPIs are removed in napi_disable.
  - Fixed merge conflicts in patch 6 so it applies cleanly

rfcv3: https://lore.kernel.org/netdev/20240912100738.16567-8-jdamato@fastly.com/T/
  - Renamed napi_storage to napi_config
  - Reordered patches
  - Added defer_hard_irqs and gro_flush_timeout to napi_struct
  - Attempt to save and restore settings on napi_disable/napi_enable
  - Removed weight as a parameter to netif_napi_add_storage
  - Updated driver patches to no longer pass in weight

rfcv2: https://lore.kernel.org/netdev/20240908160702.56618-1-jdamato@fastly.com/
  - Almost total rewrite from v1

Joe Damato (9):
  net: napi: Make napi_defer_hard_irqs per-NAPI
  netdev-genl: Dump napi_defer_hard_irqs
  net: napi: Make gro_flush_timeout per-NAPI
  netdev-genl: Dump gro_flush_timeout
  net: napi: Add napi_config
  netdev-genl: Support setting per-NAPI config values
  bnxt: Add support for persistent NAPI config
  mlx5: Add support for persistent NAPI config
  mlx4: Add support for persistent NAPI config to RX CQs

 Documentation/netlink/specs/netdev.yaml       | 28 ++++++
 .../networking/net_cachelines/net_device.rst  |  3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  3 +-
 drivers/net/ethernet/mellanox/mlx4/en_cq.c    |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  2 +-
 include/linux/netdevice.h                     | 42 +++++++-
 include/uapi/linux/netdev.h                   |  3 +
 net/core/dev.c                                | 96 ++++++++++++++++---
 net/core/dev.h                                | 88 +++++++++++++++++
 net/core/net-sysfs.c                          |  4 +-
 net/core/netdev-genl-gen.c                    | 18 ++++
 net/core/netdev-genl-gen.h                    |  1 +
 net/core/netdev-genl.c                        | 57 +++++++++++
 tools/include/uapi/linux/netdev.h             |  3 +
 14 files changed, 326 insertions(+), 25 deletions(-)


base-commit: d677aebd663ddc287f2b2bda098474694a0ca875
-- 
2.25.1


