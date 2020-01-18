Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00FCA141867
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Jan 2020 17:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgARQcH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 18 Jan 2020 11:32:07 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:38800 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgARQcH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 18 Jan 2020 11:32:07 -0500
Received: by mail-yw1-f65.google.com with SMTP id 10so15841033ywv.5;
        Sat, 18 Jan 2020 08:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0hwMyrYJwbFmWaPuS3q0otAF1/PqypL0XBe4hF/vqqA=;
        b=Ex9jv8/JkhJ5IqB4oiK0VaYO3Tmwm47pdvWv1yW9yhyReoaz8hnHKOvDvZT9/ZnOLF
         +ToEJaAaQ8pgRjUZVfcNhpim0acBuQKuhrEV2e0UZhA9w6juzVNxZAbqmDaz/dl7VnkB
         0qz6v60Ajh9JK6vRv1PCiUGfsCfzZ1mzc0DSIY4acrQI/GeSoqnzjSIwNyzAQgTBKIe4
         nIoaCSeHMt2A3EnKIZKuBls+ZNZ/TIaQhWOx1kQPTxez4c3dJ0ZDmjrYUUWEDLd0A31J
         CS0HnJYsBowE8Be4lD6HshM6pzBP52eswqpi6nEH/czNhTwElQpETLxqwZ4opcp7d/I6
         y9Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0hwMyrYJwbFmWaPuS3q0otAF1/PqypL0XBe4hF/vqqA=;
        b=riA1z/Nt8zMQ29oOUaMefkVFjn4y8WD/YHvO5nFC0omX+6q6GyiSns8pF1ZQHmBuww
         6AOwXmim6A5SVHD5piTM1B6rphMmGaRkkHBuc9TH/Msi7TAu62m3U6V+O0BkkgJQd9YQ
         EM9dP4GXb8EmRmCD061J7vLgzf8+8mbw5A+KaexzbQC/F1dfFvQMuKTIs3fXqOKHBceB
         GuVEoUcYAA4w89FAv/oKLGnQJU/XjxkEN7TmrA26i9PCeQJyBDBk4SM2vcvsyhiAOsos
         qHhjCJWHr+r1G4mxmmNBzPFKo3NiwpW45cKk0jhG0ikQ5VTNYiKGO6+kzEb+8T7lR/C7
         DtWQ==
X-Gm-Message-State: APjAAAXcseYuuNpvWJEpzduUMD2MN3lhoXk/eOTRf2R9JWNDnV8gtL3N
        gWb7Tk5pUeghhBu3iXYZL7c=
X-Google-Smtp-Source: APXvYqxq1WnW2Zpt2zxGvKiCv4IauzETlp7PrE/Dg60vUeUsbAYO4tUDHRgwJzuQo9Q/fo16HkNhyw==
X-Received: by 2002:a81:1ac6:: with SMTP id a189mr32727599ywa.85.1579365126643;
        Sat, 18 Jan 2020 08:32:06 -0800 (PST)
Received: from newpc-fedora.timestop.xyz (cpe-74-132-3-215.kya.res.rr.com. [74.132.3.215])
        by smtp.gmail.com with ESMTPSA id a23sm13277949ywa.32.2020.01.18.08.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 08:32:06 -0800 (PST)
From:   Dillon Brock <dab9861@gmail.com>
Cc:     Dillon Brock <dab9861@gmail.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] IB/opa_vnic: Spelling correction of 'erorr' to 'error'
Date:   Sat, 18 Jan 2020 11:25:42 -0500
Message-Id: <20200118162542.15188-1-dab9861@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Correcting a minor spelling mistake in the comments.

Signed-off-by: Dillon Brock <dab9861@gmail.com>
---
 drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h b/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
index e4c9bf2ef7e2..4480092c68e0 100644
--- a/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
+++ b/drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h
@@ -358,7 +358,7 @@ struct opa_veswport_summary_counters {
  * @rx_drop_state: received packets in non-forwarding port state
  * @rx_logic: other receive errors
  *
- * All the above are counters of corresponding erorr conditions.
+ * All the above are counters of corresponding error conditions.
  */
 struct opa_veswport_error_counters {
 	__be16  vp_instance;
-- 
2.21.1

