Return-Path: <linux-rdma+bounces-17481-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJSiAXxbqGmZtgAAu9opvQ
	(envelope-from <linux-rdma+bounces-17481-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:19:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5796B20411B
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 17:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ABDC3300371
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 16:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4346434DCCA;
	Wed,  4 Mar 2026 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="IGxS4qVu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835FD34A3B1
	for <linux-rdma@vger.kernel.org>; Wed,  4 Mar 2026 16:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640031; cv=none; b=fpurIGZGrN9RPJZVmt2CFPFV3kiYYgzcbbQke67QbUU9Zle3/nppZ6PQouJOkBcwSLafVVlSYt00mWiusGR6Qx29wJd2PeOzKmPN2UDI4diXrRtD2sixyMgUklGQxn/61j28etyAdoWWQxKxRF+oQeF7uVo2vODOd9ErkmcCbj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640031; c=relaxed/simple;
	bh=KEeOkJm0EmRV6jqNyOAEXWp0ZZ6RYVxsvyRyrfSxNkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=azmcSl7oMVlHRyiOrcCEuaH4oeVE5V3AvKxN9WsY8oipjk75ewJQtocc6JzE2EsRKVj4dNfzQV/8pLX9KE0vF2Z6R9pXgKNWZVJUZ+fUpyKapWw6EVakvclLnRMbvUYeOFVAeCjBCyvFsOWLzJsQY1BWzy1qHg8m8b38vDpxO10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=IGxS4qVu; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-439c4a93841so1066611f8f.1
        for <linux-rdma@vger.kernel.org>; Wed, 04 Mar 2026 08:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772640025; x=1773244825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OU95bHZuJNtP/VAPwIGit/Pa+QghFNKlhnRH3cB9CJ4=;
        b=IGxS4qVuGVB6ooSFrgfLPbkfALb0ex4ep8cdG7ROwi1Hg+ZbwYXU6KMOfoW6Xd+Ehk
         QTv5gwAKX4qmvsXMcu1w84NJvl/2i/46rktxrKqu5BY7LvGd/MhO8cnWicAa7wLsoEVl
         6qCG/RgEMQPYUdyWvSN3wxY1l37FC+grgQKIlDI/MwiRh5Uxu6aqG9mnAKw4gCmTQHwf
         x0KlDbch2jXuHkGQyd5VQGMQsgdugtR718PY2w/NODfxNvtRp7uF2ZZgSXuWrGRq/o33
         4wBLaBCQKJ4J4BzSXhWLpLNd1tRUC4FGhyli0YXa7QAhn3+Ym7bvxh+2sFiGZfMFvns4
         w5rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640025; x=1773244825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OU95bHZuJNtP/VAPwIGit/Pa+QghFNKlhnRH3cB9CJ4=;
        b=MJVHnK+PBJ7OkWAygQW66xcGi1TutiaWb6qKCwT0N6Bn4T8WSaMaqxxdoq02C5b9y8
         B3EkZxoY/TaO667B3T3AO7UqIrugd79SmsvUlvTrJlyH1gofFVh6oFEZo0/Pxb94QF1t
         iaky/Tszglq3MniMrmo3OItk1ZsQ8/RLFE7Ab9njjFdkLSKCT594foLBO3OiWxeuIxzL
         P2ysnHVAMnNisScRTqWsHuIjx9twrsTuHoblfyghLhkXMxr+feDZfOfUxguoXFahCwQ5
         v2dBIkhWDXkXMXfOuOh8fnmaoOZfCmUL2AoLoXhr6uL1t1voSVYZUTz98YCb9u9rAkq5
         6McA==
X-Forwarded-Encrypted: i=1; AJvYcCUOmZoVjpTLBtj6ava4loOzWhboRi8SxtNWFHre1uvfcM9rQImk7dps4lBIu7FGch5QtvXZOcwqCJUv@vger.kernel.org
X-Gm-Message-State: AOJu0Yycm4SdlHOBLBSx7oOv4z+Thb4ZtPeb2l8u2oHVn13KEOG9Hbmw
	OhObvVloAXUEs4LYDqyIblsjUSsDzCKOSnRlzIe1Qn9oLsa6rVIBPBs/nggyt9Bou+c=
X-Gm-Gg: ATEYQzwSZpr5G5rQRmsDpbr6xMr4k/TCHUECla0V/D88GqpkvWSo9JnjgS/7cqYXsjQ
	7qOVd4D9M17vnWO0jzdE6V42mYuD0bvtKawKRGxc3l7Y3AIKpP/bUaKyPJB/7tgiXCzVJgp5+yS
	jDfkvTlhOMg0HBY/CoUt0uqrNKbKj5xkQIJ0pPzTJWI2o9slNz+pPrvp0QKzCHFZTqCK+qKlCcc
	b0PHtWvQ2wK3UHUIp3gdBaSXkS2xjtw1FQk/djJiYx1VukZKxxPAu4N/4xn305zgwOs/BICv+AS
	CvOOKRGIg2PdacHpVF0V7nGjutwSC/SFxFiJA9k4GE+QRf3+a9q6YskTowduwdWFR0+gwPJetS9
	nw/kbGVHWZQjWqxml3jgs5gAB+sDSWauVuU4A7lq/HT/eW9TcgawWriWIC6DCJs/O33Dx2z/cV3
	C1aNSOSLgFqEUkUF8ewN9gaLOs2PHrEwJvdoWX1p6IA5EVRg==
X-Received: by 2002:a05:6000:1acf:b0:439:b3ff:9ab9 with SMTP id ffacd0b85a97d-439c7ffcb29mr5150381f8f.48.1772640024040;
        Wed, 04 Mar 2026 08:00:24 -0800 (PST)
Received: from localhost (46-13-72-179.customers.tmcz.cz. [46.13.72.179])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b59723fesm25578351f8f.38.2026.03.04.08.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:00:23 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	przemyslaw.kitszel@intel.com,
	mschmidt@redhat.com,
	andrew+netdev@lunn.ch,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	chuck.lever@oracle.com,
	matttbe@kernel.org,
	cjubran@nvidia.com,
	daniel.zahka@gmail.com,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next v3 00/13] devlink: introduce shared devlink instance for PFs on same chip
