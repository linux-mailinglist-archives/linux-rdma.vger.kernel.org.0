Return-Path: <linux-rdma+bounces-6222-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A369E3544
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 09:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 857F1B35974
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 08:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7B21AAE02;
	Wed,  4 Dec 2024 07:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HKeCanKI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EE418D643
	for <linux-rdma@vger.kernel.org>; Wed,  4 Dec 2024 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733299092; cv=none; b=Hua5VHkZOA9ZkyEjejgU+djcfRxXZ0InO76QZS6w/AA0a3BxpglDiDbHGg7laYF5T2EeSfK2bJavGIfq+PyVNMW42j/CkYcsP4k1QRXTu1qBEgYfRnNEiA01+NKPjsbGe8HPzCR6zlK0atYTeLGQ1ZpUqmY9octtd/DFuknO0LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733299092; c=relaxed/simple;
	bh=fRwu0Tgck7AgN/uibK2wsiXUmuP6yoVIXpVV0Otej/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SSoliLm9+I2GTyBTi4B0fPRwhBSkJ5FfhN1rfO9KpSWg3nL8ztEQH/Tr903C4acdJxttwhR09hcDalsSXrM+5tEZahFKQVYxbOzTCsosYadOSLCY2oFfmiilT913WGMn9WXXak49HaPz0EnK8ecpao6fPcpnajXoLbCkM0N4qf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HKeCanKI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-215cc7b0c56so12964715ad.3
        for <linux-rdma@vger.kernel.org>; Tue, 03 Dec 2024 23:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733299090; x=1733903890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1izmvet3S+2a47SGMkUisv53z/BVf88f/rut3KVNjFo=;
        b=HKeCanKIrz3Ocf7Ar3zXqdPszyFAuUnYHUEvQTAiORTtHJsFc/45lpcZ9q5qPaet90
         B7Dt6+iiSfaoa/zzyv6LXzXoVVhEAS8sJo4zM78CKkEq0RCjEbPVnVNk5MMsD4cME1Vk
         sXw2iSz7AnNxfAabFcyNc7/zesnkFcm73EhWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733299090; x=1733903890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1izmvet3S+2a47SGMkUisv53z/BVf88f/rut3KVNjFo=;
        b=K3WjjzwmzwmAW85wdagpxltaKL0b4cizYWr/OK/ebupuO/5QoXIwd41I2GSywjBv+F
         7prxnDMb4sKZkS5EwnesPJZXwqQZ4QcHeU3Hn+RM5UejN8RJPZzhY4jyg+v4mHPk9W3r
         29F0pTCCC68gfIcdw+aurE/A+FV6C7NK26qNGOq6Pl442v5geiLQ5KpJ7t8QyjaCeUdz
         C2rDTtpLQksWVSZqNL2y8KXXjQRKwiffg21eGEfKZRQq36yQvKktVMx4Z9a58lvacMmz
         e+WPGTPc1yKb8q44atBNCVOgeg4jVKhdx5zPLtQVbmxchYKF7SinOweOGNovLSySMnBH
         4WbA==
X-Gm-Message-State: AOJu0YxbdvQPVqbrXUlVrBep0Sbmbja6jhTvkZKudyv7moKimRZhdOdK
	bCoCKVfXr0V9hNaSZYO4dgyc1CXg830H1oh9Xhj7ZoLl8TwmzYIEIaALw+DRIA==
X-Gm-Gg: ASbGncui9xKrzK9X5nmdlSCrBSkUWKXu1ft6clfLPCLYsQMmJaIwQlGkVviAXk2kTvc
	KKgvsY6O+LsD/AHhjMhCtVedlkyvsJrl6d4+xf5fIx+gKOaGMx45zfb2tRQP9nd3uZLC8mpIGSO
	T0rKDdkfSCIH96S42bTSdom8RUSCe9Jqaw8AnDbWeasEXcYg0hbLJ8MSNk1NG6Wmn/YUh93EsQ3
	fHEhgix3LFmLeMxFrQPWoduDjhhXreRgFfmh6tE/gdul7cxdHR5l6H3fJBD7Q9Jc9Mxiag8l38J
	m2kcOY1G0xguZwokjUreqqTZGLgl19RnYvbuDt+LSmXHzalyE80N
X-Google-Smtp-Source: AGHT+IFw/RC7RIsQyz/vMF0Ub5SKcZ6PadIYsC8C5wPC56gvkKGW6jqBpmLFrhCZTmvjzRkVDA4Fig==
X-Received: by 2002:a17:903:18e:b0:212:6187:6a76 with SMTP id d9443c01a7336-215bd0d0d5bmr55927965ad.14.1733299090259;
        Tue, 03 Dec 2024 23:58:10 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21536d67e95sm95462235ad.76.2024.12.03.23.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 23:58:09 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH for-rc 0/5] RDMA/bnxt_re: Bug fixes
Date: Wed,  4 Dec 2024 13:24:11 +0530
Message-ID: <20241204075416.478431-1-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains some bug fixes for bnxt_re driver.
Please review and apply.

Thanks,
Kalesh AP

Kalesh AP (2):
  RDMA/bnxt_re: Fix error recovery sequence
  RDMA/bnxt_re: Fix bnxt_re_destroy_qp()

Kashyap Desai (2):
  RDMA/bnxt_re: Fix max SGEs for the Work Request
  RDMA/bnxt_re: Avoid sending the modify QP workaround for latest
    adapters

Selvin Xavier (1):
  RDMA/bnxt_re: Avoid initializing the software queue for user queues

 drivers/infiniband/hw/bnxt_re/ib_verbs.c   | 21 +++++------
 drivers/infiniband/hw/bnxt_re/main.c       |  8 +----
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 42 ++++++++++++----------
 drivers/infiniband/hw/bnxt_re/qplib_fp.h   |  3 +-
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  7 ++--
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  3 ++
 6 files changed, 41 insertions(+), 43 deletions(-)

-- 
2.31.1


