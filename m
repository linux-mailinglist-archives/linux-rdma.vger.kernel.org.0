Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F95F15276C
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2020 09:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgBEION (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Feb 2020 03:14:13 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38237 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgBEION (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Feb 2020 03:14:13 -0500
Received: by mail-wm1-f68.google.com with SMTP id a9so1484779wmj.3
        for <linux-rdma@vger.kernel.org>; Wed, 05 Feb 2020 00:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pcPwyfk35fD++vlKfgqfNulVF1tCAMwLLjtblBnrtbg=;
        b=e5rnzyj/GyXFye6zE/3/7RRCA999BycbaQQdXdz9mVp1mBucC1+MMCy6uXYwOoASxP
         42I8xeeLLPXC2ftXhjios0Vni/UBochZZ5nLX+L/gXwofUQR6kMHg0BtUtIRf3MQo3xA
         D0J73OKBL/PEvYxrQS0teu2+n7gQWuDHrkJdJ+jsU2aVFZ7kb7xezEHqB7X+s0s9eH6A
         fOOHeSoIyJSxV1adE8psDFOFYLJBpiMasFVW8HIZX0DtQ0TQJcK4HMwEQYT5rXotPt6L
         QRyt5sxygikqM4h9ROMAtVm7FdiKA59Cfpw0pVkEOFmr7WKDYS1rieu1mh67adEAquMK
         lETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pcPwyfk35fD++vlKfgqfNulVF1tCAMwLLjtblBnrtbg=;
        b=kETIkUgHjQICf2uW9Rll1Lv6sK9/Oy6as+qjYj3KnoOUKdLwaPYkT7pmhOjcvgj5hE
         qniG0AV0TirVWYOaKjYMfpkh31CftJBENo0Z+KI6VIZq4Siee9qd9pyCv36jRAop1M1D
         qIk1yIDUDo3DDublTyiz9ML8K06ygwQrzmbH//s2Lcbl257FWAHB1sNMMi2K0R6T4pOh
         C8muzNRu81j80LYhpc5JLyvPp6c7m233H7+uilqwbynyaryXN5vTG2JX6el9ZIy3rjq4
         SfOcrqlwHWwBwFYBO2E/+NaYHKofBj1GybGdT9T8BDDMVe70QBIEVQML7NZd/nRadKw7
         QKpQ==
X-Gm-Message-State: APjAAAVAF6LDbrIGKS4cDXXxrg2XnDGxgypW/setV6sl8WCj/lYVhyZ+
        Fih7RIQn0RVfYkgFkSSVytZqioXBYa8=
X-Google-Smtp-Source: APXvYqyVzX6SvJKpV06/iUuu9xNm1JyMbGMu4/T6FcKFOtYor+BKxnq6+eutSOqnm2/a2brd/d9Odw==
X-Received: by 2002:a05:600c:2c53:: with SMTP id r19mr4192019wmg.39.1580890451241;
        Wed, 05 Feb 2020 00:14:11 -0800 (PST)
Received: from kheib-workstation.redhat.com (bzq-79-178-7-104.red.bezeqint.net. [79.178.7.104])
        by smtp.gmail.com with ESMTPSA id b13sm19506281wrq.48.2020.02.05.00.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 00:14:10 -0800 (PST)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     linux-rdma@vger.kernel.org
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Kamal Heib <kamalheib1@gmail.com>
Subject: [PATCH for-rc] RDMA/siw: Fix setting active_mtu attribute
Date:   Wed,  5 Feb 2020 10:13:54 +0200
Message-Id: <20200205081354.30438-1-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Make sure to set the active_mtu attribute to avoid report the following
invalid value:

$ ibv_devinfo -d siw0 | grep active_mtu
			active_mtu:		invalid MTU (0)

Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/sw/siw/siw_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 07e30138aaa1..73485d0da907 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -168,12 +168,12 @@ int siw_query_port(struct ib_device *base_dev, u8 port,
 
 	memset(attr, 0, sizeof(*attr));
 
-	attr->active_mtu = attr->max_mtu;
 	attr->active_speed = 2;
 	attr->active_width = 2;
 	attr->gid_tbl_len = 1;
 	attr->max_msg_sz = -1;
 	attr->max_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
+	attr->active_mtu = ib_mtu_int_to_enum(sdev->netdev->mtu);
 	attr->phys_state = sdev->state == IB_PORT_ACTIVE ?
 		IB_PORT_PHYS_STATE_LINK_UP : IB_PORT_PHYS_STATE_DISABLED;
 	attr->pkey_tbl_len = 1;
-- 
2.21.1

