Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59060398D58
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Jun 2021 16:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhFBOqR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Jun 2021 10:46:17 -0400
Received: from mail-bn7nam10on2049.outbound.protection.outlook.com ([40.107.92.49]:4704
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230031AbhFBOqQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Jun 2021 10:46:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTFa7ySskn5h67kGJrB7RgUC2XRj610zjhghvyO/SgYxgFksj1LWmoBGdIhOi6zTLYjpQrgJUZhqgmRLVzZY+1E2vi3W0DCEUbin9NwE15d2YO9pRRQ+MfvQHoD8diHK8IJbbdUDPHQMBxb5nu9G5YWOwG16HeiUTcidHUZBuExAHf31fjIy4UYVpvnoTRLt9vRxMuMrxHMjDmpgKc0kA8zaTcYEc6jX6rXdYih4i07wcTq3kjzC95cRmLB31kA6oDXUx1SjL1KNoqztNBjEgXfgt+UsTFoGWzx9jIpE8NNxvQeVgfdtl0tZhdg4K9JQAmBorZX43FXJ50i52xPxCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIG85p0YASTuBnw3P1ceSQ+pqHvEDpjgV4MVrG7/WYY=;
 b=WelTq6lrzsDlH9OAcE5JwZ20ZOan24dASvA4aqklYlZ98uSGAkPQAJyLezvwGNzGEIGWipTo/jg9GBIq4+JkW1nIaQyhYMYmpsgDHMJR18pHFxcdV0PNisoAK8cPSZbRVkkT1EVfn6qmsZ1lpMQLKVGpXiNyab7gLn8dToRPvJOL9x/OE2xT+munbnA4BHgYh0mG3mjSOYEqDlQxyQFsgRmooDCFE0jXVWNRNzmqmBXWhNL6VgnSsbCtnC1ZSHaLY8q/v4H9FTuDZirgDroDFwfG0jj9yNxTZ/FAr0ECNE97lRBnSHui0SGj9SOLzXY3MVrU0WDSW3sEVFNQWiIhiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIG85p0YASTuBnw3P1ceSQ+pqHvEDpjgV4MVrG7/WYY=;
 b=NLdajvUSAusydwyzMFNhgjNm2ndQ8nk8REO3bGkL5IfInsc420McoZCLn2UJJ4aQ5YYMCgFdb1Zdxnmqcz5rfgUE6Hjzn8kgWtx42usTF1X3bCO2SuJQPYY/kAUu2QfuJjLDnabLxVCNMmXXScBLGfMGwb0s4K5HA1Q+shOkFzuQOvmx2U3OiSmOrgA054ZtR6o6aBWmuPZnSon980S+ex4+S6aYenLhhGuW4O4wFA3WIl+pGHjFUZ8gfkPDSuFxf6ywRTLyUeER/1+rCDzHTxjVJsCrYff/H2AOrse7VCLRBcZJMM76Mmf+Xk5g7fOfGKxa6wQatnM8kmoLCn+/oQ==
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.21; Wed, 2 Jun
 2021 14:44:32 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%6]) with mapi id 15.20.4195.020; Wed, 2 Jun 2021
 14:44:32 +0000
Date:   Wed, 2 Jun 2021 11:44:31 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH for-next V3 1/3] RDMA/bnxt_re: Enable global atomic ops
 if platform supports
