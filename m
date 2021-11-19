Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 078A5456E46
	for <lists+linux-rdma@lfdr.de>; Fri, 19 Nov 2021 12:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhKSLiG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 Nov 2021 06:38:06 -0500
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:57796 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231270AbhKSLiG (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 19 Nov 2021 06:38:06 -0500
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Nov 2021 06:38:06 EST
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 19 Nov 2021 03:19:56 -0800
Received: from sc-dbc2135.eng.vmware.com (sc-dbc2135.eng.vmware.com [10.182.28.35])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id A2F7020E5D;
        Fri, 19 Nov 2021 03:20:03 -0800 (PST)
From:   Bryan Tan <bryantan@vmware.com>
To:     <linux-kernel@vger.kernel.org>,
        <virtualization@lists.linux-foundation.org>
CC:     <Pv-drivers@vmware.com>, <gregkh@linuxfoundation.org>,
        <vdasa@vmware.com>, <jgg@nvidia.com>, <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, "Bryan Tan" <bryantan@vmware.com>
Subject: [PATCH RESEND] MAINTAINERS: Update for VMware PVRDMA driver
Date:   Fri, 19 Nov 2021 03:19:30 -0800
Message-ID: <1637320770-44878-1-git-send-email-bryantan@vmware.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: bryantan@vmware.com does not
 designate permitted sender hosts)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Update maintainer info for the VMware PVRDMA driver.

Reviewed-by: Adit Ranadive <aditr@vmware.com>
Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Bryan Tan <bryantan@vmware.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index abdcbcfef73d..b3b5b8b0e207 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20022,7 +20022,8 @@ F:	arch/x86/include/asm/vmware.h
 F:	arch/x86/kernel/cpu/vmware.c
 
 VMWARE PVRDMA DRIVER
-M:	Adit Ranadive <aditr@vmware.com>
+M:	Bryan Tan <bryantan@vmware.com>
+M:	Vishnu Dasa <vdasa@vmware.com>
 M:	VMware PV-Drivers <pv-drivers@vmware.com>
 L:	linux-rdma@vger.kernel.org
 S:	Maintained
-- 
2.14.1

