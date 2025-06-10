Return-Path: <linux-rdma+bounces-11132-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D01AD361D
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 14:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A2251898C50
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 12:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA4D291871;
	Tue, 10 Jun 2025 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="JClEyr7s"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1917C223300;
	Tue, 10 Jun 2025 12:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558371; cv=none; b=EndLwvg5OaqFHsy/9BDXYOrm9LMQFSYTpSAd80NdmZ0u9904Pup3bLCmbaKIHZdQvP8sZ/IZZpKsBcRaFYZXXfKOpXpxXfjL1DwL7o3160xnf1P8gNHbv+96CmTAj8qTCJpe5jnTF903zFo4GD/Eapw/s/dX1Ix4UiQa4ek/4P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558371; c=relaxed/simple;
	bh=wKYRrnf0bu+RGD0CseyzkZK+VxRIOppd45wQewnX9Ro=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=NsfjHYROf+SnpYslbvjK2wNzvz7NnTkNe0xuKnpIKyWIf4zNUaURyEj4A/QJAFUhQD5ebJAjQQ54L5mhI+NPCRJ5pq0VPQ+/pMzcTVrFNkSVZaWtPPDglET08QZ4dCjbnS7bwDRYvUjPh+/my5tK31ccz+md7D3dC2W5pBWHk+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=JClEyr7s; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1749558367; x=1750163167; i=markus.elfring@web.de;
	bh=0ibr/u9wmRw3IDDbT1w9YuGId/6Bkxg1OuLaCRNLBDQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JClEyr7sdpKAGEOGTh/hJ4RVdhG3ht3xuPykeFp9JNpYCYgeoCVSk170KiJhbmAm
	 knO8AI5EY8JvM3oYfoNw8S6ApsAG3FKvSZpoMx1EgULAyPCWrgwP+usy8M+hyx+7S
	 KsrAoR5X+Jt9bkWJEgkULtYTvUH/2xienqqF1rGQM9e0cWhOZ6vaJ6QUFYRNOYUUO
	 06sD96z0VWfCitLC11IZM/Rr/9BzFHAJDuRkqOl7243jwbadQw06kc9tfxODmclhX
	 Zp759oNxRkdGu2gPdMQ8pjIOaB53b7d3ic92lnuqCNAsVzz2IK4iOahubtRWNfa3d
	 tkoBd1Suzfd3/rUtdA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.183]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnpL4-1v9qBM1hjm-00hIFm; Tue, 10
 Jun 2025 14:20:18 +0200
Message-ID: <cdc577a5-cebd-404a-b762-cc6fee0870dc@web.de>
Date: Tue, 10 Jun 2025 14:20:17 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Potnuri Bharat Teja <bharat@chelsio.com>
Content-Language: en-GB, de-DE
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] RDMA/cxgb4: Delete an unnecessary check before kfree() in
 c4iw_rdev_open()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rtrrY1VWMDDKdChTkNwq+2zPMGyeNSRPG+dcr1qM2sbd8hrDyyP
 KhcfHLw/yvpvdIsL0XnWGXHdxNiac06nHNeN9V+TqDBXHi47jZ4l4opVSQ50vrVcA9p99uc
 7iD/yoj8wxpwvmkJOYKMIZR/qRnAiyd1U2IPNo7sP7bdKDJd437EeFFsC9tTmWQfct1VFz6
 8cLZlP4fsmbTf7oSQu3lg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1x0daLfZ/FM=;B9k1MHJ9OYGlmwibEdNvuoOOkoQ
 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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 10 Jun 2025 14:14:09 +0200

It can be known that the function =E2=80=9Ckfree=E2=80=9D performs a null =
pointer check
for its input parameter.
It is therefore not needed to repeat such a check before its call.

Thus remove a redundant pointer check.

The source code was transformed by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/infiniband/hw/cxgb4/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/=
cxgb4/device.c
index 034b85c42255..c0eb166a49b9 100644
=2D-- a/drivers/infiniband/hw/cxgb4/device.c
+++ b/drivers/infiniband/hw/cxgb4/device.c
@@ -905,7 +905,7 @@ static int c4iw_rdev_open(struct c4iw_rdev *rdev)
=20
 	return 0;
 err_free_status_page_and_wr_log:
-	if (c4iw_wr_log && rdev->wr_log)
+	if (c4iw_wr_log)
 		kfree(rdev->wr_log);
 	free_page((unsigned long)rdev->status_page);
 destroy_ocqp_pool:
=2D-=20
2.49.0


