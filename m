Return-Path: <linux-rdma+bounces-6414-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACA419EC3D7
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 05:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3376F283F56
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Dec 2024 04:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16811B0F38;
	Wed, 11 Dec 2024 04:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JqNV+3yj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04ACD2451C0
	for <linux-rdma@vger.kernel.org>; Wed, 11 Dec 2024 04:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733889996; cv=none; b=bY6mT2Xu2/vtfSDPfTuTXiAlxO4p7x+wAhaMSMlmWPRVDbUTUQM++sd7jSof44jCLq5/wFQxrIuPPksH6w9jHXwCnCvSviQTmE8XSGkY8cislw+1D7a7h0Cg+FV+CFiyHLUw/E+KCMCBKb/SRshdO1GS4kwyHlEv8NMDJI99u/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733889996; c=relaxed/simple;
	bh=4YNB6Tlahn9sjmmgCTvGLevJx3lb2+TLQfgp4i1x2Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=uYtbZTYW4lIvdPde4HkjwYwiLiHugFk3+gnupbt4qKwGrmJ1oaGRIF91xFunoJiRixR9rvQ7Rz5GOcMERS1YdW36KE//E0VmDaFaKePIoRgCgTd95MxmOwYpb6thhrVHkeVIZLhyWEtpx372iRpoNBl4M1edf6sFQ4mXST0W1Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JqNV+3yj; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2eeb4d643a5so5567368a91.3
        for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2024 20:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733889994; x=1734494794; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wlSTGCSTvz6ISkV3bIGd/ah3bR4DiOy3cN/ix3OO+rI=;
        b=JqNV+3yjlXCkYirIor5zBfcyiwMKqE4kdgn+nB1l30OblTe3rHQYlL5zJxTHWb5e0R
         QtD4gxOpoYjLKAcgJXWKh6rqpzse4jKnvc6Jnep2fBffPjKJkedVjGAOzJMr05DPJasv
         1cLzKjj+ElKrqWk977zWR/JcIB8lF8haKskiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733889994; x=1734494794;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wlSTGCSTvz6ISkV3bIGd/ah3bR4DiOy3cN/ix3OO+rI=;
        b=RHtQkCxD2tV040Y0tqfk9epx8yreLgVrGhrgK5VNejCcsAiuYIt0pUrflMUjYeQNEB
         QPffP0VQtVrditZxMUEw4Sej+9w/u46TjWj+oyAhaaeOS+Ev2JqtPfaamsNRWCAehyxG
         bZxxcjaj21E1yB26K/5TWFjn4uQE+eVV6oqg8x4GkIjw3j4hRbaSLWzLrn0sZp4jXquE
         8zUSBpbgAHav1QygEBRhy/L3R5/8Ke1GUiLTRNNy4Kj/bpy+wsgzKAdgeCM8jKm+1Bg1
         A7jsRh4H0nXHmth8kfPch8W7l9nO1iOoFkEbMEYQi1fnCW/3sd/VZrzXQo/TBUK37yOC
         IazQ==
X-Gm-Message-State: AOJu0YzGrvKgXRRRyAtIVjcdorNA5jZ5xg4o4yGeFFLpVjuqfIeBbyB1
	rRdH9So+zmV/jyFc/+KVJcj/klBsMiDFLNhQOOg9tpyJrUWb5NFyT/F1AYna8Pc82zULDteiwrJ
	mTg==
X-Gm-Gg: ASbGncvNW3zr894bVUqWoUaV1IwC3+4+hGKIBgPIwD0jsxMU0/s/TSLfkWwfNMfWgs7
	CKZRxYJoAWGR6T6TknRMobnenQFesTAHQ5A1aqNhW1BcA+ixnq6rK3jRO/dFRbvWSMINtVJuZRi
	mnK2zl8nkb/64vl/Oz9RhkbTyIhGwWsldFOm4TIjbJBjjhq+LUdXYhHNBg/B6+IhZp0yl5oOwht
	9l7DAQLbdiqPEh+vMTUvbWzGvPI8kIRdJs6pxw5+zLHkKiJmIUPG+nQwlkIQR4USKAKuGbZteDE
	5MZj4k7K23cHYI98LbEIw7ym5Mw+UMaVMQ==
X-Google-Smtp-Source: AGHT+IFWyuZYzAHcFwmo8bLevBLDBmqURKPdRQbX55SjkJcTlJFb4fO/BTq1MqUrXAs9I4WRcZBLpA==
X-Received: by 2002:a17:90b:520e:b0:2ee:9b2c:3253 with SMTP id 98e67ed59e1d1-2f12802cf56mr2277049a91.30.1733889994425;
        Tue, 10 Dec 2024 20:06:34 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef26ffc948sm12477773a91.3.2024.12.10.20.06.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2024 20:06:33 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-next 1/5] RDMA/bnxt_re: Remove extra new line in bnxt_re_netdev_event
Date: Tue, 10 Dec 2024 19:45:41 -0800
Message-Id: <1733888745-30939-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1733888745-30939-1-git-send-email-selvin.xavier@broadcom.com>
References: <1733888745-30939-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

This is a purely cosmetic change.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index b7af0d5..735bd78 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2247,7 +2247,6 @@ static int bnxt_re_netdev_event(struct notifier_block *notifier,
 	if (!rdev)
 		return NOTIFY_DONE;
 
-
 	switch (event) {
 	case NETDEV_UP:
 	case NETDEV_DOWN:
-- 
2.5.5


