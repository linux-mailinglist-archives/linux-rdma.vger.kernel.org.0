Return-Path: <linux-rdma+bounces-4607-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E304C9622FA
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 11:08:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20A151C21315
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2024 09:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7FD15C14F;
	Wed, 28 Aug 2024 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RFGLbYIu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519BF15A849
	for <linux-rdma@vger.kernel.org>; Wed, 28 Aug 2024 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724836083; cv=none; b=b8iCHdBRGUCrCP8WhNYZQMSJFtXxJnUfCHHGNvkIjtKNtLu6ABNznAXgdLrjmubErx50+nANQXkDKONXVHXQxwKKTFXPZ07T/FFk5fU7Wr68qfkOGstiWh2afZnLddCBLkcI7Yb/uJ5GW7u9C1YbzQRsrhgphHp9FKLtBnHTXak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724836083; c=relaxed/simple;
	bh=G1Kth3+3/qudoi3XmHBPycMzYTwuU76hF84xuNdtda4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=Xeq+gkKZfLymT/HHVGAZaMt9H9OOu42v14Uq9ZghxpnupRp6MHupsLukQSr/mRjmfo+IgiY97FoIujs+5LAaq2ioqlzEwfuD4MkQYKRYfNGLFh5ZlW6VaUtGY+g1Hq4XdZloMLJIksoBdZCZf1Eob4pXdUVJheEBO7AkKyMSznk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RFGLbYIu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2025031eb60so56978615ad.3
        for <linux-rdma@vger.kernel.org>; Wed, 28 Aug 2024 02:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724836081; x=1725440881; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgVz2rpaZXCPaxkjc3NkTKbuQjeJhlXJXiS6zDIyIeQ=;
        b=RFGLbYIuGLn6LqB6atKTI8UYMf+gMcqTDBpcd117HKaqrffFeAs8PA6H/v5iDNCbR0
         hzTzzjmWTLRsnn5CZPomeSB2keSL+wjSvHKpB786BIAcWFsyINQVs2eH0I8Qn6ngenqO
         pB2NuoP+cXPj5USalMjaxRcexHSPOFvqnfVRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724836081; x=1725440881;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgVz2rpaZXCPaxkjc3NkTKbuQjeJhlXJXiS6zDIyIeQ=;
        b=ZIiPzIcfPFJF0tRUwhTCiY2bHz5JG5cP8z0qQnNuofiHVtb+ykCyy8kl2jshxiWUig
         FIDMDecrXmPHV8Q5T5QTmyNeH8SESWH77d650R7bTE9NTpoJIHs3hG3seCZ6wUOs8NJp
         G6uSTAGqBgm3TQppmZjKcjeNvaoT7x4TSLVv0JRcqw48ZpkWu/LKhDOLzMMBExqJdRUg
         jyKGygNba6hymg8x//2EJWMNW0KvDFR2jmhX6tmscYE+A3G/2onGaz8031bPw5qOHMeB
         X1zLT4XRr8l65KpY38Jh1BYGOtiFetW8AyXlf0k5mSlkLjzWkzysK8fRn/NHas7Kx4f6
         I9kg==
X-Gm-Message-State: AOJu0YxNhNLsFrMS4T1cxqWlXLXc+Ee8agH4PKOIhHyl1ZBlYSCTZMt2
	K9QrJZlOr7E4WN4GqFzVIHA15sBWhyDyEiOREHvsAQE/6FSPjQaU71Mz8xjtMFSq29KRsAxceds
	=
X-Google-Smtp-Source: AGHT+IEH2IANrr4c4TdeDruUety/v4paOHAtleuFjhOKpOC0+90fsG++MBvoQ8lbjBwRxAkLppo9YQ==
X-Received: by 2002:a17:903:40c6:b0:201:f30b:f616 with SMTP id d9443c01a7336-2039e5175c5mr171014535ad.61.1724836081520;
        Wed, 28 Aug 2024 02:08:01 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385609dddsm94735955ad.196.2024.08.28.02.07.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2024 02:08:00 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	chandramohan.akula@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 0/3] RDMA/bnxt_re: Toggle bit support for SRQ events
Date: Wed, 28 Aug 2024 01:47:09 -0700
Message-Id: <1724834832-10600-1-git-send-email-selvin.xavier@broadcom.com>
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
 include/uapi/rdma/bnxt_re-abi.h          |  5 +++
 7 files changed, 66 insertions(+), 13 deletions(-)

-- 
2.5.5


