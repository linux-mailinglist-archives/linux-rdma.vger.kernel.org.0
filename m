Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF202619A7
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Sep 2020 20:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbgIHSWt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Sep 2020 14:22:49 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:15656 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732292AbgIHSWn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Sep 2020 14:22:43 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f57cbef0000>; Wed, 09 Sep 2020 02:22:39 +0800
Received: from HKMAIL103.nvidia.com ([10.18.16.12])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Tue, 08 Sep 2020 11:22:39 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Tue, 08 Sep 2020 11:22:39 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL103.nvidia.com
 (10.18.16.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Sep
 2020 18:22:36 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 8 Sep 2020 18:22:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQVHsMKUqPMTZ6PepGmxpcKUv7dYCMsx5vEaDc9f+Rn2dAdVBSYrrMWS7NGu/AS50HAoOFN8AY0yWdYmY41KWYOn2FqGemTufquk3NBCu7o2pGCZ0koq4fFEE1Dw+KJ1Y+sbiosLBYtUuVgRp3LR6brYBBGPizit8M7eiGHJOetkyHavXSu/yLYKvbPbaikTeWV/bxt+o9HVy7zM3Q0AXg0iDdoBI5P3u6G+NRy/RDwlJ27iWpTsvjDrHnwp9e6hI8ZB7e5TIbwd+lCxTc9R/SfoMztYuASyVYE1M5BJrx0s2ZSYH+OrrdyPeM+Wav+FIyv+D1JvgbYDfLPer7qABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DrNqa2tfpqI0xmVcbkSOzziJOYMY7RmZ+mD5/66IPj4=;
 b=ilqcm0ztprLng6cTMd8B+4Qkdx+yHC/SQsnNei9tiPQltmbRYLLEuDfesfS1eDJ0j0sotvZ6GpEySulO3o8XqrKZqGW8ZOdltrIjascH2/n+TudUm23sWoyFlyFQwpIBnfVkaMM6p1sAjltpwR+MA8mqtWZDaLFrqqq0TxU/ZT7FXysVvUwQPG8f4aJpV8NNCXmQaOLANSJpV5yQ4AhEcoOOeQG4j6aqiiZ98bkuEo5V5eODPYk94KNRtfzUTacRhuIUJ1JJqZX589LpwBRK2/l0TdG1E5p4wSlftO4d1+L43MV3manOrwgNT55LZKi1GrKov09woOXrW2QayxM8mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB2631.namprd12.prod.outlook.com (2603:10b6:a03:6b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Tue, 8 Sep
 2020 18:22:34 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::445b:111e:a091:66f9%6]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 18:22:33 +0000
Date:   Tue, 8 Sep 2020 15:22:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        Yamin Friedman <yaminf@mellanox.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg+lists@ziepe.ca>,
        <linux-rdma@vger.kernel.org>, <lkp@lists.01.org>
Subject: Re: [IB/srpt] c804af2c1d: last_state.test.blktests.exit_code.143
Message-ID: <20200908182232.GP9166@nvidia.com>
References: <20200802060925.GW23458@shao2-debian>
 <f8ef3284-4646-94d9-7eea-14ac0873b03b@acm.org>
 <ed6002b6-cd0c-55c5-c5a5-9c974a476a95@mellanox.com>
 <0c42aeb4-23a5-b9d5-bc17-ef58a04db8e8@grimberg.me>
 <128192ad-05ff-fa8e-14fc-479a115311e0@acm.org>
 <20200824133019.GH1152540@nvidia.com>
 <2a2ff3a5-f58e-8246-fd09-87029b562347@acm.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2a2ff3a5-f58e-8246-fd09-87029b562347@acm.org>
X-ClientProxiedBy: MN2PR12CA0010.namprd12.prod.outlook.com
 (2603:10b6:208:a8::23) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR12CA0010.namprd12.prod.outlook.com (2603:10b6:208:a8::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Tue, 8 Sep 2020 18:22:33 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kFiGG-0034RU-1w; Tue, 08 Sep 2020 15:22:32 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cdf295b5-d919-4996-be48-08d8542427bd
X-MS-TrafficTypeDiagnostic: BYAPR12MB2631:
X-Microsoft-Antispam-PRVS: <BYAPR12MB263196681196454DF88120F6C2290@BYAPR12MB2631.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3mi0gn1+u0BsiJfXkFdQGuJoTzEaZIZPCnK0DNvCzdY1U1IjMlGZNT9ywgVEs0m0YCla3PWb9PPXT+jUDTwhDwLBtN6BkhDz0s0EanPcGuUCgQFgRAFPeET7LgRY3cmYdSFAZIsl2ILaVlkQjWqIs9FqVj9xQWmIY5XcNm/thmUP9uDHGsZWkN4UpvZQG9NEpYbW7eV/fDy0M2MsGPIz5ZNHZg4MFY8Ss6UVnJfA1ETx3XJTdYHTbW/Me7pg1jJhkrisIu9bYB8jy1xfX4X+b7KLgB/SJU73BwP1agb28C6kPuXocCXr0uXB23Fcm4I0LZG89g0MfVoMtwX8VAthNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(1076003)(66946007)(8676002)(5660300002)(66476007)(66556008)(2906002)(36756003)(54906003)(186003)(6916009)(2616005)(8936002)(86362001)(426003)(478600001)(316002)(26005)(83380400001)(9746002)(33656002)(9786002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: uvwcwRcHpyZuia+J5Cl1cPw/6JfzkbLVoFByM8zoW2YeDX+yfH/X0v3w0yChcbb815045KKT+LLOCL+vaT/zFgxY5Jk+1D+MREmFgien34XoSpV96RcwNVr4toR/O4GG+O4ix7xUuYl861DAuLBfxYUITAniS6G25I5Zjt5IDlDuK0Xi6+3ZOZ+nxkKrmS9qXd0RcBl+YUjf+9An5oDgKLs7FIZWLpE3eOo5qIBUbihO/MyhewdMlN11sVxVppQEkaRboI/ruIeppggxCHYtzvt2GxkYvLSt0pXAP+JAOkIEGSU6cwRN8O5K2+SHF4QaCkMeDrcY0ve55BSuawFNFBVZLpfQLQAzlJ9KJCBLWs4xA8j1QotWfpOg2qQPJAjW+K57sfz1NbfbLNJShaVlnKGFcFPerktAuWYUqfcW1H+B1u36vxdSGTJ2wB0i09EqzzJOi4IfOKR+wAiGY3+ZEI96ow0uVZmJG6l/9M7TN8vbAKefwWXxJ3wCRJO83dOGMLGrcq/iN86YqiGHzs32DMX8XY1zEf0NSodRKiucm0Gg8deq8/NaoZGj3kFfUDZLilSq8I9sVsZOd2S31y1LndygZfS4IRWnBrRF+CWDZX0t4dADiHOnCU39VhBRhSqjHa0/n6ZrNDeRULa5a9+MHw==
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf295b5-d919-4996-be48-08d8542427bd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3827.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 18:22:33.7905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0aMgjKbtHYUWBgwQdTg0YhjJxTppAn7FJZxemfNKGuahmv08W1YDxCZELd32OQsb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2631
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599589359; bh=DrNqa2tfpqI0xmVcbkSOzziJOYMY7RmZ+mD5/66IPj4=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Exchange-Transport-Forked:X-MS-Oob-TLC-OOBClassifiers:
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
        b=h5ETJitSxWq0Jrac/Z0e0pf3gIKYHCNZBvycwFaPjzq77jbJjlWIwrRHZoMirvB6f
         nI27pe/jCy6hQyIL22w6hHVfTQhxKo4QY+XgD7Jx1U5eloYs+Vq5yiF+K/om7/ryTJ
         nvfAV1uKAlynoukIVMQSoqBblEkNMjlfPh39OzX30PDSxb20FYNm0YMJqnMAzG7n/l
         /LxpWPcCFRBGKzqmRJreolmkwt/ptHMSxzFU2Jy0PV9La29gLbNfhTTdlRQRBYDBzD
         l1eUCFnS6nlM8n/nGRgBybH6G/PZzzKZTkYq5KAPDYYdztDhMRN2I048NKgpeLieky
         JLbS9QcUw3DGQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 06, 2020 at 07:58:12PM -0700, Bart Van Assche wrote:

> The following appeared:
> 
> WARNING: CPU: 5 PID: 1760 at drivers/infiniband/core/device.c:335 ib_device_put+0xf2/0x100 [ib_core]
> 
> Call Trace:
>  rxe_elem_release+0x76/0x90 [rdma_rxe]
>  rxe_destroy_cq+0x4f/0x70 [rdma_rxe]
>  ib_free_cq_user+0x12b/0x2b0 [ib_core]
>  ib_cq_pool_destroy+0xa8/0x140 [ib_core]
>  __ib_unregister_device+0x9c/0x1c0 [ib_core]
>  ib_unregister_driver+0x181/0x1a0 [ib_core]
>  rxe_module_exit+0x31/0x50 [rdma_rxe]
>  __x64_sys_delete_module+0x22a/0x310
>  do_syscall_64+0x36/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Oh interesting..

> Do you agree that the above proves that the hang-on-unload is a
> regression that has been introduced by the cq-pool patches? Is the patch
> below a good way to fix this?

> +++ b/drivers/infiniband/core/device.c
> @@ -1454,8 +1454,8 @@ static void __ib_unregister_device(struct ib_device *ib_dev)
>  	if (!refcount_read(&ib_dev->refcount))
>  		goto out;
> 
> -	disable_device(ib_dev);
>  	ib_cq_pool_destroy(ib_dev);
> +	disable_device(ib_dev);
> 
>  	/* Expedite removing unregistered pointers from the hash table */
>  	free_netdevs(ib_dev);

Hum. Not quite..

disable_device() ensures that all ib_clients have disconnected from
the device, up until the clients have disconnected the cq_pool must
remain operational.

It is reasonable to consider the cq_pool as a built-in client, so I
would suggest moving it to right around the time the dynamic clients
are handled. Something like this:

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index c36b4d2b61e0c0..e3651dacad1da6 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1285,6 +1285,8 @@ static void disable_device(struct ib_device *device)
 		remove_client_context(device, cid);
 	}
 
+	ib_cq_pool_destroy(ib_dev);
+
 	/* Pairs with refcount_set in enable_device */
 	ib_device_put(device);
 	wait_for_completion(&device->unreg_completion);
@@ -1328,6 +1330,8 @@ static int enable_device_and_get(struct ib_device *device)
 			goto out;
 	}
 
+	ib_cq_pool_init(device);
+
 	down_read(&clients_rwsem);
 	xa_for_each_marked (&clients, index, client, CLIENT_REGISTERED) {
 		ret = add_client_context(device, client);
@@ -1400,7 +1404,6 @@ int ib_register_device(struct ib_device *device, const char *name)
 		goto dev_cleanup;
 	}
 
-	ib_cq_pool_init(device);
 	ret = enable_device_and_get(device);
 	dev_set_uevent_suppress(&device->dev, false);
 	/* Mark for userspace that device is ready */
@@ -1455,7 +1458,6 @@ static void __ib_unregister_device(struct ib_device *ib_dev)
 		goto out;
 
 	disable_device(ib_dev);
-	ib_cq_pool_destroy(ib_dev);
 
 	/* Expedite removing unregistered pointers from the hash table */
 	free_netdevs(ib_dev);
