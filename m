Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6BB4394918
	for <lists+linux-rdma@lfdr.de>; Sat, 29 May 2021 01:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhE1XVq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 May 2021 19:21:46 -0400
Received: from mail-co1nam11on2075.outbound.protection.outlook.com ([40.107.220.75]:37216
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229500AbhE1XVq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 May 2021 19:21:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2wg8/MQV1LWhCYsfY5TfIPHGZ3Jkxkn43QA1OaDaOjcRiwrQwge4T62sUNZJ2v6frUZuyjyqW7wKFPEUg5kFZmti7LkuQaedTIg3LMj0nOtUOBu36yGHrIawAlbw3Ml654FlxhxtifjnKv9KZxgXV28SpPoq5mBDkY7DtAYLjGg6z7xv57Yf5vh3z6W9RREgcTQFyw6Qk5WZcPhNIUbTjokEJkbNnbilS4yltm7VTUzn/H4tz7ZpPGVpsstPZKs2aKtoQQRxn4yOLt/jTd/b1S5frTeF/z9Y0s75lNU+XMtlvmuAw2xkDCnTOtPUXoRYOFjyak+Tp8tIvMW8Zq+BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhCPtFyXdhXCRdPQgLiPDAvFrtxCKHxG1W+f6HeQax0=;
 b=WutdVC7gJO6W8/V0yoUI0nGeDNJKnIGIrQHfj3/acUlv0knVe7khIY+IwBwS+yX3mS/IrH2YzTRWOdjsl7dnI35BUWJDutL6uRrXGhaCpoB7BsEaVpzkI+trGRvJ98Vahmroj3taiU1AwQVrdZsHqp/FLbUnuOdKMn6F4pPhaBAEy9T+vDWSUs+tl3alAJSJoLdXIU1zAmHzJIco8q5BmJAsrLIMVt2zz6fZOUSrnwGNqTV1laDeYhl53SCMaZETswiaVdPMUBjnF6t4Z/b5DbXKAVtrlw1Vok9lPBk9ATCmt449zQaADi5rFRcsGkHbIvFkity7DvHuIBDlfMzfew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhCPtFyXdhXCRdPQgLiPDAvFrtxCKHxG1W+f6HeQax0=;
 b=UbWwceaWZh+j9kbSl105a57FUl6C+xvTagTu5mWaDJkst1YcmUE3+irqOVlZ982A1X8ydI/1GPWYYwEK3bJgBYOW7TF0px3pChMxHI+vteUmqKFv5qInNdDn85iod08lIri2wlM+qj1MoXbzR4PysaI4MRQrIDJ5vpfcjVfLisq5xJCn8aZIbDfKO/5UrHHkXoh5s2YUVIj+plzJ18eP0jk9jAST9i1vwbhTFcFMa3aQBE5vgFm/J1ld5qnnkZqIvPHpK9VPtAgopvS3qPSMgmcxVyDbd2AfgXmhcBN0epg+EavxqMzZb5OaO/iy9trX+NGDAVMLty48enOmbIFwuA==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5538.namprd12.prod.outlook.com (2603:10b6:208:1c9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 23:20:07 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4173.023; Fri, 28 May 2021
 23:20:07 +0000
Date:   Fri, 28 May 2021 20:20:06 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next 0/5] RDMA/hns: Changes about memory allocation
 and configuration
Message-ID: <20210528232006.GA3852300@nvidia.com>
References: <1621589395-2435-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621589395-2435-1-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR19CA0049.namprd19.prod.outlook.com
 (2603:10b6:208:19b::26) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR19CA0049.namprd19.prod.outlook.com (2603:10b6:208:19b::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 23:20:07 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lmllu-00GAAk-Kz; Fri, 28 May 2021 20:20:06 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 250fe793-fbd1-4393-1c4f-08d9222f21cc
X-MS-TrafficTypeDiagnostic: BL0PR12MB5538:
X-Microsoft-Antispam-PRVS: <BL0PR12MB5538923B2E98DE4071DBE5F6C2229@BL0PR12MB5538.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5dfJf7Ojob7/TclkwahXkKIPFsNG2i6ZX0HidB06IjqXh+Q3LQ/RmBpuYClGvXd9YRMcRTUQ5VggucA9rSuERSSSBxEe6VXDM47CDtaB03ECo2wBGGDWM3rtu1j1a1h6rUZejAbO/wU53k9ehWCK8GxL8SN44FlOINY8aoXHWabJJhDvodd8FGqu+y7Z6jGaJRLuJHADZf+ZOX+Hfwb1RFVUclMveAj4vXASdEEAuPXA9QjVnS4dqDVPYl9k1Mjf7LZxFmB5AVHxVsuGEVRemsgXCH2iJ4s8GvJE16pJXszFiY/4UNRLQB6QsC3aHWs3kAqR/BsdAG67QJlwNGKLleJK5IEafCvuUoVsIQyL8hgZlZZar6uKnsVLDSt61YRWbqBuXB/bPQMC92+TaAVKDftRWOHeenCUoFDB8G1V3galmD8lIouGPfcnjtFcoR5rrMXPmKXQC6LunpcpoFeqz80eSLdmOhQdkfoUs6RJKeKp+j9eOapW22pnGTAuMU1QngSkNAjSuvClKHvNndKIg8Dl6q/c/9jYQrHy2xUcQ+7D5v2a/sor7LZK046nuVF0yhyBJkvkv/uujbhGuAfXx5rJs9dPvzcx7JJmLdr09kk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(346002)(376002)(136003)(396003)(316002)(426003)(186003)(8936002)(2616005)(9746002)(8676002)(2906002)(1076003)(4326008)(9786002)(478600001)(6916009)(33656002)(26005)(38100700002)(66476007)(36756003)(4744005)(86362001)(66556008)(5660300002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?huYxGmzrKhDhQn8xZO8kobsh80BVPHNA1m3drSDv0XV2yrue5x2A5K12EfCE?=
 =?us-ascii?Q?sDQSkyBhont8Gwnh5tEI3fn2okoWFqaGjMDeLcq+kZCiqFLk0mWi40bawDDV?=
 =?us-ascii?Q?FzCcDQdg/lIcewM0G5H4WT8XHWF+47iM1X4erBnHDzEc5PgvTJtfxbAZzQh0?=
 =?us-ascii?Q?qGyV0MYh+j+pWSgPFxemvB4xzxZ9YRkNaHSfe2hQvR0C67YRC4R1Aa1hdN4W?=
 =?us-ascii?Q?cRo2FYIX00A3iOHn/Vj6P3G4L66sijET6eJclVsmFr7PwmY5JhjNCp85jf4+?=
 =?us-ascii?Q?9JFx0/oqHm6yYyCl/YgqpjKLT0Q1m4ZpSjTkae/0fj6KH6PGLQptgouOnRum?=
 =?us-ascii?Q?etpsCiZn6vw1BRiC0p6j9bNkTeYqKGPXQXL5lzy5X0n1adfBspoet93aKv35?=
 =?us-ascii?Q?0ENVGuwOmJcPrGRfFE+5tDybOi+Fr7PObzt8fekOtP3WH19D8hThwDOP3kpP?=
 =?us-ascii?Q?zWSDO5G33oSIkWom4KZbyindskbFhl8PEj+a1KthmaFH3VyYR9Za+IAlcgpD?=
 =?us-ascii?Q?eMnr0np2rFLpqYlZHxFrU6RUXRkdLPjz/eZ5JIi0Gh2FDPww3AQADe5Dsbpv?=
 =?us-ascii?Q?XHA2nOolmIpvJ5vrM7lb5GZHTfnEzUfxG9FV+Huu1ats2C4BxFewp3qg4U2F?=
 =?us-ascii?Q?ENRNyT9H8sB7QerAfCf6yjSCchDYn+3SeJ5sQBlnrHb9tTfhkANdb9e7QUHB?=
 =?us-ascii?Q?ytl0uS/HsSPm8EFn1qK1oQRJcNBgR2Qi0lISRVLHMmd46qrDu41ixQQbqG8x?=
 =?us-ascii?Q?HpcJk7vrJKp1gMnz606ckWVE0eEOnWlgvxQ4JXLpREaxodseESkBPvmqtFJR?=
 =?us-ascii?Q?lqiRuX5fhxP7ctui/qzSx5FTTlP8ddZTfCxvTtHZASbQOPATaaQoFbGF0d19?=
 =?us-ascii?Q?1gUA2DP8dXLekP4pGAZ4+Y19Xk5AIg6mpJyp8FSjrdv1oYuw7tOU3UW/1NA2?=
 =?us-ascii?Q?fVeZR6WXwmHXwVqOZAjH5ccPhgf/8U18g0ng4U7CQiRmGDTMIBAJ3VB7Kmdq?=
 =?us-ascii?Q?FtyrUc+e3CAXXjdx0WDbWUV+jXminF2Nu5jWPjv6t9zToYqH/JM/HMi3IxEJ?=
 =?us-ascii?Q?yy2TGXUhzhbcPjfzXmTYlzcX03T6p+QGxahg5gRsKvLT3wJSflI5dy+CbnkH?=
 =?us-ascii?Q?Wu3tJFbxpoL8P00sZ2xZmsyAlpoNlaRynIiJ4zTm3XBoFmjJHoNPFLpWOXeQ?=
 =?us-ascii?Q?RB5mRY6wr1EA1hJEtXUr7MRZKe7X4JeoiK/OVSTRmJqGa0wx5IllgxVSYBfE?=
 =?us-ascii?Q?5U0XfKK4+0x70tZr8IwxA2HDI+cmlpufQOOIaU3edWOx4v9cemeL415yjHMJ?=
 =?us-ascii?Q?tXhiPqGG10ZOZq1sHRNEGcln?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 250fe793-fbd1-4393-1c4f-08d9222f21cc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 23:20:07.6971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHMM+9Lw9ZJbSlBmoMInsWlcGI72CP7z/S+Utz6xuUewJGvzs0BpKUxK2pycD6Pz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5538
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 21, 2021 at 05:29:50PM +0800, Weihang Li wrote:
> These series includes several cleanups and fixes for HEM and MTR.
> 
> Weihang Li (1):
>   RDMA/hns: Use refcount_t APIs for HEM
> 
> Xi Wang (4):
>   RDMA/hns: Optimize the base address table config for MTR
>   RDMA/hns: Refactor root BT allocation for MTR
>   RDMA/hns: Fix wrong timer context buffer page size
>   RDMA/hns: Clean the hardware related code for HEM

Applied to for-next, thanks

Jason
