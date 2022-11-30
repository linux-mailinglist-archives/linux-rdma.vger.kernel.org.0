Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFD163E164
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Nov 2022 21:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiK3ULc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Nov 2022 15:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiK3ULE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Nov 2022 15:11:04 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4302498974;
        Wed, 30 Nov 2022 12:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=NwdMiyCjs6mBb9kzRTViptsfgQPSjSYNBJwUO380cGY=; b=uxj1BF9/I/5pNSHmqGTJuYm1N3
        tohajqYrPBHQV8fIjEsRWOBkskUeekGasvvjKuVZVYVoT+0KuVqGPtzWYQuhz/z5uqjJbI+kSkbv2
        Pp55Z+uH8QXeGgIA88m3+VNQ/Oo1GpoVgXC7hXvitzpcVcVrk2zMMpARsbR/QjoIdvS4mvhIg71i2
        Lc2CDfDoG/RMXultHOWY0LUyPfRxK5tarBXAq7HAQnx+c70DcvFuAK2jPChUo3Miu8Jp/V87a6VnG
        UyizTR2IPrz5b+EAO72nFY2W6SHIUsf3qpKkpx1pmOFJHHRH4Sco3JHinEGsiYPu8iLoluRpD5im1
        A599fzTA==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p0TPG-00FGSf-4M; Wed, 30 Nov 2022 20:10:10 +0000
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
Subject: [PATCH 2/2] IB/rdmavt: don't use rdmavt for UML
Date:   Wed, 30 Nov 2022 12:09:58 -0800
Message-Id: <20221130200958.25305-1-rdunlap@infradead.org>
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

When building rdmavt for ARCH=um, qp.c has a build error on a reference
to the x86-specific cpuinfo field 'x86_cache_size'.

Fix the build errors by making this driver depend on !UML.

Prevents these build errors:

../drivers/infiniband/sw/rdmavt/qp.c: In function ‘rvt_wss_llc_size’:
../drivers/infiniband/sw/rdmavt/qp.c:88:29: error: ‘struct cpuinfo_um’ has no member named ‘x86_cache_size’
   88 |         return boot_cpu_data.x86_cache_size;
../drivers/infiniband/sw/rdmavt/qp.c: In function ‘cacheless_memcpy’:
../drivers/infiniband/sw/rdmavt/qp.c:100:9: error: implicit declaration of function ‘__copy_user_nocache’; did you mean ‘copy_user_page’? [-Werror=implicit-function-declaration]
  100 |         __copy_user_nocache(dst, (void __user *)src, n, 0);
../drivers/infiniband/sw/rdmavt/qp.c: In function ‘rvt_wss_llc_size’:
../drivers/infiniband/sw/rdmavt/qp.c:89:1: error: control reaches end of non-void function [-Werror=return-type]
   89 | }

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

 drivers/infiniband/sw/rdmavt/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/infiniband/sw/rdmavt/Kconfig b/drivers/infiniband/sw/rdmavt/Kconfig
--- a/drivers/infiniband/sw/rdmavt/Kconfig
+++ b/drivers/infiniband/sw/rdmavt/Kconfig
@@ -2,7 +2,7 @@
 config INFINIBAND_RDMAVT
 	tristate "RDMA verbs transport library"
 	depends on INFINIBAND_VIRT_DMA
-	depends on X86_64
+	depends on X86_64 && !UML
 	depends on PCI
 	help
 	This is a common software verbs provider for RDMA networks.
