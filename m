Return-Path: <linux-rdma+bounces-20982-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHpVON2ADGpPigUAu9opvQ
	(envelope-from <linux-rdma+bounces-20982-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:25:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57899581652
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 17:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 289023124793
	for <lists+linux-rdma@lfdr.de>; Tue, 19 May 2026 15:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C963290A5;
	Tue, 19 May 2026 15:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GQLyFltM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com [209.85.161.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C1B320A04
	for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 15:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203427; cv=none; b=On5bKoAM4huVRkmOvoAM26kkuQqSeamf+VXyW8jQBNWY1QwYww3lrXrPgbMqppDm54ypHTq1s8cgQeL6gjuIJJS78m1as2FJtD0fntOEz5KMfFRpkA5qEjWTy4FdNYIprV077sXVT2DdFtf4eIOTI3PuUMc7DZU98e9quT9V8hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203427; c=relaxed/simple;
	bh=aGJ1+LBPIbrXk4bpVEq0C3sOKOdnqKLoNquNhgw/iVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iNs6Pd2B4ZytFtHewoPV4Gs/ja1FkLnz/rwxvwVI8Pzc8ZlE5XDV1CrLnYZjMLH6eqjt2x8FMha6BaPOWTkd8yIdrOOPMlSiDtY2Ad8cWXBExSzGOLGPchXAV9BhRmxkA/AGj0nCvtyRzTyGon958S05q4/QkxkNzpAA1CL+noA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GQLyFltM; arc=none smtp.client-ip=209.85.161.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f97.google.com with SMTP id 006d021491bc7-6949831a7bcso2000698eaf.1
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 08:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779203422; x=1779808222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xNQPNXWIzERsFWVlxe/+Ze8r9dN0wEIfV+uG01eiF08=;
        b=PtY3FiVqTAJxGfJu0VXeECfHb8u86+oUKZLujX4JbKSFN8nEvpKilNWdQOANoHDq1u
         zRi6b6XICO1hdUKYMkwEWSYYhPuPk2eeaAPm0RattFnzCfDGb2SxFG+tzByJU20N8cxj
         46eEvKKAZ9Dm0RH4hAevGp7mbTaLuG/2yoKrzmdMucktJKuPJVnDzO8xIW/4IA+62+Zr
         +foYj7tJql1LYoxf3Kf0DiIGCff9EBIjXxZqBOOFbhTAa9P7ZmufFup/e1Gr+aUAxqM0
         zosEn6/Txt8kUHuPpTi7/8Mr9ipp5LiApjImaQ29gjKgQHb4i11L0KDoDqMB3cXxFPom
         0RmQ==
X-Gm-Message-State: AOJu0Yx+kofl6tG0YMzHgkRJ6iLv4LNz4JFgshpY+zzHKiZeyigCHyvN
	SbHBZ2KrSipKyQTjl5Bz+flyX0yOxfXne/ydM1NjQ2K4advTSwavT0zXcOvxYjYxirV4crzWKLC
	lhmPXtcER7GIC5K4HbTZHCMGgfpVoL550U7JJrBK+rG4tBaVzxVeeFqQPKZPN1VExIuiDn/mbqe
	vNd0wZQQuoYvFZNB8SnLCB32sznGU7HGghm7JaDvjJa8a5VvqJKP0d4riDWz23IF4s6a5HZM2rk
	fpqqRPKCHUwT09D6YuAuvebyNeR
X-Gm-Gg: Acq92OEQ/L/g2cIcoPLwWADUpAM6frQaCXcGWcJsreXF4zBVdc/F0DyKS+aTBkw1Ylu
	HWG4qG1DXZs5jRBUlK6CNdkDC51JxpJDpq0eZrjnXboVzuuOtSBxJM1Tlkb6sR2qema4n9gFPMu
	d7pjVVMRs+NSN1nWjxw+b0oSWvDuf/8Smdrm1lzvQCNtFaAQY31nCyr9/GgXR5nmevznjCbYrNe
	54h81ehauiHQADY1FvLgsayzAxtPk7kUbUqCCnIYD1NhcR+/MNZTtuzUSM2peIh1bv0ayz9E2UB
	dJfm5KL+nLI2f3fSmRz0JSqbbaIKzd9bJ0dCLuVH8f59lZkXduUjQ/87pSfZUAIMMzH0nW5kTur
	4R+kilU0JqlbvVEdDjzb1FATlDHEeVSJGizwDO0REpHqSnGfOHs8IpmnNagesEoT/CRoN6AF7Jj
	snl0QOY1/8nOrr2qtG
X-Received: by 2002:a05:6820:602:b0:688:c97d:bfc3 with SMTP id 006d021491bc7-69c9437cd86mr12462643eaf.38.1779203421933;
        Tue, 19 May 2026 08:10:21 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-69d048d1832sm721460eaf.29.2026.05.19.08.10.21
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2026 08:10:21 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2baf7748d0aso35374055ad.1
        for <linux-rdma@vger.kernel.org>; Tue, 19 May 2026 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779203420; x=1779808220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNQPNXWIzERsFWVlxe/+Ze8r9dN0wEIfV+uG01eiF08=;
        b=GQLyFltMELvcJ8JrXfjdB152Ym8bVy4isuU5gdtocg81MnUVro5ltHhPnZYkv4otq0
         sgzettDaWg0HXipzvg7RKMnwvaIcSrD9tgDMIFwdw9SSJHmZsDyws7XdS5DXy+H7Ilez
         J4EtHm7vCfDVPy75cA5n8ayi32CSm8Vn493hg=
X-Received: by 2002:a17:902:b7c6:b0:2bd:5a99:f293 with SMTP id d9443c01a7336-2bd7e8fdd4cmr138966245ad.21.1779203420483;
        Tue, 19 May 2026 08:10:20 -0700 (PDT)
X-Received: by 2002:a17:902:b7c6:b0:2bd:5a99:f293 with SMTP id d9443c01a7336-2bd7e8fdd4cmr138966005ad.21.1779203419963;
        Tue, 19 May 2026 08:10:19 -0700 (PDT)
Received: from dhcp-10-123-156-119.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d1062e9sm190739735ad.67.2026.05.19.08.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:10:19 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v7 7/9] RDMA/bnxt_re: Enhance dpi lifecycle logic in doorbell uapis
Date: Tue, 19 May 2026 20:30:39 +0530
Message-ID: <20260519150041.7251-8-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
In-Reply-To: <20260519150041.7251-1-sriharsha.basavapatna@broadcom.com>
References: <20260519150041.7251-1-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20982-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,broadcom.com:mid,broadcom.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 57899581652
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If the DPI is freed when the dbr object is freed, but if the
process has not unmapped the page yet, then the DPI slot could
get reallocated to another process while the original process
still has it mapped. To prevent this, save the DPI info in the
mmap entry during dbr allocation and free the DPI slot from
bnxt_re_mmap_free(), which enures that there are no references
to it.

This change is needed to support doorbell allocation to QPs
in the next patch.

Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c |  4 ++++
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |  2 ++
 drivers/infiniband/hw/bnxt_re/uapi.c     | 13 +++++++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 9fd85d81bcea..66cc4b3e1ef9 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -4943,6 +4943,10 @@ void bnxt_re_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
 	bnxt_entry = container_of(rdma_entry, struct bnxt_re_user_mmap_entry,
 				  rdma_entry);
 
+	if (bnxt_entry->dpi_valid)
+		bnxt_qplib_free_uc_dpi(&bnxt_entry->uctx->rdev->qplib_res,
+				       &bnxt_entry->dpi);
+
 	kfree(bnxt_entry);
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.h b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
index 13dac48ed453..6a5bcc3fb289 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.h
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.h
@@ -161,6 +161,8 @@ struct bnxt_re_user_mmap_entry {
 	struct bnxt_re_ucontext *uctx;
 	u64 mem_offset;
 	u8 mmap_flag;
+	bool dpi_valid;
+	struct bnxt_qplib_dpi dpi;
 };
 
 struct bnxt_re_dbr_obj {
diff --git a/drivers/infiniband/hw/bnxt_re/uapi.c b/drivers/infiniband/hw/bnxt_re/uapi.c
index b8fc8bfba2ad..1d44d6225da0 100644
--- a/drivers/infiniband/hw/bnxt_re/uapi.c
+++ b/drivers/infiniband/hw/bnxt_re/uapi.c
@@ -368,6 +368,13 @@ static int UVERBS_HANDLER(BNXT_RE_METHOD_DBR_ALLOC)(struct uverbs_attr_bundle *a
 		goto free_dpi;
 	}
 
+	/* Save DPI info to the mmap entry so that bnxt_re_mmap_free()
+	 * can free the DPI slot only after the last reference to the
+	 * mmap entry is released.
+	 */
+	obj->entry->dpi = *dpi;
+	obj->entry->dpi_valid = true;
+
 	obj->rdev = rdev;
 	kref_init(&obj->usecnt);
 	uobj->object = obj;
@@ -396,10 +403,12 @@ void bnxt_re_dbr_kref_release(struct kref *ref)
 {
 	struct bnxt_re_dbr_obj *obj =
 		container_of(ref, struct bnxt_re_dbr_obj, usecnt);
-	struct bnxt_re_dev *rdev = obj->rdev;
 
+	/* Drop the driver's reference to the mmap entry (_remove()).
+	 * The DPI slot gets freed from bnxt_re_mmap_free() only
+	 * when there's no VMA mapping reference to it.
+	 */
 	rdma_user_mmap_entry_remove(&obj->entry->rdma_entry);
-	bnxt_qplib_free_uc_dpi(&rdev->qplib_res, &obj->dpi);
 	kfree(obj);
 }
 
-- 
2.51.2.636.ga99f379adf


