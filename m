Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45FF282751
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 01:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbgJCXUQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 3 Oct 2020 19:20:16 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6845 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgJCXUQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 3 Oct 2020 19:20:16 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f7906c70000>; Sat, 03 Oct 2020 16:18:31 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 3 Oct
 2020 23:20:16 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.54) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sat, 3 Oct 2020 23:20:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxmQ8ZoRedvZAWg8+dqoOkwdEnNTaSDvis322HMtTQKZO7eiC8UEbYoG6coLOAqJ36xsMO/JUZAxp+UzqXw/nobNRTVBcyC00Kowsw9tDHRIFLH0n9aIub+J0vk/By80THqKSA36B2SP9Hc7GPes168gIQTTvaAlpQLqQrRohBDMGX0Pn9Po6OGyQmZqGf4LMrFFVFzoAeyxQj9fP+Nw17RfWG/IxTmILnERU/RuhDnlUpXDzSDBR8xRnBQHbCM1v2QNtWg4zH8SysCXSrQIsvyYn4kgn/LcHsND2faP9WgYz2Qv+PSBUmjStUgBtNzJBYBa5RVk0JxZd8a9CddTzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nknw/9/z1lWHmaG294w1A0MP6NCY0SCYK27AhjjMPuQ=;
 b=Q7PST+JP++ZAaWEKNGxD5hH2wzOj2HFSh5+u+yCceG1QxAThuWAesUsA7k2hmU1G/VW1XfZKRluyzzE2qjvSuYWai7Z69CLY8qcPWDckB3TkaRlIX6TUgfM6Qapbf66a31a6KmBJUibFb/rJlCUws1h/4LuNuV0SFRSFaLiEVgoxRwp6C463OSg8QZKpuAMManrthb61+vZsyW2anJyBCGlpIt5RU4HzpX6WyiAjXhkPW4J8jlO5mh1TjDJFG88OANxtBfdbO+RnK21PEukXljoThv+FclDRX/2FJcv1O1bIr5q5SVX3tB6K6thZ2t8J4iFKP7dbuUEC47h0lPj8sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Sat, 3 Oct
 2020 23:20:14 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3433.038; Sat, 3 Oct 2020
 23:20:14 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        Bob Pearson <rpearsonhpe@gmail.com>
Subject: [PATCH 09/11] RDMA/core Remove uverbs_ex_cmd_mask
Date:   Sat, 3 Oct 2020 20:20:09 -0300
Message-ID: <9-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
In-Reply-To: <0-v1-caa70ba3d1ab+1436e-ucmd_mask_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MN2PR15CA0010.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::23) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR15CA0010.namprd15.prod.outlook.com (2603:10b6:208:1b4::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32 via Frontend Transport; Sat, 3 Oct 2020 23:20:13 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kOqp1-0075ck-Uy; Sat, 03 Oct 2020 20:20:11 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1601767111; bh=569qGSGSGjwq4bV9MsZqJxSn1kNxtMZOmn2bmpwNv9Q=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:From:To:
         Subject:Date:Message-ID:In-Reply-To:References:
         Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
         MIME-Version:X-MS-Exchange-MessageSentRepresentingType;
        b=OFNlm65P21HDltZaZDOMN5ANCLlgeL+fKxzlh7+OSIMjtd08Mphn2EMxCHLlqga+L
         Bpf3d5WqQCPH+aivZnZMv8fhBb9/4XzLdOB8ghtgUMkwnHAveXoqv01BXsLJCRiNP7
         8MAY4rn5hxtHyhJEszrr7i6p7C2Q/OMByPuq9FWecWXkRQhcLkscRGojz1BZ//cHHM
         8812BYw+XzNfdVqLDEdMGqVIgT4t4/GZlsLmDJUswndqi5a20m1Fytd9eRi0Ob6Ggk
         qOlLiTDnMVV18FDAk3wTkX0hYrjnUUfoSGvi72FTKnigHIVREKYL7FmphyRxYl2Z7j
         aypTbBvMuxiYg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

No driver sets it, and the core code sets a maximum mask, simply remove
it.

Disabled operations are now handled either by having a NULL ops pointer,
or by having the common driver callbacks check for unsupported extended
attributes.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/device.c      | 15 ---------------
 drivers/infiniband/core/uverbs_uapi.c |  5 +----
 include/rdma/ib_verbs.h               |  1 -
 3 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/dev=
ice.c
index 4b808827ffcae5..b2325e7a7f2db3 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -630,21 +630,6 @@ struct ib_device *_ib_alloc_device(size_t size)
 		BIT_ULL(IB_USER_VERBS_CMD_REG_MR) |
 		BIT_ULL(IB_USER_VERBS_CMD_REREG_MR) |
 		BIT_ULL(IB_USER_VERBS_CMD_RESIZE_CQ);
-
-	device->uverbs_ex_cmd_mask =3D
-		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_CQ) |
-		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_FLOW) |
-		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_QP) |
-		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_RWQ_IND_TBL) |
-		BIT_ULL(IB_USER_VERBS_EX_CMD_CREATE_WQ) |
-		BIT_ULL(IB_USER_VERBS_EX_CMD_DESTROY_FLOW) |
-		BIT_ULL(IB_USER_VERBS_EX_CMD_DESTROY_RWQ_IND_TBL) |
-		BIT_ULL(IB_USER_VERBS_EX_CMD_DESTROY_WQ) |
-		BIT_ULL(IB_USER_VERBS_EX_CMD_MODIFY_CQ) |
-		BIT_ULL(IB_USER_VERBS_EX_CMD_MODIFY_QP) |
-		BIT_ULL(IB_USER_VERBS_EX_CMD_MODIFY_WQ) |
-		BIT_ULL(IB_USER_VERBS_EX_CMD_QUERY_DEVICE);
-
 	return device;
 }
 EXPORT_SYMBOL(_ib_alloc_device);
diff --git a/drivers/infiniband/core/uverbs_uapi.c b/drivers/infiniband/cor=
e/uverbs_uapi.c
index 5addc8fae3f3bd..62f5bcb712cf17 100644
--- a/drivers/infiniband/core/uverbs_uapi.c
+++ b/drivers/infiniband/core/uverbs_uapi.c
@@ -79,10 +79,7 @@ static int uapi_create_write(struct uverbs_api *uapi,
=20
 	method_elm->is_ex =3D def->write.is_ex;
 	method_elm->handler =3D def->func_write;
-	if (def->write.is_ex)
-		method_elm->disabled =3D !(ibdev->uverbs_ex_cmd_mask &
-					 BIT_ULL(def->write.command_num));
-	else
+	if (!def->write.is_ex)
 		method_elm->disabled =3D !(ibdev->uverbs_cmd_mask &
 					 BIT_ULL(def->write.command_num));
=20
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index ddcd0478c00dc3..437508290bc9bf 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -2667,7 +2667,6 @@ struct ib_device {
 	const struct attribute_group	*groups[3];
=20
 	u64			     uverbs_cmd_mask;
-	u64			     uverbs_ex_cmd_mask;
=20
 	char			     node_desc[IB_DEVICE_NODE_DESC_MAX];
 	__be64			     node_guid;
--=20
2.28.0

