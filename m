Return-Path: <linux-rdma+bounces-17160-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPjXHZ/6nmm+YAQAu9opvQ
	(envelope-from <linux-rdma+bounces-17160-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:35:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3F9198255
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 14:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12FEF3070961
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 13:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954E83B961F;
	Wed, 25 Feb 2026 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="y39Gkj4P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4073B95FA
	for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026470; cv=none; b=PMzKX7fm/30LfrSRnQCTgEerGA+hafXroBswU34VqFZK+fPVO/S38/OiUOIgAeHrXwPHy7qqQHBn2ahpUH51LhGpdDA8R0AB7nWyyPSr1O4QmFDoEDvgsHK7CZKtMzvc9Kuy76EeaD51HXBq9rdPwM4pdFx9l/3ao1E9dxYuvFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026470; c=relaxed/simple;
	bh=9Xz+6VxPCwoVZU0iO1RTKRbG6dMJCxhC3xLfrYIRCTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aBZRm3A3v76tYXr6svEEssNsrdyaBOvaay4x2npx+udjPC5JbxOAgMciEzlGCIpiEVhAVwtMwepUlPvOyZu1wAtHH3p6pWVDhOg0QgyZrZSITlYiX6JLq7mfELXmqF9XTzwJ1+lGmkvViClipIqZUJS7Hpxa7oWbz68sBx6L9jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=y39Gkj4P; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-437711e9195so4538651f8f.1
        for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 05:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772026465; x=1772631265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YWW7/I/6Js+wUg3YiqGf7C70f+o6TdnB97onUwiUnHc=;
        b=y39Gkj4PkxQF6Io4z8RqIwVg5bxxFbJxqYQwhSdB8toAtBk7xKMhSe8aM9bL2dUf+f
         ikmhgj7eq/NgjWGfHIzMzmXmNPXkauJyNla8sPh2klQ4RAk+XZ7P1/t2rXqkROVT4hh9
         hl7EMYleQ6kut2Ks6QRAKDeqnOqDekrcPTYnTnrWXERkSJ0fAKcO187aWExzu/EZMEg5
         fozXHhJ5Djxu2ZGbUtlzdmw6/w3O/ee83V+u4FGuen9QHv9Q7Euglfwjum/jtMf8UDfg
         GSyOXrktF68q+kPbUq1VXM0oVzU2dqueotrM5EAIjf2xGGHwdEXwrGHwvMKik4FIYrzU
         NEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772026465; x=1772631265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWW7/I/6Js+wUg3YiqGf7C70f+o6TdnB97onUwiUnHc=;
        b=VcW/RZEAps8LKthIULNv3oIiorO97qTrobRbs9esenZS0ZX1mM4/VAz2NJR71K4lSI
         60/13x93Y2H0zjIXJewcEuCiTyFODlYIMZFCT1/1iX0kEcLjhN7D0zZcVUSoZkuphzmB
         nJxSZGc4DPde16ZZarI6rzEWp2FUdgvX+hgtQz881QA42pNj+bpbRoKGukum8nr3fFWx
         mLEwJKtJpgn7jnaMxqy0BnDGfdbylsZzu7/qZUlOhrh0t14PAwMbVp2UELpKHEeuZBQ7
         pvnFPS5qXMGwSLDg53q9w3DoNbWvq0YBEmOToejaaI/ffHCnmFp5IG755soHSEgjd5h7
         Cv7A==
X-Forwarded-Encrypted: i=1; AJvYcCWZPc6IZdNrv5rUH+TUyJpkZ5Ep1f0zARQPF7dP6Jf0CR458MwsLcnyJifwzzciMJvejHWK0a3f+Lwg@vger.kernel.org
X-Gm-Message-State: AOJu0YwJFkGN9P6w6mqT/wVqBophfSsyG8+rgtUJZiIc+YkV3NKnmzYi
	0nxzy5JuyfZaluHtrA39NOlV+Q+o4VxeFkIduYGR7GRoh1GQcQ4xbSrqspcrpvnFMQM=
X-Gm-Gg: ATEYQzwoE2i1brSbm/Z/8wdJ5HKsF3GnTVevnaJIMLIDCS3RRXrHR/pfIflmE98/E1+
	9ZGZjahSxhIWiFeDxs2b3k38oUn+gVRB2OwQhpCW6V1dSUCASKbd94ZHKhdD9wvXvCH1ulwbh5D
	xJ/ar8dw3jXn/RplJzZ4x4aUsPiAj/I5ID8gvS8BiPDAEh2T07wlmhY/lOkWlEPZBEdMv4FKNLH
	Go2vNOe39rUSjR4B4RhGU17vcfFW4G8aD5T6dQmAMe11HyhuZtXJWTTKfh114sKFuUXzCCFrQDS
	J/VQEvE5/fEA6/O24iM5xph/KJ8nlJ7ugtYT7ZmXfikt7v7KTiuo4N7isMZRSBfLbRiNeSwS4rz
	0z26TLd/3j8223VcwCxdjVO81yrXudhQBSXz77uABJ+VZ2Z6SPrmxcWGgWVR+WkV3pX4iYh3mpS
	/FTijRDyEIBbTIng==
X-Received: by 2002:a5d:5888:0:b0:436:1951:21f2 with SMTP id ffacd0b85a97d-4396f16e3d7mr27778818f8f.12.1772026463906;
        Wed, 25 Feb 2026 05:34:23 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d3ff6dsm36040237f8f.25.2026.02.25.05.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:34:23 -0800 (PST)
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
Subject: [PATCH net-next v2 00/10] devlink: introduce shared devlink instance for PFs on same chip
Date: Wed, 25 Feb 2026 14:34:12 +0100
Message-ID: <20260225133422.290965-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17160-lists,linux-rdma=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.882];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli.us:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: EC3F9198255
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

The first seven patches prepare the devlink core for device-less
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

Jiri Pirko (10):
  devlink: expose devlink instance index over netlink
  devlink: store bus_name and dev_name pointers in struct devlink
  devlink: avoid extra iterations when found devlink is not registered
  devlink: allow to use devlink index as a command handle
  devlink: support index-based lookup via bus_name/dev_name handle
  devlink: add devlink_dev_driver_name() helper and use it in trace
    events
  devlink: allow devlink instance allocation without a backing device
  devlink: introduce shared devlink instance for PFs on same chip
  documentation: networking: add shared devlink documentation
  net/mlx5: Add a shared devlink instance for PFs on same chip

 Documentation/netlink/specs/devlink.yaml      |  56 +++
 .../networking/devlink/devlink-shared.rst     |  89 +++++
 Documentation/networking/devlink/index.rst    |   1 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   5 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  17 +
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  |  62 ++++
 .../ethernet/mellanox/mlx5/core/sh_devlink.h  |  12 +
 include/linux/mlx5/driver.h                   |   1 +
 include/net/devlink.h                         |   9 +
 include/trace/events/devlink.h                |  36 +-
 include/uapi/linux/devlink.h                  |   4 +
 net/devlink/Makefile                          |   2 +-
 net/devlink/core.c                            |  59 ++-
 net/devlink/dev.c                             |  11 +-
 net/devlink/devl_internal.h                   |  17 +-
 net/devlink/netlink.c                         |  38 +-
 net/devlink/netlink_gen.c                     | 350 +++++++++++-------
 net/devlink/port.c                            |  19 +-
 net/devlink/sh_dev.c                          | 142 +++++++
 19 files changed, 738 insertions(+), 192 deletions(-)
 create mode 100644 Documentation/networking/devlink/devlink-shared.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
 create mode 100644 net/devlink/sh_dev.c

-- 
2.51.1


