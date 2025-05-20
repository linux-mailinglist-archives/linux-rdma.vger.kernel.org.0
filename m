Return-Path: <linux-rdma+bounces-10453-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D93CFABE4D8
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 22:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85A554C55EB
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 20:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663FD28D822;
	Tue, 20 May 2025 20:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHHXNCA3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C66A2836B9;
	Tue, 20 May 2025 20:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747773380; cv=none; b=Oiqf+CF7DjOT8ALiRuwtNNRHd8mR83pK4i5umtEur5G1TdkOGhzjMmsAjavXBmIJflXo2rhzExTgtX4M1GNSsJKjpPhWsDSuUyhfAJF31v058yY3QVhelm+5/2X8JRl70EEfwKLPEIaEED1znmsYsLvAmRvszFBSX0PXau8NpZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747773380; c=relaxed/simple;
	bh=c+60ySRjsXrVkD8gJAxp8y79aaSVQQ0i4yoi/ZnJ8ys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OV0M7tfqSxWv2n/oJEjJ1DY5rUMtr4NqTeEranynxyZMBd2Wrbtaam3GB/1jKYGKvJWO/GU+YTpu8narWJuSM3YHn6AiZwTvvneMP6L1yFjmtOBMeU1FoFr73t/kGiWoMBOxx8yBCE1ejjFKsHvoS9jC63ifwr13VuHJKe0Vg78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHHXNCA3; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b26df8f44e6so5849278a12.2;
        Tue, 20 May 2025 13:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747773376; x=1748378176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LJxNgsOXkfEn8VvbztVnzgoVJ4MKZxw7zyI/QjMp2Ak=;
        b=gHHXNCA3UPFBCZ7kqRQXILIkBPJ89ee/VA4hxD4ONJ44GobR1VwMDVzLS9yKPMmsli
         +TH+ea2ptz616ztdS0Tj45XQXJNCizuA1QvdkRfjM+G12RkRaP4rQdlQvtRViFXJdG8L
         UBOBIyTbYcYQEtk9xQC2Vc9RZwS6/bCQqrt2bbn1O0ZuRMZpGCMhsdDy3d8HwRD6L1+f
         DzI9Bxxqcd7ReRbhzPh5gtECFarwJqpsb8wr+1DfcNLwv0A7ULJPFctBrrzT+CxT0C1P
         l8FsOHcfBWVSZoQ+vvBTUYvmLUH2TygOm4vmbKzUeuIRAyNxN8QtyXmnCn9Yi5N8CBAh
         Yudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747773376; x=1748378176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJxNgsOXkfEn8VvbztVnzgoVJ4MKZxw7zyI/QjMp2Ak=;
        b=wvFSiIH8TD9qmlbkMF0jZLueUuzIyNvqMRDN38XmN6zBWXwpdbRCBWyCcWVZ1dH2z8
         BU6qRXBg1o0q73sxt4jJVa3OQl+wNY3MXveoKVDAm7ISmHpB4/6nX0O2SD8/jnRl9MfD
         A8uAVbGBLoa6aKDJAxhbCZWSMQ40agzU5zZ+d1emADMIggU0DvZsOVTc6qQLAxlro8uj
         FjAzMetY0I6cEjbfbdgBZzRWL43k+PeHpqg56gII+y+pDGw2onp3mLen8suIZw8mhCu0
         ux6YMlevgdg9i0k2s3gPA0Xp/XdRGMwZ8l/nXMQon0TvPaWXieDIWeZ6MJNusfsPWwFL
         6aiw==
X-Forwarded-Encrypted: i=1; AJvYcCWTGzo5+fRfS9E2s/k0SNX9SBapL9ilelFkptLCQr4tj2NhO+j9njneqPlIBo3XSJtz5G55bgs8ogEiQu8=@vger.kernel.org, AJvYcCXrnYCQ+eMGr9Ygfrrza4fS/kguKm0GEvkhDtu1vDafvrBEr/tIXtvBjPzNYn2ydmcbu9JS2kZ42CBxnQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyW94Y6FEJnesBMgzhd4P6kidiawa3lQONFYdBJum7Mk7H88cRX
	Xs16lQwkyAiRw1tae5xuDtIt3KCltMkgkEwkuDy0KtbKiNgBq5qtrh1LM409
