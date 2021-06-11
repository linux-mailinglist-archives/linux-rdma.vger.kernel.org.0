Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 286773A460F
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jun 2021 18:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbhFKQET (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Jun 2021 12:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231618AbhFKQD2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 11 Jun 2021 12:03:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6628F613EE;
        Fri, 11 Jun 2021 16:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623427290;
        bh=2cJ7OWTRabSZbYW4G2yda3GKL7nFS0qMZ1I7SLuGSK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mEQEIJEklpFW1wfF5cxHSm65aP0XUVTlA03rbnyB2DuQPzKQOOHFOkAm39rVifLW1
         xWcpiUpy6aBM4TG8cND7Gp+VFpJxx1jFNXhMWlmqp8WZ7WAIgCSHyKXejbuTLGH33V
         ymbW8iU6K9VhN0GBZBYu3KGlvTBw6n7U6CKYdmN6Y/Anp54XptwYKlSuypwTVMszjG
         jfhZL7TaspACbATmEua/8qCljzOIj4avy73II5l1Y+di+uiLmv+qA9h8OrU+K6jGX8
         fdZxR6szDfdcbjCp+s1rXhsJ+yYqbRe1AXXkZIlThSmACyIjuzrkMFgKqyc1PLTOFr
         K63O0ZH8JpS3w==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        clang-built-linux@googlegroups.com,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next v2 14/15] RDMA/core: Allow port_groups to be used with namespaces
Date:   Fri, 11 Jun 2021 19:00:33 +0300
Message-Id: <afd8b676eace2821692d44489ff71856277c48d1.1623427137.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623427137.git.leonro@nvidia.com>
References: <cover.1623427137.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Now that the port_groups data is being destroyed and managed by the core
code this restriction is no longer needed. All the ib_port_attrs are
compatible with the core's sysfs lifecycle.

When the main device is destroyed and moved to another namespace the
driver's port sysfs can be created/destroyed as well due to it now being a
simple attribute list.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/device.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 2cbd77933ea5..92f224a97481 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1698,13 +1698,11 @@ int ib_device_set_netns_put(struct sk_buff *skb,
 	}
 
 	/*
-	 * Currently supported only for those providers which support
-	 * disassociation and don't do port specific sysfs init. Once a
-	 * port_cleanup infrastructure is implemented, this limitation will be
-	 * removed.
+	 * All the ib_clients, including uverbs, are reset when the namespace is
+	 * changed and this cannot be blocked waiting for userspace to do
+	 * something, so disassociation is mandatory.
 	 */
-	if (!dev->ops.disassociate_ucontext || dev->ops.port_groups ||
-	    ib_devices_shared_netns) {
+	if (!dev->ops.disassociate_ucontext || ib_devices_shared_netns) {
 		ret = -EOPNOTSUPP;
 		goto ns_err;
 	}
-- 
2.31.1

