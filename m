Return-Path: <linux-rdma+bounces-6416-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C9D9EC3DA
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 05:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02ABA161E13
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 04:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891751A9B3E;
	Wed, 11 Dec 2024 04:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IVlx6jP8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B7F2451C0
	for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 04:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733890002; cv=none; b=gXbCsvRQ//CYiqsTdh09j/YUyK6+1bBlYYDk5BoXXJCYMY77bC74h4oc6nYFC1vT+hXqiwB7xZsso0kzmiCSKWDXOMKjoTjICixQ19Bwj8o3vRq9iV0obM5jhbTfJ1p5wQ9DJzUDJ1/M43dJ/RvgAF+cCWZQWrQGxLQUJ60sbEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733890002; c=relaxed/simple;
	bh=lYmDpRjmfQu3nKlHQIjiW5WMyWgzH58IPaKAr/gdlNU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=dlcgrhy6bZf9n9+esAfj7IQfBxmCfLlnXD+dREri9Gzai5RaHa6g73tvsD1BYcv+MkdbrfMNV/Nn0ZQA/L847iKyPmGJOutZN4rAOrJlJHVYLpe2PL8UmXYbu3faXIM9/ArhpeiW8V1Z0mOWi1RSIQfrcRxsIpUMcRqaa6o9oYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IVlx6jP8; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ee6c2d6db0so5575490a91.1
        for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2024 20:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733890000; x=1734494800; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5142/wiswFvimWP1U91SJaxlF4pV9ZCEuTfK85ioSDE=;
        b=IVlx6jP8GanTszN8KNNZu8tmD9zyrx38w6FZk4uJXcs9JeP1dQxY5YDzZOn1mke6JT
         pKG4tL3VxFilgLuV826Y6rO+14RFJxIGreayxH2aONIdOg2E+Uw21liu8p/EamJHmF2K
         ZQ+HywMOpy/pjh2Wfae8Oqj37+nHaVCUErYqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733890000; x=1734494800;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5142/wiswFvimWP1U91SJaxlF4pV9ZCEuTfK85ioSDE=;
        b=YN4gYl/7cBL9a9Vwy0D0D+HdyQYEg6S8suQIJBs45ayXR4kIYRO6PifJO8wcYWhXBA
         yI6HaFQJcM3IJt4+wLvpUT3DgawGH2QUTbzYMqtdDWLsv8LrSB3sU5l5KRF+J140QDn9
         72ds6Y2HkT0YT754OQjIlk/aFq+adI6jcVsi5FItLoIEM6f3qB+eUmQ9KU02V88TTkk9
         V4QCpL0gXyJckBpJpnaFGx/qrf3dHVzGSxgmsjfH1U/AHzGwHXQRZ5tVjl8eGJb4qArR
         14VUwaSOl9Yg83OiPtWbFoT9SPOdaNaSFr82nDhHKHwbFzIe3c5dBiovPgEBcB8QvWEa
         cKPw==
X-Gm-Message-State: AOJu0YzNXryx3mYQZegHVK+WcboxttQr7c7HEsoMwqDmshhvh1g27zvq
	+4tuB0WpiJODVs0SW19ibGUrIGFSwNh1FxYU0zceG+crC9rMpDpJOnTl+C+cUDbQjk46k73mAhT
	IzA==
X-Gm-Gg: ASbGnct4cMe0l6H1KnzbJAhf2jaCfETQqeH93rh/iz4ExhmFxhD0fijN4Jcz/Zb96VS
	nJNhNSY2xNbMFlJsfSEAN5JLnwnKzTe7C9wwimVNKYIc9o7pEi2FHR5bHJ8fcSQzgU0ToCjV1Ys
	4A81UMcKXvgm5+OVJtgWV6CGBYX1BGywIHLwtkUw+qsSMk/380dfbhqwXq1bX7FCrjvndU8KwFr
	5xYC3Q7sSCl3f64S7W9Q9+kDSqqKt8qM84bHcD7fG77SnAotB6TH1SIqp/eFloaYJRlvXReUBox
	1ZfPuhoyULBB0gLQuG18r5jjDsoaST8sdg==
X-Google-Smtp-Source: AGHT+IF1NRMCKOF3AGRnp4A+SmgOC9UVfndAdfELchfyx31gona/Cd84f3AkPbyg5N3xuxtbPuQdCw==
X-Received: by 2002:a17:90a:d450:b0:2ee:fdf3:390d with SMTP id 98e67ed59e1d1-2f128048123mr2060618a91.31.1733890000252;
        Tue, 10 Dec 2024 20:06:40 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef26ffc948sm12477773a91.3.2024.12.10.20.06.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2024 20:06:39 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next 3/5] RDMA/bnxt_re: Optimize error handling in bnxt_re_probe
Date: Tue, 10 Dec 2024 19:45:43 -0800
Message-Id: <1733888745-30939-4-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1733888745-30939-1-git-send-email-selvin.xavier@broadcom.com>
References: <1733888745-30939-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Optimize error handling path in bnxt_re_probe by removing
some duplicate code.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index ae5025b..75e1611 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2321,13 +2321,9 @@ static int bnxt_re_probe(struct auxiliary_device *adev,
 
 	rc = bnxt_re_add_device(adev, BNXT_RE_COMPLETE_INIT);
 	if (rc)
-		goto err;
-	mutex_unlock(&bnxt_re_mutex);
-	return 0;
+		kfree(en_info);
 
-err:
 	mutex_unlock(&bnxt_re_mutex);
-	kfree(en_info);
 
 	return rc;
 }
-- 
2.5.5


