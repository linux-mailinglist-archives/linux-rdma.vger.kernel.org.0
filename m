Return-Path: <linux-rdma+bounces-7684-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B34DA329E7
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 16:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3C4D166485
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 15:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F03213E73;
	Wed, 12 Feb 2025 15:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TpMAppSM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F38D2116FB
	for <linux-rdma@vger.kernel.org>; Wed, 12 Feb 2025 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739373952; cv=none; b=q6ukCdKxv/sIwwxhCTT10/TbhfAVw2FKA2gld7jnOtTaw28kSQfARnL+b2QoMF5O2UZEGsWOSXNSttwEXSEy+LsT2IqTkTcioCvDpuVOWJeRgcSa4pVbqBmfH/Q/E+NhqsXPZJVH0pLiQV1rui+VMcwWpRAwdAW37MNBOBz/tfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739373952; c=relaxed/simple;
	bh=9Xev0WPL3aqSoOZ+iEdwAurHlCOlmppDeErE0Vxv/pY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Nijkl2r4c0UgRtkdKSj5kuxX4wAlv+BS+77G4jFcDYnJ9Wwz3IySJ2d7CXxr21X2c2aEBKoEf2RGU8OCRKHd/gZ5Ewn7knB6tzYDW6nRRqBjz0wKxRncVXRJjWeSUyKtzpcFGq9tUKikJ8Rpnok8toaCH77IBY+SEcZoTokW2Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TpMAppSM; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5de4a8b4f86so8424132a12.2
        for <linux-rdma@vger.kernel.org>; Wed, 12 Feb 2025 07:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739373948; x=1739978748; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m7M5GwfQ+3LOfRzgrXxTqKn9y3djRSUzmsbdmGEOdrs=;
        b=TpMAppSMzGe7Qgv4SD2KCRxTXd7Cs/VAiAWIT/QKGvfTP+ILlGxHKXM4soOQca0ag8
         8GDz5fTZziGjiehapCvZXCW+BJbJclA1dYlLH3SJu359VtyhHMXVb0eICI2ME5DhLHGC
         +nZA9GeBm/Y47BBKn3Fc/Y4k2zMIBp2F/YobO3m+mA18daRp5pzAHM0sMUNQiSVRNIq1
         C6PEo5joERGid0roqAMquRmaXxMokaHzYJQDZIOxlQSYxFCK/pgRLk3SbdBLL1FcOIll
         YUllb/JwuL2OfRpxrDA1g6h4Xzo7dit65ZLhVDQkXsBWtmw7F6MLYxtGtTYyxVqNZLKa
         DmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739373948; x=1739978748;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m7M5GwfQ+3LOfRzgrXxTqKn9y3djRSUzmsbdmGEOdrs=;
        b=YninoCyrU+S1XTRd/OUUZ1ybG4NFas27NxlGBQMSgYp3a2JSwI5JSDWOkzmX24x9Io
         QPSEkQwB5VhkQcZcbYzG1Zb1pXFsjvOji6pQfzdYiSMxW0LNMMyJiZYEmlYAhSK01hzn
         AMZdz90UQLsCWW2JwoaOBBfBEA8RWp7jzwK3IzHSoJIDKrsi9t4HFiuX2kBxw7mZoWg6
         fDQEJrfF05VmIZYyRg0d+xBompn/IZP/UtmyMdyKw+1YMXN4+FhmGml8Cw2fJaJdYr9J
         oZr1uVnbFNmuGPEwomfWx3uOYFq6OTgCuUthAeETbLrDPgUfKgOffT+Y5R7m1xipWN//
         nH8g==
X-Forwarded-Encrypted: i=1; AJvYcCVt+kmG+sOfDSBiN7GLTqfeM4OS7sY4iFILEho2ByWK1JJ6jQkjKNORM41qhPMoH6B/S0u+GLVmNbIy@vger.kernel.org
X-Gm-Message-State: AOJu0YzXue/S59UBGUdnL0g7q7HvLsNDl+mPO873TqtwSa8XbhTQ3Z+O
	MeYBljjplWfyLAOzTAsyEyToXgZWjpAeMQFgiqcA86ZiZLrgnCC2XCCBrtvWxrY=
X-Gm-Gg: ASbGncsaM16l7tC1iMaiQhllsJtd6hNtwSBN1koaOhLWIqyzJQXlc7ulCbyyAfcRV7s
	CtfkGbTpi4IOl/abhyUwMtQ00lRToJ2/C7HUIpSDNMgJr17B7exS8PCIvX1RlBa/hi7lEjT7D2I
	0YNNLTKjQTEJXn3Quh2ychCZQ6YOgnctnGTsCWZufAWJ9BA8NnKOXf6FyCKcHOuDVVPpGp54sxf
	oCuGZexKfBkaMYH6SLpCejLlhC430a+0MbyMwT2XfWHLWAqhxnSJcHFXnCNfcWL5PvQrJxbF5kS
	o0JCXr1oFSdJw1RvJSs7
X-Google-Smtp-Source: AGHT+IGbFzs4+6mWsWpYBe7JoXi+IDrmdHZBXOXvhE9G4jtbV7nz5cMuSQAFACr2ooMFlOpmsOYjfg==
X-Received: by 2002:a05:6402:40c7:b0:5de:ab36:699c with SMTP id 4fb4d7f45d1cf-5deade00bc6mr3449416a12.30.1739373947907;
        Wed, 12 Feb 2025 07:25:47 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5de59f893ebsm9040916a12.45.2025.02.12.07.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 07:25:47 -0800 (PST)
Date: Wed, 12 Feb 2025 18:25:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Mustafa Ismail <mustafa.ismail@intel.com>,
	Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] ice, irdma: fix an off by one in error handling code
Message-ID: <47e9c9a0-c943-440c-aea7-75ff189c5f97@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

If we don't allocate the MIN number of IRQs then we need to free what
we have and return -ENOMEM.  The problem is this loop is off by one
so it frees an entry that wasn't allocated and it doesn't free the
first entry where i == 0.

Fixes: 3e0d3cb3fbe0 ("ice, irdma: move interrupts code to irdma")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/infiniband/hw/irdma/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
index 1ee8969595d3..5fc081ca8905 100644
--- a/drivers/infiniband/hw/irdma/main.c
+++ b/drivers/infiniband/hw/irdma/main.c
@@ -221,7 +221,7 @@ static int irdma_init_interrupts(struct irdma_pci_f *rf, struct ice_pf *pf)
 			break;
 
 	if (i < IRDMA_MIN_MSIX) {
-		for (; i > 0; i--)
+		while (--i >= 0)
 			ice_free_rdma_qvector(pf, &rf->msix_entries[i]);
 
 		kfree(rf->msix_entries);
-- 
2.47.2


