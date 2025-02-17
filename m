Return-Path: <linux-rdma+bounces-7796-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEEDA38B4A
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 19:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74599188EF96
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 18:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ED1717CA17;
	Mon, 17 Feb 2025 18:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="OCT3O/mf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85EAA55
	for <linux-rdma@vger.kernel.org>; Mon, 17 Feb 2025 18:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739817063; cv=none; b=pQism26qgXXmL/ovdbw96N0sGWKbkuHR6J9j0o62s/ulYqSluKS1CFSnOU0fn2M7yJxJe7z2XMi1RAzb9ZjXziB6vUYg7XEjCYy44AxdUHHOQslEvZ5w/tb5T1SgbZHVhtslPEDU7VKJk9YHGtb1IOB6JknFPCBK1x+fS1EP/JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739817063; c=relaxed/simple;
	bh=V++XAGw5e8HCPJB0+vZcIEAUsfypgMEYSAKLxet2gy8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lYDikrrhzlbcb6N5z8TMpopg2dSw+Wj7i0zlwUzwa79lUR9zPSMuJsLiiR2Z7zdnGKYKF2i/1clJKtI5T4eIPy5+hOH3oOcvzOrQcmuToejz4kJ8K8UPS+UYbXOQ0xI5MbuG/WnIIRFjyHA1p/28zuC43JANg2sz+rNxmA9n+oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=OCT3O/mf; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1739817059; x=1740076259;
	bh=CK1h/qqIm1MrCSBdeD49fjjpclhLOf7AL7ArRk6/1ZE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=OCT3O/mfNa0NAnGVsbvk3nYhei8o82SvJoijg3k0PdL34QgdJAsl4yrhyQHGMsUaf
	 HS87EepbSwhi8YX10E8tw46u2uFOoWhxG/DPlgFPn5D4W+EIDJWStp5ZFYPdrlSwpR
	 UriQs2F2yB0DU04ky/GGkDPe54uSfHxkbSHwG4OHHxc4/ujJ0PJvpvc2eDyQtZXTKw
	 L2mbicNPhbUTDkJumTQ+FICnZyChbHF0R6grCW9PgbShPNazmolbMhcLrVVXvbdUi9
	 TXiyMhKv0Cx8jHBIKDIMgEhrDSe0Z1Nw5S+YvriECrj0SpyK6Dmt3L1/37WB3cTqUz
	 APxhnCjwHEzdg==
Date: Mon, 17 Feb 2025 18:30:54 +0000
To: shuah@kernel.org, sagi@grimberg.me, mgurtovoy@nvidia.com, jgg@ziepe.ca, leon@kernel.org
From: Imanol <imvalient@protonmail.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Imanol <imvalient@protonmail.com>
Subject: [PATCH v2 v2] IB/iser: fix typos in iscsi_iser.c comments
Message-ID: <20250217183048.9394-1-imvalient@protonmail.com>
Feedback-ID: 28866602:user:proton
X-Pm-Message-ID: 63d439b2a8976457afce05453090ac379a39daf0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Fixes multiple occurrences of the misspelled word "occured" in the comments
of `iscsi_iser.c`, replacing them with the correct spelling "occurred".

This improves readability without affecting functionality.

Signed-off-by: Imanol <imvalient@protonmail.com>
---
 drivers/infiniband/ulp/iser/iscsi_iser.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/=
ulp/iser/iscsi_iser.c
index bb9aaff92ca3..a5be6f1ba12b 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -393,10 +393,10 @@ static void iscsi_iser_cleanup_task(struct iscsi_task=
 *task)
  * @task:     iscsi task
  * @sector:   error sector if exsists (output)
  *
- * Return: zero if no data-integrity errors have occured
- *         0x1: data-integrity error occured in the guard-block
- *         0x2: data-integrity error occured in the reference tag
- *         0x3: data-integrity error occured in the application tag
+ * Return: zero if no data-integrity errors have occurred
+ *         0x1: data-integrity error occurred in the guard-block
+ *         0x2: data-integrity error occurred in the reference tag
+ *         0x3: data-integrity error occurred in the application tag
  *
  *         In addition the error sector is marked.
  */
--=20
2.43.0



