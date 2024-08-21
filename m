Return-Path: <linux-rdma+bounces-4457-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A01C959A7F
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 13:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4641C208C1
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2024 11:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191471C688E;
	Wed, 21 Aug 2024 11:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="OP2VLynZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C291C4EE2
	for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239404; cv=none; b=KMjGNUoUOodSZg0BVfUfflO+vAFSOEtvK481YklvKqFP2oWMlX31KsqWXri/4tDDlw56fhBuQ6BFi0xQZhhU1XJNfx2TK15GYrh5uuH/tD/EcFJVWZWm1dPI/NGeJnEBlzrLmxFER5dUFlKazoJjt54dIXig45nJeZxCpsLQwF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239404; c=relaxed/simple;
	bh=WRV7DY/vIWFiZ3gU6V1V+cCtOFglJblnZJhmSfbRmuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K322U0XdrKWfskFgPFKo76uk3zHzQa4ndWNcchpqCoHherFajUJWFyDyxqeF2qGgDkanpPk0XPGYQ4+Z6ouxac6l61Au+dXAvMcJYPWLJuhwqpYqoEKzS3295QRBM9JCHa1zCXeY3YlEtyt6PYCBZX/C97Q+G+fUIz+KT9qp1jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=OP2VLynZ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8677ae5a35so64722166b.0
        for <linux-rdma@vger.kernel.org>; Wed, 21 Aug 2024 04:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1724239401; x=1724844201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+XXHfR6ei5DWieETKO7ps9vaiG5tNzbNEBSlnAsZkFM=;
        b=OP2VLynZgCKoPYBSaNt7cUVTB7XEusobHswovkPv0NrHiz3sMOJS2jSVmJ42zFO/oH
         yCYR8WSmo4oBOPtZ0Wr8EK2S+s7lTqjZaOfUCqyiyrZZacChjj2ObHtGXsvXokb0AM7l
         +pTUW36wb9uHsZ/gy/OBYLFM1o1Bq1shDlcBXieYCtcFqCNlAqJ4TBbjK6SIIEa6oHRi
         HDQnnfzMjTWSY3bT9EsyJ0KXEornHw/RV5MK4jG5IAADPA4eKJKfAPVgkmvTQK6nuLar
         un61AsAXGroyp+dN5n7vKivxTLFx1pW37BCPv5AGYRHRQ5oq8B/CWCp3fh88UEbaW3fA
         A4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724239401; x=1724844201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+XXHfR6ei5DWieETKO7ps9vaiG5tNzbNEBSlnAsZkFM=;
        b=HYMRD3RRDPndGv3mHUVOk+wbWH9aLW8K0w489W99KScxDWUWyk8qFDedMbAbu7DKO7
         +qC3gyL2gjiCtZQ/eudMdvlEtvdjxrLJJ27WAonIqFOx+incYvP5l0AcP3CLzjyZBP3K
         KnEXSjI51mSctj11u4kpiNcVNe+PqaYfx47lrGy06/dKTPjoBt1FwNlRAu/P86MIoKN/
         gUKgkbtegavYfTg54CLkDpU+tWaODdfHNUAV9Eies1D96g6uhYgU1FJt5w5B/qKmHnV6
         mCkSsqnRqHhwIfCk9MAUotykp1WbHwpxqoRrJd231L3+rXrGC6osH6q410xgENeEzu+g
         lfwQ==
X-Gm-Message-State: AOJu0YzHDgceuKnrGkl/cxQ82+BdgBfRPHqj55gabInnMpwnQhTbsIyW
	lX5fmAwAQKr0LQ4mxEHKhM02VdgQLpE6NGKXYQt/uj0Do0ubCEEyMefLLTVI89gub07bZvvWgH7
	p0Fo=
X-Google-Smtp-Source: AGHT+IG9O4A5niIGiT8o7ZDBERKjHd7T4hEqfA2o+YTkUqqA6o5GYuasd/6blKgVWsXmDxrmMpK/jA==
X-Received: by 2002:a17:907:1c22:b0:a7a:bece:6222 with SMTP id a640c23a62f3a-a866f14777bmr118932366b.10.1724239400773;
        Wed, 21 Aug 2024 04:23:20 -0700 (PDT)
Received: from lb01533.speedport.ip (p200300f00f051d5f269a60e7b8956185.dip0.t-ipconnect.de. [2003:f0:f05:1d5f:269a:60e7:b895:6185])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c65e7sm887934066b.20.2024.08.21.04.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:23:20 -0700 (PDT)
From: Md Haris Iqbal <haris.iqbal@ionos.com>
To: linux-rdma@vger.kernel.org
Cc: leon@kernel.org,
	jgg@ziepe.ca,
	haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
Subject: [PATCH v2 for-next 06/11] RDMA/rtrs-clt: Reset cid to con_num - 1 to stay in bounds
Date: Wed, 21 Aug 2024 13:22:12 +0200
Message-Id: <20240821112217.41827-7-haris.iqbal@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240821112217.41827-1-haris.iqbal@ionos.com>
References: <20240821112217.41827-1-haris.iqbal@ionos.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the function init_conns(), after the create_con() and create_cm() for
loop if something fails. In the cleanup for loop after the destroy tag, we
access out of bound memory because cid is set to clt_path->s.con_num.

This commits resets the cid to clt_path->s.con_num - 1, to stay in bounds
in the cleanup loop later.

Fixes: 6a98d71daea1 ("RDMA/rtrs: client: main functionality")
Signed-off-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
Signed-off-by: Grzegorz Prajsner <grzegorz.prajsner@ionos.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index e1557b0cda05..777f8e52ed7c 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -2347,6 +2347,12 @@ static int init_conns(struct rtrs_clt_path *clt_path)
 		if (err)
 			goto destroy;
 	}
+
+	/*
+	 * Set the cid to con_num - 1, since if we fail later, we want to stay in bounds.
+	 */
+	cid = clt_path->s.con_num - 1;
+
 	err = alloc_path_reqs(clt_path);
 	if (err)
 		goto destroy;
-- 
2.25.1


