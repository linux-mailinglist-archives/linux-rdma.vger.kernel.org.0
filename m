Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17714482A6A
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Jan 2022 08:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbiABHGZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 2 Jan 2022 02:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiABHGY (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 2 Jan 2022 02:06:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF23EC061574;
        Sat,  1 Jan 2022 23:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Q0ej29B2j8z2ws8+2YZINTmx55/6VfNY4BKK9M/i8rU=; b=NpkxujGjDDq5zLPA7hBZ9ZBIXF
        Vv/QrXQdckNvHXp1o9YZRPJEgsZr2nkg+73hc8BKw4iy3CHuvGxMIleMmAzg27AJDmW9t/rWFFmSf
        ibSYcF+QzUtPqkLcojAE7Ws7zDzVdj39g5Uuqw/UfCazmEGHntKA/IwpTPxXqBokbY7Yqv4Gusjns
        QnazMvqArdmoP4PVB75V2KjbU1qek4nuPhUnTzNSJkQZrLnGOvU3IflbWsOEtism1tpPixCH7R1yL
        2bIsXDAa4ITn0Nq6d6CvnB97AtPPymCGx8oFf32FmVkdJykNtmnsXODYw8/1Qd/KJuVDNvlbBMs5Y
        YqPw6+0w==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n3uwi-007cUw-60; Sun, 02 Jan 2022 07:06:24 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-rdma@vger.kernel.org, linux-um@lists.infradead.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 2/2] IB/rdmavt: modify rdmavt/qp.c for UML
Date:   Sat,  1 Jan 2022 23:06:23 -0800
Message-Id: <20220102070623.24009-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When building rdmavt for ARCH=um, qp.c has a build error on a reference
to the x86-specific cpuinfo field 'x86_cache_size'. This value is then
used to determine whether to use cacheless_memcpy() or not.
Provide a fake value to LLC for CONFIG_UML. Then provide a separate
verison of cacheless_memcpy() for CONFIG_UML that is just a plain
memcpy(), like the calling code uses.

Prevents these build errors:

../drivers/infiniband/sw/rdmavt/qp.c: In function ‘rvt_wss_llc_size’:
../drivers/infiniband/sw/rdmavt/qp.c:88:23: error: ‘struct cpuinfo_um’ has no member named ‘x86_cache_size’; did you mean ‘x86_capability’?
  return boot_cpu_data.x86_cache_size;

../drivers/infiniband/sw/rdmavt/qp.c: In function ‘cacheless_memcpy’:
../drivers/infiniband/sw/rdmavt/qp.c:100:2: error: implicit declaration of function ‘__copy_user_nocache’; did you mean ‘copy_user_page’? [-Werror=implicit-function-declaration]
  __copy_user_nocache(dst, (void __user *)src, n, 0);

Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/infiniband/sw/rdmavt/qp.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- linux-next-20211224.orig/drivers/infiniband/sw/rdmavt/qp.c
+++ linux-next-20211224/drivers/infiniband/sw/rdmavt/qp.c
@@ -84,10 +84,15 @@ EXPORT_SYMBOL(ib_rvt_state_ops);
 /* platform specific: return the last level cache (llc) size, in KiB */
 static int rvt_wss_llc_size(void)
 {
+#if !defined(CONFIG_UML)
 	/* assume that the boot CPU value is universal for all CPUs */
 	return boot_cpu_data.x86_cache_size;
+#else /* CONFIG_UML */
+	return 1024;	/* fake 1 MB LLC size */
+#endif
 }
 
+#if !defined(CONFIG_UML)
 /* platform specific: cacheless copy */
 static void cacheless_memcpy(void *dst, void *src, size_t n)
 {
@@ -99,6 +104,13 @@ static void cacheless_memcpy(void *dst,
 	 */
 	__copy_user_nocache(dst, (void __user *)src, n, 0);
 }
+#else
+/* for CONFIG_UML, this is just a plain memcpy() */
+static void cacheless_memcpy(void *dst, void *src, size_t n)
+{
+	memcpy(dst, src, n);
+}
+#endif
 
 void rvt_wss_exit(struct rvt_dev_info *rdi)
 {
