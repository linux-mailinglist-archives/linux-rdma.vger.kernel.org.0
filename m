Return-Path: <linux-rdma+bounces-16996-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KMusMquClWlrSAIAu9opvQ
	(envelope-from <linux-rdma+bounces-16996-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 10:13:15 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 453941549D3
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 10:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 117E0301C954
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 09:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7D0337689;
	Wed, 18 Feb 2026 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="UmRYZsgb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F236D3382F2
	for <linux-rdma@vger.kernel.org>; Wed, 18 Feb 2026 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771405987; cv=none; b=jbHKXYf9N+dhzv7bQlI1dQKTSBXyEzrc/jnN66XEBbHZm/SN30gx3Mux7Rq5bGsn2R+x6VQiXb0Grgbk8xuWx1JOBmiz0YHhGb7XgoT8B6SgnHaLjsF5TFRxxl5yTmajR7DkRuhbcqnIgzL7LS9Vo/M54XV1/3WWuUMoXIT3RUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771405987; c=relaxed/simple;
	bh=0ZfYaf+GmBnMi0kw8MXwJOUGz4ZwFUkKuPBrkrNdxP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=esS8iA7cmJkYFg31G7kPTzhlUM+4DraRdD3cphpozljG7mLcU4D2imqj8NSieNhs1kpe8Qm+eNn19Ma1yhU0JBO52ZdRjbrYU/6JNjYaTjcQAnqB+pqvOsFsrhEA1i6glkkfMYjFHRyuVY8eb54r8vjzxdeJEHw8PneRDKlLaO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=UmRYZsgb; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-7927b1620ddso9900747b3.0
        for <linux-rdma@vger.kernel.org>; Wed, 18 Feb 2026 01:13:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771405984; x=1772010784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NbkpC4jT1emlmDvZRtXyfTKMkSp8PU/HQV5dBGNuG58=;
        b=FsYmTho8yfgNGTAKrKqsN+CsVJhcqxB/tqfF0aeTCXV1jrzS85rCykmNDpxUlsa6aF
         HPrjTyqWOn32V2ylTs1jTh62BCp/7+6ZqLNYZXJwxHBU3lcsV2v2iJRfw18YqC+beaFh
         dcVDJkiKFwiUjyVWU7O1OlTSY34onb3fvQVpRSKdBeo+RY4r+0CgLuvM24acNXr+lG2q
         NQNNSqW9S1YxDdb8pJN0gUkDNEZREILAW9f2LAVSJ2stb8/DtrooAO2TDKsvv1LXiCFn
         6fb8hszNYvCLl2oxg6QrNEXGnI0TbM9KBJCJHWRDxtOSpHu1+g8RevO2VgwI0vaGTou0
         rjrg==
X-Gm-Message-State: AOJu0YxrlbgeEWooD55MeXz5D5z/LbzUcMe7a+TlNGqmU5m0RlYQyvKm
	rfnwQUG1UQxLod4nzBNOTU9vdb5Bh0j0XxF7e5RdrrePvqMmXgiac12Tny6kBt6qKORxzUOO/Jd
	d5USY1M6t1FsJgMFtWFPN0MS/20WLakMczm7XUz8MjHErAIeGIStpZPYveBrzsMrD55rRcsgbgp
	5HVCmZ2EKL8IJlO5/SPPsHJ6oV+Dt48Xs6ToRWjtE+lL/v0tcxDS6rkn/NOJ/klxkXCXODqY0s3
	XYeZnnD/PJvEBtf6Q==
X-Gm-Gg: AZuq6aIu4KXdTqVImUNUoNvQI3rKr1gS4N1i71QymyGiX/jZSS0NQVbEDkNSNQED/nB
	LQHs9Er2KteXPQbNtM6XqtSiabBasTGbbwG62NoWCjkHSCsfyElMwoeXec7b4CtEAj3LeDcMJj0
	zeG7LfwID8xuavWnj9Gnb6lAnKxYhXP41Vtvx7njOEqYgDHHfArwkgi7VBAwlxNFJ9kvRwl3Iw/
	qSDddBlJsyKVeALJ6vJ2XyVIjXYurg9k8dI9xYJCYvA8nhsxqDHFNkhbIec1WwStPpSy+61/c7b
	2fH7At6IuM+ShrpgLWq99ckNBBI6GInUrqia6O5rokmFxbv0PSdVWfbMrN2xwH4CMXKqt+poLCv
	GC76//md2Eg3Gaz690MzOjb8M1LsNu35q8FbIL2I9vMsY4reprbUdIrUKoG9AwtURV2qxrsxh+c
	I48NUTv1dnPDNJoMmsbAL45g3a5evSdA5IJxkljBEdMa+JfVj0Ak89V0QXqQ==
X-Received: by 2002:a05:690c:c4c9:b0:796:203c:681c with SMTP id 00721157ae682-797f6f4b46dmr7258747b3.5.1771405983778;
        Wed, 18 Feb 2026 01:13:03 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-797a5caeefbsm12521457b3.19.2026.02.18.01.13.03
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Feb 2026 01:13:03 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8cb413d0002so565535885a.1
        for <linux-rdma@vger.kernel.org>; Wed, 18 Feb 2026 01:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771405982; x=1772010782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NbkpC4jT1emlmDvZRtXyfTKMkSp8PU/HQV5dBGNuG58=;
        b=UmRYZsgb0Vx2uz4foegkEk57YzFa/MnVv7/xpKvYAic+G/JKsfTDc7Ont3C22jEW/u
         pZ1UwpLO+0Hfu8KecOVJjL43Nn3to0qMic/gYz5agEwGqZKlpmpI3jW+UuaWzUn3w47l
         wdLX1sQN6KtrZxsPL2pd7rKm6TQIAoqSu/uEk=
X-Received: by 2002:a05:620a:1919:b0:8ca:2ba8:b98a with SMTP id af79cd13be357-8cb74152a94mr113097085a.11.1771405982551;
        Wed, 18 Feb 2026 01:13:02 -0800 (PST)
X-Received: by 2002:a05:620a:1919:b0:8ca:2ba8:b98a with SMTP id af79cd13be357-8cb74152a94mr113095085a.11.1771405982051;
        Wed, 18 Feb 2026 01:13:02 -0800 (PST)
Received: from S1-NIC-server-2.broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cb4a395cf2sm1180245285a.18.2026.02.18.01.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 01:13:01 -0800 (PST)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH v3 2/2] RDMA/bng_re: Unwind bng_re_dev_init properly
Date: Wed, 18 Feb 2026 09:12:46 +0000
Message-Id: <20260218091246.1764808-3-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260218091246.1764808-1-siva.kallam@broadcom.com>
References: <20260218091246.1764808-1-siva.kallam@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16996-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,kernel.org,intel.com,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[siva.kallam@broadcom.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 453941549D3
X-Rspamd-Action: no action

Fix below smatch warning:
drivers/infiniband/hw/bng_re/bng_dev.c:270
bng_re_dev_init() warn: missing unwind goto?

Current bng_re_dev_init function is not having clear unwinding code.
So, added proper unwinding with ladder.

Fixes: 4f830cd8d7fe ("RDMA/bng_re: Add infrastructure for enabling Firmware channel")
Reported-by: Simon Horman <horms@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202601010413.sWadrQel-lkp@intel.com/
Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
---
 drivers/infiniband/hw/bng_re/bng_dev.c | 29 +++++++++++++-------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
index 0678aaecb3b5..fd0a4fe274ca 100644
--- a/drivers/infiniband/hw/bng_re/bng_dev.c
+++ b/drivers/infiniband/hw/bng_re/bng_dev.c
@@ -285,7 +285,7 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 	if (rc) {
 		ibdev_err(&rdev->ibdev,
 				"Failed to register with netedev: %#x\n", rc);
-		return -EINVAL;
+		goto reg_netdev_fail;
 	}
 
 	set_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
@@ -294,19 +294,16 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 		ibdev_err(&rdev->ibdev,
 			  "RoCE requires minimum 2 MSI-X vectors, but only %d reserved\n",
 			  rdev->aux_dev->auxr_info->msix_requested);
-		bnge_unregister_dev(rdev->aux_dev);
-		clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
-		return -EINVAL;
+		rc = -EINVAL;
+		goto msix_ctx_fail;
 	}
 	ibdev_dbg(&rdev->ibdev, "Got %d MSI-X vectors\n",
 		  rdev->aux_dev->auxr_info->msix_requested);
 
 	rc = bng_re_setup_chip_ctx(rdev);
 	if (rc) {
-		bnge_unregister_dev(rdev->aux_dev);
-		clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
 		ibdev_err(&rdev->ibdev, "Failed to get chip context\n");
-		return -EINVAL;
+		goto msix_ctx_fail;
 	}
 
 	bng_re_query_hwrm_version(rdev);
