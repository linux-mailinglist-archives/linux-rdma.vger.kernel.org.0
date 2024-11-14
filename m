Return-Path: <linux-rdma+bounces-5978-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAE89C8758
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 11:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2240A1F211EE
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2024 10:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BB01F8F15;
	Thu, 14 Nov 2024 10:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="hVLPQdKn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C11F818E
	for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2024 10:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731578997; cv=none; b=d6OlPOPhRxCcgKYyhSU6CdzVNN+wG16gu0Y265DEZ5EiXeaWkFlKujcHeGEXOFcIf2Rg2Ide0E70TLZ5KihhvfFDNChhKstLdLo7VtWtyhMqqHlZwKHOkcBeqGN/cPZR5wiJms7BubiNjXZ4jzg4jCSgcfloeE1LEwPZK8X0y1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731578997; c=relaxed/simple;
	bh=4Jn+ER1D+T8uZt2XMEWjeoE83fXFsaOSZv41SWwcoxs=;
	h=From:To:Cc:Subject:Date:Message-Id; b=csOlFSr8Yb6Uee2Lwye3eofw5gFexf1pfx/RRjrmrRv+Wajm2SS0C5CurzlRu51ZV3ClDjNtPJ1V1przEqFKyPi1ISBc82yVoMJgtgZmnGFRyD+RlaDj+G4AkStXa/2MA8HAv0U6I+SJQnLeGrUm6gvh59AePk387I1szqJqdds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=hVLPQdKn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20cdbe608b3so4037675ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2024 02:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731578995; x=1732183795; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sqs22u22qw/vKp6E8qUqtpdl25QngpO3H4zZ9/4y9wc=;
        b=hVLPQdKn79Oou+b0uR+0RZZu04SOCqJGzVPSaimZBy1Wd1qmZy3YDPyoHC/ZKZH7Kd
         pezPPZ3BRsdvcztkGbTRA3TgiG1PM6mpLOXROelDgwSkmnxxKzFpzNLRsAOgeBRl6kxs
         IOlINoq1kAD//MShbD0kLue9L8+aTXZ8znPqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731578995; x=1732183795;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqs22u22qw/vKp6E8qUqtpdl25QngpO3H4zZ9/4y9wc=;
        b=U7NGudZM4t8SlvVlHvEYUGPXw3jsTmq8+EVYmfkaIfdHfaXCLBk8PFSekj5MYgyyEg
         60oRrWRqIuKOQKxslPFCHg4UUEDtyuMupnKsRKAfXqRDRc3a3KCT0LIOeYHkDXc1FFfN
         JWfBxjXRqWMcpl4sUndAhn/JuWrPknKIFg1OJa0WXX7YuG1m6r8Msp/5xK6H23U86VJW
         OfZXm/CG2PJjeWntwR6syZdBX6ONPaCYOI4MEqZ1QfwI4CcAId1pZoo45L4NyA1bEKpr
         B49pKfgwYK6kQ/YJ01VOkBT9lV6LaKGpLA4M1ZK80Z5vbk+8nmPDKSuUfGlKnJ62ALRd
         6vKA==
X-Gm-Message-State: AOJu0Yz27WfOsepm3iIWTcVSvvVPpoYvX87FG+1V3UpXxun7iYJrLRaY
	v6tZR5JTqb51jglzmqxt0y94gmfNwItCIPB9r3d4xAyDJcPw9hXhDHP2yFF48g==
X-Google-Smtp-Source: AGHT+IH+NrBsicMTcWkcusIPHCjDp13XKMheIwddzw+o56O/uMgG7PnfhzHPhLasuhfvPa1NikjQ1Q==
X-Received: by 2002:a17:903:22ce:b0:20f:ab4a:db2e with SMTP id d9443c01a7336-211ab980431mr110946185ad.29.1731578994655;
        Thu, 14 Nov 2024 02:09:54 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d062absm7251135ad.206.2024.11.14.02.09.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2024 02:09:53 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next v2 0/4]RDMA/bnxt_re: Refactor Notification queue allocation
Date: Thu, 14 Nov 2024 01:49:04 -0800
Message-Id: <1731577748-1804-1-git-send-email-selvin.xavier@broadcom.com>
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

v1 -> v2:
 - Dropped patch 5
 - Fixed error handling in patch 1 by adding bnxt_unregister_dev
 - Removed redundant comment in patch 3

Kalesh AP (4):
  RDMA/bnxt_re: Fail probe early when not enough MSI-x vectors are
    reserved
  RDMA/bnxt_re: Refactor NQ allocation
  RDMA/bnxt_re: Refurbish CQ to NQ hash calculation
  RDMA/bnxt_re: Cache MSIx info to a local structure

 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  18 +++--
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |  41 +++++++----
 drivers/infiniband/hw/bnxt_re/main.c     | 114 ++++++++++++++++++++-----------
 drivers/infiniband/hw/bnxt_re/qplib_fp.c |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_fp.h |   1 +
 5 files changed, 115 insertions(+), 60 deletions(-)

-- 
2.5.5


