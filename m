Return-Path: <linux-rdma+bounces-14783-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26761C88889
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Nov 2025 08:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E083AAA95
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Nov 2025 07:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B1729E0F8;
	Wed, 26 Nov 2025 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCpaMgmN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0330E28B40E;
	Wed, 26 Nov 2025 07:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764143866; cv=none; b=qrDBzpyj097BqoSECv1e0w54oIBwHuEVRjth7JvuWlIIWy4LS4SqJXRpDuG/f8Xo2BV2qybzeYjCv4CmJJsmfFDx7kfrN2YrDv9LsihyYnYMTefu3GYGrwBrFR19Y0mxEoOQK2gqDOD7IA/k+TRy9UrfdFFrYd14IAdipyt+nNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764143866; c=relaxed/simple;
	bh=5sxsjwesJ/b8wOoDh8XH06Par6rJuU9NSc3VyQ5jUys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YnfVzMs+BZmBTwHANedp6pIFNETzIODLERoYvQsGgAb0ZDA6JQzi0u/KTzdhpkK6HPZmiy9MqvfN35fnasz8pWviooSgsxHFHZD9IUlDsYWbJDm6l34Aajd4brusGcFzklk7Jg4oGSWsSC3vlc5zMRUHSwP0fPY5usEIUP9Zll0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCpaMgmN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28745C113D0;
	Wed, 26 Nov 2025 07:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764143865;
	bh=5sxsjwesJ/b8wOoDh8XH06Par6rJuU9NSc3VyQ5jUys=;
	h=From:To:Cc:Subject:Date:From;
	b=lCpaMgmNimde7r7BwW5q84wzXwm1Kf3RQzCuAGT3ZHZhUuR2vedXMjznjXWMqY6NL
	 ud7lFoS7P+Vz7lL/FNJR4BHWSav6jyQ8RYyGXDiHOWD+BDKfXPGVp3VJ6tDh2K9YbC
	 RkoC2JGXE4KiZoDXSwWl3Hz9psgSas6RjjMqgX+MT+4Pun3fTy8kMibJN5kmsYFWvP
	 XveKZq/J5mPS3sXRmED3+MzGi0iQSGw+J3oSMSTHZWdqF0nYzVpRt0oZ+Hjrv1F8ts
	 iEBAX4qm9a55oJtZ70WMnsLNIAKuwY+e6O30r2RLW4mPzM1LKtP79Hf0ypf9L3gH2W
	 aRPYrSu9Uw+IA==
From: Leon Romanovsky <leon@kernel.org>
To: Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Usman Ansari <usman.ansari@broadcom.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH rdma-next] RDMA/bng_re: Remove prefetch instruction
Date: Wed, 26 Nov 2025 09:57:37 +0200
Message-ID: <20251126-remove-prefetch-v1-1-fcac22007ea7@nvidia.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251126-remove-prefetch-ac5cba4dc9ca
X-Mailer: b4 0.15-dev-a6db3
Content-Transfer-Encoding: quoted-printable

From: Leon Romanovsky <leonro@nvidia.com>=0D
=0D
The prefetch instruction is meant to speed up access to memory referenced=0D
by its address argument. In the bng_re code path, it has no effect,=0D
because the pointer refers to a function that is executed immediately=0D
afterward.=0D
=0D
The issue was identified due to the following kbuild compilation error:=0D
=0D
  drivers/infiniband/hw/bng_re/bng_fw.c: In function 'bng_re_creq_irq':=0D
    drivers/infiniband/hw/bng_re/bng_fw.c:278:9: error: implicit=0D
    declaration of function 'prefetch' [-Wimplicit-function-declaration]=0D
      278 |     prefetch(bng_re_get_qe(hwq, sw_cons, NULL));=0D
          |     ^~~~~~~~=0D
=0D
Reported-by: kernel test robot <lkp@intel.com>=0D
Closes: https://lore.kernel.org/oe-kbuild-all/202511260607.Kuxn4NnN-lkp@int=
el.com/=0D
Fixes: 4f830cd8d7fe ("RDMA/bng_re: Add infrastructure for enabling Firmware=
 channel")=0D
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>=0D
---=0D
 drivers/infiniband/hw/bng_re/bng_fw.c | 2 +-=0D
 1 file changed, 1 insertion(+), 1 deletion(-)=0D
=0D
diff --git a/drivers/infiniband/hw/bng_re/bng_fw.c b/drivers/infiniband/hw/=
bng_re/bng_fw.c=0D
index 803610fb9c58..7d9539113cf5 100644=0D
--- a/drivers/infiniband/hw/bng_re/bng_fw.c=0D
+++ b/drivers/infiniband/hw/bng_re/bng_fw.c=0D
@@ -525,7 +525,7 @@ static irqreturn_t bng_re_creq_irq(int irq, void *dev_i=
nstance)=0D
 	hwq =3D &creq->hwq;=0D
 	/* Prefetch the CREQ element */=0D
 	sw_cons =3D HWQ_CMP(hwq->cons, hwq);=0D
-	prefetch(bng_re_get_qe(hwq, sw_cons, NULL));=0D
+	bng_re_get_qe(hwq, sw_cons, NULL);=0D
 =0D
 	tasklet_schedule(&creq->creq_tasklet);=0D
 	return IRQ_HANDLED;=0D
=0D
---=0D
base-commit: 01dad9ca37c60d08f71e2ef639875ae895deede6=0D
change-id: 20251126-remove-prefetch-ac5cba4dc9ca=0D
=0D
Best regards,=0D
--  =0D
Leon Romanovsky <leonro@nvidia.com>=0D
=0D

