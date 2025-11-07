Return-Path: <linux-rdma+bounces-14293-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29000C3E698
	for <lists+linux-rdma@lfdr.de>; Fri, 07 Nov 2025 05:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F01B64E2E94
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Nov 2025 04:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9DF286430;
	Fri,  7 Nov 2025 04:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFlwnPFC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8625C1991D2
	for <linux-rdma@vger.kernel.org>; Fri,  7 Nov 2025 04:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762488683; cv=none; b=sfy8REtgItdkmCtumuIbAtPtZ1OycmVg8SOjILOgEiCa4xEC2XvtUv/9E2bhpJQXWYr+yEKfJ+EvMhUeJgQ4f73TnPuqfU3rCAuNILH5VvkDkIFgcaz3vr6wJi2lvsAbtE+skXhEjRpM7J6mmaTg0B0k7fwz860AxwNfuoq22dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762488683; c=relaxed/simple;
	bh=4Zk8MXXmDdkOu+U1cEM8A5GphCzC0fyVF7jnwu8pbKE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hFa7scmvbgj5dOcTQyVGwGl6PGjcYv7V5FNeqBYOHH9Jx6PpmkpDXyw5tUtIILruab5niYZux5/BXUnP7QZzgZ0T6ixvota5QBSx3SM5T3iBAhyGIQZ2b2eVLxfdTe8CiZwRIMvKTN/0MwfyEJ15By6/gOPiOzUnyB7Q44z4+uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFlwnPFC; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7a4c202a30aso263316b3a.2
        for <linux-rdma@vger.kernel.org>; Thu, 06 Nov 2025 20:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762488682; x=1763093482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UB1bXzlzFcUbuTT9ZaXIDznGKcuL53MySKJi6hY373E=;
        b=BFlwnPFCfWpHAefcmfDFQCZSfkKhL6HEXSxhCM6yEP0ZyCH1D/9lJxi9nn6HqA3trM
         HS783KCxnHZGzc7XTGOXag9Qkvor4MJklnZwUGfOcw04HEiVtRPvHv1blIOR69RY2HjW
         Hrd/dUyWLZqruRWuiqfVoXlYvFXvvp1jNjJc2Yx4paYcEVF/5K359v8HQPREXKCGpebl
         OCG44XnvJTvhvldL2WOzFpGHZKfJbg0KLQR6+rFQDFtD2oEDsNzHyb2pLRLQINNI2MYu
         +P5NYSmC0QAQlgRHwdYEgEtezn86rkth3RqJpcnYFdT2IBhGsAaZQsT3ICEENySUjsQN
         YoSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762488682; x=1763093482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UB1bXzlzFcUbuTT9ZaXIDznGKcuL53MySKJi6hY373E=;
        b=V+LFQwkc98LfVW6Zhg/ir87Qd/prWtqia/GAMgmFdxoxgWufl224dmnzfvj8djZrD7
         82CNruas1ZMpm9k6YC0u8lfskmCDBJs9APbYutHyxJ0USoa4UFA4g+KXAOHUBVdQnN9+
         ImD+Q6qBpathGf83s1sI/6ysQGg8xFn2roUJtcsthwK+HnY9LgFlN7pshqrG6JBITHia
         OOQ56opUT7vdM0oZ95npCMSYRK52pfo6rCdXw8GiyfCV6J8px5U3GqrG1hQU4HDjn/PD
         /iAXldhF3SBjkOYIGdrbqFPpeQyVDR8Io3MbFWRhcyVBriZVu7SH7Xh42lzxzmqRw8bg
         mqKQ==
X-Gm-Message-State: AOJu0Yw82kUl5Q1Yj2sP1gCs3FjUq9hqwZzBdL3mMrHiUSOW/PG8xHZB
	BAaYNNADJ9fQNfT0MCI2KcNfo5KwMBkd2od4lb9OdhIYk19btj/LwFwF
X-Gm-Gg: ASbGncsjkpw3jt/oEhYsGYN2olBklfKKTULQWcvEw3xvqrbse1lFgfshsI6wdn6aXBv
	SAwHL7NIKaxpN6inq5AKxHXvgRFFnLrkItojkRK1+aCU0U8NVoJlfJWYy/3GswAHLUHwnMuw8U4
	O+M4RJRiV8wanj2X80kTxtzzcKcODGVfvZPd7cZ4zPcuVBpdh9127m3WEq9Krda0q0ke5WXu7bp
	n/VVOcM3lNVZ0KxMqVw7Kvi1AuNFJ5KgIpEgQ02Sv43Gwyq2YzvtRng3eJPtfUQi9OQoFWdI5NI
	G08TAu75UrgMGS3Lp9BSv5iON5AUa931Blv4ynpjVPHijS1SEkQL01M32CFEB2GQqyIYzbAGCrG
	cgZj1sz1xzGFoKZYuxnyuCx+N7eBHjT9DlcBHqdILOfIl+XGrK/1W0icPDG1RmqJcj0J7/qBFIl
	h0c3GO2YrKaFjP6Bhm
X-Google-Smtp-Source: AGHT+IFTBdtjUvs97i0n6PZZPCRYPFFLtE+1ia2eL7OO1k3lvWBqZorflY6YekXtzcFlMjotdUuR/A==
X-Received: by 2002:a05:6a00:896:b0:7ab:75fc:f8bc with SMTP id d2e1a72fcca58-7b0bb81fc9amr2493970b3a.1.1762488681758;
        Thu, 06 Nov 2025 20:11:21 -0800 (PST)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9c08ee9sm1289384b3a.21.2025.11.06.20.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 20:11:21 -0800 (PST)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
Subject: [PATCH] RDMA/core: Fix uninitialized gid in ib_nl_process_good_ip_rsep()
Date: Fri,  7 Nov 2025 04:10:02 +0000
Message-Id: <20251107041002.2091584-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KMSAN reported a use of uninitialized memory in hex_byte_pack()
via ip6_string() when printing %pI6 from ib_nl_handle_ip_res_resp().
If the LS_NLA_TYPE_DGID attribute is missing, 'gid' remains
uninitialized before being used in pr_info(), leading to a
KMSAN uninit-value report.

Reported-by: syzbot+938fcd548c303fe33c1a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=938fcd548c303fe33c1a
Fixes: ae43f8286730 ("IB/core: Add IP to GID netlink offload")
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 drivers/infiniband/core/addr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 61596cda2b65..4c602fcae12f 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -99,7 +99,7 @@ static inline bool ib_nl_is_good_ip_resp(const struct nlmsghdr *nlh)
 static void ib_nl_process_good_ip_rsep(const struct nlmsghdr *nlh)
 {
 	const struct nlattr *head, *curr;
-	union ib_gid gid;
+	union ib_gid gid = {};
 	struct addr_req *req;
 	int len, rem;
 	int found = 0;
-- 
2.34.1


