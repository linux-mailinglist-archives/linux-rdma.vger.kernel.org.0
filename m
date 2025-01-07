Return-Path: <linux-rdma+bounces-6874-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 033C3A03AF0
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 10:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC55316249D
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 09:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01E9199E89;
	Tue,  7 Jan 2025 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="K4aOzP7S"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E96647
	for <linux-rdma@vger.kernel.org>; Tue,  7 Jan 2025 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736241768; cv=none; b=sF13HeqYr7Rvj5YoSW1V4IJyP2GABAqHT4mRroer53QXtNauibkWvqO2KwR9jn1o04xcwLId45Wa5AMw6SaFrbYLm0S095gkEce/nenl1FoJe9zPxevxScyqB1Fc+ogDHcpIFFjrSG6cd3pE1/Nm8AzEPsJSPfn1VVDzGDNHmVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736241768; c=relaxed/simple;
	bh=atG3Ae7S5GWxJw4EoA9wHdXwtZZWQEum9CgqHhY/NbA=;
	h=From:To:Cc:Subject:Date:Message-Id; b=k2eC/C8CTpEkXgxS7+GYmBQlHnAoj3F6icre7tfKwEisWnVwqGYM6bfpT+y7kfJkJZZ7qLkSpK7HFBLbkvsPcsmCf6Z/PdBtfkwynjGUCoc5/WRZN+O/nXcnlwtLw9d2VrMgi+p7JnMlEAmuLk/Pby97iGxEcRtgJbCepB1QkVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=K4aOzP7S; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so22713505a91.0
        for <linux-rdma@vger.kernel.org>; Tue, 07 Jan 2025 01:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736241765; x=1736846565; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmD4Xo8QKcPvKZp4DUxDRLjeXuFvul07mP7oWjeJZyU=;
        b=K4aOzP7SXugh20pX3by5fabdxjcY8tRbadU5h4qmtb78Rnv3ci9+Fbv2VGhmv4LhuD
         6GSthnF9/Hq9ePqYmbmpsjEx9oBTSBZNrJqq/+0X6q52kL4S/MoTR4VALtjhd7Fo9s79
         9i35DZA9ZLSo3l5Zqzs2FTtCL+CDO5ZouO9CQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736241765; x=1736846565;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NmD4Xo8QKcPvKZp4DUxDRLjeXuFvul07mP7oWjeJZyU=;
        b=k8rj3XvUZIsuyx4pW3rYRi+Doqb6G2393rCAfXJO4bd5PsC8INX7ZR7gBDOieo7J2Y
         whRRXAOr8H/1zrXHs15jFWs+APpeCqquNLGtHsp62GBgk5+u6gEMmolum/vx6UuMpMQV
         wAHvpAC4xawLcFnoJgnHt1rtHYUom/+MNU8Qs0gZTNlgjB0gBPF+lBEyJ2tIVYQcizD0
         6gDaaDwIqTippX7VLHRWr7496Ltc5GCkiygKOBFhcT1mGOjIIPbhu60pq1gYC/ALfhdO
         ReDygNrMxRxsmQWe29CqFG/jFxzVoZ9LVt29yi2rVk8nx6+c0EDuPRRmzVZK+ezb3NHl
         t/LA==
X-Gm-Message-State: AOJu0YxHej5YaYk9NNtiE58Di+4dEfdXUXxWKsHYMJru9tfXcxye7Hvx
	ziwfFeQ65Yz8+F02uZxTSpzzZBeJljo9ZoxEUnBL4Q5uWelvhFnwbjjWgmL31tVeCC5MD/wh7bY
	=
X-Gm-Gg: ASbGncvbkSIf0HeyV3u/tNz7DFVeFrBQAeSqT4072ADtqsu5M84oOJI5aGyr/xgUAYx
	HeebH7mfNQHkBHwRMYFy9BOngZaECucWYFLj9S6Z8/KldqMZXBe6hGW4dWPsUvFThm3UBGMBBW5
	2ses1cDph8Ewndqd8m9UsuZzPfZiHTJ2nlpTU53r1ZeT6PLTIRm8QNo9dFYz8FJBvC0nD5yOOt6
	iRZ8Y2nsnYqLOnkRdPgvOAPcRfIHB4T2uFJLwyCwpn6p6KnExDRHmWo8HOy8vhl1NjlhqYNRGOi
	30M8eVsO7ngyAme5WhW3CxFkpfcoM380i2Y8
X-Google-Smtp-Source: AGHT+IE0SuvUY2by/kWoJ9wRZ32G0rSoj9e6ZPCaeI/0ViY1bf87EbAr1CPZLIdJqDnAQURHv5c04g==
X-Received: by 2002:a17:90b:2545:b0:2ee:74a1:fba2 with SMTP id 98e67ed59e1d1-2f452e3e83cmr91567535a91.20.1736241764821;
        Tue, 07 Jan 2025 01:22:44 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4477c4cc5sm39326479a91.12.2025.01.07.01.22.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jan 2025 01:22:44 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next] MAINTAINERS: Update the bnxt_re maintainers
Date: Tue,  7 Jan 2025 01:01:59 -0800
Message-Id: <1736240519-2491-1-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

Adding Kalesh to the bnxt_re maintainers list

Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e930c7..f5302f7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4766,6 +4766,7 @@ F:	drivers/scsi/mpi3mr/
 
 BROADCOM NETXTREME-E ROCE DRIVER
 M:	Selvin Xavier <selvin.xavier@broadcom.com>
+M:	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
 L:	linux-rdma@vger.kernel.org
 S:	Supported
 W:	http://www.broadcom.com
-- 
2.5.5


