Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A5523CFB3
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Aug 2020 21:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgHETYM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Aug 2020 15:24:12 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:7172 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728827AbgHER31 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Aug 2020 13:29:27 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f2aec580000>; Thu, 06 Aug 2020 01:28:56 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 05 Aug 2020 10:28:56 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 05 Aug 2020 10:28:56 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 5 Aug
 2020 17:28:56 +0000
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 5 Aug 2020 17:28:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksVMVCZHIx79diS8qmaEid3Xod8fV2OE/ABikCM6BZmrPKY+pOPkq90iUml8Qq0/RxJxPVK0r18SyYWCpz0IuS4FyOjBtqsYF3PcVx+DtRs72heq7mCP4Tyov0El30eaXxbtMj97RBYSGrw3O1wZBbhAG1NhhY9EhM7xRg9/PdUnWt1CbdcyiUc0u4uJ3jx3cj338cE5UoQypMjxc7efpfIhiii3z0bparYpJdOSBZn8HVmXFIyoJWGxu8LmCQnxy08jiA9gxy8CFKl/7ZjlVPmvl7wMDGdp8o2V5zrDYKpBMWeIa3zSCYvm/mZzJAW9TQ/dQT07xanzfabpxZASGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYQhsIGCv80+t3/+yS0IghJzwwGcKn99VF3v2kBo8fg=;
 b=CGySBpsJQvHv+U26YQPh7ARXt5Dkn2b7P361Vrc7tLwoYDQiDt29u0HJpw5sbL8nHoSVOeXNGBmbN1EZZHrsM2io3Gj0+kXCAxT8hrmjAv1viaKs7XO6WFHwj/AJtn0fUMikIyVf9I9T7x5d+oUXsmomjwr6aQE2Om+KSnLa/DYfrD3cmMaAH+9ZEEHqOBvQi+96nJ54jwYELP0tMOYkhzfOiBsWbQAyV1p4gRT6InQ61wB5+toS4dPi3w5tPCt/i4jcdCn6ntNCiV1wb4ImUBn4vdgcnwwOkBrd7RX0EbprQabbd3KBnH0dazcJr2/AOlFfC4dbH1AdV+wMma+Ojw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2486.namprd12.prod.outlook.com (2603:10b6:4:b2::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Wed, 5 Aug
 2020 17:28:53 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 17:28:53 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
Subject: [PATCH] RDMA/cm: Remove unused cm_class
Date:   Wed, 5 Aug 2020 14:28:52 -0300
Message-ID: <0-v1-90096a98c476+205-remove_cm_leftovers_jgg@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0003.namprd19.prod.outlook.com
 (2603:10b6:208:178::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR19CA0003.namprd19.prod.outlook.com (2603:10b6:208:178::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15 via Frontend Transport; Wed, 5 Aug 2020 17:28:53 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k3NDg-003td8-C0     for linux-rdma@vger.kernel.org; Wed, 05 Aug 2020 14:28:52 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9e1aa36-2217-4621-a9bf-08d83965065f
X-MS-TrafficTypeDiagnostic: DM5PR12MB2486:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2486653B4EC93B3EE41CABE6C24B0@DM5PR12MB2486.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AXkHWHxxvmv/aincIFL865HsRzoAEYSzafHcMMVkfkkV1PLP7Tykm8uRfJcAhrBCbfVneb/RJ8EcjdOzpmtj0gK/1MGosyWhlxFFMdGp+y02P/bt+DhXQmuVPQkK5wfsizUM4UOPGUPwbn3WDf07MZnvR6s3fKuf302wt4thOzgf3h8t28Il0LdvsZi7Zjm/VBPukhoZsDtNRxzN35Xo1shr3IZTYUDliRFDI5AWxN8XLTwpN/wvGsqnzlFglIvxi3ygL9ngpgH9pONDGep5SKtBddXzqzvG9YOMX/jjm5i3vD2BC+9PAzYNNLhn/zYGsPjsOtDQPu6v3hScSSMuBjenRdF0BUJs9Lj4z8qljEm/urW4FDmUkSMkL/OoQ+Yl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(316002)(66476007)(66946007)(66556008)(8936002)(186003)(478600001)(9786002)(36756003)(6916009)(2616005)(9746002)(83380400001)(8676002)(5660300002)(26005)(86362001)(2906002)(426003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hhZVEQBvwz4DvNC6akw/srSCajUicTimxK3ms5u/XiG1cPqGskQJGvh/7nrVc3DS2umIxWGL/6K6Ra/6NN09dTi7c1Q8XBC6GPPZgI17NUMdBNPhaUuQpu4Gr85gvlUT93iAyTPdT8pivF+O7euJ8DaHS9yIPfxeV3UPQb+F+SsKYLM+BrMoQvD6/CxOqIHFZbtGTuySh2VkIt5KG3LWgfkHC4GPC+DzhctgsHQm6zqaLH65lJMeCaH48vWMcEUfWo6AKbuIh9p3l3YVhR88/VNwEr/OPjz8wUm1pduLm88jyKuOS28v1DysY+Nn+kC6rWh2W6aKOI4sB0rpgpzckAuuZgw3bE6Qrh/OQqMCvYOWClEZQGt3H7PInxWJlfl+pSyFYqkIpFOKRDQdoqomoDDqjdJyV7UIamIO3BjOe5MsH7tDo9s7OQLTfSMPtaC82jfid187JhbaTJIDZTSAZvFLjaqPuDmvzUTO23TCqkZjnIdCntUuNUMmOIeS2OjVdkqOluXg6wDaIWjvynSugZjPvM92CG50Zl36gt30qXkjx0a8rKzdDOYzsBG/ban6XQ0azh5j4Ny8JtkPYmGHi4zQHK9UcusamEvAUL1DtGlw4lv1MWAKKmSnRJBWfRGo7iecpTRlUmRDaBlyAa2Ntg==
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e1aa36-2217-4621-a9bf-08d83965065f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 17:28:53.6196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2aR9qR+rCG2Z3TM5eJGDzpQucjxhEyB6Vj1PaqTUHqfrdlh1VHHo6Np3b6nWwep
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2486
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596648536; bh=wDDzKLxDgk31597Z6kTby43EYXDPTrRESQt73l9zYec=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:From:To:Subject:
         Date:Message-ID:Content-Transfer-Encoding:Content-Type:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=Ob2yb+iTC0OiSjXKp8u7lhhvPWpp1oTPl26wEg3jAPmA4kpZSk5fxhxLrhM9t0GzT
         sZkw5ydrgplNfjCdxRD/cOagZ2R7OwE5lCrLvvDXz/OcXoLISo3I0/2RTrq4sGqbet
         mRELzJ1xAyCvpd/C2KQWclA46BXFrLvuxObvq5Rce8oSy0dWlZn9jPMlAXSG701E5l
         yz5LO9ruAKHU4orAw3a7w31sPFeH6kB8FZvOONVfXydA0+kVLNVgOPikhWp41w5y01
         PpWzuMDxB8e+qXiirr/PY7GhsREbGLiekdnxu7uZ7TkxRNBR6oI58ZroLt5KpLuXTY
         yShTj5/rD9vng==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Previous commits removed all references to the /sys/class/infiniband_cm/
directory represented by the cm_class symbol. Remove the directory and
cm_class.

Fixes: a1a8e4a85cf7 ("rdma: Delete the ib_ucm module")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 .../ABI/stable/sysfs-class-infiniband         | 17 -------------
 drivers/infiniband/core/cm.c                  | 24 -------------------
 include/rdma/ib_cm.h                          |  3 ---
 3 files changed, 44 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-class-infiniband b/Documentatio=
n/ABI/stable/sysfs-class-infiniband
index 96dfe1926b76e8..87b11f91b42568 100644
--- a/Documentation/ABI/stable/sysfs-class-infiniband
+++ b/Documentation/ABI/stable/sysfs-class-infiniband
@@ -258,23 +258,6 @@ Description:
 		userspace ABI compatibility of umad & issm devices.
=20
=20
-What:		/sys/class/infiniband_cm/ucmN/ibdev
-Date:		Oct, 2005
-KernelVersion:	v2.6.14
-Contact:	linux-rdma@vger.kernel.org
-Description:
-		(RO) Display Infiniband (IB) device name
-
-
-What:		/sys/class/infiniband_cm/abi_version
-Date:		Oct, 2005
-KernelVersion:	v2.6.14
-Contact:	linux-rdma@vger.kernel.org
-Description:
-		(RO) Value is incremented if any changes are made that break
-		userspace ABI compatibility of ucm devices.
-
-
 What:		/sys/class/infiniband_verbs/uverbsN/ibdev
 What:		/sys/class/infiniband_verbs/uverbsN/abi_version
 Date:		Sept, 2005
diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 9ce787e37e22a6..42e9e6b4d706d4 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -201,7 +201,6 @@ static struct attribute *cm_counter_default_attrs[] =3D=
 {
 struct cm_port {
 	struct cm_device *cm_dev;
 	struct ib_mad_agent *mad_agent;
-	struct kobject port_obj;
 	u8 port_num;
 	struct list_head cm_priv_prim_list;
 	struct list_head cm_priv_altr_list;
@@ -4292,20 +4291,6 @@ static struct kobj_type cm_counter_obj_type =3D {
 	.default_attrs =3D cm_counter_default_attrs
 };
=20
-static char *cm_devnode(struct device *dev, umode_t *mode)
-{
-	if (mode)
-		*mode =3D 0666;
-	return kasprintf(GFP_KERNEL, "infiniband/%s", dev_name(dev));
-}
-
-struct class cm_class =3D {
-	.owner   =3D THIS_MODULE,
-	.name    =3D "infiniband_cm",
-	.devnode =3D cm_devnode,
-};
-EXPORT_SYMBOL(cm_class);
-
 static int cm_create_port_fs(struct cm_port *port)
 {
 	int i, ret;
@@ -4508,12 +4493,6 @@ static int __init ib_cm_init(void)
 	get_random_bytes(&cm.random_id_operand, sizeof cm.random_id_operand);
 	INIT_LIST_HEAD(&cm.timewait_list);
=20
-	ret =3D class_register(&cm_class);
-	if (ret) {
-		ret =3D -ENOMEM;
-		goto error1;
-	}
-
 	cm.wq =3D alloc_workqueue("ib_cm", 0, 1);
 	if (!cm.wq) {
 		ret =3D -ENOMEM;
@@ -4528,8 +4507,6 @@ static int __init ib_cm_init(void)
 error3:
 	destroy_workqueue(cm.wq);
 error2:
-	class_unregister(&cm_class);
-error1:
 	return ret;
 }
=20
@@ -4550,7 +4527,6 @@ static void __exit ib_cm_cleanup(void)
 		kfree(timewait_info);
 	}
=20
-	class_unregister(&cm_class);
 	WARN_ON(!xa_empty(&cm.local_id_table));
 }
=20
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index 382427add67743..e23eb357b7613a 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -14,9 +14,6 @@
 #include <rdma/ib_sa.h>
 #include <rdma/rdma_cm.h>
=20
-/* ib_cm and ib_user_cm modules share /sys/class/infiniband_cm */
-extern struct class cm_class;
-
 enum ib_cm_state {
 	IB_CM_IDLE,
 	IB_CM_LISTEN,
--=20
2.27.0

