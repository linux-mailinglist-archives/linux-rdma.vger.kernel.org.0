Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876C53AF556
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jun 2021 20:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhFUSpy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Jun 2021 14:45:54 -0400
Received: from mail-sn1anam02on2087.outbound.protection.outlook.com ([40.107.96.87]:28866
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230160AbhFUSpy (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 21 Jun 2021 14:45:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=br3p19mWKutqGeu1EnqgHBDqeO/5TqAPB2fRePG36GgH3SlWlBey/ddqYBsTYrICCvFnY6upEIvl9MJ0KGlQXjCn4MnrRKZxc8lLNSLtP8uOUaK1XAj6jnnfVwbw8uNCUWgvGCX8q8eMTBzg5ukt4R70h2mPSJDeTt7FM8MVWAGyn+8zXwafEmQWp9ACHjFiO614z19D8rlK4erkUqrHsKMwdWl2CnsNSttnAo0ns78Yl1qrVITvZQg/fHmOCHS94mGzUVwCVHUnECXgUYwQn6cB9clQRNFA+fckZgTu0wrb1NGuVTdxzD23jtqSaHvdgq3U/TFx268sABMXoxsv6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZnptIAdPtjJsGcA5cIRfanLmnf1cOEju2hypOjGhdI=;
 b=E50Eo2drDZd04G0DX6EiJHaey/T/Yu78DEJanERU5pFxCj52n6SAYRw66zBJCqEddIyHerTbqxCnjEd16Y6WqmevY2afSECDwAPxwV44optmWLLy29NM/X76aheoGOt62ud29KmuPBCcQF/XeskjEbjd7r08W1BZo7fSv4NbPBHwZuItUzDjFKv6Lf9safLabCJfV4y1HBfjFKAUqipn6en87oOa2Eu8Kaw7gU4zepj8DGLHmDio/u8vgNLiCK21GhOyGPffFlZIP3eooHTrbU6GXdcHM2rEernSOfRECIaQh8ZUWzPfQ3524cLL1+JziHB3Xd+tGNn80W0PSx3FYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZnptIAdPtjJsGcA5cIRfanLmnf1cOEju2hypOjGhdI=;
 b=fGmW4I7qAOQgEe6lORobBS2Nzfor0ugCxDFgNWItwJP7Mkv8xnbmESUSm8b3SjQ1nGmsmV8QRr3XIjR609oh5kustoyUNMBcE6rNWqywhv5EEn/hEotf5a9ibaUJzQY0BCnaR/KmWONNzK1afzMZrZMK1CMJ/ikT5mRurMBC8PqEk3nF1CTRJY86ydub1PMD1Zg9AIZXn8PM3aiNy6kE5NxRf8xeI9B2V44jwQZV0+qAe8g+WAXSx07FCbfe6b9fYPmcxeihm2NpiurD0VWhC/USUdG4+lJmZwMAy//nb3PcJHIix8HBeuL0QJUS3ADc+F49clvSzjEBH7BXHFMf3g==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 18:43:38 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 18:43:38 +0000
Date:   Mon, 21 Jun 2021 15:43:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/6] RDMA/hns: Use ida to manage index of some
 resources
Message-ID: <20210621184337.GA2345030@nvidia.com>
References: <1623325814-55737-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623325814-55737-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR05CA0033.namprd05.prod.outlook.com
 (2603:10b6:208:c0::46) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR05CA0033.namprd05.prod.outlook.com (2603:10b6:208:c0::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Mon, 21 Jun 2021 18:43:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lvOtV-009q3i-2U; Mon, 21 Jun 2021 15:43:37 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32e263cb-b607-449c-8a93-08d934e47bd2
X-MS-TrafficTypeDiagnostic: BL1PR12MB5032:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5032CACD3ABE0425963437E3C20A9@BL1PR12MB5032.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OPAEk/H045LaENYQel5EmtBLFNHjB1bqxF6eaYYbE+LbXjwxWPNGh9HnJk9Ag27sSKPnn3i+/365/LXgItAAVubMIkp5yvoqe6i1Y4mocvTOEaZhqHsN/taZZYP2p8DhpMvbxtFwQW1+nvQplUQSI7n9ybUy2WqF4J2efB2KuSRekbZNjzOEeUNBqZljw5qEbEyRnj+q8En0r4pfcVKNJd8xFgWXu5JQf/Ab5lkFcS3vpTId8osah4vCbLzSRDOsd3G2ouAtYJMXlKyXSrHgk8Y2sXVF5dupoFKm4zN3rs/+jbL1TIBHGftjPJLY1Q+zPAu1m6KLhkwwhAvF4mRaGO8rsrYFRwYrCs6Enknuf8E+i8HMU5fqxGKTpi1WMuulYt8g9X+hZTh5m7FmvBT5D1J/4wgaffrVLipETDHb2Zjzgse2cvTh+5evVIylU0iJhxd4usrv2rTLu2aDWxbgipVhRo5xg5LAZCnfiU7OfqDYezjEKevGJFk+5vx7Nv/mqLwzA9dh5RO+E9Cf11TNIDvLVsYFQpwuo2Ij6O3Dl3d6H3h6yzXaLXr8uJrPuNqLW6ECLlOTkcafG6nPP99nc9z4nvzJmvZ0QVvXDUdl76k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(426003)(4326008)(9786002)(9746002)(66556008)(66476007)(66946007)(186003)(26005)(6916009)(38100700002)(2616005)(36756003)(478600001)(86362001)(33656002)(5660300002)(1076003)(8676002)(8936002)(2906002)(4744005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gwvMdf7jvRGh8EqoZ7weIeNmo3+ZXoagQdzsXjkLM01vHo/KR1+Q0gtmMLQs?=
 =?us-ascii?Q?rFpsncJYYu8fwkoxb428AhCgt8Lcs3XTZ9or5afNYK2yVisH4Dp9xVscNnQb?=
 =?us-ascii?Q?hKVs+/YkIciyp5H71moToci5WsqSH3RHDe26dTVwFi9JwooQrKXOHFErI6Ux?=
 =?us-ascii?Q?l2tij+6r/ORX+ke+eMzF77Gp5En79we6L8DlCLTeSBNpk0gAuVxSEl8ZIl9t?=
 =?us-ascii?Q?RWEm+D7PYcQss4v6k2lm2eGoMrSjU+Uidl6dBo2R5UH6+zbBgdIvrrMzTPcl?=
 =?us-ascii?Q?phVhaDq3+f13Mwxit++SWZJkbWn5c9QN6yoglMQgY+NAlutuvSH1u0dJ9e6Y?=
 =?us-ascii?Q?GUQ4oQxmQA57B1xJsmLUN8zJs33cHAbjnBNkFjpoN7Rl/0vlcnqoie5YITQJ?=
 =?us-ascii?Q?gOrEkSmkIxJGudlWDF49uCAZXf5tsJmeVY2MezQUbOm6eNkDSZ2gSNimhT/o?=
 =?us-ascii?Q?JRoJn0N5kck9HWKmnIS5tGBb0mp2xlQMhgUPGeJJfvkp+n8jI7+guhMU1f53?=
 =?us-ascii?Q?m25sVwPj3BVkdZSZaqAMfpohJZRQMQygPVkqJmrk4Pbnrsz/2H9+vLaLoTZe?=
 =?us-ascii?Q?gWZCsReap0lq3wTtz46JAAiMqnUax84lVI1PBHjvrCM469D6t2G1twm5ngoM?=
 =?us-ascii?Q?GzTkOOli65pnfl+cnE2BHbZO9ED6NaaND3XI3wallRwPn2qnyk+FIUXQK9/x?=
 =?us-ascii?Q?GewabVO/RVihG3vqQenQZASmCwFo7VdWEFW5D/5451iUCvQLXM0fgc/qKfoR?=
 =?us-ascii?Q?KF40K4now83j2PjGGklWj1GyWxgj6jLad1MNVd2fCkgiMjXZT6XS/0qVELyp?=
 =?us-ascii?Q?PdyvYLjrVfF5idUJ6F3ytCzLB3wNpMjN1v/9EnDXVCgQKEUWC2NQxKu5MrFF?=
 =?us-ascii?Q?zVhIqaEZzXI4lBQo5W684TWmdtmNyGgl/MvhPSGZ2CrAsM+MqxKAUGVTWn83?=
 =?us-ascii?Q?7E+XnEWEATHTEnMP6pbjv/mCfBPZX0R935ZzKilWhuWRMMl/u331YZWHHjDD?=
 =?us-ascii?Q?L8DT8UuYctVHrE9sVnDkRzEnFrwQfC4DZK/qtNXsr7mt/q29t4ZMsM6aTBKt?=
 =?us-ascii?Q?w5ZTplYJghM+N5m8aP5XvFzk2GW1wzximHBgWsQsxe6UYEmUQPx7Rw0AoAW7?=
 =?us-ascii?Q?JoiBTGcyovcoi5rybZOEZhzEDB3zZUTaDmqj3ymTzf2eXupH0IRGp7YqTcSo?=
 =?us-ascii?Q?XYcO9qIMdUAfoeKMYHj2uj3TED3WHaLWOtfPHewPjDGrSURCu3b75nA3dGUx?=
 =?us-ascii?Q?M5PzsVgGm1hWLTXo5tV/O+ONPhZe8gM7VmUxc61q6bvuoNSovCLaL0AgYtwB?=
 =?us-ascii?Q?aoDJZJgmPdQMyW++ToJGAzzZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e263cb-b607-449c-8a93-08d934e47bd2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2021 18:43:38.6041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHdWuiDqx1aIpH4056MwE9Z9gII0lnTpW74Ip2zPebUw3ymUkgjFYb4hkNnBfXkp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5032
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 10, 2021 at 07:50:08PM +0800, Weihang Li wrote:
> Index of some resources is managed by bitmap in driver, we first do some
> cleanups on the bitmap functions, than replace them with ida interfaces.
> 
> Yangyang Li (6):
>   RDMA/hns: Remove the unused hns_roce_bitmap_alloc_range function
>   RDMA/hns: Remove the unused hns_roce_bitmap_free_range function
>   RDMA/hns: Remove unused RR mechanism
>   RDMA/hns: Use IDA interface to manage mtpt index
>   RDMA/hns: Use IDA interface to manage pd index
>   RDMA/hns: Use IDA interface to manage xrcd index

Applied to for-next, thanks

Jason
