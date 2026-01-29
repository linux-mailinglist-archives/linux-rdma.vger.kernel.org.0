Return-Path: <linux-rdma+bounces-16188-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AI8OIE1e2mGCQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16188-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 11:25:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 510A1AE9B0
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 11:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4035A304B008
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jan 2026 10:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85D4335BC0;
	Thu, 29 Jan 2026 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="goTeh4FR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640A531DD97
	for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 10:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681935; cv=none; b=gqIp7DCIdgfzYZOrdNyMd6/k6R7ohwf2yKIKdbvVcv+IpKEExV9vi4BCYZ44PG0oHvlFv5LSJzU1uq2yq65orY3zF6rqaOlCoEDec2++ovUp5tQwwarh3IdoDpJGXicL3MTeogTAOH6PJ6HGBeSVOY3MMQzh96yO+0eVCgojQds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681935; c=relaxed/simple;
	bh=ov8clyLfqxNEBvWRpGujN20ZfaTjVz3FzH/hPrH5x0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjKr9Bui0x96vPnlcfzmkuTCebgSVL6p4DivGw8/YqRvoha1kLU75jTx8y/2oXZ9R3Vzbzh+lSqEfOBQy7lOLlVinzSn6kZzCsUo93tab/TuvkvucUe9a+tkJPJgkfjbK0NK1ZN59jFP5Nb+CMkE4JjFNzPdcA7z2AECeDZDlC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=goTeh4FR; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-c05d66dbab2so543727a12.0
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 02:18:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769681931; x=1770286731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5wKTjqNGqwbPWUWBwX0EYSUZ4Cl88mKrjf+1xnIB43M=;
        b=PZ+ifkeAvU+f3nhyuVov4ZaEdAIdKRDSSkEOvZRDdTgwoZiWoThxxK41wEEhsUFeO3
         JX9yO6jQW0CNEOlEJZd2YWtBGdwUSK0yWDdER4/Rfrer2p6k0fAi4Nxzrg2oMUl5U6Cu
         psQF6sB4XIAAoZbhjjsIJ+KDcsLKpjINqrLDtEjbU6Cttithd9XwPJX21MTtJ8ey85c4
         aINOLO9jj3WB1k4WTwVdrF/PJM3knV4INfpwD6G0XOQH+flwWqImnjs5OXhR5U5flL1s
         pSPkcKYNVe3PvmBqf1b74hAuFrDf6JWc+Kx2nzGh+hD+AjCydNSUx4b7lU2MwiRKNJmr
         M+Dw==
X-Gm-Message-State: AOJu0Yxji4M0IyMOzGMQBfR7Ft5J2HFQUSrNqolbr/y6RUsuiYJWWqe4
	YvrUPV0MEUhVyLFv5UdwkeTE8pKVYv752QHgSpTH7Tx/ZCuX1nV6K1NtY6gPuJIQyitLsN3zda1
	dZ91Jyez/byl8noZ7lIQeyTAOFO6IlK3oxnvs5DgCvQ699qesvx2V2meEoJtwHO6ERja2IMuyRd
	wnBj+kP5SFJvz6C6oU9YOD7x0+8T5enljPMinviUgfThTssJarf9iUPD1KDe89ZRL9d5MGDVixw
	0yEXbsQKsYb0EkSxfE541lDPZ8Z/w==
X-Gm-Gg: AZuq6aKEO7hKNLIGJNwpCu/IsCkBCy5MCatPhRq3HcJcPfJjnJGsXeuiiNj0hboqHDU
	05wP+YeLE15UvOasehTC/C9xpzQ9xWey3TUSgrZrlhTRblPK9NlKG3vQoUcVIO/+f8haOep1mDW
	8enx91wTonxZx5otQ+TwIGwCpGdGJpwCeCr3upo8CT4KwNwbV8RmgHJ7k6wUfTL+gXUes9QiXqU
	8J4sr96GiO4+Z51fSrlkXtTm6NbtyGaIINWHJ5UbOpNZM0lPVXmkK1mK2BgNTOIEqzfWfCauV2g
	ZLFLmw28DfOH09jqhlUDpW4u4gz2OKRpN+5MRDIt7kXUYS+TiyUWlcY+dbwtsh4l5fKSmr9yaUa
	W/nzB/L8Azkdwqv6Srnz17lyYjZ64AHhnmHJjGyvDbzlcGyr2GykUqNzPvAE1MdBXb82zcyz/VJ
	MvahHyn/JS5L0FORfxKRzAFSfXqdrGTkWnTqTkTKy/KeiUb9uE1OoRYfCsWg==
