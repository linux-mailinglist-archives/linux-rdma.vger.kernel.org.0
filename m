Return-Path: <linux-rdma+bounces-4845-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D78972843
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 06:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9937C1C21A51
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2024 04:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098934F218;
	Tue, 10 Sep 2024 04:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QWAkFuta"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53291566A
	for <linux-rdma@vger.kernel.org>; Tue, 10 Sep 2024 04:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725942114; cv=none; b=q/Nv2SB3C2XaOwxIZMqeHQp8kB79/x3nxoaKa/CN9lvhqLfTCnjvGYcMvsH92oo5I01wXFWBv2bMdQbO6DNHpYeUOcNzQvDSE4nKORS+143RbCQ3FOux8N1e0qGIQ3QkhySwhhg/ZwrN1biPfseQG38O24jcWHq5nWduudSANXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725942114; c=relaxed/simple;
	bh=o3lbnqKafI23tlknqFq9iVKLT5nVEGvqllgjXm7qza8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=O6Kf2+8xnTWqgnfyF0ICqP7uwZ9sTob4kJKFG43wj59v7r1F0YthFhTmUvKKiXQyO0zaDzPPGOIu4tI6VfzHZ9vLs5kj5MZ9IkgW/mJyxXTnuEWuateSE4ATVotsq+NdVdSOVNO+hRSyn+tio2tvtbkVPMaAP4a2Jv/IuOYmQ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QWAkFuta; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20696938f86so42437155ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 09 Sep 2024 21:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725942112; x=1726546912; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KhEx4b1zbKwaz1nP6dUg6AaylenskeQWQLOi4ZbDqyU=;
        b=QWAkFuta7R8/++a9jTaUUdPtc5GrmYYRHcmxQjTTfiMZmObKsrgsyjApJwFw4khr1/
         yy97xXMvipxro+GDwX4ensVTSbmSumoN/9kezq9IBUro779YITi0aFTfUaQCJyLNmqhd
         XnMAL3HwONUe8/SeuoEpl1B8LaDdJFUELrhY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725942112; x=1726546912;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KhEx4b1zbKwaz1nP6dUg6AaylenskeQWQLOi4ZbDqyU=;
        b=GjE9a4V4TT07Ks+0UdDZgvV1Q6oHtQ03pTHvLOk8ynC5VEifWEjnbikpExY+TZYSf6
         AL4ddJcBrzOpDCWuBR0uw/LWsOJmNvNU2K01+g4UkwFmyePqgoOh/DnLXY1f/Pzq44eK
         1PD63euT4Sjfzl5Ut6gAv/HcKZ6AEEKKmo1ZlIidUPQLFhsZ/317o3Stcfc763MK81zA
         LTBPVn2vYCPrrhE9UuBvKsBR7x43DMoGnh1E/S+OuWmy3J6iP+8D9VIocpZlT37+P99s
         TDTyftt/laFWiZBl66pbU45qEBD07PGAyHr0IT6ANTqbgLFfGPKI1CVFuLr3Flz4Z3Qb
         3oEQ==
X-Gm-Message-State: AOJu0YyugGNv9waKXc63Se76HDfC8I6Kb8cy1seKaE03DcF9GMFdKEsT
	KEpVhwGRC7e5uF51w+i0VBi0R6oMgML8KwdICahABh2bqkVS3/UD/MHGO8+xyw==
X-Google-Smtp-Source: AGHT+IGaeeaFcbOBBx6bZYaa1oOKlto1SuHdxf8v435ofzYhy9Rtq1U74yTliGU55teDfzHeniVHEA==
X-Received: by 2002:a17:902:e54e:b0:206:a79c:ba37 with SMTP id d9443c01a7336-206f051a9f5mr212795915ad.19.1725942112258;
        Mon, 09 Sep 2024 21:21:52 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e328aasm40703005ad.91.2024.09.09.21.21.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2024 21:21:51 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 0/4] RDMA/bnxt_re: Device re-initialization after Firmware error
Date: Mon,  9 Sep 2024 21:00:58 -0700
Message-Id: <1725940862-4821-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Add support for complete re-initialization of the device when
driver detects a firmware reset. Code reorg that updates the
device handles stored with Auxiliary bus and the bnxt_en driver.
bnxt_en driver calls suspend and resume hooks upon error recovery.
Driver destroys and recreates the roce device instance upon receiving
these calls. 

Please review and apply these changes for 6.12.

Thanks,
Selvin Xavier

Chandramohan Akula (2):
  RDMA/bnxt_re: Change aux driver data to en_info to hold more
    information
  RDMA/bnxt_re: Use the aux device for L2 ULP callbacks

Selvin Xavier (2):
  RDMA/bnxt_re: Group all operations under add_device and remove_device
  RDMA/bnxt_re: Recover the device when FW error is detected

 drivers/infiniband/hw/bnxt_re/bnxt_re.h   |  21 ++++
 drivers/infiniband/hw/bnxt_re/main.c      | 199 +++++++++++++++++++++---------
 drivers/infiniband/hw/bnxt_re/qplib_res.h |   1 +
 3 files changed, 160 insertions(+), 61 deletions(-)

-- 
2.5.5


