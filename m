Return-Path: <linux-rdma+bounces-14058-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D0BC0CADA
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 10:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E15FD4F20D4
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 09:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01132F0689;
	Mon, 27 Oct 2025 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdvVfgXY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A006A2652BD;
	Mon, 27 Oct 2025 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761557650; cv=none; b=a3cgpkX+dSQuId8aRLZUoZPGjCVnI9uTN6ARQfifZvj5AJ6UEM0fVxUf7Lok/NxJs2rGLonVDwLodvoSbFAs4tpE22RI30qpH1OOJM/edAVQNfIqbmRmq3nC9ykUO2ItOo+PqSS06bmpXftWK58Qv1U0lIHOf/R1VBgNWKOf4ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761557650; c=relaxed/simple;
	bh=6XkTlKpjvq7IawQ+0bCGl/BetTBZ7NlEyKu1Fl+CgP0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZUXUCP5lXadMhQ+dAGmZvLSvD2+6CH0EXMAbgmcY6Rf5FlEjGV8vUMCrSdlkVTXuqOp4zZJbaXq57HN3meLtWxv07miI/i5zFxyisqM4nu/+wz3wa2oIp0qq1oclbCbdBTM0+sC5nyRxwQAf/D2RfFE6p0aFkR/Fk/v/O0NeIrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdvVfgXY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86490C4CEF1;
	Mon, 27 Oct 2025 09:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761557650;
	bh=6XkTlKpjvq7IawQ+0bCGl/BetTBZ7NlEyKu1Fl+CgP0=;
	h=From:To:Cc:Subject:Date:From;
	b=hdvVfgXYErfi2ktvCDcZV339zsYT6JN6M54V8Mxhc85nGDlwet6GgNThIs/+q8o22
	 /d3D0dwzKfHc85Ifa+90gPStikrQJsv/uoA94YpiHwi+hDiV7iDzC+gF/tS796Gfgz
	 Jd0uc9CxfYnpTL6vKinppofdvawDNrWqy2xPeh2Dn6voxKbySBtPblU+WfUSRBEmes
	 uC5A2lKSlWRgUoH7F67RFhyNtetPPcdqy9je/brQbFz0HeezpdtX7DPz56IS0XShqw
	 MkqxqqxvtAzWyARZ7jC/FI4AWP1LD0naH4ohjcJqCzvzvHM4GAKW4t0Sh0FCib9Ael
	 gW0XzJnV9N2nQ==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Yishai Hadas <yishaih@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>
Subject: [PATCH mlx5-next 0/2] Add support for direct steering tag mode for RDMA mlx5_ib driver
Date: Mon, 27 Oct 2025 11:34:00 +0200
Message-ID: <20251027-st-direct-mode-v1-0-e0ad953866b6@nvidia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251027-st-direct-mode-8d7d874a7d36
X-Mailer: b4 0.15-dev
Content-Transfer-Encoding: 8bit

From Yishai:

Add support for direct steering mode where ST table location equals
PCI_TPH_LOC_NONE.

In that case, no steering table exists, the steering tag itself will be
used directly by the SW, FW, HW from the mkey.

In that mode of work, the driver is not limited any more to the 64 max
entries of the capability config space table.

The first patch in the series exposes the pcie_tph_get_st_table_loc()
API to let drivers detect the ST table location.

The second patch uses the direct mode in case the location equals
PCI_TPH_LOC_NONE.

This enables RDMA users working in that direct mode.

Thanks

---
Yishai Hadas (2):
      PCI/TPH: Expose pcie_tph_get_st_table_loc()
      net/mlx5: Add direct ST mode support for RDMA

 drivers/net/ethernet/mellanox/mlx5/core/lib/st.c | 29 ++++++++++++++++++++----
 drivers/pci/tph.c                                |  7 +++---
 include/linux/pci-tph.h                          |  1 +
 3 files changed, 30 insertions(+), 7 deletions(-)
---
base-commit: eea31f21dce10814e34dc7ef7ed5136269c7bb59
change-id: 20251027-st-direct-mode-8d7d874a7d36

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>


