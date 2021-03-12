Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55776338F54
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Mar 2021 15:02:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhCLOBj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Mar 2021 09:01:39 -0500
Received: from mail-mw2nam10on2053.outbound.protection.outlook.com ([40.107.94.53]:39520
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229728AbhCLOBO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 12 Mar 2021 09:01:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxY8IddnlQdQFz6IGyagrCpHMcV+6/ATJGlBM7bBJ8VsbSlv3WhT8L0PZYVtCsAF5PZShVoTlrOh99Mt8thvFDBv9iP9xrQelwhxVpveC4+ajWwwFD6uXTCBQOXPbJqT+vMDtIVxODl/bjg9/oIL2g7e0YEfDs63Da+TrcUw/v9HJjxuuHLhagivosrFWro5iacj8JHMNNhSca6cna4frGJodOcT3cNMWstOGxsfVDppk12uRFsQ8XA98w7qo5rN63XH2GAF9I5wN1uQsOtqQP1KgnQ/4aQr/1JaRJobqunlRt+HicstC0zWpQPQpvlVSKCPqB7A9ZiEtRX0AooEFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxFGkxalSOK/qH2v3iMfrWr1JhSZ6oE+oIbdKxRiTi8=;
 b=fyBOoz9rw6ObTI8IjPcTlBSGg0okZ7NhZUMTE9qCJy8/Otc/jcnfUGvGI7qJ/BLSmu0rQr3dR+fQYmVdNGJn2nfWLW/ywIyhATj87H4iCu2KlNwqw90HPAkh8U2hGSxd1RSXROWQ/maOwCGn8LyZwLCiUPbrmunkK29gg8wRT3DccxTFrGlnIz/K0Fnm482mPffPn/DFVfD6QgWRJywrSQJ7gK4SXE/8UpKdQYzg5ii+WkYrlY1FVj1vGgVkO7JVyDPDtqDfYU8JbxEhkZVDGcrXdCRJjCoL+eQJcdBR/93je5Ynf7Iu52nJj72tCciJDFR16SlHoTXXK5ongaY86A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxFGkxalSOK/qH2v3iMfrWr1JhSZ6oE+oIbdKxRiTi8=;
 b=Vfr11L6ApEAt6EGjmIlLu2yY0+ByZKB389oovPB0JiMJliRqp0eFpe6iqfv8Bj+AapGY6vD5per4oiGX/bagAbh64Z6CMQreyuhP9gBibzMbzBP7QUjhjKNmvvtuZ26ltffpbqamNyWtcSG58IL6ygTFj453HjuVS16q3tju0gPliUfJV5kHwTw5AWl4F8l4GcNJr2c1w+MYrCBU/69YLcNFW0NRqBct3+9fXeZS6g5equ/Z9n4tOk17iYZ5nUQpGXWJdk0tL4CnwXEH9ACp4XX4YmuOF40zO1depBs/KJOJRIKHxQpBnCjpTB7lK+DODoWeCjTd6gffb0F+9hAqCw==
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2602.namprd12.prod.outlook.com (2603:10b6:5:4a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Fri, 12 Mar
 2021 14:01:06 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 14:01:06 +0000
Date:   Fri, 12 Mar 2021 10:01:04 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <zyjzyj2000@gmail.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        maorg@nvidia.com
Subject: Re: Fwd: [PATCH 1/1] RDMA/umem: add back hugepage sg list
Message-ID: <20210312140104.GX2356281@nvidia.com>
References: <CAD=hENeqTTmpS5V+G646V0QvJFLVSd3Sq11ffQFcDXU-OSsQEg@mail.gmail.com>
 <YEUL2vdlWFEbZqLb@unreal>
 <CAD=hENcjqtXstsa3bbBCZVGF-XgAhPz-1tom68zm7WNatH2mZw@mail.gmail.com>
 <20210308121615.GW4247@nvidia.com>
 <CAD=hENdymrkFV-_piiOKL-fK38SQh3sTAfc7+WPSky8mHtJ8DA@mail.gmail.com>
 <20210312002533.GS2356281@nvidia.com>
 <CAD=hENcb4DAs7hhPLqgqAhLr8xYqxkMhGp=99bfgq1SZN57QHA@mail.gmail.com>
 <20210312130243.GU2356281@nvidia.com>
 <CAD=hENdqu3v5_PJwQF2=zQ6ifGZD_DUJtUStoiCA5byru5phaA@mail.gmail.com>
 <CAD=hENf07aKBivP93tN9CAR4oZ9jEygmVKowpxGTdAAV9pjpEA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=hENf07aKBivP93tN9CAR4oZ9jEygmVKowpxGTdAAV9pjpEA@mail.gmail.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0320.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::25) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0320.namprd13.prod.outlook.com (2603:10b6:208:2c1::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.9 via Frontend Transport; Fri, 12 Mar 2021 14:01:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lKiLg-00Bus4-UN; Fri, 12 Mar 2021 10:01:04 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62c6c7a2-dadf-4367-ee62-08d8e55f47f7
X-MS-TrafficTypeDiagnostic: DM6PR12MB2602:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB26029FDB674CAA197A8B157FC26F9@DM6PR12MB2602.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dic24OVDw7/Is0yCdfUPKnjW+Ra2QvsC0lpJkXJ8s4GquwyO4YQpzeuQTMbK07h2z6G8c2CCh3HcicN3dgYSVtoK9TmplKBm6KmcnsY6ZnuLNfIQCUE48UVfj9m85eoEUFDeJ/4ZAwUgmBzsWFtsrN88Y4xcOcOtmMLYlvZ8a3+64uyCvkLm9eyzgJhmQTxvTlyU6Jx9E7Jw/yykRg0GAPUQAI3AmC3NXvpCJaNEALvXaUBtu9RUDR1AWnA0y4zm9xMy011xmj+bfPPVqNVn3mRv591B6XV5fa9q9hPXnIGh06cTtizxDq9Vpbfi5+scg4eT19EGsqnzp3VY9jcU7Lje3ZQL5YmXgf0mg+up282fm/fBuKfvp3Msqh2Icj8LLi27y5hN7EHriZI2T+VSvT9uu5TgZ6UHP/qNa1EWdFW4N5Xy/PUo+qMjfBuG1ZXD2L5yGGq131zwEn/2p3Q5x75dEInk5Az/OnAqdfVECpMH75wQPZ28vZbunp2ah7mDyAns738PYpV88VDj7Dvx3AuZ5riXoJdW+jyrHrpcPR18nlhFJtY1gnKiHMjKxFZK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(33656002)(83380400001)(66556008)(66946007)(66476007)(36756003)(478600001)(316002)(2906002)(4744005)(1076003)(5660300002)(426003)(26005)(86362001)(2616005)(8676002)(4326008)(6916009)(107886003)(9786002)(9746002)(54906003)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?oaWs4aNukNZ+fVpw6V3+OGRyrNIGj5wQCdVQ1pyMTSiGN64nqwEqmWo9p3Ge?=
 =?us-ascii?Q?AB0d5R82vPGrhtSAmgaxHpHk2k2S/LKN0OPmw/+f7fI37bdbQHK8TptxrWga?=
 =?us-ascii?Q?NZTdbEcPyaFC1Bsk/p/Dn1LZhvh8KdAPg/Uk34ll25CF8ufMVCCrhpXRD6Tv?=
 =?us-ascii?Q?q8ZXV6xD2Mml7tg+u59refoCD4QBE12btyNA15mskjIZ4jUZM9PtDF5Bqncv?=
 =?us-ascii?Q?EccYoOIL40XvC8rV13EYmrk9yR5G9Fecacg4dW1Ciqh/2eBXbZJOaFZvrV9e?=
 =?us-ascii?Q?2Jvi5tlUHf/KuepgbbIgJGE2YKUhsCGvWqXvXkh2DrSwyoTZsse9t3iuq6qu?=
 =?us-ascii?Q?wcLvl8Ew0KnR2YcCkaL9cPgR5KCvW/rQxXAKmAL7bxnYWS7eQPT4c6je1fDu?=
 =?us-ascii?Q?AM5r866ia1TUIZQw8b+FmKDYmlhdNa2nqh4GPxvGB8iGHLFjZyw02S1tdJ1p?=
 =?us-ascii?Q?kxQSLvHULF2KvV/y/OXOly+NFadE5BKM4l6QjB/GMQm9dRZnQajchis+GGmU?=
 =?us-ascii?Q?B6nz6DcbQuy94mLkt2cy90gegYkLhJ0LDgYc52fFPwHsWP+aEk388IHsvhFi?=
 =?us-ascii?Q?Uw7+OBDwY34NOvpeZ4GtSepnRkh1Yy14qujHDSq+S+GSIN4lpvuJNHvQLZBf?=
 =?us-ascii?Q?kl3MPuc3Xx9zO0KFFTp1ZPb8JK7DjJ6h4SHkeNR+7PratfW71TZWj9OJg7vR?=
 =?us-ascii?Q?ajxBf+DTcLVHK1uDGTW+3LtpN37KcLV+SQvwghyYNwuJzzEexnlTuG8khrlL?=
 =?us-ascii?Q?NwGsvZhQjmjydzUrHt3wbYxra4vF7hjzr82eTbW1AIDg348P2Sf8YN1loV5O?=
 =?us-ascii?Q?o9rBZMcKLXdKsx2RmEB34XKB74lJKKLLI/kemfgQ2uGIxX6fO1XIAEqyJfkb?=
 =?us-ascii?Q?KYuMyudT9weCyELhtmxoC15aeBNVkXanCdBRIpgtZuo37ASOPQB8vuisLL1l?=
 =?us-ascii?Q?qiG65d1I5MqBnpD89ZHz0a+g1SE6WoGXbcoLhjW7V4MJ1jbkDryKMA2SxFpH?=
 =?us-ascii?Q?8+lmvp2o6EBLc0zxo6adPDdYnFcuR9Spi1E4xjmQygvOCQ6zw2iWtr/Pgj3+?=
 =?us-ascii?Q?KRviiFmLkkAqIXxhgSi7fvh3S1KAv61N0q+PmroXmidMpLgFN3zxHcnlbPRr?=
 =?us-ascii?Q?NiZqw5JOlvTcVH6YX1CfcPDcuvBsNH4O8N/XseWrW1Ckf2E7FjuCD4MejUIn?=
 =?us-ascii?Q?bwPGMTL/dXRlBPTDTPCVRHtpJzw6vfSER2ZWD62wc9f03RUUpQ/nc+chwzgt?=
 =?us-ascii?Q?J/vm7E0Hy3P19j0NUgDovEq6zE8Ue3Cd1pUYi0gMA5MQgFy2ylbIgGGgT7vG?=
 =?us-ascii?Q?/tblLsDptXaLhw7uzi58DtEiVMF/gkN2y+GIgQYNiDVuTQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62c6c7a2-dadf-4367-ee62-08d8e55f47f7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 14:01:06.7648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EYP3GnuoyFEJwD9J2rrnjTDjgoJelv7YlfPyTCR0Iq24kotKeqlttv8pnTeV+2HO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2602
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Mar 12, 2021 at 09:49:52PM +0800, Zhu Yanjun wrote:
> In short, the sg list from __sg_alloc_table_from_pages is different
> from the sg list from ib_umem_add_sg_table.

I don't care about different. Tell me what is wrong with what we have
today.

I thought your first message said the sgl's were too small, but now
you seem to say they are too big?

I still have no idea what this problem is

Jason
