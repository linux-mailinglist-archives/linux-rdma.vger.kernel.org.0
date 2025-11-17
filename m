Return-Path: <linux-rdma+bounces-14532-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB26C63FD0
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 13:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 989E035EB5A
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 12:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0664D32C94E;
	Mon, 17 Nov 2025 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="WU/L1iha"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED3B257854;
	Mon, 17 Nov 2025 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763381205; cv=none; b=qZhwz4xJcSCIR1Yl9A0lf/Kyk9RP/yxn5P45TzQYCe51xVVNaWvPUSerrwZXt+fTc1HjHmiGf+J15m1jFmcwgSmk0Hkp7wMEhxtxbm2SfA0UFIS+KyRf/t1/JNmye46YK4h8580KJa2nXejPmgfvlTHmfeLuO3T3klyDWBnNuMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763381205; c=relaxed/simple;
	bh=kuS8ZVbLhND5KJER3gHFfgdM5iFVTjjuNMrsyzs2Fds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VSrWH9UucOyihDVSnJojynGnJ4La2ARupUdG5V36ND8p0EgbbiKChez+PV8fnLnqm+m3hqzbVs9kINffzu99XQ2tQb5ZfhnS+mM/etr5NWZIEajEuZ6mEQlHU9yjIFf/HHt28fWrClcx0sg0Uknp66KwNlYizqHDvLrohvoqHmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=WU/L1iha; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1763381175;
	bh=fLshn+7E9KUs6vh0E2as97dyMJLrggNvwrM3GmPcWj4=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=WU/L1ihaVR6liOXRs6Px1n17hroYoJmFt7NLLkPiVqCFsQExVUK1d2kGyvupSj274
	 MTCShV9PVKxZCyKtXi1npFT91lTT7U8v+woy1v12z+q9x7lTwry+OmK2AqgqG47SsH
	 9zP3lhWIep0AOnhHQrQcbsHX1hrmw42Exbfw8Pxw=
X-QQ-mid: esmtpgz13t1763381166td1f29682
X-QQ-Originating-IP: TJq7fiIGP1hf079n+so4ykzadcdTWYUHAdKgrnbaCd0=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 17 Nov 2025 20:06:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11519860046904685920
EX-QQ-RecipientCnt: 9
From: Wentao Guan <guanwentao@uniontech.com>
To: leon@kernel.org
Cc: shiraz.saleem@intel.com,
	tatyana.e.nikolova@intel.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	niecheng1@uniontech.com,
	Wentao Guan <guanwentao@uniontech.com>,
	stable@vger.kernel.org
Subject: [PATCH] RDMA/irdma: fix Kconfig dependency
Date: Mon, 17 Nov 2025 20:05:51 +0800
Message-Id: <20251117120551.1672104-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NAvIe9bVixN3YxWpuNkd8u8xNvhBNTaGLq/t7tfpvjtz1vb8unT5Uyin
	VSfpBTqNSbX+ye0iXsLrPk8yZ0GaCE5pgjlZPtHogfomMxPolQDed9AA11dWnLxT7lcvH3s
	aXkXazkpyLHZ08Jdz5LChlnQ9bADhKdRRauTpg3cJFIdNTICzGaoZLmLy3E9zKJB0y7JDQw
	tU7dmJaOdqvlofo3YuUmUBjlGTmgmLjDe8b1DJm07m90+bAG3bCopi2025S79JlqUxBD6K9
	iJdDBLp/VPUoteuMcj8ZXtWVAh+l+g9RvvRZOKr9ELkEh/Gc0Lp7iR9H2ATjFn3UcJNcBC/
	WQM7/LklGZ/lDuWMxnLnm4WoWg1PDuYv15iCFOdtTgMFi1QGgrqhKPgNvgXJ8hl/2SftG9h
	lAvo/Gke3yN5vHC2eaGNT6XZWeugK7pguIRucixUcofxU5SiTqtUQATmrVsshjvGbHfosGa
	IvWXRmtH3z8kDTnKWS45bDzamUnN74d/y/eXpkKwRy1Rj2lsoK1plPL2kDb2Ef6k2m2Cs0D
	Zf9x/BnJyLcrPNaiSa2mccYJ8Feeo+///x8rh8Ou2IxgqKRHRinzMgra2Xw3YDNqGLUxPsl
	pxpgSgkw4R1xhpd1XrsaSb8VgMkF2W3G41mKCM6JldbCx+FyxTWqxqka1svv/NsUI2Eu5ve
	gm13owGExfSG8/ZQmmibr+94vSvXM3LvLSHFTsKnWOZXwXRvSuKQjOnLRoVTfj7cMbsuLR9
	u6zMg+Nu/1gkX3toJ1pzsIX08Py+7l1YwXecBd9DtRPqZA/cXvoqkrTHBUNDKManzGBtUL0
	D6relsxwmyDH/qWyZxIJFq4kkPsXrfNV32/Qg8yUao90qIro4QKLgX55lqg0ArjQnhX0415
	IMnRGOfbWBj7FzaikGSwJQZbuJT0j69oFmvxgrDIwjhBGlQKjEWkIWToORVxV27wRSbCur4
	QfiLB/Jtd17diq3KlOROqmBF53CtwV9jK1BLmU/xVvsUtcpbGlMFuLeqpjb6TuecVKtq4zi
	Rci1G/hiQAgb4bOS952IBDN+n5A70lsk3euFcky3LHTuG6lu1oQANKHEQhq3UgaWJ+TLVyW
	uIZQixONexr
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Any combination of (IDPF || ICE || I40E) can register auxiliary_dev,
so use '||' instead of '&&' in IRDMA config.

Cc: stable@vger.kernel.org
Fixes: 060842fed53f ("RDMA/irdma: Update Kconfig")
Fixes: fa0cf568fd76 ("RDMA/irdma: Add irdma Kconfig/Makefile and remove i40iw")
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>

---
PS: found in stable v6.12.58, it makes IRDMA be removed when select ICE+I40E+(!IDPF).
---
---
 drivers/infiniband/hw/irdma/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/Kconfig b/drivers/infiniband/hw/irdma/Kconfig
index 0bd7e3fca1fbb..83a55b23c1325 100644
--- a/drivers/infiniband/hw/irdma/Kconfig
+++ b/drivers/infiniband/hw/irdma/Kconfig
@@ -4,7 +4,7 @@ config INFINIBAND_IRDMA
 	depends on INET
 	depends on IPV6 || !IPV6
 	depends on PCI
-	depends on IDPF && ICE && I40E
+	depends on IDPF || ICE || I40E
 	select GENERIC_ALLOCATOR
 	select AUXILIARY_BUS
 	select CRC32

base-commit: 9b9e43704d2b05514aeeaea36311addba2c72408
-- 
2.20.1