@@ -315,16 +312,14 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 	if (rc) {
 		ibdev_err(&rdev->ibdev,
 			  "Failed to allocate RCFW Channel: %#x\n", rc);
-		goto fail;
+		goto alloc_fw_chl_fail;
 	}
 
 	/* Allocate nq record memory */
 	rdev->nqr = kzalloc(sizeof(*rdev->nqr), GFP_KERNEL);
 	if (!rdev->nqr) {
-		bng_re_destroy_chip_ctx(rdev);
-		bnge_unregister_dev(rdev->aux_dev);
-		clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
-		return -ENOMEM;
+		rc = -ENOMEM;
+		goto nq_alloc_fail;
 	}
 
 	rdev->nqr->num_msix = rdev->aux_dev->auxr_info->msix_requested;
@@ -393,9 +388,15 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 free_ring:
 	bng_re_net_ring_free(rdev, rdev->rcfw.creq.ring_id, type);
 free_rcfw:
+	kfree(rdev->nqr);
+nq_alloc_fail:
 	bng_re_free_rcfw_channel(&rdev->rcfw);
-fail:
-	bng_re_dev_uninit(rdev);
+alloc_fw_chl_fail:
+	bng_re_destroy_chip_ctx(rdev);
+msix_ctx_fail:
+	bnge_unregister_dev(rdev->aux_dev);
+	clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags);
+reg_netdev_fail:
 	return rc;
 }
 
-- 
2.25.1


