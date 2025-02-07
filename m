Return-Path: <linux-rdma+bounces-7510-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF034A2BF05
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 10:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E0E3A9B09
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 09:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8765923644B;
	Fri,  7 Feb 2025 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rEfuvVzJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847B81DD529
	for <linux-rdma@vger.kernel.org>; Fri,  7 Feb 2025 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738919786; cv=none; b=B88xhw2rSdnAt3pTzs1T4KYPkUfu2jJVUi/37VIdNRx2WHKFrjMNe+Ntr9MthiIjRVsfoCNouHbRZrsK+xOl2J9nPQXaqRRPXqN/4aKEGQFvDHl8nVP4QBtZ2AHQ6dsKNhKqPZ8psVBwlc39wdjJR9o7NfWHgD/aKhwEtgtUJ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738919786; c=relaxed/simple;
	bh=8QyhjSt+PXmG79JqqMzYxvWUPvnaR1/TlhVoEt5+boM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d+kqMSc3DvDvByra5Ue273e5IwMcr+N0tQ67SrJvcn6EL8DO0tMqrlbc8keZCGSSwHeWcPjfzmd6IJ+gHE3XY8GTfxdWVLVTOzJdK67u+IU0PGmrafjftxjkDdeZ7bfDxoO4eBcZ7Or0nPhNIsQOynFDn44pQnuBHEsknMLGxmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rEfuvVzJ; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38dcc6df5d3so218926f8f.0
        for <linux-rdma@vger.kernel.org>; Fri, 07 Feb 2025 01:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738919783; x=1739524583; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vvLbUtxX6Is1AqBp8WxV0jhxtX114UxVQqr6c6sxU+8=;
        b=rEfuvVzJaugBmbO1ALFHHOKtedha/I3DKWGnXzXrsyODjKqCWZlu28q9j8b4cyUpc9
         b0leMaD7xx/qHCTYdURVKfF4E7/UtBJd4/eAC4UFFT9vbl2CrVu74q/Ks1iYUSHp4KZk
         5XJJ0iKczoiohEHsDJnavZJKLIeCtJLZQQ1kRsxyreaysn3zoGMI5w5eQUzhB1d3Jfmp
         +27hrAO18exGrdY0nIdnERfjHfTMCO1tfEKm7VKRkEzE58e1tl1RR5vlwQZZ4jMQiohN
         xvOMQKX1KNigz25GtoQA74Pa3Tcro+vQvL9fZiSs5eli9585J/eTw067p6Ebxpm3Tfhw
         Pq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738919783; x=1739524583;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvLbUtxX6Is1AqBp8WxV0jhxtX114UxVQqr6c6sxU+8=;
        b=i/T/RToWrJPezcB5hmmluNF7IuxeQH8zTRTlsENOrXcp+hqpnl12t5QL6j7dcsPnTt
         5dOr/IEGfMxcdh5ZRQsgfBjOGl8BMPPqMywuFvnTrSCEv12uRqxaCKllVQ0VD20fg/ZB
         Pk6D+ewQlJOgN5rGUG6FG5Zw44sp8KQojZWCzHKArnaIteYK37SakWOx8wG0URZgS0co
         COLrq1Q7pL4oWEDRwd3hgH30fBx1WS4aaHCewbrJ+YvCSwmMhJIyTaqgvWZ7cs0ynxCJ
         58HwEc8fSR2LQliON7JTKNeBmxixFAF8wu25KBUr7fZdk39hApsf7W/kumdVWbr8RocJ
         kA4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVr0oloWjz4vl5LoSQcMgaYMv+8Bo2bbGIoWzxJ9xWEkJO8yr3iUFtcq4DD30o/Sg6Hv9kzPmEr9lsU@vger.kernel.org
X-Gm-Message-State: AOJu0YyLp7Ux2SbVhDM0OtLDjsdKo1oYpAQyEBNcXdPCNTI5Eew0PB38
	vR6LZhfV4jwfeHaPAMV0aAW9pFYUnK6QVL65/LT/IIHwiRZyV0/YNHSykekBuXo=
X-Gm-Gg: ASbGncs5fXZ76YEBiMn5d5gO030TRH9ZPa6be0C2juMn6psMgCvFyB4Q7D3aNhSG+Wg
	ScGLFftYU6n7BGZJg6OwZiEx8omQEotWiFLrT0yYNeg815H0zqpKPalqltZrSeLjGP05i3Bfzm7
	SvhFwLtDQj3eBIcrna5oChtLwIQbGMC3lELBDjqFBX2znCxM3OIIIaKzEryoUhAuFl2osYWBp72
	Alqvm+cVowDdq4Bh/IyUIRcE36UEHXSYGw2Vra1PwiaqNVE+jY5akES7citxHZQLx7tybPij5CF
	7/6KzlnXMUi7PzD0QxuX
X-Google-Smtp-Source: AGHT+IHzf8MzMXdkrcAtuah1r8BuF90slZNj+eI0Wnjcj38CkfEtHceBBNaIgCqFjXafoOn3pJtT+w==
X-Received: by 2002:a5d:64c3:0:b0:38d:c58f:4cfd with SMTP id ffacd0b85a97d-38dc8914130mr1679493f8f.0.1738919783039;
        Fri, 07 Feb 2025 01:16:23 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-38dbdd5c87csm4012010f8f.52.2025.02.07.01.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 01:16:22 -0800 (PST)
Date: Fri, 7 Feb 2025 12:16:19 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] RDMA/bnxt_re: Fix buffer overflow in debugfs code
Message-ID: <a6b081ab-55fe-4d0c-8f69-c5e5a59e9141@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Add some bounds checking to prevent memory corruption in
bnxt_re_cc_config_set().  This is debugfs code so the bug can only be
triggered by root.

Fixes: 656dff55da19 ("RDMA/bnxt_re: Congestion control settings using debugfs hook")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/infiniband/hw/bnxt_re/debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.c b/drivers/infiniband/hw/bnxt_re/debugfs.c
index f4dd2fb51867..d7354e7753fe 100644
--- a/drivers/infiniband/hw/bnxt_re/debugfs.c
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.c
@@ -285,6 +285,9 @@ static ssize_t bnxt_re_cc_config_set(struct file *filp, const char __user *buffe
 	u32 val;
 	int rc;
 
+	if (count >= sizeof(buf))
+		return -EINVAL;
+
 	if (copy_from_user(buf, buffer, count))
 		return -EFAULT;
 
-- 
2.47.2