Message-ID: <20210602144431.GU1002214@nvidia.com>
References: <20210526153629.872796-1-devesh.sharma@broadcom.com>
 <20210526153629.872796-2-devesh.sharma@broadcom.com>
 <20210601144643.GA4168406@nvidia.com>
 <CANjDDBi12tnQNadTd+OXegVCVj7a1E0SO03gwEG7ycKq+_=9pg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANjDDBi12tnQNadTd+OXegVCVj7a1E0SO03gwEG7ycKq+_=9pg@mail.gmail.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR20CA0009.namprd20.prod.outlook.com
 (2603:10b6:208:e8::22) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR20CA0009.namprd20.prod.outlook.com (2603:10b6:208:e8::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend Transport; Wed, 2 Jun 2021 14:44:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1loS6h-000G9g-GG; Wed, 02 Jun 2021 11:44:31 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6e24df7-eb5f-4f0c-3069-08d925d4eefa
X-MS-TrafficTypeDiagnostic: BL1PR12MB5160:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51602D5DDE13CF797AFE16A3C23D9@BL1PR12MB5160.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8bLyk6W6n3r2aiAJ9L9jf0gfbkZiHjzSOqPz+mgsb8XX7KZKoBJoYxWEj7q3L1KAvDK1IfzxBBl1Iu52Khw5q9upx/jTog39/7pHmdR2l2ClP8zjIZPJV/2nKuqfFUOCX6gukY/p6eGmmApwlTYdB5GezDwDHMSFPi0gSe1Et6vWOjsx7mHeq6HK2Y8twPlL3WoF2ZG7jAKIs5TeJglST3N74yY7p9vwGatpg5gkJ8sbz0kQHPSfuP62i3Hn15gzWmhYrIVudUBxpAifHFrpiPlkjIyns7Ckej+6f/qFnutnQZtFfD3lY873Knu1WEbrY+ub77/SOkVvQA8ZWJUhMyjiU3D5D/DaFs95W6uTmGvlwQcq8y8RPJFPwiSC8FgPJJvsO9Y7JrSCuoBncHm60BwSfhI0pMTXKI0d3oiEXr8fxWcua9r14sDsTzTz+E8nNF3oKZkf8aDzFbmcisuT+4LoA5bHy7ejHYQIZiigpyOIu6CrhruajwhvorASeAiSCDbaaPa9Zk7L4qSlvCFNxQ4V9FIOHDvqSzhx7cJLsgZH9ErpvMCLiEVK9irsQ8FZShWoFyyi3cQ7EjDvLbbB72+k080dc334YEtOuw1lm4g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(4326008)(9746002)(5660300002)(9786002)(1076003)(8936002)(38100700002)(6916009)(36756003)(8676002)(86362001)(33656002)(478600001)(66476007)(66556008)(186003)(2616005)(26005)(53546011)(2906002)(83380400001)(316002)(66946007)(426003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?c6RlLUqiJ9ZQHgRb7Qsvsasllb6Hwzsush2TDag/fx9e0mFb93y7s0ILJVcX?=
 =?us-ascii?Q?O9vj77RvaPPYmeBGPojNm+c20Q6EOWrXohC7Lb97usWzQ3znNQWFfJ1YqBJ+?=
 =?us-ascii?Q?mjsPe/ml5iRk4i0FsBGj9uf8/W6965/x/oSpXKtVTzVK+h5nQZPN+Cqari5l?=
 =?us-ascii?Q?zLcrZjZiSoQGXCWmK4pl4hU7hDB9jjs3rVbrsE7DqRvaxqi3xwO8b/g2+y+a?=
 =?us-ascii?Q?PPeooL4Rpdhc1giN3BKGFb6Itt09pkb02uK3vhVcmZt1i8K7SuGGsm9tr9xJ?=
 =?us-ascii?Q?dr/Cc2P7CmnJFD5HmbQIM31Q2zPf9w2fUhVfCcDWJHy6zaohv6cuRf5/FPUf?=
 =?us-ascii?Q?f7UY0bKbNpme0DqJy33DLJ+OX+7adZYokxN+eS8txWR5kCOEunwylFmQ1x5k?=
 =?us-ascii?Q?5LgoEUSZf24R3r86cXYFIvp6LR5H6gh0rufLXRjG3QswhvJlmfePwC87uSgQ?=
 =?us-ascii?Q?aw6bs/eiwyVn6T4JdGiKhK93DdCazvkxLnz4J8eCYIYsFsvfaq0HGm0GzYWA?=
 =?us-ascii?Q?D4OSUPswg1ASiezfOCvMmDZ0iIBwhUU2v8COyIOBUm/SGhuxWb2toY90kiAN?=
 =?us-ascii?Q?h+CSw9puJqIsnOnEd8ft1vEwQl6B/W6QfTifgIAuq4mZ3C0KY2HTGlBuO/oO?=
 =?us-ascii?Q?k0PWQddpoPFvEw43Cdc3t24BDUIWCQYIXp3rTsj6HmX1IIC6tdvjDw1hDnnY?=
 =?us-ascii?Q?t8p6UdCP7rAsWPtnO4XxDsuomveEBdA5zHxOhtDFghs2ln9XcCDpApeoGDDm?=
 =?us-ascii?Q?FXeV5Izf12Xi1WA0Ik20iqKatKzFfqIAffyLGa9SeTCSB5IUA1ztOTkwkbHB?=
 =?us-ascii?Q?jhJmx+j8vBXIAxEd9OFx+CQdbMCuLSHOFhhfyOrLf+oM2AjzZSRnFxXZqvUi?=
 =?us-ascii?Q?thQYAZWmDZhGqrKW4R9rN8LbA5A6a0A5XUa4v5D/vvM/fez9SRClx5WvhTHj?=
 =?us-ascii?Q?leoojkibJiuchvlSP49drtx4eZrkPrbxy+0acL2PY/IKVP5P0q26DXxIR3od?=
 =?us-ascii?Q?QnHfz5069DSoDUxtrnnXwWC21BKc7BfFOEgjqUDlNeZzgiLXatGtxEP6FoKT?=
 =?us-ascii?Q?OG+B10M6xuCufiVnDaLZuwfXwFtPJlYQjuHKGfOOlKX+QcLkz5a8j3iKcuqX?=
 =?us-ascii?Q?x6QfBafAYaCerDNRM7x/Y5mwpERTn+fS/tQlSmUyjncM6dedaTaAJsPlormV?=
 =?us-ascii?Q?wZWMYue9VoTkpnuxQke/CRE7XZjtncDh4Y9qITTZfhmWfTmuwkOcFXJ+o/5i?=
 =?us-ascii?Q?6qhNLAaHWtZjPH3GuZm+PQnte6C2Y/qtoDo005ItkHB4pinA0aZFSG9rmXrH?=
 =?us-ascii?Q?93VR7GrCHq2qyfMa1hXDsOVb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e24df7-eb5f-4f0c-3069-08d925d4eefa
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 14:44:32.3668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcThF/lncbfhVud7M1HB2zfWp8jAxewb/Ob4ED9dKUH4mJHeQjjX8+klA01hliML
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 02, 2021 at 09:13:43AM +0530, Devesh Sharma wrote:
> On Tue, Jun 1, 2021 at 8:16 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Wed, May 26, 2021 at 09:06:27PM +0530, Devesh Sharma wrote:
> > > +bool bnxt_qplib_determine_atomics(struct pci_dev *dev)
> > > +{
> > > +     u16 ctl2;
> > > +
> > > +     if(pci_enable_atomic_ops_to_root(dev, PCI_EXP_DEVCAP2_ATOMIC_COMP32) &&
> > > +        pci_enable_atomic_ops_to_root(dev, PCI_EXP_DEVCAP2_ATOMIC_COMP64))
> > > +             return true; /* Failure */
> > > +     pcie_capability_read_word(dev, PCI_EXP_DEVCTL2, &ctl2);
> > > +     if (ctl2 & PCI_EXP_DEVCTL2_ATOMIC_REQ)
> > > +             return 0; /* Success */
> > > +     pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
> > > +                              PCI_EXP_DEVCTL2_ATOMIC_REQ);
> > > +     return 0; /* Success */
> > > +}
> >
> > true on failure, 0 on success and the error code is thrown away??
> > Please return -ENOTSUPP or something on error
> make sense.

I just noticed another mixing of types with return bool/return 0 in
the same function, please check them all

Jason


