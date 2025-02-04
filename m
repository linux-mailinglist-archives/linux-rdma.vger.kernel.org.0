Return-Path: <linux-rdma+bounces-7389-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F02A26D6F
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 09:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6DF1886B97
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 08:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42052206F18;
	Tue,  4 Feb 2025 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="R6UXHea3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA5D2066F8
	for <linux-rdma@vger.kernel.org>; Tue,  4 Feb 2025 08:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738658534; cv=none; b=K/JyXWlaVrfWeTwglFOuWtGO5W4rD3qYmtUJsOiGj2AUx1CCnS42BhYausNH6SXYGpuWXzCHzhbuxSg7Pgb4xM1MevNctaObPl2sbRVkRUQ3dufHpXrBnt4AgXTXJpEk/9SqrKIiE7WKsllggZ6CHAwPExWRuZ7XWV15g+smFj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738658534; c=relaxed/simple;
	bh=JPL1//Se7eef2Rvk2KP3lh/mNGNaKDvUVywwb9AQbTc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=NoLUHdxnby2Atbf4zq0H28CrHEVGBIUSKH9vJyQkR5ZGA3ZSR7/NuQkxkVS8TdoXjfM0RvIwPTEfk3XkUgv/BNmCfWBkO9NvkJ3ApcZtudtk7IjAF/o8PdWZe2vUdtZiJLuommRuu6tTbF6nAwYtVJvGFhkuAytSFhi8ov8Nzz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=R6UXHea3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2161eb95317so92392195ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 04 Feb 2025 00:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738658532; x=1739263332; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBLpXqDkWRlpK5Mt+4I4PfhtCFaqJuGnYWvEbo5bwZQ=;
        b=R6UXHea3XOG60pXRqjDk9o4HfMQd4E3cPkjXxUZKR2mfjZk3YJFZK60vjTUdDgrJbT
         r31TIZ/EWyPeSbz1r4x5jj1GV3z0guhSF78lHhXEi5Ubt4hGluHUNGHRPaN+/2EEskAJ
         yLMrQGnUdqo81YMmVIOaBt5hfZWwW1+HWpYYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738658532; x=1739263332;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBLpXqDkWRlpK5Mt+4I4PfhtCFaqJuGnYWvEbo5bwZQ=;
        b=eelY+OoB5EzWX0uB41blY4+qXm4XG3AGDRNepdqtOSSaksLtIJEcnm5UgfHdiTrHsO
         eDrAO09YjicAXaLnK8aD8gJ4zP8m+tv7dTYnLqikjURkGKqFqyDII9f5EW7CLUs6aQhp
         vvP2k+pb2cz3Zt74ye/ee3F7VhlpiuQaxRNEk3m2pO1nMVNMVadZmngvSM+EJaZT8vKW
         +8ag6F+xzPzg2iuWV+mHEufW3Z322XyDza9pQGf3VdUXRuFQqEPejV3nJJcUrYxUVoIZ
         C0Jgi+APjNgLUbpWnpxK1so538wBdsgm1ytZV9wA2/8JE33EG3Z9HNhKDyPinhw+06SM
         4ZxA==
X-Gm-Message-State: AOJu0YzT3IsFF9IMjnqEotftGgWR7zhwXK1prSMDB0OWF5IHRRE9aKhS
	KwhvmnUxnc1lgZaVYhoeKwVAjLHR6xUC//we3RUYYnYtfFBJpxVliCUYr5inNg==
X-Gm-Gg: ASbGnctd6gT8ebEEE4u5X49lpxDf8JsoqAN4VrEkjrzEyD4IU0Kx7VnyF0nSL74ICk6
	T0mami+ZR5xJvaXHh6Wl3YIHY08JsUB9CMgM8IPLh/7c8S5Z+P/+kDYdu+qtfyeifAZiTRmAjjK
	bmP8wyqPKqSQQ1XWyYxrDWf17Sx7XZlfFLGRLrvU4mQjc6S+e0f0ckrviinB1i2kJCfYCx5A/r7
	2U6M9gd0TxZfsl7P50TdYLhLno4vjqK+7kS+5hM/vkNeXj0d9yQwyivuRBegILiRdSmQGrgxcTU
	U5+wdefuKXK3/pbJDA3gpPIoTK6vtqF0d9QXfcKgGFHDdSBh74kExruWt0lYekrwJYcCuyo=
X-Google-Smtp-Source: AGHT+IH3i/+izrI69y8cKTmjGg4W2NZrxlG6rxgedYxfjjOICquOim6Xp5mkUpT92ZnnbhakG0LCFQ==
X-Received: by 2002:a05:6a00:3e24:b0:725:4109:5b5f with SMTP id d2e1a72fcca58-72fd0bf3cd5mr42988646b3a.8.1738658531529;
        Tue, 04 Feb 2025 00:42:11 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69cdce1sm9822069b3a.126.2025.02.04.00.42.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Feb 2025 00:42:11 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc 0/4] RDMA/bnxt_re: Bug fixes for 6.14
Date: Tue,  4 Feb 2025 00:21:21 -0800
Message-Id: <1738657285-23968-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Includes some of the critical fixes found while testing
the 6.14 branch. Please review and apply.

Thanks,
Selvin

Kalesh AP (3):
  RDMA/bnxt_re: Fix an issue in bnxt_re_async_notifier
  RDMA/bnxt_re: Add sanity checks on rdev validity
  RDMA/bnxt_re: Fix issue in the unload path

Selvin Xavier (1):
  RDMA/bnxt_re: Fix the statistics for Gen P7 VF

 drivers/infiniband/hw/bnxt_re/bnxt_re.h     |  1 -
 drivers/infiniband/hw/bnxt_re/hw_counters.c |  4 ++--
 drivers/infiniband/hw/bnxt_re/main.c        | 22 +++++++++++-----------
 drivers/infiniband/hw/bnxt_re/qplib_res.h   |  8 ++++++++
 4 files changed, 21 insertions(+), 14 deletions(-)

-- 
2.5.5


