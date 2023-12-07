Return-Path: <linux-rdma+bounces-317-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F5680914D
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 20:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70E6E1C20AEF
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Dec 2023 19:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741CD4F882;
	Thu,  7 Dec 2023 19:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UDzJtx4S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381BC170F;
	Thu,  7 Dec 2023 11:30:16 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3b9e1a3e3f0so497589b6e.1;
        Thu, 07 Dec 2023 11:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701977415; x=1702582215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NmLNXSh/X4Dd8jwq3Us6MATONjhNzvGvJ4m5T859Vwo=;
        b=UDzJtx4SQeu8f3UplNlv2DAe79wyQrfEiqpDRFie6IPxVU7JFXnEL0Txv1HKlzqJqa
         MkOxMXbh98u2NeaiMo1+IPfKIG1ROZfLjitWruxLh5UC9L6OVpbEdNFsZoK54vig4f1E
         /YS+3dZz0NDxrnfZoHJzN+20ZfEod7rfA2MENYnbnaPtjTRRd6vrNGy8BZPu7zh1TKo9
         wPksKJZKrvNhcGRyf5HlwixHzV9X6TQV13cvLBAQA6InqfJZB0fOHHg41VKexIkgX0Ba
         GX74CjSThT4iDmJNKbhJSHAMksa4Llp5fN2jMWLP3WercKC/tQcq/BY+nAQFAufsK3xi
         EVTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701977415; x=1702582215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NmLNXSh/X4Dd8jwq3Us6MATONjhNzvGvJ4m5T859Vwo=;
        b=AHIL624QG1qlEbHRPWx4UlhG31Q7m+CMcXhmLT4nsgS+zDp6QLp7dLOfyjyBsBVRVW
         94bz/55XRqfj45T2LSQBt5x0esSJcS4iQWti3hlZZIjPuqdigF+dfrEV5YqNHvKodgkP
         k6Rk/rzo4haW80y5JfGv0p2HUeJtDN/3cywU1a00rqEmHrGKdAjdPueivKId2waV1TW8
         nPikfJEXykmRi++8W0ufbdk0y5kr/sTNCpwRvoiLseuyhAx18dEyC8NfEsfwTti1aGIJ
         QDkQRlHbszg55cm/k9XvSrSNHab3F7PuUGgEAIg5RI8z2q4cpur0mLYmQ2/vGypEcvM/
         zzrw==
X-Gm-Message-State: AOJu0YzdrLMX162EHEhx6yoje7SqlSbaUjefXmF6auOxUr5HMea0Tp/r
	3PgOH6dKtsfnwtqe0qnvak8=
X-Google-Smtp-Source: AGHT+IHBik1146XkrbSQxLDmzHRatUdDYr2p9mCUyflpcwh8bpqRI2APlpTfxKAhfM3lVknsV7b0VA==
X-Received: by 2002:a05:6870:1b83:b0:1fb:4a6:31dd with SMTP id hm3-20020a0568701b8300b001fb04a631ddmr3958907oab.42.1701977415350;
        Thu, 07 Dec 2023 11:30:15 -0800 (PST)
Received: from bob-3900x.lan (2603-8081-1405-679b-ca1f-53fd-59c8-8b84.res6.spectrum.com. [2603:8081:1405:679b:ca1f:53fd:59c8:8b84])
        by smtp.gmail.com with ESMTPSA id mp23-20020a056871329700b001fb634b546dsm92347oac.14.2023.12.07.11.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 11:30:14 -0800 (PST)
From: Bob Pearson <rpearsonhpe@gmail.com>
To: jgg@nvidia.com,
	yanjun.zhu@linux.dev,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	dsahern@kernel.org,
	rain.1986.08.12@gmail.com
Cc: Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH for-next v6 0/7] RDMA/rxe: Make multicast work
Date: Thu,  7 Dec 2023 13:29:01 -0600
Message-Id: <20231207192907.10113-1-rpearsonhpe@gmail.com>
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

Copied to the netdev list. Please review patch 3/7 which interfaces
with the netdev stack to create the IP mcast endpoints that
support the RDMA mcast endpoints.
---
v6:
  Replace spin_(un)lock_bh(&sk->sk_lock.slock) by lock(release)_sock(sk)
  to address comment by Rain River.
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


