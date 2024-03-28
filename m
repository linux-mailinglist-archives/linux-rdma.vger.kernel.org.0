Return-Path: <linux-rdma+bounces-1633-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADC18901BE
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Mar 2024 15:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE84A1F25057
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Mar 2024 14:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756951272CA;
	Thu, 28 Mar 2024 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWM+Qp30"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F081879;
	Thu, 28 Mar 2024 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636265; cv=none; b=TsaSuZaa+mOPb4gMTrYw6L6GZvvkXyWSJl1F6oLiN/d9cyei/sqjeLivDoKuLEArbftgkr8kn/4RC8rMN9pSq8Gslumnb5ALq7gqV9IAkh6ac+f9ubVSGA5egeD7c36qrt3LE6ob/nVFyIDbCG9PrsXhJb8Ue7u7TlApyLr1VNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636265; c=relaxed/simple;
	bh=zN2hzijZlAwA7dSIUuqXqTXuAGGw3rihlUXROhzown4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XSfHzXv59ixjGGMOCuKiEcRfQH5Wz0iPodm6syal3cKs1ibOcBB8VQ6aE2+tAAVPsfPQQBTyRyb/qoda2KTCVttB0xw3cB816Y4UGNxWeP4Km2wwe+2WJvcSsEZOcPsQad/YfFPQWfacVFhDbYmSmLNrUyj97Cy6uzU917PbO2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWM+Qp30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7141C433C7;
	Thu, 28 Mar 2024 14:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711636264;
	bh=zN2hzijZlAwA7dSIUuqXqTXuAGGw3rihlUXROhzown4=;
	h=From:To:Cc:Subject:Date:From;
	b=eWM+Qp30VXj9Cmh0LnGCxoeRKFCdiRG/+7cYiw3/d1A2+4+cFEwZTeR0JCmdB7dCq
	 BJ9rIQbF9IBEI+soObC424HP7laoiCA3/oi1O9qP9rBITnPfxuSYeV5KRvg9hYcRab
	 e/dCX3l7xvE+Crt9nLuvyn+RK8JuQn+i+0gl/X6RqKrS31M7lA4cVVAcZLH+2tD70I
	 3HfxG2oBSEgx+79CZh8PlNRuEJmIOG2T+nm5DpqItFA2gaY6b7ltr3jg7UjRUmiCnX
	 fBIiKt6tGKRHDPmTgbO18UpcTP5WlsP5+HLng5MSKm27q042WFMvRohaMfXHDUBt2+
	 CV0uOkwqjgK7A==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Ilya Dryomov <idryomov@gmail.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	dm-devel@lists.linux.dev,
	Saeed Mahameed <saeedm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xiubo Li <xiubli@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	ceph-devel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-nilfs@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-kbuild@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH 0/9] address remaining -Wtautological-constant-out-of-range-compare
Date: Thu, 28 Mar 2024 15:30:38 +0100
Message-Id: <20240328143051.1069575-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The warning option was introduced a few years ago but left disabled
by default. All of the actual bugs that this has found have been
fixed in the meantime, and this series should address the remaining
false-positives, as tested on arm/arm64/x86 randconfigs as well as
allmodconfig builds for all architectures supported by clang.

Please apply the patches individually to subsystem maintainer trees.

      Arnd

Arnd Bergmann (9):
  dm integrity: fix out-of-range warning
  libceph: avoid clang out-of-range warning
  rbd: avoid out-of-range warning
  kcov: avoid clang out-of-range warning
  ipv4: tcp_output: avoid warning about NET_ADD_STATS
  nilfs2: fix out-of-range warning
  infiniband: uverbs: avoid out-of-range warnings
  mlx5: stop warning for 64KB pages
  kbuild: enable tautological-constant-out-of-range-compare

 drivers/block/rbd.c                                    | 2 +-
 drivers/infiniband/core/uverbs_ioctl.c                 | 4 ++--
 drivers/md/dm-integrity.c                              | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c | 6 ++++--
 fs/ceph/snap.c                                         | 2 +-
 fs/nilfs2/ioctl.c                                      | 2 +-
 kernel/kcov.c                                          | 3 ++-
 net/ceph/osdmap.c                                      | 4 ++--
 net/ipv4/tcp_output.c                                  | 2 +-
 scripts/Makefile.extrawarn                             | 1 -
 10 files changed, 15 insertions(+), 13 deletions(-)

-- 
2.39.2

Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: Dongsheng Yang <dongsheng.yang@easystack.cn>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>
Cc: dm-devel@lists.linux.dev
Cc: Saeed Mahameed <saeedm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: David Ahern <dsahern@kernel.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: Nicolas Schier <nicolas@fjasle.eu>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Tariq Toukan <tariqt@nvidia.com>
Cc: ceph-devel@vger.kernel.org
Cc: linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-rdma@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: linux-nilfs@vger.kernel.org
Cc: kasan-dev@googlegroups.com
Cc: linux-kbuild@vger.kernel.org
Cc: llvm@lists.linux.dev


