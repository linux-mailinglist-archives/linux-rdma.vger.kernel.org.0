Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA8920B78A
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jun 2020 19:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgFZRtS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Jun 2020 13:49:18 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:57671 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgFZRtR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 26 Jun 2020 13:49:17 -0400
Received: from hkpgpgate101.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef6351a0000>; Sat, 27 Jun 2020 01:49:14 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate101.nvidia.com (PGP Universal service);
  Fri, 26 Jun 2020 10:49:14 -0700
X-PGP-Universal: processed;
        by hkpgpgate101.nvidia.com on Fri, 26 Jun 2020 10:49:14 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 26 Jun
 2020 17:49:14 +0000
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 26 Jun 2020 17:49:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RL89Aru1cSQ14dY3NVzQpkRBZ0eMpz45zmMpoRLoFxRYVoYkrxeBWKwC2dUxstanVt5c74YUdrs3vfkYljTG97bGOnh6DaEV2uC7r3xPul2+BfPd851AlCTzRlbibn4N5wNyk02ppz+e9L8yTMlNSue3uo1niql7pbYL/Bdj3F1jrYRgOS7RQ6DbdvvliM+4qdVUf9hwsqjy7+Eg93kTfexhYI1ZESAorm7WNj3VUJoaipPGjEcuVx6gIOCkokNhtHSj1M0Na88GsKOwKkfsIGFatNnNGZ4oyQYZGxM9TL9c0olQrbfjEAicEST5EIuClmxEgOFZ/EGzfVqbfaNOtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwjAMJPB8EnpExtIAD3KWTMe7wQjgAxsoGy0J/cxs4M=;
 b=gtrm0HF6sdBUxlvXWkFjOMtmqL1dMewx6AL7esbXi1hX01ofoYaT6SXh534wjXQDqQtlIVNCxB0L/izn0lA51C9Fyyy4fomfMxpw2Vw9rrlYvoynlzGwCuE3acAaaZ055mIgFOFEiA3BP0OIFtx97XEx14FR30t/jBvuqhWp8CRsf62OgykP3syFC5/hng+rsrfRUh184GGTIwZFulDEOM+pKAUaka4Pt/47xeDFwVY04xbKMxK988/Di++ueVLTrjNcw+rA8Mw9tw/OvfLHzaeFKQ8q33KkB2Ss/VrK36n1hYsHpAI7ZXNOIxKup4e5fjrKu7VbtbmhEIINKSltdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1883.namprd12.prod.outlook.com (2603:10b6:3:113::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Fri, 26 Jun
 2020 17:49:11 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3131.025; Fri, 26 Jun 2020
 17:49:11 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     Hillf Danton <hdanton@sina.com>,
        <syzbot+4088ed905e4ae2b0e13b@syzkaller.appspotmail.com>
Subject: [PATCH] RDMA/core: Fix bogus WARN_ON during ib_unregister_device_queued()
Date:   Fri, 26 Jun 2020 14:49:10 -0300
Message-ID: <0-v1-a36d512e0a99+762-syz_dealloc_driver_jgg@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0095.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend Transport; Fri, 26 Jun 2020 17:49:11 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1josTO-000CLP-2F; Fri, 26 Jun 2020 14:49:10 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f8e9dab-b9ce-497e-1d1d-08d819f93be0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1883:
X-Microsoft-Antispam-PRVS: <DM5PR12MB18834896019DBFE0EDFD9648C2930@DM5PR12MB1883.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w2rD1OFV8lo/p4g3CDDUy3vl31fOsZi397vNRqHzVuRSvwNbGCOUGWis+ORl9CG3KYXTEKoL1A38hmC5d/Sc+5YMIvY2K9bSY4IHvB1ovJmfs79UeJTM51eqRos5p1yASaJ2IH21y1NY6nEBKAn4/n0rJ0i3ZXPqUwz2r3oMFNeszXQvnj544L+WQ5T63jdPX1VnJl6I66Nyfdy51PK+1qgKU8rOrtm5kRNghv1W/Nb44jmf8v0GTnqYRZwyb2XpUeYh/UR77066oJgGVL7Rlm26puR08Enwdc/NlhshS/fqQmXUCBZGJI204yVLFXO77Z/wPRZVyj5KtjMvdRyj9trOk1655qexItmjEElvkbVYBbaTkznWiiwSFiNicUvf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(376002)(39860400002)(136003)(346002)(366004)(2616005)(316002)(426003)(8936002)(5660300002)(66556008)(86362001)(66476007)(9786002)(8676002)(6916009)(9746002)(4326008)(478600001)(26005)(83380400001)(66946007)(186003)(2906002)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: YuFG2pcNoMKRkx6d7lf9nCi5+H0oIq6oLDSmoHl3YNQaoUrMJ6jvcJVFzzWYuM/XkhEwbMhgbWFecNTuO1Zr6cvpURv20KqVs2i7k6zLIdtzFSyBUN3HQItk97lMgQ6jiRu963NWjsEjjpRFy6Av9+RYsoILLKEUvICAFzwN42tTCf6oo7YwB6ofdBqVlTU0rqJ4at3dpKGsn4QAX05I50oRYIhpjrkJr7W/Ok3ReB6wiJtSHc9xIYiJZrc3QWVwEXjPtUJLK4XWXwpAp8jInv9ozwbHOmhPdzuYxwtN2LuoWyJX1HFXuVUeaL1tq9t9IurTxj+dUbQ6tDVjRCZRw2oxJ3rdpsbO/WTvsIHup8sonlSxBDqYRrmrXqyO4yjBuEedW+KCZ2SWAPIMLZzCAqk+r0Y9LOiuBUqvxyeR6drirKZ4oe7wwXVPol0O644AxwkwJFrOZi/Okd+8BEbyEQZcuB4zKLfCE12hlltBLtSVzvQnngArJwBh+KoJ0mef
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8e9dab-b9ce-497e-1d1d-08d819f93be0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 17:49:11.6078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lnWZawFAs2Sg6W5V6tWb55V8wpsIy5vxu/3DanzNqKWDakmP3D4b4LKTyNBp+oof
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1883
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593193754; bh=7+/Ulcx2v/or+zejbuHjg0jYb9EwN1aZpP8mENr9Lh8=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:From:To:CC:
         Subject:Date:Message-ID:Content-Transfer-Encoding:Content-Type:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-Forefront-PRVS:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=KtDjlwajG0s//P+d8t4PbRxeBuZBuqsRaoUWJNCvJa2QiCla0FVGC3aV92X1i1E1p
         Vniz3H6RJ6146uRLL70WUKYUYLpRQbO1pspsS7MBcb2OSFJ4DYxVklNuz8dzX1zRbE
         uOYYczYxVU4dtb/oIi6F9SQQxsSjwwc/Axv+pwG67w080TquYm2xA/KH9/NtjSShFR
         TaCByvppKwMDPjhqR9zTW4emXmXlHxM9ByVll+gZxtiX4UjbQiqnNYsdRiFDpRAMze
         2248YeJ0rHn915nC7Eyxcie/WkuwGJxkITDUau9J19twnrkouExFW0Li+91oFCy4D0
         Y2NTbKuj9390w==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ib_unregister_device_queued() can only be used by drivers using the new
dealloc_device callback flow, and it has a safety WARN_ON to ensure
drivers are using it properly.

However, if unregister and register are raced there is a special
destruction path that maintains the uniform error h andling semantic of
'caller does ib_dealloc_device() on failure'. This requires disabling the
dealloc_device callback which triggers the WARN_ON.

Instead of using NULL to disable the callback use a special function
pointer so the WARN_ON does not trigger.

Reported-by: syzbot+4088ed905e4ae2b0e13b@syzkaller.appspotmail.com
Suggested-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/infiniband/core/device.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

As outlined by Hillf, seems like it is OK.

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/dev=
ice.c
index 1335ed1f1e4a25..40cf07129f662b 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1339,6 +1339,10 @@ static int enable_device_and_get(struct ib_device *d=
evice)
 	return ret;
 }
