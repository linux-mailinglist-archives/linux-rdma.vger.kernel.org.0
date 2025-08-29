Return-Path: <linux-rdma+bounces-12993-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ABDB3BB4D
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Aug 2025 14:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8D6586562
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Aug 2025 12:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37E61E1E19;
	Fri, 29 Aug 2025 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZMUQgMkl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8B031577F
	for <linux-rdma@vger.kernel.org>; Fri, 29 Aug 2025 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756470655; cv=none; b=HYfTo9uAbt46TYnqxp6cGTorSuB1+vQUOCivJCB+fIskhuFKMYO/eTauVc2EJMAjPR72gnfgTLKtPRrDer+2kV3X/DoL6dooRa5Y0yDH+B1sSNpDttSK1mUbV8n0f1X59ExQMhHpftvGsQNrWVbUi5B/IpZ/Wo2vvi2NkHE7cMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756470655; c=relaxed/simple;
	bh=lar5Fqgne8dQ9mMEZnq4D4ForA5Ob5wZBJIiZjhgN1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SrDNOhmD//BQIGrvY2Zl6eoYr41kVe4csCrHSW9UNAgIw+Sg3/4560jCAM7Wfx09NRHjZr1G72JSZP75pjSW5IipPe5i2OqLqk4mRdsmmpU19Pjk4UxzFaCqshtdEbSENX79u5SeaR00/bSNO/HT8mgLImmMXo2QsjcnENeMids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZMUQgMkl; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-886ec1ac877so63324139f.0
        for <linux-rdma@vger.kernel.org>; Fri, 29 Aug 2025 05:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756470653; x=1757075453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5GnqKOnW5BpFyiRDa52fECtVjd022u+EygDiNyg3D4=;
        b=PumtURv+bX4Yn7domnWCWwpzlCdlcDHLsKLVt/M7f6Wx08x7aMli3VjBjmA1ZvN0PV
         ZSByWamEcL3tk37c/3f+uCnXJwCN2/4E6Yg3dpfcQ1/SUH96ru/9HoZHFrbgksYimSgb
         Wq8RxEFUGopSflCdvkEE3Ar+SIsb96X4GghqEnps/Tc1PNEUHX1CYpvZatYRXJq2jb23
         B4sufPLy9WkrFDP40vhMw5t3q8GYjnRxYIOivx8pUVCM9hd3seuTMaEjuTkrin/W0Efw
         Ja+Esas9wg5Mvjb2d0oLUF0Uv3pr5PkZDKfht8/7WLCJc40ke4xhl/f+6uVMoYlqV7W0
         uXGA==
X-Gm-Message-State: AOJu0YwBsUdVrY6P+hLFCYJQmSFpFvWWJ+CBHBnt5B7JhgdORzPi5epi
	TRbRAwVV49uqBI71riBzBl3q7ySwh6Y3iLtyN8mcgQ0DKYxQ6akVqK1FgDnLasqPFDsmy5IV7hZ
	uV3UB2ad4NxYoF4MIo12KFhzIVbIlyBCT8FVKP17s1YbbrXlZ+zgKG2RA7awvPTMo9YzLLwvtRt
	ccXwj+SWYONQJFhxzYDiNZnO5baKvF9dyL6Wo1M2ssvuAh+IS5s0QCOU+0ih7Cfa0GhBGsKAHGo
	1kKtwZzOyq5exhA+g==
X-Gm-Gg: ASbGnctBRx4/s97Xkker9NuZHSC+XGneJX87Ux2K06808HjvbaEbJyo1W4pt73dy9cY
	oBtFaf2jGuv27XXQJbCclGj3gMcE3306le2GeqkwgulCqyYXRT/TyoMq1H43VkyrBhcslWItizR
	mIABVIOeLMsbwMiG/N85FMcsXE6mYc/Bb353rL9154AkqYZDpd6lzkTnwhBnoaNifdmn1GG+opj
	EOCdnGvPdKORIq/wkp8YADr4/1kXJlgtIVYIhg23ZDduEUfGJFiPsV0H5VgrRwtD6LZoLCQweSr
	N/WR4rigEsBOIEvZUgyUYOz0nZOhoOSSig7mmo6LUd2DqTy2qcLcPKEC7Qlume5uDMxDAJffLK1
	P+q+z3kznkAtWBf1m+F6x0iaKEjEKSSCXjBQrbKWJD2FOgYomB6pMJvg7ZPn80YJSBXWXW3yotQ
	==
X-Google-Smtp-Source: AGHT+IFxsBk9MVXo4fQlgX4L9SwgdqEDU3HSsCUST7D8U6KfLlG9MPZuuSZUbdSXILhd+R97whV9UHbsJln1
X-Received: by 2002:a05:6602:6206:b0:887:17b4:d106 with SMTP id ca18e2360f4ac-88717b4d749mr313288439f.4.1756470652779;
        Fri, 29 Aug 2025 05:30:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-88713bc23desm9758139f.0.2025.08.29.05.30.52
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Aug 2025 05:30:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e8704c5867so701942585a.1
        for <linux-rdma@vger.kernel.org>; Fri, 29 Aug 2025 05:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756470652; x=1757075452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i5GnqKOnW5BpFyiRDa52fECtVjd022u+EygDiNyg3D4=;
        b=ZMUQgMklyTX88abAIsJBTQ9Fj0/aWssUt2HoIipMBRvr3rOOG/rUj9TYdBbf8gHkw1
         n6pd1cFOUK/eYmVDfOwxJTB8wmbNkGq+GNbleoaxSTXX3p1+/OCaiiM2TrKPD3mcwg13
         6hUBPMgkzFVurobnokPjfnf+3n3UvL/9GLOlY=
X-Received: by 2002:a05:620a:1990:b0:7e9:f81f:ce94 with SMTP id af79cd13be357-7ea110a9e21mr3035700885a.86.1756470651613;
        Fri, 29 Aug 2025 05:30:51 -0700 (PDT)
X-Received: by 2002:a05:620a:1990:b0:7e9:f81f:ce94 with SMTP id af79cd13be357-7ea110a9e21mr3035695485a.86.1756470651022;
        Fri, 29 Aug 2025 05:30:51 -0700 (PDT)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc16536012sm162384585a.66.2025.08.29.05.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 05:30:50 -0700 (PDT)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	vikas.gupta@broadcom.com,
	selvin.xavier@broadcom.com,
	anand.subramanian@broadcom.com,
	Siva Reddy Kallam <siva.kallam@broadcom.com>
Subject: [PATCH 0/8] Introducing Broadcom BNG_RE RoCE Driver
Date: Fri, 29 Aug 2025 12:30:34 +0000
Message-Id: <20250829123042.44459-1-siva.kallam@broadcom.com>
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
 drivers/infiniband/hw/bng_re/bng_fw.c         | 786 ++++++++++++++++++
 drivers/infiniband/hw/bng_re/bng_fw.h         | 211 +++++
 drivers/infiniband/hw/bng_re/bng_re.h         |  86 ++
 drivers/infiniband/hw/bng_re/bng_res.c        | 279 +++++++
 drivers/infiniband/hw/bng_re/bng_res.h        | 215 +++++
 drivers/infiniband/hw/bng_re/bng_sp.c         | 133 +++
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
 25 files changed, 2928 insertions(+), 2 deletions(-)
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


