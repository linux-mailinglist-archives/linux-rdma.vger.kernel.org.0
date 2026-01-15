Return-Path: <linux-rdma+bounces-15604-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AAAD27EED
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 20:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 287323012262
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Jan 2026 18:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4200A3D2FF5;
	Thu, 15 Jan 2026 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfhvQpp7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945533D1CCF
	for <linux-rdma@vger.kernel.org>; Thu, 15 Jan 2026 18:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768503487; cv=none; b=ERyNCxybUO36KSukG5Od9jQ64RHCR9MeNzA28GstZYBqHWBLUItrH8dcvqX9xlyQsiuzJF8qbPHtzAFblj8xjlNhIepTU0SEKWS5tcrBq6i9NY3lrGjzB8aJJTsjaMNCTeSebloFyKPbd10vJR+q+qLZA9OpzEYFYzFXjE009BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768503487; c=relaxed/simple;
	bh=DToFpCuHSuhM+DNHpirRAz41A0l+z2tT9QDmqX4hQ4k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hbIrlS/ToIXtBlef04rUk6IYM5AkgDtbTcT3lX4dVDWVi9wzJv3jies/rtHhOXOoj0otYyL47y9meOQg1BIbEE+6mdm0g5vk88/oIfAW3PEGqJ0yW6J10gcM0rVg4bC2nHBDZmlWc9WpABE/+CKjt9L79L1lx1G4aQRIrleBldA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AfhvQpp7; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38304020185so11173101fa.2
        for <linux-rdma@vger.kernel.org>; Thu, 15 Jan 2026 10:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768503482; x=1769108282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZL3nD4Mi+r9SwzljwlE9pccItzJ+U5IHWeQeM/fGf6Q=;
        b=AfhvQpp73Ls7OsPHhn6C3PTSVHgSWDKf+PZWPVvjGK4rpwNH6zWpxWW/aK4rfgGVQo
         oPc5Cb5PodFIgH+wyI5VrKqROqEzyT1ldk6Jr+1RfoaGK1upH4TIuV8Zjoag89C9Sx/m
         6Q4Flgg5m80rjqQ5p2WOnkriCksYmg/kyXV+BUnaevQGdbg2l7TBves8cfJ7HfDyv9c9
         en4mZUA6r+zLIfMPp6gQ/QR6bpbajRsLLMnRbAigBuEjMGHyKXDQH2fUViJR0Kq9JeqZ
         +9MWyvY2m5zXHgdlDrGxyOyXvKx30KKDoRHbsi4K5byL7LN19vMq9Uq0VS8Et5aQNn9M
         OzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768503482; x=1769108282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZL3nD4Mi+r9SwzljwlE9pccItzJ+U5IHWeQeM/fGf6Q=;
        b=lvlKXLjo+tPMgk+oDC6MnfBJm0o2H1TV65nTsCAay3Z8FH/YMoZzWyyblvE60mW5xi
         QG0wTPW1Z/5SS8Er2Prpm80+hxRAW4NVf1h/W9h+1k+ioIUcrmQiwC65DVVGA/+yWXFV
         EMSh8BPDKEVizbOcLclimcqSGrPVbvKIbNAxQ+aq60x/kI+GYtg3mzFZx6VRFPFUufYg
         OBoz9JBQZG6JCmTHdwGEKwE6g6sGW3LsQzwxvR2U/QjvgGaXVRIfos260g2pZmtA/+Sf
         1ZMzzdkSBL8EpxNizPAgSp/JVRHUrU89pDO1cq/PuMA8Xj6UOrfcfPGw/pK/h7L6PgR0
         Js4A==
X-Forwarded-Encrypted: i=1; AJvYcCXdjK8SCQz2ZdxYmKkdlIk/SYe2rRNhRXlmGS/uklFbKNQwlQiPwpf7Ta+6RN8bDteS9fYySzT8LEAH@vger.kernel.org
X-Gm-Message-State: AOJu0YwyZOrjOhcj8Pr0rIQIdwZOv9+jubtpanUMPTAbGkSVujfaGC6I
	ZXmuFNRmin34n2axf8oDITpuxVGMPfiKJFKohKiSZO0LuxY/NtCRIQo5
