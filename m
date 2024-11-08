Return-Path: <linux-rdma+bounces-5856-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B3C9C18B4
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 10:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7BA21C2308D
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2024 09:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FB11E0DF9;
	Fri,  8 Nov 2024 09:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="g/WSzhXv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5615B1DE881
	for <linux-rdma@vger.kernel.org>; Fri,  8 Nov 2024 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056610; cv=none; b=Hgjux2oYtaVsNXXMBUL56cKeBY5K5PdPiaD8z8f/VLXwg3AuNcPJQowfIM5RLwwG1i6XufndpOCA29z0bOjmMdEwi3JDVW4jNTqLJ1RpH2JbOhF73v075CLyRh8AfKNwQzy3NgG/LQ6fiDPaH3xVLRPeIxcjuCjZFjuktfOxaHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056610; c=relaxed/simple;
	bh=l++7WGqGhgaTgrcNg8jhZHBJ1xy02iTjAZiNKudPCzQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=DqAhhvJCwc7ezouYE6UIHJD2lJOKluFdfRGZl0/y94MbvBcw0rJO5z7ieGjGMrudoW6h+R2P/kiiyKG9fW86aFgEAlhnhqWie+xBC3C/RUsPbdq+WpG2xTqQXklpZkCQLQPm2e8EXvrZxrpuR7J+lg0sjQdne+9Vh5M9JGgQ/yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=g/WSzhXv; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so1501767b3a.1
        for <linux-rdma@vger.kernel.org>; Fri, 08 Nov 2024 01:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731056608; x=1731661408; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3uvo1/bH9hasysXvuRTgDw3EkQjeQOCKktiqAbwO3c=;
        b=g/WSzhXvIQUsKSf1OLJYecs9nRzS3GiR8sN4lW6vg1B6Eg5CJT2e8rUxJoX+cFqZ2Z
         aeeAYH5KldELPvqwaBmMe44tgOGVh7DhJ7oRA/zmcUJXNB/1sm8xVO5CryDa7+oL/s4u
         c9lRrG0dfi7+KZyjXQhoBxSGTTAPV6yg7KxwA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731056608; x=1731661408;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3uvo1/bH9hasysXvuRTgDw3EkQjeQOCKktiqAbwO3c=;
        b=dWgoLSsA5q1+ikb6v3BfE0lUvLEDXSnPJck/eRmHTxro2ARsc9HGnufqL/abtU4iAe
         utsXRiYkAYJ74wCpQ6oLJT11e3Qi60rhCHO4TqJZUQO/cEN5I0O1wAvJzWlvVcmj71Oa
         BPRF0cxtsNufFBazM+wxGNt+hHAHpTTciJHtIssjYqq+WwMXFd1DVsp1TT/CH9gy6ib5
         8GUdkZPvx5+cD5pPLNEc1MNBJ/TrfSNwA0uwtTk1wFjRt3MttJliHj2ooP8KSeA61MWL
         he5WuIrrcd1ED5BEF9ajfsUGw2iOENhVh3mIoFL7sglQgM4q8sNpxnTbyrsE9EvQ5ouL
         ylBg==
X-Gm-Message-State: AOJu0YzBJMTBnWefDd84uXPglfMdIXqTg48Hxt+Ms8OXW4d1/6qrqjm8
	QzkHi2/IIQ2FMk5FQXU4oFQQwcLEul+LXNZF8k4E2u8j87Mpsm/g9hwH/GigVQ==
X-Google-Smtp-Source: AGHT+IEByoI/WEzBJ9pUk5zfHHcaIJvLnX0q91fWLEAJ1ncwhGN6DW1fWJAzHOs25VcQ6UQwbKrFOA==
X-Received: by 2002:a05:6a00:238d:b0:71e:66b:c7eb with SMTP id d2e1a72fcca58-72413382fdbmr3016050b3a.23.1731056608552;
        Fri, 08 Nov 2024 01:03:28 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffcdsm3096441b3a.31.2024.11.08.01.03.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Nov 2024 01:03:27 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [rdma-next 0/5] RDMA/bnxt_re: Refactor Notification queue allocation
Date: Fri,  8 Nov 2024 00:42:34 -0800
Message-Id: <1731055359-12603-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Includes some generic improvments and code refactoring for the
Notification Queue handling in the driver. Remove the data
structures that store the NQ information out of the device
structure. Fix few issues in selecting the NQ during CQ
create. Also, fail the driver load if NIC driver can not
allocate at least two NQs for RoCE.

Please review and apply.

Thanks,
Selvin Xavier

Kalesh AP (5):
  RDMA/bnxt_re: Fail probe early when not enough MSI-x vectors are
    reserved
  RDMA/bnxt_re: Refactor NQ allocation
  RDMA/bnxt_re: Refurbish CQ to NQ hash calculation
  RDMA/bnxt_re: Cache MSIx info to a local structure
  RDMA/bnxt_re: Add new function to setup NQs

 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  20 ++-
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |  37 +++--
 drivers/infiniband/hw/bnxt_re/main.c     | 267 +++++++++++++++++++------------
 drivers/infiniband/hw/bnxt_re/qplib_fp.c |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.h |   1 +
 5 files changed, 212 insertions(+), 114 deletions(-)

-- 
2.5.5


