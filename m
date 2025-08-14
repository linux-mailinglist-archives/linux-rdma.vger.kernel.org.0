Return-Path: <linux-rdma+bounces-12761-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A40AB26420
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 13:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94C01B6176C
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 11:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832872BCF6C;
	Thu, 14 Aug 2025 11:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ag9RM96T"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E39528EA72
	for <linux-rdma@vger.kernel.org>; Thu, 14 Aug 2025 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170419; cv=none; b=tem9bq2XdezHthY3CeLq3XjDYR8fgOIq2hoBeRI4kxh1El2NDred2B0tN+A9+IjsVdujwFEu37TlIRdvYvb/fGRuL80nvgLDuI4IgSdM3kCicRjW5GQoFWxeI7NkbsmzVAsDs+jZWImoLl4ZkoOcEepu5vnPCys38jpxld7ZjXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170419; c=relaxed/simple;
	bh=Q75pl6zkpnceltiQJnUO9x2K2exyc1ZFeFrio1LNHXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=to1kYmY7orDHWFRUUZ3LGoxStv+J3KjD0hOE+5MlF9sf9/aJ5ZLyTTHmEX99xkgk92J4/+wKVnZi1B1kdhYxHf9+p9O9WR+vcPY5H79PVrI5cflgabyhBAeMspxnHpH8TsvznMlNdDT+P0/2f2Y/lgHbCYzPW2JOJ3z2DcEflwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ag9RM96T; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-244580523a0so6982485ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 14 Aug 2025 04:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755170416; x=1755775216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bm5BLYFw2YJVXz6MY+FlnOwNY0LiRM1dh9CSjbCoJQ=;
        b=Ag9RM96T1ZjGWljxRUOpiImQHnFYJemqqEPoXCaEU1acGap8k/HTzf0e6D1F+gWmTg
         JIpO6nZTmzBITJuekbwmclsTGAatkyF/3yBzCpRPXJ2dP8IvdR/jVwrHMcmlGnaMeXwK
         1Bo3/29Pu1x0SmE5Q87bDFjUXsfQaNb7Chvyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755170416; x=1755775216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bm5BLYFw2YJVXz6MY+FlnOwNY0LiRM1dh9CSjbCoJQ=;
        b=VZbUTICBh2LmshD0AjZ1YPcb4l+ValI8qLsCAVqUov7Y8gTNR0C1i2uz0nO04XmzYp
         YzCaammtNJCKsR27GWVyDHU0PSfaFsSnRCf003m1pW6BjHf3KD5vo9gjrYldciiiPDN8
         2Vq9kIRc/eUENgA6x6oyuBwN3QfMyIZAou5Ajaot4wvn/ijktKuGe4zG7P+F1ANiWkiC
         saWfGpBPpxT37tX+w6tRRmgCDNPZHyzroAGq4K00kwToMJkIU9u7VM+blJ+b0z3M3Gqo
         h51j/dyg4pMzeDOu8VSowoqw7NYl96zLbh+lAM4nE01/KgmLXFHQd9z+jIIyHSKxDHX7
         UJ9g==
X-Gm-Message-State: AOJu0YzaSwuIh0zEOUjoyBLIvMxCYAKxmyH6IPWILyNFpKfGwMY4mSx/
	4pOAsYSZhuLGyPPIshUqNWwVN+vAuO46Y6Vk8eIQa3U30Bo5MDEmjiu2Dn+2znAtSw==
X-Gm-Gg: ASbGnctJvSv/aWZ66NspkAz/OSOvuXOxjxIzlso56OX8KWAxxqP6hUx/IWDd01fSsf6
	QGOZBXwFXsbz0jvZnZUlgSe4uua3JEHVrjbQemY3QML9tuRG2qq430LPISJULbYpbpeoKlNT7ss
	51uzkC5Y5r+1K3HrxtMOWEKjsocLMHcKbEs40lfRWvobXh9hfp8dYyGAWDjIWs+SYo6dDo3Pnmj
	ce98kRnSaPB2cSjODgWtOc/FMFfM2bJ/W/qoE3assCYB3DZ1G0qdbVTecggjVqgdAckOgjK599a
	Nb6FTzHD/mlbtdrC06qCy/9uGfpqd/kr4enA+KnessB2EgGlEUdWf2CUwb/sn081P5qo69Caan/
	LDXGDW8FzdszQzT57bDWT63mSm3GoivDbonzR6JEre7I4Dk5qTiWlRKhCXVryQpsnbYvLGjWk3U
	jUHGWUSS7rekVs5fXIZ0z5/A0AMzYEPw==
X-Google-Smtp-Source: AGHT+IEP8oSdztVTzvpidTigfasGkFhqe9KWX7pppBm8lasLQihjhGhAKcJqoC0FMnzjaYKv/NldEg==
X-Received: by 2002:a17:902:d504:b0:240:a54e:21a0 with SMTP id d9443c01a7336-24458a3266amr38166925ad.19.1755170416115;
        Thu, 14 Aug 2025 04:20:16 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f21c65sm352415175ad.73.2025.08.14.04.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:20:15 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Subject: [PATCH rdma-next 9/9] RDMA/bnxt_re: Enhance a log message when bnxt_re_register_netdev fails
Date: Thu, 14 Aug 2025 16:55:55 +0530
Message-ID: <20250814112555.221665-10-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250814112555.221665-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250814112555.221665-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make a error log message more user friendly.
When bnxt_re_register_netdev()() fails, the current
log does not convey much information.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 1c474b3707ce..3ae5f0d08f3a 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2045,8 +2045,9 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 		rc = bnxt_re_register_netdev(rdev);
 		if (rc) {
 			ibdev_err(&rdev->ibdev,
-				  "Failed to register with netedev: %#x\n", rc);
-			return -EINVAL;
+				  "Failed to register with Ethernet driver, rc %d\n",
+				  rc);
+			return rc;
 		}
 	}
 	set_bit(BNXT_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
-- 
2.43.5


