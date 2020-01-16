Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB7CF13FC2A
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 23:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbgAPW1R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 17:27:17 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46106 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbgAPW1R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 17:27:17 -0500
Received: by mail-ot1-f65.google.com with SMTP id r9so20901309otp.13;
        Thu, 16 Jan 2020 14:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iSl/iz8q5qsynSrNKHIQvHUN+GEAmInTpvYEYnskbhI=;
        b=tQJWWE+aXJ7Q4PQlKya0EvRWlTVBsEAQxCUciiydmJ0zAadyfj/YO0XajNeBIEgEM5
         m31QFefRbLVzSESQvsL5jAAya91YemMAr3ap9SvX7qX8YT8IMZ4PVIdHEWXkYHuHN30W
         VVvFISoOixhkg8amsKwCYpz8WPStm6v5KGpN2mDZfe7S8iB0uAxA3o6EdJ/L1aKyC+cv
         Su6aGd8HJ+g12eSz6gk5SfrBO3YQXgeRwL7KqHNgdDFlqam8o6n08iHDDL8vwPrInSyy
         Zo5Hp8uCbJjCR1zC2BubBMAnbt2L6q8gfqkg3QQ5iQ9RIAfjGrUk4ka0FV8VnigLv+pi
         g4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iSl/iz8q5qsynSrNKHIQvHUN+GEAmInTpvYEYnskbhI=;
        b=cmZpxXMow0d6TUm6O5BFOk44hnYmg8uq1+bjVcquKnnwEOe/LU0DV7U7YMXtawNYUe
         of3lEEtOkqzC7RAI4Mvu7+iAB38XDc4MheiE3cywVkGTVj0QGsnNCHwYMxSN3LCpgk/b
         +VMBt4rNGmsGWl7G0UtjVVR9R9/wNVldktQkXYwYKYvd/JHvU8n+wIBXmyRRd5bJ0kc4
         EDFXDqhd+Uv+W7kRZk5HvWm/KkoyPoQhyDlJbkjtQfJHyA8SJcLl9FzTGC9gLgqi9dh3
         gP7tH3I626PkLEFLE8Yy+fLva/wzKi8HltPNnuHjmdPKGtgeH52iV1P+voaumT7hHSl5
         7O4Q==
X-Gm-Message-State: APjAAAWN5461K+05ouS7R2Pt4lIzhqaOmlhdgyeBaSAP1JNDPnfv+UnM
        9xh6UAHQ83qTHR9W+/d3+zM=
X-Google-Smtp-Source: APXvYqzFgJ0McJrahhe7vh2rOK8/NO5bak3ECkJ56UAVMeGC+zD/jnWt6BjxDAJVedX6AkXY0mFl5g==
X-Received: by 2002:a05:6830:128e:: with SMTP id z14mr3883578otp.184.1579213636587;
        Thu, 16 Jan 2020 14:27:16 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id i12sm8216172otk.11.2020.01.16.14.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 14:27:16 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] IB/hfi1: Fix logical condition in msix_request_irq
Date:   Thu, 16 Jan 2020 15:26:58 -0700
Message-Id: <20200116222658.5285-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Clang warns:

drivers/infiniband/hw/hfi1/msix.c:136:22: warning: overlapping
comparisons always evaluate to false [-Wtautological-overlap-compare]
        if (type < IRQ_SDMA && type >= IRQ_OTHER)
            ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
1 warning generated.

It is impossible for something to be less than 0 (IRQ_SDMA) and greater
than or equal to 3 (IRQ_OTHER) at the same time. A logical OR should
have been used to keep the same logic as before.

Link: https://github.com/ClangBuiltLinux/linux/issues/841
Fixes: 13d2a8384bd9 ("IB/hfi1: Decouple IRQ name from type")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/infiniband/hw/hfi1/msix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hfi1/msix.c b/drivers/infiniband/hw/hfi1/msix.c
index 4a620cf80588..db82db497b2c 100644
--- a/drivers/infiniband/hw/hfi1/msix.c
+++ b/drivers/infiniband/hw/hfi1/msix.c
@@ -133,7 +133,7 @@ static int msix_request_irq(struct hfi1_devdata *dd, void *arg,
 	if (nr == dd->msix_info.max_requested)
 		return -ENOSPC;
 
-	if (type < IRQ_SDMA && type >= IRQ_OTHER)
+	if (type < IRQ_SDMA || type >= IRQ_OTHER)
 		return -EINVAL;
 
 	irq = pci_irq_vector(dd->pcidev, nr);
-- 
2.25.0

