Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57E321618D
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 00:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgGFW12 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jul 2020 18:27:28 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:65260 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726763AbgGFW12 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Jul 2020 18:27:28 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.9]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f03a54a0000>; Tue, 07 Jul 2020 06:27:22 +0800
Received: from HKMAIL102.nvidia.com ([10.18.16.11])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Mon, 06 Jul 2020 15:27:22 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Mon, 06 Jul 2020 15:27:22 -0700
Received: from HKMAIL104.nvidia.com (10.18.16.13) by HKMAIL102.nvidia.com
 (10.18.16.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Jul
 2020 22:26:55 +0000
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by HKMAIL104.nvidia.com (10.18.16.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 6 Jul 2020 22:26:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5hzsYTiQmMuGViz2iqpQnyEwCA/XGp2ToPSnk/ByP/NAPRsV+isGa5sLn+pV79Qd2sEoIlm+Y4xvgNRXTj7rryt+SHczeEu/ImdSasAH4+V6DZRb63TB85HlqjZd7iNZVowSkMCTZx9hW8Zr4GvGdOFnq356HEpLkagtvDzshS6jj0+XBHToacBESXrwtagD5/bEkFn8aLJGQJRfiI7Cs0+XdelRLsAhDJcuWAeUZWDKEL042FZ2mXzln+xQBAGoV5srRTDuytHPqtQ8pXegGbpWCL1vyNF0jNyKTbPqsu3RJ0vF/or92aqdqEy3olxzO1WTdD1uFQh8baVFUwOAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DIkpZOaOca4oT1ftEVmKd7HrN9/iHKZveoyN2pn0O4=;
 b=aAW9PnyethEsriIEUZfPWOnTqLA/4aV2QOU3XSV/ZF77VntP4GGxzN8cYE0IAAIb10msHOOPg3b9WM76tvMpTAguQebAdFAiOOIkW1FThh9MSc9CRhHcQUrp1BENr35SvdY3btSu2+OLMiYTgNj7JtgUsKz6HX2MsSvPXw+CANKFV1XYnkri/mkjMe0M0Vop+fNFTvGWqkhjGrxZksK7qH/byLfEciC4jt1w6W8CvWZdzwJ+yuxn8BM4CQfrBpGcFdei9Hj5XgmzUYjqsgwlz3wIpOyAUvGoyeA0JFPAw9qmqbeYiF++LGcfTrHwe3Nu3A61zpLgHu5m+4SSZromFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1337.namprd12.prod.outlook.com (2603:10b6:3:6e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Mon, 6 Jul
 2020 22:26:53 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 22:26:53 +0000
Date:   Mon, 6 Jul 2020 19:26:51 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Gal Pressman <galpress@amazon.com>
CC:     Doug Ledford <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        "Selvin Xavier" <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        "Potnuri Bharat Teja" <bharat@chelsio.com>,
        Lijun Ou <oulijun@huawei.com>,
        Weihang Li <liweihang@huawei.com>,
        Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        Michal Kalderon <mkalderon@marvell.com>,
        "Ariel Elior" <aelior@marvell.com>,
        Adit Ranadive <aditr@vmware.com>,
        "VMware PV-Drivers" <pv-drivers@vmware.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Zhu Yanjun <yanjunz@mellanox.com>,
        "Bernard Metzler" <bmt@zurich.ibm.com>
Subject: Re: [PATCH for-next 0/3] Allocate MR cleanups
Message-ID: <20200706222651.GA1257136@nvidia.com>
References: <20200706120343.10816-1-galpress@amazon.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200706120343.10816-1-galpress@amazon.com>
X-ClientProxiedBy: YT1PR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0090.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22 via Frontend Transport; Mon, 6 Jul 2020 22:26:52 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jsZZb-005H2v-7C; Mon, 06 Jul 2020 19:26:51 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03465442-e0dd-4ccb-accd-08d821fbaef5
X-MS-TrafficTypeDiagnostic: DM5PR12MB1337:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1337E7C5421917559C6AF751C2690@DM5PR12MB1337.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iQmEuE/G3OcWuPZuOxqynL582DD+kr/zzdqv196n5G4vXzSnF+f295qpbtXrMA3dZNwFaHYfrbWcMwdkvRwAy1G7SndJTFq3dBwlqdI0mAfyz9Xb26amDQsZJwuuBOoppfkvOoBXWunPawC5VbwJP0eWaZGsI1h74rz+rw+8ZgfDyqpd0Q5jzYL9JXvl3n8s6d7vqwqI745pXKyAXZttc2HRLBEM3ojsftjEWMOk8/wHoTC5qtoQHtytAmvtV0gIfDABmIq7jdQThekYS3C7y/eUbX5gp9FYtMmfCBJGTecMiBQljJc2dm164CRCGYm2YrEkl2mCZUr/1OCxhQ8dkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(66946007)(66556008)(36756003)(2906002)(66476007)(4744005)(1076003)(8936002)(4326008)(186003)(7416002)(86362001)(8676002)(54906003)(316002)(478600001)(2616005)(6916009)(26005)(83380400001)(5660300002)(9746002)(426003)(33656002)(9786002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZMY4Cj0yodm4J2DzJnbpa/9rGutFhU3UyaSTEjxLPs1uce23t+vZVXWuVioWQ5oJ1jiBopxDKbRi+q0EnZAov31vEzIEBsZBG0bHa/MBuygtYPfxOiy1J6GehO8qZSmBtzhuT7KQcsDD5Dqw3NpV+yNgEHHTcGGxZ/xsL241X6U5LXV7mQeXqOq/QKX1EaqKPWD3gfRNMA8YMOi8/erXuNU8ESIt/h6+eXh8kILnLdZVYCSl08G5Lpc2dRp1cttmqEZx4wlsXZbsEr/8jZIcPpIL4i23SFiSG+m/uWLZXIlDZq2+1cjvNpDWEerDA2ORFMDsEXHvoUdlGwk9OU41jPo+B9rn66CylVe8ICxG18lZrfTg5VTiNzZv5FPvoSDv7SfaPvxWE00sMZolzPlKi0auCYSJa8Tmy4hu01wNPED5Y72p4w/JmlKq5eSCdq0ZJOKTPzF8L0lE7VQWY1tqfabrv4zlMRi3zB+oxL9opVT6uh9O5tkeRV+llDC8fLEa
X-MS-Exchange-CrossTenant-Network-Message-Id: 03465442-e0dd-4ccb-accd-08d821fbaef5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 22:26:53.1337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dmHmaXghgAZG00rpCj7S/t6w1+5/sLqcMeTQMmwn8Bh3X7y1EC6c24sNUGXY2xZ7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1337
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594074442; bh=/DIkpZOaOca4oT1ftEVmKd7HrN9/iHKZveoyN2pn0O4=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-Forefront-PRVS:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=J4r1bVqqGys+/lvGxvp2gZXszYU1GVOGXk/lqsloBKLBnYyOBw4TQzeRixipumsz4
         9kFVoMbmlyFj62yQj2rQDpLgrsrnfkXofxI2T8+qXmjLk6ba5fXVjyj1gwGD1AEXwn
         h1BAuIIfeT3mz/njxOtCHYGtUJdC38VkBBzuycVfDrvzCxrPsj1fDHonIY1+7CfZZ1
         J487fnFT1XXqKgDY+zTdDWZmgTp8NYOtBfwvANR7wiHM7TCggvlYtN0ZApvcvLslaQ
         LnY4CCDF7Wu3ucWdYxP8+2qdHN8BCuhXvr/7X5JiIzKAGLcCj56oBtjRU7/avRaQvq
         87GrTDZtOdgfw==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 06, 2020 at 03:03:40PM +0300, Gal Pressman wrote:
> The allocate MR functionality is limited to kernel users, there is no
> reason to pass a redundant udata parameter.
> In addition, a small cleanup was added to the MR allocation function to
> keep the main flow unindented.
> 
> Gal Pressman (3):
>   RDMA/core: Check for error instead of success in alloc MR function
>   RDMA/core: Remove ib_alloc_mr_user function
>   RDMA: Remove the udata parameter from alloc_mr callback

Applied to for-next, thanks

Jason
