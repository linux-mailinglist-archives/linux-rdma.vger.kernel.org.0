Return-Path: <linux-rdma+bounces-249-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFEB804347
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 01:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13965281300
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 00:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19C539C;
	Tue,  5 Dec 2023 00:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+wUmOc8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E4F116
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 16:23:56 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b8b2d0db48so2002369b6e.3
        for <linux-rdma@vger.kernel.org>; Mon, 04 Dec 2023 16:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701735835; x=1702340635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aBJZJJ2lg4hnBdTeWk2xl3AWqATX8c1GWhuam1itj78=;
        b=B+wUmOc8Nd1JzCIOHdnwMJ7X01KhH0fZ9dHUCCGKFDECKEITuvyoF0o6fTBobMyfOE
         LjoEzkAs/IgYqSmhM+Ly45rzVXErqyWeEqfFa0qj7fsBjpfpEC8teuf3uuVy2cdzpd6i
         DCKjHRlVqNAaVkNxnW8aIVG9WfrYJBi3CGLZcFlbHfqpzxFms+4PbsLJSrYh0Cttrw6D
         qh2TM3F8VAfXoHc9qZ3gnQD18piLmQoewTmw7AwTBpNYnyE+dyEp5/nziALZP0ehAMoF
         LAL0Ck4rQzbB6fwA5v3agHOAj0cA6u0dwVdpJ8+Q8//tDqy9Lj+8VASIV9aSRgxWdrg5
         3jZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701735835; x=1702340635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aBJZJJ2lg4hnBdTeWk2xl3AWqATX8c1GWhuam1itj78=;
        b=iF0G4sSpLcglfu16Zdiy4Ev3XcZojz2enRV8h035JBP00yeCsZ75K2Zuw3Ct+h0nFN
         NcKuxaNFCtVqNTL9FTzRv6d7rnfTvrCMA7R0SQzP/WQoRQ+hrCfpdGYApNf7EHOQuTWP
         ruWhrNidg3tRAaiHfIsOf/pvkIiUpRWqm18MK+zzj2k1EYMR/0lZxrqG0xixrsw5AumU
         Ti0jvlh785dAB3M1WrFsuf1A25qPo4bkqJgBp+IcF1f0c+2EVVnmKK3W0ulyYhcxXyzW
         0CP8pIfUN3qsS0ksH5oqkEy1MM146/1igHWZ+mYH/pVDdnG+zaGffm3GPrGlwnqRz1iW
         QACQ==
X-Gm-Message-State: AOJu0Yw7ZSTQekxfZSISKDCrQAdbuvdQmQvje5a2DB9d2P/OPiBIW/Ue
	ztnNvCHz5PmMYTiGmPGqh7g=
X-Google-Smtp-Source: AGHT+IHv9NAMzNSjClJes218rviYEQRKR8q08ms6jg+yY1H1bGWzXeXF0n1prG0CpF1h4zz07LOOLw==
X-Received: by 2002:a05:6808:1694:b0:3b8:9999:d82b with SMTP id bb20-20020a056808169400b003b89999d82bmr6483797oib.3.1701735835489;
        Mon, 04 Dec 2023 16:23:55 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-e463-fe8f-1aa8-6edb.res6.spectrum.com. [2603:8081:1405:679b:e463:fe8f:1aa8:6edb])
        by smtp.gmail.com with ESMTPSA id bi25-20020a056808189900b003b2e4754cc2sm2007066oib.26.2023.12.04.16.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 16:23:55 -0800 (PST)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: jgg@nvidia.com,
	yanjun.zhu@linux.dev,
	linux-rdma@vger.kernel.org
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v5 0/7] RDMA/rxe: Make multicast work
Date: Mon,  4 Dec 2023 18:23:16 -0600
Message-Id: <20231205002322.10143-1-rpearsonhpe@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After developing a test program which exercises node to node
testing of RoCE multicast it became clear that there are a
number of issues with the current rdma_rxe multicast implementation.

The issues seen include:
	- There is no support for IPV4 multicast addresses.
	- Once a multicast MAC is added it is not removed.
	- Multicast packets are sent with the wrong QP number.
	- Multicast IP addresses are not created and without
	  them no multicast packets received on the interface
	  are delivered to the rdma_rxe driver.
	- The implementation in rxe_mcast.c is potentially
	  racy if multiple simultaneous attach/detach operations
	  are issued.

This patch set fixes these issues. 
---
v5:
  Missed previous fix in error path. Add sock lock around
  ipv6_sock_mm_drop() in rxe_mcast_add6().
v4:
  Corrected a lockdep bug reported by Zhu Yanjun.
v3:
  Removed rxe_loop_and_send(). It turns out it is not needed.
  Added module parameters to set mcast limits to small values when
  driver is loaded to enable mcast limit testing.
  Rebased to current for-next branch.
v2:
  Respond to comments by Zhu.
  Added more Fixes lines.
  Added some more explanation in the commit messages.
  Fixed an error in rxe_lookup_mcg. Should have checked
	the return from rxe_get_mcg().

Bob Pearson (7):
  RDMA/rxe: Cleanup rxe_ah/av_chk_attr
  RDMA/rxe: Fix sending of mcast packets
  RDMA/rxe: Register IP mcast address
  RDMA/rxe: Let rxe_lookup_mcg use rcu_read_lock
  RDMA/rxe: Split multicast lock
  RDMA/rxe: Cleanup mcg lifetime
  RDMA/rxe: Add module parameters for mcast limits

 drivers/infiniband/sw/rxe/Makefile     |   3 +-
 drivers/infiniband/sw/rxe/rxe.c        |   8 +-
 drivers/infiniband/sw/rxe/rxe_av.c     |  50 +--
 drivers/infiniband/sw/rxe/rxe_loc.h    |   6 +-
 drivers/infiniband/sw/rxe/rxe_mcast.c  | 526 +++++++++++--------------
 drivers/infiniband/sw/rxe/rxe_net.c    |   6 +-
 drivers/infiniband/sw/rxe/rxe_net.h    |   1 +
 drivers/infiniband/sw/rxe/rxe_opcode.h |   2 +-
 drivers/infiniband/sw/rxe/rxe_param.c  |  23 ++
 drivers/infiniband/sw/rxe/rxe_param.h  |   4 +
 drivers/infiniband/sw/rxe/rxe_qp.c     |   4 +-
 drivers/infiniband/sw/rxe/rxe_recv.c   |  11 +-
 drivers/infiniband/sw/rxe/rxe_req.c    |  11 +-
 drivers/infiniband/sw/rxe/rxe_verbs.c  |   5 +-
 drivers/infiniband/sw/rxe/rxe_verbs.h  |   5 +-
 15 files changed, 305 insertions(+), 360 deletions(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_param.c

-- 
2.40.1


