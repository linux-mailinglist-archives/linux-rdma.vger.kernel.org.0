Return-Path: <linux-rdma+bounces-12254-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A63CB08BA6
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 13:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AEB258591C
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 11:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B321329AB11;
	Thu, 17 Jul 2025 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKPTalwU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C0B29AAEF;
	Thu, 17 Jul 2025 11:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752751302; cv=none; b=JhtLwQZKoNBxuy4LFk3PjKu5icaEF4dR+BN3CupxkLPhSDSp3CF5+GSHY2vgw0FbhTpehPeYPCOgOeoPorHVtxtRmSoXGiBC2CMHDlm5vo9oVke3HSBC9hVz/iDrCLHivDAc9dB3zAwQ9CgEbWmJMi6AemcqDYc2id7oYwbmmJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752751302; c=relaxed/simple;
	bh=uNNznCHaRYPa6z9ckg/J1qp4DmjrTdqGCQFEu2dpFEM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KizQsyoXhjSy2AINLLus+qkxufGTJjsQWGOo6N1Ycba7tKzc5kGqa9sww6uPFUvbjcBGCfLeNPa0OdPk+jNzVMBT5pzj+TS61N2B1FEPcA4HHfvC5t9YGlXDGrqg6N+yjkwk46Voh+iSpyhzIiq+m+Rac3y+kaehNffGf6DLmAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKPTalwU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45629703011so6162995e9.0;
        Thu, 17 Jul 2025 04:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752751299; x=1753356099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6eoKHYqrCMjRD+TGXC5ab0tIcocXYRaE5P3oQBVLSeQ=;
        b=MKPTalwUwaWUxVaBK2u+d6rvG9QnfBP72FAYiydZa0167O2AUJHnOh2nBOtJvFkbMM
         DfYd0IBP7da3vVDs/mjaeL+P2tWnoI2/CfUy9gertdlLv5R82FFRBmFXcOOzWVkAgxUg
         G5UZJkJ3va7Dx3jTxWfQnE1ikhG/KI596VXe5AAm4y6foRLgY1LH4NxwI+VT1LcKhpE7
         V61+0eY/0gQJuZTYLpK6xw55su69GSDfcsSjapGz5EGlkE3uU3u06J3Nsw+UNZoXzmDq
         yjJ/PH5f/r1dRi9ZAiVTM0efJ+1reB37c8W6SKABctU1fKvILGjzsscoX6O90HE/olA6
         7WlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752751299; x=1753356099;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6eoKHYqrCMjRD+TGXC5ab0tIcocXYRaE5P3oQBVLSeQ=;
        b=xPfIhbudJzSXGNNccXKdSPslxMsCTpWuXnqvY4fVurgmYtrKLaMhYC74yDqMKDKhQJ
         FddjpOVQPlwqAMLhek4kYJlVCHSI6aEEi3gUb9anCNfdIuBgN+k7tLSdWhXRaN/AteLY
         RSA5jZ3CdhQ9WThqiTgJmCDSQS3h6y4HI4ptqZ9qLBRUzxYfouFF/KHu3jMqhGB+3h92
         c4GUSOL5n3Xk/CAEFrmsy+5Iwiuy6fvur8PrhlQD/tPQr4Z+hJI4I+m5t7WFuGHBlfJD
         73MZGUerLMvNhLt4BH+EJbxdcOwhtrIty7hcDO4+ocYz8jt6lDTCXWw2D3I9E3bfELh3
         5F+A==
X-Forwarded-Encrypted: i=1; AJvYcCWPvcOIkFLY9sNnn/GFDLpAT4VMzr3NiNuAY0TDW31XI+zawBIlxH4j0e5VNGvRGFtMCYYcbuSGh86c4A==@vger.kernel.org, AJvYcCXDrjq14egQGo2JjQISvGWj/rNr4Xa9qlLSsrCz8KfboqfntC644hSnmSma/+Cn8WbHTPmjTDEw7HCpb+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQhIBQgi9v53Qv506xsN+oIFA/+P85RKYU3lI50KsVGD2eFXQb
	zHoef1CWxwKLeejE5fdpiB9rC1WWwFBMdRysud9kigJbLBF7wOfn7wEf
X-Gm-Gg: ASbGncsnxdZQvQc2aJXXcTqQrhDOkdyAuSGPd6I/sFmWOErCabpbYVdDlMpi6uJkg3/
	QEpnz4MkV7XYjrPGTaZjuPUMYYTg19cliBVArClfPjOskIL87kbJcVKH4hNzj61fmKWMG8nHoQV
	+Do724ZkJcxCMI6DNCqHnZCsgNJA2+OMqpoflitBN21yXfFUJSbNDqniek7g4kotQozPMin7LH3
	7u5p9YfUxEcVLSBrpro7uD+G2clqKXann3gZwQvIfAuXy+S/QVcb6AW5mSeEM7FzG0c+lR0sozS
	3DxMV55ApNREkjv8PiGLdvJ6vqj0afxK9M2Ras8a9HcgvlT8OX31fGcAKbp+BRL+66M96txH2Cq
	5Kev7SQvk63GbQ4jYk2GN
X-Google-Smtp-Source: AGHT+IE6/9C532kVHj8pqjuvwRwAQMgHAT+7XlkS/1Ij8Hzgv32arrvQu6O8oEwkhIDBGucY9Cwngg==
X-Received: by 2002:a05:600c:1d03:b0:442:f4a3:b5f2 with SMTP id 5b1f17b1804b1-4562f7c7596mr48583775e9.6.1752751298778;
        Thu, 17 Jul 2025 04:21:38 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4562e886286sm48874615e9.26.2025.07.17.04.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 04:21:38 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] RDMA/mlx5: remove redundant check on err on return expression
Date: Thu, 17 Jul 2025 12:21:08 +0100
Message-ID: <20250717112108.4036171-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Currently all paths that set err and then check it for an error
perform immediate returns, hence err always zero at the end of
the function _mlx5r_umr_zap_mkey.  The return expression
err ? err : nblocks has a redundant check on the err since err
is always zero, so just return nblocks instead.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/infiniband/hw/mlx5/umr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index b097d8839cad..fa5c4ea685b9 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -1050,7 +1050,7 @@ static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
 		}
 	}
 
-	return err ? err : nblocks;
+	return nblocks;
 }
 
 /**
-- 
2.50.0


