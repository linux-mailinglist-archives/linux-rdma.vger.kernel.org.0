Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978EF48581F
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jan 2022 19:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242864AbiAESYl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jan 2022 13:24:41 -0500
Received: from mail-dm6nam12on2065.outbound.protection.outlook.com ([40.107.243.65]:63832
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242861AbiAESYk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 5 Jan 2022 13:24:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzSq06ACN4Wck5sknol3KxzrLmA1rnXmb5WHkjuZTwkKnLrevh592dan1uaDX3iv9miyNT8sgKiM3btP7VJo2oSYw95lzQUl7Q/QYHvyJtMzkt7VnJeYWZmK5xyg3mOrORl1G3NBXF5B5zF1zKvbTLt2cttmd8lMGmaRmYNgbuechBsbTVu1gZasIqL4O5N9qM2GGj5DZ3pQi5gu+Pf09hIZvdnqUxiUuC9vXQaMLCJY9fizAxoQsXNTl3TXahSW632UjQiOCtREXQymHnZ0tQE2Voc+rehYQwRI2LmRqKD7OPZ+6XKgtb4Q6Ye9BbQu+liAo3L6TIoObrCQzPQh2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdnsbSfL6Us8ijfNtg2vTN+EBYfZUMZnfngiZtSMAhE=;
 b=RCqvR70mHnonokFaFcDtkVJDkxg0LMmh6pRUJrTp8+thz+ppazBAOZTNZoH20eJXQrGm5ZY41+34QIQWEVPrr9GdYbo/WwdP/mtV/Qh0zUWF61VsLrf8m7T7AsQG2o4chFXt/XSHOfme476GD0gRbs7ldkDFUVAtGucLV8TRBYzD3pVs76FmQfMiXrySMK3q8+AbhWwjmlJ6KGahVPnINeUT4bVj6FmvXYxnhnde1chk5ORFJlnu270FtlXQQukjaBHcczWyfG4A5OreIr5utqrUM8J2LeEPAqPcMPSq1anJYSjSB8/lEN7HOffe2aMyLKrAtv2j61vpZoMRG7jPQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdnsbSfL6Us8ijfNtg2vTN+EBYfZUMZnfngiZtSMAhE=;
 b=dhMoWzjUZF70EolwFnjC4e4VmxSLdZAm3nClkUqzYBWVjGgLkz0bXU/qPzbQ5YYbvxSJy+zauRrk0pj7qoCKWOLKf29uFnr15CERFbVPgMISZ4E85w3HioHRsexl9TG9EO7hh81A5/a3C4dV/4UyTv1PwxdwrSpVfHSJaJl05UJrjNfWgZBchcUIR/55Uc1Q053jHPcCfGb2c2R/HEfFbNA+7IKoTIkiAZtGYUT+EBkB60pYVC0ncgkfB1RIwKywSPolnQeWlB2Vsd/v+cwYFoXRUWeXNUK20lMCXHkILA6toDdiYtDBupSviDTF5q64TRjvN86gPpMygcFQxVV4iQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5189.namprd12.prod.outlook.com (2603:10b6:208:308::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 18:24:39 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::464:eb3d:1fde:e6af%5]) with mapi id 15.20.4867.009; Wed, 5 Jan 2022
 18:24:38 +0000
