Return-Path: <linux-rdma+bounces-7256-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA52BA200AC
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2025 23:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 355723A502C
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Jan 2025 22:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB671DBB13;
	Mon, 27 Jan 2025 22:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJ/ZTF8s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8911D9A50;
	Mon, 27 Jan 2025 22:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738017538; cv=none; b=VQMfZUnXpn5mnZzk3gu0CwqchCJJymTDvpB3EbqLWDXoD03Khes95REzuqzERxrYPrVML5ajHqJdJZDF4ygJsvX2Z59Fj+9lm1M7gwdFXmdKizv7txaWbIuR0OsEA/HZPWsJij1/5V/7JnqrvI51h6XEE+48dcEDyL1hv6FR6VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738017538; c=relaxed/simple;
	bh=o4niIlLTPWIhz/KZH60NrGSI/SQAzdT1aRV1xa3huOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PyR2jupz3c3tBRdh+lelX+8PIN0XKcAidSP5Pe8CduhbOknd+/r/8ib1bnghrezoFNIQl+V7GSso+u0PKBRWK57iGozFZ1mtGTYzM2S+/pJ9LpjdqwASGI4NarH+oIEGUJ+AinLNOFTr0QQq7PRcGTeZnMt0tew7NlaXS03BEYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJ/ZTF8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AB3C4CED2;
	Mon, 27 Jan 2025 22:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738017538;
	bh=o4niIlLTPWIhz/KZH60NrGSI/SQAzdT1aRV1xa3huOs=;
	h=From:To:Cc:Subject:Date:From;
	b=lJ/ZTF8sbtVjqg1hkyhbvMWE+yC/EGMRDtuKjy0A+iw+aakXp08eDXK+ThumqRoTE
	 5bB5ERHePrJTpyXIoyA0VLmO0aqD9vaFgN3CTQQh71or3IAU1lz8j72VYs6Shs429C
	 4Z/Ppt28fBUFgW8Ej56O6vQa6SnNmUPt16aXhvV4v0c8D+jCmDJXgRXsG5VQ0a8hRN
	 FHjMYrJeom477X9AWylH1Wf+HLjFmA+fcwXgqUsTuYuu0v2krVNkslRYh3fM2jmsUQ
	 As5bVYrq7xTtahzGa5OwsYMwst2wqidRvR1UFO4mwE1+UoFNzfzYRmYU+1E94xePML
	 i2HUlXFxlmA7Q==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-rdma@vger.kernel.org,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] RDMA: switch to using CRC32 library functions
Date: Mon, 27 Jan 2025 14:38:34 -0800
Message-ID: <20250127223840.67280-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Starting in 6.14, the crc32() and crc32c() library functions are
directly optimized for each architecture (see
https://git.kernel.org/linus/37b33c68b00089a5), and there is no longer
any need to go through the crypto API.  Therefore uses of the "crc32"
and "crc32c" crypto_shash or crypto_ahash algorithms are being replaced
with straightforward calls to crc32() and crc32c() kernel-wide.  This
patchset does this conversion in drivers/infiniband/.

Compile-tested only.

Eric Biggers (6):
  RDMA/rxe: handle ICRC correctly on big endian systems
  RDMA/rxe: consolidate code for calculating ICRC of packets
  RDMA/rxe: switch to using the crc32 library
  RDMA/irdma: switch to using the crc32c library
  RDMA/siw: fix type of CRC field
  RDMA/siw: switch to using the crc32c library

 drivers/infiniband/hw/irdma/Kconfig   |   1 +
 drivers/infiniband/hw/irdma/main.h    |   1 -
 drivers/infiniband/hw/irdma/osdep.h   |   6 +-
 drivers/infiniband/hw/irdma/puda.c    |  19 ++---
 drivers/infiniband/hw/irdma/puda.h    |   5 +-
 drivers/infiniband/hw/irdma/utils.c   |  47 +----------
 drivers/infiniband/sw/rxe/Kconfig     |   3 +-
 drivers/infiniband/sw/rxe/rxe.c       |   3 -
 drivers/infiniband/sw/rxe/rxe.h       |   1 -
 drivers/infiniband/sw/rxe/rxe_icrc.c  | 114 +++++++-------------------
 drivers/infiniband/sw/rxe/rxe_loc.h   |   1 -
 drivers/infiniband/sw/rxe/rxe_req.c   |   1 -
 drivers/infiniband/sw/rxe/rxe_verbs.c |   4 -
 drivers/infiniband/sw/rxe/rxe_verbs.h |   1 -
 drivers/infiniband/sw/siw/Kconfig     |   4 +-
 drivers/infiniband/sw/siw/iwarp.h     |   2 +-
 drivers/infiniband/sw/siw/siw.h       |  46 ++++++++---
 drivers/infiniband/sw/siw/siw_main.c  |  22 +----
 drivers/infiniband/sw/siw/siw_qp.c    |  56 +++----------
 drivers/infiniband/sw/siw/siw_qp_rx.c |  42 +++++-----
 drivers/infiniband/sw/siw/siw_qp_tx.c |  47 +++++------
 drivers/infiniband/sw/siw/siw_verbs.c |   3 -
 22 files changed, 134 insertions(+), 295 deletions(-)


base-commit: 805ba04cb7ccfc7d72e834ebd796e043142156ba
-- 
2.48.1


