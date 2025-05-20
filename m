Return-Path: <linux-rdma+bounces-10454-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAAEABE4DC
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 22:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07D804C5A0A
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 20:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5C428D8C5;
	Tue, 20 May 2025 20:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEPMihI2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDEF283157;
	Tue, 20 May 2025 20:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747773381; cv=none; b=bX28DWQoEwqvkDa6OQQctwDX4/xV1xqoGwxOBbALb5o54WeRzGfJAtbcRCKUbnutWFjB8ef3PenN+cFQQ8dLhH64lDi72r3BfVo2dAwDgbvBsYQmrw/kVUHvO94653ENTQm13WKgO2BurLrsLc2uGuj9Rnl360Wxt2N22SQ6w/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747773381; c=relaxed/simple;
	bh=c2cggQALUIf/dfn5q+vkgGV3x9yZgrUpIWuuES4L2mE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+RO/KjztyGdlGUrrmen2Of90lCXr5qT2FtiI6aMcAqQu6CE4sTJfEGo+LAZziFcz1DqKH87msoFt73LnT5//3451UXdhOwOTlYPUV5mevIcNoYu5GF/yFN5tx8Yk5AqLjCOX/dKJFv1VNEgEPxN48j6rcpKhx6COFudArLlgtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEPMihI2; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-306b6ae4fb2so4820695a91.3;
        Tue, 20 May 2025 13:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747773377; x=1748378177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5Y9lrCw7xR2ho0EkMK1AgoBE7OrT8n9eYd5ybPQld0=;
        b=nEPMihI2CJLXoOg85w94bJPWy1dgF/C5RmvAv+qxSmYXVMEMEyPlYSq1o7s6IVFfaG
         99Gnnr2rseZxxG3rSI9w+Re8di1q/6w/Xi8pJISIbHm9tJGGkFxpobQRBXN1GruPqhVZ
         haqKn3/4SW8jJ7a4mQkNnpFQGhPu6JU57XeW+bWt44Wvd4lhRzKkbAK3jD4iZAtqPdC0
         cgYG8LnJ7swq3WKWhxzUhqjhrmiEZEWfDklGZWYd+E9JWkSmWZswpX0x7YrdznPzQfYY
         VAbnQ62G301YoZYhNVHQy4JtFbwCK17mgqTYNSQg6/j5/3hXuUZRzCc8cT6crDJCHOqe
         a4Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747773377; x=1748378177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5Y9lrCw7xR2ho0EkMK1AgoBE7OrT8n9eYd5ybPQld0=;
        b=ed5wkPN3MsavUFOmR2/fy5eDl5Olu7coP/6uNdtgbDDP8GyRud/9LdCfw5+FDi1OfW
         0pydoK0uO792Q2P91nqg/pmDHVzgrgUHjU4oNLkvHfHoixZhiPU0O9d34OVuQSqKhtLj
         u5BGEIP0RcN2T7DNEf4IVTKWhefJncTP+lO4BIcM7jBMkQD6xGoahfLWe+ydfCHiPTMs
         3K8RPVJ6PdsbpSOd2NwzTwSgEBbDihsvukM5EfrVoFzpgYUfQSn8QmBjmtlOEe4REBXL
         s3zqvmYNHzqr0K+rGTPztPB8YZOgvM1HPiVJt0sPtC618oKnAHnsrX8ZkZEyY05nT53s
         b8KA==
X-Forwarded-Encrypted: i=1; AJvYcCWYXg7PDRrvlc+GexpGOTNq7KbYeFkGAvuI4Fq/OxUTzVTeGrT3jIBHsVCZalz9tRHFK7EidZVXy7kd+g==@vger.kernel.org, AJvYcCXPooGkYhAPi6j6zD66PTRTuVF1Tukup4ojgX2gDWpymIowJODUmdxzbQObB9rJIhP//WavHDj1ivhrVug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4FthFSZ6YYiV/Ti28oNR6h+C8i44FdGqEJ+fUtyTaYH0tgEqQ
	diiKxtSRhMYeZMZzEsx60eW0P/zT2m613sZlWrFfjQuzjO+cbudW5rEz2trC
X-Gm-Gg: ASbGncvDC1zQKc3c4d8SzdorPdmEIOMcJDLo3W+TnWFgCaNFiIaoSWYEqP9m35+xKtS
	eIIAHuC/f5yj07uO4tcKh+GTuOomI/oqDp+oxDy6VR5i5/3AJGcGCQJhEEfbRv4EhS8kYEWkoRl
	YHF1Q4cbn8ieO4JKNIyniXgAaT66EDfbhPpohnSYJBYH2pE2r6rgBi/RvCLG9bH/+8120+KNU8f
	/XKKHSlsgwCS59KYxREvjM7FaB+Jpl6fMIMGfoi3gf/vJfjdckd/zEfM+0adLQFbt/uIHSZ0wH0
	69ZJq39huO6s1LX1xmdXL0+CxLE9vJsAn8BACOrRhlQYWExktbPW8rDr2IBU2umD675JMIP6m6/
	Yo6bxNMY91S8s
X-Google-Smtp-Source: AGHT+IHWgke1DG8ChG5fslNyhSb3j/oJctAD2YHyTgUEC0y6COR53m/9wy1aosXnbUA1AqrRETKSPg==
X-Received: by 2002:a17:90b:5105:b0:2ff:62f8:9a12 with SMTP id 98e67ed59e1d1-30e7d5b763emr25797392a91.23.1747773377342;
        Tue, 20 May 2025 13:36:17 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30f36491d85sm2158936a91.29.2025.05.20.13.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 13:36:16 -0700 (PDT)
From: Stanislav Fomichev <stfomichev@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	skalluru@marvell.com,
	manishc@marvell.com,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	tariqt@nvidia.com,
	saeedm@nvidia.com,
	louis.peens@corigine.com,
	shshaikh@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	ecree.xilinx@gmail.com,
	horms@kernel.org,
	dsahern@kernel.org,
	ruanjinjie@huawei.com,
	mheib@redhat.com,
	stfomichev@gmail.com,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	oss-drivers@corigine.com,
	linux-net-drivers@amd.com,
	leon@kernel.org
Subject: [PATCH net-next 1/3] net: ASSERT_RTNL remove netif_set_real_num_{rx,tx}_queues
Date: Tue, 20 May 2025 13:36:12 -0700
Message-ID: <20250520203614.2693870-2-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520203614.2693870-1-stfomichev@gmail.com>
References: <20250520203614.2693870-1-stfomichev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Existing netdev_ops_assert_locked takes care of asserting either
netdev lock or RTNL.

Cc: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
---
 net/core/dev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index fccf2167b235..5ea718036921 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3179,7 +3179,6 @@ int netif_set_real_num_tx_queues(struct net_device *dev, unsigned int txq)
 
 	if (dev->reg_state == NETREG_REGISTERED ||
 	    dev->reg_state == NETREG_UNREGISTERING) {
-		ASSERT_RTNL();
 		netdev_ops_assert_locked(dev);
 
 		rc = netdev_queue_update_kobjects(dev, dev->real_num_tx_queues,
@@ -3229,7 +3228,6 @@ int netif_set_real_num_rx_queues(struct net_device *dev, unsigned int rxq)
 		return -EINVAL;
 
 	if (dev->reg_state == NETREG_REGISTERED) {
-		ASSERT_RTNL();
 		netdev_ops_assert_locked(dev);
 
 		rc = net_rx_queue_update_kobjects(dev, dev->real_num_rx_queues,
-- 
2.49.0


