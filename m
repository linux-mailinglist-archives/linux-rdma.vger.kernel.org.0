Return-Path: <linux-rdma+bounces-5784-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D55B09BE1DA
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 10:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A192285432
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2024 09:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E441DD0FF;
	Wed,  6 Nov 2024 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WQWEifMZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2011DBB21
	for <linux-rdma@vger.kernel.org>; Wed,  6 Nov 2024 09:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730883931; cv=none; b=KHWKJ1SDA1Gp3/+voRuniN4bSfTIpAp6s3rq4M1vKBs57ZnjnUcC4uPVfWQaQcJNMDFlRdAb0b/C6fH6PANadgig+vELcKSARrk955gi6ugQhSahZObDckeqEtmTvVdY2+LDZdQf8n6/EK2NILYI5AlMR8IS9wgfFVQLlDyFctQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730883931; c=relaxed/simple;
	bh=nepz5ZEdo7U42poI3ekNVWSS3AoLSObBx0QSfv4+9SU=;
	h=From:To:Cc:Subject:Date:Message-Id; b=F04Rsa6CqKLq0JRM/iLxJAUiOc0+GwN1iVdPjK8Wu+fKBxjHaRFUgjpjMeD1u2Rn3AlUrdTlLu/KO9jScp6VRM+lxUJAGojgykympHzyweWkDYW2yUEjT2gImK23pFGwyL4FIe8/g/3yNJRCbls0SDDd0kWZ7EFt0tA5XSIur2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WQWEifMZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c693b68f5so69308695ad.1
        for <linux-rdma@vger.kernel.org>; Wed, 06 Nov 2024 01:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730883928; x=1731488728; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbrUdx8AnWYClHmA8SZJJAgOkHFthT0yMRum0EFAWWU=;
        b=WQWEifMZAyvr0fACziGJmvtBlXNJhAe641lf2Ek1wa/p+oBFScEHjQ/Nv1l2IHYj/u
         5xQvSFBZMvAZlfhWIhh19Oup4uWjJv6zmBSoZAYwj/OvQeDg9F/3Q/N5jbku5nkPAYn6
         f4L/Zc1EdLKXxHgGllWD/XO+8HKUwbKqGRV9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730883928; x=1731488728;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbrUdx8AnWYClHmA8SZJJAgOkHFthT0yMRum0EFAWWU=;
        b=WU0Fng8Y3+m8Lsxo1YAgGj53tkskN+Yx8UMZdHFiD0n5q62OjpZ3rH+qd+SQh7DKje
         0RCQv4AlKerJ7hFoUDG9bGGFTijUmd1RYmLHEX3kEs6nHuYeln62WyZJ2dmppmNRShLB
         5cShtyuu9XhPO2DXZBh5K3+aNJ52CbYgyjc3YHI1FFA/7lA/DrCt2X0kN4ZyPCX/JLdC
         XzruKnZh5yWiidFSUO7OcP8wQBexqk6wR/SxU/uPeOXgqoXz54eJ3JUGUxg2ZPV21jtk
         ca/Gt6Kh3Dz3BefUeULTX1BrzCqtOJkr4npLDDdsP+568y1+R0PK7dF8CJB3a1n4O/nn
         W+IA==
X-Gm-Message-State: AOJu0Yxh3BzsF7BxGT1KWa+53kmj6Ye+1ziGh7kosPzMhfUHtI5/v4uK
	ZL9gXs9cK05B11nzrvo4xQTakA/jnwGmB7zpJxxFB2sWFxLkFafqROe7OzDe4A==
X-Google-Smtp-Source: AGHT+IHopMnnXO+cdpbLI9vGPVwp6EWwYiJV3p8sX3ArHhRCkLhHNOzjZV/7Zu/AZzSXud8pQ3wizw==
X-Received: by 2002:a17:902:f707:b0:20c:f261:2516 with SMTP id d9443c01a7336-21103aaa000mr338769645ad.8.1730883928370;
        Wed, 06 Nov 2024 01:05:28 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057084casm91715395ad.92.2024.11.06.01.05.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2024 01:05:27 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next v2 0/3] bnxt: Enhance the resource distribution for RoCE VFs
Date: Wed,  6 Nov 2024 00:44:33 -0800
Message-Id: <1730882676-24434-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Implements the mechanism to distribute the RoCE VF resource
based on the active VFs. If the firmware support the feature,
NIC driver will distribute the resources for Active VFs. For
older Firmware, RoCE driver will continue to distribute the
resources across the total number of VFs.

Please review and apply.

Thanks,
Selvin Xavier

v1 -> v2:
	Updated the commit message of patch 1 of the series

Bhargava Chenna Marreddy (1):
  RDMA/bnxt_re: Enhance RoCE SRIOV resource configuration design

Kalesh AP (1):
  RDMA/bnxt_re: Add set_func_resources support for P5/P7 adapters

Vikas Gupta (1):
  bnxt_en: Add support for RoCE sriov configuration

 drivers/infiniband/hw/bnxt_re/main.c            | 24 ++++++-----
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c      | 13 ++----
 drivers/infiniband/hw/bnxt_re/qplib_res.h       |  3 ++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h        |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c       |  6 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h       |  6 +++
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c | 53 +++++++++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c   |  2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h   |  1 +
 9 files changed, 89 insertions(+), 20 deletions(-)

-- 
2.5.5