X-Gm-Gg: AY/fxX4/dXuwpj5kVHRjmvDij5C3g2niVsdaDF/n3jsOb81NhP29KGE6Vsya8xl4BQ/
	HUdPDPZo0/0vFu809ahp7Eeux781z/r+J8Z0MlDdpSh88SpPNmfkTeFVSkp1/Z05eG0CA5PJfUK
	x/38kuefB8bJDlGYUpiQQKkbRFwKskDoD69crY16HizH78oPvMS0L9ViBJv1Z7MmTYjFX1JI7AU
	fNLh8EOjBsJmcNDu+NQQQAJNBFF7nbwFj+RVwte7oTGpA8k+oLd7rt0tu7wTAU0xT6aRE21xXHN
	e9VraV+xXQ/pxshst+WbwBRAxyXKdGFPzDSDUToItfxLIS/+vDTRJijv5iSpDh49TahFe6ZUX31
	uqIDxpwMlaNB8UidzzWVu5nmczYQ4oDiETdnk7Qp9eu1aDM0kXYyxJKDsz8ehrysmWsDjopaqH8
	yM2o+V4AsFCl0DJDKx/hXm/0hCylaiUFokMu4lpZtcqmV3Tfv6nFwjmI7v0CUr0RzFvsCuXqmew
	mXyaj5zfGm/5zwDZA==
X-Received: by 2002:a05:600c:4e43:b0:47e:d943:ec08 with SMTP id 5b1f17b1804b1-4801e33dc26mr5755305e9.28.1768497142655;
        Thu, 15 Jan 2026 09:12:22 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f429071a2sm54741645e9.11.2026.01.15.09.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 09:12:21 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Ankit Garg <nktgrg@google.com>,
	Tim Hostetler <thostet@google.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	John Fraker <jfraker@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Joe Damato <joe@dama.to>,
	Mina Almasry <almasrymina@google.com>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	David Wei <dw@davidwei.uk>,
	Yue Haibing <yuehaibing@huawei.com>,
	Haiyue Wang <haiyuewa@163.com>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Horman <horms@kernel.org>,
	Vishwanath Seshagiri <vishs@fb.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	dtatulea@nvidia.com,
	kernel-team@meta.com,
	io-uring@vger.kernel.org
Subject: [PATCH net-next v9 0/9] Add support for providers with large rx buffer
Date: Thu, 15 Jan 2026 17:11:53 +0000
Message-ID: <cover.1768493907.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Note: it's net/ only bits and doesn't include changes, which shoulf be
merged separately and are posted separately. The full branch for
convenience is at [1], and the patch is here:

https://lore.kernel.org/io-uring/7486ab32e99be1f614b3ef8d0e9bc77015b173f7.1764265323.git.asml.silence@gmail.com

Many modern NICs support configurable receive buffer lengths, and zcrx and
memory providers can use buffers larger than 4K to improve performance. When
paired with hw-gro larger rx buffer sizes can drastically reduce the number
of buffers traversing the stack and save a lot of processing time. It also
allows to give to users larger contiguous chunks of data. The idea was first
floated around by Saeed during netdev conf 2024 and was asked about by a few
folks.

Single stream benchmarks showed up to ~30% CPU util improvement.
E.g. comparison for 4K vs 32K buffers using a 200Gbit NIC:

packets=23987040 (MB=2745098), rps=199559 (MB/s=22837)
CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
  0    1.53    0.00   27.78    2.72    1.31   66.45    0.22
packets=24078368 (MB=2755550), rps=200319 (MB/s=22924)
CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
  0    0.69    0.00    8.26   31.65    1.83   57.00    0.57

