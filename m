Return-Path: <linux-rdma+bounces-10428-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8008CABCE00
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 05:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 053AD8A20E4
	for <lists+linux-rdma@lfdr.de>; Tue, 20 May 2025 03:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E856D2586CF;
	Tue, 20 May 2025 03:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T6a9jSA5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2531F238152
	for <linux-rdma@vger.kernel.org>; Tue, 20 May 2025 03:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747713308; cv=none; b=Wn4poKFsuH3qqvCVvpGn5rGXNUg74+/D+xDePVe/z39ggL2eBdgj86kS0/mm234iz53KBjeOztUlvc38g4YsX7gWFWBltF95jcnjlDsC53lQPaxyWLwQjjgIWZeZSpjXMnUUkH7Yy744ueYWqOGkr+bfDrNTIjWpElYvpS5NNNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747713308; c=relaxed/simple;
	bh=Bg1XRAf9vBL9odi5oO8rl4gAgcv5kDR/FJ3S8bOMybE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WmyIoVxF/LqzTO9+1dacBUgDqmWAnaTiWOzHVoA69UUIXC2taVE67vLPx+lhMeSnAp3N7Lki+R06dkrxgPBnlzdqj9t+9whli6FVHEoslggqe/Lg2BAu94QRmWjJPRe09iNFo9L6bQMQshLWL+5t3WKWsxCDHbxcO+v/+4Hnud0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T6a9jSA5; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7398d65476eso4086194b3a.1
        for <linux-rdma@vger.kernel.org>; Mon, 19 May 2025 20:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1747713306; x=1748318106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fx3z2JWGZwm21XNnF/q7Ki2EgIQYl3/ncAE5HyLZNHU=;
        b=T6a9jSA53wGOrFg8+ovylvo5fmmi+5tL2ckCLqBMbPrui7xQrBAAwp5fvX2TtW73Ev
         kc3GpD5S+3kgCbWjL00Ig3K5cu/t5q+9zHroX+3NNPHJllE976D9aOhX3kHcNgzuPnkH
         hxjIPC+GHBgSrgR3sxD4P+W4b5cWrFOvWXEao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747713306; x=1748318106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fx3z2JWGZwm21XNnF/q7Ki2EgIQYl3/ncAE5HyLZNHU=;
        b=fcQdCEKJE9FB5U6BGuc+jyyXb6ECOQeqU8xTGy/ve29DS+iqH7R/Pe2JWPHYFu6i+i
         4KpmaCFxMESQ8wI4Phv8bjUVFwWaIFsQPxW31z6ka6T2YQgeBl2R/pzSr/ecnz/aPiTT
         V1dBx5BhtwrnwWiON/S/lCNwGsoV8fgxnTOfnzCsPK7UK+JPIPrbWjWAwjUmDMgQPm73
         +UxWAF2zDDB44OzRY7qZuuocO7T2zeZgkjmu6rQ0kF+FQJhITjq0/UXOBiJ0o1I3r4rA
         TElZYGBCKYhESmNw4C8HBSLjamS2TCmqb5mWyvrp34jvEF7S0I5BplSyZJ/QUf2ch4/T
         b2rQ==
X-Gm-Message-State: AOJu0YxdSSRv7eRkNwh4BFT7rbmEoDcIaYFAQAofbK86nmLKJVQmHg+A
	1orFh3QzM/BUBAVgaddMJKP8oK2qyAzowcvejNWXrrhtgh6bQWnXbO0qGuT2BKScBA==
X-Gm-Gg: ASbGncultvxlz7iZW7oB1l1DwgK0ex26gjSAr8fnUUe1TZQsKQZtrogIcA9fEaxHcQK
	DDRS16TZhjxvuND3bDTufJtVIgVaStSrSVbufmDVHzx0lz4R6gypmsMXw8vsO9knquCfTG5yeVx
	RpKa1TlR7k2lAoKvEpVvF3VMYVz5UXF8zqcVb17VSXS/SRLhJ2XsWUDGlfGF+VAV7l+sbaTtkbt
	URJcXe7l8o62DMgRoskO+nC27vhOm+wylN+A+H819KHx6Wp6vSPi87IlPe+JVbaCvX4plTps/Qx
	smgFF4nneqYQutd/xuJ9GXy75FpKnHcxoe/QkRJLfsgRUvTU4hKDOf5Ao6ktjKPIoRstE60sYgC
	YeHgHuwcgfBSFKAe4bGiSHjhPx9o20KxtLA+Tkac3SqzmLabKW/RkkQ==
X-Google-Smtp-Source: AGHT+IHO+svdCIfU8WxG3uoXP0bDIDZLXe9+v3d5FhatBsseop4gI+J82YF4v1aIuwlL9EWnVMUbfg==
X-Received: by 2002:aa7:9a8c:0:b0:73b:ac3d:9d6b with SMTP id d2e1a72fcca58-742a9a282demr20356814b3a.4.1747713306232;
        Mon, 19 May 2025 20:55:06 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9877063sm6984179b3a.153.2025.05.19.20.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 20:55:05 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-rc 0/4] bnxt_re bug fixes
Date: Tue, 20 May 2025 09:29:06 +0530
Message-ID: <20250520035910.1061918-1-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains bug fixes related to debugfs
support in the driver. One fix is for preventing
a NULL pointer dereference in reset recovery path.

Please review and apply.

Regards,
Kalesh AP

Gautam R A (2):
  RDMA/bnxt_re: Fix incorrect display of inactivity_cp in debugfs output
  RDMA/bnxt_re: Fix missing error handling for tx_queue

Kalesh AP (2):
  RDMA/bnxt_re: Fix return code of bnxt_re_configure_cc
  RDMA/bnxt_re: Fix null pointer dereference in bnxt_re_suspend

 drivers/infiniband/hw/bnxt_re/debugfs.c | 20 +++++++++++++++-----
 drivers/infiniband/hw/bnxt_re/main.c    |  2 ++
 2 files changed, 17 insertions(+), 5 deletions(-)

-- 
2.43.5


