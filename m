Return-Path: <linux-rdma+bounces-4764-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA6396CD8D
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 06:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA631C2085D
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 04:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200921482FE;
	Thu,  5 Sep 2024 04:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XlrfEKuV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B677347B4
	for <linux-rdma@vger.kernel.org>; Thu,  5 Sep 2024 04:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725508991; cv=none; b=PSfwA1WpDB9nNA9Xj8zOKmY9+RVHfJMQPviX4zbFgSOrBmbKeJbUVd+ylflK+Hve05WgYUGet+skNXJ3g+iP2cz5NSwa0GfotW1gA7tB/Qzlo/MJHDkg11nb2zgqy7+t+A3tt0vxFYYySICeJJUmgppjoVk/cPyKSg8OswfK4GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725508991; c=relaxed/simple;
	bh=8pABicp+50IsLqxOyqWE6Sq8aD/+XIjO0scm9/7FURw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=nypNg5tRgxn/4o5XWo7l7FCY9j4V8dZLyuhPrw6ayCWeTdZeycKe3Y72577muyDcxmzTq0HxOnYUG1UoxVj1wEjWznhFa0xaR7946xAfpvrMLTzpbafO8cXreofDrBA/f+sS0zL2LlPhYqDRLkLokt/Ob4BkOOhr75BuVzZ+3L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XlrfEKuV; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8a7596b7dfso6729466b.0
        for <linux-rdma@vger.kernel.org>; Wed, 04 Sep 2024 21:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1725508988; x=1726113788; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlIByFDmC8Mahq3GIIzaKXynB+32bEHND/HXQox9Rro=;
        b=XlrfEKuVSf28QtNtngx6pcM+KmJsNtse8w1b/zkHUkpkakv6kKz0DtMcaHL/MEM9nn
         xcve+n72KTG0p2zLZOuwt+CN0RFT9Ya6Tm2Az/4VrKmBuJiEihdBxVEi+/V1esH4nhv5
         V9GiTtPLxJQ3r4L4Ibn7RUFBrNrlvWWBIUXNyLnGC12tOoNHqUWy7P/F5t52pnt4Pgvg
         DidfxtXchzq4znR1v5a2e+14W9RLdVz1TqsB/auzuGvaAoAo2fCqUYJ/kwxb4Vpc1DmA
         fVzv3zpPptqw9V2AJ1mqoNvD7BBQrTdvmhvv2sVgDdEep4wOfR3A2rHLSaeNGfqHLhIU
         lj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725508988; x=1726113788;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlIByFDmC8Mahq3GIIzaKXynB+32bEHND/HXQox9Rro=;
        b=cmST3ZGfVuFWmqoda82nU3A5D0nytdzfWssA8+GBI6bAqix+6aQxT15ePLfKlP+d+m
         AEPZS905Gfu7jGCGbBJBXZALEkjL+9kDDAGzSioReIlLeMGvP8GReNFCq0mApvHWoxYv
         QmkVtzV0TySfKHEyM/KCp6x8+twuSD7XY0mKtWes3mOk5Gx932KgMtKGnvfpBJRR2K0H
         9LLIH0TegPQgqoIhIFfsPmFLdCzehBSVzcpeijqrTeviYm++jPn39yPWnyzhm3rfMZ02
         P9MePTMNt357KDYFkfJrN+/B66HgcMz1FZRhg9Gil3D9Lx9BAv+jqVWWeHXyd10tLTU5
         vcgg==
X-Forwarded-Encrypted: i=1; AJvYcCVWHZsrxLz/+k9KyNWHp6deaK9vonHfurKawREPcYLQLcD9t+wPsgcIXKcv7nn6vaV6L1+2GXdQModk@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4IxVgYjZzb51bcVu8lJg7Vz2wqnKVIlsvw0T0eE4RpPk0WJWV
	qyhpbqk5T2JB6tY+IIosRJLhc8DuyOPjoppBGs2+K2aRE1tSZB+OZ1xXNQEALSc=
X-Google-Smtp-Source: AGHT+IFegv6CAdqeljKZjd+tW6xGIxlEnk5sl8GV8u0dq1pS2dAxSFJempXIEh11AlDG1b8kGZ4a8g==
X-Received: by 2002:a17:906:c146:b0:a80:b016:2525 with SMTP id a640c23a62f3a-a8a4301f534mr382421766b.8.1725508988250;
        Wed, 04 Sep 2024 21:03:08 -0700 (PDT)
Received: from dev-mkhalfella2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a8a61fbb093sm74170266b.11.2024.09.04.21.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 21:03:07 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Tariq Toukan <tariqt@nvidia.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: yzhong@purestorage.com,
	Moshe Shemesh <moshe@nvidia.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Shay Drori <shayd@nvidia.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/1] Added cond_resched() to crdump collection
Date: Wed,  4 Sep 2024 22:02:47 -0600
Message-Id: <20240905040249.91241-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Changes in v3:
- Added Fixes: 8b9d8baae1de ("net/mlx5: Add Crdump support").
- Updated the commit message to mention why cond_resched() every 128
  registers read.
- Simplified the check that calls cond_resched().

v1: https://lore.kernel.org/all/20240819214259.38259-1-mkhalfella@purestorage.com/
v2: https://lore.kernel.org/all/20240829213856.77619-1-mkhalfella@purestorage.com/

Mohamed Khalfella (1):
  net/mlx5: Added cond_resched() to crdump collection

 drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

-- 
2.45.2


