Return-Path: <linux-rdma+bounces-9394-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 625C3A87A4D
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 10:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D47A3B1D9F
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Apr 2025 08:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E9C25F961;
	Mon, 14 Apr 2025 08:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CwLQ96es";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="stqjzGM4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCE925D548;
	Mon, 14 Apr 2025 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744619180; cv=none; b=AquHuR+Ch+TbuesYm0tJJOb7sFOBImUGFwALpQdjNlfb6K035sYIGp3bbMLYnxBfrTZhae/0cKzehuHQVv5wLQQFv8Pqgos9BeCTcWH46NDx1prDxNBGcRhsg/3S3VnkimbIbT/bQaoGx09SPQh/6e5ywx0olG2nuaW7kUFLuVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744619180; c=relaxed/simple;
	bh=DUG1+lN4hYWTRXUIHu9/uXnn+NTpymOB/TnWz/zGsdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kJm99oAoqCvvo7Z1fovHh09kBihNxWccAUYvi1py6RnfMHvowcuMNdzFsJnczot46KRCG9HdGqXhNMnD5miLj80LiYtYQIM3KUCLrFH3mWZWK64dHYe6FEfsjXQlyGtCpspPIBPA5dnf9A5IF86ghwgr6uyrA9zo+WEjMG6GFmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CwLQ96es; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=stqjzGM4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744619176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/ObABjOV6tmamGjv9L2Q13+VEF7f80WjKn+a2KmsZU=;
	b=CwLQ96esYh4P4KVCJatZ8Hs44GlzB55o2RFDlB2NnoKBpBTwtnnttXtq6VROizK0QMlx2I
	fdJ7j4gqaLBCoqlkfZ1RXGFlNyiBmJWKENL3vw8Uczt17RPRBi5rxA4Gava5iUDAFYvikp
	QE5M9Z54sDWEXNx5tdtopJ9DVVmmtcwowrh/m0D/S2+B66LoJJ3a6+WPDaej08VijYy+gj
	pOup6JcF7y5Pcc3mwYSDOXBypIIu4AFPIaunhtcjzU8or4EWnQYp44LtnOrIkU7bntJpWC
	NctE2AcFsSHEFFVm1SrRM5+S1R3TygES0fgt3lu+ss6ppElalDk8lhMyfXz0Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744619176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C/ObABjOV6tmamGjv9L2Q13+VEF7f80WjKn+a2KmsZU=;
	b=stqjzGM4ft7DElxC/qKesdImygtnGtJLw7FA4P6YSG5XAK7GUU0TpDDd0NwKpK+oBLbwLL
	p8/cYaEmZo1280CA==
Date: Mon, 14 Apr 2025 10:26:06 +0200
Subject: [PATCH net-next 5/7] wifi: mwifiex: Don't use %pK through printk
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250414-restricted-pointers-net-v1-5-12af0ce46cdd@linutronix.de>
References: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>
In-Reply-To: <20250414-restricted-pointers-net-v1-0-12af0ce46cdd@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744619172; l=1442;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=DUG1+lN4hYWTRXUIHu9/uXnn+NTpymOB/TnWz/zGsdo=;
 b=4Oqz6NIxNX2Dv35WuWlxsIW56xiHSeN4apRT/2S8GealXzW3EYzYF9P9h2Mhnx6cG1SWclSLx
 d+XUSmGw7EEAI1exWfEp1WbMYoqGspvBdqwaN+gAowvrX+qdbEJLvEv
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
 drivers/net/wireless/marvell/mwifiex/pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index dd2a42e732f2398892915e1a3ac88b7d3fb4ed3f..a760de191fce7340040b1bc74efb35cf52ce8368 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -2971,7 +2971,7 @@ static int mwifiex_init_pcie(struct mwifiex_adapter *adapter)
 		goto err_iomap2;
 	}
 
-	pr_notice("PCI memory map Virt0: %pK PCI memory map Virt2: %pK\n",
+	pr_notice("PCI memory map Virt0: %p PCI memory map Virt2: %p\n",
 		  card->pci_mmap, card->pci_mmap1);
 
 	ret = mwifiex_pcie_alloc_buffers(adapter);

-- 
2.49.0