X-Received: by 2002:a17:902:db02:b0:29e:e925:1abb with SMTP id d9443c01a7336-2a870dc06ddmr85782415ad.27.1769681930719;
        Thu, 29 Jan 2026 02:18:50 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-17.dlp.protect.broadcom.com. [144.49.247.17])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2a88b4265d6sm6396565ad.25.2026.01.29.02.18.50
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jan 2026 02:18:50 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a7b7f04a11so19497005ad.3
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 02:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1769681929; x=1770286729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wKTjqNGqwbPWUWBwX0EYSUZ4Cl88mKrjf+1xnIB43M=;
        b=goTeh4FRZnuUj61jXfKq7AXsCGBQ0x4z9ZMDbWSMBIb3Y3MTDnJ3bTT4aQGodElCj7
         KWq1tk1eJKlGyljFV2KW1QJVoi4OfC/1gXcK+d5pmTPZbjlpTrRoprgGGMZH5ppVCDft
         QkGY0JCDJN0Q5ehjG7LhFvLtdKHEAx8KquAAw=
X-Received: by 2002:a17:903:3808:b0:29e:fd60:2cf9 with SMTP id d9443c01a7336-2a870e7423amr95723335ad.54.1769681929247;
        Thu, 29 Jan 2026 02:18:49 -0800 (PST)
X-Received: by 2002:a17:903:3808:b0:29e:fd60:2cf9 with SMTP id d9443c01a7336-2a870e7423amr95723075ad.54.1769681928752;
        Thu, 29 Jan 2026 02:18:48 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eedd0sm46155295ad.3.2026.01.29.02.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 02:18:48 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: [PATCH rdma-rext V2 1/5] IB/core: Extend rate limit support for RC QPs
Date: Thu, 29 Jan 2026 15:51:29 +0530
Message-ID: <20260129102133.2878811-2-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260129102133.2878811-1-kalesh-anakkur.purayil@broadcom.com>
References: <20260129102133.2878811-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16188-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kalesh-anakkur.purayil@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 510A1AE9B0
X-Rspamd-Action: no action

Broadcom devices supports setting the rate limit while changing
RC QP state from INIT to RTR, RTR to RTS and RTS to RTS.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
---
 drivers/infiniband/core/verbs.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
index 8b56b6b62352..02ebc3e52196 100644
--- a/drivers/infiniband/core/verbs.c
+++ b/drivers/infiniband/core/verbs.c
@@ -1537,7 +1537,8 @@ static const struct {
 						 IB_QP_PKEY_INDEX),
 				 [IB_QPT_RC]  = (IB_QP_ALT_PATH			|
 						 IB_QP_ACCESS_FLAGS		|
-						 IB_QP_PKEY_INDEX),
+						 IB_QP_PKEY_INDEX		|
+						 IB_QP_RATE_LIMIT),
 				 [IB_QPT_XRC_INI] = (IB_QP_ALT_PATH		|
 						 IB_QP_ACCESS_FLAGS		|
 						 IB_QP_PKEY_INDEX),
@@ -1585,7 +1586,8 @@ static const struct {
 						 IB_QP_ALT_PATH			|
 						 IB_QP_ACCESS_FLAGS		|
 						 IB_QP_MIN_RNR_TIMER		|
-						 IB_QP_PATH_MIG_STATE),
+						 IB_QP_PATH_MIG_STATE		|
+						 IB_QP_RATE_LIMIT),
 				 [IB_QPT_XRC_INI] = (IB_QP_CUR_STATE		|
 						 IB_QP_ALT_PATH			|
 						 IB_QP_ACCESS_FLAGS		|
@@ -1619,7 +1621,8 @@ static const struct {
 						IB_QP_ACCESS_FLAGS		|
 						IB_QP_ALT_PATH			|
 						IB_QP_PATH_MIG_STATE		|
-						IB_QP_MIN_RNR_TIMER),
+						IB_QP_MIN_RNR_TIMER		|
+						IB_QP_RATE_LIMIT),
 				[IB_QPT_XRC_INI] = (IB_QP_CUR_STATE		|
 						IB_QP_ACCESS_FLAGS		|
 						IB_QP_ALT_PATH			|
-- 
2.43.5


