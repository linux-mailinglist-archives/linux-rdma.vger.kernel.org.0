Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6C463E14D
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Nov 2022 21:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiK3UKy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Nov 2022 15:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiK3UKU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Nov 2022 15:10:20 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFA594902;
        Wed, 30 Nov 2022 12:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=E47s7ipLMlIc2p61K7hVJzDyYXzzIeBc7VvzcwFMKS0=; b=fCreKj5Uhk8PkDJ0ePgOKryMGY
        Oo5vAepcgn4j3ApgPA8Yt8s94K3O+M9LixUfH0tkR6V102fEfIfojXL8+fnMDam4Ce2ZibF4kbrgS
        g/W6809lzC8ktKSJbUTn73N7wWnSp1/l6Kwuf9gg1JVkO9EX7eg+j9QMpec4i4Tb6qVzlSv8yYJxB
        aPRo+FS+mGMpvTBF51YdoWIwOYa7ZOjZKgXEI4Os2uF9puTFIZQUihfwb+FqPZb6PAKzHcIkQm6cQ
        nhGbt+r7Zk8CV0KxuekterH7AUvfW/9eqqRifh0FP+y/xeo0nwceJAFC8iFAM/svEYUfGWX4LkcfH
        aexETR5g==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p0TP3-00FGQd-BU; Wed, 30 Nov 2022 20:09:57 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org
Subject: [PATCH 1/2 v2] IB/qib: don't use qib_wc_x86_64 for UML
Date:   Wed, 30 Nov 2022 12:09:45 -0800
Message-Id: <20221130200945.24459-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When building qib_wc_x86_64.c on ARCH=um, references to some cpuinfo
fields cause build errors since cpuinfo does not contain x86-specific
fields.

Fix the build errors by making this driver depend on !UML.

Prevents these build errors:

../drivers/infiniband/hw/qib/qib_wc_x86_64.c: In function ‘qib_unordered_wc’:
../drivers/infiniband/hw/qib/qib_wc_x86_64.c:149:29: error: ‘struct cpuinfo_um’ has no member named ‘x86_vendor’
  149 |         return boot_cpu_data.x86_vendor != X86_VENDOR_AMD;
../drivers/infiniband/hw/qib/qib_wc_x86_64.c:149:44: error: ‘X86_VENDOR_AMD’ undeclared (first use in this function); did you mean ‘X86_VENDOR_ANY’?
  149 |         return boot_cpu_data.x86_vendor != X86_VENDOR_AMD;
../drivers/infiniband/hw/qib/qib_wc_x86_64.c:149:44: note: each undeclared identifier is reported only once for each function it appears in
../drivers/infiniband/hw/qib/qib_wc_x86_64.c:150:1: error: control reaches end of non-void function [-Werror=return-type]
  150 | }

Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: linux-rdma@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org
---
v2: rebase & resend

 drivers/infiniband/hw/qib/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff -- a/drivers/infiniband/hw/qib/Kconfig b/drivers/infiniband/hw/qib/Kconfig
--- a/drivers/infiniband/hw/qib/Kconfig
+++ b/drivers/infiniband/hw/qib/Kconfig
@@ -3,6 +3,7 @@ config INFINIBAND_QIB
 	tristate "Intel PCIe HCA support"
 	depends on 64BIT && INFINIBAND_RDMAVT
 	depends on PCI
+	depends on !UML
 	help
 	This is a low-level driver for Intel PCIe QLE InfiniBand host
 	channel adapters.  This driver does not support the Intel