=20
+static void prevent_dealloc_device(struct ib_device *ib_dev)
+{
+}
+
 /**
  * ib_register_device - Register an IB device with IB core
  * @device: Device to register
@@ -1409,11 +1413,11 @@ int ib_register_device(struct ib_device *device, co=
nst char *name)
 		 * possibility for a parallel unregistration along with this
 		 * error flow. Since we have a refcount here we know any
 		 * parallel flow is stopped in disable_device and will see the
-		 * NULL pointers, causing the responsibility to
+		 * special dealloc_driver pointer, causing the responsibility to
 		 * ib_dealloc_device() to revert back to this thread.
 		 */
 		dealloc_fn =3D device->ops.dealloc_driver;
-		device->ops.dealloc_driver =3D NULL;
+		device->ops.dealloc_driver =3D prevent_dealloc_device;
 		ib_device_put(device);
 		__ib_unregister_device(device);
 		device->ops.dealloc_driver =3D dealloc_fn;
@@ -1462,7 +1466,8 @@ static void __ib_unregister_device(struct ib_device *=
ib_dev)
 	 * Drivers using the new flow may not call ib_dealloc_device except
 	 * in error unwind prior to registration success.
 	 */
-	if (ib_dev->ops.dealloc_driver) {
+	if (ib_dev->ops.dealloc_driver &&
+	    ib_dev->ops.dealloc_driver !=3D prevent_dealloc_device) {
 		WARN_ON(kref_read(&ib_dev->dev.kobj.kref) <=3D 1);
 		ib_dealloc_device(ib_dev);
 	}
--=20
2.27.0

