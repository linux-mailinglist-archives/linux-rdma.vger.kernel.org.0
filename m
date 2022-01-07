Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D2B4877F2
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Jan 2022 14:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238706AbiAGNG6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 7 Jan 2022 08:06:58 -0500
Received: from mail-dm6nam08on2084.outbound.protection.outlook.com ([40.107.102.84]:29697
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238681AbiAGNG6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 7 Jan 2022 08:06:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ebKji/ZLJLvBIp1XolutYuhYSqGev/0wut/6S0rlBEI1H+TE/WxByBJCJyTAxO1qOwKol1yC7VcGG7se2y4BvFsxciQRZQNBe/n3zYrwiwfPj9GtqzancUIor7Bp6cotVEe+dAVs9z7US7f/4+MnvMOGnpwmhplYhj1E+zQVV92aO6ADd8SqetFhTpY2U4ofm/X6XbrcByeqeVuX6qRSFPpYDIfRz3rUHoDTe8qlO1diGSK7BkneZ8cXxkeSwRcny463Xi8QO5BoP9XBdf9XfggQZjvGbzon4gHyt61E1Q8gLQCTY+rKhmxt7KxwyB6vLSvEtAs8YPwzUeqVseenTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XlyybW45VJWA59uNdR/W+QEA/gqtuLfUmeMoZFukXK0=;
 b=g8P1kygfEiu6ZfWzJ10M1PT9D5nOue/1MRSwPHYiWKuS+vIYWDt/jNJX2wcnBE359MRt7Dy7Fr5GC7ge788FAfOMGcwKrJJwNoKlr4J5dw3X4STAvlyfMjP+pjjY4Ipb0gwf3DWq0u9IR8lYbE5O/Ao+xCRG9hWxKJvZp7P2sf3fRCwdAmKHnlzJvu0FRV1qcxRLUZxSPNuMqdxUrr+SAHEDrysaCMhiwOVMgAIp4VcX07JGkg0Fr9onsf+Plb9SPLvdDOXm6qvxuV6+60UhXkf5gt+v4NCdeDfLyW6hRA1OqK9UAuWgJoOHJMVhogOTzf034pYIQxahC4BeHsVz5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XlyybW45VJWA59uNdR/W+QEA/gqtuLfUmeMoZFukXK0=;
 b=X2urH9osIeKODJq6U0LS/1uIPi0L5eRTg8Ubga9mjHpKMhyixLR8wLt2hbKAgh+tZkWUSEYaRMGuhXpsP8cxzyMvnHyuWXZqW5F9gkqqtqxv5E9hxPHKUxDr5/CGX0o8i54wbyCMzf9kJlgqVF/w47y1JgInvalaYrN9R5B105kVTLGFwjAreU3p9tc2Te4pfps12GNXXuMzZdESTY4Rww1SsQWGegAaCa+r46AezIrSm0Qm9H2C/GSu67b/JcOWXEMhaN1FdDKM3F6wZAd4H24sibN7WSxEXW/5DLOfXsu9qbquCRIiA3az7iD573l8LwJQXg6AzPiW11OdR8C5MQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5190.namprd12.prod.outlook.com (2603:10b6:208:31c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 13:06:56 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 13:06:56 +0000
Date:   Fri, 7 Jan 2022 09:06:54 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v8 1/8] RDMA/rxe: Replace RB tree by xarray for
 indexes
Message-ID: <20220107130654.GA3062441@nvidia.com>
References: <20211216233201.14893-1-rpearsonhpe@gmail.com>
 <20211216233201.14893-2-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216233201.14893-2-rpearsonhpe@gmail.com>
X-ClientProxiedBy: YT3PR01CA0081.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::27) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f208c0d4-7626-48c6-29a7-08d9d1de951d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5190:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5190DA4F293F37D637192E15C24D9@BL1PR12MB5190.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F1vWHBbSSUVTlKMOtOpBJyNN6lwjRwX3bMH633F9UN3fvxAmgvHjr/VnUV8X64P8FOR7otSsVe+lpMcX59vLAi4McGw7wekgigKU8Zsrl02hmeu2yVCgCd5a5kiZRQSYMb87tnuz0FqqFoFVO3yRkR2vmMew54+linEV3cRqhjkePYBt99m2SEchcdDdOdxKUVCShcrY/MDPy+5Y2lu6AjKC5uT0DIhP0yRsBaYoplorripJ4KXetKxks0nOl54S+PE/s3xF+qbpl9CmcgBNZo3x6l03uZjqsBv7pNXry6Gl0zmt39DrkWHzlTeIhgP2PnaKHGqcWAhU7Hn8qAe2fVy0LgE8O8mp/RIDHrECDqavrw6UPWEubqQiW1W5OB3uNMNcraUoDxqi+4tPHfGCKh+yv81bC4TeafE3k5jLkyIBl5FSrcaYE7ldPyoO2U3yjuR8VD7ZRGODzAXldb2vkTKP5qHDMIhyQNXvHgVUGbjpiu0RZWzw/4vE2h9I2zKQzGJ3gfEZkm7RGO9R50k5UKapmqx9YcWwgEvHR0GN6h40A4UZPgRScG4Y4RLeJ+eV9xfLBDXICje4AKEQR5c9uMR6Fhdh2nZlKfxJi1gIABhir4Wy6URgyuriTpFypdRafqGosXErOrkbAaG79HcPxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(6916009)(6506007)(38100700002)(8936002)(83380400001)(316002)(66946007)(4744005)(66556008)(66476007)(8676002)(2616005)(4326008)(508600001)(186003)(33656002)(2906002)(6486002)(36756003)(6512007)(86362001)(26005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2a2LKkIEXaUT327Dyc+o8mdxeENZXDEAYNIVghhFzQbnCCSGeXQk7h8oyQH9?=
 =?us-ascii?Q?6cSqaxaBVGaTwiA3WHdz84vRSTqzG1B/eZTIWhOckoG/j8ZK+CKNXjBCJMiX?=
 =?us-ascii?Q?m3nsTVAOOhknooC7zQivcH+NM5u5ikECIs7Q+/u3Wx5JyHmvbBSqA5p+0cc+?=
 =?us-ascii?Q?k0+LIUr+qdUfKX0n35OkTXelha4O5G6LdqO7vgH1fAbklQ8AWZ3wO3cYV5Ar?=
 =?us-ascii?Q?wZykU5ns4Hy1dxNHMfjm7YjhKVThmIU+PQDNnbzxeGhPMsKlTEA4KFh35kW6?=
 =?us-ascii?Q?f6UfC6yuTS0zuiWTyHDjl4w33fy9Fp1Ts91h9IpKX0gIoMHs3nNJPBzgHohT?=
 =?us-ascii?Q?chSQIKTMrBq8l2mITICCrzqv/6FTyDG9svKkEYPiuH2aul4wYlHl7bftS1dN?=
 =?us-ascii?Q?WbWRMVtGlJb2D94yW+82e+k+KxQu+9mTSPHUna85wJWPnDQgQ2RUtJIBaD+o?=
 =?us-ascii?Q?pz/hy7QIRJyfSlFAHW2WvotTPKsGMbv1DofIe3Mfh640bPA+DIqI2bOqxtpN?=
 =?us-ascii?Q?4uHN+8xd3voC7UDb/PTEJyVVqEk3taS8fm2r3/z8OGsv3yPJdjCNSlj4dya+?=
 =?us-ascii?Q?8UQQdhu5uVx2BhFEkjW+cLP82Vt+oWrPX3YOZrhYYQe7kwV9YJL1THJs8qxM?=
 =?us-ascii?Q?4LxhktNBeOdQr5IBVhw50WTZUh5orrwfxC0oZkGtpYQ1mA9LwdtysTB5YEPK?=
 =?us-ascii?Q?XtUhC6REuVhVRioBp6E5Jecjex8s9nf8LqUHPWdAXpMz2VniNz3BekndkdfY?=
 =?us-ascii?Q?dATonWiSFiWjPGy3SdzvN53YMq/EENxA6OT363VO6CjY5NpOIpY5GG31ADT0?=
 =?us-ascii?Q?+CTJMJBJeDqYKfmMrXjHbFCNKR6eSWNY3qoxvmCSEKoLAQ0G1KhOcdNTWVWJ?=
 =?us-ascii?Q?c5XCzenKKP+JZJQgzGdOgMLTD2epsJX2+CLgiw5RVVODOrsPtPemczxayeNp?=
 =?us-ascii?Q?DK3MlZjGjcbPuBUaSZZpn0Dur5ACgKhk1q9GDPHqzOwbCIFfpW7uUy/0lEOe?=
 =?us-ascii?Q?priVgjIC1bNQwBIoHG1LcuMJZ8U3at4X2Xgt56ispQIidKmslHIs0mch68Cn?=
 =?us-ascii?Q?MUcQpplg4G4QS6DGKddLatGbzPeOnFbSB6ZA/ApGhwCUdHpThT2W9Iibucla?=
 =?us-ascii?Q?0aFLy6yC917oDXa+vBrJ4IQOAg6iWQ5papWKrv4zNhqYuqxSKesciqPcJ/z3?=
 =?us-ascii?Q?KTQhUSWyheO4qwQBzotbX6nx4YB3v4lq2zmYgUBycj49jWjgAXc4hBWYU7DH?=
 =?us-ascii?Q?sranRu/PAWwbc53k0etaJrnBeDIV+gYQ2Ea+xEFsN7gJQTciswNNUzrb3Nw/?=
 =?us-ascii?Q?EtXp6d8f0SdrbSDidTHNwxMp5ks52m/HrGwzF73rLb34UkaN2D4bm/EI1xbA?=
 =?us-ascii?Q?vQga2XixM6cw2GnmOWm6cROYbCaqxZzjldSX/yhKEFVsuYhrMmc7ZbfV5a3A?=
 =?us-ascii?Q?jQ+PjP8OwUWU4QZ0EjslUkFV4eMHN9xEngg1YJYRoV9FRoZ+L35GL6JSJAe7?=
 =?us-ascii?Q?EX/QpzywbGlrpFhSx8g/SYf6XZmSv1JpDr1n8nP1JRQYTiJZTACEyL+h5noj?=
 =?us-ascii?Q?HsmY6lz5kr3WwvybxMc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f208c0d4-7626-48c6-29a7-08d9d1de951d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 13:06:56.6015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckbq2Nn0nmdbQmGmdyqupq1BLidtG+8WePfMalwNK52jKNTyhtnwkDXRqOMIyVf4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5190
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 16, 2021 at 05:31:55PM -0600, Bob Pearson wrote:
> +/**
> + * rxe_pool_get_index - lookup object from index
> + * @pool: the object pool
> + * @index: the index of the object
> + *
> + * Returns: the object if the index exists in the pool
> + * and the reference count on the object is positive
> + * else NULL
> + */
> +void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
>  {
>  	struct rxe_pool_elem *elem;
>  	void *obj;
>  
> +	elem = xa_load(&pool->xarray.xa, index);
> +	if (elem && kref_get_unless_zero(&elem->ref_cnt))
>  		obj = elem->obj;
> +	else
>  		obj = NULL;
>  
>  	return obj;
>  }

This has to hold some kind of lock to protect elem from free while
calling kref_get_unless_zero().

You can hold the xa_lock() around this, or use rcu_read_lock(), but
that requires using kfree_rcu to free the memory.

Jason
