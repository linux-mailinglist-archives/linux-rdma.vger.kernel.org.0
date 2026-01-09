Return-Path: <linux-rdma+bounces-15403-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B4576D0A6B4
	for <lists+linux-rdma@lfdr.de>; Fri, 09 Jan 2026 14:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0027930504E5
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 13:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460A32E6CB8;
	Fri,  9 Jan 2026 13:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/sbXFOW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3FB35BDD9
	for <linux-rdma@vger.kernel.org>; Fri,  9 Jan 2026 13:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767965042; cv=none; b=iU6CpTuYIERSfgmA8mmRx47NYRse6a7/vX3uP0Kt6+vlbWkoi/QnhDphES5yE4995etzcoPzcNoarLkGpJ7z7huhYxA6G+Cvf75MUQ+l0Whn1dIBhhwcazIcbCVd8wZ9JjA2WsAoZfgcRU485yVnTQJ1ga5L2IhHox+lAdDUhUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767965042; c=relaxed/simple;
	bh=ME5RwYYeXnXNLbQ/Bkl/rSm+h34n/XlbEQhFl4FNSPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nU164QLj2n7/tFTJKyiGnB0Y1Eh7mojzOLB9lvr9Q1cTSEP2hZnyLEgP5NjQLsA8sRra0NW+4lEd1zIGH2GCPjkCvP5vUSVRG9lSWpwsps7Vs6FVHi/y0t9lVHa7AgPa+tCnrHtf7oMIAjdVCrLRRsAyjCChoWsUayypFJL1ViA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/sbXFOW; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-64d0d41404cso6471554a12.0
        for <linux-rdma@vger.kernel.org>; Fri, 09 Jan 2026 05:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767965039; x=1768569839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fQi3F9taD578uKhb5WeGr8+LqFJi+cgMU9mJCgFH+JI=;
        b=P/sbXFOWnYgusGtsRclb4LRv+Xm1fLt/QiKfctwPVesYW3of90zrZTMuqCTU3BxRV/
         4CmMfRvbE34K3bNdrWiCJDXs1TAXVV8OOvzLesFju3n9xZTKXN0B/BL1Z4RX+DBI4Yi4
         0Rdl+w8vR6RZSD94Z5acJbeGTdwnVDDKY++PzBaSxxxSLjKTRwSR4alkgn1DAiqF9DcR
         myTH2Nwbk3wFWkTOf/GQ+M/yUbTQ49BqSl4Djn8b6dVkloxafY9bc/ERd95b+ZBPelFX
         v/QjrbAvevQlggoQFITLBzmtBcA3VsY1X8Dw35sUnmGsMkRcE4Vt8IEQvrZFn3l91wWy
         f71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767965039; x=1768569839;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fQi3F9taD578uKhb5WeGr8+LqFJi+cgMU9mJCgFH+JI=;
        b=slCEqIpVc4507i5PhmTcncu6b6tktkg2J1jqk64f2jZSwkQW52if1sQwcwViFACgM9
         VdtbkdIbsRI3XI+qsJaZaK8pxx8pmck0q6TI/vK6S5OE41RtuiZNt+E2ZiWn0R2mM4RJ
         ZyN9MTMUd9eoRONKCmUWxyTkhX1LRieQb7IPHmdqWl4EAjILk9ZlkjXkKE0AOkLBnz6I
         tujFUrLxPgJT5Xjl/jNxBhgfPhUi5HamL38MXMjXkVLNLMx3FI9/ns8Lg/kF/jFrRG88
         aIUdwy7f9hwz3oaQw+aTn3aeJdSzhVcyI6VfB52XEVplqxFSLVXAmbUKAR4ZUUQMT0sN
         lXAw==
X-Forwarded-Encrypted: i=1; AJvYcCWkuoQUQH7Ph6ly3AQv/iUPnOiNw+zKQDJxSFxXWE9dQ0mKpqli4jkxoXtImqdYNwe7FEwItxK+ZGzw@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2xUrjbPnm8/XGgK02L4sdbqjgjWt0Ajx+I9eM/YrKR5HfPXzz
	VKQKLanemUfAqTX6P8eCDGELrbG84Q3iyI1ZD3T/Evwrdj3pZm9Aojyd5RlKeA==
X-Gm-Gg: AY/fxX6wY5+PTWokifojTnqOZ+nvQqPWRcmrIk1K+jeUn7U2xNnADcXrSDBAOYhXCLj
	1w/JywIjvIShLs4NXUqC0yR96/3sAMF6q6sn1jPskjWF3amfXw1zGzVxebYoSMXzBeyJcWnsVha
	8ca0vbfHVqFLKB0Q4NoJdMmoLRqnkMt8hpsmBTv8+tf0qHu99Sf6ETTHtHE377wKDRk4grvmrLL
	dO31odBdCMhUPig+Z46C0DX5SVFquFM8NXQJZu8sAD/qRqHVwtrvzYRs/c5fBdPm5bPH9FjfTao
	a4oM8iGyYZwYbAa2+x6BSXv+R3FT4ISw35KvkyqB4x5QXFpzipkWLOYvdTkW8AcsI627taf/XzQ
	ILLFyaV5mJDw4ICqrxZODsKlwaGEOwp71/G5/iuPy17nRtI2yGb3X32LktJ3xrYggpfCTDTtiXT
	qOFpGhjBr4YQMr0h9fDRoRwhSt/QR0TB/VHYwSTend/3Qn/QKCzBFsNknvEUN9F7ANy5Bu5g==
X-Google-Smtp-Source: AGHT+IHEu00dTqymHYnWX3YB9+V+M0g0pVj0f65C6gXQXrOLC70cW7LkbUbrjcu3dFBefYWTWksRNQ==
X-Received: by 2002:a05:600c:4fc6:b0:477:a21c:2066 with SMTP id 5b1f17b1804b1-47d84b0a902mr94022565e9.5.1767958133975;
        Fri, 09 Jan 2026 03:28:53 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::1:69b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d8636c610sm60056985e9.0.2026.01.09.03.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 03:28:52 -0800 (PST)
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
	Ahmed Zaki <ahmed.zaki@intel.com>,
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
	io-uring@vger.kernel.org
Subject: [PATCH net-next v8 0/9] Add support for providers with large rx buffer
Date: Fri,  9 Jan 2026 11:28:39 +0000
Message-ID: <cover.1767819709.git.asml.silence@gmail.com>
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

The following changes since commit 9ace4753a5202b02191d54e9fdf7f9e3d02b85eb:

  Linux 6.19-rc4 (2026-01-04 14:41:55 -0800)

are available in the Git repository at:

  https://github.com/isilence/linux.git tags/net-queue-rx-buf-len-v8

for you to fetch changes up to 37f5abe6929963fc6086777056b59ecb034d0e19:

  io_uring/zcrx: document area chunking parameter (2026-01-08 11:35:20 +0000)


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
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 126 ++++++++++++++----
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
 .../selftests/drivers/net/hw/iou-zcrx.py      |  37 +++++
 16 files changed, 318 insertions(+), 79 deletions(-)

-- 
2.52.0


