Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7283540DC93
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 16:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbhIPOTY (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 10:19:24 -0400
Received: from mail-dm6nam12on2083.outbound.protection.outlook.com ([40.107.243.83]:17270
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235557AbhIPOTY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Sep 2021 10:19:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BmuQjbgPvpnrO23lnNFLWyWcRj7dLJLtAQr1RQbdG6FJpVNjYhk1CskQ9kx+DO5oXsq5GLnQc+bOvX1ZDlvmuyIPIYN99f8n/4ojPVSh+KYiLtZgbKAHbSGTPQMtltSKdYSvnFsRj3ixFxV5CqOcsfrnZpHt2oef/jntiNU96oL+8YNs2GlV6AsVVHF78snnNVRf07WhuQa62+hL3NnN41kg8KfB5Cc/xV57hkyDiBUk5lwqDiu2Ut9A2EApLDKBtcpBSjmw+igdk+cT/H/uQmwrckPDZ6M5hCdacad18yrFoQdVR9gAm9ME6cNq6E6ISzqMHuNGWydCsBo8chL2Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=gEGnLowHY3soqd9DN05geJ9YvqXNyeD/GRiYHUC8fz0=;
 b=INhF04uPHjjYclT2j7vEj9q9VplBZL4DfFrwnp0m5EgYqkuSI5TQnEBfRGVOov1Rk78JYPcq0eXOAGApyYWNsAFNNTF/em5P+txQFnxtbvGXockyUcw9NjOtEJc4AcPEMcHdHfzogb80mEaUmjKUr84vPFL1iXn42fx2l/tian22/YcK41sgT9NKG3gjMAroPw+wSakaP+OU3t4ZpBgUQPm4GyQTX0FrDBsrjBpCvFNoCessWuWPny7yW88NtqJrcYtvDtQR4pVj7oDiaIf65PmKUyhmM+0YYYMAHnu0f0h+rTlu/ucCVO2kU1k/qCTkgQDWZftOJMcx7gApwD3NAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEGnLowHY3soqd9DN05geJ9YvqXNyeD/GRiYHUC8fz0=;
 b=TKd7Y4zH4n9wy3qJmOpgbwt/27lBNcdAnnMCySaB6HCyuTjv5fZvLo3jukfS/hVJLKIqvGvQoOEF/nO8SZ2aTpxSwKOZ9XrR3TvmYjQ4M58qEyhMbH8mplfL2oHK2v1qRDXx/qSjg258pYz26rD3LAJ7aNdxnl2Bsqfnx6tcuD43O4L+JAaHHVszRX5zAldsCbmTNWxK8aMo7noUdANIRPYoD+ktkDs3+4SyFFvW+4zUN3zX0pJiSt1J0nfY8RW2wzIl4+3EW0l+3BG2FGobdavkDO677WsLFgmvN80GsRLX8uj7DiWPYJByyGD6sLIUDxOr/R4xUR787h9PursEYw==
Authentication-Results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5352.namprd12.prod.outlook.com (2603:10b6:208:314::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 14:18:02 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4523.016; Thu, 16 Sep 2021
 14:18:02 +0000
Date:   Thu, 16 Sep 2021 11:17:59 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Mark Zhang <markzhang@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/cma: Split apart the multiple uses of the same list
 heads
Message-ID: <20210916141759.GC327412@nvidia.com>
References: <0-v1-a5ead4a0c19d+c3a-cma_list_head_jgg@nvidia.com>
 <67155640-e38d-ed1a-5af9-693f9c860f21@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67155640-e38d-ed1a-5af9-693f9c860f21@nvidia.com>
X-ClientProxiedBy: YT3PR01CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::10) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YT3PR01CA0043.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:82::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 14:18:01 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mQsD9-001O3E-Rw; Thu, 16 Sep 2021 11:17:59 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 222b8588-b380-44fe-efb1-08d9791ccae8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5352:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB53521CE053D5CED021E0DC0FC2DC9@BL1PR12MB5352.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i4UilSDHnPihGuEvlm2SyMUOy3T+UB4sd08wmmbbx0KkYKh849UwDQEYTxUgOUZJeyXcoc2KWlr9ecb1YEcQ7GKprmolx9Dq5ZDiEf1xCSsfxdS6guAUMM76XvkYVelASUBGtArg0Obd13Re03fAR/TdvOxLWd5OUKpiowrdkjpU+HrA62ADwZWVvYq5giI/ygb1u9aDCcZL+Ls8dHgLo9Xy/+rQJEf11nlspK0m3hS3Ue4kamko58LXZKTTBXb6ZhJBTV4qUAlHUCZnpLSWqEwb7lwnotUKKr7huGRXBxjXt3tEqvhxeXx/qzUQfCN+nUHPmEdX+2ZVr7XndX/oSiHAEWKWSLwpwM/AilV/C8CqSPry4/xY4lzTa8iHqGnSjegplTV8k+y4W4+866wwu1YnGqbIlT1qFBiv4BxpuegW9nUTTv/AUaFckvyIXs3eU2JozNtq+cA3jqQrNJye/lK6vnwsNteigIMnkGQvGw//mrsmAjzIU+e5d7ABLzpAVZbw24a2lYxCVk2rPfGhogz+uPbxE00AFENLEJjx6R9fJKdFDao9z0d551zEzI3kJjS2xFrumK2fKKrwsm8w+tqz7sM3UzdJ7ylrjFsAdoCGJ64YRLV8ufdgJHlaJmPvlVjFWA63dhPnxcIujUHyGAGXpCGXRXrQNUv6gYKxJLrO3riYJBRaUNSmyzstTVWS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(316002)(6862004)(37006003)(6636002)(36756003)(83380400001)(1076003)(86362001)(5660300002)(478600001)(66476007)(4744005)(66946007)(66556008)(8676002)(2616005)(26005)(33656002)(186003)(426003)(38100700002)(8936002)(9786002)(9746002)(4326008)(2906002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9A6NtbFFFsDSyPjjytqrbsjqRyATEQeyJJFrVf0QJ9TxOS6PCPi/G5M5hfqg?=
 =?us-ascii?Q?8iuTC8uSlUGTIr515OLNj5ma92/MHeGZ5S7kF2MAwZ/xNfff4dphysWUDciA?=
 =?us-ascii?Q?ZodNKogSEvZe+zmXCVPFabZpVnrq5PtIbxL79/4fX8yMApXHa6WmzME8lIoP?=
 =?us-ascii?Q?u8/WUPzBYefYsaO7IJFyGx+MwD60ebRRjkqohzwtsg5gZW8b4jnAyUTStFox?=
 =?us-ascii?Q?ZvnD/OEQSoMN8t3SISLx6jdTTIlgamvEzbAiSdAfTRmm4xB5mEX5TbI4sIo9?=
 =?us-ascii?Q?7BOA0xv+8fzYU+rc3jj139eIefGwpKqYHXbXXUXqJaqPr/ksv+Ql3owD7vEB?=
 =?us-ascii?Q?mHmGNshv0WuIzwzenG1RiP2kzIMbr2I4eBGHvbNoxGSQw3Oil5f4qYvRS1Nw?=
 =?us-ascii?Q?pyMiiN9CvwccLSgNHr5X4Yy/prfAZcdgU+Ef3+gBUeqSrpSMeFTmKExHtYm5?=
 =?us-ascii?Q?20AwE8loV8Ebk0b/UFnMLVpjp9Y+H8gmoTCigENVyGcImPGmPAyNgLNiwRCb?=
 =?us-ascii?Q?o2vabMmEceJicZww5mgutKm/qtuuzO38yJIhD2DQfSAyd4De3C7fimP5pDE0?=
 =?us-ascii?Q?stG12bLRqMLghfHS32Z7KY6HTHqA9ARHZIUgwu4l8B7vCHQ3i8QW0YFxZpwz?=
 =?us-ascii?Q?qJUMuJVTA+91A4yin1nVSp9Gqrx18rxX/qXHSFNsbvhDxx24o3/muL/oNl/c?=
 =?us-ascii?Q?bhF+sGNFAo9RP3fRr/fsu+/HRzfdRfV9+TnjnYUPHCggLO4rkhEZGga52ZM3?=
 =?us-ascii?Q?XeZILogJpvauBBTRnzuPIqZ+bjwEEvVRjr9Lmf1on12E0uKl241d/4ijLYim?=
 =?us-ascii?Q?Y3XBDmYoSq0nevcKcCG4GT6agLdpJ50aOD5hW+q1PjFYngM7fQS9g2YYsgst?=
 =?us-ascii?Q?UU6rt5Mk+lhjRxLI1BOMrwwSSD+sChHjl1BwU0QNfCaAw6BEwQs8/+voFCwo?=
 =?us-ascii?Q?m47ZNk0rN9S4UNo/HthlmGzVBHQDcVtKkghIzc9w7d6erg3y/V2z6hnWWZZ9?=
 =?us-ascii?Q?NZDNsdX8SojHwEYm7wEjjmm8rzEmBhzpCgfpmpfMbH9L1MMdwrdgVsTDDLGJ?=
 =?us-ascii?Q?kOKgzZ8DFV9CgWfvsmqZj/WWlb4DNMDETKIXJW9e1E+eHkl5+R6SR05oXXvt?=
 =?us-ascii?Q?L7gwEONGov/PTX9q2mhPl1jdU7SzkSWeAyH7iLnjxsTrbNxFlIGZGHH4jHgY?=
 =?us-ascii?Q?IZpwgFlVrpgQ2UTXA3zX667EACedsDRcg4GEUsI8yw96f5kGFvJuyppSMCwI?=
 =?us-ascii?Q?8iJkuDgaY2O+bpIXpJAXNKZZo26V5UQhrtyFbj6LZ6fhJAwKkhjADUOY8Qr/?=
 =?us-ascii?Q?xPMHZoVAG0/0hl6jScjXHhAA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 222b8588-b380-44fe-efb1-08d9791ccae8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 14:18:02.1646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/fFOoD2fi2vIdYYQ/dq9D3jjsI/os51E3Fvc/LECOFK44XC6vwttHyii+mpAg6G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5352
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 16, 2021 at 01:11:14PM +0800, Mark Zhang wrote:
> > @@ -4928,10 +4930,10 @@ static void cma_process_remove(struct cma_device *cma_dev)
> >          mutex_lock(&lock);
> >          while (!list_empty(&cma_dev->id_list)) {
> >                  struct rdma_id_private *id_priv = list_first_entry(
> > -                       &cma_dev->id_list, struct rdma_id_private, list);
> > +                       &cma_dev->id_list, struct rdma_id_private, device_item);
> > 
> > -               list_del(&id_priv->listen_list);
> > -               list_del_init(&id_priv->list);
> > +               list_del_init(&id_priv->listen_item);
> 
> Should it still be
>     list_del(&id_priv->listen_list);
> as it isn't dev_id_priv?

Yes, probably should stay here, but it isn't entirely sane

The next code block must trigger the list_del or the
wait_for_completion() below will block forever.

The whole RDMA_CM_EVENT_DEVICE_REMOVAL bit is kind of insane and needs
some cleaning. For instance I think it is a bug if any ULP doesn't
return 1 from the event.

Jason
