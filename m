Return-Path: <linux-rdma+bounces-10432-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 027EDABCE04
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 05:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC9B17ED7B
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 03:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B26258CD4;
	Tue, 20 May 2025 03:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="blkf5VdX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BA22586CF
	for <linux-rdma@vger.kernel.org>; Tue, 20 May 2025 03:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747713318; cv=none; b=A/XSa7JaPvMYkcexuJD0oAnlMPkMN7qQWfsnev6djgxxswmpMAAhGSpFpQZj/VtGuMhrbw8N+Q0wYnjOfuNe+pTi1MBwZnV+SqJOdQFa90qS6DAD6xIFs/rDHnNkbk3PWahVL/2AEBWy2zL0bNEzve0eq6vyY/zf4C/2McxRS5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747713318; c=relaxed/simple;
	bh=fbZXrlvsw971MJs44zBPyuPZHcAYWwnZzXRM4Tyn39U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBao1jT1X1miJUrqmoPv9rvKOyl3SnVMedA75SxxUCIDFXOsKrvH7DX80ot729tLrtwpksixX1LONW2M7+pXl+9eBbE8LkcKmUCU1L4KWSCoj4rpwIFUU35Iu5s3PNyP+qEmtqBJiRkkfNJpFlppotDhF4i73v+QfYY4qOrZimw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=blkf5VdX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74068f95d9fso4656741b3a.0
        for <linux-rdma@vger.kernel.org>; Mon, 19 May 2025 20:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747713316; x=1748318116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qI8Ksba+d5JcXZQdDTjJm5ENJX0KyuollFpANuiCMIA=;
        b=blkf5VdXvTH0cq2mirFfwdupFytyFu1qd9wVnU74TBznpUpt3jmRRS0KIVI243IAHu
         +pvpkIyDMzDj1iaestaZZ1cq2aVluCkl3kkLol6Rfen4XLGdz8E0n82vk96t3CItD1Gj
         kDmAvYsu8xquyOj5jpRgisbGURuGNpYB5n+qA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747713316; x=1748318116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qI8Ksba+d5JcXZQdDTjJm5ENJX0KyuollFpANuiCMIA=;
        b=HXNsJWS2LCO/nAgCOy+lF1EySawrjXVXJdNNEuMEposBNtY9IpbTGciZZpkpJ8Pwi9
         woBGMGlJvkFUDIDBsrBTchTJHLWbXRXhDG9+4n9zPVPIIvtr0FSBGff3c09WTIZ8opCc
         YPXKLd14tx/dBu1xsBg7EuQbh6uSfEKxR5KgOAIuJuUkdCH2VjY+I+6WsM5xnHZoXO+w
         vQy2Z+pG7KweZA30gnOBIxKTjt8DxRY4ZdFxFzAlWYVzQuJM7t8lBpT/pb++C9ofQOjN
         qy94FEX8torqmmYrc9Jq0rT6jLWZEh9HYrtcRCwic6m5dAoUfXVWdXaNS10vmwTnBriX
         33aw==
X-Gm-Message-State: AOJu0YzlCKlWvzVpbH8EVLUnCtksse2OA3+VDihzX2ia9gb9MUF5Xvem
	NbuUosLR1K5a+16+h+NAfFL3x9jGSALnQoFIeFXY+SzbuWyIL4CieoiE5/SleOSJVQ==
X-Gm-Gg: ASbGnct02CIg0nkN/TJWYDPFYA+/TtEVm+UnB+rCkbmBsguBqX+nS9rqd7jk+vW2/Xj
	tFCU1A35FNM7/TR1oWGXg1iS6+ss3358aIdc77pZTdm4eTlPV3dVYtLs65SJYNvk2DULUArY6ay
	6VRvwLTVVzdujL1z4IiyjgAH0O834LW+KKkhhKc9NnWgft8dYOHRhuZu2zzhGJ5KItKAvHrrda9
	byXdyqmabGr//qgNgPB/tQtcNoUGTQTmk1A7F/gwymyR6KtpVO5Bz5oJC+RF1gm8AgsMI0C9GNN
	W/NinsZlSgIinnNDZEF0USQKf4RHAJ4TKpTG5RaDl8k4j4GuvPxZP2pF0URNOYM6t+arfOQWYjI
	e2bkud1MxA+KbZzrD7ISOwonYWL3T4soXzShEU0nHRll2LaJ7a46Xpg==
X-Google-Smtp-Source: AGHT+IFpZ0tZaP9HQEv0u3aMHeSB25p6bat8EM8VEINnoDD0tDQ0pSfHAGnSRuLF8vjjtQfXqx8aQQ==
X-Received: by 2002:a05:6a00:4b05:b0:736:3c2f:acdd with SMTP id d2e1a72fcca58-742acce2deemr20991910b3a.14.1747713316039;
        Mon, 19 May 2025 20:55:16 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9877063sm6984179b3a.153.2025.05.19.20.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 20:55:15 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-rc 4/4] RDMA/bnxt_re: Fix null pointer dereference in bnxt_re_suspend
Date: Tue, 20 May 2025 09:29:10 +0530
Message-ID: <20250520035910.1061918-5-kalesh-anakkur.purayil@broadcom.com>
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

There is a possibility that the Ethernet driver invokes bnxt_ulp_stop()
twice during reset recovery scenario. This will result in a NULL pointer
dereference in bnxt_re_suspend() as en_info->rdev has been set to NULL
during the first invocation.

Fixes: dee3da3422d5 ("RDMA/bnxt_re: Change aux driver data to en_info to hold more information")
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 293b0a96c8e3..bc0b40073461 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2410,6 +2410,8 @@ static int bnxt_re_suspend(struct auxiliary_device *adev, pm_message_t state)
 	struct bnxt_re_dev *rdev;
 
 	rdev = en_info->rdev;
+	if (!rdev)
+		return 0;
 	en_dev = en_info->en_dev;
 	mutex_lock(&bnxt_re_mutex);
 
-- 
2.43.5


