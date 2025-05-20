Return-Path: <linux-rdma+bounces-10431-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE98BABCE03
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 05:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4EC6169BC3
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 03:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A469258CD6;
	Tue, 20 May 2025 03:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FdZ39vvl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71118258CDD
	for <linux-rdma@vger.kernel.org>; Tue, 20 May 2025 03:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747713315; cv=none; b=XRIIRS19N3vLMg1s641oR1g7tMUituXr3lPxfQ+E3EWIa8g+J9XgiA5lZuGleyn4PrMuPGxNfIf/XITPiwEcsKXJ9dSiEwHZn1I1JzGj16KSaRk5YAAq44HSsaalZzPloZoVFe4B9fE59sxszwm5Dzk8/jFvGlcNwIW1t0eBqLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747713315; c=relaxed/simple;
	bh=DcFYRlGu10P9wM8mX1s4Q5jFldfN3zXO7AHxmLFJXtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eby1spMb5zQscSSTNx9GgLo08NgZLJDd4np9AtUqoKqwrvrb9MosELiyBokxVXw1GrgHPGHe2+Qr8GJsIGZfZsElROUuHQRqk5Du7oChO+6FnlUlL0u89FQEXBAaE5yoFUM17IAVRrqxgUx1GN28GSggnJztsRuq2oGcFGMP6bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=FdZ39vvl; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-742af84818cso2908742b3a.1
        for <linux-rdma@vger.kernel.org>; Mon, 19 May 2025 20:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747713314; x=1748318114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xmcJGqLqu+p4u3IEg0u+7XWJp8EYkAGnYWb0majFoJw=;
        b=FdZ39vvlontSyOQXYQkOC657qDZtvyjDHvWJ8uGJtimG0k5wsxx5TAw/ylFy4QG95a
         tyNpEL7SHmzw7lmL2SkPPc2HWzsS6Pgvp5GGRYxO/pvOg2PRzmPD/Aou/4N7FF8LjQsY
         dFei4AQWKjVOuX+TLETFxjOhJIiZBi5or3obE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747713314; x=1748318114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xmcJGqLqu+p4u3IEg0u+7XWJp8EYkAGnYWb0majFoJw=;
        b=PbpMGrW1SiAmmEbqhoQ/7PVVqyYVR5kpVFRT/QWBNWjaNKx0otMDFYAf2nMoA1H2EE
         DoU1YCWT9DTFHHpE7gPyWzVqKQ2dZOEO7zR5p6Fj1dlZ3LOL4iSxYCnZ3CxI7QueIGs5
         VB18Il1KVpjvQqfg9Uw/7yGqcOqtAGbBD/sGN4+2Ws6Z9bs9n2uwhxFHUuDi9I3doqxz
         EAdjW9Q8ojmGlcxg5wUB7HKfsvlAAA6izdJpx1dDPier+vfcWloykmF9HCHWETVwJh7c
         8fbFclmhTfouZ6XFzn23g0ChraGpl1gqCgZLePe8XKlIMg2UTKtaHd9MEKF2ylI7BRTK
         IPaQ==
X-Gm-Message-State: AOJu0YwCfUbqpCVaWyLFzwOmkF4l64KEf0htFMTNLqzjjDk1TbG3gqOo
	o97Kpv8NCIeICE8fyDF/9oxyDB3SZyq8LbbKqaWpPimrqm4++UCei1RfmQ22rSxmUA==
X-Gm-Gg: ASbGncvpCSnjcc1b5aINOiEG6mI8u1ugkM1eDDsg+ycP6HvfYMh0AOyw40jR9BvapP2
	Qj8u6k9SwxgsnVJ9vLVmhUdYTPlYnvplaOshfmTKAh5l7V8/6v4zvVpQ5xycbyB0ZMRr0xr3cPb
	aS7z89drDtIXr7rT1V0QBa6SkoCNSa840tIjxbjZj550BbqVU2BifLt0K77sIe4C1IA3dUkyN9D
	NloLPwufKLVAyGN8Z0MUtuAck15yvB/JisRl5KMr/ZLGeTqvi/ionEJV9lBdHprXsp1ilHB36JY
	miuALezyLvqMOCtRoO0W7PnuL7gfL9aZ1QlJQioSTEkinp1igrbYm9QItKZO2UA+XcRMvB25Lc/
	rDH8A4XCyBn3UfxDVY4h/BNX8s7QKkcHR0xKRYwHKmuVOaq72zEz3VQ==
X-Google-Smtp-Source: AGHT+IEjUVbMCJXoT44kR1JZ13+668Qhyhlrf4gMtSIs/ZjcXR1qGmMxGcJzzMWnDJ6UbD7oAy6C9A==
X-Received: by 2002:a05:6a21:3289:b0:203:9660:9e4a with SMTP id adf61e73a8af0-21621a18c62mr21883335637.41.1747713313682;
        Mon, 19 May 2025 20:55:13 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9877063sm6984179b3a.153.2025.05.19.20.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 20:55:13 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-rc 3/4] RDMA/bnxt_re: Fix return code of bnxt_re_configure_cc
Date: Tue, 20 May 2025 09:29:09 +0530
Message-ID: <20250520035910.1061918-4-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250520035910.1061918-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250520035910.1061918-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver currently supports modifying GEN0_EXT0 CC parameters
through debugfs hook.

Fixed to return -EOPNOTSUPP instead of -EINVAL in bnxt_re_configure_cc()
when the user tries to modify any other CC parameters.

Fixes: 656dff55da19 ("RDMA/bnxt_re: Congestion control settings using debugfs hook")
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/debugfs.c b/drivers/infiniband/hw/bnxt_re/debugfs.c
index bd5343406876..4be19e0abd32 100644
--- a/drivers/infiniband/hw/bnxt_re/debugfs.c
+++ b/drivers/infiniband/hw/bnxt_re/debugfs.c
@@ -277,7 +277,7 @@ static int bnxt_re_configure_cc(struct bnxt_re_dev *rdev, u32 gen_ext, u32 offse
 		if (rc)
 			return rc;
 	} else {
-		return -EINVAL;
+		return -EOPNOTSUPP;
 	}
 
 	bnxt_qplib_modify_cc(&rdev->qplib_res, &ccparam);
-- 
2.43.5


