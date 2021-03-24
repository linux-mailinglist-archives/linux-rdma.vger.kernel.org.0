Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD28C347F97
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Mar 2021 18:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbhCXRgN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 24 Mar 2021 13:36:13 -0400
Received: from mail-bn8nam12on2068.outbound.protection.outlook.com ([40.107.237.68]:53700
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237491AbhCXRgB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 24 Mar 2021 13:36:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9Zt+KmIr212tbMlOjlnrFRWwqeXcr4/C/zDr6pqElWhR+nBL2iP+/TPKvFeULL1AmCYF+B3NuUx+5cNR7ugOMzOmGorRNQRNEJtB7CYeegutBYAclRc3jrm1u/xelpK/eHr/7jVk+NCyb4AxzgMQGfY3O9qLSmAI8PrdcXaIyQtZyyy3W4KWFdwxbehYGZvJ8sqEX3lORHUPFWIFiUi0GWENVvvZ60RcB0TOa9y+NKqYdAxT/soS8b5VMTmO3Hy4Qv2oTBba9BbzuSWwtDD+BDUBR5+c0AtXNJZ631+mMuboyI0mdZt58AmEDKrHXG5YVZ8jn/HqJoDx2zUcxXxfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k47dZRx076N5oFS/a+KfbKUBQdJ3qmtQ8nd1koOl4BQ=;
 b=ZUxzCCTlnK3EGoJaNlzwHFIKXtNlzlMz6ymerPtn3ow0JZFzlT0Vd5jAmLg8jW1mw462QzM9JIaYwr/RkcxhkF6YzsJoX4slIonqKfH/i6ZdQn1mK8SRGE3PekzjUoRzODXG4GwK8sHnZzNHjyp7sWn4owYT3u/9GxWv32wBNLnOEW/SDJLyVIqg0WZRyxohlbBRO1dMxXKyVZ9j3ip4YEbgJ6iP7WZdyIrh3s6R+FJw87qBsCRMg9jJmmylc1TMy3vly5qhjogdDN2zQ9AbE42bUq94Ur1BNHeumjhhsd4UcdrDNpJP785jisxyl3r/HbuCOFyiQIJ+LCYXorHdBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k47dZRx076N5oFS/a+KfbKUBQdJ3qmtQ8nd1koOl4BQ=;
 b=dGkLEA0wq5E/ZY703C2oq1BqQFzjgjUb2CCblVERGb7U4r4sTRJekVQFf8d9BzgnPD6lIrcnOCfAcSIuxe93Ye1O60MbCU9XTZyHj6rlHSRqZmqxovNSFh+AStOn2zoTHcq/GTuxrV3/wDnSfeOsyJTbZkbYQdTu8upZdraAuHuz4uqJL+TSDwuVS7v27mDqYnkZMU+A7ZSZGU4QModONIyJKeS7V5HxLvJUuJq0SgU12goI4pdswkWAxurfSPdVD+ZdKc65WkjCEq7xjePreHbez/kkoQCDju3I0cTE+d2yPIJTMWw2zFXcIIDqgQRtsJexHPAh/u5VRmZNgD5ojQ==
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1339.namprd12.prod.outlook.com (2603:10b6:3:70::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Wed, 24 Mar
 2021 17:35:59 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 17:35:59 +0000
Date:   Wed, 24 Mar 2021 14:35:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Subject: Re: [PATCH rdma-next] bnxt_re: Rely on Kconfig to keep module
 dependency
Message-ID: <20210324173556.GO2356281@nvidia.com>
References: <20210324142524.1135319-1-leon@kernel.org>
 <20210324150759.GH2356281@nvidia.com>
 <YFtXw+w7MZFynam0@unreal>
 <CANjDDBjKbDkbwnWV=kk8m2J_NdwjOir0Uoj2xahwEMVDfu-5CQ@mail.gmail.com>
 <20210324165648.GL2356281@nvidia.com>
 <CANjDDBh_H1jqQxBJFgu-uO2AmWe4-3Qiuos93vxMPxHOx8md+w@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANjDDBh_H1jqQxBJFgu-uO2AmWe4-3Qiuos93vxMPxHOx8md+w@mail.gmail.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YTOPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTOPR0101CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Wed, 24 Mar 2021 17:35:58 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lP7QC-0025xG-RX; Wed, 24 Mar 2021 14:35:56 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b532590-f5f8-4f26-0310-08d8eeeb494f
X-MS-TrafficTypeDiagnostic: DM5PR12MB1339:
X-Microsoft-Antispam-PRVS: <DM5PR12MB13398D9FF0FEA18C39BC8B9FC2639@DM5PR12MB1339.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oAnfcFIbt85kx1DuHSxmHe1TNPdQf+r7RFbGwz2WHyOs0+RJXfNHHsuy/MlxCD4qjDJQMYezvuZlNm7PZ6qu9bI6FtoPG5N6r3KTriQdWBlQrGEdznGCwvfzsbEsjFBN2EyypgYOVuXR5DH4U9+vc0pil4Us+X5r0u67zTYg1gFo0HAqYjTCqqnD1RhmPylIUFnxCtJcGBlX5wIPzRNNgj6TztDjLXmYTrMlGBhfLBrhD9zFEJHbF0xoBPKzP5eJzaremwio0dh7LMlE5ZUgdwEEj5VOO2G0r60k64asVSUrTzsv2If20GhUU/SNJG9S74k1hoR1FZCQj25TIvlUtuzDSDkv0O82lcMU8wSimB9NlGNcc99EIeZxBZ8/SQWERUH5tFaX3El7+MOOC0ObH9TaV5xTDnZ4XdYkIJ+3aQPj7DpioPJPbPAy7hTmEbIS6qITXrrh8R9CG8LdSHBr3VcHNkaBTioZsYajHNc6xtlJHjzNWrsReRMO7tS3FPr28uCnSEpBLVZPOqdcy2quo6hUtfksP/RnAh112px3+WwyFmLObC7npSF2gaF0HSC/U7U7PY8TeJu47rxKSeeysJRIqPZtRLSF/L30fbYFdsxIf3GY/wZF2LyhQRaA+qEwNjpBfzUZWECmPpiTSIHqp/Y8by4nT/aSmYqXK1fXF1M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(426003)(66946007)(26005)(38100700001)(4326008)(186003)(1076003)(2616005)(83380400001)(86362001)(53546011)(2906002)(66556008)(8936002)(36756003)(66476007)(9746002)(316002)(9786002)(8676002)(54906003)(5660300002)(33656002)(6916009)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gIGADlaeyIgYmq0xAZcUMMMD7haqgx/3FthdE8iRMuSBeyulAeitnTDIPRQk?=
 =?us-ascii?Q?IIsHwdG68s7TsroCl5hCpBtnQuDxrVPIGssPKNM5e6m6BhW0hd8oYTMg1P70?=
 =?us-ascii?Q?ZLBxxYCBnie/LOBKQiVQdXZVh+xeDHjlyCVJ8pBEcqxVJzDB5jHCTrlNEnNC?=
 =?us-ascii?Q?Z61oKT2/ud9LYtLmANkQTWzBMXsjtED76Xor+kcU0E9WFNfAHSsWq7igPZYx?=
 =?us-ascii?Q?NSI+RFJEI+IrfIROjGFxI9SFmoYlXcFqfA3DiEhjB25n+IcFy0H8JghizY3A?=
 =?us-ascii?Q?2V0xQVZs0l0LK8gDx3+wtFTUut13wiCVmh2xAH2876GYazqtWtKKJ6zNztw5?=
 =?us-ascii?Q?9JH9D6veUbXfnQsLZhrxd9BK2GMBurxH3IUkpSEBaFZ50zkYap+Kcu8JrAtI?=
 =?us-ascii?Q?X54fIXqsakgK/qp2ToLMa1g28bZ9GRof50iJq7UFuMc8A4DVk6tU6jUv6l4S?=
 =?us-ascii?Q?jqQHq/hgkoF/DzX+4s80sMFALxUbTsnaWzP8sIj7ZwNmq4kmMmDcekWnSTgL?=
 =?us-ascii?Q?wuQPVe/hfmmckdw8ZZqSzLSgJ6BytICYisXf+uRjuILfEVE5WlbNLrzxaqBO?=
 =?us-ascii?Q?PPtixHuZp5Ze+G1KvslRgkVbysD+WX1hhzY9Rvs0oCbuBHGf99ekoyN4WTue?=
 =?us-ascii?Q?nqjy/jA8WnTV9W8MzQ1TxVB82J9sp/IdoGFxkLJtOYulwbd2ACYkId70gqmW?=
 =?us-ascii?Q?EHjs1MWvmXBX9KH/jLWxP5p5KLJOfTWrvogUrMZRXfQKuKHIzfort7yN3wqx?=
 =?us-ascii?Q?T0vJb8hgqdYVZufdyofXW4k7AXPB9fxAKcuY07NfKueMl0cM3BICxde8M5I3?=
 =?us-ascii?Q?FGzmpriSXhtIhX5gpCIA2nVLddwr5ZqoXEFkA5mPrFMgvByYlaymaeFq0ntC?=
 =?us-ascii?Q?AKuUb7BUpaHrIVzkIs0+QFMSCU8FHY9NcTxvjSWcTFCFWmzXOrcslVIkNBmQ?=
 =?us-ascii?Q?FNvOxOT5e5RW3lxy/v7T6m9zbplLu0THFm3bhZl2rkInpY8dULLLSYhxqKmK?=
 =?us-ascii?Q?riXN6NGXvymgS83OaDYuX+9qg5k9g+trYPGQ6DirMSoWHc8gtfzQPyRuC+em?=
 =?us-ascii?Q?g4/pEDU75lVgDdtptytKCD5+HEKZLa+oI9g8SAhwzjaidkE8QGx6iji2YvGZ?=
 =?us-ascii?Q?IWlTOBJZnNt2o3EMf6m4tLFzXBkQw3yfimxbE5Qvc/i5bAM4KRrU/MoUWupp?=
 =?us-ascii?Q?IoO5Hn3XV3TtMO2Zb1xxbr3YqtJNCvTYxKjS/L4q5WPq3f3Srk6yqxuFqArI?=
 =?us-ascii?Q?fDPLmL5fyQh0KQfVF0uIgXo+6xaqighJ08mOg6plpRKKAGvm4KsG4Tvg6yny?=
 =?us-ascii?Q?LZPH51XZUDN82HqwyZFGWJCw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b532590-f5f8-4f26-0310-08d8eeeb494f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 17:35:58.9784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hQvHy+mlY/7ALeKXODHVypw+383TX6epYjzpFqIMYbD8KEVVF+T3Tjt/09aLNK6p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1339
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 24, 2021 at 10:54:58PM +0530, Devesh Sharma wrote:
> On Wed, Mar 24, 2021 at 10:26 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Wed, Mar 24, 2021 at 10:00:05PM +0530, Devesh Sharma wrote:
> >
> > > > > > -static void bnxt_re_dev_unprobe(struct net_device *netdev,
> > > > > > -                           struct bnxt_en_dev *en_dev)
> > > > > > -{
> > > > > > -   dev_put(netdev);
> > > > > > -   module_put(en_dev->pdev->driver->driver.owner);
> > > > > > -}
> > > > >
> > > > > And you are right to be wondering WTF is this
> > >
> > > Still trying to understand but what's the big idea here may be I can help.
> >
> > A driver should not have module put things like the above
> >
> > It should not be accessing ->driver without holding the device_lock()
> >
> > Basically it is all nonsense coding, Leon suggests to delete it and he
> > is probably right.
> >
> > Can you explain what it thinks it is doing?
> That F'ed up  code is trying to prevent a situation where someone
> tries to remove the bnxt_en driver while bnxt_re driver is using it.
> All because bnxt_re driver is at the mercy of bnxt_en drive and there
> is not symbole dependence, Do you suggest anything to prevent that
> unload of bnxt_en other than doing this jargon.

Well, the module put says nothing about the validity of the 'struct
bnxt' and related it extracted from the netdev - you should have a
mechanism that prevents that from going invalid which in turn will
ensure the function pointers you want to touch are still valid
too. (as the struct containing function pointers must become invalid
before the module unloads)

Probably the netdev refcount does that already but I always forget the
exact point during unregister that it waits on that...

As far as strict module dependencies go, replace the pointless
brp->ulp_probe function pointer with an actual call to
bnxt_ulp_probe() and you get the same effect as the module_get.

Jason
