Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2C433B4644
	for <lists+linux-rdma@lfdr.de>; Fri, 25 Jun 2021 17:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbhFYPGH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 25 Jun 2021 11:06:07 -0400
Received: from mail-dm6nam11on2060.outbound.protection.outlook.com ([40.107.223.60]:42177
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231883AbhFYPGG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 25 Jun 2021 11:06:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WbBI6j7BluwjACQpKpN84kxNKZWen7QudGcGZ055HJ8A5SLBVPVIeSi0l5nRe+6SHWfvOOWxQI+ZGaiK9dWeUtn2ngOMcwEStTwnHWmjClA29wKr+sMUEEA6Z+wXhz9taVDlcoYEBvWKq/bqrg1d1Gw0zMk6nDA61hp1YD9LjfTHQvdHGyJ8+HKfvzXybOlIUg++zP7rDhfkeYq0hYiyrT47mW2uAfCf2iWTo9x/CK7v5AwVYH7av2mrs0Ud0ImkhhOTgo59225CZB55XwxTXoVRYvyhc7DmX/YkHGgw5HFcLENkesec0mJs1oRxmG4OnPoA+9eXfViD2RtLjFS7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYmgEMNbgOobklIXuzZ8vLGJvuSz9KP3CSowwr73X7A=;
 b=DSA095Q9Eh1pY+jjbkzT5dbCiKVHV0Yc762Zrbdgqe/yzO3ReEQPsCWXUga+vRnRBdJr7JD6bql+uH+yvqXb/epCeDOINV0P8J3Gq00aHFm31PG2MW31jtZU7xOX7mscPKK7pPmLMAQQVHNWiHeC5Y1/hLR5WswR3acU+JbCGbwlqwxxqKfLAy7fyJbZLUNYXaafo522FiMMLIgsUpKQYXL/e22L7p2ZMXL2+ObgiGqWyZcBcH0PUHr5p624SWhiuUGFV6euf2cOMe/0z9DoYzgUcQMUfu5y/jC6ZJhziSIMF6R6m4zlW465A6YbNvrN2Q0hM+voQJzabILSPbbUBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OYmgEMNbgOobklIXuzZ8vLGJvuSz9KP3CSowwr73X7A=;
 b=stbFPpVLaN4dYSGQ1RtbAIO+yrOhgWuseokn1GA4xT2ce5dlZ7G/BZKpeqJBFwEZaKKnRBwqdARGFQ3pR5ighuYZsQxCxfNAE1vLMabG15b2NrLitCvdjsiQeNaAyRz3ZRdQ+zC9oNzIFD3HFyOr5k3+hwD81f0J9Cn2FIpB8XljxWReSn4VAS9x+UIzdDfSOyM3YqUfRDrz3yujPvYWop39XZSWnn4LtLX6lUG2s7G4whZBCcQfexIo60gAf8l2fMja3pfATLnN0BgWpDvf6q+OahO4tGUu9NcikWW4EdygOm5Bn/YRexz+2RLeHDQqLd/NIjTFwr86TeMvi6L+8Q==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Fri, 25 Jun
 2021 15:03:43 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.023; Fri, 25 Jun 2021
 15:03:43 +0000
Date:   Fri, 25 Jun 2021 12:03:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Zhu Yanjun <zyjzyj2000@gmail.com>,
        Bob Pearson <rpearsonhpe@gmail.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: missing unlock on error in get_srq_wqe()
Message-ID: <20210625150342.GB3006866@nvidia.com>
References: <YNXUCmnPsSkPyhkm@mwanda>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNXUCmnPsSkPyhkm@mwanda>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0106.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::21) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0106.namprd13.prod.outlook.com (2603:10b6:208:2b9::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.8 via Frontend Transport; Fri, 25 Jun 2021 15:03:43 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lwnMs-00CcGX-Iu; Fri, 25 Jun 2021 12:03:42 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ac4f03e-61c4-4bd4-1d0e-08d937ea6c94
X-MS-TrafficTypeDiagnostic: BL1PR12MB5350:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53500EF236C4675F0CE71F56C2069@BL1PR12MB5350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3jEbcGe69CmP0iambUNwVFcyQ+W6CkBqFWXnJazbUsONMWVLWDcEXnvPGzAspp2NQBxuFCHHy8f6t5DIsN7weqGTF90Hw8AQxbXmDwNFgf1c8YNXiSu/Tz7F1PSp1UWG/SgFwgecDt3dIEH+bDpeMz2sxDSlGxN7mMWb2T1SzqHC1odgEuGBLZ+rZeAPN4eZz74P1xnt+9Le8ILS1p29+Txgy7SQ/S5+xzbwBy+MDp456GvyOriKrxAmYD3HPqckuCA6X2M5Vr+Ru1RntzcTRwajjI0dXukbOdtI1cO0shnYKgk2uxFQSqt1SJMEAcHMH5zQKRl6k/BHKPafodYPBZYiP4s0PogL4pljlS2XRcqiFwevEazNJRYMV0PXMhps8KoaeGrsxtLAER4jG+keVx0iHA0RcriGn9J5ZQWhpw2W7sTcJqsX2O+LnF/S082nQxaOJkrx8ZDzMqHEig8sHHMCQVnLaHCYXyyWYBWmG4MizGBrf5MGnbIrrlK3rTzTy1l0Pzo/mg5AiSLSbSCaXyj8YHGeIxC22X8VEdMfytWapdVQxuEoCfBmq/HkbGObteKcGTW+u6n/GMby8kS3RMBYKe9vjVxqeJLaC2gbXBs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(9746002)(9786002)(66946007)(86362001)(83380400001)(316002)(33656002)(426003)(36756003)(26005)(4744005)(66556008)(1076003)(8676002)(8936002)(54906003)(38100700002)(2616005)(478600001)(186003)(2906002)(5660300002)(6916009)(4326008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RS2hNxhrglRAyjEQTuI6VYxWLCdPY0KOFyT3p11F6pQj2bwjJfZNrMYpzSwU?=
 =?us-ascii?Q?3AnjuYfsmNWK+hq2UwIra9LlSZ9tEzgDHnajHHlbafOH9X0MFA5Q5vy1JBr9?=
 =?us-ascii?Q?G9nFKeVTmRbKT+SV6SSHqlYX+NvQV+8ANMAtWRfl+pZ9g6D6YHT2Q1gw7vZf?=
 =?us-ascii?Q?le7LmqRPF1LueCEHBapiXv41S3Y0C3tD1BpgP7PRDB9hP5sRo5Zc5+/BFT82?=
 =?us-ascii?Q?tXLUPxWFPg8O75kHqu41guTPgbjlOLijXr2/aCeCUNDq23XFnG/2QswpOX7u?=
 =?us-ascii?Q?/lY+dbaatjECmUtp53gHR1D4cnDVKm47OrpE0prEKPcoM+pDJaX3b90doW+Z?=
 =?us-ascii?Q?hiy++upFgEPYDaet4vNKquWgN+kIN5hZTt4sKpEPQdFNGo8WE3jNx7rCfvBT?=
 =?us-ascii?Q?BxLAc5Jk61I4e+Pw1lgmIreJpBC+SVVgDX7+hebNwg39cXyTFDocAs3mEGHw?=
 =?us-ascii?Q?F2VXHKJqAKzT1yPBvDmmQ9P97KcZ/cCmu813qniJgbGACeMgfT3CBSGsmfcI?=
 =?us-ascii?Q?xLkk13By8HXBWCGhCq9NRkRq63BhvF4BGIZ5gO7vOa4ILZWIdhPifYiz3mKB?=
 =?us-ascii?Q?57YGb9X6fhDNP/Zrto1TYnKvrP74KqzW2JA/frgmE6qvJrxJppI6DMoj9Mtx?=
 =?us-ascii?Q?WpgYGxHmZc2EQZyLgHt39oU5MwrOts8RQ/0XaslL8az4wyWUJ1eKY3KShsoG?=
 =?us-ascii?Q?6mJI6ZJQk2EtTr6pkKQCmrOKheae2fgLgMXi6NygDpez0V7CzccTMjAdnKPs?=
 =?us-ascii?Q?GqaelLA+JQ7ZvCCxeHIseN2tTwuIe8PwDulo6OSVhsPVgdk05j0Af4E2kPkn?=
 =?us-ascii?Q?wMsbvF0HvAToGwlRX+pqihs41KamipIHIbMTVG/coiTaWHgjJqQrw3lOxBBP?=
 =?us-ascii?Q?as6PvuljEmxznbahMBDzUk0Upox4TOaYV1kL1Dst7zl3GunbxlCnyez1CNDY?=
 =?us-ascii?Q?vy+k4s3t+Wa3XBm04bzGkkpqrMo+lchoslrSP+h8RXWASzH0L43uCfJ++0rh?=
 =?us-ascii?Q?w1qP8twTRPMJmWvadHasBSsb9vCSV+20rKWXONnGq1X9nMgUVYaj7ASd0pMx?=
 =?us-ascii?Q?ZzEdcv9ALk0XTpJgBmfS6GlzkuMzanZn/wc9wUSMOBVAmHtMp+65ox1j93td?=
 =?us-ascii?Q?1j4qsy4ufrwoeigMEkPCnVgW16/lleSG0/0F7LO3895IVcUrt85rzUPVNi8V?=
 =?us-ascii?Q?k13Rc3jnsuxHf5m1IL3aidFgbfTTj4/acVOuLi9XCw00+1VlzVB50+ftTTEi?=
 =?us-ascii?Q?WZo+VGwiqeqJFPE2EA6V+n6ZubH8BUHxufL1hm38cqmPcuWz/spBMNTvO5+8?=
 =?us-ascii?Q?wUfeKPDEZ/RcVz6KC6BTOffk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ac4f03e-61c4-4bd4-1d0e-08d937ea6c94
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2021 15:03:43.5277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbhEZO7zNv8ynGbObiI9MdD8WWUYkL1WiSyj6I6bOBpRV3J7Z7x9fZLB/BBotzRd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5350
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 25, 2021 at 04:03:06PM +0300, Dan Carpenter wrote:
> This error path needs to unlock before returning.
> 
> Fixes: ec0fa2445c18 ("RDMA/rxe: Fix over copying in get_srq_wqe")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Majd Dibbiny <majd@nvidia.com>
> Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
> I'm sort of surprised this one wasn't caught in testing...

Probably because you have to make malformed wqe's..

Applied to for-next, thanks

Jason
