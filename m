Return-Path: <linux-rdma+bounces-8513-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6604CA5869E
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 18:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A112F166F1E
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 17:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23C51EF392;
	Sun,  9 Mar 2025 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyHKyj43"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5910D1EF37C;
	Sun,  9 Mar 2025 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741543076; cv=none; b=IwZ/s/myk48EoFEznbvLoZPzYS8sZlyHCt2YK+eUD4clF2IGMv9IDstC8mVe7R+F+yUVjNlePCyh1m7or5YryE+s5Ew8pNxl25LVouat6Jal9cMpYfXdk9sYJgeigVj8YFqNnycA0viKZfkTxHAqcfTF13GLkybezbcDlSVZYpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741543076; c=relaxed/simple;
	bh=IcDiQbjK7QkOUtwcahlljvJSSFMJ7nHeE1X6Y+ZDf/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c3WD/hcyYpv3TN+IG5esSLhZI7/gyDXQpxCR1P39Z6fce8BNsCpdNs9c36YT/JERNmiB59pxAEGSYZe85qyT51wR2g/WmSM1oYX0gMqNpg6T1xDZ3CP0QbIAq83uFsD3bNTlvaAyr+e/3fZPoOmWRhnsRGr8Rze7OOKrpMfnsOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyHKyj43; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22438c356c8so29971475ad.1;
        Sun, 09 Mar 2025 10:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741543074; x=1742147874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ShW+R2fg4UIDkgDliCZ19ugTtc1H63Gcayp71fy27U=;
        b=MyHKyj43uXGVB4Bi+RGt1D4cJ7ASY95xRWcAbziYKFf3084EQcwulfu1EVlws3k55z
         0urCLACm4g2aSkVlQYYGFVrYa0KoknyHkvlc/JAlkgFDgNj9wJn0TJ8N8+CvL6GI4M1F
         Ucyjmj7m0UI+1G3wv3PTnI5ZN1yuSz70scjk53IwKGCI3lLd2GhnAKGOVF/j1ahIBapm
         o9ieSd92fYTevp4ZNxJbMju6L0NLcGUke8LfrLCFaAt9VQ5hN7dfPSIKQq/2exeADXsO
         ljflwljHpmaMNjctrkGUeEeg9K9gfH3E4SHwpKqr8x7kx5ttUelF0FJAnKMlaUeyHiio
         MvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741543074; x=1742147874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ShW+R2fg4UIDkgDliCZ19ugTtc1H63Gcayp71fy27U=;
        b=o0lFBw45OXZZ/L3Kuc1xSP/Oy4BeT1EV/Y+HxWPReC4XOr2/UPjboXQuSnUKSFnmNb
         YiS9PkEJVJfkkhZGHaM3vQLib3J8CXYuXo0MXYOYIXQsOzjiOrmU4x7ObU7RAHIKX7nq
         /hEmUpb9Rp7eqn79ASmhFINk6vST7Dml2uSqNGatviooJfpnsESI3JRijQbEmM4hY5JT
         VU/7Hul4HYHdEZuxR6o4eUufRqE5YtpYWfNbT5zDnFoX+lwAPWbHVII6v5ekyiJyW9Yc
         1jmuvXc0RV4RcUmsz7mRPWx+Iv/eFlXMJbuVX9pMKLst7MhFv9LfC/eseA714yATzjWf
         dPYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlSjLlnymAfUm0TNQ5u4XECCoXHMlRoLj93PIe11irnOXMocdkE4kyVHKDpjYLz+/74xX1X6woquFR5+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YymOxdyB+zCrWUDDB6TS/YQnSC3sUpHfa/33JwMWJkwbm4dR6b+
	phRiHhFy6yVqlrUgCf2BkUnk8puAIG3RKGfvvHKi3GmB7q5msmDdRGgAqRBRAsM=
X-Gm-Gg: ASbGncsW3sH+x6LtRliQYKLfk940BBgAbzZ37aNOHj9A6f17Zb/LkM+sR8qrh60H6Ls
	G22rqR55XWwd46/6zE5XuoMfOexNxxgQ7vTFx8AAu8LTDzog2lro6z61cEKZ9r06XbW01VJvv+q
	3Vu6WjBcOkQf3bWVysNaru5jTuOTLtf33/WnhnajDwgB8/cOOk6y9Q64VK0WtkY1OGqP3lNEc5U
	cobDtmvcePdtGXRLPB/PwMZna7XYOXsAbSt62OFJ2jdxJy5vUcfdPo4avsaDDtg5LXoMhVF4AEr
	rfmARE3fS1MEZiZpWf+xRWbg77GZiqiKSE0MkDu2FAMjsPFiGg+0NFM=
X-Google-Smtp-Source: AGHT+IGBozFibCaSqkZ66LWvTrvLy45EL4JsTX508qnHiaChaQeNrguJ7G1t9sZHiCE9u0fIYS2xqg==
X-Received: by 2002:a05:6a00:4b4a:b0:736:339b:8296 with SMTP id d2e1a72fcca58-736aaabaedcmr18333823b3a.18.1741543074450;
        Sun, 09 Mar 2025 10:57:54 -0700 (PDT)
Received: from dev0.. ([49.43.168.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73698206989sm6713019b3a.21.2025.03.09.10.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 10:57:53 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abhinav Jain <jain.abhinav177@gmail.com>
Subject: [PATCH] RDMA/core: Publish node GUID with the uevent for ib_device
Date: Sun,  9 Mar 2025 17:57:31 +0000
Message-Id: <20250309175731.7185-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per the comment, modify ib_device_uevent to publish the node
GUID alongside device name, upon device state change.

Have compiled the file manually to ensure that it builds. Do not have
a readily available IB hardware to test. Confirmed with checkpatch
that the patch has no errors/warnings.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---
 drivers/infiniband/core/device.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 0ded91f056f3..1812038f1a91 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -499,12 +499,17 @@ static void ib_device_release(struct device *device)
 static int ib_device_uevent(const struct device *device,
 			    struct kobj_uevent_env *env)
 {
-	if (add_uevent_var(env, "NAME=%s", dev_name(device)))
+	const struct ib_device *dev =
+		container_of(device, struct ib_device, dev);
+
+	if (add_uevent_var(env, "NAME=%s", dev_name(&dev->dev)))
 		return -ENOMEM;
 
-	/*
-	 * It would be nice to pass the node GUID with the event...
-	 */
+	__be64 node_guid_be = dev->node_guid;
+	u64 node_guid = be64_to_cpu(node_guid_be);
+
+	if (add_uevent_var(env, "NODE_GUID=0x%llx", node_guid))
+		return -ENOMEM;
 
 	return 0;
 }
-- 
2.34.1


