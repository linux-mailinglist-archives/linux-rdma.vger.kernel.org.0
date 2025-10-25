Return-Path: <linux-rdma+bounces-14046-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DDEC09B2A
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Oct 2025 18:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BB115640F3
	for <lists+linux-rdma@lfdr.de>; Sat, 25 Oct 2025 16:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8D231B805;
	Sat, 25 Oct 2025 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMV8anQu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3A6306498;
	Sat, 25 Oct 2025 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409621; cv=none; b=CYd8lFKPxxsSSE5+QmipVk7dgxacqHP+csTKOuVg4LvOvMUnnkKBCVNdQhSjEmHBkL7X/NfKTS3tOVOacfBnWrZrL3TVOlpVqwDfCJ4KDM+3Tf7/odKCAvopjfbUsiwxCl/s6gYgRKdzdcweBaznnE25pHQaFUweK4B/yyqdJEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409621; c=relaxed/simple;
	bh=EV4V0aToZ75vj9kD31WLFR0fiNf2p961IW8sUVl4/d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ijmst2t0rUbVGRdT9Gy3sZciGa1HnSA14CD8Un9WG3T/UGNoy3GmnNhC2H/iXnH6RfsoabCWyhmtEqJSISlqXDPeMTcPQMQ8hOMDg6yN7eN0uwE4hGx4jBME2iL2jn3D+gbZsm3ZpWsP7PKzcS5krGC1WNkh2K1XbE9RWM6r1C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMV8anQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F07C4CEFB;
	Sat, 25 Oct 2025 16:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409620;
	bh=EV4V0aToZ75vj9kD31WLFR0fiNf2p961IW8sUVl4/d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CMV8anQuNyFfPS/it7TZ8rApThqQ+jg7Dd6dkkln+kDwppdWJLIgQkUZcxyFLLu3J
	 yS//fLsMBqw4tOg0iS9QuNqVuWE+02q5tCMPmIt4Uin8TKxzurOoYj76QWnnnoNXlY
	 kn+tumOzPCNKtAyqJMgoNpQVgCzZNQGEhAXnq9iXU3MGykzGP6UV8ow+DXF2x27e57
	 Zd5XAZQbSUbLjXwRMYUAFymmsQDGF6IZ3b1xm7JLYj8BQffQyZHOXVgTbTHkjLrVIz
	 fKM/gebMKo29dlGPdOkPg4EmOg9G29Ky2heItcg//VncRpoZ746oPvkj3/n5pVNhKy
	 3wOVEJLgn1Ahw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jacob Moroni <jmoroni@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-5.15] RDMA/irdma: Update Kconfig
Date: Sat, 25 Oct 2025 12:00:28 -0400
Message-ID: <20251025160905.3857885-397-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tatyana Nikolova <tatyana.e.nikolova@intel.com>

[ Upstream commit 060842fed53f77a73824c9147f51dc6746c1267a ]

Update Kconfig to add dependency on idpf module and
add IPU E2000 to the list of supported devices.

Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Link: https://patch.msgid.link/20250827152545.2056-17-tatyana.e.nikolova@intel.com
Tested-by: Jacob Moroni <jmoroni@google.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES – the new dependency avoids a real build break that appears as soon
as the GEN3/IDPF support series lands while keeping risk negligible.

- `drivers/infiniband/hw/irdma/ig3rdma_if.c` calls several IDPF-exported
  helpers (`idpf_idc_rdma_vc_send_sync`, `idpf_idc_request_reset`,
  `idpf_idc_vport_dev_ctrl`) unconditionally at lines 25, 73, and 188
  (`drivers/infiniband/hw/irdma/ig3rdma_if.c:25`, `:73`, `:188`). If
  `CONFIG_INFINIBAND_IRDMA` is enabled without `CONFIG_IDPF`, modpost
  reports unresolved symbols and the build fails.
- The patch adds the missing `depends on IDPF` requirement to the
  Kconfig entry (`drivers/infiniband/hw/irdma/Kconfig:6`), so broken
  configurations are filtered out at menuconfig time instead of failing
  late in the build.
- The help text tweak (`drivers/infiniband/hw/irdma/Kconfig:10-11`) is
  purely informational and carries no risk.
- No functional behavior changes or architectural upheaval are involved;
  it is a small, self-contained dependency fix squarely in stable’s
  remit.

 drivers/infiniband/hw/irdma/Kconfig | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/Kconfig b/drivers/infiniband/hw/irdma/Kconfig
index 5f49a58590ed7..0bd7e3fca1fbb 100644
--- a/drivers/infiniband/hw/irdma/Kconfig
+++ b/drivers/infiniband/hw/irdma/Kconfig
@@ -4,10 +4,11 @@ config INFINIBAND_IRDMA
 	depends on INET
 	depends on IPV6 || !IPV6
 	depends on PCI
-	depends on ICE && I40E
+	depends on IDPF && ICE && I40E
 	select GENERIC_ALLOCATOR
 	select AUXILIARY_BUS
 	select CRC32
 	help
-	  This is an Intel(R) Ethernet Protocol Driver for RDMA driver
-	  that support E810 (iWARP/RoCE) and X722 (iWARP) network devices.
+	  This is an Intel(R) Ethernet Protocol Driver for RDMA that
+	  supports IPU E2000 (RoCEv2), E810 (iWARP/RoCEv2) and X722 (iWARP)
+	  network devices.
-- 
2.51.0


