Return-Path: <linux-rdma+bounces-14192-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAAFC2B311
	for <lists+linux-rdma@lfdr.de>; Mon, 03 Nov 2025 11:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C9B63A439D
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Nov 2025 10:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FA82FF144;
	Mon,  3 Nov 2025 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hKL8EC6p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846672FDC5B
	for <linux-rdma@vger.kernel.org>; Mon,  3 Nov 2025 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762167457; cv=none; b=mGE50IzqTQl+x4N9mQdJ33lMYN2dRJUCdJaBnI1OLD1sfJqjOQLTVpMQfZT1McCCH0BpqldihOMpCuDiZJ1JX1voNYhElHPGC3f4Jo/VYJ2mRG1zUom4+N7bqxxlKUTC0KiC9oA937PM2PFVjYuu+r3r9O/hV4fdlnO5vVGP7+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762167457; c=relaxed/simple;
	bh=P16YaxWi7YwYdN6kyC/InRqQ5z+TkxAvYNhF3WMfWoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EFVGbFrLuJt1+iOCi1QmrF9cCqlolZM9PTK8xkvXN4eXKBqP8xkCaPYAUCD+z6QhYgi5l4VJGhYsNcGNMsDqC34bHl/Fdqv2fh95ilIqucDQMT+ua8vT3AajeMzNorjXgEFurAvtpQdpzFA+vxWLoSmGFmCzBWwaKiNIHxz0GBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hKL8EC6p; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-b8c0c0cdd61so4188116a12.2
        for <linux-rdma@vger.kernel.org>; Mon, 03 Nov 2025 02:57:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762167455; x=1762772255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xKRpzw6WM9uha1y0ZcKWu7DN7BAxye8b67lEfyJLbY=;
        b=w/c87Ri9kTy54CZXgNJuleau963in7Bts4/Y5fejltlUlt1iVGT5uaJXJdVm6aeNgp
         dZf0Jg+YFwzRUDNtf0DpFQpet134f4V/NMETeNnCgGyGZQ+iLbBqhWTCqyDt/QoIXvHY
         BIjegMW/NfjdSL3mxl1YvWh4hS5+t/xVx9Tgc3RX08vdsp3ZyhQqY5jLaI5IBX09fR5l
         Oy7zpJ27Gk8X0lqLtT+VyFf2bR1410/2K6+5IhKwjMwmyLhZGxeyIQuQmOqPyO403IDl
         fUJg3bUJIZWkCW7VqCFn6Aqzk9n7lQWK31yyxizMdab4qylTSbVffhdCCDGvmbqb76W9
         ULGQ==
X-Gm-Message-State: AOJu0YwY+94O9lsuIZ8IcfbgtrI7DGAxIPIRSkHc+wZeeSsprfQDDIXF
	5uKX6Y2LukCiL733i/zJsUilptRpMAGENSl5V69i1apQip8Yz1lDYoRfzwfcHWD4LKNcJIB+mVf
	dUJ0tnRm24TaNuW9FPKbDln2GOgxpeo3pxkpg4DMMjdrBdPuGYNbBglUvc6IrPoVxZe2mlWkIH1
	Q60ZV49sY0GHW9jwsci2DRRgdi5XpqqZ7hcV6X0Br4+I1qRPLZsEpHHYsKna0D6xqdAfW3W48+u
	4SUMgtYMQZvZ1ICBS+BoB4xU4bx
X-Gm-Gg: ASbGncuzhuL9fEIglG7yPLRvSEFSyMcitTg/5uv6+kLNG45ZiBzKEDEaowFKhDZbjU6
	1tJWmpr4PffE1WFc7uqyEoWj5pmSuCfDS9fCVW9MO2TEtMKWO2O2n6GiWQ7ODItZXltseBOHSjt
	pPJRHMTGFJHIETs1WcdCvUqjI0MMVb1SzZK7yoblOkMr9dEmzIhE+YkLUr0ytU8+HJ7sUmvjyu8
	2+0jz7K2gSZ1eDYDdnROJCEmw3R8PZr7u0/lqSrNN0avOLSc9xWMsBu0ce4TjsgAUUzhlpfZ183
	SIkR6OHELTt2cK+qjGXY/3XbebSFiTUlIYJNgi/f0uJ58HumCtRzt0tUQ2a8t16mULZJt4/9vWj
	eU8fmIV2ENaCYozrbQXQTnlKrDu8+tTkbA+e5n+iQHrcwUcJ/WUmam7tRXyfeviR0Y4kekLD23S
	xdYQ1x6RDYMLUuqTLRT/xoPWsQ9fEfTeiF8hND72MVWv8egA==
