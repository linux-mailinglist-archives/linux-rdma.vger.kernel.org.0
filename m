Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15FA41235F6
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Dec 2019 20:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfLQTxj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 17 Dec 2019 14:53:39 -0500
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:44716 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727492AbfLQTxi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 17 Dec 2019 14:53:38 -0500
X-Greylist: delayed 537 seconds by postgrey-1.27 at vger.kernel.org; Tue, 17 Dec 2019 14:53:38 EST
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 47cpWF29X5z9vhY6
        for <linux-rdma@vger.kernel.org>; Tue, 17 Dec 2019 19:44:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a1Je8sBuW4KX for <linux-rdma@vger.kernel.org>;
        Tue, 17 Dec 2019 13:44:41 -0600 (CST)
Received: from mail-yw1-f72.google.com (mail-yw1-f72.google.com [209.85.161.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 47cpWF0v2Lz9vhYF
        for <linux-rdma@vger.kernel.org>; Tue, 17 Dec 2019 13:44:41 -0600 (CST)
Received: by mail-yw1-f72.google.com with SMTP id q130so8927484ywh.11
        for <linux-rdma@vger.kernel.org>; Tue, 17 Dec 2019 11:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R1nYMTu3Wf2YneM8vgiZKJG+c743nMdOxOT93hCjzzs=;
        b=DAfDeiI9HtOxukTLIYKgQmkpkKUv7J7YaGh692J9VOk0jzsLoQqUlE5fAUcdFsMR4Y
         Xns2iJygS4mABqaeC/J+xVsaEyeDGyiK1fRpm4SFCGS16TXbnPr0qiQNpL/hiANdaXDI
         A9zrev0buQQs2T0isEDR4B0nbdPu4jRQ3K4U5FQJS5bSOCl3gt3ek8HXY1LNc3TTNzIZ
         cV2Iye4xX9pW6Xa/c4yxQopgjl2nvYQa7xvJEVqD1BF416uU0jgisubF0awK9vpGd2jK
         9y4lzRZnLQ/DLt1VN/6oMlmVMQpMXlES1Ca4gXM2E98tcJSCqmu27SRw6PyoZfwDKVAb
         7ABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R1nYMTu3Wf2YneM8vgiZKJG+c743nMdOxOT93hCjzzs=;
        b=DWQ1nplxuCHVVJWEl3lIlUv3ahBl9TUzH6yXtSYKt3xIiTr2uPK57UTPvZumZbd7OL
         MT7brmVko6p3ryUAK2mw2dnjlEeg+QW/2GPXItzlw+9++IaIWSlBL9r+d36cmP5+shaW
         CkHJIDb/Iw/eC5ekosYyssJDuJbg3QfKAzD+vR9z/38oprBektrEKYclFw+MuC4FubMR
         33tLY424ngzmr7nxk3bvBs29jP7ShCLD7LsSvoHLFkVQ+pjPCuPNM/RyEGhF0TD2732J
         MScUEdmQv7AdEFzlevtkNlM6TB6asZKC0nsyS7IZ78tRhfYzUBp3iiRAFIwSyW/ri8Tr
         stew==
X-Gm-Message-State: APjAAAWVZF9yD3Ro0ZeQ0yxp5tZfL+CkXwXW+y6Vz+s6dp8JIRJwJUqD
        BDDG2yM2+0Aa7yeVriNt57dRrSjMWE0mqAqZJ0HVwDrUu1CK+sq7QhuPjoJJjqZJPw9hQfuT+Zz
        ubaCe77+i57LXGEjDQSbMT7DAxw==
X-Received: by 2002:a81:4685:: with SMTP id t127mr261858ywa.280.1576611880205;
        Tue, 17 Dec 2019 11:44:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqwG27ef4T4PwFlqhO7GpbzcsqqrakfJavePAIbgiH1x+hqfmQDxFACpa97lZJlVnTx0c9xA7Q==
X-Received: by 2002:a81:4685:: with SMTP id t127mr261838ywa.280.1576611879986;
        Tue, 17 Dec 2019 11:44:39 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id i72sm10195197ywg.49.2019.12.17.11.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 11:44:39 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Bart Van Assche <bvanassche@acm.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] scsi: RDMA/srpt: remove unnecessary assertion in srpt_queue_response
Date:   Tue, 17 Dec 2019 13:44:37 -0600
Message-Id: <20191217194437.25568-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently, BUG_ON in srpt_queue_response, is used as an assertion for
empty rdma channel. However, if the channel is NULL, the call trace
on console is sufficient for diagnosis.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
v1: Avoid potential NULL pointer derefernce of ch. Current fix
suggested by Bart Van Assche
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 23c782e3d49a..98552749d71c 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2810,8 +2810,6 @@ static void srpt_queue_response(struct se_cmd *cmd)
 	int resp_len, ret, i;
 	u8 srp_tm_status;
 
-	BUG_ON(!ch);
-
 	state = ioctx->state;
 	switch (state) {
 	case SRPT_STATE_NEW:
-- 
2.20.1

