Return-Path: <linux-rdma+bounces-14459-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD51C57060
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 11:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9624B4E9FDE
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Nov 2025 10:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F784332EDE;
	Thu, 13 Nov 2025 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h7C6Ooxb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f98.google.com (mail-ot1-f98.google.com [209.85.210.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40732D979C
	for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030988; cv=none; b=rPMmrH7GynaDBiVUp+NUl0RGqabWqYnRlM/3Tayqm1gjj9EQwXH43X238xBji532HLRtVG8QvmTpppKta1JDcbXke6UacKgFcZo31ALTtKqtvt3/8zhXBjLzliPRdpdVhdWCrnz/LgvH0NZ21nu8cvrcOjtNie7nr8FDQg+o1tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030988; c=relaxed/simple;
	bh=RqMk/T14w9MZRZFZOkV+0ThwIbRDnYFxA7nkdtjdbrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fRcVYOJzjPx3OVupZ8EaxgTWh9aV0Exr0O8XazPj6nkY5EfGosRa5L+V1Ecu/4shSMburhsIZPL/+h5UOPEux7CHqqLsTczVk7Zn7bVtPqfnTlKpSyTZcWHZDwIcJ9iIMN6Bffkm8ZTGo05BJL1Hk1TWgc7swONIaVcNMkIeg+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=h7C6Ooxb; arc=none smtp.client-ip=209.85.210.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f98.google.com with SMTP id 46e09a7af769-7c6dbdaced8so464235a34.1
        for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 02:49:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763030986; x=1763635786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRjqhZsvMiW0zkf+qbdc3//DIWYEnn9SfyYAz2Pu1hs=;
        b=RVpTvOlU4xEqIRq4iM91qOM7sg1H62WQaKwoz5KcIa6XR7kuKzcIjlDLoVsC8vqR5j
         A+EZYxvbA/MITY/5QwhqDg5eiu2GL6xpvepU6rln37peojic5EEI5qRkcR3/30MWTy2p
         FV/U1bG4SojZ6+JFeYvRmDM+tOInf1NHh+fyTDH7ImQqOq8n4mctM4CKru9+CorUlBUn
         /qTav1xnulZ1VcJF/3p7s+9UA8snsefVClE7H5LLZsv2AIuUfALD9CNkVAoNYNnSlWZs
         JQyHjpRY3GP2XomvCD5JkbtTEJrTmf/4zooDHD/YTN5gaxRWVTcS7ycuPn7cllaDdJc3
         Q1Fw==
X-Gm-Message-State: AOJu0YwC/uyg2FU5diqpdSaXBtoNsY9ObsjWi43e4Zs5WmHUzIbuD0ZV
	xCVmK1WqQYc4cLBoi4ZU8Pgx19FD2M6PZJ6QMHAQMQPXRaX6NGcUjtZPTjCiejqtGb8qRpnvapm
	gogaumuM6S4SNMA/RsuRBNLuJauIxXWdo+EQOSnzrWPWKcuSCQQgKFseFUDdAIav/rYn2dPG8QR
	02CsHhhX/DuBYkOmNU2e2Snz4foKFhxDnBQxLaPbnYapcMDpW6zxGomqQr5G+z1cUpp56S5ESiv
	K+ez6oc7xkyOmNO7IxrepB6Jnix/Q==
X-Gm-Gg: ASbGncsX2WlHgXJgJ58s2ppImcgu8Dxj5zopHJxOT9eh/E0fThWPcbnlDPzOV1pF61F
	HlxOGxPqXNexsdFzfAf3aHC7kTKLIJjo3us1TPrVNNlUg4La09p17LqISHdHx6rFGLHD1RTaH+C
	RbAJrlRADfOF2LwkY8Eh2QmwYxv6NbrbJh14kkKHZsIhSLxG46eZZaKqPMACr2D2z8spfWvT1PR
	PC4K8fUR2vJqWy+woP2pXgIVlDUedT0v/6FIGLt32cUBL5eIkWNPezu2HimZwuoFYx5esflT0+D
	BAXg4o7exY8mhevT13YfSOB52q4/oSXGgGrvWkm13SzfbbioxbCypj/VN1sgz2o3/oxEG90whxN
	TNxPeNIy2olaZCTpQC0DFQDWndZJMY1s+e7dk+GgdC2dpkx7FA087vs2AsOIb4tdoCGCAJhWVOy
	haSXVccv4zuKgMjsKON+UChbQWRmbLc/Typdgm+uyiTdmYGzo=
X-Google-Smtp-Source: AGHT+IE6BN+dEO2eH1RtiCF2YjRXzTg6yBBTiGhc4vBBqo+yPMxQVZUoqdy7qI06fmnmc3GhhJyT+eey5c87
X-Received: by 2002:a05:6830:34a1:b0:7c5:3045:6c7e with SMTP id 46e09a7af769-7c72e20ff3cmr4216443a34.13.1763030985821;
        Thu, 13 Nov 2025 02:49:45 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-14.dlp.protect.broadcom.com. [144.49.247.14])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7c73a292469sm116979a34.2.2025.11.13.02.49.45
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Nov 2025 02:49:45 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34374bfbcccso722270a91.0
        for <linux-rdma@vger.kernel.org>; Thu, 13 Nov 2025 02:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763030984; x=1763635784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yRjqhZsvMiW0zkf+qbdc3//DIWYEnn9SfyYAz2Pu1hs=;
        b=h7C6OoxbjTmgtJuuDRbhmAUj7VIeG4EVIvpQx5s8ysFYQ8bkodJItPlmN5QjxhvTVF
         bsQzIYGMZ4sPc+yziaNawkJok0rtt+nlvOjsWt0Fc8XJrB6aJ/tqVZ6dtoagAYXJcCPi
         AchP/6bKngiOgvL6IRIbfkvR3CSeOHvJqTi2w=
X-Received: by 2002:a17:90b:2741:b0:33b:a5d8:f198 with SMTP id 98e67ed59e1d1-343ddec0cefmr7113188a91.25.1763030983806;
        Thu, 13 Nov 2025 02:49:43 -0800 (PST)
X-Received: by 2002:a17:90b:2741:b0:33b:a5d8:f198 with SMTP id 98e67ed59e1d1-343ddec0cefmr7113155a91.25.1763030983354;
        Thu, 13 Nov 2025 02:49:43 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc3760d9887sm1810417a12.28.2025.11.13.02.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:49:42 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next] RDMA/restrack: Fix typos in the comments
Date: Thu, 13 Nov 2025 16:24:57 +0530
Message-ID: <20251113105457.879903-1-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Fix couple of occurrences of the misspelled word "reource"
in the comments with the correct spelling "resource".

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/core/restrack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index a7de6f403fca..b097cfcade1c 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -175,7 +175,7 @@ void rdma_restrack_new(struct rdma_restrack_entry *res,
 EXPORT_SYMBOL(rdma_restrack_new);
 
 /**
- * rdma_restrack_add() - add object to the reource tracking database
+ * rdma_restrack_add() - add object to the resource tracking database
  * @res:  resource entry
  */
 void rdma_restrack_add(struct rdma_restrack_entry *res)
@@ -277,7 +277,7 @@ int rdma_restrack_put(struct rdma_restrack_entry *res)
 EXPORT_SYMBOL(rdma_restrack_put);
 
 /**
- * rdma_restrack_del() - delete object from the reource tracking database
+ * rdma_restrack_del() - delete object from the resource tracking database
  * @res:  resource entry
  */
 void rdma_restrack_del(struct rdma_restrack_entry *res)
-- 
2.43.5


