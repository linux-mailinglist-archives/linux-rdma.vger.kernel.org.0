Return-Path: <linux-rdma+bounces-19366-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCiEAC0p32lpPgAAu9opvQ
	(envelope-from <linux-rdma+bounces-19366-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 07:59:09 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA35400AA1
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 07:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15DF2301F4A8
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Apr 2026 05:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE4D372EEA;
	Wed, 15 Apr 2026 05:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Z4RCqVA5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C868933985
	for <linux-rdma@vger.kernel.org>; Wed, 15 Apr 2026 05:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776232744; cv=none; b=Ex4I5HGXzHWJO7tl3hwiQAojIt94NDnQj0lVdu0KyOJZ/0TSwn8o1p1vzgyhd9kIp6wtd/nVelTh+Y3X1BzUsWrhxHKLhBlNTzoKNcCj1L2icJxqoXj8Mz6jA10PP3WJJ5f9duRwKrUSLi+xUbf+848rl1F0+BmY6LuDgqlWTKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776232744; c=relaxed/simple;
	bh=qGF8ox625oN0iKA5bYZn4v8VbD968lXzf84gcEt6Q7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kYtFSwbinS1ABZ7gCEWUu3vSbUIzATrLHGl0LlK4iuss9fcyf56V2vl091ZodOuRlmmP0c/tB6BtA063/O7JzCI9BvzzeKDe4Vj6AUmvSfNJi1qny1AtFspkb6oIHmSpemdb80l8AADGxdOGxwO8VuB/eXE5B+37aH/nKKPXQDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Z4RCqVA5; arc=none smtp.client-ip=209.85.160.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-50d87c138e1so65613621cf.1
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 22:59:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776232742; x=1776837542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hnp581tzg3FAXtTYo8HD0ub5npF/o+7j23Ji1oXZ/Gw=;
        b=R9rfzzcD4skCmbw+l1++qbuuYfniuF5ejo3skG00QFmZCn9pAEzpLfUpT0F6wTsIg9
         jNhzhZTabxJsrVJnDV7Um16m/10BYn+BUfHjION2Jk6LcOaZttI2JPzMAzH5OhXh1Q34
         TBXDIT8RABHGQx0UvQMHkHWYgeUpHz1TZ1+ZUKSyCwqJ8W62fnkbxXcH2QBJfUIwcCsc
         +0+unZThG3uzRiVRvyepHAQyetg2UdaGLGP0dQryD4SxOrx56r0uXJSx2DBUClcyIaSW
         tQcCg6FTGDzYSmqZB2hDAgUeynHGYy706fVd479YnmJODI7py9C+O47AoK10SpztScy5
         IgUA==
X-Gm-Message-State: AOJu0YweCX0Ggi7V96+6Z+xsZkwt8pELcS0pupM4AxfBk7fKszLIe2aw
	lWariYkJN6MVIAfWN6FsbRuNEjd6vaBD6LMwdBQa6TGaR+rmzV/8a0crTN/WcnhdxyCH9m7Vnwv
	8k4O8UJADJtSv1ytD5wrBm/w4XUaONIEyJODPAnbFoN6Y6Z6gIUEwTFtGQ3atJmJLcMyQQJ2yZi
	4VOv/pCkp8yEFVDoPxPEVc/l33PvauXTGVUVleDritBlm79WMEz4QUkcCSC5+LjrWNXpvkLC/Rp
	s066IuwT+WHVzKfk3kFZe3fHvjl
X-Gm-Gg: AeBDievpDlnY23CcjGsBXfY7wrLhK8brG8JpxwTM9hxhglLSggnIh1VMOG/FzVusAM4
	tBw4r+jErQhQuVKt9fJZv9glWjBOkXrippKBfHmVHXf7vosDo/IW72CUhz/nJibfprR3o19XLre
	MhdFQaA+V9cTNUybH19gz0SMGeVu5fFxK0H6rGCXrqzEviHRkoe3zGXb0cc0dDoKbJcRHPC+eCJ
	xhXshGD4WswCv1uhdCQSYC90LiyAeVOCiWZe65+2TTxmAa1UElefx9Qc7wT29JhRRTBF1OF9aDO
	YnPvGEuAdT13S9ahuY71pk8uTNPtAjFKCYQ7XVLpg9rOSvYVyyzF+SzyoNGYuy0AxBwZlr2XaUQ
	YJhZOIMY9cY7k5z2x24QNDIc8U4g08lnb7r4yAACYitZa+71KbS65SiFtqBwjK7i12uv2lLqNGU
	e3ZWnpGqfPRIKPon1WVShVxTxB7ula4AsCCTp3WlTMaAhLi7F/KmwznFQbRB/Jjg/VBsct
X-Received: by 2002:ac8:5855:0:b0:50d:af01:63cb with SMTP id d75a77b69052e-50dd5c5f8e1mr303607741cf.50.1776232741649;
        Tue, 14 Apr 2026 22:59:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50e1af7dd9esm540971cf.13.2026.04.14.22.59.00
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2026 22:59:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2adef9d486bso58849725ad.2
        for <linux-rdma@vger.kernel.org>; Tue, 14 Apr 2026 22:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776232739; x=1776837539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hnp581tzg3FAXtTYo8HD0ub5npF/o+7j23Ji1oXZ/Gw=;
        b=Z4RCqVA5k8UVQjKGkH8UXR8Lyl4z4w46mWVl14LCev1JXwGI30x8fWMAiMPuAfUPsp
         tfoOy0ytz56GmnIe9us3f0opLUeZsKos//jo25Jj63g3YMMiLWfcGj8mBHMiC5wFsJuv
         yd2lJTDAzTPF6ztNmzEr6bOV0W8222ZbIYzdU=
X-Received: by 2002:a17:903:283:b0:2b4:5c0d:314b with SMTP id d9443c01a7336-2b45c0d3361mr114542625ad.38.1776232738754;
        Tue, 14 Apr 2026 22:58:58 -0700 (PDT)
X-Received: by 2002:a17:903:283:b0:2b4:5c0d:314b with SMTP id d9443c01a7336-2b45c0d3361mr114542415ad.38.1776232738212;
        Tue, 14 Apr 2026 22:58:58 -0700 (PDT)
Received: from dhcp-10-123-157-187.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b4780ef365sm8344825ad.1.2026.04.14.22.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 22:58:57 -0700 (PDT)
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: [PATCH rdma-next v3 0/7] RDMA/bnxt_re: Support QP uapi extensions
Date: Wed, 15 Apr 2026 11:19:50 +0530
Message-ID: <20260415054957.36745-1-sriharsha.basavapatna@broadcom.com>
X-Mailer: git-send-email 2.51.2.636.ga99f379adf
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[broadcom.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19366-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5BA35400AA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

This patchset adds QP uapi extensions to the bnxt_re driver.
This is required by applications that need to manage some of the
RDMA HW resources directly and to implement the datapath in the
application.

This series supports application allocated memory for QPs.
The application takes into account SQ/RQ ring sizing constraints
(extra entries, rounding up etc) while allocating this memory.
The driver should avoid duplicating this logic while creating
these QPs.

uAPI changes in this series:
- Patch#4: new uapi parameter 'sq_npsn' in bnxt_re_qp_req.
- Patch#6: new driver specific attribute 'DBR_HANDLE' for doorbell region.
- Patch#7: new comp_mask 'APP_ALLOCATED_QP_ENABLE' in bnxt_re_qp_req.

Patch#1 Refactor bnxt_re_init_user_qp()
Patch#2 Update rq depth for app allocated QPs
Patch#3 Update sq depth for app allocated QPs
Patch#4 Update msn table size for app allocated QPs
Patch#5 Update hwq depth for app allocated QPs
Patch#6 Support doorbells for app allocated QPs
Patch#7 Enable app allocated QPs 

Thanks,
-Harsha

******

Changes:

v3:
- Removed umem patch from the series, that is dependent on uverbs support.
- Patch#7: Process DBR_HANDLE attr regardless of app_qp comp_mask.

v2:
- Rebased to umem_list uverbs patch series:
  https://patchwork.kernel.org/project/linux-rdma/cover/20260325150048.168341-1-jiri@resnulli.us/
- Deleted Patch#9; create_qp_umem devop is not supported.

v2: https://lore.kernel.org/linux-rdma/20260327091755.47754-1-sriharsha.basavapatna@broadcom.com/
v1: https://lore.kernel.org/linux-rdma/20260320135437.48716-1-sriharsha.basavapatna@broadcom.com/

******

Sriharsha Basavapatna (7):
  RDMA/bnxt_re: Refactor bnxt_re_init_user_qp()
  RDMA/bnxt_re: Update rq depth for app allocated QPs
  RDMA/bnxt_re: Update sq depth for app allocated QPs
  RDMA/bnxt_re: Update msn table size for app allocated QPs
  RDMA/bnxt_re: Update hwq depth for app allocated QPs
  RDMA/bnxt_re: Support doorbells for app allocated QPs
  RDMA/bnxt_re: Enable app allocated QPs

 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 270 +++++++++++++++--------
 drivers/infiniband/hw/bnxt_re/ib_verbs.h |   1 +
 drivers/infiniband/hw/bnxt_re/uapi.c     |  18 ++
 include/uapi/rdma/bnxt_re-abi.h          |   6 +
 4 files changed, 206 insertions(+), 89 deletions(-)

-- 
2.51.2.636.ga99f379adf


