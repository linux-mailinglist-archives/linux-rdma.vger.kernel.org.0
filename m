Return-Path: <linux-rdma+bounces-5421-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B3C9A03F5
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 10:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345641C2A9B6
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 08:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80891D1F5A;
	Wed, 16 Oct 2024 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UjTjgk1a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C9F4C8C
	for <linux-rdma@vger.kernel.org>; Wed, 16 Oct 2024 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066599; cv=none; b=d88OyjnJHV7RzrvUTrQ6KPTfYF/pBUvVB2nqJ+dqmwzXsWNmqqTNZQVP42q6/qXwQmLJVuiRMSOt9rOs9BFyA5nnjCzHX8Z5DYLqDRIhtSWgl8a7lwQPH00tO12Qx+YxQrZLOlwNkD0GnOXTq8Bj3J+y9Zk8m8PsJMiFOx54d8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066599; c=relaxed/simple;
	bh=KORuVpz32HE0ro+jN6vfASEOJIXWf3hf8PvpWFN6i0g=;
	h=From:To:Cc:Subject:Date:Message-Id; b=owEodOIRKMrdSFy3zy+CHErhtCEUL8ZiJHozFLpWI9d9BHMNbC2AVhOQubiyvQVLqM0IGdcGmA3AZVIZ2HZVXUxUeiuVDg0TVNrzkOZRBxrtWRh4HOi6KzohxtHCmjixGUL4KzMFJ0QSoxXmmb4A+soRti+S2dNz4Sqv00mxpT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UjTjgk1a; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7db908c9c83so3771727a12.2
        for <linux-rdma@vger.kernel.org>; Wed, 16 Oct 2024 01:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729066597; x=1729671397; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Hc72PCjTTyKyvHtKX8b2k/LmUD2HE1Idob5U8viMh8=;
        b=UjTjgk1aRN1yor1j876VRpkCQ7xIY59dwzsNfZiOUKwssYYEzUNfiRIw3lba9qQxAz
         Q22duhpU6oqHTUh620Xn1WYqT9kB1sf9Bq+xXCJGKyjK6i8I8j6hG9Ex3IUvayLLrmI2
         i154m1tFulsUzV7x/AZl7CH9REOPOLPPyVXgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729066597; x=1729671397;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Hc72PCjTTyKyvHtKX8b2k/LmUD2HE1Idob5U8viMh8=;
        b=jE1+njMnw3avSskd37v+LjVuaeBOK7RHm7NzCXGJdGnd11vHhUlrwe6ut1CxNLm2rB
         Ta9BEX5dPtIeaazPQmCSUw1F1Pc7wFX8wd0YwRWbe/EAFiCUZQKVy5+ui1awui3No9Vq
         vzCJY7t0kbzXd4PEcIT3CT3wMn3Aj4UzWv8WO5sOjymcUis3dKiq6N98QkfjJKM8Lr+1
         68MJkf3h/UAhZdLllDnbgMYCcjSwtn2VNbm2m4wXys4DffUq6+TCmte6P6UMuukNQ3zL
         ZuzlN0pdZkkFpy+ZQddhNFicuVt4pvTaWiycGdSB9b1+pQ7uujjRb5ypjMgl1lry7u2Z
         EHcA==
X-Gm-Message-State: AOJu0YyTjAGd6ebBYRCNPCd9B1SZZIOtCjwnJ+WSoYYbfDqOaEDhJmSS
	hRbRuhdH9fRDxPmWoNkKUufUtCsORvVmPkr9N2q0AZ8O8fVxaevcsL7BV+9gWSdqKunw6BzaXBF
	Oww==
X-Google-Smtp-Source: AGHT+IHmyahGfLkmi4C0tFWC+4MuIc4f49SE+NZKG1LZR8Ba8SW31Hs+fkOQ6Fckaw1E4U7CxQ9MYg==
X-Received: by 2002:a05:6a21:1706:b0:1d8:f048:c0e4 with SMTP id adf61e73a8af0-1d8f048c30cmr7706390637.36.1729066597276;
        Wed, 16 Oct 2024 01:16:37 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77371099sm2632667b3a.15.2024.10.16.01.16.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2024 01:16:36 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v3 0/4] RDMA/bnxt_re: driver update
Date: Wed, 16 Oct 2024 00:55:41 -0700
Message-Id: <1729065346-1364-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Includes some generic driver updates.
Please review and apply.

Thanks,
Selvin Xavier

v2 -> v3:
	- A bug fix in patch 4

v1 -> v2:
	- Fix the sparse warning reported by kernel test robot
	  for the first patch
	- Fix a minor checkpatch warning in patch 2


Chandramohan Akula (1):
  RDMA/bnxt_re: Add support for CQ rx coalescing

Hongguang Gao (1):
  RDMA/bnxt_re: Fix access flags for MR and QP modify

Kalesh AP (2):
  RDMA/bnxt_re: Add support for optimized modify QP
  RDMA/bnxt_re: Add support for modify_device hook

 drivers/infiniband/hw/bnxt_re/bnxt_re.h    |  8 ++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c   | 76 ++++++++++++++++++++++++++----
 drivers/infiniband/hw/bnxt_re/ib_verbs.h   |  3 ++
 drivers/infiniband/hw/bnxt_re/main.c       | 10 ++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 60 +++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.h   | 20 ++++++++
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  6 ++-
 drivers/infiniband/hw/bnxt_re/qplib_res.h  | 10 ++++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h   | 17 ++++++-
 9 files changed, 199 insertions(+), 11 deletions(-)

-- 
2.5.5


