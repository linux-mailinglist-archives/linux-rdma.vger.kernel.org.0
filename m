Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 765DE18CDC4
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 13:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgCTMRn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 08:17:43 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39574 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727257AbgCTMRm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Mar 2020 08:17:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id h6so7157923wrs.6
        for <linux-rdma@vger.kernel.org>; Fri, 20 Mar 2020 05:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Nv6Nv+6LJBnq5DZKchYhL0m3LA+Tdn3F16jhKKXecEw=;
        b=Mv6lV69/HzDcrtQzHRO16E3I9XP32B1cCujWesi6N2q4oDmZd48HiqUSEu3jI/ZLy0
         GJYW2/v8nCRjVttHdXZUdYzx2+JJScGHCQ8/uZQQI6qQrb531shZvYpbkLpbUHQYAwP7
         NmPHNFx/15c45oHcKL8qUbIOjcnYiwIYnLWe5HVelM895rLvQzU3vYiSFb0O/Q8Drjda
         AOjO6sbThXWo85I5n9Fauo6zKYBoG8KnoaYVdh4pzcm0sADeyGQVr5EjvivX5qAVWdmp
         ZSxbOLUBxRt7nQHo/xY4T+HHLe64lhoptvn1gsJ/9Xdj/Zv37Juj7xikKdIB+aq+DbjS
         b8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Nv6Nv+6LJBnq5DZKchYhL0m3LA+Tdn3F16jhKKXecEw=;
        b=csF03zkptwz/6ZvduNCxWtweG6GMuJb6nyo6mbYAZ8qlf69HgzhNTz5auZhanztp52
         N00EryMmv+FqYefXq1eKGhb6by43FoFBu/mNPerIF1/AfEre8ljmN59TkhJ95jjmTbks
         oj9Gs6CuQ9urCcwHKZUQayOFaod/1C1gwJWprWi4akMH8hMUvFxFAamCC3NLB8bJvTdB
         3jKdboShRRmXQ3kMkeRFjetlvg7SWNCxrtOn5NGM6+0ImUnZT0x+FBSGBjuQJ7YM0DSS
         vM8pCOO0C1cBe6LC7ygp538LPraJW83RVBC5ztgrWRK8qyXxm2znkO/3VHNzHfXyiKuK
         uB+A==
X-Gm-Message-State: ANhLgQ3udnCqhKQRRwt7qeF5Ll9As6DAJvHsCLwxMsuErW6hrLZyY6CC
        oqnDXAZzmMKehQpGzoTDMe/N7g==
X-Google-Smtp-Source: ADFU+vs8A8qMkFr+lNLox6jkgMkXOhVEFI/rz47VpAGKJiDi2bpBTpA5OdLchMJ866tsx6VlH08Y8g==
X-Received: by 2002:a5d:4d07:: with SMTP id z7mr10388762wrt.89.1584706660967;
        Fri, 20 Mar 2020 05:17:40 -0700 (PDT)
Received: from jwang-Latitude-5491.fritz.box ([2001:16b8:4927:3900:64cf:432e:192d:75a2])
        by smtp.gmail.com with ESMTPSA id j39sm8593662wre.11.2020.03.20.05.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 05:17:40 -0700 (PDT)
From:   Jack Wang <jinpu.wang@cloud.ionos.com>
To:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, leon@kernel.org, dledford@redhat.com,
        jgg@ziepe.ca, danil.kipnis@cloud.ionos.com,
        jinpu.wang@cloud.ionos.com, rpenyaev@suse.de,
        pankaj.gupta@cloud.ionos.com
Subject: [PATCH v11 26/26] MAINTAINERS: Add maintainers for RNBD/RTRS modules
Date:   Fri, 20 Mar 2020 13:16:57 +0100
Message-Id: <20200320121657.1165-27-jinpu.wang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
References: <20200320121657.1165-1-jinpu.wang@cloud.ionos.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Danil and I will maintain RNBD/RTRS modules.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc1d18cb5d18..9aa45cf61088 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14284,6 +14284,13 @@ F:	arch/riscv/
 K:	riscv
 N:	riscv
 
+RNBD BLOCK DRIVERS
+M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
+M:	Jack Wang <jinpu.wang@cloud.ionos.com>
+L:	linux-block@vger.kernel.org
+S:	Maintained
+F:	drivers/block/rnbd/
+
 ROCCAT DRIVERS
 M:	Stefan Achatz <erazor_de@users.sourceforge.net>
 W:	http://sourceforge.net/projects/roccat/
@@ -14425,6 +14432,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jes/linux.git rtl8xxxu-deve
 S:	Maintained
 F:	drivers/net/wireless/realtek/rtl8xxxu/
 
+RTRS TRANSPORT DRIVERS
+M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
+M:	Jack Wang <jinpu.wang@cloud.ionos.com>
+L:	linux-rdma@vger.kernel.org
+S:	Maintained
+F:	drivers/infiniband/ulp/rtrs/
+
 RXRPC SOCKETS (AF_RXRPC)
 M:	David Howells <dhowells@redhat.com>
 L:	linux-afs@lists.infradead.org
-- 
2.17.1

