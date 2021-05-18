Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63372387E9A
	for <lists+linux-rdma@lfdr.de>; Tue, 18 May 2021 19:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243330AbhERRlv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 May 2021 13:41:51 -0400
Received: from mail-bn8nam12on2046.outbound.protection.outlook.com ([40.107.237.46]:60128
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237923AbhERRlu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 May 2021 13:41:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzKknUwWr1BAxkqLxMW+Tq0+a40+4CH6Qm+OFqNpqIjy/t1hOcnfC7Vt9syRSdK+CR74KtDEgYcRsm+QH2lueJiRHoEF901VlxVC9UrTcGeQ+3slOEzQjOUkRwln9RBBIQUh4TrpUKlM7uzGAsHvLmxWIIbRrIWkTk/P7tYFxTLCNbVtrGjBvyE6qvgBjhsoHIMzYa5zC/zt2+5WAUt4BKj33pE9nDRhvgsw3TH64yMyMugz6u7ZmLxV+bOer/q1mmpCe723b/YjnDRISxAfnzBN2flrk70GAj2o6pToyUVVafSNhOb+j3TZjQxAncTHSsAHSUIs/Cut9DPAVOtczg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgQfJGJWmCVcSIXRPSXVA5icFLRkXHhG5gcpgj0hSWI=;
 b=besdRxcILwz+Vu1eihi2T0avi3ktsq7qNwT6P4QAh+xtKB5ZAPNeR0hyxuboq5x+4p/KcSCyNW2iX4dkeSXqA0owkLybkDeNlKvsNak3wJnUxIs35BTHgRMR5wS/ZZeIMa35UrRF2jy2H+uw1T3kUKmr6PV7aWz+OvgOW7z/j+C2aaVs+XUMUQRNmqkeVJf6eyea5BbrfUC6d5xeNhe47vJN9nHGYV7Rkf4SJz2+8ikr7Lk96KibqQg3LBH/3Cl/pYXGnuxaL39czocpzA8lodK0R+lxfWExk11NoWa4g3IIBg3MVn6/UFraw9nKhPiG8NGblSAsM3vVYAzZuvmzPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgQfJGJWmCVcSIXRPSXVA5icFLRkXHhG5gcpgj0hSWI=;
 b=oIiL/2lFnfSZtMiaYJJQazvddNyjtImF7cQOnE2OWOUaiPkACz2aVtY0qfs7zVkH9P1J4nYqAlMGGqpX4el7v9/9KET+3G0BrxLEUSG5qWOFHg2ftV/9TbRQJ0dihlvrdpvvn7eIC6pEYBTPR4WQ5s7Z6E+skL3WimmdWCJNqfebRDTelzizQwrkee3FE2uLOSDBmjEuzrf8xXqqXclHthdEKwg9yKHdJ7xSPUauWAqMfKVjggNA4vzLgXDEO7aknfzCrekZnVHeE8ij7rZLczCA8Gge3z1gWcMGoHK6Z7lZZYXwbq0GtTulKfMW8PFHkB/TViNCUa42LTfgT7q0vg==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2603.namprd12.prod.outlook.com (2603:10b6:5:49::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Tue, 18 May
 2021 17:40:31 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 17:40:31 +0000
Date:   Tue, 18 May 2021 14:40:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-rdma@vger.kernel.org, Maor Gottlieb <maorg@nvidia.com>,
        Shay Drory <shayd@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-rc 0/5] RDMA fixes
Message-ID: <20210518174030.GA2476957@nvidia.com>
References: <cover.1620711734.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1620711734.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BLAPR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:208:32b::6) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BLAPR03CA0001.namprd03.prod.outlook.com (2603:10b6:208:32b::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Tue, 18 May 2021 17:40:31 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lj3hm-00AOOR-0m; Tue, 18 May 2021 14:40:30 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c99b9d55-8d91-42df-009e-08d91a240863
X-MS-TrafficTypeDiagnostic: DM6PR12MB2603:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB26032CB39463A95BE122F0D6C22C9@DM6PR12MB2603.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ElxF6gvkivB+8fmIyN6itzuu5+B8Cmlrnza3EL7VIoTwWb+zhppkwHKOvDlk9IneUDIxT+z9hYS2nRAoZrCdlP5ZizSy4dieuJpYroDUn9BnTH/xirkUUP6KCyAFiueT/NyHk92GfxmqYHNA/2rzRlxJnrEl3qMN9RA3Xo6Z65TSEpzwxTIXrUSus4qSanzk/geSYUMlApwhYFfYJXT1NiVC6x+h570kEkWa7UaIS1pAdu+hfCgeIW2VwF8IHebzT0olabYoEh+JRNqYTIqIpjPSA2CAj/O4PUW9If4VIpPOLhIgAN0esqRUoGdaORkxA/u/AtmKkG0dbExX7kR4DqkwY9eY1pB3tJsOQF2DryK3zAVKDGnheMIRBT+SvRxulFJv5ScntFuZGDhV8w+xxFbgYcByylVrB7fLRaTfhSEnUjPFORJsOL//10C04Ia9E/NtM9tEwDsUWSypqH5X9HatzAT9nQ16p2RVc/42ngFhZO5dM1Ua3ljNBI+LxNJrUsiHEBWbIN+sc2GzXeJGIxPeCCvzx2dXxvEfmJnlaRjgPtahFyhagO7i/iDbMndYBbuiR9x8EHoJs87AFSfn0hv+J+iESBe3o68kvVouVPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(86362001)(2906002)(8936002)(6916009)(9786002)(83380400001)(38100700002)(4326008)(54906003)(36756003)(5660300002)(4744005)(1076003)(186003)(66476007)(33656002)(8676002)(478600001)(426003)(316002)(26005)(66556008)(2616005)(66946007)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?5VNJwH7GySoqmBF+rsFbCcrWyd9BnHj1oLt5ADJzspQkWGj58HbElBrmlsje?=
 =?us-ascii?Q?KZaiQA9baI6uZ+TtxWvsF7gneWaUnmHWqD1LZReb50gVqad2Z6djlpX0upz5?=
 =?us-ascii?Q?joGMouUsamO9ThvozvNfYG+AjFXHh3Kv6TZQG9EhgANXyK1NLpgX81Rs1KxC?=
 =?us-ascii?Q?vbX/KlaRY99Ctjm+qYn/w5GZqldPEDL+sJiF1bhRNPQM8U0sEMUAOy1yYGgJ?=
 =?us-ascii?Q?2Zn1y3b0Sl2e3NbEcD25Ye2kIAj8pQv2xX5VBvjJjikJga0zYgtb4Y0PuEkb?=
 =?us-ascii?Q?6dn7zoa1ykjB16e98j3INzWhuplQdP1uQCy66qawz+i3ya0cOp6FiHhCaAuE?=
 =?us-ascii?Q?rluFqEulwP0SMrGTcQX/514z1lLDXvWhJrp31P+dALgfdXVyuqrBUyXEVGQP?=
 =?us-ascii?Q?pu7Af4y2+/IlFumk90eLlNvP0EZIVzsvUw8IOdIFowqwr6cjooZYV3Ao+AEK?=
 =?us-ascii?Q?6B0aLd60VebSW0E02FNz93543kFskWyt8K1kKfQgmwlYxqmEXDWI5t9Xy6Mk?=
 =?us-ascii?Q?OKrdMbEdRPQCq5pVkBTs0X9DqfARdnIqKPtwHKEn6aKSEs9GULuJ1CSzrvOV?=
 =?us-ascii?Q?olWJJi14AKYfzoXxKb0tiQEArWYkoEGx5SsN/yhexewrpBlvgPbhTzxa8Ie+?=
 =?us-ascii?Q?upXTCG5hwD1jk/Kd883JxulsdfC2xNpJNugGUY1WEfyb4ub39vWGmghYW64A?=
 =?us-ascii?Q?1AIo94NLVnBQq/Wa6zai8ZLy6MtUFzX3s1bVZjALYi+KGmzKp7rpieqb6Pko?=
 =?us-ascii?Q?kj+LsBAWvAOG0rUAGThLkh8QXigPxQnJCKEzFtn87rCh6ApzffN6ZE0u2LbN?=
 =?us-ascii?Q?/FItU+3NftrQ3h9wnflHRPimtak9m8J5RY8UJnaCEb9RGnr8Vbs6GGYGznsx?=
 =?us-ascii?Q?0VXMb1VNE5jW3lvditXQUzRH7JHwAwjR2j9KjecMiFE4zAELvbqZ33agj5gW?=
 =?us-ascii?Q?thWugi7pf0YwVPD+d41mdEmkqMgX7B0YdMl2Fusy4z34Y+fBb4/VOR/nXdaM?=
 =?us-ascii?Q?Ksf2NlbEOfkYfqq6qSMSjuJWAzP1l9KTG3jXurVrsYmprywAo0YG41XfTbw3?=
 =?us-ascii?Q?zXm+Fso8/x/kBRSHYcvYnv/bTzGu7c71lUsy0RNHBcdG2Y95z/PwRtcloPau?=
 =?us-ascii?Q?bRmXhmEaDj51XJk5CnPziROnOOkk5N/D0mC6qa/+JcjFLE7oOmK0YxtzGzvW?=
 =?us-ascii?Q?bDcBCkiKJLCwOsTwTDgdE4tzHZYOHn+orrh4cpeKL8Kj02Ru7NPtb6U9WwZ2?=
 =?us-ascii?Q?X33i5o3ZzUPmiMF0rZypGtdfiZNqWmbwDL3Q3kUwNnSERS4SPV3xng2oFWCg?=
 =?us-ascii?Q?OZ7KXPJFbsXLYY2yNs5sn0mR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99b9d55-8d91-42df-009e-08d91a240863
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 17:40:31.3125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7PjTAFQ0W78I2DlyHD5WNjFRWolklbMcR6ukLBiinb+2tKqWG7P6ZQRJUGl/edk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2603
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 11, 2021 at 08:48:26AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Batch of completely unrelated fixes.
> 
> Thanks
> 
> Leon Romanovsky (2):
>   RDMA/rxe: Return CQE error if invalid lkey was supplied
> 
> Maor Gottlieb (2):
>   RDMA/mlx5: Verify that DM operation is reasonable
>   RDMA/mlx5: Recover from fatal event in dual port mode
> 
> Shay Drory (1):
>   RDMA/core: Don't access cm_id after its destruction

These applied to for-rc

>   RDMA/core: Simplify addition of restrack object

This one will have to go to -next

Thanks,
Jason
