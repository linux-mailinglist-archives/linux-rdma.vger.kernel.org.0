Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E0A3A4834
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Jun 2021 19:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbhFKR6V (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 11 Jun 2021 13:58:21 -0400
Received: from mail-dm6nam10on2052.outbound.protection.outlook.com ([40.107.93.52]:48993
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229979AbhFKR6V (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 11 Jun 2021 13:58:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQXP5AZeETfTORD6n3t6fHu2yuV3+jXPRsG5CgAGGDarvcU6Usoj8a37XPi7tp/AjSs0U8kJdP8dB4wyUgzLPmiju1ulR43wwth8UP8imMhg264Mlg05xic+C6QXREdmF9nuwJqy51dvy4TgwUbC6Pa7riMiMU2oJmx1/2wwJ5qiAMbgfkB8UGqrd7TsoOWlqov11YYGUyWlRt4kS+RlJdP2b+QdtibAbkJ9bM1yeSSkJ0Xj7UgW4nU4FYXl1VaYKhD1oUWvjXEWzghoDtRlXC40vrCK4qj9xcTpFGPmTy2i8VZ+xN3CPo+DNr0E6yZiXuw7w4edf5q2JVGxRIbrmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4SbxFx22O6hI6gzXI/sD+OgvLBgbLAiQxFmXMhyF7Y=;
 b=abit5SoT1Wb60VTc0cjZEkvXZENqOlLKzAuQDn6ktH/3twKpwPT7WPogqBdv6P6MdlGHvwzgrkdKA2jYTGwP8pnGEnMayA8xKbqyjVUEY8pA+ehzHoeHCLafrVey62OILoqfIHuAy5YYL8QBaF8ytRTdyA+g/QBuvdp5US8TPuSSEhS2B1uJ8PkqXpWhbzwOxwzUB0+PlI4WrgyeXA7m7RvrcCqaoqtXhi3YrLm4xEdQtg0FVj2h52ie7LhcgmzTTUwRlUzyFsjY0sbAb8Wg1ksZbrlcNp/R30V+A0GALGdPFoTIy7nGCw6iUPpwsAAa/J/g+UjMBbtPS51h8hLEDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4SbxFx22O6hI6gzXI/sD+OgvLBgbLAiQxFmXMhyF7Y=;
 b=KIhA9/HD0kerOkjzMdmbinALH8RA9zvJieqaYkcEWyLvTRAd5qK1c/zSrTx+krZnEUj8KLgLQmYnu7LfCHCRcHmZD6O2YQUp4nJPorpxJ6IWbOlnGFO7IvXH57yYZprwp3i38775HD7D2rWHDX5uI9y47mrbqw9axbLt3t5fXHGs0T4RWWrF9FkJODJUhVs3teX5Iivu3ytMNSxISSqfmLpvWMmWKNdmkUGMNaxTQm+SqAv/Mtk/Kc0KtvnyBuIBjfpKLzKSxrzJTXXZqEtCtMYWN2W35bC5JjiXGmU1gAPv3ujGgFSUMg7iWb5YzkudrGFwOt2r5g5KDJ8VyZtMbg==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5270.namprd12.prod.outlook.com (2603:10b6:208:31e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Fri, 11 Jun
 2021 17:56:21 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Fri, 11 Jun 2021
 17:56:21 +0000
Date:   Fri, 11 Jun 2021 14:56:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Christian Benvenuti <benve@cisco.com>,
        clang-built-linux@googlegroups.com,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Gal Pressman <galpress@amazon.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Nelson Escobar <neescoba@cisco.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Potnuri Bharat Teja <bharat@chelsio.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next v2 00/15] Reorganize sysfs file creation for
 struct ib_devices
Message-ID: <20210611175620.GY1002214@nvidia.com>
References: <cover.1623427137.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623427137.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::32) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0117.namprd13.prod.outlook.com (2603:10b6:208:2b9::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.9 via Frontend Transport; Fri, 11 Jun 2021 17:56:21 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lrlOG-005hqX-Rt; Fri, 11 Jun 2021 14:56:20 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc435f5b-fb14-4b21-b372-08d92d0238d1
X-MS-TrafficTypeDiagnostic: BL1PR12MB5270:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5270A7D1D4390171FA775FEDC2349@BL1PR12MB5270.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Viw+R6zvcwUeMCkJqaKbb54KYOex8Xn/pKZAt2rOEMhFLvAdcwGMejhpYdDBb+BSZwJbojDCZh3an+w8zH8TCMEhyPtCehRmDAyncvgMEs0O1BQiAqnx6BH/PJUfteNCsX+b79UJBkaMhb3CZxfHa2d7OOcKuLgF8tA2RPjNZPo73+yjyr6ZwlrwK676USICjz7Ydk5DUkfY0xOnsefCpJW1AJkRa3fsipyteLxakQ6t6G3A7v4HBViGqfNvEa4JABGcWBOtPjbOuChkwWa4pcHR746F+heUBUC4w2ILzAiq0M3PKb1bdg04nJQRm+MDzVxuL2ANlO3aaepFXEYXyZBQhyXuNbj+tvp1e9eaTSBgQpcKN6YHGNXyJCTraxWVk9vh8qB9kcRrFZSU0N2mBlG0zOnCyIc2T2YtBYWGry7wKR/YM3XEX8TPcKIJdsJ4FlFv750x+kQV0Cn7d9i4Di4Xdshz4fWEEHXdIMvllt14OyiNoZ4WDscVJVU09lv2vAa+RF7oG13Erj+lrtzYy6M9JGOW0sMPFn3JmTU9AbkzOTyMU/UsFRGf8O7Jl8o3CI76rZ1z3CNEleei5jKGJplzglXkwZP+4qUci0webYY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(66946007)(4326008)(1076003)(66476007)(2616005)(7416002)(26005)(9786002)(66556008)(54906003)(8676002)(316002)(4744005)(9746002)(426003)(186003)(110136005)(36756003)(478600001)(8936002)(2906002)(38100700002)(5660300002)(33656002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R0ApAoJhdUIR9SXi+btORN/Yr60ZGwwFUHgYQ/BW9alO/sVfzdfw2ROTjEyC?=
 =?us-ascii?Q?PYH8+cG2cdPhKYSumT2nvs3IxcdCTefJJQ84og9r1wRncPM5MAo0mRUyfxPg?=
 =?us-ascii?Q?6LW6TzzqLR/mGdsDQCoGsw5FoKek+w86IhOwZcQ94tVkIfMfcM+5JuAKT+eW?=
 =?us-ascii?Q?H3KCXRPej5xHs/dG4BQQJVBcfQA78y1WOypQyzEps3H8o01oG7szkAODr2Yk?=
 =?us-ascii?Q?X/mLVGx/mKOP1mLfgIBteeSkf8994ozPsC8Q8y+rPncSzV8s42/g0W/tt8VB?=
 =?us-ascii?Q?ai99YQEqJOW9fgp+852nFqGEUF3n9GKPdUn/jICfpmpqzzbKhTrKVTurrVv+?=
 =?us-ascii?Q?RlQFyEuBP/cEBo8GIjQ06FcdbCdLPLR5v5ehy28B+4yqKrjcpbTDkXaQVWGW?=
 =?us-ascii?Q?L8tkG47m2r0ty22BWlnTu7HqDk5+DRvTHku+rmQC1znFeAxtjN73W5g9DbHP?=
 =?us-ascii?Q?7RPTyKHlGI/1vl78oAf1OGiYLNQoh7bAK5owI2XDRoWMSadbV5lH8g4TxIe4?=
 =?us-ascii?Q?0FOp7SZwjEdEKEEeCV1hwPjlC9TK7p1YnqSN1AahlA3hnmc9ivTSL+GhsP/v?=
 =?us-ascii?Q?gAJfmEkh0MkrbmfBIlKlcwjXOGWgTNLybho1D9LUXYtkE+cD8TSPR2ZVm8+1?=
 =?us-ascii?Q?MtSYI9T2DlsX3uUz71UljpUIVyb5q/xR6p3Ysja2Deml6fz0YRH2foJzFAK5?=
 =?us-ascii?Q?AS5DHU1L4uYWo5orBjTeBZyynt9SBSN3Rk05bqyC2rpHLCzg9nN2efI2V1EF?=
 =?us-ascii?Q?dlCFhSCFPfhUIkGKrAyRVw67agLy4lV8WsiIj9BAsulOtlK6nZRW45jB+bdt?=
 =?us-ascii?Q?WQ07dklkSQDWjw1SwgTVX3r5+HYzqFL0he68zMwL0J2MIM3BNIRAapL/yP8r?=
 =?us-ascii?Q?05W6f23LsUDWAVwgNaKTiQDLJbPiIdIBrziWs3RVRlsjTeO6x7dtRLV03pUa?=
 =?us-ascii?Q?tQRW9QHkalnLoyV7+OOX1HGWl7EH4wbrLO19i09vdhdkk5xu2oLqLU26FIKp?=
 =?us-ascii?Q?rConCfRkqecqWQrew9nNaoGj09RrB6wUloPNdcvUFTBktu0Et66QMuhmJmqX?=
 =?us-ascii?Q?Gy1IXu5U+wz96vnuwLMSlicuU6ZORHLouB2WLk9z1js8pqVOaxP2a+x4s/k5?=
 =?us-ascii?Q?DzD2bD3+s+MW/TT6jWTRMTWjacEZ9glOBM+Nl9ePwT1q+NZXDJK6ByayWrRn?=
 =?us-ascii?Q?z2Vp91djq01JbfC4kVgMN/KdR/3m8p/a+u3aKcru+T3mJcbrtraXXROecpSJ?=
 =?us-ascii?Q?OiXDBisnf75zusrCCsVIW2sJlb4+0dOESrg4Ys7PRKbIOW2/O88ff9R2gr/b?=
 =?us-ascii?Q?7Wx6SOKMMFj9A02Cr6qo0M4r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc435f5b-fb14-4b21-b372-08d92d0238d1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 17:56:21.8098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGFrCI/kzVfFcXp3NKzKpNFRwiy6znhajAp/A2JTgekxp0TkTVuUABFqD1rBEerp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5270
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 11, 2021 at 07:00:19PM +0300, Leon Romanovsky wrote:

>  drivers/infiniband/hw/hfi1/hfi.h              |    7 +-
>  drivers/infiniband/hw/hfi1/sysfs.c            |  530 +++-----
>  drivers/infiniband/hw/hfi1/verbs.c            |   92 +-

>  drivers/infiniband/hw/qib/qib.h               |    8 +-
>  drivers/infiniband/hw/qib/qib_sysfs.c         |  616 ++++-----
>  drivers/infiniband/hw/qib/qib_verbs.c         |    6 +-

Dennis, are you OK with these changes? 

Jason
