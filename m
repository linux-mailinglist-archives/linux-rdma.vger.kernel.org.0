Return-Path: <linux-rdma+bounces-6850-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A7AA03581
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 03:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B4D23A420C
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 02:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D97333086;
	Tue,  7 Jan 2025 02:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gnVx9rnI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D80386355
	for <linux-rdma@vger.kernel.org>; Tue,  7 Jan 2025 02:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218410; cv=none; b=apoi13UUYIUU4/QqQ2bcJiDzxLoOxVMM83F0ToiyNImATw0S8/KCOjORe5/wk7U9vD/McUuYtq849wZtedfz0MyG3ymF9UhKSvp8hXO1u+nWj21t9/sCbrTeJ75WrS4UBR0qyUgediuUbng0zsy9npjQdPF5Lra3YVdZBkIQwHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218410; c=relaxed/simple;
	bh=dkUGgPaQv0HlenJL6h3glKDnebubexeUid88hsJAWbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BWJGWCkZN/3adLv4fo/cMRFXhYXhRFhYBxQJdXvvGq1BTmFXhRsBVxs1V9TkEMTNfJ5aO0kHe5ebC/EsLX9IazM5j/BhvUyXWWRxHpmSs/UYMKbjw7lkyMO0Fvo/wzHguAtc/O0ikbyWIQ4zNtEzjg13qxtY4iN656lrHQcEoLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gnVx9rnI; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21a1e6fd923so21974445ad.1
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jan 2025 18:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736218405; x=1736823205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2T8x/Y3tf5HzBNGI9qqdrAzuAwQcN9/qZhlm85+Qs5I=;
        b=gnVx9rnImi1cMAf/pypHP3nrbNIauS9RUQAPz5llxCRD2KZFekAa86D56gIaYXCaGK
         pivtcjoqKCa/8EjYSyweeG0+7p3hziYfqntOjHVeL1akrJ6vlw6bMYqgtiFFdFvFN/Lr
         O62MjyTCABDVl+Tt1HKzCza/xcmQTFEcwqNec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736218405; x=1736823205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2T8x/Y3tf5HzBNGI9qqdrAzuAwQcN9/qZhlm85+Qs5I=;
        b=sFfGT4Jg+iyH9adgyjgi/tXLLCtbXWv5z52lrWIyRAtsedgbLVKa5PUToieuCjAYGi
         ETKsfhcw7hIibRs1s7z/q5oSX/Hy9Z0fE5ULMEnJeZZocNt2LMdrSua8pQ3SBuN7mUmC
         /ZK0yqaQTfiH9S6ItodzE2hZEVfvTwtpnQnkpFrnNnB8WTqXx2ZTygzqxq7xKPspmmtg
         JkcUdZqp+dDvuOY9TCua9UHWr3bHC9QuQWGhxWQW7VFPNEgzxsn2slt0/I+7rKdQ6MXN
         a9zTRc2hvs0wUUlry7vy/KM/dA4QM4S2GrWgCNzsW0rty04RWPWFHCfhrKEiZltaU5fu
         4CVg==
X-Gm-Message-State: AOJu0Yx6eyWxUPhUH5eFyN/ao9RcwpTk6+VB6DOkiUT0AxgqIiiPbSWo
	BE1kj+mywgdkaWx4fPFcgKgtIcntDv5dYwj2WFBwTb16wj7JbaX3RC4NLz0ftw==
X-Gm-Gg: ASbGncv9c0bXwDV2+xZt6k+Z8IYrgMHbDzKZUIFIC5kxeDvnJ27hvCSa8xQNmVLuYkg
	y+vDV+OKao2SiHyUKE7sKVAlIOuaZv4pp8LdiTs2Zgc7tEHMtm+1TmFxgz9vlKrbpNYoAYj1Hso
	ZpURkdgZqFWz+BDbjo2GOuDKNOTyHlxYCrcOba+TnstpOzN5LgKKaLxhLuWraTvkUk+jBijYUb6
	p8cAePuxgaTE0UfcXjU37AVOh71WEInGp6ckcdWi2vkP+gYl+eYbpQiB13jQx96zfhTpH5gaVEN
	Ml1skVKnLcoE48EWFszcIPDoxwp+iJm2GQeHLCY0m3+Ym6Z562gIdl3qVzo=
X-Google-Smtp-Source: AGHT+IG4Eg1Qa4bYrwkHsVmy1FJUfccMEmddhYKXobsoGSeCuWxcP/7/t0DNSwIMZtSokFC+uyzWYQ==
X-Received: by 2002:a17:902:f60f:b0:216:32ea:c84b with SMTP id d9443c01a7336-219e6f25e84mr890072725ad.37.1736218405373;
        Mon, 06 Jan 2025 18:53:25 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f692fsm300093285ad.216.2025.01.06.18.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 18:53:24 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next v2 RESEND 1/4] bnxt_en: Add ULP call to notify async events
Date: Tue,  7 Jan 2025 08:15:49 +0530
Message-ID: <20250107024553.2926983-2-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107024553.2926983-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250107024553.2926983-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Chan <michael.chan@broadcom.com>

When the driver receives an async event notification from the Firmware,
we make the new ulp_async_notifier() call to inform the RDMA driver that
a firmware async event has been received. RDMA driver can then take
necessary actions based on the event type.

In the next patch, we will implement the ulp_async_notifier() callbacks
in the RDMA driver.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 28 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |  2 ++
 3 files changed, 31 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 4ec4934a4edd..25850730071b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2857,6 +2857,7 @@ static int bnxt_async_event_process(struct bnxt *bp,
 	}
 	__bnxt_queue_sp_work(bp);
 async_event_process_exit:
+	bnxt_ulp_async_events(bp, cmpl);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
index b771c84cdd89..59c280634bc5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
@@ -345,6 +345,34 @@ void bnxt_ulp_irq_restart(struct bnxt *bp, int err)
 	}
 }
 
+void bnxt_ulp_async_events(struct bnxt *bp, struct hwrm_async_event_cmpl *cmpl)
+{
+	u16 event_id = le16_to_cpu(cmpl->event_id);
+	struct bnxt_en_dev *edev = bp->edev;
+	struct bnxt_ulp_ops *ops;
+	struct bnxt_ulp *ulp;
+
+	if (!bnxt_ulp_registered(edev))
+		return;
+	ulp = edev->ulp_tbl;
+
+	rcu_read_lock();
+
+	ops = rcu_dereference(ulp->ulp_ops);
+	if (!ops || !ops->ulp_async_notifier)
+		goto exit_unlock_rcu;
+	if (!ulp->async_events_bmap || event_id > ulp->max_async_event_id)
+		goto exit_unlock_rcu;
+
+	/* Read max_async_event_id first before testing the bitmap. */
+	smp_rmb();
+
+	if (test_bit(event_id, ulp->async_events_bmap))
+		ops->ulp_async_notifier(ulp->handle, cmpl);
+exit_unlock_rcu:
+	rcu_read_unlock();
+}
+
 int bnxt_register_async_events(struct bnxt_en_dev *edev,
 			       unsigned long *events_bmap,
 			       u16 max_id)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
index 5d6aac60f236..a21294cf197b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
@@ -30,6 +30,8 @@ struct bnxt_msix_entry {
 };
 
 struct bnxt_ulp_ops {
+	/* async_notifier() cannot sleep (in BH context) */
+	void (*ulp_async_notifier)(void *, struct hwrm_async_event_cmpl *);
 	void (*ulp_irq_stop)(void *);
 	void (*ulp_irq_restart)(void *, struct bnxt_msix_entry *);
 };
-- 
2.43.5


