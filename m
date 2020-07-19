Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21070224E71
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Jul 2020 02:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgGSAc2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 18 Jul 2020 20:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbgGSAc1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 18 Jul 2020 20:32:27 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FA1C0619D2;
        Sat, 18 Jul 2020 17:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=fNkUg1z2dXWsVKhXv4tD3045EmSTq2gFU0A9CPcMrMg=; b=ildwkEbs+SXz3SlMAZVmjZ/b55
        DbW7ul+pFEkBxfIRdlhoPDKnuGrJ11uiJOPqo70c/I/O8+LxjGuUbTCsR89eJW2SM3Nh6eZIsgn0c
        Wn4i0//7/q3z1Tk7kw7waCsohtie8Y+gVTPMZI9y2wk2sVbwpgUMu4oBZH04+g98loP/QDcAoCAvq
        VZeplYHPsY+2oEcHuqzwdXmhnEMhj34iRGsKsK75yEevU3c71N/na9iL1NrOHnqC6/rwO724o+OD5
        vrye0qqtTj2xo0dK/k+DJs8UxgPbh69W2xfV5bmMu4+0cpMqvgOyo0+LGSqgQ0D11OIzUZWu4EaEk
        scIZ99mw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwxFg-00032L-Pw; Sun, 19 Jul 2020 00:32:25 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA: rdma_user_ioctl.h: fix a duplicated word + clarify
Date:   Sat, 18 Jul 2020 17:32:20 -0700
Message-Id: <20200719003220.21250-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Change the repeated word "it" in a comment to "it to".
Also insert a dash in the sentence to add clarity.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: linux-rdma@vger.kernel.org
---
 include/uapi/rdma/rdma_user_ioctl.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/include/uapi/rdma/rdma_user_ioctl.h
+++ linux-next-20200717/include/uapi/rdma/rdma_user_ioctl.h
@@ -43,7 +43,7 @@
 
 /*
  * General blocks assignments
- * It is closed on purpose do not expose it it user space
+ * It is closed on purpose - do not expose it to user space
  * #define MAD_CMD_BASE		0x00
  * #define HFI1_CMD_BAS		0xE0
  */
