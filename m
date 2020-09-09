Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA182263249
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Sep 2020 18:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731097AbgIIQj0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Sep 2020 12:39:26 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:61661 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730876AbgIIQjG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Sep 2020 12:39:06 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f5905260000>; Thu, 10 Sep 2020 00:39:02 +0800
Received: from HKMAIL104.nvidia.com ([10.18.16.13])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Wed, 09 Sep 2020 09:39:02 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Wed, 09 Sep 2020 09:39:02 -0700
Received: from HKMAIL101.nvidia.com (10.18.16.10) by HKMAIL104.nvidia.com
 (10.18.16.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Sep
 2020 16:39:01 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by HKMAIL101.nvidia.com (10.18.16.10) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Wed, 9 Sep 2020 16:39:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXvCWuIGM8EaaZFrNwWNXvzbmF5DAs0Ya/XremWaee9VQ3nnsxfNo5FSSdbJQthBvdyxK89rpDtcDUw1f4XBT19se2SbKdXN4G1F+rwBNdvDgDtUykvQObwo2zQ5ynWYFWM01JDV2tujz7cUBoRzd1CF2SP0Z8TlDA/fHYb/e1EJTRDslisvIpN68RkoROKBjDxDMkNBGfNRmmAj5Dfc+JIUCD6YX36XHpt9ys8qsLRjd0vQKF+9kkitVbKkHCBMsbRTVWUoptAZc8ywztWNJNr0jk3JYrk5mg8qLQqQdYXPaX82bD6bf6qMDxNI+wYA5PvcTmOoWGB4Y47SN2DbbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTVaYKMr8cQHNsWPmqS0cjyUKYID6aAKr9NBHZ//Do0=;
 b=QlK9no8RB5IrFkQ0tqUTgX7c5/EhKpdeE7JI1eJWFdTg4bIao6QEVNqGdLmrgz8YTcBXhj0ztG0i74UAJR2Bkb4qyhgClmepG0vDAbqCMK87GrAFHU/HoePXB5gltLliICE2Zv0Htr6NsPDf3JgboTVGG4I6ZjWKiTG1/FVGB9co61UxrYVJ/SVkMMrkn6FDzM2r6uugAYVP9FNqIZRNDaegD8Igm0NWDh6yBk+e75sd0VUILZ1kwv3kszwd9v9qASgT16si/KeuLzPc6fD/qgqNtycX1t7KBTnjefOmQWTeHRGgUWNklT0VxCxG8oc0L6WTHTU+WdmmcLv7jl2VqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB2582.namprd12.prod.outlook.com (2603:10b6:4:b5::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 9 Sep
 2020 16:38:58 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::cdbe:f274:ad65:9a78%7]) with mapi id 15.20.3370.016; Wed, 9 Sep 2020
 16:38:58 +0000
Date:   Wed, 9 Sep 2020 13:38:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tong Zhang <ztong0001@gmail.com>
CC:     <selvin.xavier@broadcom.com>, <devesh.sharma@broadcom.com>,
        <dledford@redhat.com>, <kamalheib1@gmail.com>, <leon@kernel.org>,
        <maxg@mellanox.com>, <monis@mellanox.com>, <gustavoars@kernel.org>,
        <galpress@amazon.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Bernard Metzler <bmt@zurich.ibm.com>