Date: Wed,  4 Mar 2026 17:00:09 +0100
Message-ID: <20260304160022.6114-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5796B20411B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17481-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,resnulli-us.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,resnulli.us:mid]
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Multiple PFs on a network adapter often reside on the same physical
chip, running a single firmware. Some resources and configurations
are inherently shared among these PFs - PTP clocks, VF group rates,
firmware parameters, and others. Today there is no good object in
the devlink model to attach these chip-wide configuration knobs to.
Drivers resort to workarounds like pinning shared state to PF0 or
maintaining ad-hoc internal structures (e.g., ice_adapter) that are
invisible to userspace.

This problem was discussed extensively starting with Przemek Kitszel's
"whole device devlink instance" RFC for the ice driver [1]. Several
approaches for representing the parent instance were considered:
using a partial PCI BDF as the dev_name (breaks when PFs have different
BDFs in VMs), creating a per-driver bus, using auxiliary devices, or
using faux devices. All of these required a backing struct device for
the parent devlink instance, which does not naturally exist - there is
no PCI device that represents the chip as a whole.

This patchset takes a different approach: allow devlink instances to
exist without any backing struct device. The instance is identified
purely by its internal index, exposed over devlin netlink. This avoids
fabricating fake devices and keeps the devlink handle semantics clean.

The first ten patches prepare the devlink core for device-less
instances by decoupling the handle from the parent device. The last
three introduce the shared devlink infrastructure and its first user
in the mlx5 driver.

Example output showing the shared instance and nesting:

  pci/0000:08:00.0: index 0
    nested_devlink:
      auxiliary/mlx5_core.eth.0
  devlink_index/1: index 1
    nested_devlink:
      pci/0000:08:00.0
      pci/0000:08:00.1
  auxiliary/mlx5_core.eth.0: index 2
  pci/0000:08:00.1: index 3
    nested_devlink:
      auxiliary/mlx5_core.eth.1
  auxiliary/mlx5_core.eth.1: index 4

[1] https://lore.kernel.org/netdev/20250219164410.35665-1-przemyslaw.kitszel@intel.com/

---
Decoupled from "devlink and mlx5: Support cross-function rate scheduling"
patchset to maintain 15-patches limit.

See individual patches for changelog.

Jiri Pirko (13):
  devlink: expose devlink instance index over netlink
  devlink: add helpers to get bus_name/dev_name
  devlink: avoid extra iterations when found devlink is not registered
  devlink: allow to use devlink index as a command handle
  devlink: support index-based lookup via bus_name/dev_name handle
  devlink: support index-based notification filtering
  devlink: introduce __devlink_alloc() with dev driver pointer
  devlink: add devlink_dev_driver_name() helper and use it in trace
    events
  devlink: add devl_warn() helper and use it in port warnings
  devlink: allow devlink instance allocation without a backing device
  devlink: introduce shared devlink instance for PFs on same chip
  documentation: networking: add shared devlink documentation
  net/mlx5: Add a shared devlink instance for PFs on same chip

 Documentation/netlink/specs/devlink.yaml      |  56 +++
 .../networking/devlink/devlink-shared.rst     |  97 +++++
 Documentation/networking/devlink/index.rst    |   1 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   5 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  17 +
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  |  61 +++
 .../ethernet/mellanox/mlx5/core/sh_devlink.h  |  12 +
 include/linux/mlx5/driver.h                   |   1 +
 include/net/devlink.h                         |  10 +
 include/trace/events/devlink.h                |  36 +-
 include/uapi/linux/devlink.h                  |   4 +
 net/devlink/Makefile                          |   2 +-
 net/devlink/core.c                            |  91 ++++-
 net/devlink/dev.c                             |   8 +-
 net/devlink/devl_internal.h                   |  34 +-
 net/devlink/netlink.c                         |  57 ++-
 net/devlink/netlink_gen.c                     | 350 +++++++++++-------
 net/devlink/port.c                            |  19 +-
 net/devlink/sh_dev.c                          | 161 ++++++++
 19 files changed, 813 insertions(+), 209 deletions(-)
 create mode 100644 Documentation/networking/devlink/devlink-shared.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
 create mode 100644 net/devlink/sh_dev.c

-- 
2.51.1


