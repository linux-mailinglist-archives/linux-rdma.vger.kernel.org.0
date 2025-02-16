Return-Path: <linux-rdma+bounces-7784-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F323BA37909
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Feb 2025 00:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C8616BE29
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Feb 2025 23:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8ECD1A5BB3;
	Sun, 16 Feb 2025 23:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="EJuDjHHr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9B642070;
	Sun, 16 Feb 2025 23:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739750183; cv=none; b=b9W28LZvGxYtBIZEpGdI2Cqv8jrx4dX7OlnffvMTx1sBPzZv8uvMDQ57DR/gYHL8GBcFq6FrBV2mOHBDZLeMLeI3Hcwr22t7+jrdJor6a5RF9peg9aCCgzI/f1YmJIJ2v2mAAdaBXWo+ETrf+JXmgqj+TR0KKvweHRs7MDub5bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739750183; c=relaxed/simple;
	bh=V++XAGw5e8HCPJB0+vZcIEAUsfypgMEYSAKLxet2gy8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=VdTV2enGQXTMMxVhqwXqP393XNBVI5aQnbhOrnidIJXOf1HkUuQUjBDxt0uIvGKZG5paAgy05UzvEX4xp+aEWldxNtcGpqi3S4w1ziJ5o444jqZ++SC6fuRq7LDudLaCjLHJhgj1ycD/vphR0CWkUhRh1cevbo5LqvGmGzgn3BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=EJuDjHHr; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1739750173; x=1740009373;
	bh=CK1h/qqIm1MrCSBdeD49fjjpclhLOf7AL7ArRk6/1ZE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=EJuDjHHrCRZOb1YG6XaJ1DCSAICru+Qdq+VUTbDTcfJG1xA81F1AGe1CTLR5kWdpF
	 H4AwJgT+mnau0swCdktLzdCGur7MxNv6e8op0W9+Tz7hmFii3PsQVEfYdJRYwBHbpt
	 ts2iQB+NJP167IflKbMX3f02pB8ydY7rqM1D6cdCyUzOXcvMwzkxUgFckhHW618Ptz
	 V+cFHSYSlUH7VyEP4rqj2IGuPGtbqEV3FXnBLF5GVosQo+O58O0RxQZN4SImrqbxmx
	 rN3k5pGofqfmltM6ir5fO2N6pPoqCPs9YQ7y6FvlkQ1rWGEgtqAi0PBfAV4yDA6Aqt
	 swyBMO7IAj54Q==
Date: Sun, 16 Feb 2025 23:56:08 +0000
To: shuah@kernel.org, sagi@grimberg.me, mgurtovoy@nvidia.com, jgg@ziepe.ca, leon@kernel.org
From: Imanol <imvalient@protonmail.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org, Imanol <imvalient@protonmail.com>
Subject: [PATCH] infiniband: iscsi_iser: fix typos in comments
Message-ID: <20250216235602.177904-1-imvalient@protonmail.com>
Feedback-ID: 28866602:user:proton
X-Pm-Message-ID: 368e9c71ecc7a789a8e3dda4a49455dbaf7b6414
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



