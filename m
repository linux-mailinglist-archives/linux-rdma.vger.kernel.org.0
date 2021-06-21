Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430CF3AEC15
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 17:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhFUPO6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 11:14:58 -0400
Received: from mail-co1nam11on2067.outbound.protection.outlook.com ([40.107.220.67]:57952
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229747AbhFUPO6 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 11:14:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaWzfPgIaWyFd9fGjk1G5BWbYU8gMWmiYTGiGe4pvYU9i4Lvq+4fFgVf562Xql3L7mOiMC/lzeJrdab66HSN0t/XTICkcJWLe1uIJ5Xwziyz7vSKsbKDLZmPdSVEdVu+Ftyyae4n/RjryrmMHh4KlUBOP0bFRWgcaN9sZwMCn1kDjCSs7DR6EmZkK2+uZEcFLSdu2y2ZiMuoFWuWvWFhcWDXN5LHsixf47ivxyWZhCd6InPJFkoH3wPlnBlbzZtd0yXsiKZ+9xEbRcJx/gh+3jD4LVtnUHerGUt76fTwZZpG2LD76gOUiNkb0JKzLqoBnH5HdfYKscnH+ZGCo7OO7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHoNd0VYT/KDl1J3xpUv7RF0EdzKG+iPGp1XDGr2w+w=;
 b=MtlqHUSdMManhR90s3pme16EPawzGz5CNXJifakRV+CUJXZqx/OhGIm6TFPp432ZCtNf1b1e1pEFJbSIsOscor+KnF3tlokz+t6CsKocY+zh7zlxqB2Qw1FGVSoW9Ocu6VHKCiI4fYoNgJvo/OrvX8yXyU58kXgtl/k+UtZMVwg3qynuAQBR/UQ11+GmI6JAll1FReFqrIj44nuo+TXHmXcMujkzaM2vv10+Tolir5ILC79+yTRnkrUAy6JpUgoYEoyNBhOPdTeyqRHsVEGaZcO1REmga27zal99Xm+n8DKNconEP3n0A1tFjdWNpHLiKE5JsYnsSA4GcFoMGtYyXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UHoNd0VYT/KDl1J3xpUv7RF0EdzKG+iPGp1XDGr2w+w=;
 b=a47xgCuAUU9ugxuwaT/DK00Gx5IyXMpaS8T5uVtknyqPvR6jpv+ZZFNR9FXsdHbvmWSUq6qBkFz14UAf6RpSRes+Ji5BcOxMnFA9OdxG3N+bAux/y31+fxeEW8lgU4rlosqW07w2LVxKuPejswlc21o9oaClcByKMBamndFllz1bLNxtxvMmjLZkY36YOZzEKFbCMX3++GXFHLvqvIRQPGc2Mr44cJtpPeT4TNiwM0OGo+3pYNwr6cuJbIQ6zOF3nCfQ1C8WwePubS8fUXk6XWvrys1kDDA94xYP64rWxvImpELW2kUn/+Ru5hu2KXpGJWyfxQ13HaMSQhNe351i+A==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5522.namprd12.prod.outlook.com (2603:10b6:208:17d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Mon, 21 Jun
 2021 15:12:41 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 15:12:41 +0000
Date:   Mon, 21 Jun 2021 12:12:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Hans Ry <hans.westgaard.ry@oracle.com>
Subject: Re: [PATCH for-next v2] RDMA/cma: Replace RMW with atomic bit-ops
Message-ID: <20210621151240.GQ1002214@nvidia.com>
References: <1623934765-31435-1-git-send-email-haakon.bugge@oracle.com>
 <YNA7ZnKIKC217pCw@unreal>
 <C8E39F1F-14D5-4DBE-ABE0-2EFC20353D83@oracle.com>
 <YNBhuZNjGvUsJHUy@unreal>
 <FB3E1A32-A1BA-48B8-A20D-99662CDAC921@oracle.com>
 <20210621143758.GP1002214@nvidia.com>
 <36906AC6-B2DB-40D4-972C-8058FF0B462C@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36906AC6-B2DB-40D4-972C-8058FF0B462C@oracle.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0044.namprd13.prod.outlook.com
 (2603:10b6:208:257::19) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0044.namprd13.prod.outlook.com (2603:10b6:208:257::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.15 via Frontend Transport; Mon, 21 Jun 2021 15:12:41 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvLbM-009Xsa-9b; Mon, 21 Jun 2021 12:12:40 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95f9b437-7a95-49d0-4bea-08d934c7038d
X-MS-TrafficTypeDiagnostic: BL0PR12MB5522:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5522B5D5DDF6B1B7931BDDA9C20A9@BL0PR12MB5522.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:529;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2VYZeCR/tySXHtVI3kXG1qS17uo6N12RHm+UNvnqnHOlCweZ1MsCKMWIGXq7PghGPBNUVZJKIrKy5vM1Q5OCAQKuIKIk+GF80l5XRl6p/PC1tAJOB+pulbMJUu9rNtKnlFV7Mo7z8J5MD8A5Aqb89eKMmLjVPOxRtibxwsmNj0QBP1GKqCMFYyCXuHvHR4F8kXwQN00Or8q8cKVsCsoJA3lh0mQaEQvuAdwG4sSuFgTe+IqPJOA2GhIAubgaTYc2/m6HvYa4AbfhBsmuaiZ1EKNzMUqFQ8z+d1kVfaL/96D8RMow1AdWa0l1KXaS43laKIA03ldJBj3kxTCCdfcWIUkpiI+Hk2rEvlnmG0YlLFSJwJuqwo4923HHqcI9K320c4Gh3GywBuQXb0J1VeytC8E9acVFcGWV3CIhY0vwmw+kXMEdLY4iVFDPRqYJbS3VYY17iOzHX45fo6lcL5sHyycY/8BpbnlRSnQOSDkx2uNuqlSf80RFgsOmgfJYBwiBzgkOv9NFXYOxIqPRcwRG0TFyOBK80gEL1OSQw6QlwCvrEZHg9KaQP8dExUMcsYaWLGd7C+x0/OO/8aq43v2uYPLWCRMe90vuu1f2rfuItFo9GjW9SvAhGmsx0sFrfcG0esOPGnRYxeiH+nITNvLiL4QgQ9WedyWN2s2yiZH07jU8vN8IljmT8X0ACgGJUzO1BGvKTP/3+56FRuyiYi+Cd03KLe1miI+5MAhqXh4480=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(1076003)(86362001)(426003)(66946007)(66556008)(54906003)(36756003)(66476007)(4326008)(2616005)(966005)(38100700002)(478600001)(5660300002)(26005)(8936002)(53546011)(8676002)(9746002)(316002)(9786002)(186003)(83380400001)(6916009)(33656002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rASH1cGSjA8Tq/Cd6ABHaPOx9awWHEQ+X0gl1Aj2zg1CZUhVMCU3/P2TxR8i?=
 =?us-ascii?Q?h/EhgsNTKRd8GZFWNrD5fXMhxHC1kN02FpC1UjAxyR5hxU24MWlayQQA2tDZ?=
 =?us-ascii?Q?Xmk87TOOf44FI8OUKmN1zI11fiRNkCpE/ehxqW1FCKVevbB1EJqP5qxXXfeQ?=
 =?us-ascii?Q?SSFuit7PjuAvLufi2JgXLjCjFlLs5OGzzPGU9S5C76Bej+zXUkQ3d1kqdtv+?=
 =?us-ascii?Q?HPYjQviEyd6Vk42mT3nV7luiZwJtyBsUoduxbmmmfrD/gOMpzM8qoVvSawpd?=
 =?us-ascii?Q?dc7x+6I/0mXPw7ZncDJxXhxMROzuIN83V/vgODKCDiTCRGy+eNignfNGGQFZ?=
 =?us-ascii?Q?uK+4DC/gvhKkJ61ZsFeXU8Kenm9BR3EXCTe52/0/WlHyQXrKd5UFOyaOKpm5?=
 =?us-ascii?Q?k+r+T526xeSkAW6A4REE1EDo7CQBdA7QbuX1LmvKmEqAVRTjFaRmNIndGlnT?=
 =?us-ascii?Q?vhA9sb4FF5eM2TbmSfWO418sD9w2+oUxIg4BTVP0EZEGRh7/oxgEGWy1Oche?=
 =?us-ascii?Q?5j1pGz6okDshUwEwYmfr3xh/dox3DWEDbWhPwI491BYnL5ups1oNkQuFYnSa?=
 =?us-ascii?Q?Ys4xAjyD0Lk7NSzZKjk5I58ZUW8vvxD4YgXruRAJlAXRuzI0tJ5doNbJ89V8?=
 =?us-ascii?Q?nMiA85nmNifZVfUwQVPcnBy8Y25e+BYfv2FFWPhKiLhe8knFOwxGPnAfDO1d?=
 =?us-ascii?Q?d93iO18IIHQk5a/EjUbRlirRWpvET5PpGsvU+luX/dK1SQVHVKmfXYYOJIZ3?=
 =?us-ascii?Q?oVltMhaniAhmculWsQ8JtJTI8cJDz2VOrkL797WBrRImpgl7uxja70G7mKUZ?=
 =?us-ascii?Q?xBUPnYP1OBcDqnJld03kOSezkIGAwr1sl7UUgPjG+SPGBRULA2msIBwAhRSi?=
 =?us-ascii?Q?eWFasOeAr48Je63MlWHySfOWaGUVlsA78HY82z3Oqpu6x/Y3pX54bHxNCwZF?=
 =?us-ascii?Q?U4C1o6Y7XX7QMVmbbmMo4nxm45+v0NO0RtOWr8r9QCDP54P9NfdanX0xxzk/?=
 =?us-ascii?Q?+TFjGTO+UGDzYgbjHnXsNm63mUuEIRGtY27on45QuX9EaOR1cpoKgrMDgLed?=
 =?us-ascii?Q?+2yKGWPdHvn6kU7Yo3NQK30ZkM4gATd27TMTz6jDXpRsD5Hycw/hlFAin9OF?=
 =?us-ascii?Q?qu36J5BDkfbaN5lqgStQQUAMBmShE93YSrYoUXRnG8FZyi0/2tWJ7+R5NxZu?=
 =?us-ascii?Q?asLsKSaRWQBSIS5fMsBFA6z5mn8m0gnZwY337UNUUuefhrUmu4AEysReRgcN?=
 =?us-ascii?Q?HkdyZabPGx9Ptex7h41MCapR+QshLAhdVeNbBdlld7d9/cCDtR2U29tw71dl?=
 =?us-ascii?Q?FB/MHZwe7jm5tFncyZQG1T0X?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f9b437-7a95-49d0-4bea-08d934c7038d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 15:12:41.3966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZSIFdAQ7LsUPSE08pXyvDSkigvKA8eGe/KSuCX3DA0z5JYuyiggIMImeqPvc1/y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5522
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 21, 2021 at 02:58:46PM +0000, Haakon Bugge wrote:
> 
> 
> > On 21 Jun 2021, at 16:37, Jason Gunthorpe <jgg@nvidia.com> wrote:
> > 
> > On Mon, Jun 21, 2021 at 10:46:26AM +0000, Haakon Bugge wrote:
> > 
> >>>> You're running an old checkpatch. Since commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warning"), the default line-length is 100. As Linus states in:
> >>>> 
> >>>> https://lkml.org/lkml/2009/12/17/229
> >>>> 
> >>>> "... But 80 characters is causing too many idiotic changes."
> >>> 
> >>> I'm aware of that thread, but RDMA subsystem continues to use 80 symbols limit.
> >> 
> >> I wasn't aware. Where is that documented? Further, it must be a
> >> limit that is not enforced. Of the last 100 commits in
> >> drivers/infiniband, there are 630 lines longer than 80.
> > 
> > Linus said stick to 80 but use your best judgement if going past
> > 
> > It was not a blanket allowance to needless long lines all over the
> > place.
> 
> That is not how I interpreted him:

There was a much newer thread on this from Linus, 2009 is really old

Jason
