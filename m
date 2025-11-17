Return-Path: <linux-rdma+bounces-14540-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BEF5C656C9
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 18:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 51D6B2C363
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 17:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3EC309DD2;
	Mon, 17 Nov 2025 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Rb5oBhl3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f226.google.com (mail-il1-f226.google.com [209.85.166.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29A23093D7
	for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399511; cv=none; b=l52j7hBIiMl+vAX3/qoEuAzHZ6SAz9mLHO5zTqhEywbebUuU7tdW8l1YsEd9yr2DmcIv240z52E7gSBMUOpdDH+7ss75tOiu3U5X7ZxdD/6iucT5zY+XMStpJR3T99l+1GyQedMP4XaZssznSEPEwMhp9bzYL6YX4S8qfCcqZh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399511; c=relaxed/simple;
	bh=CGD3WWM4RJsKjiBIKI5DOKn8UKZZLCFREOivv4kIa68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PKVVhnaKezQsggsNtRg47fdr7/ZWl5+nVcN35+mXZJXUmhWw+BwK0eO5u+PhBAQhUttwmPMIUG1thtKXwWZEUA7eLtQ7SgUZKbtoElJE4v7Shmn5LXIx0yWbrkFGBWMl0cNjdqBHJ6slQrD5uc81N8XMUnbq3wl7lS6sPRd2DUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Rb5oBhl3; arc=none smtp.client-ip=209.85.166.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f226.google.com with SMTP id e9e14a558f8ab-43380a6fe8cso33067195ab.0
        for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 09:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763399509; x=1764004309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/PnfIwiIPLokh861WW9VvfFK1qgK6/9Jm139k+AFMko=;
        b=a7ui7gq7zWL6yMbaMvG166u9i4MTMXGa1g9KzOOROolFZlZ1AyBxVcs03A/6FdKnzF
         PadHlOD2PEDLUXEAgXzvVDgcnrn2tjP+IQGNQy3UjaLgIiiUW7smKQEEx9xrJ0Kx5qRh
         p+jaCp5N+pUOa/mFu2rx0K4k2bOliiAmtNJJZxyoAo7fCe0QZZonQIzajhYaxHmW79JQ
         q/kw9KBa3czyFKqj4RHJb8+D3IsGFqARQhskKXimC1+oqrklVnw43d66ma2pmB9gMbDd
         n2MT8xprseBF1cee4JHQpL/bNmrF4yrjnEZsvtO+g9BE2MVS+Z9u4qpGwphHVRxSjCpS
         zbQw==
X-Gm-Message-State: AOJu0Yxixu0iTCiDzbuKK4ygs+4D23xcbwCnsz2gefqfU00g7M9mpirf
	NvpPAU/3tUkKGz7R8mRJf1SYMMNR6MksXJaeQ8xhIzA86WPD/rQV0VRDi/ecAZsyqJt1qCQd/Um
	SVa+ZzzSshVVlzczwaEJDGxpO3ve9+J1VkW0myZDFv5HuApL/nYVLQ5K/tS9A9RohdZWkuhU0n2
	iDdaM2RDmuqEa1A/IMx1AVtXHRm7JIPSg598f/lCrbO1mZD8pVSglQ0+eHiB7jW/deTT14H+6LS
	guZgJS/gj50jLnMXQ==
X-Gm-Gg: ASbGncsYkRcUgGunmsVD9cnZbpcP9Kps+tkyQqIU+2/9/diMIRIPd7EYwcpTDoS0OiV
	hehgNpU8tOI+s3auXg0IeGaN8JW1i8OMcQCvQa09gKTul8UOrlMbIHn9xboXgqkdC1lrshdTkW9
	t8jzUroX+zl3Wj5FWDuKbDtIwMq4lxgdx0x4Ji0wEf8WJ0zAGD389vD8nKnzAgThvblA3Lyatsw
	D51nw4OuNy4SBkpvBAk9Qy5RJO1Qo01ZGbuaG4klzuCqpR08TAgMggpQnyDzIr1VrGiQLEymSjZ
	RE9mip2Xx6O8rkrr+uzT6FIv6QE3GS8hv+KoJjm7nTl9yeuhbbDt+XHSbJAypEO6YTfI/MPfEPH
	T13Ryu4lZtAPs1geVHVaWC00d12yIXEqoh2boYRWeSkC4dD+t48+aPIoFBYvrcDFmjDS+5cOWMn
	2twmBbJInLaudb7WE/ERt4Pe/aWI0C51fmtT0=
X-Google-Smtp-Source: AGHT+IFoSNVpBtTSROUiHmmDLUGCdrpzvicScKcny9SKnOFK68QotsVYO1BK3h9vHlPI5Y4YiCfSs+zjVn7D
X-Received: by 2002:a92:c94f:0:b0:434:96ea:ff7e with SMTP id e9e14a558f8ab-43496eb0332mr104768915ab.38.1763399508603;
        Mon, 17 Nov 2025 09:11:48 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5b7bd266f39sm946718173.15.2025.11.17.09.11.48
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Nov 2025 09:11:48 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8823a371984so29119466d6.1
        for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 09:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763399508; x=1764004308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/PnfIwiIPLokh861WW9VvfFK1qgK6/9Jm139k+AFMko=;
        b=Rb5oBhl3eD/ngdzcvSDNKaSMiVXFL0NdgVuvBUZDldNP0bn3uPf1BWh7s6S+Sr7MQ6
         IOjxmiQ7IvlrlZb78fFrIP7bOKcrtdle5ug0gpAxwhdpnNApKa/LYv2EROhJ1oa3x15C
         w/rxTb8vqbbwwGpatz3N/KqiQkUunxG9lgIIs=
X-Received: by 2002:a05:6214:21a3:b0:882:401c:e391 with SMTP id 6a1803df08f44-882926e0205mr225523946d6.57.1763399507640;
        Mon, 17 Nov 2025 09:11:47 -0800 (PST)
X-Received: by 2002:a05:6214:21a3:b0:882:401c:e391 with SMTP id 6a1803df08f44-882926e0205mr225523336d6.57.1763399507161;
        Mon, 17 Nov 2025 09:11:47 -0800 (PST)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286314557sm96082236d6.20.2025.11.17.09.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 09:11:46 -0800 (PST)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	vikas.gupta@broadcom.com,
	selvin.xavier@broadcom.com,
	anand.subramanian@broadcom.com,
	usman.ansari@broadcom.com,
	Siva Reddy Kallam <siva.kallam@broadcom.com>
Subject: [PATCH v3 0/8] Introducing Broadcom BNG_RE RoCE Driver
Date: Mon, 17 Nov 2025 17:11:18 +0000
Message-ID: <20251117171136.128193-1-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=all
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This patch series introduces the Next generation RoCE driver for
Broadcom’s BCM5770X chip family, which supports 50/100/200/400/800G
link speeds. The driver is built as the bng_re.ko kernel module.

To keep the series within a reviewable size (~3.5K lines of code),
this initial submission focuses on the core infrastructure and
hardware initialization, including:

1) bng_en: Auxiliary device support
2) Auxiliary device support (probe/remove)
3) Get the required resources from bng_en
4) Firmware communication mechanism
5) Allocation of ib device
6) Basic debugfs infrastructure support
7) Get the device capability (QPs, CQs, SRQs, etc.)
8) Initialize the Hardware

