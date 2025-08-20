Return-Path: <linux-rdma+bounces-12846-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF27B2E486
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 19:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1066A7BD539
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 17:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83397277C9B;
	Wed, 20 Aug 2025 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QPuvGeFZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BC7277038;
	Wed, 20 Aug 2025 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755712606; cv=none; b=RlTpfGSf/izRgySxA8StwEfzpHnLgPelnsC2W6GIkRYaMMA/gV+j2/yfZ70xFbR8CqFsBUYn0TD41VosZ1q5aFSHUmkC45pBBg9FHxAe6Mlr1lT/br7fSvW2UX0I96ddNCU2HPxCpNbVDjP6773YhYZNPxKqLAWSBkYEfQJbQ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755712606; c=relaxed/simple;
	bh=/0gzM+3hdedGfBPxBtBaiKUwTX9q1lzp1I1KRqZW8+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ogsSn/VElfu99PCu0/HXx/5JzmNeR2ScSpa4bBD8q9gSQYjZe+SEW1LvT9OY/NMDQ89ctUZ2eweR0H54sOiexG29mr1ZGzzYnGIWE1tVSHZOc3GC5UiStaVNe6TzjCupITIeoZdbghANqX/Uob8qIRDEs09Gf0SVejqCQnkzqWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QPuvGeFZ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24458195495so724805ad.2;
        Wed, 20 Aug 2025 10:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755712604; x=1756317404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGLb0vaI51LWFzVBHuMu+Aqd/KzmZTAIpd9FpNIGaCw=;
        b=QPuvGeFZEbOe4sQxozPYoEtqAOxuz/3IAR7CgEvglrLTaE9EzWqBBcTx+daDdToW9o
         /k29qr3h+ZTHxYJ34XsRDlxqk8wkIJodmEw6w4dT8MviYhkIZb5hfJmU9O9rFybCHSmG
         g/neDS5+XcQDiENfVeliDTY54j2EluJ8bSwdtqhlcVJ9WKd/NB2zuyKQb9UhfQ5aiytI
         4g4Srxrn89KMZIyZQHict6DoUj9I8mcvlMYKsbwPPjNo4i6m5A5774qa0pi69U4t3mLt
         eXYXAnfGsbyYKWnpE3IUlcSNIIfkugFnMDk90w5CNUduBWw6qXQjsUgmHbTM7CQXbTrv
         pMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755712604; x=1756317404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGLb0vaI51LWFzVBHuMu+Aqd/KzmZTAIpd9FpNIGaCw=;
        b=mREiixgBh+T4rEwSofv531ZaHNxCx/3eNrBa0zX7Jz+kWTp+XkV6mXnoj8yo/DJt5d
         kSzMH8mBUwkgl7CBo26uFrAOaCB/16SLhPxfQYUv2AHmvNpKXm5QKC95e1XwHBVmRDgR
         3DeHsxqTfJ+dHgbw7izLwR6A6INm0C+7x+PdFnQnLypeFdj/ztIU2/B5gbabVwtWnIwI
         qCdj+QOiPVOPbx+2OkCvef7Qs2RT+3oxonqy5KYKufkEAaiOog16DFgM3iORXT89E0/H
         RlhedQT/xNWDipB1zu4v2MWS9ZH5r44Z6aiNRkI/dbPxwvVCxbcGaPBJcfkMbrnX2Kt+
         A0ug==
X-Forwarded-Encrypted: i=1; AJvYcCVbzzsEt44x9GYCO/uwMa1JhD1XC8HKMwy3xYiFvwywomGdRQe0rEnktEjacmm6krGNpnqIdFpY4jd2MHE=@vger.kernel.org, AJvYcCXVxj+GcFkMBua8GLtzFZtkoijG9UItVb7VDElYBm8vKzpCXnuze261xUJ/LZGMdpDELBuGqZXHqqlj+g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbsyEfbQC3V4Ah0JhjnId6H1kAN+hH5Z+HyumyUk1E/n4tBTHW
	ySSbeYEN6IAjKXsmrYjcQNn/lTBSx+L2jKzxKbJ0ibLMc1d98gMRBh0=