Date:   Wed, 5 Jan 2022 14:24:36 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/uverbs: Check for null return of kmalloc_array
Message-ID: <20220105182436.GA2855076@nvidia.com>
References: <20211231093315.1917667-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211231093315.1917667-1-jiasheng@iscas.ac.cn>
X-ClientProxiedBy: YTXPR0101CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::46) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c326f2b-043a-4a51-1f05-08d9d078a224
X-MS-TrafficTypeDiagnostic: BL1PR12MB5189:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5189B02FE975CD2591930216C24B9@BL1PR12MB5189.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dknrRXev/hFZxNILWQiOWn3Qod3JtTNbSGDD++KHUsWNIKBDs+5ndYU5fUPiIIvYyvJo/UX+UZIA470iAmd5tve28pPuGKocUpbfIR/TRkHx3oKqIZncAJ7dOiMUIIvA9qg3kKlgNhjq29ypNsPqXdn5+NiyVUdJSjWhIEwz7TTUcQArQA+V+MMd1HSfatT11GldZriB2ZzsJm05m8nERELhQ7b4WAjCf2CSFpDilCi2CMBL+XokndFq7dXqzVbsZfO/orDN9d5NutP3nFPxPSj70Cv2iomeS5TzpqPN9TSmq8xDrFjU3GexhZw/L+c2pxBANiKSupbdmE70J9pY3D1asK8ghRfwOP47gSpcZytKYQr99NTctQUt160LGV5V/3NFKSF3OKklC4BoypCwNOxjf3LPGfkVA6haZGRnUUd4jimPSGwfian96Ggo3i5DIifmVJrWmYaZqq6IOao+yyLMNU46WbjaC2TZrkc593YycKELbKQsCqIPiDs9mhLMeWR6QbvXEprsJWTF1s//2rCCHLD1GqzCJ6r0d1fEcsqVRExv7vguos3BtTpV5vCVOgVXEk0v475fXotH3VEibCtu1i3LI2XGJ5ZEbc5p0E1rUa4pDU1pUEMtBktFkW8eBEtv5n7WWfO0N27N2mpsJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(33656002)(83380400001)(4326008)(8936002)(2906002)(5660300002)(6486002)(36756003)(1076003)(2616005)(6512007)(6506007)(4744005)(6916009)(38100700002)(316002)(26005)(508600001)(186003)(86362001)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6VhoEw/ubgK/PUPX6Vh0t7sDM2++n+AvEFnssBoLwp5g1eldohRiNYAkA9vd?=
 =?us-ascii?Q?3X4/+SlPKjTVSpRFXW/6XjItoDDcawnBSaRxTSSmse/k9JmoMs2rcBDpg5hb?=
 =?us-ascii?Q?GZRWAT+m5sxN2aXaNVYkuCivsGAh97arHHk2vjNd5WpQqoVXJhBwySN7GUny?=
 =?us-ascii?Q?jQSqJANWg3PeHS5G3U26xyH6/RCeTqYLtVk8J9lxfnlmsj+IKE2QqDhlCfZJ?=
 =?us-ascii?Q?VtSKk9LCKF5U2q+GFMUlpR+tQ5lyoTTCMP/kmXjNCO3JtG3SeUlqRz5+c08H?=
 =?us-ascii?Q?5WfCzFJv9FKWTMoKy4Lx1MyA7aT2zZaqlxZfzxup3WDQl5CpkR29+XeF3lKK?=
 =?us-ascii?Q?rBjR0mMlOi9QOByE1Fx0mzt5dENAZDYafTS6pBMF70qQ1lu13435YwvXBfY7?=
 =?us-ascii?Q?nJicFWn5cgupvoC6tvliQ51N5K86wGwvUnZE8pxgDYcEtW6pbVGU2BVfVux3?=
 =?us-ascii?Q?HlaICWWGmm0qhYCoEpwn4SR90t/YeHOe1cVCXhUJl7dFALQMDXjiuhXRGMEm?=
 =?us-ascii?Q?fJ5oxqExESYYNJodX3it0YMgGqjUFpn1iZTQEh2zhGAQi0YONIPY0/EnRD2w?=
 =?us-ascii?Q?ROazzMil14ISZimkUpaXMrqzXnTOKMIHNlA6lI90Xrs+hF0w/8UA6jofIM4U?=
 =?us-ascii?Q?RiK5eFXERsvwdY7vQh9+0xTJFeDSK+b91F1d0aIAD4XjM2uV6/2VOkMGPobl?=
 =?us-ascii?Q?MFOeel+Z5vMiQrWO8GPLBtUa7XTceIg2rz8zmurDwOSrftXdH8I1+zAX09uT?=
 =?us-ascii?Q?XX9t7vqU3lt6zr/OOTjp7Lti9OC/0Emxrdg+foLWVgIYdUuYCElWGOAYuXBc?=
 =?us-ascii?Q?rVledcuJXWWViPOylZzOWNFkkeZtgaTt3Ti7ysenFPlLAtfQDfEF+J0cvGRF?=
 =?us-ascii?Q?0lxyXgKfF7tOBtBLdUDB8m7AQuzkClfPI2QRdgAu9GZj3wHFNhRfKIy7zwaG?=
 =?us-ascii?Q?PWu+Th2E1LJ6eLKKvMx2cp3QVOyXP+lhmp2K+qPW5Lg1ApsTU503+cjzy3/L?=
 =?us-ascii?Q?vfrBDpxoiwzpNBdh8ULdjM9I9gqZCfnhUcjuQMFDS1Gfq5BgnqQoulajGWJN?=
 =?us-ascii?Q?lwb9E8U34Vu586u9JwsLgyH9TujM1FPKaKP6yyfzga8SBpRxmFIRRds0/AU7?=
 =?us-ascii?Q?ug2kjguRXT4b4mV42gKdiGbPNqvqSxVNavBr7EjKbd0I0DITHDGDQpL46iLm?=
 =?us-ascii?Q?c0knBAcKUcbg3xTNAdji2DzWXNSGzC4Ia6s50t/mmt+pUl1fmcTtNMJ8HDKO?=
 =?us-ascii?Q?j4qsAUwP0SnEksFfOumyoVHu3Qmuuee13Plxu+LCRyw669Lno1B4+L00oBof?=
 =?us-ascii?Q?xQrJOGAyP2spOhNPdnbcE2kIWpdGqhhdi5lO5A8cIhERWzL1lzxcuqRcibju?=
 =?us-ascii?Q?O6Z8uCCL8ooT4IvUEOcHJTuYvjzUoDf6b3wRgB7K+q/sASMZKsZ+jUbzDLbs?=
 =?us-ascii?Q?K9Fhj+/nO7ojs/M3NOqTAo2+Vd9PavqSasFf/L0lDlNRwnRRWmiXZ7/pJ5qL?=
 =?us-ascii?Q?f1CaSCAfvmgzYT1VuOV1Xwi/5lFrZuRFMrWm7u2PHL864RzA/hwGItZxKk7x?=
 =?us-ascii?Q?aBYpgWGYkD7etTHB91k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c326f2b-043a-4a51-1f05-08d9d078a224
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 18:24:38.7376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LIg4a/3vvxQ2hE8+bhmpN8xjf9fyz7iSn/YKEsilqG9not5OshJ78Nrkvb3btxY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5189
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Dec 31, 2021 at 05:33:15PM +0800, Jiasheng Jiang wrote:
> Because of the possible failure of the allocation, data might be NULL
> pointer and will cause the dereference of the NULL pointer later.
> Therefore, it might be better to check it and return -ENOMEM.
> 
> Fixes: 6884c6c4bd09 ("RDMA/verbs: Store the write/write_ex uapi entry points in the uverbs_api")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/uverbs_uapi.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied to for-rc, thanks

Jason
