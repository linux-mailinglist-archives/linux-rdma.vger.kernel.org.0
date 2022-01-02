Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15DB3482A68
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Jan 2022 08:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiABHGO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 2 Jan 2022 02:06:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiABHGO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 2 Jan 2022 02:06:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AC7C061574;
        Sat,  1 Jan 2022 23:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Fn0Dlw6FCxWGsDk39oPG6vOggtEUK9wbuTNWpXi1hUU=; b=xqq2+LYn0oJc/Ka/MWISEp9pGL
        tnWi6anzIxsedlLsZ6OiqL4r0T32tGEv3IL/4ja8wbs5XQjNCiQ+3hUAPxkl5pH+66oERIzdgOIWa
        yTUP64kpb33pFIvVF0NF6UyKCRlmWVm54JqmpNDsdhoTHwDPGMWRiHZ/uqczhGXIyEXjnzp2cOxd6
        Div/itI8k8HbbkfmghNDtWafMxHrq7Okz/y/DkVitw2sbxkMl2KBcu6nHAiFsiv6tew/DxahHetsD
        vi0xRdOUHXloy8w9G2sTyAlHws62nzycyxbshQVU+kPWi5Llb3T1lOgTNlJ8es5NJsr1NDx2W17Nf
        d46jbKag==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n3uwU-007cTF-ET; Sun, 02 Jan 2022 07:06:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-rdma@vger.kernel.org, linux-um@lists.infradead.org,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 1/2] IB/qib: don't use qib_wc_x86_64 for UML
Date:   Sat,  1 Jan 2022 23:06:09 -0800
Message-Id: <20220102070609.22783-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

When building qib_wc_x86_64.c on ARCH=um, references to some cpuinfo
fields cause build errors since cpuinfo does not contain x86-specific
fields.

This source file is x86_64-specific, so don't include it in the
target object file when CONFIG_UML is set/enabled.

Prevents these build errors:

../drivers/infiniband/hw/qib/qib_wc_x86_64.c: In function ‘qib_unordered_wc’:
../drivers/infiniband/hw/qib/qib_wc_x86_64.c:149:22: error: ‘struct cpuinfo_um’ has no member named ‘x86_vendor’
  return boot_cpu_data.x86_vendor != X86_VENDOR_AMD;
                      ^
../drivers/infiniband/hw/qib/qib_wc_x86_64.c:149:37: error: ‘X86_VENDOR_AMD’ undeclared (first use in this function); did you mean ‘X86_VENDOR_ANY’?
  return boot_cpu_data.x86_vendor != X86_VENDOR_AMD;
                                     ^~~~~~~~~~~~~~
../drivers/infiniband/hw/qib/qib_wc_x86_64.c:150:1: error: control reaches end of non-void function [-Werror=return-type]

Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/infiniband/hw/qib/Makefile |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20211224.orig/drivers/infiniband/hw/qib/Makefile
+++ linux-next-20211224/drivers/infiniband/hw/qib/Makefile
@@ -12,6 +12,8 @@ ib_qib-y := qib_diag.o qib_driver.o qib_
 # 6120 has no fallback if no MSI interrupts, others can do INTx
 ib_qib-$(CONFIG_PCI_MSI) += qib_iba6120.o
 
+ifeq ($(CONFIG_UML),)
 ib_qib-$(CONFIG_X86_64) += qib_wc_x86_64.o
+endif
 ib_qib-$(CONFIG_PPC64) += qib_wc_ppc64.o
 ib_qib-$(CONFIG_DEBUG_FS) += qib_debugfs.o
