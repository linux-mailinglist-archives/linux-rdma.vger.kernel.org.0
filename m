Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCA7483419
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Jan 2022 16:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbiACPXF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Jan 2022 10:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiACPXE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Jan 2022 10:23:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DB6C061761;
        Mon,  3 Jan 2022 07:23:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A50E6112B;
        Mon,  3 Jan 2022 15:23:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071C9C36AEB;
        Mon,  3 Jan 2022 15:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641223382;
        bh=YwRWKkYhJ9tAkLXDpAHe3WAgCJNFy0NWGyqnK8ueBLs=;
        h=From:To:Cc:Subject:Date:From;
        b=NhzlXNnqJPFukOfSVsX96itKdGJdA96fNhcjmKD6irLi6MWS5l9uTkamRxWz0Nd6N
         ta4YFoS72vOzv7dL/LdNgEB1NU5mpDYWFkpsoRPFMFmTAFA/+qyLgrbxq6dSMNiQVv
         iyYH+m3UIM0hWQ83nchmab8/PDv9QLPGPMQZScpc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian Benvenuti <benve@cisco.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Leon Romanovsky <leon@kernel.org>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Mark Zhang <markzhang@nvidia.com>,
        Weihang Li <liweihang@huawei.com>,
        Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH] RDMA: use default_groups in kobj_type
Date:   Mon,  3 Jan 2022 16:22:59 +0100
Message-Id: <20220103152259.531034-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2453; h=from:subject; bh=YwRWKkYhJ9tAkLXDpAHe3WAgCJNFy0NWGyqnK8ueBLs=; b=owGbwMvMwCRo6H6F97bub03G02pJDImXRS7OYW3Lj9qtIConu9JRuS/6VcL0xV93TNuwwuuV9J+W RTtndMSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBE9BcwzHf+t66jq0pu9/dGJd7qJe t0515gjWBY0HN6TZKYTeWRREd+K7lr8k/qa1OMAQ==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

There are currently 2 ways to create a set of sysfs files for a
kobj_type, through the default_attrs field, and the default_groups
field.  Move the IB code to use default_groups field which has been the
preferred way since aa30f47cf666 ("kobject: Add support for default
attribute groups to kobj_type") so that we can soon get rid of the
obsolete default_attrs field.

Cc: Doug Ledford <dledford@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christian Benvenuti <benve@cisco.com>
Cc: Nelson Escobar <neescoba@cisco.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Wenpeng Liang <liangwenpeng@huawei.com>
Cc: Mark Zhang <markzhang@nvidia.com>
Cc: Weihang Li <liweihang@huawei.com>
Cc: Aharon Landau <aharonl@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/sysfs.c              | 3 ++-
 drivers/infiniband/hw/usnic/usnic_ib_sysfs.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/sysfs.c b/drivers/infiniband/core/sysfs.c
index a3f84b50c46a..84c53bd2a52d 100644
--- a/drivers/infiniband/core/sysfs.c
+++ b/drivers/infiniband/core/sysfs.c
@@ -433,6 +433,7 @@ static struct attribute *port_default_attrs[] = {
 	&ib_port_attr_link_layer.attr,
 	NULL
 };
+ATTRIBUTE_GROUPS(port_default);
 
 static ssize_t print_ndev(const struct ib_gid_attr *gid_attr, char *buf)
 {
@@ -774,7 +775,7 @@ static void ib_port_gid_attr_release(struct kobject *kobj)
 static struct kobj_type port_type = {
 	.release       = ib_port_release,
 	.sysfs_ops     = &port_sysfs_ops,
-	.default_attrs = port_default_attrs
+	.default_groups = port_default_groups,
 };
 
 static struct kobj_type gid_attr_type = {
diff --git a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
index 586b0e52ba7f..7d868f033bbf 100644
--- a/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
+++ b/drivers/infiniband/hw/usnic/usnic_ib_sysfs.c
@@ -243,10 +243,11 @@ static struct attribute *usnic_ib_qpn_default_attrs[] = {
 	&qpn_attr_summary.attr,
 	NULL
 };
+ATTRIBUTE_GROUPS(usnic_ib_qpn_default);
 
 static struct kobj_type usnic_ib_qpn_type = {
 	.sysfs_ops = &usnic_ib_qpn_sysfs_ops,
-	.default_attrs = usnic_ib_qpn_default_attrs
+	.default_groups = usnic_ib_qpn_default_groups,
 };
 
 int usnic_ib_sysfs_register_usdev(struct usnic_ib_dev *us_ibdev)
-- 
2.34.1

