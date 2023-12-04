Return-Path: <linux-rdma+bounces-229-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 966EF803EF1
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Dec 2023 21:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E091C20AEB
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Dec 2023 20:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601273309D;
	Mon,  4 Dec 2023 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFv4tRzZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F67DC4
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 12:04:09 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-58e31b5b0d0so1229040eaf.3
        for <linux-rdma@vger.kernel.org>; Mon, 04 Dec 2023 12:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701720248; x=1702325048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AYL2MxqW5sHfhOvGocyQ17maRXoysT+ki4zPdBGJhbk=;
        b=fFv4tRzZhEd0sbFRhYCuCaC9dh/jlIMxCq/yxV51ovCL3bfIuUPxk82o9E2WGglJz8
         KW4FJlSbtOgExoOIOCxELhvDEyyjquH/3/agZ1afBvZ+CiHcOn7B6V17UuAVvTqpBKUZ
         hW3b2Zg94yWwiVAx1alzhp3P9dMTAWbebjz4uDsgODtD5/qAKOQckbqXU/amZSSvwvbY
         utVoBiqsHP1qZibWhzKDxU6aEVXUiaHZxfVCyOldRduONGgJRlH6EK4ZSZYsRMSZSIRb
         ECRNFYIaGALZbHisUK0XijiLMsyGWO5dYrHLf5xL6gabxwePqsYZtmVWv9rJfEQ7MEkS
         8iDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701720248; x=1702325048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYL2MxqW5sHfhOvGocyQ17maRXoysT+ki4zPdBGJhbk=;
        b=s54fChD0WfsO4jbeoEXlsDHzrrRirI6duEt/XSFw7Yiy1bOCRcZVsyG3duFvc7zjUX
         RQ+pomIl/AwRz9/xEnoKqfqlSciUJXwcfpcqush1qCZwqfTBKVS+rBHbfaDBkjKRBhLg
         2r/Hkz+eZ8vDISce/mmwJ/meuEVVGO0jsqb+xO8vCgXWqaFkJvVkOv5lb7PlnHG/IQzU
         zTLjkmFVR/DKJ2ytvFCM/aTANj8Djkoq1dfpzLPlq8QiqOdaEpBRmVN3k5fZSkSsWw1k
         xhvnGblLJvXVq4gLl5THx9kvJDZhOhn7ydHnmmk3zi2dxR99stpi/myqBYhyElTZYrEY
         VtVg==
X-Gm-Message-State: AOJu0YwMSnUY/l5E9ho8FlGbffg1HSfXUCfbBeh+rpzLfqZ1urLI/q5u
	80RhyyedN7HGNTJMdAd5Q4k=
X-Google-Smtp-Source: AGHT+IH5DRwUHFj+P85jdv+WaW2chUG2vGVLDimidsN2rURw3lLUKQypbiRfHGcwGmbQNHn1FLpAKw==
X-Received: by 2002:a05:6820:515:b0:58d:6217:795e with SMTP id m21-20020a056820051500b0058d6217795emr3215429ooj.8.1701720248410;
        Mon, 04 Dec 2023 12:04:08 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-e463-fe8f-1aa8-6edb.res6.spectrum.com. [2603:8081:1405:679b:e463:fe8f:1aa8:6edb])
        by smtp.gmail.com with ESMTPSA id e72-20020a4a554b000000b0054f85f67f31sm537281oob.46.2023.12.04.12.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 12:04:07 -0800 (PST)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: jgg@nvidia.com,
	yanjun.zhu@linux.dev,
	linux-rdma@vger.kernel.org
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v4 0/7] RDMA/rxe: Make multicast work
Date: Mon,  4 Dec 2023 14:03:36 -0600
Message-Id: <20231204200342.7125-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_mcast.c  | 524 +++++++++++--------------
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
 15 files changed, 303 insertions(+), 360 deletions(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_param.c

-- 
2.40.1


