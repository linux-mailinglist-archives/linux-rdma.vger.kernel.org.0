Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810C845DFE0
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Nov 2021 18:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbhKYRma (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Nov 2021 12:42:30 -0500
Received: from mail-bn8nam08on2086.outbound.protection.outlook.com ([40.107.100.86]:26145
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232053AbhKYRk3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Nov 2021 12:40:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0azBnZXp/y2uexAixMpJWILaW/EZuAyvLoix9AJ4gQ2rQkvoxk6GU8ew1nZBY4lMqQmxxrOjEF0cOnW4t64+MWaIRmfYcecd6njbYeMsrcCDj7bOg6tmPZQzGAQCmzrV7j98SHupfvYI1ZbzQwTZ3PR9aGUCgA6YjMQOhc75Uhc90s4uqDuNoV3k0UgEFCGu20W6wwk7o/cnbYichD3EvZtbrF/g4tmvd9DPS2IVilxNujYIP1sfrUoKm9HuBqp0/RIjzBKWeSyyh0g5Nh8mZJlWuR5TLbH0g0aeaVeq0VFtaZrnRVKZRMAIMFIuoDTWLkBRLYPwm99peKS4uzBVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRL0RBPH84Ms4KZ+eJTp7w1AEA9nlWUC1j1VA9EaGos=;
 b=Z2VUM6kJfFD77QWWanWJ/R/Gkn1qwdzBAsUEHys+SkpwW8aG8/RT16Dpe2XcOScCpRw+jilqIDRGSg+CzKLi5d1MmwaCNUJA5lk/IUvCX5TpD8H8I2EQaiKsrujO9VzmEgFp2lxMxrZ2XRmYIuQUZoNsEIhBQa5rfSy/RUGxxIgq6j3IhfMFNJ3CLCHJh6YoOL0Nuz2cZvAhjsBWqjPwzaHjbTGZZ5zcwa6ujdli0X/tx4BdFCf0n1jK2U0PbgnDeg/pFgGmZm0IE0j8cQttIcB+CnQmTHKir16/pW7ru3C4D7apnEDQa4UxxtPespZKlF8W08z4k2oiapo2qXlC1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRL0RBPH84Ms4KZ+eJTp7w1AEA9nlWUC1j1VA9EaGos=;
 b=CyISj3IhhzEbrL0G/jNe7m7XgjfmQg/QnEjW3884nQrYG05gJr0dM/kIbg8RV4bqcEcqZvf3/h3jT+S/Jmj9gl/LHk9yyVQfpxmAzVHdfoiL6BQ+jC1a3dO+UJqo4i2OWaU9GArMLUb2M8ehgAypnxRkRWFz+q1RBtZ9k79U+Td5TUwdFqS/1sCmyEde9V+TCymML3uW20gHufE++Rw+joGV7f12ioqYxYAofJMLXqD9LR9EVD2lkflsa3KHleIej6cNlaBe7m1QgijY4jB7XLDff2Fo+9x1eJ/rUt+qpCYS6hp+22qioyYjF5YnzYTFMtG3URccdgJlc4BWbJ01+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Thu, 25 Nov
 2021 17:37:17 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.023; Thu, 25 Nov 2021
 17:37:17 +0000
Date:   Thu, 25 Nov 2021 13:37:16 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     =?utf-8?B?SMOla29u?= Bugge <haakon.bugge@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-rc v2] RDMA/cma: Remove open coding of overflow
 checking for private_data_len
Message-ID: <20211125173716.GA504001@nvidia.com>
References: <1637661978-18770-1-git-send-email-haakon.bugge@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1637661978-18770-1-git-send-email-haakon.bugge@oracle.com>
X-ClientProxiedBy: BLAPR03CA0127.namprd03.prod.outlook.com
 (2603:10b6:208:32e::12) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0127.namprd03.prod.outlook.com (2603:10b6:208:32e::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Thu, 25 Nov 2021 17:37:17 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mqIgO-00277m-1w; Thu, 25 Nov 2021 13:37:16 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4662f928-37cf-4ade-3fc7-08d9b03a3996
X-MS-TrafficTypeDiagnostic: BL1PR12MB5349:
X-Microsoft-Antispam-PRVS: <BL1PR12MB534971DF3435865E52872B4AC2629@BL1PR12MB5349.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u3r78jQyM19SfVl8Yt0rllOyMY9Ms47b1oRvk3FO0AtrBvWBDFmgkS6/6+9uEAmc62iQlYDN2qafdsgnQQJC4Pof7PKpoZUe+yu6gq4PYe6XTKnaOThv9+CiNRXtvbvy1DjYCuCBNEo11JvT9vd18+Kg+2rzODAr7yoMWIb62+IZZlI26ABkpQdWpktbkZZU5/Nd9eKjJn1uz+gcRZYZ2PFZA3sa6n0A8vxJmLt7S7m9iejuofoKY3Md9JGEUPI6dLlOy6/l7wccyjK5sZ7PeHtEs3UPAixGOgfwDvwbJrz+sehOXVeOu1z32uayu7tPcq2X2cip8Ysy+ouVYKVjrz7wEJqOJDyIPeVtgdN8FM7af4T+zZJ8e9VjEfMXqx6sed5DdBpOIrwGBVEeOdwP6gieP7FGN/baSwkhT0xEnUboIffrOE+muZ8ZL4ulX3DGd0eEU6FM+qamMH2krK/L2Eq7hgWXukJXx3YU/ZWvKHRD+TtvYQKI5/ivl3I3kg4J8/DBhShEjwmuwmS2I+QvE1FzhVELQtIprmBWiykOHJm4AXh3CnyOxcci7IFleJUUSyhTjbxtAexozijORZpSPsXBCkM7KfeksKqKkZXLp00ypewozkg3Xqp/BGK5qxh4SNNe1b/09nkFaJTeNmLqS4cJFVpg0ab/jR+8VDZjqm+l8wMiiVRnM7d2CEsFKhbemkE47makBsILJ9BUzMiAyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(66556008)(4744005)(66946007)(316002)(2906002)(36756003)(83380400001)(66476007)(2616005)(1076003)(4326008)(426003)(33656002)(8676002)(508600001)(8936002)(5660300002)(38100700002)(26005)(66574015)(186003)(9746002)(9786002)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGxLUTNhejdlVnN6R3ljN3ZIaVpJbDlDQVprcjFaS2laK3NWUlNaTGU4OEZs?=
 =?utf-8?B?UmZoNFV2ZHU5TlkraStZSm1PeDVySnlxSjRURFJDeWxlM3lkNUZWVkVicFAr?=
 =?utf-8?B?RXJ1Z2RhaGZKdDRURGJKKzVMRFZOWExvUHRFWlVIVy95RUNtQ2I2RVZ4bkFU?=
 =?utf-8?B?Nnlub3BUTXZwcjhxakF6MmZDeXN1NGZ0Y0pTdW5CaWZwejJmRGVMcm1RZHI1?=
 =?utf-8?B?V25oU2k3eDlPdkRPYXk0dHRvNFRhSFZ1RzlDcVBud1BFL2swYjdoMk9hSVB3?=
 =?utf-8?B?T3dqb003UGxqcEQwaFcrQjRmT1czVWRwczllUmtNYVJwMVZpdWplWUIyZVI5?=
 =?utf-8?B?NlRNS0xjbm1qK1FZdWhaVDdadi91T2ZCaVY4T1pKZ1FjWVhMMmE5clpsTGsy?=
 =?utf-8?B?T3ZackJQcnowSU1pcEJlM0l3aHRwMkVIeGpCQkRmZmxxemtGNWN0RkhjODdP?=
 =?utf-8?B?bTErRDRnUk1JQzhZaStabGRjdE56TmphUEx5QzFwYld3dnlFZ1h0ajR2SGdP?=
 =?utf-8?B?SStxOXYzZW9LZWZnZ2VlYkI2TkVtMmtGM2JRUWpabUh2NnprbHQ4WnlKdEV1?=
 =?utf-8?B?WnUwaHB6cFlvK1RDVVd0UFVHRTN3Z1hqbkh1RGZrUlE1OG1BcVJHSEdYSXR3?=
 =?utf-8?B?YXNHWlh1SGZlWVVjWnFDdURkczdYMEcwOE1zWmpNRVIxdC9uZ254YzhaazR5?=
 =?utf-8?B?RmN0Nmp1U0lZWHQ3WnVoQ1hULzFuVWZwY1ZraWY4YjFqeW5Kc2k2d2dISlVN?=
 =?utf-8?B?R090OUJ6dENLejVRNVRZc0c3UmdRY0hMRWNKWDQwb3hrZko2OHpya1BPWTRK?=
 =?utf-8?B?bFhYRkRieHNBR3NhQ1dpZE1SNGhvZkM0cDBpVnc3YVROeE9SdkFxcWZFeG1n?=
 =?utf-8?B?ZithUFpaKzE5eVdFZ0p2WXJQQjJuYjVubGhKSEUxdlpFRGY4aW9xalR0eTZl?=
 =?utf-8?B?SUFnWUljMG9Tc0FtSEdPSDVsME91MzJHUndNSkpkV3h1ZENUWEJGaTNkUWUr?=
 =?utf-8?B?VEx3SkVKUXpIcnF1TkRjdENqZ2VoUnM5TW9qZ1ZDSDhKeUpXMHo1b2hrdG9r?=
 =?utf-8?B?MVlQTk1PWHNxWjlxT2loQ3FWWW9GejNiWTJQcVIrTU56cmVpQWFXK2JYUVFu?=
 =?utf-8?B?OVRzVjl6eXFkcXlxMjhQSzdvUDJHL2I4TUhzWW9iMzg4UEdweDZONFh4SEk4?=
 =?utf-8?B?eDRuM1F4ZkdENDJ6QlE5Zjh6YkdQS0FPK0lOb3dCV0orYjJ3Y3JQUy9OTlVp?=
 =?utf-8?B?bnp6c2t6V1FvVzViamRrdE9HL0ZKQjNMSUF2YitjUU5WOWtiRDRlaXpQK205?=
 =?utf-8?B?aDQxYjIydFp3Ri9ta0RJa0RPOG5HTmU2NUVmQ0REeVFvS3VuNjVRSHBMbFBC?=
 =?utf-8?B?Y2tXUmc2ck9HV01HQUNnbVJHL1gwS0VSeU8vY09RbXNDdzlNVkpKVjErWnNF?=
 =?utf-8?B?RFpYS1VadVpUNFJxZlhZZmRrQjdDZDlraitkRGd5QjAxRTVkV2VlU09ob1Nz?=
 =?utf-8?B?MW5FWkJXTGZ6UnlPRWNjeWY2QUIwMjBUYWpySlZjbW1JS01KVXJRRnJNSGZr?=
 =?utf-8?B?NXVnRzZSVEErWWFGcDlaWWRpYmlPdmMydUtoNUx4WktKL1NPakg0SW9kWmYw?=
 =?utf-8?B?Tk5SM1NFeWRKc2NPUm9yTlpHaEc5ekZWVFBZZ1dFREVucjNnUDlQVGFvWStK?=
 =?utf-8?B?UXBlTHZ4a0R0SkpVYlZiaEYyVGtpeDF4SXp5Q1BHdmN4RFZaQ1djNzFacUQw?=
 =?utf-8?B?aHRYWDB4Q0tKK3ErYUhja0R4VHFwMFlZN1I1Z1dZZ0xuK3N4anBjL1YvS0ZM?=
 =?utf-8?B?R3ptUVRDSlJ1eVhEK0JkVUN4Z095WkczWnVJTkQwSTRQcFZydkpYN2g0Q3RK?=
 =?utf-8?B?THR5clZ5RUhJM0x0K3ZocHVSbmY1SFlxVUJVUzJTWXhLSEtjYTlYbUpHejZs?=
 =?utf-8?B?dWM0ZGJCYUpzUWZuNWNiRW1peW9ybkxQRXd3cGNGU1l1aW9ZZ2U0VVkrc2p0?=
 =?utf-8?B?ZUJzQmhKMlJJYVpUYURldUhjN1UzUytDT0IzZ2dBc25TZThRN0tDVmVjSStG?=
 =?utf-8?B?bm1PcTJNSVRjdlhjV3FKeXNDNVI5KzlJUjlmemt4dldEb1dxYjhiOWp4TWly?=
 =?utf-8?Q?Fo9Q=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4662f928-37cf-4ade-3fc7-08d9b03a3996
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 17:37:17.1779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1x0YF9Q/ApJnmhmR9sWc/hUIVtEd0fBPwp5cOPF5L/O7ow8gor00Z9FsSjY3KxPl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5349
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 23, 2021 at 11:06:18AM +0100, Håkon Bugge wrote:
> The existing tests are a little hard to comprehend. Use
> check_add_overflow() instead.
> 
> Fixes: 04ded1672402 ("RDMA/cma: Verify private data length")
> Signed-off-by: Håkon Bugge <haakon.bugge@oracle.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> 
> v1 -> v2:
> 
>    * Also fixed same issue in cma_resolve_ib_udp() as pointed out
>      by Leon
> ---
>  drivers/infiniband/core/cma.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied to for-next, thanks

Jason
