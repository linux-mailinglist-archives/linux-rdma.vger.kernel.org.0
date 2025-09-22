Return-Path: <linux-rdma+bounces-13568-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB32DB9206D
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 17:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 507BE17604E
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 15:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96FE2EB848;
	Mon, 22 Sep 2025 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dx5XclZ/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C112A2EAB61
	for <linux-rdma@vger.kernel.org>; Mon, 22 Sep 2025 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555801; cv=none; b=ojvzsZjtP0ReDh8e5BDxGfGawOEDtHlfL8peIbUMYzkKxsrb+tvzWSwliH1IUK7j9Xm4CyCx/0hVkTY06NQyZNoFO/qr93N3PxRtBATyflTVxOAq9qYkDeGHLF0+axSzWCx9aeyDNLG3NCutEd5Cy671bbJCMHLO5Je7lfBr8Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555801; c=relaxed/simple;
	bh=eT1q/ggLAI9PLCKRueICnDHYAAU6zPP6XchIZCEilWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AE7ysfB6t4CdLHcl8lVPQ+ywC7F+tWFYao4pPC4mQO+iDI4A07MeEU12vmrbF8dsI0pOCcetaCyzA90jW0VgQeCENelyvvSFhMu23r0+lT9KeOFGc6TleV/16XUYqOOv/PGkQvDOOfIJQTBFxbcFxfzIZXGJ0N4Hv1XHO8MqAFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dx5XclZ/; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-77f38a9de0bso1063363b3a.0
        for <linux-rdma@vger.kernel.org>; Mon, 22 Sep 2025 08:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758555799; x=1759160599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/1hUL2jvV8omMh0VOz9ss1Si9bOzTUncZ2FZRE+Kng=;
        b=El0C45lqJBihucTgKiSjIRNK43mXV2/PBqbsjdm75sRK9WTPR/u44u4SN3lM7OYLql
         j5MdAztlpTj8bVzKgTdkojyFulXl5iP2m4esOHdFmTUY3iYhJfrNaGIVjQ5K/dIl6m/b
         z+E2QvOy91OZvpdwWUPOC2mERTZJuPzCh4U7NpZbJUoc5KixgNctRcsnQKwHZstKZiJD
         WEYxu6dvYjvMAQdJ7kr/jeQjPfCwpaWWsu/ttKIjlsfUkQhY++fVFRepF57i7mm5nW75
         82dleydMw4/GVIEDgKlH5oWqxeLADwgZhp2LPhjs53eLH/XvxLmhW6fUEHdS0LX79cK4
         9ASA==
X-Gm-Message-State: AOJu0YwCG0iR/yOFgb/HbD6lYACupyctakIRpUOHX2qNlRJlOeoVW8EL
	S1pivtjL02F0CN9uvXFOQFCxHoborc58+mcvWjq8riA6eNz9Ob+HGlnkB9+cjYnORiSQGeRTNXU
	EwV7ews1pwNmuxuRLBCYxkBBK84T6nLPmqgHcwU7bjrbeLvtWR52khu6slQ77UxKm79zyW9TbNF
	ZlG2ZRPmMV9vq1wFulFKaFasdE7NM1rY+J5NKpiLoyPoMXdHa1/wb5i6Qftpye0XvbDS8xdINBX
	snAUr1f2xUQI7kywg==
X-Gm-Gg: ASbGnculE/EVPe8vS1A3poCw6MvOjTGm30DiyQZKnFh0p5WDT5Pc0htcMcHw1P0SKcI
	HmDkuJ4jYtiq7ChSHn+ooOfdHMRfkCS21UAl2C156ZPbu9sM9bR5ilS/+WlsmAuTmV3C1jDC4br
	z1wO4w5lwH6F3IWNgHf6Wp2r1gGUoqwiHzQ8qFJ1B7pFCzPRtyg631DzXKYNunnSsaXpAA2O+Is
	zI9aX0kWnFyAz69mbM/pahsTn6yC3ue9ayPag0m/d3kpBS6wbY0SyBd3Prvuc4cisWCLLUYMdnz
	aFF2dVOAgU/4Q/C4atdVjf63SROUry/KI6FlnBeVtvS69hQNKQicyIacimhijVMrDqJv4SPmQPJ
	g0RurvSc9hCPQ6obBMY1DZG3uBWIygmS/Llc6RaWQcAKuz/7tboO4fSIgZACoZDMcpClXWtdiCG
	Y0
X-Google-Smtp-Source: AGHT+IGiRmbsIzcOGdJjXajTbefHCdGkFGwJBlTmhLUxy6+vjPoLWIG7fUZcefs3X0iyq01N8s2nGtWKk6Qh
X-Received: by 2002:a17:903:3888:b0:271:5bde:697e with SMTP id d9443c01a7336-2715c0c3b8fmr79538605ad.3.1758555798868;
        Mon, 22 Sep 2025 08:43:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-269802c23fcsm8599165ad.72.2025.09.22.08.43.18
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 08:43:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-773e990bda0so88666576d6.3
        for <linux-rdma@vger.kernel.org>; Mon, 22 Sep 2025 08:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758555797; x=1759160597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e/1hUL2jvV8omMh0VOz9ss1Si9bOzTUncZ2FZRE+Kng=;
        b=dx5XclZ/kucp1bkoeA0YPbRNIWdZlC9gm24w28oca6E1cNvs/vbiDXUUSnvXWBJO6O
         KxosUCaTDF+xLEkORkacmpPwbFGVz900EVd9ImXUnlnPFCTCZQuCRIJD4r+W+vg1Q35W
         kZ3W2BRIv1PU1EfBpigflo0TnFJF+SQodq1fo=
X-Received: by 2002:a05:622a:198d:b0:4b4:9489:8ca9 with SMTP id d75a77b69052e-4c0720abc46mr145056171cf.54.1758555797422;
        Mon, 22 Sep 2025 08:43:17 -0700 (PDT)
X-Received: by 2002:a05:622a:198d:b0:4b4:9489:8ca9 with SMTP id d75a77b69052e-4c0720abc46mr145055741cf.54.1758555796819;
        Mon, 22 Sep 2025 08:43:16 -0700 (PDT)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-84ada77bb17sm179496785a.30.2025.09.22.08.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 08:43:16 -0700 (PDT)
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
Subject: [PATCH v2 0/8] Introducing Broadcom BNG_RE RoCE Driver
Date: Mon, 22 Sep 2025 15:42:55 +0000
Message-Id: <20250922154303.246809-1-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=all
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

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
2.34.1


