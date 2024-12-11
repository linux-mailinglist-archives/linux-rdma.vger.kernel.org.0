Return-Path: <linux-rdma+bounces-6415-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76DD9EC3D9
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 05:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 228CD283D1C
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 04:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC24E1AA1CC;
	Wed, 11 Dec 2024 04:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OsEHLyCK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215752451C0
	for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 04:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733889999; cv=none; b=s66/U2G3UiP9hBVDK7EnCbMufir1DikVEOI/4BlWd3ETXD0Xne3jDIlwt+V5oGjzbSSI1jx/2kSnNSETLv6+o4NDVxh1ve2SpAEdLWSgHJem6FfSfjRXPxM/Wtn/HUrCksybvIVi0OQ8lLaqwcsPXobJZeerfCB0joQDY4nHt0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733889999; c=relaxed/simple;
	bh=qh5s924yOMAa+G3wwc6ruxX/zPfheOg6fq6Y9Osk8Zs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gTDvBdfy2VpfgD9z5xBsIW6NRDZ8OhNgT27Hc7gkx1P4DJJV7wkIgayWFoeN20K4BG6/I0ueQc/oHBzoQUiIreILiCcfkV8V8Ffrugz+oBqooUPZ3Qb5TXBlLRafpi2TYXfiQOR+NQQIHFcj+L4JD3eV4f/d1KiRstw2GaAdVLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OsEHLyCK; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ee46851b5eso4545372a91.1
        for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2024 20:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733889997; x=1734494797; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hlQqCak9Zw14b59krJv7Ecz881JEH8cPanY8wmMpAzg=;
        b=OsEHLyCKaFkvy1uR049urr3ONez740NRRbuDaaLLjYi+AVvpEHhV++9l0nRWNfuO47
         kEM4Rf+ppX9CRquaPNSWbvdS3p8oQsBJVINNIfv7nseB22FPiEgUk43QuvUY1G1I6Uto
         qzLk+83U4CDPXPemBV9XYYmtYTGCBKDnLtkt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733889997; x=1734494797;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlQqCak9Zw14b59krJv7Ecz881JEH8cPanY8wmMpAzg=;
        b=LbK0Iy47JVdr+97dm/fC6tF+a7q0k4I97NGIEMJlbhE3sc1BgVZs7zU0g9ewfy1LgA
         YijTh7KrcP4Uj8xdIifykABXV+WeTnOc0uYlcqqPAfwEECzj1TTbO68jaM1UEJQs1hl2
         CgUnXvfQ9FU78qs1a1Tdhy3+1NDNHGPidTFsFOIWdo1K677S2Nf6IJv7u5P/2JL79KwV
         KwzDFhbSn65LHhBbOPVcj8tRUI4DEFJG9eFr4ST9WRMWVO40fCjnyFmOxFT+s8gERAK3
         ca4aj3XDVrTb0BphtNF20SPJmzcp3sgPfS6EyimRLKwZwqV70YTHhfGsjzsfxqCrWTF2
         v2Ug==
X-Gm-Message-State: AOJu0YycQjmlQyIVCb3GWKHczbec8r6PeE9K+23C1aPL59P8ahJx995y
	xPMSzMZXFVO/9cIPw4Xc7bevlrZFQsUlmQ/2zq+J8tDWf+w1Xm677ui1rfCVoQ==
X-Gm-Gg: ASbGncs3Im4pGTakOC1F0UIXbekmULq9Jp4VCOlHOsgyQaTS/TuEaBPHbgLTW0/b45w
	8Yvve/+gOxOxDWEEoXo5U4JTl3JccA2WGbEco0Zf/q07iIaHoPGuR+em2l2zBzS+r3hWiKIp3XE
	95dlvD9vJHXn6XEqrwX0m5C0eQCqiomNzZ6mMRkdpSYCIWHln2LDfVbXDgzaJO4Ck8KBXt2t3pC
	Fy2nMhLfG0H7Dj+vkKADpfngn83o/NV+ytmBDVn86cqYJ08eUy8qSb8BGB44S+PxTMlZoWQ0rbC
	Tgvv0/s7GRZw+klGiFKPC249mXlf3jFiMc74
X-Google-Smtp-Source: AGHT+IEsjKc5GhqtEg6PJK9CMnxR+6Bv6BTgoz/8Yc3aiO7xJ5mnQEWQunnbfdg2zbrvIdWKe6WLpA==
X-Received: by 2002:a17:90b:1c05:b0:2ee:ba84:5cac with SMTP id 98e67ed59e1d1-2f127f5684fmr2440300a91.7.1733889997355;
        Tue, 10 Dec 2024 20:06:37 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef26ffc948sm12477773a91.3.2024.12.10.20.06.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2024 20:06:36 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next 2/5] RDMA/bnxt_re: Remove unnecessary goto in bnxt_re_netdev_event
Date: Tue, 10 Dec 2024 19:45:42 -0800
Message-Id: <1733888745-30939-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1733888745-30939-1-git-send-email-selvin.xavier@broadcom.com>
References: <1733888745-30939-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Return directly in case of error without a goto label as there
is no cleanup actions performed.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 735bd78..ae5025b 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2241,7 +2241,7 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 		real_dev = netdev;
 
 	if (real_dev != netdev)
-		goto exit;
+		return NOTIFY_DONE;
 
 	rdev = bnxt_re_from_netdev(real_dev);
 	if (!rdev)
@@ -2260,7 +2260,7 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 		break;
 	}
 	ib_device_put(&rdev->ibdev);
-exit:
+
 	return NOTIFY_DONE;
 }
 
-- 
2.5.5


