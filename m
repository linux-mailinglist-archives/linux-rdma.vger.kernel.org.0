Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA33939EA5B
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 01:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFGXs3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 19:48:29 -0400
Received: from mail-dm6nam12on2085.outbound.protection.outlook.com ([40.107.243.85]:13152
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230233AbhFGXs2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 7 Jun 2021 19:48:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RrHRZuyzS2nBei1dVDzlApcT+udxfBdHSdQzl/UUdb5J5EQ5tgYjpXdAzGFW98U7NSCV/gVTovcU8s6bw++UxUvx0WQ2gbmER0eeGLT1IpGkMRf/dwwx5B86qsJ+MXCOJZmkAc/yjxRnxObXQxVjMGzIF6BA5MDlLKLcyB0U3bWADi1EGt9J1mridoVfORhJRoxmmwuWezYWDWtrtLlfyxI8RWIk2/QrW9UYlfUcVbbVH1jv3us3GgF2/qFhEojD0vqvhd4VpMJFIYPgHa6eBn8jKhjMl84ay+VZkqVJe4TMszsYMoFCC70okqbwRXNxFtUo0Q/S02Wb30pTv5nfvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lb1MKQACWmhY0wGVMQqblfD3+LTEbLD55GW6oWA9qso=;
 b=lLj7SzyqB0r+FczH1UNxw6fktFYYwKa9bf8kpHTSlN4hwWszDHkT4wCzEgeJbhn2JEZhMrWSP4sEmsirHHW2AGKIuRNIULz/RTvBA5KT8abT3YlBH+PjgvvYWrL4jH0Gt2JGm9k0EK0PIGBZZ0raQ5BQj5CYtu+sIHg/nYcmFmg2dSBRwher85VLngj0JTArGv7j3o/hPKYoPFmcUTWxx5I5+Nxljgopjmzva6EMu/uvMuNBck2BX0CGRkKDcZ+iOxUTFV7VJ079bk3P8cgOgJ5M2E3mSy8XqHwb2rrBgNuAu33W9qUJjF2LgzHc45V98TvqxKhxwdNxhVnZTpHg1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lb1MKQACWmhY0wGVMQqblfD3+LTEbLD55GW6oWA9qso=;
 b=LTsPWbo7mu4fAoCw0Cn4wtOqE5hA9PMpIWAzLNd/78Lwr/Cn04dMRvQ5imL0bwYCwy/NOcFcTqA5xmiHIjk2pNB4geC9f+gHwkadRrducaU5awPvCCstIaVD4RnR5ZQFV7swpYflwqElC1o7prCWXi6d3Oi6VzcG1KUPjqBtyhtjClJaUj9e67BC7otGmXYL+CZek/oJUEyt7MpdBTal72GDI+RYeWbpLGNuVk+FbNue9Hnt8Pwtx+8ECKSoxb/7QDJUTiRt/KspfLAM1Tg1v/lBU7mr8O5yZB1y69E22cSKiS5F5SkFa3el8aorVxha8QIxEz0PtkVlPt+oxAQJCw==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Mon, 7 Jun
 2021 23:46:36 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 23:46:36 +0000
Date:   Mon, 7 Jun 2021 20:46:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>
Subject: Re: [PATCH for-next] RDMA/irdma: Fix return error sign from
 irdma_modify_qp
Message-ID: <20210607234634.GE840331@nvidia.com>
References: <20210607221543.254144-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607221543.254144-1-kamalheib1@gmail.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR22CA0009.namprd22.prod.outlook.com
 (2603:10b6:208:238::14) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR22CA0009.namprd22.prod.outlook.com (2603:10b6:208:238::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend Transport; Mon, 7 Jun 2021 23:46:35 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lqOx0-003Wef-Mw; Mon, 07 Jun 2021 20:46:34 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5ed1bfe-954c-45df-5ab1-08d92a0e7caf
X-MS-TrafficTypeDiagnostic: BL1PR12MB5192:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5192EBB588B69752CC7E9B38C2389@BL1PR12MB5192.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f1xBB6HAuFNMvrMc0S4D4UH/VbXR/Abb0mPeNx1xtIngteZ4pCyzMHNxteL031yA6tDO42WItmSW4KhSWDvaae5Ld8Mzoi6QBKGx1Rqs2+uSyRY6U7uYhi/7ELivsUr0mWTS7J9ALzoSjnWg7a+5TcgXOX5dGItMB/GX30OUvZ7+BDPlcOMooCSaD8qhDyaZ1xyUasXKpmpodsAZzcLFr86hYFoWo1lWVSTKIBhZXfbW6gBEWGtanRfhnpE96iNvYaMPRiM8u4ucm6NkciGSCPB/y49+cyWP+Dlgs/30tmUzQlrnXAFu+xp9tvEnugUOyxPXHE19qmptqJgAD4oMrOnwj2rpxqrleYgeIBDl9YhLiqja4b81c0wpfrOEezFuEkIqEPY3Dm/fbAueq6METi1sJYpKVhiDI19YRBPVTuAMYiBS9iim1lJrerZ6PSMLSPH1loP8lYPn+3wmf3y37xBYM0QOgEUYQ5/8/nEkTmi3Eh8Q1ycaHel28EMo8T/VV0FwZEaLmWcSa4hi30GQkq3sjEE2b5E/2Bb1WunhhHMoesp+EY3Nrf9gCG7CX3MoDgknllGN61rcBcxiB0K+Es7DgtP9R7Xs/Gr5NLYtLUZcG46mla5mNmKC7n01ipPkCOlcSgVMRkCTeiSWvI3sEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(6916009)(8676002)(8936002)(478600001)(66476007)(86362001)(66556008)(2906002)(26005)(9746002)(38100700002)(186003)(9786002)(4326008)(1076003)(316002)(83380400001)(2616005)(36756003)(426003)(33656002)(54906003)(5660300002)(4744005)(66946007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?4qZyCSnbomTPxKAvV8W9xCEAfE9xJ+d6xg6JAv37lsBnLbaii/VQy+HtnTin?=
 =?us-ascii?Q?JG2dQRq/1NxRxdmqFsSnJYWLooLWWcB21EbZXm6Sl8KGI3OOzJQzu/Kxemwg?=
 =?us-ascii?Q?PBBC5eUdcy26h34qwgds4jMbMMHRxGUpsxBOEAFiYzQJSZdY+n403Fys5L16?=
 =?us-ascii?Q?A/0GaV1XhOIlt1KTjCi4eJPkTPz+rO6/81xwAe6fY4EBiJKrestHOQ2Z+PvB?=
 =?us-ascii?Q?m8dwpcdoSBA7IcCMhbH7P7Z2umrkeZpLxmobAeOV/EpE5Gyh45G4CegfqMSj?=
 =?us-ascii?Q?WoHcMIF0yrn45Sqz1o3tQS4dly7kR/cGdLv8V9sg+L2Fj/hnW+SgW5MuR89R?=
 =?us-ascii?Q?IySrFiMuBH5AFMhuLw8cIuMP4WLUmPJJz0jMUtFpE+iVs37fzAP3oJb1YMae?=
 =?us-ascii?Q?lObYdTGHViq5F17S7Dd9ZebRaXDuNQx0B7OkPK5kQNF4GeNzHWKGFHhCXIXh?=
 =?us-ascii?Q?+tWhcYV72iBOpRATRhSaxz3YqwKdbIHO2Je1IYEgfS/c2Xy9r+f09cyGXxQ/?=
 =?us-ascii?Q?gBUnf6QcaX1KVUZD/XFrkvyqDQilzUmV4bTXn+zW5qbKxPEvVMyVuGcvsopX?=
 =?us-ascii?Q?rUrVx64cAW4CTT1w9RHtJ8lkfpSIVgR6ejHPizWFWaeovjs8GCs4Sb9uHym9?=
 =?us-ascii?Q?XMi/XJv1mAGtkhcGTQySp57fW5a179LDgGJhh39anEhmMZPAMDDsEQxWNg39?=
 =?us-ascii?Q?ZxOHozOmBFRLzoY54abMtnlMebkVUHfdFXr5kE8ekn1BIu9pvOSvnqaaCo2o?=
 =?us-ascii?Q?ccbgIK1feNbiIl00N7Wjf68vO9GZkWWqXBeYe1SrdaGbgRnhZPoQraLov6rz?=
 =?us-ascii?Q?1A43n25Zsd6h8NcOUeP4zgwaKtaCZPuBdINWqbdKYGGky3Mlp4r+TAfEy3gw?=
 =?us-ascii?Q?kawE+dahhI+Nu4bb/mCGwUzV1kFIFl5tTgDhuZnkej2Z1fgllA6Ph72ACouv?=
 =?us-ascii?Q?Ei0EOyNb5gkG2gdBPI7g0gCzOU9Zd5xd7+pLSJnoOmnA1awN1V1KNX0FIzTT?=
 =?us-ascii?Q?9v94U/6ChovYC2In3+ARZooYF0Pnt5rLU0MEUOvRtPazMjRyJS8ewDhRib4O?=
 =?us-ascii?Q?tWotbFBHPENTYuFSmiYPzwVFIdfnWifwqG/8OnJuDrRXsXm0F3TIUToBL08X?=
 =?us-ascii?Q?QVOI/yEpa/YUZWa4OnUkm7G8x+QFSxEnXK4UXpil6wsazOQV+w3vLyXGj9Ai?=
 =?us-ascii?Q?q0X025svyis2/04gkw4Tuq3y6QILXOEI9TUWWXHrKMYcwtrHv1OIK5wkNomf?=
 =?us-ascii?Q?xJwCdLRQcZ8aW0fq08JHAbVES5Y8pkSzYYdbAw0USGuyTkeYNbg34ei0DP6F?=
 =?us-ascii?Q?vk5GOZXXS2KKUexbKj+EqOzp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ed1bfe-954c-45df-5ab1-08d92a0e7caf
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 23:46:36.1203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tam38dkfpUSCDjg6CAsnTEbgkZyt862WYBLrA6eLZESdDJsybLmk6j38KMWzG9ep
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 08, 2021 at 01:15:43AM +0300, Kamal Heib wrote:
> There is a typo in the returned error code sign from irdma_modify_qp()
> when the attr_mask is not supported - Fix it.
> 
> Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