X-Gm-Gg: ASbGncvGrnMrE2rbUUlcNWLdRCNthiDWZc7YSOIzbZiBMrisMniVxSAJv1/hgAmzw/2
	Wc84vXhnYRggEetYKdH+5dnCu0bVm1i0nRDixe9s2ZrnMyNPlirqcCI1gNzx0aPCmamMwQDo0Ac
	JPZLtphbb8xz6UKWUTL3l8puzIsQDwEkNQ/jwtzFDkgbZfsDHlnz5KqGH6IQfOgQgP2xlr0FUlb
	ghppRL1mmoeqBZ/qPy0pXMBTk4XJAeWRi38+FGhCjyB26lVVCT9a9IQD4f93POrKHBxEjVpEBQ6
	K7c3sjfbsLdTRd6RFmOE6cixYlLZi9pqeL9gLpbHxrYFYjjdfgXBAKJhfXdZ8zd8ekWf0lTwJ4z
	1uh//8BPHwImM
X-Google-Smtp-Source: AGHT+IFMjXzxlLgDuz6liqwqBsE6c/B15yq/4Qcwe5vGmbvaEcoMyR5RQOp+vL18fNrzg3UHc/xoMw==
X-Received: by 2002:a17:902:e946:b0:22e:3e0e:5945 with SMTP id d9443c01a7336-231d4562130mr235286095ad.50.1747773376032;
        Tue, 20 May 2025 13:36:16 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-231d4adbf5esm80721645ad.64.2025.05.20.13.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 13:36:15 -0700 (PDT)
From: Stanislav Fomichev <stfomichev@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	skalluru@marvell.com,
	manishc@marvell.com,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	tariqt@nvidia.com,
	saeedm@nvidia.com,
	louis.peens@corigine.com,
	shshaikh@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	ecree.xilinx@gmail.com,
	horms@kernel.org,
	dsahern@kernel.org,
	ruanjinjie@huawei.com,
	mheib@redhat.com,
	stfomichev@gmail.com,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	oss-drivers@corigine.com,
	linux-net-drivers@amd.com,
	leon@kernel.org
Subject: [PATCH net-next 0/3] udp_tunnel: remove rtnl_lock dependency
Date: Tue, 20 May 2025 13:36:11 -0700
Message-ID: <20250520203614.2693870-1-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently bnxt had to grow back a bunch of rtnl dependencies because
of udp_tunnel's infra. Add separate (global) mutext to protect
udp_tunnel state.

Cc: Michael Chan <michael.chan@broadcom.com>

Stanislav Fomichev (3):
  net: ASSERT_RTNL remove netif_set_real_num_{rx,tx}_queues
  udp_tunnel: remove rtnl_lock dependency
  Revert "bnxt_en: bring back rtnl_lock() in the bnxt_open() path"

 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |  3 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 42 ++++---------------
 drivers/net/ethernet/emulex/benet/be_main.c   |  3 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  1 -
 drivers/net/ethernet/intel/ice/ice_main.c     |  1 -
 .../net/ethernet/mellanox/mlx4/en_netdev.c    |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  3 +-
 .../ethernet/netronome/nfp/nfp_net_common.c   |  3 +-
 .../net/ethernet/qlogic/qede/qede_filter.c    |  3 --
 .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  |  1 -
 drivers/net/ethernet/sfc/ef10.c               |  1 -
 drivers/net/netdevsim/netdevsim.h             |  1 -
 drivers/net/netdevsim/udp_tunnels.c           | 12 ------
 include/net/udp_tunnel.h                      |  9 ++--
 net/core/dev.c                                |  2 -
 net/ipv4/udp_tunnel_nic.c                     | 33 +++++++--------
 net/ipv4/udp_tunnel_stub.c                    |  2 +
 17 files changed, 34 insertions(+), 89 deletions(-)

-- 
2.49.0


