Return-Path: <linux-rdma+bounces-14412-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F09C51052
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 08:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91DD3B7FB7
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Nov 2025 07:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674012EDD50;
	Wed, 12 Nov 2025 07:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdKdpMlF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C339B2DCC03
	for <linux-rdma@vger.kernel.org>; Wed, 12 Nov 2025 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762933653; cv=none; b=qyNEXDGOgr/EktiKk5scGt7LkF9hq8eAoiclFKujMu0P+agRJmkLqa3KCsuRWyr2PxpHD+2ccvpoRlUIaiRbSj5dYdwO8VXdG8VwvjUEswrHMB4HIibJjJMg/jvBB7lL+vk8KqmhHquCnRALCLIdWH5QhTVupNploa2bYokll6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762933653; c=relaxed/simple;
	bh=N2srVn5ft8rrLUU2LxtJ7kYPfjxO14iedItRd7WbfjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TQpA6gCX20BhSEj4qxBqxvcWZrHzFE7el4tfGdbEc8ELEmjo8VQiA8kSiiIpZXh3j0ctC9H5Q8GM6xfjyRvWuCV5mLXSqa/0itVbWpL4GFxrF3TNXFXA6me7ZieHS5hpkjpPABydThox2sB78WRoFPONgztk7csrDwjMN3jIXqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdKdpMlF; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7ae4656d6e4so650948b3a.1
        for <linux-rdma@vger.kernel.org>; Tue, 11 Nov 2025 23:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762933651; x=1763538451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TLKuQP1AX/IkdkuwdwbT9+zxaZwxScPhJnRXzeMQssI=;
        b=MdKdpMlFwtTCkI3Z04nkYvXjPKgi9ZHZ9GngbDRqi5vxgsw58jok+Th/xDWppK0/CG
         ZpDPSh6rkC4k3i5nQIipneC/QpY/KsAhPo3ypSyW65zo3BTZFvUiXdueqcf53qnTdY0R
         HoAyW3+wpysfFdmRlCIZdy6T7D8Vtl3Ece/E1eQyN/fMnJFIPsS0Lrx5OMwLCe0Y7gKR
         Ol33JXjcpeIFT/DNuAaRbMsgAE/o+ySgn3kSoKjRpS3qERvIdyxsoPduQ0kJe9pNYSGV
         w8m8csZrcXEdsXbUnOEjl1e77nISFou2nWuckAViowwt/ShPXzbpQ/xQlZhB9CI1L0IU
         cbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762933651; x=1763538451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLKuQP1AX/IkdkuwdwbT9+zxaZwxScPhJnRXzeMQssI=;
        b=jI+YLlagv+Rsjqez8/LAid/dTWu1oroXYuFJ30G1P6kxBqr67vO0z+kKh9TGvxBUqi
         FLT0uAqNRQYyWuyeOw1MdjFkruhrJexBHFH1G0amrT/PS1KqoZGUps/476MGWF+7MpSr
         PpWkBJxnvhQjSeHuDRKCSxjh5Ne/gxnHTm2LdNcV80D1rREkOZhUOz6UQfJ/0YOmzyAQ
         cs5BMZln5lhDmP180VYzlYaC8BzHsxe+1IIRa8+njedVuW/CE1ViOpsEATubUK2ID/2F
         /08PvHJbgz5tWCe8sHbGw5qFbzF3P1XyCbvCvFaC3FGGp4/8ew20LZoUkiay1ngy/dZW
         ZAFQ==
X-Gm-Message-State: AOJu0Yz+qBkayjknISjVwOzxjVt3s3hUWFFyNI+k3Zy5V9TMKyhFjt3e
	U0QN50YfSB9Z4tXv/nQpTPMj6qgaNvpDE6qdVgqPfpJItSX8h0HxPUba
X-Gm-Gg: ASbGncsCuQkacbPypZpMj3Je3+aTNjDpJjse73e6ivMx29EFo/Rsgt4syNuk0w13xK8
	rgsUBW2jzI0VlFhVB6th2DFStvJaGS84d6O6mjRIaerfF+1ECwv7uDZwc4LcQXYipVp7/yN6Ht6
	0POs13k8Gl+xDpyaHTkMQ3VZzVANff1iSD/o42rxzffUbWX1dOC7YnENUMfc2ejLHBbbY+NBvSN
	79s1LPsZuEkOBdkSJK58sUOtatOs3eih54cb2FDkIvAX+kIYjaRgRykZOuDyufOUE/QFYN6MS2g
	EpGhr7SxJaTNZtNV5QSXlLuckka0IhhXsW6L0De6E0gz58gvOu+XtEAQW9TKsIX76QdpRwdmnjQ
	aPWYorANfLkZi03ECOJtwFtkp/NFP4UVOJObWRwb0VUB8oF7m9prkLTr4HLt0HC//ysbNFV44wL
	bH3303EG8QsF2SVT3zSDFv
X-Google-Smtp-Source: AGHT+IEzc8kFTKN/5uP4kOX7SlKaPkWcvzMYInvDfOzhEJ5HTSk3WJ1KU0r0QzloC42huJGx/DqarQ==
X-Received: by 2002:a05:6a20:a10a:b0:33f:4e3d:b004 with SMTP id adf61e73a8af0-3590b506614mr2649206637.47.1762933651118;
        Tue, 11 Nov 2025 23:47:31 -0800 (PST)
Received: from oslab.. (n11212047227.netvigator.com. [112.120.47.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9634f56sm17931628b3a.4.2025.11.11.23.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 23:47:30 -0800 (PST)
From: Tuo Li <islituo@gmail.com>
To: krzysztof.czurylo@intel.com,
	tatyana.e.nikolova@intel.com,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tuo Li <islituo@gmail.com>
Subject: [PATCH] RDMA/irdma: Fix possible null-pointer dereference in irdma_create_user_ah()
Date: Wed, 12 Nov 2025 15:45:12 +0800
Message-ID: <20251112074513.63321-1-islituo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable udata is checked at the beginning of irdma_create_user_as(),
indicating that it can be NULL:

  if (udata && udata->outlen < IRDMA_CREATE_AH_MIN_RESP_LEN)
    return -EINVAL;

However, if udata is NULL, a null-pointer dereference may occur when
calling ib_copy_to_udata():

  err = ib_copy_to_udata(udata, &uresp, min(sizeof(uresp), udata->outlen));

To prevent this possible null-pointer dereference, add a NULL check for
udata before calling ib_copy_to_udata().

Signed-off-by: Tuo Li <islituo@gmail.com>
---
 drivers/infiniband/hw/irdma/verbs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index c883c9ea5a83..01eccbbb9600 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -5233,7 +5233,8 @@ static int irdma_create_user_ah(struct ib_ah *ibah,
 	mutex_unlock(&iwdev->rf->ah_tbl_lock);
 
 	uresp.ah_id = ah->sc_ah.ah_info.ah_idx;
-	err = ib_copy_to_udata(udata, &uresp, min(sizeof(uresp), udata->outlen));
+	if (udata)
+		err = ib_copy_to_udata(udata, &uresp, min(sizeof(uresp), udata->outlen));
 	if (err)
 		irdma_destroy_ah(ibah, attr->flags);
 
-- 
2.43.0


