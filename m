Return-Path: <linux-rdma+bounces-12754-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C598BB2640D
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 13:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF28817E0E7
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Aug 2025 11:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66743318155;
	Thu, 14 Aug 2025 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ERpE9G5w"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF3E318156
	for <linux-rdma@vger.kernel.org>; Thu, 14 Aug 2025 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170399; cv=none; b=QWtDAp2z8GzpQ1gSepbNYlKdBWpi2mcUd6qrSDRNuOugsDU8SuwpxaP4lqn/QVg7Iib8nJ1E1BhBUQ9KNo7IeUcNAjICrGqY4AGkWdTgD7lQV/AoVuLITGwT0ZYUr7xZHHh24a7iYjeE9XhIqeVWjZT9AkWDYSHVS5vzXOWg8tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170399; c=relaxed/simple;
	bh=wakGDzhu9Xlgv0P6TGd9CVKdwU46urbRaQ7SQmYM9y0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qyh1cju+pVrLwYqBV49jUDfB9VJpIGL+K4crceG1/OKcDPJhAzpPSnjha0vG5hPQZqmVvO9kiSrpA9Bf7vbZcJvgfjtiX9RRXX1YbZebnTEaDMFjkbWx49BtJGBTZwFPz11gIg0n3fhGzmQ70fb6iEEZtGGhE3JkaYb8Vr/CsHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ERpE9G5w; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24457f5b692so11110015ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 14 Aug 2025 04:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755170397; x=1755775197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Hv0ibVszmxG+N0Eoawde5ij2ANuam8Y/ss6msBFflc=;
        b=ERpE9G5wVH2hFGy+uYGIdu5P1Nz2X8rGkGSXVDGzBFG6yVjpcRbjhJv6Q5DVzui+fm
         igY9uaqD/xMbQ+y5PhqGCbd5nx/emaCVjlK46x8ZRnOi4BOqhERitwLdMyCEHRY7S/Z8
         4F7qcQpS98Ie5O+bmjH1iJf6i4407lPemiTT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755170397; x=1755775197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Hv0ibVszmxG+N0Eoawde5ij2ANuam8Y/ss6msBFflc=;
        b=MXrnK5YPmUNnAt45ZYEQmUL/kRFGiO5dDnzAGBWys0ZII4jU++ZjZLzo5l0X8TbR7K
         J5SvAJNM3mZJVb+3ti8SSe2vJ0pY5ZAYvvjQJL02DJSpobKu+xYrBSZg7ivNTca81HfH
         idHb7AFrMabtntzsGVe0xqfJ7caIQtlsnd++/AHSgn8bF9HQvPkhw/HXSjLi1PH3L/oV
         xqDUqwkIEJdYi9MZ47LJg0Iz2eKkRi9nwHUA0B/Q/ZvXg1IbRMliXoenlZxCGwBv5K1O
         KkXRsRK4rc9piJiBUyJdAJcji5HyMwjyL6giRg5B/lZLy4m0kx2zo71SpNfL0xJV0oW4
         KQnQ==
X-Gm-Message-State: AOJu0YyVsNZDbkcO9QA+CmSvEa+47dTCY2E9Z4ROl+6dprnu353n99Cy
	eIYAyFfWNU5hY8EEyFEOqxMIeBlLkscHfSEGnlaHcWHG6OQhBxbPOwyOP5dpacxadg==
X-Gm-Gg: ASbGnctLZuTW1jrXUqb2x9oRoixnzC00td3Lq5AWsrDbPjzBoKJotaJiCFR+Pa0vDLJ
	ViHQeQwythEWAxZ/yWEfYd+Sz4n0W8PZbVhLID19hTLr0nTq3/dLcZHgRoA6X/D3eKgLyQcuJR4
	8hZzeufRDNQC02mZCrW9iKubvKr2AlyfldjjNQc7mq8KL6odBvgpfJnru4V2JEnQZoja3J44Y1p
	dG/Qf0aSxJiGuOPfL0eqUSbWIB2DKJVdZhgtZIkJ5EVGu8s19riA2lDGJ42bwP5Ci1TDA9+yXHk
	uHq2BKMSFRl0cH6kraLSM3sPyr5Yk0JUE5GwMZnAwEteggl+Pw3QqpzgLEo6V6fDxuND5L+XwTN
	LWL4zns08tk7GRnNqpumqWykK8zzlriZ6Vb0AtltDD2ccvrvqKppoY5ZdvPwZl/BhC9vIil7X/0
	zfWi9VZ4S+o301aaz1C3UfO+AQ1rgfrA==
X-Google-Smtp-Source: AGHT+IGOaMNz40ehllI7l73xyEp11TKSYzWoSUHBoqG3lXeKo5Wyyts4O6VkWMeXfixH+pG0OvddWw==
X-Received: by 2002:a17:902:e78e:b0:242:460e:4ab8 with SMTP id d9443c01a7336-244586dbc4dmr38982185ad.46.1755170397081;
        Thu, 14 Aug 2025 04:19:57 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1f21c65sm352415175ad.73.2025.08.14.04.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 04:19:56 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Saravanan Vajravel <saravanan.vajravel@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next 2/9] RDMA/bnxt_re: show srq_limit in fill_res_srq_entry hook
Date: Thu, 14 Aug 2025 16:55:48 +0530
Message-ID: <20250814112555.221665-3-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250814112555.221665-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250814112555.221665-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kashyap Desai <kashyap.desai@broadcom.com>

Added srq_limit in rdma show resource srq hook.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 20c6a961cb18..f08948a49976 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -1225,6 +1225,8 @@ static int bnxt_re_fill_res_srq_entry(struct sk_buff *msg, struct ib_srq *ib_srq
 		goto err;
 	if (rdma_nl_put_driver_u32_hex(msg, "max_sge", srq->qplib_srq.max_sge))
 		goto err;
+	if (rdma_nl_put_driver_u32_hex(msg, "srq_limit", srq->qplib_srq.threshold))
+		goto err;
 
 	nla_nest_end(msg, table_attr);
 	return 0;
-- 
2.43.5


