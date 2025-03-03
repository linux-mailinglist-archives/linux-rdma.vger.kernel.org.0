Return-Path: <linux-rdma+bounces-8256-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBC2A4C9E1
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 18:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79488188BF9F
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 17:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBF52356DD;
	Mon,  3 Mar 2025 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZhPFJbzd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F63E22A819
	for <linux-rdma@vger.kernel.org>; Mon,  3 Mar 2025 17:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022427; cv=none; b=Cpt1cU88/PV4N7ZOCLzjuNbegQ/lpX5SzrCozqRoAV/iOTcRcPMcem8W0lA+6LaLNxW1fA1Qu+jopR/QhdPbp32RxQ0AunF431+A4JLqeaulkcTDW4XJxK/kk/XBX+YI3ltPeK21X0s1wcFOdJsUY6NTLtPFIUJ1zE4ftYH660U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022427; c=relaxed/simple;
	bh=SHz+8ytpCSTq5e87MXToHEceh38A7/gjgn05QTq8QpI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OsOji7vAXnjsZWd0dai2uAxuV0KgaLdmnjoqB5Th0tosDrPNaQbfyUVx9/jsb1Ft1prEz59fl676qG409h26GvrZ4FTWPonMyOnKbbPh41h1HLrLmmJz01eFMysk8X6tXF0YyJfggWfpxwkIyvDoZNAfJ3QbfC2v+TntaTBwEY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZhPFJbzd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2234daaf269so60844135ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 03 Mar 2025 09:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741022425; x=1741627225; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7chQI1HyYpbBw/XZdinvcYwdnzFZQ7RnGK43UGFSwUw=;
        b=ZhPFJbzdaQNXcyT5ypQqRaGv8P2kS/sH25qh9c+ggEQ/YaMwLAt+CZ9OBXhqTWNXEi
         RZ4AZrZRBwlYO+yFH3BptrgQkRCPwEkJD3sSaBPQPf55Ulpw+Q8ttrhFwwesXRmxcwdi
         R00fbib8AKv7/Dar/AFpd3FYRCR71ZOqWafGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741022425; x=1741627225;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7chQI1HyYpbBw/XZdinvcYwdnzFZQ7RnGK43UGFSwUw=;
        b=CXmYapz96wEDcSN73E+sfmXEDZMAw1MVz6aoySVzoAwH6h1EKOWP1YZIhJ2zeWsh4c
         CT+Dps9XXh547s/eu/lk22mOLZJXyKJsuHWXSs9OXeb5CLB+BpylDPX5BphufntgKP5J
         Fzs2iuqZiW7LtoBtx8ReeMi1YXLam1olvfv2vGkUmeVmA52EAwIqXZOUEwJ++v1dbMqk
         xk4Vck/z2luNRDLZqCR7ISOMVP9PujclcPlJjPSzeVGtDU7AovqPj8ojpEe/++duohYM
         qPiw9K4z9YS8l3xR7VlTW5zxlqyQH9+T7eXVBosc2L6BCj1j/llv9dpAaVwmgf8cieJm
         Dv5A==
X-Gm-Message-State: AOJu0YyM2baUF8Bo73QsD2Epjjhhn5Ahd5LtPczWl+1q3H99JPMAKiJ3
	b7n88co7gFpHn6BPH0/EsVEEhEbktVEplr5dHISovfjJ6MytnxT4z2uVlhGylA==
X-Gm-Gg: ASbGncuIdxZ0RIl8SHqqGRsEotUopsyizh1z4oIAcqW9WSl4/g+mj8d44EJr688zJcx
	coHBHbziX7Z3tkr2o/qz9iQAqauEKyUaCAgIBR0+WMrsB1WI9RX7G45NuMgCzZY84HlHXzWBRba
	OIcAz09nLzZli/vN7pz2adOTz6vvccpRBl7jCu8aS1Sk9W5aR4mI4xImIuwnkLESBhDvgDer0pI
	3Lodk8zwJcqHsEua7HeTEBNGKuAX/LZbL7uCtsLx444XKGh17RQzHDlABOe9tOiMp795/M64uLA
	PLQWtghSHZ4UuOUvvtwC0wTbV6mQsPnrRVzp7MbkCBzPUsX4jvnXMTz7IvS9382zbLkkZc9n+VU
	V4d1GmD2WGTSD9uFBznOUeSxe
X-Google-Smtp-Source: AGHT+IGSiIGIl4YUSkNPAKULsmbS7aZAqH5XjPltAfxISfKiI+MGZthwDlJhpK2Z4SgFQ4oMwUE3og==
X-Received: by 2002:a05:6a00:92a1:b0:736:3ed1:e83a with SMTP id d2e1a72fcca58-7363ed1eb34mr11039370b3a.12.1741022425550;
        Mon, 03 Mar 2025 09:20:25 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7364ba1371asm3064917b3a.5.2025.03.03.09.20.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Mar 2025 09:20:25 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc 0/3] RDMA/bnxt_re: Bug fixes
Date: Mon,  3 Mar 2025 08:59:35 -0800
Message-Id: <1741021178-2569-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Includes some of the critical fixes found while testing
with increased resource limits. Please review and apply.

Thanks,
Selvin Xavier

Kashyap Desai (2):
  RDMA/bnxt_re: Fix allocation of QP table
  RDMA/bnxt_re: Add missing paranthesis in map_qp_id_to_tbl_indx

Preethi G (1):
  RDMA/bnxt_re: Fix reporting maximum SRQs on P7 chips

 drivers/infiniband/hw/bnxt_re/bnxt_re.h    |  6 ------
 drivers/infiniband/hw/bnxt_re/main.c       |  3 +--
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 10 +---------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  6 +++---
 drivers/infiniband/hw/bnxt_re/qplib_res.c  |  9 +++++++++
 drivers/infiniband/hw/bnxt_re/qplib_res.h  | 12 ++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.c   |  3 +++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h   |  3 ++-
 8 files changed, 31 insertions(+), 21 deletions(-)

-- 
2.5.5