This series adds net infrastructure for memory providers configuring
the size and implements it for bnxt. It's an opt-in feature for drivers,
they should advertise support for the parameter in the qops and must check
if the hardware supports the given size. It's limited to memory providers
as it drastically simplifies implementation. It doesn't affect the fast
path zcrx uAPI, and the user exposed parameter is defined in zcrx terms,
which allows it to be flexible and adjusted in the future.

A liburing example can be found at [2]

full branch:
[1] https://github.com/isilence/linux.git zcrx/large-buffers-v8
Liburing example:
[2] https://github.com/isilence/liburing.git zcrx/rx-buf-len

---

The following changes since commit 0f61b1860cc3f52aef9036d7235ed1f017632193:

  Linux 6.19-rc5 (2026-01-11 17:03:14 -1000)

are available in the Git repository at:

  https://github.com/isilence/linux.git tags/net-queue-rx-buf-len-v9

for you to fetch changes up to d1de61db1536727c1cad049c09decff22e8b6dd7:

  io_uring/zcrx: document area chunking parameter (2026-01-14 02:13:37 +0000)

v9: - correct nits from Paolo

v8: - Add stripped down qcfg
    - Retain the page size across resets for bnxt

v7: - Add xa_destroy
    - Rebase

v6: - Update docs and add a selftest

v5: https://lore.kernel.org/netdev/cover.1760440268.git.asml.silence@gmail.com/
    - Remove all unnecessary bits like configuration via netlink, and
      multi-stage queue configuration.

v4: https://lore.kernel.org/all/cover.1760364551.git.asml.silence@gmail.com/
    - Update fbnic qops
    - Propagate max buf len for hns3
    - Use configured buf size in __bnxt_alloc_rx_netmem
    - Minor stylistic changes
v3: https://lore.kernel.org/all/cover.1755499375.git.asml.silence@gmail.com/
    - Rebased, excluded zcrx specific patches
    - Set agg_size_fac to 1 on warning
v2: https://lore.kernel.org/all/cover.1754657711.git.asml.silence@gmail.com/
    - Add MAX_PAGE_ORDER check on pp init
    - Applied comments rewording
    - Adjust pp.max_len based on order
    - Patch up mlx5 queue callbacks after rebase
    - Minor ->queue_mgmt_ops refactoring
    - Rebased to account for both fill level and agg_size_fac
    - Pass providers buf length in struct pp_memory_provider_params and
      apply it in __netdev_queue_confi().
    - Use ->supported_ring_params to validate drivers support of set
      qcfg parameters.

Jakub Kicinski (2):
  net: reduce indent of struct netdev_queue_mgmt_ops members
  eth: bnxt: adjust the fill level of agg queues with larger buffers

Pavel Begunkov (7):
  net: memzero mp params when closing a queue
  net: add bare bone queue configs
  net: pass queue rx page size from memory provider
  eth: bnxt: store rx buffer size per queue
  eth: bnxt: support qcfg provided rx page size
  selftests: iou-zcrx: test large chunk sizes
  io_uring/zcrx: document area chunking parameter

 Documentation/networking/iou-zcrx.rst         |  20 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 123 +++++++++++++-----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |   2 +-
 drivers/net/ethernet/google/gve/gve_main.c    |   9 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  10 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  |   8 +-
 drivers/net/netdevsim/netdev.c                |   7 +-
 include/net/netdev_queues.h                   |  47 +++++--
 include/net/netdev_rx_queue.h                 |   2 +
 include/net/page_pool/types.h                 |   1 +
 net/core/dev.c                                |  17 +++
 net/core/netdev_rx_queue.c                    |  31 +++--
 .../selftests/drivers/net/hw/iou-zcrx.c       |  72 ++++++++--
 .../selftests/drivers/net/hw/iou-zcrx.py      |  39 ++++++
 16 files changed, 317 insertions(+), 79 deletions(-)

-- 
2.52.0


