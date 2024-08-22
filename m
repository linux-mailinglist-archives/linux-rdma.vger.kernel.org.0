Return-Path: <linux-rdma+bounces-4485-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7311D95AE1C
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 08:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6D52811C2
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2024 06:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D5716D9AF;
	Thu, 22 Aug 2024 06:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dsPouiyb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEC1170A22
	for <linux-rdma@vger.kernel.org>; Thu, 22 Aug 2024 06:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309558; cv=none; b=imIw8UUWPFoRTeTWTQT2cHYuDfa+Vro55Nsnh2TM1VdAvOcVRHOACcQxACfW12W7AJORLi+Q/KWUNdcifGVmx9gjPzPU+sTWSbBA8KvTh7/g4WFshz4o0jpslPtzyGszb1FXoispt+a/ZJ60ksNZJCso0Bboss9FGS3CMe43mfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309558; c=relaxed/simple;
	bh=HcNuhaMR5GFVKKfyDwml6/5AnDgXrYlzbwXlSe/GI6M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s8IWzVFlNyoTvWNibcjiphv7yiP+PLkr6R5MY05xwkkseuQ35mJI/6xrHB2MUzsWZkJe1uzlEeKNjn/Goudtgy7nk27FIqLSD9y2xP4olvdYU1shFvVyPc1qwsQf0+N2PpVMsiK7yE7RTgfKUgFNFS/KT/BT/3X+UJXhsoaWz50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dsPouiyb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-201e52ca0caso3539675ad.3
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 23:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724309556; x=1724914356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snoV1iTL8bPhsSIyEH1EhK1+rRvIHObyd7ozZ6RtJgM=;
        b=dsPouiyblBiIxo/vC7BGFhMugUZSfcMMiTIhLp5bZhIdarW9a9qMEwzhNp/qASjgBL
         bfCy3+acVJjt2UWsYcPItq6WURPUovH8/DKcXysyWMwhNmQkW8c2I1IbB8IWiui1S+Du
         7GXMzJk+Yr3rxI4DUc/QmvrVj36dMQFOXr2vzzSNaOfsCgdcCmCL/KZbGf0bs6BkqRyw
         cH9ETTv0NgqrSponX/oWuvbVvl8NIqS8R2/R4Xo+p9aHAqZZqi573EUa4z3vbPe4N9rR
         3uKga0FKVpls5e2O1qknXd77n3gYoytwTzcpcSKDXp2ozLk5jGyD2yW7mBJBonwhmofl
         sVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724309556; x=1724914356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snoV1iTL8bPhsSIyEH1EhK1+rRvIHObyd7ozZ6RtJgM=;
        b=WFO0vxB3Ywu2fnoLcanGZV4Q5llOfyJnMxYcB1g68e21pXHytpnYQzN40kW10eoLUZ
         jdt3s40+Hf0odfvkJW/tTyDDwKdaduHIruD6HeW2ibghi8vW8whhfpvArhWT43Y4F0Cy
         i1fHrjhPzGP4Qs2bYsEWpcI7dyOG8y7TjygD0qtJOKgo7sWJB/G1FtPQ0CdPDDsAfstX
         NNqK/4XdyDaA8RBaHEgRBK1J5aJUynN4tYJzpmQyAknRTHSqZamXY2HucObkeJzeKBTB
         Nzy6QqthXiJUDleqVJyCOGbcdj1o9pQO/5ZUOMyn7yZZS8+1vNFbWBjcwz8Jq6vhMpCw
         Nr3g==
X-Gm-Message-State: AOJu0YxLC6p9iVL3VGOTtD2MhWxlrXXnALM5YMVu3IKqNkoKtIll24Mm
	kvqNylWzoT+mfbS42SZ9/RU//Ja0rt+cKyUCySocXdktSBhh5rUuc41PSng+ZDT0P6TrUF7yKN5
	O
X-Google-Smtp-Source: AGHT+IGRh+LUc+DWLwZpWgmFamLq4T3hY6/bi7pybwa1EurEAQq3/LLWDaltr/gcMPtSfBCtUlG/8Q==
X-Received: by 2002:a17:903:41c6:b0:202:3296:eec1 with SMTP id d9443c01a7336-20368199110mr48684385ad.36.1724309555919;
        Wed, 21 Aug 2024 23:52:35 -0700 (PDT)
Received: from libai.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385581165sm6150645ad.88.2024.08.21.23.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 23:52:35 -0700 (PDT)
From: zhenwei pi <pizhenwei@bytedance.com>
To: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: zyjzyj2000@gmail.com,
	jgg@nvidia.com,
	leonro@nvidia.com,
	zhenwei pi <pizhenwei@bytedance.com>
Subject: [PATCH 2/3] RDMA/rxe: Typo fix
Date: Thu, 22 Aug 2024 14:52:22 +0800
Message-Id: <20240822065223.1117056-3-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822065223.1117056-1-pizhenwei@bytedance.com>
References: <20240822065223.1117056-1-pizhenwei@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix 'rmda' into 'RDMA'.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/infiniband/sw/rxe/rxe_resp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
index bf8f4bc8c5c8..c11ab280551a 100644
--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -341,7 +341,7 @@ static enum resp_states rxe_resp_check_length(struct rxe_qp *qp,
 	/*
 	 * See IBA C9-92
 	 * For UD QPs we only check if the packet will fit in the
-	 * receive buffer later. For rmda operations additional
+	 * receive buffer later. For RDMA operations additional
 	 * length checks are performed in check_rkey.
 	 */
 	if ((qp_type(qp) == IB_QPT_GSI) || (qp_type(qp) == IB_QPT_UD)) {
-- 
2.34.1


