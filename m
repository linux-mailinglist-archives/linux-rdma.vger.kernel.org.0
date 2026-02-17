Return-Path: <linux-rdma+bounces-16940-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YO6NGZfbk2k89QEAu9opvQ
	(envelope-from <linux-rdma+bounces-16940-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 04:08:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C86D514897A
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 04:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB0EB30160ED
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Feb 2026 03:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2E1248F72;
	Tue, 17 Feb 2026 03:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OBiUcVMx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5AB248880
	for <linux-rdma@vger.kernel.org>; Tue, 17 Feb 2026 03:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771297685; cv=none; b=DEmYRsotjp8wKvdRkUQGTKX793mNIUTcBlpA9Pu/GUicgSkCfQiu3dIPXN4WUyvma6lyegQ3Fn5w8RkXHxvSW5lYyD1fq0VguJNlvJevq0L7sjOyrrRl6vQOCgiUW0q1VqwMAh5Ym7bSBfepO18R1hxCZuhlNLvMMqNdmTpqpgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771297685; c=relaxed/simple;
	bh=3G14zlax5nQoBkvpVsposeAn6JfZ0ragHBqJDD9DoWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4kVIE6LqkQGIkRgJqtNkNI4lGbkS3gHb51FvVLdTib2RBoncXCpkrBWdit5jdYncOex269wYEOGkeaFK3NLoEtkGBnKOysBFRLGql9Kn3gXoJ+MB5jr9cNEJ84a7DgUBqKbwL89lRTBcTIqLW4jspHVkVUF1W4smlz39nTLTYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OBiUcVMx; arc=none smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-797afd2e872so20578887b3.0
        for <linux-rdma@vger.kernel.org>; Mon, 16 Feb 2026 19:08:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771297683; x=1771902483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yK34Oem95qlWbYo0PMQLEl08UdCfQXEhq8w4ZDdU1tE=;
        b=IA/sQ+EUQX/gljvApOihggm8r8fl1W0fQfdczpR57GfGqN3IKNLXPRibYt24UbUWia
         u/++30D6lWkBUZ13/monsDsPY+WwUyx31L6XsxUjlvv+WUDMHwyRWw5Io4X2yRhHSXmg
         dZG7aNFkiBa6puhm94T2WgBJCviqF+LymdTlBJnkx9xAJsondNmHaIBXx4LV5ShA10qC
         aL3KGllQwphFHLlSVuZ9Qa0MxkM0BjlJYDnb+1w0tu5RbPZ4lEV14WDANEkdMocEU0E6
         aDEeryq843hxvGXJ+BoxyHv2KWtawy7KFlhPq+X1kDAl4K933TQ1WCZHpJelW+RTzR+U
         NSTw==
X-Gm-Message-State: AOJu0YyMi0n4bw5tvvVmp6fkGETt5xOt79C0sKYxlKTXGI8017tCK7b5
	ALlckN6dmuxiTBdTay5nAx2jGuh1xf6EJAYBn/d87sluqfJUXANDYqYhz7ncwcS4F36k/4EyDtL
	woy/rhhsTw63Opwq0Jyay+YSxzf1EB0E1D1/wV7t/02TR+9st2sxF7bS2jdMta4d/qyMbUwOTJf
	MSJz/Ssx905mYQZ/20m9ntothrPKpCQJgnCWejqaur8Cu1Abk1ASnaPE7O3HF1pJINPrNDQvShL
	YuEceRn5SC8KdnfvQigBztk+gqh
X-Gm-Gg: AZuq6aKXQb1yCdBteGnz0kic7/IgfGw4TyoSJllaCOiNL4zJUSpzBMAKZVqpLvrpZaZ
	EeYYBNqtBk37LZ91gyfSTTnDEPnyaFDRfc4AHq6S7vmrdbMid4iKL8wJdPJmuXKzHLL2243OROb
	k/BxVn3P8RTZ0FcxbrdMpcYxHoSIJkOZiCEjuvTmidplUVWUYOa6MkNJr1Kevyi5FTVYieDYxA7
	+Sj5S1HTX0KzdH/E+VN4fOgYSnyCOvqhiiPv8LUrFpLSeLf6sPnKcmnPb4z9OwqDPVmiFfdTUu7
	TDXf+HqjW5tJr7KoAAQ6dTJC4OECQr4k3mGVnip5BOjXGzX8Iknw1llqeQY3fKrPVsLABEiVQy2
	F3toDK8pxnbFup4Ykb5uhc7zUklqNEN14PuZ0+n2OvUabHLFgZedZdK3LNmQ8KLNwbzFBvPhNdQ
	//rhTi52crZv3Wo5hNLFyKQOKBRMr7oGZ/IVCbwnVf5UYDg1nrduO9m9Wq9JgvHbNnZBMy4eE=
X-Received: by 2002:a05:690c:1a:b0:794:dac2:89de with SMTP id 00721157ae682-797ac51fbf8mr76148167b3.17.1771297683022;
        Mon, 16 Feb 2026 19:08:03 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7966c24c131sm16040747b3.24.2026.02.16.19.08.02
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Feb 2026 19:08:03 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-353c9d644b0so2675166a91.2
        for <linux-rdma@vger.kernel.org>; Mon, 16 Feb 2026 19:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771297682; x=1771902482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yK34Oem95qlWbYo0PMQLEl08UdCfQXEhq8w4ZDdU1tE=;
        b=OBiUcVMx2qU0nnZdUUiivkS7v/xpVwDuAIAx88CnREaplpCcLvBj7a0Xnhby4OTYu9
         iF5tOECAT0CJshy1Jwx4hmbiTP2/SF0/l2a91nTa2eAEF2uJGhgDxJBtRnW8Ovrp1SrH
         9VttqVZH8bC3eejgqpqDsLPyJ54/v06qogKVs=
X-Received: by 2002:a17:90b:1c0c:b0:356:2eac:b649 with SMTP id 98e67ed59e1d1-358448265e8mr8770383a91.7.1771297681794;
        Mon, 16 Feb 2026 19:08:01 -0800 (PST)
X-Received: by 2002:a17:90b:1c0c:b0:356:2eac:b649 with SMTP id 98e67ed59e1d1-358448265e8mr8770369a91.7.1771297681383;
        Mon, 16 Feb 2026 19:08:01 -0800 (PST)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662e537desm20688167a91.4.2026.02.16.19.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 19:08:00 -0800 (PST)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v13 6/6] RDMA/bnxt_re: Support application specific CQs
