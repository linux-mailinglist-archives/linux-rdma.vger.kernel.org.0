Return-Path: <linux-rdma+bounces-4737-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CA596B85F
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 12:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBC8EB2501E
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 10:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF371CF5DE;
	Wed,  4 Sep 2024 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KAkSWSeQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713D31CF2B5
	for <linux-rdma@vger.kernel.org>; Wed,  4 Sep 2024 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445504; cv=none; b=A/+rdStxZoXoJ2Vvi+SJDfuem1BzxECvUCz6otOz1m6IsBpMt+cgiceLj7lRUq94n/e2yhJQIZnwVb9HszTayCPsguk1BlZdQr+BCyY5YqTHlJXbfUhagl0vXgr8Zmo87S4qNfiqKpvJ8GQlW72gr6XFPxUA0DYMcpJ24Ho+bnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445504; c=relaxed/simple;
	bh=yFYsxuD3sDUI8FZwxUd2MZ9jvbEDZhS3J/K1EfK69ms=;
	h=From:To:Cc:Subject:Date:Message-Id; b=M9f67s/A3/SeE1T7bFBuwaodsfG7tQzwZr1GhjtVhgooVYTTnwdUOMYX26AhorThF3ELD1rnyTzzWI9uy7mbM3RxKBDt8jRbVgttjbPVxlOqWlUkYU+pnmeMPQ21qx44YxtalY4+hH/Woun2My1L4lZqImIVHIEgu0RrFQlQv4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KAkSWSeQ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2021c08b95cso4716925ad.0
        for <linux-rdma@vger.kernel.org>; Wed, 04 Sep 2024 03:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725445502; x=1726050302; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFrj2xFn6J+WbBCN6F4vPCJf6haIatl6AW+MJb1nn40=;
        b=KAkSWSeQ4e3+JQSVMT0DFoRwhYQl8XPxUCKxmAs3OCbCLf/HWTpZUs5WEJUMWpUsKd
         gGzm0jC3LfXcWtAxvpYnAzijrqUbgtg/ghJzeZFYatkCWCx2S6/JZPspop3tQfh2pzmu
         B7vCypuVInaWMBzC2/x5nBAIbVpRw0/BEYJPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725445503; x=1726050303;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFrj2xFn6J+WbBCN6F4vPCJf6haIatl6AW+MJb1nn40=;
        b=vfXn79dhQOFd/HKihRxlFo5DLiPHkFTxjvSfbC5oq/hZYS1LfoEIupQszYUJ2q+uOR
         oqhkuxdDIrpbOIOMa7fntUCtmUw54TtJXPkS98HEHntVRg3FLirKwax7mkAQQHYx23I8
         xitwqo9VFuF3RmAQ+Kih4ic+Ty2HPgn0/smBdJcKnkSrPdnHqu3YjSFGpTL4dQrofbmV
         PPSzKlPBekpzsKqLRrPUXYK9iBiG6wUDN9a7PbJaVh9h994BCLuoX2MR2s+KlDH9u01B
         qUW29GcLHyYq8iQKNrtTkC3Ay5yFMPPKGQE9GpdStZWX01+h8Vet17kNBy1R2pSDhcLG
         dItA==
X-Gm-Message-State: AOJu0YzJz5nRK/9bviDcrqnytb4MAuhsIYb16ZZg87KZrnKkMZDW8Br0
	Vi2JGQoKzFH0y4/KrpQUi8v0S5fGhDzffUMqJdbZSbR7IkmeBI+DvHfT9JSKzd/qOQs8OJjVNQ6
	eDw==
X-Google-Smtp-Source: AGHT+IFrgeU6dpeh+JIlhLnhsUUKk+V1Mv9MNVbGYES5sf5JMfc1WNdl+u1hDKgAPD4ga6SOjzoocQ==
X-Received: by 2002:a17:902:ec88:b0:205:866d:177d with SMTP id d9443c01a7336-206b8372fbdmr29331085ad.21.1725445502591;
        Wed, 04 Sep 2024 03:25:02 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea383aasm10940265ad.136.2024.09.04.03.25.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Sep 2024 03:25:01 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 0/2] RDMA/bnxt_re: Bug fixes for 6.12
Date: Wed,  4 Sep 2024 03:04:11 -0700
Message-Id: <1725444253-13221-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Fixes couple of compatibility issues seen with older libraries
with variable size WQE patch series that is merged to 6.12.

Please review and apply to for-next.

Thanks,
Selvin Xavier

Selvin Xavier (2):
  RDMA/bnxt_re: Fix the compatibility flag for variable size WQE
  RDMA/bnxt_re: Fix the max WQE size for static WQE support

 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 25 +++++++++++++------------
 drivers/infiniband/hw/bnxt_re/qplib_sp.h |  2 ++
 2 files changed, 15 insertions(+), 12 deletions(-)

-- 
2.5.5