Subject: Re: [PATCH] RDMA: error code handling
Message-ID: <20200909163856.GA882940@nvidia.com>
References: <20200824234422.1261394-1-ztong0001@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200824234422.1261394-1-ztong0001@gmail.com>
X-ClientProxiedBy: MN2PR19CA0009.namprd19.prod.outlook.com
 (2603:10b6:208:178::22) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (156.34.48.30) by MN2PR19CA0009.namprd19.prod.outlook.com (2603:10b6:208:178::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 16:38:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kG37Y-003hiT-Rj; Wed, 09 Sep 2020 13:38:56 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e18d102b-6af3-4ca4-44e0-08d854ded967
X-MS-TrafficTypeDiagnostic: DM5PR12MB2582:
X-Microsoft-Antispam-PRVS: <DM5PR12MB2582399A0227A2C93769EBD4C2260@DM5PR12MB2582.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ADJAO+hASo08Zad1Ekm2qbVxuQwEd7pynW8DIZzzo9oU2bbsy0Zj36k1dEgJWeItM0NbJlOJx40473k4fYjfGIqjzW5qY+Icp2DcE2tt0agaPq9iSZyJp7ZCnSdsq/xXMXJW2kUIXhfpSB3XqfKyQVasKFYtLF47mNOofpzz2BSrIIa0v1jVeMAkqjdMwS7V03buUGyYLco3xL2TxDh3SNm72yKZ2Z0OozYPadzio+8g/ZvgJsaY+T1KifgD6gChhtoW67EvHyTu07u+3cr5+VtYC65oCZdawIeAw1D35q+9Gj0c4G9Fvl2LM1lOP8ulJwZcBdpnt3wKNAlW1W0mVvHz8MJybvHMtBLJEhZ6TxbBPrtE1gBpiNUsvcJhilh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(33656002)(6916009)(8676002)(2616005)(316002)(8936002)(4326008)(2906002)(9746002)(478600001)(1076003)(86362001)(426003)(9786002)(66946007)(66556008)(66476007)(26005)(7416002)(36756003)(186003)(5660300002)(83380400001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: rKCcRm3IdUWPQ69TZ9hpfwRBr0kSTCDwAQSWUvIF2zioN7bzXHMTQeliRi7UYQ8mPu0XurLYAmzXguf876Ogva7U8ZiXV0Vs9kGG4RRjGvf9qfcMFn7/JkAQ3Tlg1redwtuaE7G6bcnn7gG4ruUu15K/xesKYkoRkO4pr0R0Wh/q1jWL7WnaBKxOl6vJ1E6uAyJgAiC+mdzu7iN8reZ9tGW6TpWALU46pbZBLKYCobAsp0NKJZ0UUqJxHoJrcydSbvXCZTMIT/4mxeI5sW08Iua8zg69kscRmDWGW55Xr4/MZ9o35NWHeGQDq6GmYzOmPTQbwcRFyCVvXrIwAI8eHnOVKF/o4qqnh07hrt36I5tZoUi5IVQcOMCUu3wzjdsCa4cZqC5IJuqKPAMo1XS2sjufUbAW6HjjfpDZyr/lHjF9T7aKjpBN3RrqghVdsZYUrZEZpek7LYMWpxJF33ZKKQ52/cXMG4YndMz0javmvzt2wYyGN4TN/UnVBiPOcvu9Eu5BOMyPr1t6Vg5HWUrR462wBxU/H8zgx0NfBkeyS7teOen5Gfb1T9W7SuPPSvqD6+cRIXx9Zkvg3RIBWFwexlnKeNjqnyc+IPKN9D31X4EJobNSpm1NBjk8Ewz/oQHLYeYXhsSsrliZBiQWiGmADw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e18d102b-6af3-4ca4-44e0-08d854ded967
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 16:38:58.2150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dY4P9UNLR083zoZlUjZJYuq6OVyFAJp2Xvsx/gWjPC/IeogddnvkAMODHYWVwWLZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2582
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599669542; bh=GTVaYKMr8cQHNsWPmqS0cjyUKYID6aAKr9NBHZ//Do0=;
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
        b=nau0JkKKlnFAeZueaBuwlWS3qlYHM5jcnKvhYBjdVf2ImOZEszLr6AYAkX6RCXY/F
         F+/Nn6DXAn9TkoJj0SuzoLIaAwMDpK3498Oi1uFEjA9CBsKpQZ1dTMPCOGpGzB8UJz
         BobfLKOblpb2QWuo116hMgfrvaPF2CFo1op2tTaIhsM4AMNkp6EXkoRRoMTVDSiNup
         eldXO7uXe/fepls65/MZBzvlavQ6CSSEIneE8lrFQcodrC+QPEdms2rvlp3F/kz/CL
         AcatsG3HvGJBmWb05qSYnWd0Lg5GyRVk7WVZE6fiL0eAfGAudRFXL2OT9ck5Bz+ys3
         KB4D8n3naeaWQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 24, 2020 at 07:44:21PM -0400, Tong Zhang wrote:
> ocrdma_qp_state_change() returns 1 when new and old state are the same,
> however caller is checking using <0
> 
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
>  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> index c1751c9a0f62..518687c5e2cb 100644
> +++ b/drivers/infiniband/hw/ocrdma/ocrdma_verbs.c
> @@ -1384,7 +1384,7 @@ int _ocrdma_modify_qp(struct ib_qp *ibqp, struct ib_qp_attr *attr,
>  	/* if new and previous states are same hw doesn't need to
>  	 * know about it.
>  	 */
> -	if (status < 0)
> +	if (status == 1)
>  		return status;
>  	return ocrdma_mbx_modify_qp(dev, qp, attr, attr_mask);

I'm not comfortable with this patch unless someone from Broadcom
approves it.

Skipping the modify_qp just because the state is the same looks wrong
to me in the first place, I would rather see the dead code removed as
a no-change patch.

Jason
