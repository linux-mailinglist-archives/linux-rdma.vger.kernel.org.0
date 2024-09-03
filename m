Return-Path: <linux-rdma+bounces-4724-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4727969C78
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 13:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C821C23740
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 11:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26451B984D;
	Tue,  3 Sep 2024 11:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F+9KbSns"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576EF1A42A5
	for <linux-rdma@vger.kernel.org>; Tue,  3 Sep 2024 11:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725364313; cv=none; b=f57ku1ETwXHC6TQwjCAm78E5h3WPKII6m+kzD5mT+y0hY8y9NcS6mrib23XvN0ktzOsIu+S3XxxZVWZzC3uD+6CoNlasisdHrlD2H0KYShJYnAjjuTwkM3TH3Fn12WiOUIRPmczS7Bxz/OE6bmQ5rAcf2K2UetHjhcPqwm78HXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725364313; c=relaxed/simple;
	bh=3+9GLi12i64L17l99b8brhrQgzSyCX2nEX4GjnFZKSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gG6gS65j333JFHJVqA+7c8ZIngZJtbIv2zlkbcP3axx3Jyt5fYi+cTFqlhy0mfW1H8NKXrNus6q7lmAsEE5gyQTnvxwCVqe5B6rsvd04LhbJwfGZHbAPa4+4L5ogyCQFOCwd/ePH8O7gldnmRYfl0jRcnBD7zLNZnsBXDrHVUKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F+9KbSns; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7176212de5cso1102617b3a.0
        for <linux-rdma@vger.kernel.org>; Tue, 03 Sep 2024 04:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1725364312; x=1725969112; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ro7hSRKb5fAPixSSCSQtU0bQSbW1z0mLonx53tD/Kk0=;
        b=F+9KbSnsRcl9OZIXamUwbBKHnO7NBS0DtfG0F/aQ0oTJXmNMt2ZID/+vC/VCFxO7mk
         Z7RNZODFqKh7/+FQR6GEFBPcOZRUdhIAFAzwh2/n501vQNzDApA2h04Moe/5cxnNmBAO
         5tYVh/cTp98LiIosipbPphNYMe15EuP1KXeJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725364312; x=1725969112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ro7hSRKb5fAPixSSCSQtU0bQSbW1z0mLonx53tD/Kk0=;
        b=e2ERdNPYC354nXvxd1ZRfejuxN3bT5wFFiUNH7SvSUIkMGLhQVkDmPKBl4fSVXkdxt
         86cK0DZJ1I1xuXLbzrvocYgic2NBWG3dqPspyUcIfgTpXDtEgiNYCrPv+XfmvpxDV21g
         RiBdBgxW5yV5O6JRyFJlcK02iSe1pbArCazyhBcKbATAVUO1UYg5ho9aEttFNmyUIt3M
         mMoO/5qbTf/zgzipEhrN5y2jApjjzawvwx6oZpKiSPbxa+1CFfNc5L1NobCkJo9BbBwd
         1jH8MZvrqmyr4fYZ1i4lkXknxaa59uaoDp3c4MR+KFaU5mr/4rD0/bvtVFdL8becuJB2
         1ZIA==
X-Gm-Message-State: AOJu0YyoQTTFne5TwJa1GqW51YPzBo2M1u0fA0/aP2P1k/b6KkP8mAs4
	cT9z5yKpkxVXBFFTf7We5PRqbPNqrZG1fRryUDWJa9QdVHQyioRTALLeBtEdjA==
X-Google-Smtp-Source: AGHT+IGbOa3dzEAGLRL96vE7N7jCXWKlzLMHQs1QTJo2ZS5XWxuSOuucekgIJhCotHyZVLhM0kt7Rw==
X-Received: by 2002:a05:6a21:386:b0:1c4:ce43:7dd1 with SMTP id adf61e73a8af0-1cece503b0dmr10279157637.20.1725364311660;
        Tue, 03 Sep 2024 04:51:51 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20532b81016sm62077335ad.226.2024.09.03.04.51.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2024 04:51:51 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 4/4] RDMA/bnxt_re: Enable ECN marking by default
Date: Tue,  3 Sep 2024 04:30:51 -0700
Message-Id: <1725363051-19268-5-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1725363051-19268-1-git-send-email-selvin.xavier@broadcom.com>
References: <1725363051-19268-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

To mark the packet as ECN capable, driver need to enable
the configuration during the driver load. Enable this
along with enabling the congestion control feature.

Fixes: f13bcef04ba0 ("RDMA/bnxt_re: Enable congestion control by default")
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index e13c0cc..4eac6b8 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2003,6 +2003,7 @@ static void bnxt_re_setup_cc(struct bnxt_re_dev *rdev, bool enable)
 		return;
 
 	if (enable) {
+		cc_param.tos_ecn = 1;
 		cc_param.enable  = 1;
 		cc_param.cc_mode = CMDQ_MODIFY_ROCE_CC_CC_MODE_PROBABILISTIC_CC_MODE;
 	}
-- 
2.5.5


