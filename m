Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA58162460
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2020 11:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgBRKR4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Feb 2020 05:17:56 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33782 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgBRKR4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Feb 2020 05:17:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id u6so23257173wrt.0
        for <linux-rdma@vger.kernel.org>; Tue, 18 Feb 2020 02:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dReGtbaqYQYeT0nYOyJyiHDwOywL7RFTwEoOGruRNTs=;
        b=UYDNwJPd7/udUfAm//dAh401lMwcjupbOvumiBn5gumKtEH2eV2szEWBSU7axljWNi
         S2l/MKl1vjZ3pShDW82U3uuYZgttH1OHtIIPkg9W3gbn74D6GX5a5x3BVqAtZKmgXEMx
         WIwKtcaY4AN09ZTO/TYhBWNMXVUafZPIfKVWELgjMC+HErttFPVM6XdkZ0wpGFzBoDgC
         5Tuv4XK7UpdkTNixpGOiABl0ZLvqx9ZlojPw7inserZNwrrWIpdUsC9bcUIqvAUTbPAV
         06FqLDZeBhH2uAVWoDRw4kaXNVj9l9k3G68nn4dEVoPUVTvrRtevQ4YZinFKq8Q5wSlW
         JGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dReGtbaqYQYeT0nYOyJyiHDwOywL7RFTwEoOGruRNTs=;
        b=qS9ddAcW3LLLXxdWQKfiBrH2Vtu+cQxpMAJ8y29S8HzoDikZLgZMaxKJmwStrjVVzP
         n/sBsJUNDZG0xD3NKKMrrRr+41dAbCZ4RJ6PCg3icZ2LZYFFDsE7GgnZM5BIY767O6ws
         hxA91OZLTim/dGaF7baVzxG5NdWUZVJ8odBGM7/RrXozF3Ne1R1ccOceUIkmKmk9J5MI
         IC6RuuaKNbF/TlXbLcxG1tM67u4XhTIU9Eslhu8QIHrf2u6GOW4grxzA/34a0wSDxudv
         iJyggtOFvcpiLVLKswkK1hBqBO2QB5Tf1RzgjBauf4SrFvcPWSxjWKJXcjOxDcfIcbkk
         a0tg==
X-Gm-Message-State: APjAAAXOFa4i1grhq6cc2hwX/27U+RzgZbFMMHnkenjNHpcljDuwxHYo
        1ukdwXqBjAzjiOiDxSOZPoupQFAvnWU=
X-Google-Smtp-Source: APXvYqwjo5JtUvKoGWPL1RZpR4AlEhSwTXSMkDH3DT/jM7T3+pPJF/VEo3kt5b71Z8Ei/TzzLD966A==
X-Received: by 2002:a5d:6284:: with SMTP id k4mr28902542wru.398.1582021073974;
        Tue, 18 Feb 2020 02:17:53 -0800 (PST)
Received: from kheib-workstation.redhat.com (bzq-109-65-128-51.red.bezeqint.net. [109.65.128.51])
        by smtp.gmail.com with ESMTPSA id f1sm5397897wro.85.2020.02.18.02.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 02:17:53 -0800 (PST)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-next] RDMA/srpt: Avoid print error when modify_port is not supported
Date:   Tue, 18 Feb 2020 12:17:40 +0200
Message-Id: <20200218101740.27762-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Avoid printing the following error when modify_port isn't supported.

[47541.541145] ib_srpt disabling MAD processing failed.

Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index 98552749d71c..eba2b156616d 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -628,12 +628,14 @@ static void srpt_unregister_mad_agent(struct srpt_device *sdev)
 		.clr_port_cap_mask = IB_PORT_DEVICE_MGMT_SUP,
 	};
 	struct srpt_port *sport;
+	int ret;
 	int i;
 
 	for (i = 1; i <= sdev->device->phys_port_cnt; i++) {
 		sport = &sdev->port[i - 1];
 		WARN_ON(sport->port != i);
-		if (ib_modify_port(sdev->device, i, 0, &port_modify) < 0)
+		ret = ib_modify_port(sdev->device, i, 0, &port_modify);
+		if (ret < 0 && ret != -EOPNOTSUPP)
 			pr_err("disabling MAD processing failed.\n");
 		if (sport->mad_agent) {
 			ib_unregister_mad_agent(sport->mad_agent);
-- 
2.21.1