Support for Verbs, User library and additional features will be
built on top of this patchset. hence, they will be introduced in
the subsequent patch series.

The bng_re driver shares the roce_hsi.h file with the bnxt_re
driver, as the bng_re driver leverages the hardware communication
protocol used by the bnxt_re driver.
======================================================================
Changes from:
v2->v3
Rebased the patchseries to rdma-next

v1->v2
Addressed the following comments by Simon Horman and Leon Romanovsky:
Patch 2/8:
  - Remove rdev_to_dev check in bng_re_add_device.
Patch 5/8:
  - Remove uninitalized variable rc in bng_re_process_func_event.
  - Remove unused variable in creq bng_re_enable_fw_channel.
  - Modified the switch case as suggested by Leon in
    bng_re_process_func_event.
Patch 6/8:
  - Remove unused variable cctx in bng_re_get_dev_attr.

Thanks,
Siva

Siva Reddy Kallam (7):
  RDMA/bng_re: Add Auxiliary interface
  RDMA/bng_re: Register and get the resources from bnge driver
  RDMA/bng_re: Allocate required memory resources for Firmware channel
  RDMA/bng_re: Add infrastructure for enabling Firmware channel
  RDMA/bng_re: Enable Firmware channel and query device attributes
  RDMA/bng_re: Add basic debugfs infrastructure
  RDMA/bng_re: Initialize the Firmware and Hardware

Vikas Gupta (1):
  bng_en: Add RoCE aux device support

 MAINTAINERS                                   |   7 +
 drivers/infiniband/Kconfig                    |   1 +
 drivers/infiniband/hw/Makefile                |   1 +
 drivers/infiniband/hw/bng_re/Kconfig          |  10 +
 drivers/infiniband/hw/bng_re/Makefile         |   8 +
 drivers/infiniband/hw/bng_re/bng_debugfs.c    |  39 +
 drivers/infiniband/hw/bng_re/bng_debugfs.h    |  12 +
 drivers/infiniband/hw/bng_re/bng_dev.c        | 539 ++++++++++++
 drivers/infiniband/hw/bng_re/bng_fw.c         | 767 ++++++++++++++++++
 drivers/infiniband/hw/bng_re/bng_fw.h         | 211 +++++
 drivers/infiniband/hw/bng_re/bng_re.h         |  86 ++
 drivers/infiniband/hw/bng_re/bng_res.c        | 279 +++++++
 drivers/infiniband/hw/bng_re/bng_res.h        | 215 +++++
 drivers/infiniband/hw/bng_re/bng_sp.c         | 131 +++
 drivers/infiniband/hw/bng_re/bng_sp.h         |  47 ++
 drivers/infiniband/hw/bng_re/bng_tlv.h        | 128 +++
 drivers/net/ethernet/broadcom/bnge/Makefile   |   3 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  10 +
 .../net/ethernet/broadcom/bnge/bnge_auxr.c    | 258 ++++++
 .../net/ethernet/broadcom/bnge/bnge_auxr.h    |  84 ++
 .../net/ethernet/broadcom/bnge/bnge_core.c    |  18 +-
 .../net/ethernet/broadcom/bnge/bnge_hwrm.c    |  40 +
 .../net/ethernet/broadcom/bnge/bnge_hwrm.h    |   2 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |  12 +
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |   1 +
 25 files changed, 2907 insertions(+), 2 deletions(-)
 create mode 100644 drivers/infiniband/hw/bng_re/Kconfig
 create mode 100644 drivers/infiniband/hw/bng_re/Makefile
 create mode 100644 drivers/infiniband/hw/bng_re/bng_debugfs.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_debugfs.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_dev.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_fw.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_fw.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_re.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_res.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_res.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_sp.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_sp.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_tlv.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_auxr.h

-- 
2.43.0