X-Google-Smtp-Source: AGHT+IFkTlfERNpL8WzgI98HNFXPMpu3vb8GhIWSo6vXbrSUHECtKm9AHdFcXUyHULX5ulppI2gsxTbonnuD
X-Received: by 2002:a17:902:eccd:b0:295:34ba:7afa with SMTP id d9443c01a7336-29534ba7bafmr131845055ad.43.1762167454789;
        Mon, 03 Nov 2025 02:57:34 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-29526984313sm9565155ad.50.2025.11.03.02.57.34
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2025 02:57:34 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3324538ceb0so7868683a91.1
        for <linux-rdma@vger.kernel.org>; Mon, 03 Nov 2025 02:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762167453; x=1762772253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2xKRpzw6WM9uha1y0ZcKWu7DN7BAxye8b67lEfyJLbY=;
        b=hKL8EC6pFXaTfB20zRqgiQU6ydLZRLDGLdslRUfViTAvlzQoys0I2Yz9cUeNIGa1eo
         ByO8uK7aS8kV0mYppBC9pF5xY0aKzgxY/73Ze8YjxcRuqA5qgOF3Ofc5x4w0K7+twxWQ
         kRnxIZL1wZL0xXh6HjVWG99DYUKqGBel0vBZ4=
X-Received: by 2002:a17:90b:314e:b0:340:d511:e15f with SMTP id 98e67ed59e1d1-340d511e56fmr7582398a91.18.1762167453150;
        Mon, 03 Nov 2025 02:57:33 -0800 (PST)
X-Received: by 2002:a17:90b:314e:b0:340:d511:e15f with SMTP id 98e67ed59e1d1-340d511e56fmr7582383a91.18.1762167452809;
        Mon, 03 Nov 2025 02:57:32 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159fc0e19sm602263a91.4.2025.11.03.02.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 02:57:32 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next 0/4] RDMA/bnxt_re: Support direct verbs
Date: Mon,  3 Nov 2025 16:20:29 +0530
Message-ID: <20251103105033.205586-1-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

This patchset supports Direct Verbs in the bnxt_re driver.

This is required by vendor specific applications that need to manage
the HW resources directly and to implement the datapath in the
application.

To support this, the library and the driver are being enhanced to
provide Direct Verbs using which the application can allocate and
manage the HW resources (Queues, Doorbell etc) . The Direct Verbs
enable the application to implement the control path.

Patch#1 Move uapi methods to a separate file
Patch#2 Refactor existing bnxt_qplib_create_qp() function
Patch#3 Support dbr and umem direct verbs
Patch#4 Support cq and qp direct verbs

Thanks,
-Harsha

******

Kalesh AP (3):
  RDMA/bnxt_re: Move the UAPI methods to a dedicated file
  RDMA/bnxt_re: Refactor bnxt_qplib_create_qp() function
  RDMA/bnxt_re: Direct Verbs: Support DBR and UMEM verbs

Sriharsha Basavapatna (1):
  RDMA/bnxt_re: Direct Verbs: Support CQ and QP verbs

 drivers/infiniband/hw/bnxt_re/Makefile    |    2 +-
 drivers/infiniband/hw/bnxt_re/bnxt_re.h   |   12 +-
 drivers/infiniband/hw/bnxt_re/dv.c        | 1822 +++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  549 +++----
 drivers/infiniband/hw/bnxt_re/ib_verbs.h  |   23 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.c  |  311 ++--
 drivers/infiniband/hw/bnxt_re/qplib_fp.h  |   10 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.c |   43 +
 drivers/infiniband/hw/bnxt_re/qplib_res.h |   10 +
 include/uapi/rdma/bnxt_re-abi.h           |  142 ++
 10 files changed, 2382 insertions(+), 542 deletions(-)
 create mode 100644 drivers/infiniband/hw/bnxt_re/dv.c

-- 
2.51.2.636.ga99f379adf


