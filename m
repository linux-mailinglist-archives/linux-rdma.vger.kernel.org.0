Return-Path: <linux-rdma+bounces-4640-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F9C964AB6
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 17:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CFAD1C249AF
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 15:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5951B29D7;
	Thu, 29 Aug 2024 15:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dq08AlvG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30201B1432
	for <linux-rdma@vger.kernel.org>; Thu, 29 Aug 2024 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946905; cv=none; b=HAxGWOiifBMBDzN8EwirY3nYjc21jO80J8uwjyxIAwq311aoFVgcdCD4BgE9MEYc+cD6fnpogTZMBujWUEtaJ99e8ZSCdXE9fP7+4XXwMM+YhPO99UZUEx5kLXMr+XIpRqDTDWjmF63xH9ypcU0qivg0r34aEN9QBNt93hDMysI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946905; c=relaxed/simple;
	bh=QUu5Nxvl/wlTp5NSD/FjrOjujf1m6o5gc+teRbmekpM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=GKDAfZirhAZuAwAGKAK92ZQsMOkjt7k+xDv1r5FxIYFbKSq+wP6hakrBehJqqgWwvYM6OgDcZowKJ/bFxrbnw4hK01Xbj57aIa07UXtubnuPiBAxZskYrLDNAhvKIwrkGJDW5YmViP3ndxoodWSWaV+b7QLNPDrvinB3Tjd+ZZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dq08AlvG; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7094468d392so472857a34.0
        for <linux-rdma@vger.kernel.org>; Thu, 29 Aug 2024 08:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724946902; x=1725551702; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=he85rS1tKTYpe3AYKtPwuxcCR++d2cJwkpqrWBF5wgw=;
        b=dq08AlvGAfbLbhFw75rajoe8t7m2D6gH+w4nMUMN6c5cbdiLLjRcwDkSRM00/IMJyk
         +HcgcYYrzr/VHgDPuWGeBt+iAJ7WfXFkUBNxMUZCkwjxZovu09oXJgJGw6J/AR5RW+IH
         lHYS9a4q/UZ6O0dOrYxzAtbc+BS9IfAf5Y1gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724946902; x=1725551702;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=he85rS1tKTYpe3AYKtPwuxcCR++d2cJwkpqrWBF5wgw=;
        b=tJPoMiCmscRfM/Z8aw+sonWFWrRC0Cyj58XSnFVyVeTLTEhuR0Qpoy0YhIRctGmVwD
         n3gcLj1GGnhaJ0M7mmk8EiXP0uKIraoEcsKtAJgDJTb9YcKvWUYUSGIYNwIucDsk5Nis
         05pg0IzW9n/wSNvRSUZd1g4/cSAkgptDxUVchsZugMk3HSC2+uZEgxU8w3yOjVuW/2ja
         OOPicYTgoAgs98ZY8EwV9mHbAIt6XU87Oo0HlbzEs2BZw7VdoZoMota6m1utfk7GuTGA
         tfmetwCBPI0v4xOM4DidAZJ5+PVxUJ9gOnRWjI0n3c3RzF2cXC2c/Jj6MH2W0Svl6oS+
         JikQ==
X-Gm-Message-State: AOJu0YzOpxdusy02ss/4IXmgMm0or9/rBQXNQ+SlymUSbYrziQyqURq/
	eDCwEFMVVhuB5hnMtLp7tkmv3AIgYmqNN4H9Mi/S9C0BtzTy0TNNAkpa6gFLvQ==
X-Google-Smtp-Source: AGHT+IEntWLFwdh6304bePdufXndH6XOEImKSF/PT0tR1KzW8AwaSJ61mfM0IcY0xCKLOSw6NacbYQ==
X-Received: by 2002:a05:6358:4316:b0:1ad:95db:b6f2 with SMTP id e5c5f4694b2df-1b603c44523mr428860355d.17.1724946902255;
        Thu, 29 Aug 2024 08:55:02 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e9be627sm1396735a12.57.2024.08.29.08.54.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Aug 2024 08:55:01 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	chandramohan.akula@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 0/3] RDMA/bnxt_re: Toggle bit support for SRQ events
Date: Thu, 29 Aug 2024 08:34:02 -0700
Message-Id: <1724945645-14989-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

SRQ events from HW gives a toggle bit value that needs
to be used while ringing the SRQ arm doorbells. Adds support
for this and share the toggle value to user space applications.

Please review and apply.

Thanks,
Selvin Xavier

v1 -> v2:
	- Adding __u32 reserved field to bnxt_re_srq_resp to align the struct

Chandramohan Akula (2):
  RDMA/bnxt_re: Refactor the BNXT_RE_METHOD_GET_TOGGLE_MEM method
  RDMA/bnxt_re: Share a page to expose per SRQ info with userspace

Hongguang Gao (1):
  RDMA/bnxt_re: Get the toggle bits from SRQ events

 drivers/infiniband/hw/bnxt_re/bnxt_re.h  |  2 ++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 52 ++++++++++++++++++++++++--------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  2 ++
 drivers/infiniband/hw/bnxt_re/main.c     |  6 +++-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c | 11 +++++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.h |  1 +
 include/uapi/rdma/bnxt_re-abi.h          |  6 ++++
 7 files changed, 67 insertions(+), 13 deletions(-)

-- 
2.5.5