X-Gm-Gg: ASbGnct8YEr1UsYmvqyuF5zDvDeKjT7s49dOD8uu465zqkGAdFBCfy2xHx8gRY8TK3Y
	17CODtxTNFPHadiU4u6Xlaq1B1h1I/CNIs7lPZrK+MKFVmlkSp9Up0HLzuDRYZ8Em1NabIJbq6b
	HA9QNxL2U7YKlUHdkZ9Ltf7gapx/QisjwsG/uewBM9rR9F2fUgqRlOPqxIG+3S49o38OV0zNyzh
	UqCq5KQdE82kCdzgJLOVTX4fE6Mk66AGvRlHzQRWit29TkHcqa0mPPIbe77NGa1RoHyLROxBCUd
	ZU0ddrQ+1NbbHAySENc0qGIrNJDOUMWhN4Bx5ieuJ1PCXZPVGq4mRq8fPt9PCWkV8EgsiS1M/4B
	4IpGKeWJKr/8biKV0sm3NQBygX4iRoKCaxiU/m1fzbXE=
X-Google-Smtp-Source: AGHT+IGPtz2x4V8T24dPaoqPFFBquGmZtrJlTAYRsxhSzc2q+oMKFmBMq/AEpCOimnGu2SqlqkG7cA==
X-Received: by 2002:a17:902:ef45:b0:245:fbf8:dd0b with SMTP id d9443c01a7336-245fbf8ddefmr8250265ad.57.1755712604073;
        Wed, 20 Aug 2025 10:56:44 -0700 (PDT)
Received: from debian.ujwal.com ([223.185.130.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4ccaa9sm32553815ad.86.2025.08.20.10.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 10:56:43 -0700 (PDT)
From: Ujwal Kundur <ujwal.kundur@gmail.com>
To: allison.henderson@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	Ujwal Kundur <ujwal.kundur@gmail.com>
Subject: [PATCH net-next v2 2/4] rds: Fix endianness annotation of jhash wrappers
Date: Wed, 20 Aug 2025 23:25:48 +0530
Message-Id: <20250820175550.498-3-ujwal.kundur@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250820175550.498-1-ujwal.kundur@gmail.com>
References: <20250820175550.498-1-ujwal.kundur@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__ipv6_addr_jhash (wrapper around jhash2()) and __inet_ehashfn (wrapper
around jhash_3words()) work with u32 (host endian) values but accept big
endian inputs. Declare the local variables as big endian to avoid
unnecessary casts.

Flagged by Sparse.

Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>
---
 net/rds/connection.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index d62f486ab29f..ba6fb87647ac 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -57,16 +57,17 @@ static struct hlist_head *rds_conn_bucket(const struct in6_addr *laddr,
 	static u32 rds6_hash_secret __read_mostly;
 	static u32 rds_hash_secret __read_mostly;
 
-	u32 lhash, fhash, hash;
+	u32 hash;
+	__be32 lhash, fhash;
 
 	net_get_random_once(&rds_hash_secret, sizeof(rds_hash_secret));
 	net_get_random_once(&rds6_hash_secret, sizeof(rds6_hash_secret));
 
-	lhash = (__force u32)laddr->s6_addr32[3];
+	lhash = laddr->s6_addr32[3];
 #if IS_ENABLED(CONFIG_IPV6)
-	fhash = __ipv6_addr_jhash(faddr, rds6_hash_secret);
+	fhash = (__force __be32)__ipv6_addr_jhash(faddr, rds6_hash_secret);
 #else
-	fhash = (__force u32)faddr->s6_addr32[3];
+	fhash = faddr->s6_addr32[3];
 #endif
 	hash = __inet_ehashfn(lhash, 0, fhash, 0, rds_hash_secret);
 
-- 
2.30.2


