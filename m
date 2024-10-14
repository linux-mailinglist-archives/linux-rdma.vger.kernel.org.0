Return-Path: <linux-rdma+bounces-5400-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F88899D640
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2024 20:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2968A1F22A24
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2024 18:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945691C0DE2;
	Mon, 14 Oct 2024 18:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AgDlwzs/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5241BFE10
	for <linux-rdma@vger.kernel.org>; Mon, 14 Oct 2024 18:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728929815; cv=none; b=CDXaGf/W/1y+o/83/NsNePiXJ1sKlmVOw+DHqUKV4dTzIgIOyLXAlJJp1AyiV3T+Y333qEAX+ypSy1+0BvTcR5CF3xmy6TJJ4cEG7wuBeFiPyudRyPADco+fkm5csLOKJHYpmMepWAffq//hQ6+iMP+hskNNwVPoNf98j4L9sag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728929815; c=relaxed/simple;
	bh=2Oir69nmb97Bcky9u4i5CsKctSIFSywimCKtlnhEs6I=;
	h=From:To:Cc:Subject:Date:Message-Id; b=P1ExGuJMoDLgCBSMfb9LjMMu6PS1jausXTIQKMfrOvOS2s6/qrsZBoMGUIvSFakoMg9EU24fGTckTcYs25yWuZWDWUK6cL+v3bAtZouE/qgtXQXF7CQ/JsDVCiJHAn9aCtdNkZb2GBq0qqtxZS+hesbVwmwKzkkHUrQujc8LYKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AgDlwzs/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20b5affde14so26589365ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 14 Oct 2024 11:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728929813; x=1729534613; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Lg0Cj6QCCxb1X4KN/lb0/eIIEAbXEJ6AtlJikqNsEU=;
        b=AgDlwzs/zxDzMWkAEkYONwoMNjC/5fm8J5Mcg8+QqB+FhqbeTmuhtUvBvHG903doC9
         b1YfNHAKSVFAdFZfJMYzSykiJ1Bfwwxs6J3tDVJj0kZrHR1m1E5BjzoHvxLgj0aMxwQ6
         NoDxpZlCX/iocpaupelTHQVw4GDclZEnZdb3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728929813; x=1729534613;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Lg0Cj6QCCxb1X4KN/lb0/eIIEAbXEJ6AtlJikqNsEU=;
        b=Sj5l8eo0TdZezfhG8N30ruBFh16P5/U26c5GQhj7XPKW9kJhPWeMRTdc+ViRF2R3H6
         XUGRESxnBbzkPP2z79j4Xg0JjZWI65AjeBtXslV5D9WQ0yh1B0twwz+ciUkPNZL57xHJ
         QtYUFb1JQd634SQhPoms+hz3k1C0VNZt6WkfeUhweM18xY/440kocVSZgwZDLSaNHK/K
         +1ZfCEMCNHCi2nHJvdeEtZkYDZV+l+SOFWGRQddElvKsAkmFiruYRzZhHnZwuFmTCwF+
         /YRy3EyoPHYRV+58P+MMtB5J91oFg7qeBLg7du7OcKmOBznsBU1jNFUQpBUytNb6kJif
         QTnQ==
X-Gm-Message-State: AOJu0YyGDSCHrE/D5pCeoD4fcWlLdkSfGRIzDIHt8gfWUi9dzUGmOFfM
	4JE2Qah0gBKRCjpBDBVQY2m+4xnEWtNXq2dpCey9rbviGPySu71HUTmNWExxJQ==
X-Google-Smtp-Source: AGHT+IEgVxjv8aIhB0JzzN80tMDhl91PkInvh4rrQovSloVBfHvL/EQ9lL9XHR15MPALs7sI+7ZgVw==
X-Received: by 2002:a17:902:f551:b0:20c:fb47:5c1c with SMTP id d9443c01a7336-20cfb475f21mr43931165ad.14.1728929812994;
        Mon, 14 Oct 2024 11:16:52 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bada14asm69245605ad.7.2024.10.14.11.16.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2024 11:16:52 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 0/4] RDMA/bnxt_re: driver update
Date: Mon, 14 Oct 2024 10:55:57 -0700
Message-Id: <1728928561-25607-1-git-send-email-selvin.xavier@broadcom.com>
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

v1 -> v2:
	- Fix the sparse warning reported by kernel test robot
	  for the first patch
	- Fix a minor checkpatch warning in patch 2

Chandramohan Akula (1):
  RDMA/bnxt_re: Add support for CQ rx coalescing

Hongguang Gao (1):
  RDMA/ bnxt_re: Fix access flags for MR and QP modify

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


