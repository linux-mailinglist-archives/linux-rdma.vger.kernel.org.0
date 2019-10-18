Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD56BDBF9D
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Oct 2019 10:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442179AbfJRIQC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Oct 2019 04:16:02 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44371 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731008AbfJRIQC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Oct 2019 04:16:02 -0400
Received: by mail-pl1-f196.google.com with SMTP id q15so2471812pll.11;
        Fri, 18 Oct 2019 01:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M3S4yTtVgaNC9BkQRuSaEuAlwVVJJ6jYNkihyhEpRi8=;
        b=idopb+em4RetH9GiUvFvJK761YLj4h6/AlCEqA6bzDqYMWGLNUahqbQH6A69wIQsDT
         hGUNY4MnXEekB51MQ8sI59BW/kyjexIGJ27cjEtI5itCrGT05nVYV1OaFaEroBFeGMaG
         eJ22SaHega6SqNDS+lIcWSOr1k5ibLmeJaJgDUIVnz2whel16FRvcsc3ELS39qvMbq4t
         MR6mf+Egztb99o9k/MJeOkKYfNR/6m2xs+Lk93ZwnZ8ivpWphIuUT6XJoRLZGrCQjR/2
         2KJ7MUOXFIZHIi0TTCDKvTHAniMnSSF061ZM/nRfh5OLP1gEuyhNu6XRAt129699POlC
         qQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M3S4yTtVgaNC9BkQRuSaEuAlwVVJJ6jYNkihyhEpRi8=;
        b=NKpuxb/t14ngqbPUwZUUxiu0AXo7xLpDVOQLJ5WHN7ml0FcoZWDetjifI9V1xJ/4po
         /0KGV5Vf90WvFJ55ueFE/hWmEYgcCzyV8t8Pdo+ytVlu1KG1A/ylDwn+IV4Gn3hzAZjE
         r9LeuMm4+DMwASGlUDgCoXuM6SLkeZhyJV77BUkuk+KqvIcTaN7oF1/7D4D459Dw1U+s
         2Ec4rgBUSAQzoD9rqG22E3jLFEpibGZdNVufRiSdhRP8hix1cP6rTzbilp5KK996jdrD
         DiVHlLXhY8tLntnMBnnU0Woh2khNCTi/6i8LBMb954rwaRfuwg5JzpiMIu9JjSLkzUBM
         PY+w==
X-Gm-Message-State: APjAAAVdkhABs725Hn2+3XkiGrGOXb9DPKWCMHvqhwoc2M2tiTWYNXTH
        6aEcyrmCyjq3+izxw49qaw7/EOEc6NQ=
X-Google-Smtp-Source: APXvYqxOyPRwYYZarT0UfJktCM8UsTrZreWvRAg17Hy3LBgoxoEYTPHLs16Xe3qS9t4vyyElzAggng==
X-Received: by 2002:a17:902:bc41:: with SMTP id t1mr8649031plz.34.1571386561943;
        Fri, 18 Oct 2019 01:16:01 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([89.31.126.54])
        by smtp.gmail.com with ESMTPSA id e10sm7216574pfh.77.2019.10.18.01.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 01:16:01 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] IB/uverbs: Add a check for uverbs_attr_get
Date:   Fri, 18 Oct 2019 16:15:34 +0800
Message-Id: <20191018081533.8544-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Only uverbs_copy_to_struct_or_zero in uverbs_ioctl.c does not have a
check for uverbs_attr_get.
Although its usage in uverbs_response has a check for attr's validity,
UVERBS_HANDLER does not.
Therefore, it is better to add a check like other functions in
uverbs_ioctl.c.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/infiniband/core/uverbs_ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_ioctl.c b/drivers/infiniband/core/uverbs_ioctl.c
index 61758201d9b2..269938f59d3f 100644
--- a/drivers/infiniband/core/uverbs_ioctl.c
+++ b/drivers/infiniband/core/uverbs_ioctl.c
@@ -795,6 +795,9 @@ int uverbs_copy_to_struct_or_zero(const struct uverbs_attr_bundle *bundle,
 {
 	const struct uverbs_attr *attr = uverbs_attr_get(bundle, idx);
 
+	if (IS_ERR(attr))
+		return PTR_ERR(attr);
+
 	if (size < attr->ptr_attr.len) {
 		if (clear_user(u64_to_user_ptr(attr->ptr_attr.data) + size,
 			       attr->ptr_attr.len - size))
-- 
2.20.1