Date: Tue, 17 Feb 2026 08:29:10 +0530
Message-ID: <20260217025910.15865-7-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260217025910.15865-1-sriharsha.basavapatna@broadcom.com>
References: <20260217025910.15865-1-sriharsha.basavapatna@broadcom.com>
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
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16940-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C86D514897A
X-Rspamd-Action: no action

This patch supports application allocated memory for CQs.

The application allocates and manages the CQs directly. To support
this, the driver exports a new comp_mask to indicate direct control
of the CQ. When this comp_mask bit is set in the ureq, the driver
maps this application allocated CQ memory into hardware. As the
application manages this memory, the CQ depth ('cqe') passed by it
must be used as is and the driver shouldn't update it.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 6 +++++-
 include/uapi/rdma/bnxt_re-abi.h          | 7 ++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 8ab959d16551..c78535c5661f 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3401,10 +3401,14 @@ int bnxt_re_create_cq_umem(struct ib_cq *ibcq, const struct ib_cq_init_attr *att
 	if (entries > dev_attr->max_cq_wqes + 1)
 		entries = dev_attr->max_cq_wqes + 1;
 
-	rc = ib_copy_validate_udata_in(udata, req, cq_handle);
+	rc = ib_copy_validate_udata_in_cm(udata, req, cq_handle,
+					  BNXT_RE_CQ_FIXED_NUM_CQE_ENABLE);
 	if (rc)
 		return rc;
 
+	if (req.comp_mask & BNXT_RE_CQ_FIXED_NUM_CQE_ENABLE)
+		entries = cqe;
+
 	if (umem) {
 		cq->umem = umem;
 	} else {
diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
index 1f7685665db1..0f631c65c63d 100644
--- a/include/uapi/rdma/bnxt_re-abi.h
+++ b/include/uapi/rdma/bnxt_re-abi.h
@@ -103,12 +103,17 @@ struct bnxt_re_pd_resp {
 struct bnxt_re_cq_req {
 	__aligned_u64 cq_va;
 	__aligned_u64 cq_handle;
+	__aligned_u64 comp_mask;
 };
 
-enum bnxt_re_cq_mask {
+enum bnxt_re_resp_cq_mask {
 	BNXT_RE_CQ_TOGGLE_PAGE_SUPPORT = 0x1,
 };
 
+enum bnxt_re_req_cq_mask {
+	BNXT_RE_CQ_FIXED_NUM_CQE_ENABLE = 0x1,
+};
+
 struct bnxt_re_cq_resp {
 	__u32 cqid;
 	__u32 tail;
-- 
2.51.2.636.ga99f379adf


