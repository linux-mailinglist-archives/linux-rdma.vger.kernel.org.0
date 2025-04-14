Return-Path: <linux-rdma+bounces-9390-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46552A87A3B
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 10:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 412BF16A7B0
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 08:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDFC25A2CD;
	Mon, 14 Apr 2025 08:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yk3WhpFd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZUTVDh8T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41FB259483;
	Mon, 14 Apr 2025 08:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744619177; cv=none; b=DAy793dZJnzqh6z49GAapcOfLHhsKONeF24MT6yhr/wFIWXLDJjsY5DzFMJE9cZrOQB8PP1USbkeatOaz4uiZP1QJcMuw09QRjHMOLyPoGQthMgxHIvcG8N4TwfZAgAncMN2s2eKEekfCVTC06bJo0pF75vtW+bIBDYx6MPEZFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744619177; c=relaxed/simple;
	bh=BORzOQMujEQoEZ1/2bV+p8+YHtYSGgUIbSUnDvITbw0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WidLv1cwML2VrCvPBWEqMHoDmJ5lFbfjxba0M0JC3aE/9XjwRIWmZ3qE6poxVioKaU7A//9hbjPqcZX5zV1f9dc6eaBYv8zzwVsZzNy2IN/2cHsEkneqAZAQyEH7CU/xY6rZXhP3zq9PXafrICmp6pNDI04l2U4WEVVNDh0vop8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yk3WhpFd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZUTVDh8T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744619173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jrc9Yy1PzgCFjX+NHqHe/gPvbxLEMwfRYZpvhZ/FS0A=;
	b=yk3WhpFdZmssQZ72lhB1qTZyyfyRxUMGb509WQ1XvYBshseihS05xwBznxHhRaTSuvl2/r
	EV94ezp88ycSGWp7iOyTpqrj5t+3wGtxAiaM9vEX47RmKk5P48wS0XMSxxBOdg/4jJqAHD
	iHBl8abWHKqitQ+lC99k0cGXVhaRkjhGljSMANJ78YhV8KbI3RqgpbXkvKd92G5a9GW2nS
	tIBmRwss1Fuv6LjD9Y7xqZj8VGTlEtB6qHwYn6Tlye1uu66CfvxVl6aULoNDAziN+j01pg
	XkPcQInqq/spXCdJv9D13D3LtBdTdeebkK0YlMI2cFrQF3INyTTmpgSTQMASeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744619173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jrc9Yy1PzgCFjX+NHqHe/gPvbxLEMwfRYZpvhZ/FS0A=;
	b=ZUTVDh8TwrC2G20/dfmdoIzBLROL3SA9B70xNJai5NOfSK/ZlnlfAJyXQYz/eR/yLSEC1D
	jaRVzn4m4tTolrBQ==
Subject: [PATCH net-next 0/7] net: Don't use %pK through printk
Date: Mon, 14 Apr 2025 10:26:01 +0200
Message-Id: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJnG/GcC/x2MQQqDUAwFryJZN/C1CqVXKV3Iz2ubTZQkFEG8u
 79dDszMTgFXBN27nRxfDV2sQX/pqH5me4NVGtNQhqmMZWRHpGtNCK+LWsKDDcnzrYpIuWKSnlq
 9Ol66/c8P+gmGLel5HCeLK549cwAAAA==
X-Change-ID: 20250404-restricted-pointers-net-a8cddd03e5d1
To: Jeff Johnson <jjohnson@kernel.org>, 
 Loic Poulain <loic.poulain@linaro.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>
Cc: ath10k@lists.infradead.org, linux-kernel@vger.kernel.org, 
 ath11k@lists.infradead.org, ath12k@lists.infradead.org, 
 wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-rdma@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744619172; l=2519;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=BORzOQMujEQoEZ1/2bV+p8+YHtYSGgUIbSUnDvITbw0=;
 b=nygQqQzI+POOkmd4HUPMbkxcLkdDeVe3FLi1mMvmt2xMpHokr9kq0+dmMGqAVzLbgbGctLw7P
 7VQYQJVB0MyCdd69OEvNE7wWyCtsM12NiJoSol6jf5d2f/1FWxdOYwI
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

In the past %pK was preferable to %p as it would not leak raw pointer
values into the kernel log.
Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
the regular %p has been improved to avoid this issue.
Furthermore, restricted pointers ("%pK") were never meant to be used
through printk(). They can still unintentionally leak raw pointers or
acquire sleeping looks in atomic contexts.

Switch to the regular pointer formatting which is safer and
easier to reason about.
There are still a few users of %pK left, but these use it through seq_file,
for which its usage is safe.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Thomas Weißschuh (7):
      wifi: ath10k: Don't use %pK through printk
      wifi: ath11k: Don't use %pK through printk
      wifi: ath12k: Don't use %pK through printk
      wifi: wcn36xx: Don't use %pK through printk
      wifi: mwifiex: Don't use %pK through printk
      ice: Don't use %pK through printk or tracepoints
      net/mlx5: Don't use %pK through tracepoints

 drivers/net/ethernet/intel/ice/ice_main.c          |  2 +-
 drivers/net/ethernet/intel/ice/ice_trace.h         | 10 +++++-----
 .../mlx5/core/sf/dev/diag/dev_tracepoint.h         |  2 +-
 drivers/net/wireless/ath/ath10k/ahb.c              |  2 +-
 drivers/net/wireless/ath/ath10k/bmi.c              |  6 +++---
 drivers/net/wireless/ath/ath10k/ce.c               |  4 ++--
 drivers/net/wireless/ath/ath10k/core.c             |  4 ++--
 drivers/net/wireless/ath/ath10k/htc.c              |  6 +++---
 drivers/net/wireless/ath/ath10k/htt_rx.c           |  2 +-
 drivers/net/wireless/ath/ath10k/mac.c              | 22 +++++++++++-----------
 drivers/net/wireless/ath/ath10k/pci.c              |  2 +-
 drivers/net/wireless/ath/ath10k/testmode.c         |  4 ++--
 drivers/net/wireless/ath/ath10k/txrx.c             |  2 +-
 drivers/net/wireless/ath/ath10k/usb.c              |  4 ++--
 drivers/net/wireless/ath/ath10k/wmi.c              |  4 ++--
 drivers/net/wireless/ath/ath11k/testmode.c         |  2 +-
 drivers/net/wireless/ath/ath12k/testmode.c         |  4 ++--
 drivers/net/wireless/ath/wcn36xx/testmode.c        |  2 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c        |  2 +-
 19 files changed, 43 insertions(+), 43 deletions(-)
---
base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
change-id: 20250404-restricted-pointers-net-a8cddd03e5d1

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


