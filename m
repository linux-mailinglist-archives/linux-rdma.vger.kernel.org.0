Return-Path: <linux-rdma+bounces-13817-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B33BD4129
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 17:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD54D405481
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Oct 2025 15:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4476830AD08;
	Mon, 13 Oct 2025 14:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eI5h7Hu2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0557426E702
	for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760367204; cv=none; b=lrkvlD00WIKwirpnhc1kFkkIz1qqUXZZpRQwSBGku0ES/IiGSOpT7Slflqa2SzK03hl3Y/e+2F569h2jhqbvNw/TjyGYo6AZMkg7NanG5GGcHw7C+dvHa6BYKoXBBlDgBvGpBpfW3P99yH0HN/QZRfnV3hulOjFdLEnSwN2wi2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760367204; c=relaxed/simple;
	bh=bSEBq/uVXgrRFdrC3jvOQMbnwmsIHdYUxMJ+CsFrB9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dRaHMXEqE5B1BOaGQjAvnOz5tDFm4yJm0kZlva6V4vkJBNgSqmHbz1V5XuI+RdzJsBxY1BE6V6h/pjSwcwpDI9L6IjC4h5AqgTp9JEipcsMaP4bSP8iY34IL7MgdtahHXyTCbwrW8fqujpcUyR7k90LNm13IHSRn0cZLDkx3Fzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eI5h7Hu2; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e2c3b6d4cso31990135e9.3
        for <linux-rdma@vger.kernel.org>; Mon, 13 Oct 2025 07:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760367200; x=1760972000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dic3M/lLM2/ycZ5ZARs7aXZDn/viBq+O10qSDjyGmLY=;
        b=eI5h7Hu2yH7LOsJfEAzfkjFKS2FVeOXqWKf43qeyUV5VU5WOmytJpVxVeItaZMECVT
         rhVyFzeCfU93NyO0ntGLLzO59Xbo581j9aK8onwIjzP8A+FFZLTyhgTg52ouWvd0luR5
         8uvNePxkBpCODQxjXQWilIjptHnGNL5MeeTTJlgGGycIWO1VQ98A4yKwlIjL7vUlDnv+
         Qt1Wy8Iw1vWCog1+QzRx+0zhSyciqC2JlIVgT7UivaTSTLOO2HzzI2YOgjmsmtu1TyGg
         GqyXyVr2cb9km5kE0BKeBQNmQGTUpVvaQEBIIE7jiKJaLCuuGSG5oppKz/eSNHGWrP1b
         mbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760367200; x=1760972000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dic3M/lLM2/ycZ5ZARs7aXZDn/viBq+O10qSDjyGmLY=;
        b=KS92Jyq2LGmfRbf0FHbxJeD+Sek4LcvNguk3Ixqf9Z69RVb7SGGV8Juyw6zrGUrIm0
         Ad5NUmLjMKfDrUt8ny8KyE3I8cRcr80079BVXD/ab1GN+R/hxULQ+33KJfUZSvmRc3+8
         UGBR3HJzRPwDg2DhbW01x/YhEuFq2CHWa7N+qu1CNtINfCheIHnZjw7Yya3JvA0l0LPP
         MFo1SacW7yjea6tlXv1Nk8OGPK5JFFYmBgyvWUz+PnDyLa1IUhLDbhEORsK2TZf9RgNl
         x0MMbjnkhCq3vGmWpTy2QWJ9o+QGTKgvqH9QukByULxZMPRXcDu8YxjAFNEVaiGFm49o
         lDVw==
X-Forwarded-Encrypted: i=1; AJvYcCWX1fWbjUAp2hf81v5HKaj2AS5Ka3e6eGPY61J0hiaT55WPmPb4g8ORTvJSu88fKVGWRl0sQJcDuuOL@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0VhYtGjmtqPKe4o/Kug9+RqECr7Sf+L+oOUY3kC+ulsJ9df50
	BpmmK6amp9CSD7ykelHD3p3LqMT5aB6PBq5s+81lDaoS5pwk6KU8i2Jp
X-Gm-Gg: ASbGnct+tpIFlSLFMaNc82tsGkFZMnlXiwV9zH9FZ6SznRhjfYt8AkZOwrUgta8zm/Z
	97oLFmymVMCaIXCMiTSmcSBYZSsybapNfkwL89Kjo1nBqXTZ+97RtIrqy6ylmzXRxgYlFwojtwb
	8tV3ryiKMdZhtpPZgHhpRVGPDqR83IX2oncBRqSCp2/hpwvZmrkSGXnJtJwxquaz94UkB4ChPPI
	gGsxM2t7gSsOENPV1541PaRDH6uLu2cpdKGhHBMRQ2FW4Sw3AJhHhU/RSev57s+tKJp0etC05pA
	+hfhvAOM08Djt/6p9zlU1Kz8LNRAHRNbEoR31MPEIVEkCohXhhJ+hbEVVJwJmTfCHEwlp8d2vi/
	4AyIAMSCGA3+ImWMK178nUpdJU3OhCOBVSeM=
X-Google-Smtp-Source: AGHT+IFDZTW2epAqGg1QWXue+k/9B/Zz7ksBcY03jdXwPOwwoD8VfVpwsFq2UFKu96q8UNrRi/98QQ==
X-Received: by 2002:a05:600c:4e47:b0:46e:42fa:ffce with SMTP id 5b1f17b1804b1-46fa9a863c4mr151531815e9.2.1760367200111;
        Mon, 13 Oct 2025 07:53:20 -0700 (PDT)
