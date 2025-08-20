Return-Path: <linux-rdma+bounces-12845-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5770BB2E48A
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 19:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5DFEA26F76
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Aug 2025 17:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CA72765E1;
	Wed, 20 Aug 2025 17:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlCEfWwV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACEA280308;
	Wed, 20 Aug 2025 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755712599; cv=none; b=Arf5NkiItf+0xL1vTbwcn6wiuXbhaHL755A8GL4vpNQ6obW6lALbvbGk8RLPLw7n3kJGrbpnQGdAh/GcclpRAa2iR2Do5oaWROUGEOmuzCBI5QSUCRVshDIE3rbdcySulgOZ2Wp3h8PhyrM5zS95bRZ5WsmKRddb7jR65CIufaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755712599; c=relaxed/simple;
	bh=lLfmta+h4SkyENDhCMnpdr51VJu3AKvH01fLUD8umjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lIWIhf1YKpQnCJ2ijKwFr4S5q5/4R2wgq0+MAajD3ahBgSAbS9P8MbtpJ0GSIwFlxIJ2ZDBOmO62QZbpkJCsHLNeojkQfFd1ju8OaP26MH31cKoscaikfHGmV79gqj3IkLUakXOPEH64w5tB29GHs0aSPnoO8pOS47o0WX9HPsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlCEfWwV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-244580523a0so1281515ad.1;
        Wed, 20 Aug 2025 10:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755712597; x=1756317397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H+38vPXKcE2XwH0KgIp2x58rU9vDQLzRiLzmYeUQXBI=;
        b=QlCEfWwV++Oz0XpjNI5BhGkCyyWDx+gjVjcahTt018CN4ASsiUgKf+8422U9Ey2t8f
         wawhCj0Z3chx/82zEQh3QEcJLUMlHxtsXuJN4oMBw7c8H+vRgibI718aNJsLkYCfcDdS
         lJyUt6VIJywwOMs7o+yTG2uUHKyMnMVs8ZQDO0u8rfDIi9J5P1j477hgF2XD9YrZBoB5
         EgBSZMmt9YESS7aKFDjbxjZ52NEZtLY7PLD4e+B8NXGsRrYYT2nXiG6zY2M23x7JWiOj
         rAKLjm2Q5e9jCoogSgUCHAI+QlEukxQ3V/b08sixe9Y28pzbVizVm7uvEBelIDizW6/e
         ysRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755712597; x=1756317397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+38vPXKcE2XwH0KgIp2x58rU9vDQLzRiLzmYeUQXBI=;
        b=d0DZuJDYnqMQzbOqDYgR+E2Kov7h/2eBlTZHKIpBypMKd28440nqKgEnvXszfqaVwC
         LrgdQP12KsWkJlzplpAKO4dDN9Y2QnNAO25ingZgPPQvbhDJO3nFT0oStkOdSa3DaYim
         VSrGDVD9WwCz3gMFbj4HikyrITDvrupeMZoBnx33ZqWv/jskb4YkXCLwwIy34LIcAIeu
         Y4F6d/nFmIfRCBdcoIjXWFF18REZwi+8Fuk/+7p/kNtxVwbpszmReowcj92Q2us1cMEd
         YHetF4olO9ra5Wvh5u+UwOS9IBTFytF28sdVnuA1gPG1A1rBIt2e9TvAoVmrLHaLIxG2
         g8kQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9tYjS+YgvVqd39JQd3uGLCGBuQgwsyo2GLQIjXrEaAsDsN67xFNz62aqcXPQOwnWfU9KUYNrwTdDGbbY=@vger.kernel.org, AJvYcCWH+jAXAsMhwnYlwZEZNg42IwqRXw3PeDD6kgc5oMO9mT5r7Y+lbzSFUvfVQ94CZUzoLU8Sc9HHQ3X1Hw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYEQ28sHDJr8CZAdbeVzplnFBJvUqO+eL5O+Ouj5p3kSdGlzIB
	yoQau1Kj9FFOx9+vXPaG2Jd2CULTtB0q+c/HuOzPvo5+NczrCeQTra8=
X-Gm-Gg: ASbGnctqrXajTHSjwfFR4WBt+Njkrov3Vj+Xo458CNrVBOxcTmZxO/+mJB4mPG0LP0U
	bF8X2gr3awa1ZQexFnHhEfkdIumBIVu24BusYAVEYAY3IfSbnZ4BVlMAza1KQYFfRJCH79czSWv
	In8nfXLUY3glg0v8CPi+po5rjVb3dz0oMCtLqx8/5ViPW4m1td2waz+U3DDIXpoPow32VFa2unC
	XUYa08Jn7k2cLzCbWbu09T1D/xMTf0SfGoz6cLCmYhKURxXsq/LiV5RBKIJk8mXDFgBVL1cBxuo
	/kPyr5GmSAdlYCb+K0OGTOqEf24dfF69pK7JxDvBVotqoxpU9cWfkLoY7O0Jcb4hXl5g8tRds9J
	UFkbJmh0XuKxED1Xs3vuq5YdD3q0FkoZZ
X-Google-Smtp-Source: AGHT+IGOFAhBd7MGUiftUnl9fbiq5WDVmusdQ49YdOIXSr9FdK2a+VkS31ZeJvULUj4TqUOJvUU3zw==
X-Received: by 2002:a17:902:e80b:b0:237:e696:3d56 with SMTP id d9443c01a7336-245ef22f57amr59998195ad.32.1755712597270;
        Wed, 20 Aug 2025 10:56:37 -0700 (PDT)
Received: from debian.ujwal.com ([223.185.130.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4ccaa9sm32553815ad.86.2025.08.20.10.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 10:56:36 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/4] rds: Replace POLLERR with EPOLLERR
Date: Wed, 20 Aug 2025 23:25:47 +0530
Message-Id: <20250820175550.498-2-ujwal.kundur@gmail.com>
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

Both constants are 1<<3, but EPOLLERR uses the correct annotations.

Flagged by Sparse.

Signed-off-by: Ujwal Kundur <ujwal.kundur@gmail.com>
---
 net/rds/af_rds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index 086a13170e09..4a7217fbeab6 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -242,7 +242,7 @@ static __poll_t rds_poll(struct file *file, struct socket *sock,
 	if (rs->rs_snd_bytes < rds_sk_sndbuf(rs))
 		mask |= (EPOLLOUT | EPOLLWRNORM);
 	if (sk->sk_err || !skb_queue_empty(&sk->sk_error_queue))
-		mask |= POLLERR;
+		mask |= EPOLLERR;
 	read_unlock_irqrestore(&rs->rs_recv_lock, flags);
 
 	/* clear state any time we wake a seen-congested socket */
-- 
2.30.2


