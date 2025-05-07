Return-Path: <linux-rdma+bounces-10118-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6110CAAE092
	for <lists+linux-rdma@lfdr.de>; Wed,  7 May 2025 15:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D744D16B75A
	for <lists+linux-rdma@lfdr.de>; Wed,  7 May 2025 13:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3F3288CA6;
	Wed,  7 May 2025 13:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVOcGfWy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12122820D2;
	Wed,  7 May 2025 13:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623930; cv=none; b=Ar3sXRkon5ae6pAacoMLJwq236oobHm9FSNla9MrJnvlfhhZFUQLy04/zOmKGndN1QCj8XgVV8mUVT2vkBg1kdIlLGzfa83VDMDiDj88RJLfEBBcgAgpc2pbYsV32NsysoVyfmR9r3efoTc0t7lI+al/YCzF5+i5Ls3b7po3LvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623930; c=relaxed/simple;
	bh=5R0F1GGFzfTgOH/FF+ArtieoiEis+zmCQJM6z0vvjBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=imoPlvWBfc7DnhiIAyaR7kJkPvXqw0UD8C5OV583ELzbbqkf3cGechOERPIhLxMBhN14wpcKgg34Hkz3Qo50voh7b9jWjBFcdGWF60liylWjXp8Qczb/P984BTzHFvWLB7Or1oAoVcBIoMVRj8sG5i7uqfQrG8oNAgcD8L8BkDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVOcGfWy; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ad1a87d93f7so657176966b.0;
        Wed, 07 May 2025 06:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746623927; x=1747228727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XG4gYw/os44VieuMBGo0LazKtq45QTUEHPt6CBsKz9g=;
        b=TVOcGfWyE0k4UBl7fmRifZJoTRLFqxkDDqt2/X/Pnnqo5lcKPm/ZMysdv4VP7+BQUw
         AisQkCyUwMBT4JYFIFNFjIyfQ/kTDdIUYBvDwGM3B+VJcX+bDzEXrmNleu9gUcRUqtLW
         Rv50Q3rftb935wwIsC+o87035EHoETj4mj22yjUjzIiX5+GVwo8s3Yy+kEhHY50nhivm
         U4QqxCFCh0WSi6c03tSakNsfNOUJtFSArB3J/t2Hs4Qbnr/+mB4mevX6FByPLQhTsyxq
         MFZf6s9RbiBif8JRC2meB996THFLF6fqQFcGscx6+uOUt5Xq24udjXuH9UXymegOY3Rw
         Iq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746623927; x=1747228727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XG4gYw/os44VieuMBGo0LazKtq45QTUEHPt6CBsKz9g=;
        b=k6zeT1JccjMhHS0tABhxY7Bq7a6F1tDA+fyL6hnqGcwDp6/ZKdH692JqrI4xUTJcVt
         RacW/hHcepVOLrTUV7Dqd4dJzpN3GFe3yFS+YJNJS0FICWkhZUPTnLCuj3HP/1fTJjvc
         BrpVWakCV+eKQ1GOe3ZL4fwN4fSBif1CkXkIQ1zgSB4VH/Qgtp+sqwnkqMidk6uaIt8z
         2qxnoYJ1WbzYPK0a0r5hfDV89viSpUujLz5gGRtMeIblG9wz2krmWXyCHHnqREwPZowO
         xZuV7RNml3LhsGhzpnjI0JJcswAilS41SVYPFFnAEK25B767UzpT0CUKFR/uG9Xu0MUg
         tuKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQVAOQfuDYzwLj6lIpkYEcRo15fRuDs++fzX382ziZwY/jWjuhvBiTDsGdwvOBlP3ossmP1OHUTlCVgw==@vger.kernel.org, AJvYcCWbzuFK4QRZxRQicKidaBHYpRtNHergd2NArg5uFtXXA8DQr2Ot2lLcIu9072nvwIszSBTXuQ1LHKZy6Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu46zsl+XNaMGQ+lRwqVxhpjqsqfUHgVVLQhtK1rMUloTg/48W
	PIRRUQLFtdWXQQS19+G79PHJEMIg97icEL2ZBdV58bXxJHKDQMD6a8RCOtsCWZFMRg==
X-Gm-Gg: ASbGncsILlsNNzCXqvmiyp6orN4nglUI0atsC7pamv1O0bxCz67ON9GoSIwFAnvEFeM
	MGqBE/zLqFjfrAL5LG40TkiTTAmyWhvebi3KCdd2rr2m5gDrT8TzdgivWuSDDU77S+qZ3VLiOvo
	QqtQrAS9NUI6KiO5LERYTH4ljEtBFY9gFC/LlMMsGcQLmW5ITdZhvucIvB3uL8YP5o7uj1Btbbp
	6ZNiPsSpJ969G/ZOomB2rVc0j/an3dr+B82JbEpZKZsIWQvv16PDrWVUXRwU3cMCNt9bZGg9YLy
	CMdLQ3oqMfk77c91C3bpYJ3Mz++OC7zyqDb6P9Y=
X-Google-Smtp-Source: AGHT+IGb2mTqtTr9/4na4ydOpBoJ20121LDJwcMxvmIv8RwYC/nsRM+pfVB6P8wstG0+WES23PVlCQ==
X-Received: by 2002:a17:907:7fa7:b0:ac2:88d5:770b with SMTP id a640c23a62f3a-ad1e8c91ed4mr378798366b.25.1746623926666;
        Wed, 07 May 2025 06:18:46 -0700 (PDT)
Received: from localhost ([87.254.1.131])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ad189147375sm908159366b.12.2025.05.07.06.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:18:46 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Bernard Metzler <bmt@zurich.ibm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] RDMA/siw: replace redundant ternary operator with just rv
Date: Wed,  7 May 2025 14:18:34 +0100
Message-ID: <20250507131834.253823-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The use of the ternary operator on rv is redundant, rv is
either the initialized value of 0 or a negative error return
code, so it can never be greater than zero, and hence the
zero assignment in ternary operator is redundant. Just return
rv instead.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/infiniband/sw/siw/siw_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 7ce0035c54fa..2b2a7b8e93b0 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -1102,7 +1102,7 @@ int siw_post_receive(struct ib_qp *base_qp, const struct ib_recv_wr *wr,
 		siw_dbg_qp(qp, "error %d\n", rv);
 		*bad_wr = wr;
 	}
-	return rv > 0 ? 0 : rv;
+	return rv;
 }
 
 int siw_destroy_cq(struct ib_cq *base_cq, struct ib_udata *udata)
-- 
2.49.0


