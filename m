Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F59435673
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 01:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhJTXZT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Oct 2021 19:25:19 -0400
Received: from mail-bn7nam10on2045.outbound.protection.outlook.com ([40.107.92.45]:48225
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229702AbhJTXZT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 20 Oct 2021 19:25:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHC9Y1JMPfROQhReZysuyhI/PFca0nOTehXYeTCWjjyqOImRFexU5Nk074++TjXQpGxTHxEUjiUQMuuwQMnnoDBfaAQTS31MNH6387b1vV5v5w1rRZFl2iDRclNF8VlXkmpmDezKbolP76IYoWIcknmnhe9tVCHvsTr5aD02dAjK324t5L3R0LC0Fh8FoUe5OhEphsdznqJx4fDdEqIMhOoWFu1wyNL5FdoHO0KjoNUWGyKbi9yoKPJl7itrw9TrL2ggyRc9WWj3fLRIawmhQYQub+acYrGJtVd5oehPmD71KxOwA2tya9eZSTCuqK5V0qokUjXULq9zuduhp/bQ/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvQR++yw9tlzzZ69l6FAPj4YUUTVA7CC5nPmheYyipk=;
 b=KVHGlPZgKw+FaTW0OGKkLFW2lyvnvfYP/MleFKA0enOrGWeWSW1rbsK5rgVgWsSvWvsvdyMXF/ql7akl6r4LR2ZHYg578vhsOkI9zRmpNguoFOi/hmcCfsTADGUdz/gNkNvXq6k0wVFwG19fo4e8BwA6KRHpcNkPgUlZPOakMweFRZr+aw4O1UIUM0pz3XHPCYrzRWjA9fZhhRwCpPWvVHLEWC3yYvsyb8uuAE1wW5YimeFkGw9xsL9dxiG3sIY58ax9B6DpOF45SsKvw2bH74qCDa8FWm22YkD/2KCETdBMhhGjQCGpmqQ+vVy1B7zUx0pcAbLFeLnAkK25Te87Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mvQR++yw9tlzzZ69l6FAPj4YUUTVA7CC5nPmheYyipk=;
 b=gBeGmx5uomt/p9sg+LbtHMTveoY0IwP2OuRNeUsjuPh01v1gKrxim/yXpSgF6OlmW6B30Kt0+68gI7SuhtAhvV9lnko2r20AAK/prdp/I29BcHHLpEEFDoR1llSXkJertJECx3URM6Md670j0gNk9Y3kGtFUs+GbHYxuL7c+eSPiQtPNxgtvvKEg8VER9yhgED1BQ0XS/3LKcTW17JNEvKmI6Sz+H5XVlgUMCv8950a0cWCKdYuUDQpXPa+kS7iO/3l8l3q6sNPfB21UQLVBAFUc3TQEf2mV88D/LDfa/8QFNo5FbC2eSR+6VyEolR792CONPLcl0mMI7XzTTcSwIQ==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5030.namprd12.prod.outlook.com (2603:10b6:208:313::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Wed, 20 Oct
 2021 23:23:03 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 23:23:02 +0000
Date:   Wed, 20 Oct 2021 20:23:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 6/6] RDMA/rxe: Fix potential race condition in
 rxe_pool
Message-ID: <20211020232301.GA28827@nvidia.com>
References: <20211010235931.24042-1-rpearsonhpe@gmail.com>
 <20211010235931.24042-7-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211010235931.24042-7-rpearsonhpe@gmail.com>
X-ClientProxiedBy: MN2PR11CA0018.namprd11.prod.outlook.com
 (2603:10b6:208:23b::23) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR11CA0018.namprd11.prod.outlook.com (2603:10b6:208:23b::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Wed, 20 Oct 2021 23:23:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mdKvF-0007Vv-Pe; Wed, 20 Oct 2021 20:23:01 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2bc1be1d-83a2-45b5-900f-08d994209024
X-MS-TrafficTypeDiagnostic: BL1PR12MB5030:
X-Microsoft-Antispam-PRVS: <BL1PR12MB503078C8681864DE8F3C8ACEC2BE9@BL1PR12MB5030.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g8yjb0wPlQaODJqzHkjo3xu8Rm/7hAoKduXJ5Z628/8xUg3sYkzSwkeTkKg9ilnrkjBjTAL81HpTFopAv+yR2/7YT8chc9ooQKiv9+MnCL42fWXZWiNifeRyJu8SMn8i/qKuDCo0jYwLjrys285NEBozwlOcx0mBHL0ZLkFp7f5mZq2yzO8v/59n/H4dFmQjOa/Dlbe9T04B7yYmXPkTHMszWcgydzU3PwSQXIdxz2SJFO2+lgITK/JQq6ZUuo75Jz/xvBmYPFlm9jhKpNbmFqyB9C7An7rEtA+psaRf7QFp+s0ap+9Cv1uvIBhmBhxfcYwZtKZE/CqtcttRl4Rd7exjoKaR/KU1q3wyihfDkcPXgaktcFpBMAKfrgA96h+M53sAEJpe6hUlGKUHw9YaFrJH9Q7DgP4IponzjV1lpZqdJy4lFzmI0FPDkn2FoGUCV6p+Jo0bIg9Pz1bq1FedRopxduXgLItcv2uf2/LkoogB4LGqlXrwa4vB+DYTcb3JKzsNfTojeCrdOH2n9wQ+OmeGdpYA3MuzzUTtGTyA0zn9Ot8iY3EeDCHJUo2Z+C3IqGyup4Y+DniBe7ZRrhFHznrU88RWr5fSQWiy65xuHWxwQcouEfo+5byp0WkTpwcLIT360IeU8JkN8wFzt9mVmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(2616005)(36756003)(38100700002)(426003)(186003)(66556008)(66476007)(8936002)(4744005)(8676002)(5660300002)(4326008)(1076003)(33656002)(9746002)(66946007)(26005)(508600001)(2906002)(9786002)(86362001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hf+UQJJaIV87xM9Xob6VnWCxhfEsvKO4AE9n0a2UmKE5C1nOf4MW5AcCzFBD?=
 =?us-ascii?Q?NrEO2woE8Dhihgitq/WFgfSGwkB7Yi73as3ZD3tDc0na/WPCYofpxjH0bJYg?=
 =?us-ascii?Q?efCeJ4PoFTqB0JBfXVqjwHNKckD1FtCy3UgUvetDqsTLKzwwdCSEKzO8kYln?=
 =?us-ascii?Q?t8y8Jdh4JYDUAQhp1n83ruo4NGJin8DZfuJ1/konkhPdRMi8R4C2iL1A7+aW?=
 =?us-ascii?Q?6V5rkaw+bXnRtKWaBoQ/279QTl9sO5+rLicO71VKnPMbcL4xF3K+0vKDtry/?=
 =?us-ascii?Q?0V3gs88sd488p0crU/rVRUEzQSV9UCe8n6RsbopS/Ikbo+y/H0a76SE3RHn9?=
 =?us-ascii?Q?GqhoA7aesmZWiyuy9Q9i/SK2crmqAOEVcRU5njY1GlZ2tZGo4IYilVaD0+E8?=
 =?us-ascii?Q?uGhqXZPnlBWgSnYxqOCaTEMVktlGtPTQ76LI13uiMnBWT7IMYD8JXRDDReDG?=
 =?us-ascii?Q?oXwhInGIKVi/g8u7mz+QptDVryHmn5qzqe8Shqh8AA7rsWNgqBw/94RFxljH?=
 =?us-ascii?Q?vE92w1xB8DYWvlklgy/XD5y80kpKY/mu1uZKqLE+PHanJEyH2JnPJS4aA2fz?=
 =?us-ascii?Q?29/NUHfgrm6S8ua601iLE7kGS+BpTOB0KQHp4dMuVnt0MDShoYnpiG63LhWt?=
 =?us-ascii?Q?dSFrw8httixwHIuNRy1611p9HwhNICfc0DnO+h7YY5F99Fb7K8HADoSYNl3v?=
 =?us-ascii?Q?0DAyMxm/Sd/GCa7kfh0PoSph6gjhG/tbk2/QAPLBYJCWVODcniLbFz6EVQCv?=
 =?us-ascii?Q?6R1kVnBIuiUJXmCHDEwn6cdoDjXwJ1PuVCuX1amh10MpOQKQkqyJuz8GOfJ4?=
 =?us-ascii?Q?AO/7rxqkT0QR9I/fxdpRaH3FuFSI7u74/GHuU0Qujq/mUgKUWDDYH8WDLKLg?=
 =?us-ascii?Q?S7RO0QwLbeAW67AAjQ1EzFhU2l3NGMGhBvXCs4xaxCNc7vBHOGwsdd2ZsIa8?=
 =?us-ascii?Q?ABjYttCVqL4un3309DVS0jphc0JeO5Q1Oogbj9nMxNKUnRLxML1wBNpnLXZ6?=
 =?us-ascii?Q?8o2V2KkADnoZRWMMmYL++/BMp8nhtVP4IuVfuG4suLgFj5kBZJpWoia/5TiL?=
 =?us-ascii?Q?gXHfSIYBVkVb578CMeBUby6DOZxJlATIXtFCinORl1lUR8mIgL/DrfLsmU0q?=
 =?us-ascii?Q?ADujcUfkwasr//6gsRVfdrvVkgKmbqTKKrR03J80mBr7aDfGiFAamUo9/rPk?=
 =?us-ascii?Q?wXFp2w0XT7GsW8XIzwUmRxlgjF6duAls+XRuN7XorF9IFF+4yWTOSKUZuxBJ?=
 =?us-ascii?Q?9fR24pctPFFqRS+dkDbV69ALM3rkuWHiV0rbwYySaeq8AAPZkl6bECwjSJs0?=
 =?us-ascii?Q?Ce2h5c9Fjg787xkyhBkaYkrA2p/MHHEpQ/ypYMW7z8tNfUi7MWmpQGVf2JMA?=
 =?us-ascii?Q?CCKTCQNvbHywXQuP8vtmdfwfNGBrpwmqj/ren52OGrPNGheIbR+C8Kbu34MS?=
 =?us-ascii?Q?nldxJ4ONbSw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc1be1d-83a2-45b5-900f-08d994209024
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 23:23:02.8512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgg@nvidia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5030
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 10, 2021 at 06:59:31PM -0500, Bob Pearson wrote:
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
> index ad287c4ddc1a..43dac03ad82e 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.h
> @@ -132,9 +132,20 @@ void *rxe_pool_get_key(struct rxe_pool *pool, void *key);
>  void rxe_elem_release(struct kref *kref);
>  
>  /* take a reference on an object */
> -#define rxe_add_ref(elem) kref_get(&(elem)->pelem.ref_cnt)
> +static inline int __rxe_add_ref(struct rxe_pool_entry *elem)
> +{
> +	int ret = kref_get_unless_zero(&elem->ref_cnt);
> +
> +	if (unlikely(!ret))
> +		pr_warn("Taking a reference on a %s object that is already destroyed\n",
> +			elem->pool->name);

There is already debugging prints for this built into the kref, you
don't need to open code them

Jason
