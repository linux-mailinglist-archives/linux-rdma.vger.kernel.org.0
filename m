Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8E81DF452
	for <lists+linux-rdma@lfdr.de>; Sat, 23 May 2020 05:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387505AbgEWDFI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 May 2020 23:05:08 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:36086 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387481AbgEWDFG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 May 2020 23:05:06 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49TSry12n8z9vfWK
        for <linux-rdma@vger.kernel.org>; Sat, 23 May 2020 03:05:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id W5p9sMpHs7ao for <linux-rdma@vger.kernel.org>;
        Fri, 22 May 2020 22:05:06 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49TSrx6VWTz9vfW1
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 22:05:05 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49TSrx6VWTz9vfW1
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49TSrx6VWTz9vfW1
Received: by mail-io1-f69.google.com with SMTP id d10so8662185iod.6
        for <linux-rdma@vger.kernel.org>; Fri, 22 May 2020 20:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r4APjft/5VvetHiIznyWdv2vIr+e1uIVsN6rb4yHlPI=;
        b=VA99b1HY2OCME05zDpyX6XVw4kEAgvxKrRRUhYAOhFIiAu9+SLhhd/tLM2GxxOpNpR
         OIQq93cVOn6cqM838gyozL2a8kyd1x2LmwqNEdBdXNYPJcrumXQzlNy8kgvg89XW55iH
         N/F80sFaONQsq+a8J+vO2YWCiqg1hohgaZLoZ9vYfnouwXZWWxdzOKxbJOjP3K6QXqpy
         pPFjeJ3/IU8AnBJQCVIkOEHgM1ihLkN403Di/x4NR1BgYh1h5a07VQQj4kT/ymhcFi2A
         SAtUggp2julTWCrxn3J6H6Mn2LcR3y1mWWCCTP2uNIjIBoRPcKhdgKRS+bBcRNT6tM45
         /HBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r4APjft/5VvetHiIznyWdv2vIr+e1uIVsN6rb4yHlPI=;
        b=oXtURcSBSkqnAhY2i1nrJW3Gr0SmfvyDK2pFNsM873DDZzQCyDQNskp1yPMUIoVFUU
         TCHteJxNs60gjVN0vlf3hy69QcOExkzjqvpLvXbii7AKz9CLeN67cVy5cqzXUI4AM8Mn
         tS07ziMjmvDS75V1wm+0d8z5Rn92w9zGaO2yeVw1UUj4HSoY5dyZMiQMA5ScT9NKbl0Z
         dgUV1vJ8F1STKCpaSuTuR76pq2L0+wOwonVBSSk7Ahgq7RC3QuWJXZ72RKP95UZTIZM3
         r7lk2JAx7bWwmCTkQqn/KBDNedArLTTe3tT7JvSNjXHhNArACFCpEBLOm/jZKLDZ044l
         V4iw==
X-Gm-Message-State: AOAM530InlHLXevsbAQ4rCoxm52YXTy9dpSoJze+P78WuACkcdy8WFBF
        lf1ep7IIk6QIjU0YYaGLLDBhvSpNRgTue+liQ0/MO/IWMt2sSuq84aaAYr7GiaA8PYgNoD5/7sE
        2tP2Ulk8okW4tjlg6dfETQdLZWw==
X-Received: by 2002:a92:a199:: with SMTP id b25mr16770653ill.77.1590203105492;
        Fri, 22 May 2020 20:05:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJysOKS8U5syUfh/x1v52pLjo8By1qmPmyAxMt2dObO1CEXzbBkpWlS4XnWTRgSZkVNwW2OCLg==
X-Received: by 2002:a92:a199:: with SMTP id b25mr16770629ill.77.1590203105129;
        Fri, 22 May 2020 20:05:05 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id q78sm5634989ilb.25.2020.05.22.20.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 20:05:04 -0700 (PDT)
From:   wu000273@umn.edu
To:     aditr@vmware.com
Cc:     pv-drivers@vmware.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH] RDMA: fix missing pci disable in pvrdma_pci_probe()
Date:   Fri, 22 May 2020 22:04:57 -0500
Message-Id: <20200523030457.16160-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

In function pvrdma_pci_probe(), pdev was not disabled in one error
path. Thus replace the jump target “err_free_device” by
"err_disable_pdev".

Fixes: 29c8d9eba550 ("IB: Add vmw_pvrdma driver")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
index e580ae9cc55a..780fd2dfc07e 100644
--- a/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
+++ b/drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c
@@ -829,7 +829,7 @@ static int pvrdma_pci_probe(struct pci_dev *pdev,
 	    !(pci_resource_flags(pdev, 1) & IORESOURCE_MEM)) {
 		dev_err(&pdev->dev, "PCI BAR region not MMIO\n");
 		ret = -ENOMEM;
-		goto err_free_device;
+		goto err_disable_pdev;
 	}
 
 	ret = pci_request_regions(pdev, DRV_NAME);
-- 
2.17.1