Received: from 127.com ([2620:10d:c092:600::1:eb09])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e0e70sm18641085f8f.40.2025.10.13.07.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 07:53:18 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	kernel-team@meta.com,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Joe Damato <joe@dama.to>,
	David Wei <dw@davidwei.uk>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH net-next v4 00/24][pull request] Queue configs and large buffer providers
Date: Mon, 13 Oct 2025 15:54:02 +0100
Message-ID: <cover.1760364551.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for per-queue rx buffer length configuration based on [2]
and basic infrastructure for using it in memory providers like
io_uring/zcrx. Note, it only includes net/ patches and leaves out
zcrx to be merged separately. Large rx buffers can be beneficial with
hw-gro enabled cards that can coalesce traffic, which reduces the
number of frags traversing the network stack and resuling in larger
contiguous chunks of data given to the userspace.

Benchmarks with zcrx [2+3] show up to ~30% improvement in CPU util.
E.g. comparison for 4K vs 32K buffers with a 200Gbit NIC, napi and
userspace pinned to the same CPU:

packets=23987040 (MB=2745098), rps=199559 (MB/s=22837)
CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
  0    1.53    0.00   27.78    2.72    1.31   66.45    0.22
packets=24078368 (MB=2755550), rps=200319 (MB/s=22924)
CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
  0    0.69    0.00    8.26   31.65    1.83   57.00    0.57

netdev + zcrx changes:
[1] https://github.com/isilence/linux.git zcrx/large-buffers-v4

Per queue configuration series:
[2] https://lore.kernel.org/all/20250421222827.283737-1-kuba@kernel.org/

Liburing example:
[3] https://github.com/isilence/liburing.git zcrx/rx-buf-len

---
The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  https://github.com/isilence/linux.git tags/net-for-6.19-queue-rx-buf-len

for you to fetch changes up to bc5737ba2a1e5586408cd0398b2db0f218ed3e89:

  net: validate driver supports passed qcfg params (2025-10-13 10:04:05 +0100)


v4: - Update fbnic qops
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

Jakub Kicinski (20):
  docs: ethtool: document that rx_buf_len must control payload lengths
  net: ethtool: report max value for rx-buf-len
  net: use zero value to restore rx_buf_len to default
  net: clarify the meaning of netdev_config members
  net: add rx_buf_len to netdev config
  eth: bnxt: read the page size from the adapter struct
  eth: bnxt: set page pool page order based on rx_page_size
  eth: bnxt: support setting size of agg buffers via ethtool
  net: move netdev_config manipulation to dedicated helpers
  net: reduce indent of struct netdev_queue_mgmt_ops members
  net: allocate per-queue config structs and pass them thru the queue
    API
  net: pass extack to netdev_rx_queue_restart()
  net: add queue config validation callback
  eth: bnxt: always set the queue mgmt ops
  eth: bnxt: store the rx buf size per queue
  eth: bnxt: adjust the fill level of agg queues with larger buffers
  netdev: add support for setting rx-buf-len per queue
  net: wipe the setting of deactived queues
  eth: bnxt: use queue op config validate
  eth: bnxt: support per queue configuration of rx-buf-len

Pavel Begunkov (4):
  net: page_pool: sanitise allocation order
  net: hns3: net: use zero to restore rx_buf_len to default
  net: let pp memory provider to specify rx buf len
  net: validate driver supports passed qcfg params

 Documentation/netlink/specs/ethtool.yaml      |   4 +
 Documentation/netlink/specs/netdev.yaml       |  15 ++
 Documentation/networking/ethtool-netlink.rst  |   7 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 148 +++++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   5 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   9 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |   6 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |   2 +-
 drivers/net/ethernet/google/gve/gve_main.c    |   9 +-
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  10 +-
 .../marvell/octeontx2/nic/otx2_ethtool.c      |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  10 +-
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  |   8 +-
 drivers/net/netdevsim/netdev.c                |   8 +-
 include/linux/ethtool.h                       |   3 +
 include/net/netdev_queues.h                   |  88 +++++++--
 include/net/netdev_rx_queue.h                 |   3 +-
 include/net/netlink.h                         |  19 ++
 include/net/page_pool/types.h                 |   1 +
 .../uapi/linux/ethtool_netlink_generated.h    |   1 +
 include/uapi/linux/netdev.h                   |   2 +
 net/core/Makefile                             |   1 +
 net/core/dev.c                                |  12 +-
 net/core/dev.h                                |  15 ++
 net/core/netdev-genl-gen.c                    |  15 ++
 net/core/netdev-genl-gen.h                    |   1 +
 net/core/netdev-genl.c                        |  92 +++++++++
 net/core/netdev_config.c                      | 183 ++++++++++++++++++
 net/core/netdev_rx_queue.c                    |  22 ++-
 net/core/page_pool.c                          |   3 +
 net/ethtool/common.c                          |   4 +-
 net/ethtool/netlink.c                         |  14 +-
 net/ethtool/rings.c                           |  14 +-
 tools/include/uapi/linux/netdev.h             |   2 +
 34 files changed, 650 insertions(+), 92 deletions(-)
 create mode 100644 net/core/netdev_config.c

-- 
2.49.0


