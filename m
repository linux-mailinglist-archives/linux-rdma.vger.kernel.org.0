Return-Path: <linux-rdma+bounces-5172-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CFC98C99C
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2024 01:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19161F2466B
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2024 23:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89561E009D;
	Tue,  1 Oct 2024 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="xw+TLgPx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522AB1CEE8E
	for <linux-rdma@vger.kernel.org>; Tue,  1 Oct 2024 23:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727826813; cv=none; b=EdBvWKABELBrTNOLDMR2u/uoEVe9QUbG8phaBJYQGpLyExGsKvbKbDiflToBQ20xEQPSqcy8S7m/17VGkysgez2SCTKzr8EPFYwBQSzgl1dKUNtSqrlDtmN3ItFGNSCBFXLFJ0EH73dhOwEUDxlzDzIAhI9lAbBEVzwISNUJPtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727826813; c=relaxed/simple;
	bh=v4d+UGl9YNSRPmUiAQL/XOCttKSR+tqAQhjsG7BZ9JU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g4heb3xS9u1tMBskqh8xKaBKkjlAQYUTSzsP+LP8XpKt2aDTNmNGdf8wQRSXkb2MteI5lzdabEz4dSa3pX8wag1pQVukes2GhPlhqzFXgLw1AjlJoL1D/gnGUQV1vO95pU9xSf6rZln7/nbI5PdoMaijdUM3nUFVBbtXGhVo13s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=xw+TLgPx; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7d4fa972cbeso4607125a12.2
        for <linux-rdma@vger.kernel.org>; Tue, 01 Oct 2024 16:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727826809; x=1728431609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l5b1MjfGcd4AzGnOC54zgkOiQ8aJmBj62vqypQsDHj0=;
        b=xw+TLgPxRDpcIo666604NYo5rF9NaWx9dCmi0cv2JN76GM/nHDIny9wnozFiT6lgI9
         ETdvujjJvynZpFGaVcV4P5W52mFqDdeQUzAQcgb6/Olu5NBw+ZHcgIfc99BrE7lnhTI8
         +4udBfAH8b/4iVMJwidbdA0cU9epEb17N9hpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727826809; x=1728431609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l5b1MjfGcd4AzGnOC54zgkOiQ8aJmBj62vqypQsDHj0=;
        b=B6/sf75RWDEg0FbcgK9OERsMHvAaUeH2QflSl+g/FudGz04m+RNk1qM36LFjvc7FCL
         64GFlQVDN6U9NeCcF0O/ArSdEVILbjB3bEjowesrwLvk+nZq/9Kyv3H+Ieb7W6vPu7cO
         wOrkqcQl0p6vOS2WKWCmC0+FlQ74xjUg7fLLHM2UkYRb8Y5nxN34bHfBU+1TTjJDMWBY
         YtoRefwXYq6HRx3N6NX8c850p1R9fgPGcmCX9S5k1GjbblNM1lFQ2+v+td9bDXkQ4OUJ
         m5xh6IA3umYW0mH2ObS4BDY8zCYtYklGIYxFkeygM6JBYHaPAKQ7NeGeEgdCuDkWgfC6
         vqgA==
X-Forwarded-Encrypted: i=1; AJvYcCU9gDn0TN+YhJSkLBX0f8I3XCyLpjcwUkXDfuCxix6BVBI36ir+f1eMxnn2Jy+bU3Mt8t4HzAynRb5E@vger.kernel.org
X-Gm-Message-State: AOJu0YzcOioW4uJmhvmiSiqHGZHHEi/pMGoUwmN30XGsWFJigSIkmmgj
	2886WHP8Fw4bxzyA8d6fgjoClSzZrGzz/hB//DabSKBnpBE95w//2UIJmW0gbRE=
X-Google-Smtp-Source: AGHT+IEQAMwrZpWjGQQAXOYO52vF2PdxicVe8qt++Jyzou6vIB2WjqtQirUzcksNEccb8Ff5uAtXNg==
X-Received: by 2002:a17:90b:33c2:b0:2d8:7a3b:730d with SMTP id 98e67ed59e1d1-2e1846a0525mr1731254a91.21.1727826809507;
        Tue, 01 Oct 2024 16:53:29 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f89e973sm213130a91.29.2024.10.01.16.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 16:53:29 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	willemdebruijn.kernel@gmail.com,
	Joe Damato <jdamato@fastly.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Daniel Jurgens <danielj@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list),
	linux-rdma@vger.kernel.org (open list:MELLANOX MLX4 core VPI driver),
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Michael Chan <michael.chan@broadcom.com>,
	Mina Almasry <almasrymina@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: [RFC net-next v4 0/9] Add support for per-NAPI config via netlink
