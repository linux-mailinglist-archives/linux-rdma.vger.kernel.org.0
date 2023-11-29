Return-Path: <linux-rdma+bounces-142-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 219017FE0F5
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 21:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E0CA1C20AD1
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Nov 2023 20:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0017D60ED0;
	Wed, 29 Nov 2023 20:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l266eEwh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4136D7F
	for <linux-rdma@vger.kernel.org>; Wed, 29 Nov 2023 12:26:25 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-58d521f12ebso135776eaf.2
        for <linux-rdma@vger.kernel.org>; Wed, 29 Nov 2023 12:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701289584; x=1701894384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dkdVLOXciU+j6RK5INFa5Ivz2gWQ+0a64AvSm2Foijs=;
        b=l266eEwhRlOcwfTI3pDHLll0qv0mMXy/nMeaqn+aMtpWNGzc/tlen3R8611kGWHGYd
         wlJ2uPaUxukGrUHsibcLAltqP+qn+1lg+CG+yi7vckHFRz+Hnh3SCfGY0lFUSZB43ziC
         aLxZR/k8LoIEhJLqhZeM38AwgQtcjIUBm/l3O7hrt4s2AxYVz3XGm3lNQlK4Uieia9Ta
         7g1Z2+cl7ybjXHvRD0Cyscu2cOqZFnx55+PTJ1pAX3BaVQW7Dea3ycSUuBzvXRZyYMeO
         u8xfRP2e+uIXvVdrI+M6R5pZBUeZLxo2SqWZXpBoIpFQoAYMN4yCrXxAfyfxoNbb2xcA
         1AjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701289584; x=1701894384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dkdVLOXciU+j6RK5INFa5Ivz2gWQ+0a64AvSm2Foijs=;
        b=Rp9UJ6Ju2Wy0dtSI/tWqYhEgzSL52eAjGk5Ri55yDZOUIjDiB/1YNk535hPAkyizDe
         ip0mGtvWhRoJC5T/zvzcTzY1kyjoKjaHyKdivzeOaWJDVSiYPxjpgY8iDgMQ/V9DKKLr
         +wjTD+2DddGOdHHwgIIDmAR+kgtEIct9A/jy1CQ/77h82BCA0FxrhM2cF+WMBg080ps1
         DnIio8fB4VQsabORMCs9bw1hSg8VtJICMcl5IWJ0IETNalTKEhGNH22sAYrMWyJsfzpk
         jTjQkq4Zu6Ls+3k3xwXbvr/k85aRWm5sUtfWGYqzuGShJ/M/ryCjRdXZ2xg//zITsiNZ
         vBGw==
X-Gm-Message-State: AOJu0YzK84Fr3+o3Aw4LPwgBU6Enur9Uc7f6XeW895Z1/zFpMinRQWB3
	16I6Hf6d0s2o4cT70419wn/M203u97c=
X-Google-Smtp-Source: AGHT+IF7AbNLjxUFzxlmmJkFS1TGoSuKsHAEyS5NXzjkRWr+cPGrwRzoBwCzOEFhnsCXeGF8yNuIyg==
X-Received: by 2002:a05:6820:16ab:b0:58d:9e35:aa01 with SMTP id bc43-20020a05682016ab00b0058d9e35aa01mr10322422oob.3.1701289584533;
        Wed, 29 Nov 2023 12:26:24 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-6755-34f8-2ed3-56ec.res6.spectrum.com. [2603:8081:1405:679b:6755:34f8:2ed3:56ec])
        by smtp.gmail.com with ESMTPSA id 126-20020a4a0684000000b0058ab906ae38sm2473867ooj.2.2023.11.29.12.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 12:26:24 -0800 (PST)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: jgg@nvidia.com,
	yanjun.zhu@linux.dev,
	linux-rdma@vger.kernel.org
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v3 0/7] RDMA/rxe: Make multicast work
Date: Wed, 29 Nov 2023 14:25:52 -0600
Message-Id: <20231129202558.31682-1-rpearsonhpe@gmail.com>
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
 drivers/infiniband/sw/rxe/rxe_mcast.c  | 519 +++++++++++--------------
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
 15 files changed, 298 insertions(+), 360 deletions(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_param.c

-- 
2.40.1


