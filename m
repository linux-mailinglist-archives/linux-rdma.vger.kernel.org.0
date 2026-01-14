Return-Path: <linux-rdma+bounces-15550-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E14D1DE47
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 11:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 937793014A23
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jan 2026 10:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0688C389E1E;
	Wed, 14 Jan 2026 10:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AMu/C8Dj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B15C3803D1
	for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385615; cv=none; b=cb+MAGDmAVwb27FXDxDb+yMmFyrF1g4kCTQUWs5za3lWLSQ4BabNZKmo0mk/vfPiEevaFEojpMLWEeOBjphDyvs9GDkmqLrJ3LE6YMbXQBrikNNYdudBldf9majZB6/d3ZIwcVtvKyiGGgW2YxNJkRY0XXAaSZZAmk0H+JOUsS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385615; c=relaxed/simple;
	bh=YD0Zm/XReZ/qiuJDuMO1us34FttS66msSQm4tLpsFXw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qVGOvogqgqHIi+pFxkHSOhsjVKVzADsGAn0uSg8sw/1cXfbgV9/tGQr1JcczgPEVM7lJG5KzMdKhd42sHG50pWRMcvJqGg0eFwhIEVRgespR41nzzeJPM3KFLTaaTbLmBUBhcndc0HnEseIWD3dsgBmq5FhHZV4/+7Nat6hHocw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AMu/C8Dj; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-6481bd173c0so2700522d50.2
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 02:13:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768385613; x=1768990413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6BppJcC1cV2grbqUXketxfe+wsjxVNsUTvoFbnwvCY=;
        b=aVQ0pFj8/d/x2FMKxKm+pJwT2u54q8i6ZLXtlJ2cccfZOTg0SGnjSpfhiOaSHHeuTx
         kBFoZvS5PRIupn521spxVV8fiPhFdRfgK2STfYExJnxxlaedhSvYR2hwqfYkCB8kj0g9
         MlHol66RnRCS3l6s4bKepgx9rgcnOoxCEUDKneJJ2AC82tVo11X69qqvkBM4IjidE8T5
         SAswOGALlMQ7Rci7i28vmjyTdYHy5sVw+qmAzv7dVoksts7bxWAKNFWPjsi2Q53wnSiR
         KfAvbYUSb5xa6mnBEyDy0l6B/NgIRHhRhfIKA8ZD97XIKwruukSz1Pm6HJQVgIajr1x+
         DAmw==
X-Gm-Message-State: AOJu0YxroqFzC1Qq+pacYxmijIbGQQtInw1HZ3pGaCrj+AoDGY+LIo5u
	KaW2qQ2VqSatN9bfNMv4fyt6RDVh0HKcBfpqYVC0oFW5e05jxIBfbKm2g8tascRMzRbB2dJesYA
	LlGy+HCGPMFiyomBUPkLN/aMd/QhihrJOqZ2HRKK23XM5mkJVq9C+dliXxOQ+ULwG17742/2C4m
	W5e237c+kZdrT3JliVE/mCwUMV8DG3d6eJIv2IjIiTYVvHmmWW4MNIwWvxfO5wUttg21hK2f6H/
	TTBgkvsUDxZP0M9Aw==
X-Gm-Gg: AY/fxX4wwngvFx8PtIvxU8InaeUafZ0ZOi+FQLIYWGJYQUp7mjBopvLps5MeMyCX+1F
	zdh9TWSLibU3wvd3euwi9dP86uO+UuCtR/7qFqKappZgwbOXKLxHDPOSZWt6W8dWThX57Xciy0P
	a55ix0jrNVidJpHnUQQXkuzVApIyBmjhCHUjwVnryYSzsKUzD9mSa63rzjuJS325sQue6UMt3Fc
	MGNHd6+XWSe/11VmgGPGJw/NKg5ArU/FSY0ChxmDAo9tMsjBvxVCUqkxqctG9XrrWweWYTpcRgw
	BYw5Z1XpARy3mpoSYFbsObG/uOdDe4jdk4FXbF6u/mgWg8JYqaJ0UlI/d5ocolr3kTY9PhwmMjO
	GbeIv/bgMej+AFzqT3aGAH+JlutQrJvM+VyDpZE7Ujj4MKb0vGHvas5m5Eb9bh7shNIDGt2ci5j
	k/udCT7lhWGRCCKnSSQntiMUg2q5Kd8iWqe35RCVNZFG3sJQ==
X-Received: by 2002:a53:dc91:0:b0:644:6bec:e1f3 with SMTP id 956f58d0204a3-64901b0bdd0mr1259656d50.51.1768385613373;
        Wed, 14 Jan 2026 02:13:33 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6470d835699sm2190430d50.7.2026.01.14.02.13.32
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Jan 2026 02:13:33 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5014e3becdfso7604911cf.0
        for <linux-rdma@vger.kernel.org>; Wed, 14 Jan 2026 02:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768385612; x=1768990412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I6BppJcC1cV2grbqUXketxfe+wsjxVNsUTvoFbnwvCY=;
        b=AMu/C8Dj+aT0SDDqq+/z4Bs+1vgFCEe47hRON4wgZJQtrEq/dhhjK/6C0hJR8xU+77
         QHIM4Jcx8VkMc3yGbaVL+rYgbIuGaY8jTZhbWAWtnEpE4XiFF4o2Yx+gpPWHkiLP/acD
         vf6LKeNupWJln3LBHq10sg+pXfiKUzJ0wB1tc=
X-Received: by 2002:a05:622a:5a1b:b0:501:4647:3883 with SMTP id d75a77b69052e-501481f9389mr28481481cf.23.1768385611838;
        Wed, 14 Jan 2026 02:13:31 -0800 (PST)
X-Received: by 2002:a05:620a:4143:b0:854:b9a1:b478 with SMTP id af79cd13be357-8c52fafd250mr293670785a.18.1768385252710;
        Wed, 14 Jan 2026 02:07:32 -0800 (PST)
Received: from sjs-sai-83-64.broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530aa87ecsm128946585a.24.2026.01.14.02.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 02:07:32 -0800 (PST)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	Siva Reddy Kallam <siva.kallam@broadcom.com>
Subject: [PATCH] RDMA: Add BNG_RE to rdma_driver_id definition
Date: Wed, 14 Jan 2026 10:07:28 +0000
Message-Id: <20260114100728.484834-1-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Define RDMA_DRIVER_BNG_RE in enum rdma_driver_id.

Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
---
 include/uapi/rdma/ib_user_ioctl_verbs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/rdma/ib_user_ioctl_verbs.h b/include/uapi/rdma/ib_user_ioctl_verbs.h
index 89e6a3f13191..b78bcc8cf3e7 100644
--- a/include/uapi/rdma/ib_user_ioctl_verbs.h
+++ b/include/uapi/rdma/ib_user_ioctl_verbs.h
@@ -256,6 +256,7 @@ enum rdma_driver_id {
 	RDMA_DRIVER_ERDMA,
 	RDMA_DRIVER_MANA,
 	RDMA_DRIVER_IONIC,
+	RDMA_DRIVER_BNG_RE,
 };
 
 enum ib_uverbs_gid_type {
-- 
2.25.1


