Return-Path: <linux-rdma+bounces-6639-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B860A9F73C0
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 05:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21EEB165AB7
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2024 04:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924AC2163B2;
	Thu, 19 Dec 2024 04:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5ZFIQHo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EBA78F4A;
	Thu, 19 Dec 2024 04:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734583199; cv=none; b=iKZaD8ed9eKMhw27CpYxr65Os1hf3MNIMFm0IvpLTO45gAyU89jUcwG55SE32QAkB0fqkP3iK6YGcWTZhmgQh8Jm1IQSom9xfdetGa6lxvH1kmtgqirVvKByi7fH2QUTvS49e4xdgd/Zv217yQ4aHi8QlnRSDapxZKc+X43oVBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734583199; c=relaxed/simple;
	bh=U3DDF1cAIJZt1lWGg01dDaOz4KZC9Pk0kmuOkb7W8nI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=asSukAckA2n5Ene2MimPaTK5Qsv4p+Y7yUP91A0SVd+be+/IzGnOqO6qcx2ZBuhmNBGl48B3ngHw9mRlk3cKo84D5vDsN8Y7V7WasRbfSx2+BLCl9lqeSzhdcdblA0H2vOdzv7Ro7/+sbvGJ9u6UTKZrt3PKDXd3dP0IpsbSNmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P5ZFIQHo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-216728b1836so3279465ad.0;
        Wed, 18 Dec 2024 20:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734583197; x=1735187997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aTko1nz8VtG7Y/HwxLJm5Wl2aZOrQdeVVTMmel3Sd4I=;
        b=P5ZFIQHoij6qN4xBp4KzbUO/OmngW7rHoZfJH8q8uuqcjZQkMyd7NP009YlrAtpgeG
         Q46uI9LuGjkxBWTs0BAg56RvA+W/kOg/TYc9ym6rGhsxDVdaQLD6NUJ6wKp0AMbu/X9U
         tBUROtisEWtF0kVgZKw0v4MKgXIWO7gwQYsYU5ylA60qDPjAEIIGTgvKl4asTkjOzTkr
         vBPWeMxLYjwJ+FCC8R7miF5KMlVDJUgvBdaFmuQX/90MYbFZ6TesWqLGBVP+Vowv1+d+
         82tjS6qHpKd/+A+62QpdIZrJEpcPDD7h7Y3Gm5bedH/XGNXdFsYzkRnD4g1koUyRfKAD
         Ssyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734583197; x=1735187997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aTko1nz8VtG7Y/HwxLJm5Wl2aZOrQdeVVTMmel3Sd4I=;
        b=I35AZ7MxKzzfHKsG1Vkd/2KYuSW202700r+o/wI6YfflBnRgF67SurLYmjtR5taXwn
         2I6V6XcW3gfIi2pduopPa5SWzIKwV/Mc/qRO5/vDkfoTL2aMrCqmTj7qbxkXSHRCOqFf
         46YuzxxsUtephfP/+y0EnJXPr6gS0RHtKvT/WvDVk9RsWgV6oRmlKJcI4aqNcxWhjLB5
         XXHHKiPwDxiFA0zLFgZUTXWTJscPvyKWIHkN+txF4YBtoP/U6jfVQMC2UPJrMdycF8WY
         n9mrczrJpgzWR4qHRKdLBwh46okpqKxXfhpIxAGO+5R1XBKIrd+WKDz7bc2o8TkCtVVm
         YWvg==
X-Forwarded-Encrypted: i=1; AJvYcCUVppOLeAFawmLTQMyRn28+TXMiNBAAM2NGf1fEj9FueZyfzLEQDRNoR9nz4oTPmhUTObulWADsN7mkBXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP3rlHgDymRqoIvTuA/PfmHzpEVj61ANzpz66+Inv+WmB2z07B
	xrIGFNswV014mI9Y7CXKSdMkz2H8QIw9VN0Kb//AxK6awvAmMgTn
X-Gm-Gg: ASbGncsiN5Yton8MMKQfNt9o8ALU3Pb0SMliCfXMDmwXqNW9PTJWDCooAW9mYFTkAP8
	NgWk7NyCFqQnWXPJeTkFYmDSdVkADUMgUyh7r2bpbx2jf7JIfCNfjSlOq3Dz6mKDTE7WhqgrrfJ
	4ygA8iu5QPKv2Bm1t1g23EAULiTCAwgr8XWejPJCNs5vu7v/0POwm4MEodytxhNVbZ++8G9kaaU
	Kd+DB/pk+sEvyXA1FnCLAAPHERmRb9hrvlAKCicJCgVbUbMs8DSO+fXLkImteUg/EOti8w=
X-Google-Smtp-Source: AGHT+IFIzB8Ym2D31dM1arLZLmbEoPqW0PheHXFq2/PeFpE6OO22LXuvXBj3VaXS1WtbquExUBNqFw==
X-Received: by 2002:a17:903:41c6:b0:216:725c:a11a with SMTP id d9443c01a7336-218d6fc3971mr65446955ad.10.1734583197146;
        Wed, 18 Dec 2024 20:39:57 -0800 (PST)
Received: from advait-kdeneon.. ([2405:201:1e:f1d5:a9b6:e0f8:2f5:27b0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cdeecsm3464215ad.123.2024.12.18.20.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 20:39:56 -0800 (PST)
From: Advait Dhamorikar <advaitdhamorikar@gmail.com>
To: Cheng Xu <chengyou@linux.alibaba.com>,
	Kai Shen <kaishen@linux.alibaba.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Advait Dhamorikar <advaitdhamorikar@gmail.com>
Subject: [PATCH-next] RDMA/erdma: Fix opcode conditional check
Date: Thu, 19 Dec 2024 10:09:39 +0530
Message-Id: <20241219043939.10344-1-advaitdhamorikar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix conditional if else check by checking with wr->opcode.
The indicated dead code may have performed some action; that
action will never occur as op is pre-assigned a different value.

Signed-off-by: Advait Dhamorikar <advaitdhamorikar@gmail.com>
---
 drivers/infiniband/hw/erdma/erdma_qp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/hw/erdma/erdma_qp.c
index 4dfb4272ad86..5c266918fb36 100644
--- a/drivers/infiniband/hw/erdma/erdma_qp.c
+++ b/drivers/infiniband/hw/erdma/erdma_qp.c
@@ -406,7 +406,7 @@ static void init_send_sqe_rc(struct erdma_qp *qp, struct erdma_send_sqe_rc *sqe,
 	if (wr->opcode == IB_WR_SEND_WITH_IMM) {
 		op = ERDMA_OP_SEND_WITH_IMM;
 		sqe->imm_data = wr->ex.imm_data;
-	} else if (op == IB_WR_SEND_WITH_INV) {
+	} else if (wr->opcode == IB_WR_SEND_WITH_INV) {
 		op = ERDMA_OP_SEND_WITH_INV;
 		sqe->invalid_stag = cpu_to_le32(wr->ex.invalidate_rkey);
 	}
-- 
2.34.1