Date: Tue,  1 Oct 2024 23:52:31 +0000
Message-Id: <20241001235302.57609-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Greetings:

Welcome to RFC v4.

Very important and significant changes have been made since RFC v3 [1],
please see the changelog below for details.

A couple important call outs for this revision for reviewers:

  1. idpf embeds a napi_struct in an internal data structure and
     includes an assertion on the size of napi_struct. The maintainers
     have stated that they think anyone touching napi_struct should update
     the assertion [2], so I've done this in patch 3. 

     Even though the assertion has been updated, I've given the
     cacheline placement of napi_struct within idpf's internals no
     thought or consideration.

     Would appreciate other opinions on this; I think idpf should be
     fixed. It seems unreasonable to me that anyone changing the size of
     a struct in the core should need to think about cachelines in idpf.

  2. This revision seems to work (see below for a full walk through). Is
     this the behavior we want? Am I missing some use case or some
     behavioral thing other folks need?

  3. Re a previous point made by Stanislav regarding "taking over a NAPI
     ID" when the channel count changes: mlx5 seems to call napi_disable
     followed by netif_napi_del for the old queues and then calls
     napi_enable for the new ones. In this RFC, the NAPI ID generation
     is deferred to napi_enable. This means we won't end up with two of
     the same NAPI IDs added to the hash at the same time (I am pretty
     sure).

     Can we assume all drivers will napi_disable the old queues before
     napi_enable the new ones? If yes, we might not need to worry about
     a NAPI ID takeover function.
 
  4. I made the decision to remove the WARN_ON_ONCE that (I think?)
     Jakub previously suggested in alloc_netdev_mqs (WARN_ON_ONCE(txqs
     != rxqs);) because this was triggering on every kernel boot with my
     mlx5 NIC.

  5. I left the "maxqs = max(txqs, rxqs);" in alloc_netdev_mqs despite
     thinking this is a bit strange. I think it's strange that we might
     be short some number of NAPI configs, but it seems like most people
     are in favor of this approach, so I've left it.

I'd appreciate thoughts from reviewers on the above items, if at all
possible. Once those are addressed, modulo any feedback on the
code/white space wrapping I still need to do, I think this is close to
an official submission.

Now, on to the implementation:

This implementation allocates an array of "struct napi_config" in
net_device and each NAPI instance is assigned an index into the config
array.

Per-NAPI settings like:
  - NAPI ID
  - gro_flush_timeout
  - defer_hard_irqs

are persisted in napi_config and restored on napi_disable/napi_enable
respectively.

To help illustrate how this would end up working, I've added patches for
3 drivers, of which I have access to only 1:
  - mlx5 which is the basis of the examples below
  - mlx4 which has TX only NAPIs, just to highlight that case. I have
    only compile tested this patch; I don't have this hardware.
  - bnxt which I have only compiled tested. I don't have this
    hardware.

NOTE: I only tested this on mlx5; I have no access to the other hardware
for which I provided patches. Hopefully other folks can help test :)

This iteration seems to persist NAPI IDs and settings even when resizing
queues, see below, so I think maybe this is getting close to where we
want to land in terms of functionality.

Here's how it works when I test it on my system:

# start with 2 queues

$ ethtool -l eth4 | grep Combined | tail -1
Combined:	2

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

[1]: https://lore.kernel.org/netdev/20240912100738.16567-1-jdamato@fastly.com/
[2]: https://lore.kernel.org/netdev/20240925180017.82891-1-jdamato@fastly.com/T/#m56b743bd16304a626848b14f90cecb661f464b74 

rfcv4:
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

rfcv3:
  - Renamed napi_storage to napi_config
  - Reordered patches
  - Added defer_hard_irqs and gro_flush_timeout to napi_struct
  - Attempt to save and restore settings on napi_disable/napi_enable
  - Removed weight as a parameter to netif_napi_add_storage
  - Updated driver patches to no longer pass in weight

rfcv2:
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

 Documentation/netlink/specs/netdev.yaml       | 25 +++++
 .../networking/net_cachelines/net_device.rst  |  5 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  3 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  2 +-
 drivers/net/ethernet/mellanox/mlx4/en_cq.c    |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  2 +-
 include/linux/netdevice.h                     | 38 +++++++-
 include/uapi/linux/netdev.h                   |  3 +
 net/core/dev.c                                | 95 ++++++++++++++++---
 net/core/dev.h                                | 90 ++++++++++++++++++
 net/core/net-sysfs.c                          |  4 +-
 net/core/netdev-genl-gen.c                    | 14 +++
 net/core/netdev-genl-gen.h                    |  1 +
 net/core/netdev-genl.c                        | 57 +++++++++++
 tools/include/uapi/linux/netdev.h             |  3 +
 15 files changed, 320 insertions(+), 25 deletions(-)

-- 
2.25.1


