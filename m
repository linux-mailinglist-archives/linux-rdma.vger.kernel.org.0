Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A8F3F33E9
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Aug 2021 20:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhHTSgs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Aug 2021 14:36:48 -0400
Received: from mail-mw2nam12on2059.outbound.protection.outlook.com ([40.107.244.59]:45975
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236193AbhHTSgr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 20 Aug 2021 14:36:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgI/XHJGKvEC6T71ouBfDTsXTFVolS8N9ITT+z23EJKgMqOzmExaYHlJY9mh4lxsNhi12t3FBAYAdgy45HcLhuDcONV05e9B7aalSD96+A7da2KW1Y+TesR4ebzJCdTyQVAK5yj8GhNkvl0UaYuWj8Q4aBF3IVdtx3czgWOEg5XpUOYSF5PPhRQB61WJQBcXR1xHFGZR3SOdfmO8o/n9KvAX7Zar90yImYOURfclo+Cy+av7WLie9kjapNuyYtpCpj3OKdlwkJTjzwxhV6NzdvDvxuQQOWqRBzRE+H0WrSDjX0ppv8nqhw4ah1YtQS7eqpmDb2A8RRcbs5nUdZTKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuzTIl5qpWvPfU9lKGNHup4j1+qBBiUDrRZR3E0YblE=;
 b=hnKtLS8dg7ChkpyQDHb/pR4OF1SzxDxrGlpZGtjIv/I5fCVKKk1FMDvzVUXw6Ke+9sTeVzL8sMVc3GG/4aq5SLMoR2Fi2md+ZytoHdMQHeV+MuE8j4dc1NwuQJTVfiGx7d/WKDiuT7b+Alq2txMfkfVQOQ6BvVU9R6zp8GYESMnkh3rwd1GAonzgc8vD80yX3kUxZMlb6wUoYYmpo0XeJRyPnIDDe7tpBYyGi+TTxTG+HpuWvD6NnHeZDcF/DAshHF/rh4FnPsahRF2ntDp4zEy8huJA2A06zxjd0gPAWgi5cdjwsSWec5FaOnV57oY4N1Gf7pkJffD46z9v2c8e2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuzTIl5qpWvPfU9lKGNHup4j1+qBBiUDrRZR3E0YblE=;
 b=BS827ag7M/g5zlFlFAB2g2hWZ6gRa1Wns7JHsa6QtC+v3N/YTh98KhQKohHAEU2MAVZ3kyYHxEI0CssNzzitKnsa8K5VQNia15XVu2D07CNEs6ifUBoYo4EvUNZMxI83NGkytsfUkNN1TzqyTTNCFw74+mqF3N8Ny0QRkCOS2YgplvMzZL7b9ebGtXFCQpGFCMpC3OGgmz+NmHgbRU3d7XMOBVKidTfYlkbpD0u6hqlZJho/dWSt+1bN2ZIVHn97EpnXFLoDxWNVqPccWm9v8ppH2AVKlGyMWlU1mBsofMOnaoV6kiRKn3SIggr2OV1s3DKRNDicZFyKtAZW/Edo4w==
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5379.namprd12.prod.outlook.com (2603:10b6:208:317::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 18:36:08 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.021; Fri, 20 Aug 2021
 18:36:08 +0000
Date:   Fri, 20 Aug 2021 15:36:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>
Subject: Re: [PATCH for-next 0/4] EFA CQ notifications
Message-ID: <20210820183607.GA565562@nvidia.com>
References: <20210811151131.39138-1-galpress@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811151131.39138-1-galpress@amazon.com>
X-ClientProxiedBy: MN2PR15CA0060.namprd15.prod.outlook.com
 (2603:10b6:208:237::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR15CA0060.namprd15.prod.outlook.com (2603:10b6:208:237::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 18:36:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mH9N9-002N8i-9R; Fri, 20 Aug 2021 15:36:07 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0b4748c-dddc-47d5-5fca-08d964096060
X-MS-TrafficTypeDiagnostic: BL1PR12MB5379:
X-Microsoft-Antispam-PRVS: <BL1PR12MB537933FE4F4239DFCEE39FA4C2C19@BL1PR12MB5379.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lodvvRunzLbiJjGFCmm4iN7PGEwlijdzXXKcLpfQViutai8XyyK9IQjmUgxB2cx5UouvK7+BkmN8haDusYFY3ZILiSTFhNkHFgmWmZS+EJH4uA+NK0+wstlVBH1L+Ca2mD4LSDsm0b6+6G/dTJCUMxZT6RkRmiQ1xWE5G6F9+vHbCX6XxFuvhqtE22IZfqgat90QmX5qHQZda0KmrjV8odKCF6HPKsY/0F5NU1toRw6lLZvaszVIIj7B2EghtQL9wsCrbR1i/Je3tsD3f7zcMnaBaxKn1bLZjXtMiqyP/pY3pjI5G9gIFZCm7tG8kpNKR91z1NPgzEcn/kZ3OhsUgDj/+28b99GAWS7dGFz7V0EE9RE6vqc5TG5CVzULi7sI/S6KJ77h1C3pSF7B62oFOwCTAE18Ex+eAphcWpaMhq1V3sJhk4sTAjBMsIVyVMx4gE/3Nkhixu0GoNvuS68G3MY/8n5TK4/e25bmwioiTfGFDZu3LA7BTOUO3BNuQLZMUGKYr1tz0qd2KyTOGxqAx6H7Z6Ji+wrM5p+AiirK2CLOSO8buwE/SkSVv/iMIbQyGDZynkESMSeMNP+osyJ0jHuONgdenaG+Gs9jIkuUNdK549/PRC/1qLNzzmJBHd6dYznKW23NCJmyc7C9184B/6R/+9aLOhLPmSZmad5wUQrZ4nDl5WpehSy2P6lNuTzQ7HK0ZPvtnovVxVX6d3kgeHOxKAD49T3NbNT2Y44Jz7qRiRo7aFbTbawCCPOi+2M3/nvsG+4EuJLHooUUzwcCSajjeix+v4LMUNGbZMrb7lQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(4744005)(966005)(6916009)(426003)(83380400001)(4326008)(66476007)(66556008)(186003)(54906003)(1076003)(15650500001)(66946007)(508600001)(36756003)(8676002)(8936002)(9746002)(9786002)(33656002)(86362001)(2616005)(38100700002)(26005)(316002)(2906002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v9DzugH5y8bfaz7NLBvREQD0MrG3v+guUKtE5yCrnPShFQXj0CdVl83AK9Si?=
 =?us-ascii?Q?wUl2u6USFZq21LTlHFr2PSN1BNDElmNSTVBYbPdQ93l0zKranYUFyEEd4Ecd?=
 =?us-ascii?Q?dpZM20bHwWGcFQSVOgDNfqUJ61qF7HfzPKY0Ty+irrktsd3X8NXrf2CAvrkn?=
 =?us-ascii?Q?QJiNK1pzdv0k9x+/km4XC9Y/pu1prbhnZz0+D0zjz7+XLletgvb+v/dBYAdj?=
 =?us-ascii?Q?N29aE6DBUB8bDkSanq152PsnDxfSwU0sgJ3bXZVKgZ6boDni/dtzpSGZT9Ua?=
 =?us-ascii?Q?9k2jvht3MvMI3JtyxdbR4RcjMBbPz81FuEqzpvG99H8aWZeJFcUk+XytcCyl?=
 =?us-ascii?Q?jpeNGvm7LVJc8b5OJn5U22GDZerJsV8E0O+C72l2atbqLdrO1fW3OzGdAhfV?=
 =?us-ascii?Q?OT8FfvyZQuOLGj00xqs+KlwLbk35Pp6nVgjKLFLiUfJI1tya+/sCLlJ0pnmS?=
 =?us-ascii?Q?d6KU8dwvTChiN2jspm830T30N1jYrzY5oFQPANBikg2ZyKTthLBWcoEsHulK?=
 =?us-ascii?Q?+mlZJ5XuRKIQcmZ14Z2IPj4XS+8jitQWTZ0qVh5jfJp+ue9W3hsw+C4Nz20q?=
 =?us-ascii?Q?Oc5uU1ihR9LUVZH4qxBE8p+jZj3E1hcL0F3/Et6+KnelVWoQFBeACRVC8p94?=
 =?us-ascii?Q?A74u3oQcu3hMkIHQ8HgiSZbLVn6e0VYjPhUu18iyXsBt27Zf32zvmcbxdNrP?=
 =?us-ascii?Q?a6ciKfcc1l83r484Uv4aDwZsZzknU+lJ6BdJH2KzxlUTICfzBaWT+z9bILBj?=
 =?us-ascii?Q?EA48B8Y1+P38rxeSQ0yPxx0Uhx6i05v8s8ywJPupzLxIDN9Ex3qQ0McrGokQ?=
 =?us-ascii?Q?P3wAfcMqQK+c0wcsudJGI0fnwS8p0xnL8o73ie/JWlLYL6nd63+XY8l5sbmj?=
 =?us-ascii?Q?Zk8OISYoNj5YhCq8vmGcom75Bqzy1CEuZ+2n+0E+LAtm26qtP4YxcT42XPKO?=
 =?us-ascii?Q?v+o76cVjm/zTsINMLWSTlggX5ml8xxscOXvzki2BVUYuiObBt+X7yKDg9MJW?=
 =?us-ascii?Q?AH7qDApCgj8EUzju/mgcEwV3cLLYt+epuMQp/aFhoOT6HntjshCLTP3JVHW6?=
 =?us-ascii?Q?Lph/Y5vBHi9DMonJaaJtZmWu8fWWaT4Txw/PJotUwSC8dJwGpL4mQd8xh6wt?=
 =?us-ascii?Q?8AzxFq3KKx4am9/S46Bgjo5L01Fb0CJs2lv/2s1qdydmXIrMIXzSeDz6j9bk?=
 =?us-ascii?Q?opAuQVwYjmIEDu5e67aCd6IqLEMC2iUJhmhv1S+2FsJz5CQHc6TSgljzSu13?=
 =?us-ascii?Q?LY1bPHwn5O4zh9qHPHIqlj82UukQuAGLRx4mczhCszKgNe64LbYCIMYvsWR8?=
 =?us-ascii?Q?9ek/MeaqKuro6UEtDXB/66mH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b4748c-dddc-47d5-5fca-08d964096060
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 18:36:08.5381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCvvtMDv089RpqJIgK28HAZbX8hD1lwQ/308t+Hestjydi/FCGrCEZIRN046bTeb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5379
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 11, 2021 at 06:11:27PM +0300, Gal Pressman wrote:
> This series adds support for CQ notifications through the verbs api
> (ibv_req_notify_cq/ibv_get_cq_event).
> 
> In order to achieve that, a new event queue (EQ) object is introduced,
> which is in charge of reporting completion events to the driver.
> 
> In addition, a new CQ doorbell is introduced that is mmapped to the
> userspace provider in order to arm the CQ when requested by the user.
> 
> PR was sent:
> https://github.com/linux-rdma/rdma-core/pull/1044
> 
> Thanks,
> Gal
> 
> Gal Pressman (4):
>   RDMA/efa: Free IRQ vectors on error flow
>   RDMA/efa: Remove unused cpu field from irq struct
>   RDMA/efa: Rename vector field in efa_irq struct to irqn

I applied these three, thanks

Jason
