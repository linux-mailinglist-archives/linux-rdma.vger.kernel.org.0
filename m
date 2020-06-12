Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6D21F7DD4
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jun 2020 21:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgFLTyj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jun 2020 15:54:39 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:41436 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgFLTyi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jun 2020 15:54:38 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 49kBJY3gV5z9xN6l
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jun 2020 19:54:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7pb2iZgS1kln for <linux-rdma@vger.kernel.org>;
        Fri, 12 Jun 2020 14:54:37 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 49kBJY25dZz9xN6V
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jun 2020 14:54:37 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 49kBJY25dZz9xN6V
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 49kBJY25dZz9xN6V
Received: by mail-io1-f72.google.com with SMTP id c5so6782851iok.18
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jun 2020 12:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KVNEopejGTcquUzpholqEMyuQDrUJhXxHJx5sPEa/is=;
        b=RGOBe2C5HrCbXKC28ByOVDr8j1J4cDTQVN3GtugZW/o2E/sTrXC2FAn2Lk8+CtNMuZ
         ha15zgGasOcZbIvJvOozIp7UgqDsRSaVG1wzN/BQfypCHL9W1pVzKHTN8to0+GkuFCnQ
         TCFD5V9BozUfF+LzG4SmyF2wHJIr0BLzsb9Reorp5i7wX2WCKGyWbYJz14S0B/pD5tOH
         Ax7Mpy7cgAmw3Tt2JSk9SIPVmXUZCHkJYAB3BBpkUB9nV16E81pyiEBogtswlNu3jVLU
         oTuDp9vhjjfYUrFi5/YLhhFmSOJJY6AwqUEK+GO9UGLHd5GZgkneSsmtZAD5d4xfJybK
         UjKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KVNEopejGTcquUzpholqEMyuQDrUJhXxHJx5sPEa/is=;
        b=S/PzpmbRdDwwd0+fwzwPa+zzmprOEBtdOw/QHtavoacqq9fCTPmEsUxYL39uZEN174
         A47qWKC9aebEt51/r7lSq75eeizwZ0S1ypgYa8kmT0VhHtWCQ6ijECoHERbSsuHEbSC0
         ttHfdNObWlv6arjTDEghGSPO7njnguOBdkim6DiSGim2fPrraGBjgw30cXHkFSt4KUiW
         dHPmcJBTUotmO5eUdZDEGRF+QdQNEOJ/xHvgPH9nmaTARG9yMSFjuioIKncKkWYEGqmG
         HhGlSQ3GcfaH+AQj57iVGOehDIECbFx23o6+m+xLGC1yyy6+d/Cvci8yybIJuWwkY7Jb
         0X1A==
X-Gm-Message-State: AOAM5314P71gHJUVnmFQrykAg05mgNNcTokiMmrVesBpdaP03/FS6LpI
        rXA/47EyWeWsHkHIYfIg4qyFlxzm3btVzPLf4C9Tr1BiLAjdmB8qwV2iby/IRWdknxfUbt4K1Az
        yYcnNhVjbsEjnHYfilJEcmNN5Jw==
X-Received: by 2002:a05:6e02:6c9:: with SMTP id p9mr13783914ils.185.1591991676901;
        Fri, 12 Jun 2020 12:54:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJv1BxyuEFAefrdvOCv2COicwn4idUnD3ytLomV6kVXKtkyonUXgIPxGUe+T5+I9OVlVjvzA==
X-Received: by 2002:a05:6e02:6c9:: with SMTP id p9mr13783908ils.185.1591991676748;
        Fri, 12 Jun 2020 12:54:36 -0700 (PDT)
Received: from piston-t1.hsd1.mn.comcast.net ([2601:445:4380:5b90:79cf:2597:a8f1:4c97])
        by smtp.googlemail.com with ESMTPSA id c1sm3479728ilh.35.2020.06.12.12.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 12:54:36 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, wu000273@umn.edu,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/rvt: Fix potential memory leak caused by rvt_alloc_rq
Date:   Fri, 12 Jun 2020 14:54:26 -0500
Message-Id: <20200612195426.54133-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In case of failure of alloc_ud_wq_attr, the memory allocated by
rvt_alloc_rq() is not freed. The patch fixes this issue by
calling rvt_free_rq().

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/infiniband/sw/rdmavt/qp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 511b72809e14..17ea7da73bf9 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1203,6 +1203,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 			qp->s_flags = RVT_S_SIGNAL_REQ_WR;
 		err = alloc_ud_wq_attr(qp, rdi->dparms.node);
 		if (err) {
+			rvt_free_rq(&qp->r_rq);
 			ret = (ERR_PTR(err));
 			goto bail_driver_priv;
 		}
-- 
2.25.1

