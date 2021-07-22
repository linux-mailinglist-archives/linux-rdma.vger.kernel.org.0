Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C6C3D2513
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jul 2021 16:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhGVNWB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jul 2021 09:22:01 -0400
Received: from mail-dm6nam10on2055.outbound.protection.outlook.com ([40.107.93.55]:7904
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231925AbhGVNV7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Jul 2021 09:21:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VW2XyqLOC+vmWTZUmtom1pa1eFqPYl4vgTnwOc0X5l6I0RoVTL/BdDQK0FmUaiLLH2k0iYgql1ST7ZSsvFIJLbtoo83/5S1ReJBl7hIIOf/8QlzDaYFLas/SVs426FRYPcFDKpLfyqxbxn9CLwdvchPnKgq8py05j2R6wbvM1F3dgso5ifwHTYGs0fEismLWM8LWXOJU4ntbM34t/PbOgiX6dkJUDz8+f7Tk16+hbaDo9MJfxpiwepmnQSwkVLivvuKFCIKJ8yxs7RPE+ZaEK9MTuzL3VSMw7NbVUYDNsnF344QK508MJTrIR/DCMaqXcwLUqXclQp+XRd2e8PHmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtYdc1TtkzmRITP7cKbXnXXnKCef/78jziDnVJm8VOs=;
 b=K6w0TNYEvkYqxkfuEXujshnVWE2LxR50svdYKG9a96PcfRGwfa5/mvVd7JnIJgu55/1KWDpKEdQKk7SE87Gcvlk/aBzdhWmYU5CbKmcWmWWdyrFQ8Ok7faIQqfoxjaVAkppTLTHaxiSKrG17wbuu8CrLLqISAb8FEc14uBPPAChlcaQ04q5HWykya/mFPBwzX/hxXKuH/KmK0jD/6GupPd7ulWIlWSTFFI3fCp3edHOTFO4qQg8op0AoS8e/jRFJ3kPBokjVmPLXGVu4Zo37CC7ZII+3NN2ABcHfX0jUvz9W8V4XoRn7puy7GYK29DqG0AtfXDYoM2CjVAR1Wg5vyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtYdc1TtkzmRITP7cKbXnXXnKCef/78jziDnVJm8VOs=;
 b=fqZ64YJ3mSaZ/ciBtL3BkjELcWiF0pblHroAOcsRBeNUfvOzwHp5xxTrSe3jOAKifN5bjVG3iSqjbwYOlEsvFlLPUVUjjaFaWm02wYWEkA4+fmB8mEYKBitL7WLJDVx/Ysc7zQiZ6VaqbUUY2HS9WjYgziBtyeqjIJHzfA5TXD9ESTEv5hJMbZtjVBR6xEeAuPt2pzsk9Ev1tmI7cwapgjOACSy0KIfuXsXVWTkRhtDEDDuQ1UrWUHF0Iea+7vAteRbpH/E3oBQ5l5LyQHfSusk7+uwhCY43S3iLyL//lytgOuFTJSV4pa0QAV9KBMY2qVbOuGX0vsluzE4Fo87w1Q==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5159.namprd12.prod.outlook.com (2603:10b6:208:318::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.24; Thu, 22 Jul
 2021 14:02:33 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4352.026; Thu, 22 Jul 2021
 14:02:33 +0000
Date:   Thu, 22 Jul 2021 11:02:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Dakshaja Uppalapati <dakshaja@chelsio.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, bharat@chelsio.com
Subject: Re: [PATCH for-rc] iw_cxgb4: Fix refcount underflow while destroying
 cqs.
Message-ID: <20210722140231.GK1117491@nvidia.com>
References: <1626866515-17895-1-git-send-email-dakshaja@chelsio.com>
 <YPkhhDkvYY2JVM+6@unreal>
 <20210722120607.GE1117491@nvidia.com>
 <YPlrQ1Uu+OXxRJBF@unreal>
 <20210722130231.GI1117491@nvidia.com>
 <YPl6Oh5Gm0uQPiiZ@unreal>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPl6Oh5Gm0uQPiiZ@unreal>
X-ClientProxiedBy: BL1PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:208:256::30) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0025.namprd13.prod.outlook.com (2603:10b6:208:256::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.7 via Frontend Transport; Thu, 22 Jul 2021 14:02:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m6ZHT-006GAq-E7; Thu, 22 Jul 2021 11:02:31 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39bf7587-402e-4248-c6fd-08d94d1959df
X-MS-TrafficTypeDiagnostic: BL1PR12MB5159:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51593284B872AA564C7E102DC2E49@BL1PR12MB5159.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Le2IT84IjlShXibq914FbRwz/WnAUyp1nrt15IbXxTWMAEknrrzbo6X0/peYjsuiEBgMjxhSwsqr8jLRmYuBNm+IpGiFRM6F0g1mH7B2AWtiba+EltSNJxY/cU9HveDsnpLDY8PKla1h5DMmm6Or0bjIEpIPUfsf9ovXr6WsDpXAgoTEyHgqmkl0ZaNIWdFRGPFSTD4yVkR9uUsHB6QKgaYks4H09VQhR8RAyXul9xJh/v43XU7RC0a6VyyZJ9X2JbmGiq/a64z+ouDcJdjMI7SL2AwGReMxqmZbu7c1cDALHCP2PMhNJVnuH0Rc9X+f7tgvhLRXP2M+RoBj+mOI9QgWDNKurFXA2QIQ0uslkDiTzc0lLgAKXODYXVWy6BalRZ6X0Y+/tKwoA91nG2Ym8Zx72jY1PypxYt2UVlCzENTrDrcS7gDw4lEP24Rti6O+J3EN/hmzFwMwPF5pd9YyPe/XLOsVy5rLSaK7vF8C6zw+al1tE1fJbBxyRa6rPqNG/qt8oAoaJ7mlV34swv7Ro4VeoZdzQakNL2OW9zH+HCrPjVzTe7MXRK2Lu9OtdaPiCEpRO+oqSlnhHVeXJMP1NBCExA9XJf9Rs7KqmL3B981RK2ZRSmSJ6xVmggscnInH+ZHQVy2OceZfMoSg022tUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(66946007)(4744005)(478600001)(9746002)(9786002)(26005)(5660300002)(186003)(316002)(4326008)(2616005)(6916009)(38100700002)(33656002)(1076003)(86362001)(8936002)(2906002)(66476007)(66556008)(36756003)(426003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fdDIEsDsyfOJxmuWM/687xGohI07YZJFEf+XCw9lwGao0Gjv9Xo1f0xQ53fT?=
 =?us-ascii?Q?smohv0TCN8QrA3XE+CJ6o/AizgZ/zwP8FuH3gbheV3GCfeYYDcYkfJmZtKTP?=
 =?us-ascii?Q?MAN/932VJsGv0oqLUNB65iLV51bpSYQaXrKXT6J00cXQzB4hDwlPMa6jT171?=
 =?us-ascii?Q?I1p72nsoJDVH7utmmZcq+0iyaQWqjR1XacQuyilO3Cdbx9cLGz97bagLnDrv?=
 =?us-ascii?Q?xMSKlrccqwa+xPMCa+R0SziBMJj/qiPaST6zGMBhXfZUAvmB+8RfGH0y28Y9?=
 =?us-ascii?Q?Fr0sNTjPxDXl6ekxSEOWIjMoy9TJXdRfnd5mbjZx6pxFLu1JYNyKfu69VYBA?=
 =?us-ascii?Q?cy30/Azr1IHrIsIXC3dXLvMncKFLS7buihvCLhYMycNRt0k9TDjjfOGTBHlS?=
 =?us-ascii?Q?I17oQeQ4Oy1rroRAZGGtOGkICEA+98vKm/A6IuYFLz2Y6eYKWFQutKiKhe/e?=
 =?us-ascii?Q?dINCf9otpQN/fzmcxb348bQfMGItRiRbnpSnH3cYiiVYw3ayHmDmJGE3xEAy?=
 =?us-ascii?Q?BfCZ4SCyEj7b6zN1vhLBUkrx4s+b2ZKv9p3sIGSE7mFuuNFB3KiDM9vFWu+M?=
 =?us-ascii?Q?Yx2aaMZ2wYGX2n/efJJnqbuasGr3y+9Wiq8fJObqztRrZLFscRIUEK/F35jR?=
 =?us-ascii?Q?iJ6qV1ycpAEaj7CmYS3J2lUZkFjJNWWyOlYkJ1YNTsq6h/YNUV8HM8PSp/lO?=
 =?us-ascii?Q?3UCTkCgUJfR3Qi9x8EYrpDJNRoFqPHd14msIOS9HCNlj1Lli7yaRhGcEjQnI?=
 =?us-ascii?Q?jJ3mW5mOrgfT2cjDoew9VTG5bmgq5kMbhN7sNVdUmDtR/neHmYBbeXYdaU0g?=
 =?us-ascii?Q?/0VzshAr7PGBH9jFX9Uy1EzwBEhVMo+ex9ej5KxbBsnqqeUgwzILqHp3hPuv?=
 =?us-ascii?Q?zWFtPqr/n729EMpnb/m70IqAyALhjWjENUPB673rXzp3bg68cpvW+x/usDzG?=
 =?us-ascii?Q?lrT4usbXq2RhucBTkNkAovGW4UADlPOQsZCiX8uPKSX/raqF1+Dr5CjPjCdk?=
 =?us-ascii?Q?Z3kE6CBTqoH3Pg5mHL8RCa0rqjSl9xMMpWK70EsttG5FeCZ7R4VkRKH6Rvmg?=
 =?us-ascii?Q?loa8rSnF0SMZMlnQsElO9J7tOQHWoe+0s4h3ydFi4eEdVelBxL3YwRyOsfI+?=
 =?us-ascii?Q?yhNp63uCtA9fDhKjIjyeBaQPY2nvF2UEMO2SBkyjW8DKymsqXQ5x6f7O+lh4?=
 =?us-ascii?Q?ViJE2vyuIPWF1g7O5ukLXLhf3KvSd2Rgt/2mrVKPjkvEhmJn6KkaoGpbPX22?=
 =?us-ascii?Q?fJbF2GJ+dlu0VK0tRmGAuDVxCS8LzaRXthuJ373qCySvkvUX7WLhRvRth3YA?=
 =?us-ascii?Q?7f61JNjV/cWSxsnnSn6cLvw6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bf7587-402e-4248-c6fd-08d94d1959df
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 14:02:33.1843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sez5Ii+gsVssSWgamB7+m1RcH376dBfHTpJu0c8Q3mA8rBs8gk5zaL4wO1+iH8hM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5159
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 22, 2021 at 05:01:30PM +0300, Leon Romanovsky wrote:
> On Thu, Jul 22, 2021 at 10:02:31AM -0300, Jason Gunthorpe wrote:
> > On Thu, Jul 22, 2021 at 03:57:39PM +0300, Leon Romanovsky wrote:
> > 
> > > We are talking about two different issues that this refcount_read patch pointed.
> > > You are focused on wrong usage of completion, I saw useless compare of
> > > refcount_t with 0 that can't be.
> > 
> > It can be zero. Anything that does refcount_dec_and_test() can make
> > the refcount be zero.
> 
> It can be, but it is not the case at least for iwpm.

That is even more broken then. Structs with non-zero refcounts in them
should not be freed.

Jason
