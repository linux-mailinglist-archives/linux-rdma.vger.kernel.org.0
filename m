Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9888128006
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2019 16:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbfLTPvt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Dec 2019 10:51:49 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50705 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbfLTPvs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Dec 2019 10:51:48 -0500
Received: by mail-wm1-f65.google.com with SMTP id a5so9421489wmb.0;
        Fri, 20 Dec 2019 07:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0nWlFwyOnI3SfJsfemTFfW4VA1Jj+i6JBHEMaJP7K5k=;
        b=aRzTtCRkaRP3bbcSrXGnOM0Bg7IgI9oYbX6Y5hWob7o03m/DwLe6JnE7nOIkemN77H
         /vUM+aWKt6PixbNzXdbHe5qowCnQM6eTM+oD/NtGnoKWqqDaPNP1TWgIOfcfebSbjKTr
         HZBwa2OK+WpVk+0bwjTOx1bp3sIAcONap15P1ZxB3Pkr4+o1eT5K7ia50Rnl3TwgMwJe
         WXZ/cQWwU3f1O17sCHI7QQPWnqbEIX2cqtcwJtnsS7/hSZnx9qkJoApLr2b1URv+hVEY
         7lzNirBvfcbNP3tK5+PHvft7GaEhS35tqSn0/I0afRUohcHrMquhrzuoEGn6zg4ptoEA
         dcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0nWlFwyOnI3SfJsfemTFfW4VA1Jj+i6JBHEMaJP7K5k=;
        b=e+xUBRQavklw2IQs2jnPKZBLKiqCOg5KjF7+LZ4q0IVGicvFDZpP2TCumO8rjET2Tg
         72eDJe9ncCdppj8q50mlw7ijDI6ewsBIq37ZwI9dABnspShLFTpOdnOmgVTgBGIy7t++
         ILDqAc52Bw/APnmNP7lscyIFpWzb5kifd7sCr+7CRmp6HTXUpB8y/eHZ/BTEWKPWO0TD
         NEB23pBuP4YF4jUR93biuKeTceBwkYwc93NtJnXD6R2IP90I4/a1Y2Zd/XFF1isHxxpN
         KAHZk60sUwLCJkvcJhmqh8RStakZ5VrnylFjDnrqUjmaQktSHjy3Ez8QJUW2krB5lsPh
         5tkw==
X-Gm-Message-State: APjAAAVMlGZQCIlkIT0rpwpGf4mRf+NGAos7iMvrfjYz/w3UWrBV6sua
        SIpA4Podv7mG3PCue3S8lEjHmrPB
X-Google-Smtp-Source: APXvYqxW1qb7HD4whFj09yt0iKXkIEDPmX3uGbdWJeMTbtRK2ypDkRjgZp/hH80onujJzC3oH6jz9A==
X-Received: by 2002:a1c:7e0b:: with SMTP id z11mr16079687wmc.88.1576857106171;
        Fri, 20 Dec 2019 07:51:46 -0800 (PST)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4972:cc00:b9e0:6ef7:286d:4897])
        by smtp.gmail.com with ESMTPSA id u14sm10372139wrm.51.2019.12.20.07.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 07:51:45 -0800 (PST)
From:   Jack Wang <jinpuwang@gmail.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        rpenyaev@suse.de
Subject: [PATCH v5 25/25] MAINTAINERS: Add maintainers for RNBD/RTRS modules
Date:   Fri, 20 Dec 2019 16:51:09 +0100
Message-Id: <20191220155109.8959-26-jinpuwang@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220155109.8959-1-jinpuwang@gmail.com>
References: <20191220155109.8959-1-jinpuwang@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jack Wang <jinpu.wang@cloud.ionos.com>

Danil and me will maintain RNBD/RTRS modules.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc0a4a8ae06a..e0caeac43fc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7955,6 +7955,20 @@ IBM ServeRAID RAID DRIVER
 S:	Orphan
 F:	drivers/scsi/ips.*
 
+RNBD BLOCK DRIVERS
+M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
+M:	Jack Wang <jinpu.wang@cloud.ionos.com>
+L:	linux-block@vger.kernel.org
+S:	Maintained
+F:	drivers/block/rnbd/
+
+RTRS TRANSPORT DRIVERS
+M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
+M:	Jack Wang <jinpu.wang@cloud.ionos.com>
+L:	linux-rdma@vger.kernel.org
+S:	Maintained
+F:	drivers/infiniband/ulp/rtrs/
+
 ICH LPC AND GPIO DRIVER
 M:	Peter Tyser <ptyser@xes-inc.com>
 S:	Maintained
-- 
2.17.1

