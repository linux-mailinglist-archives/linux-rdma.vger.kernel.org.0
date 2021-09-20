Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C44884119F3
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Sep 2021 18:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbhITQmR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Sep 2021 12:42:17 -0400
Received: from mail-dm3nam07on2041.outbound.protection.outlook.com ([40.107.95.41]:12897
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229561AbhITQmQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 Sep 2021 12:42:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9dnEnAWMnn5T/ieInnG0SDZdvMxaxwzU0XChzqwbZgcq+YnL/LPLIvZu/pLWUVfTIPcDob4Wbq+VZHNe/Zg9whyO2WvkFAUFGhlqt7/y+FTvL7apd/uV+u+t4bghNUgfOkWMWCkI7LQihuTuzW5LPJz9Oe0ng/VNdfFBoDW6bvdHGQ1hdI8KBrOwAC2ytayrjvZ1dfjMqit1Bk+s4o7WwV5o3Buc6cle/IWmycl3AAlAhP4OIJt589JajdGXF1lYaLOqnFSYLJlnTNLo6L+8NPz2KcMk1TXboZgxz6g1IBwpfwspa9620Sxlhcz6KlcB3o6ODiPlERBOZDkalhc7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=VR/8baPlLuzBAlbx6gGdtz1KstdWFy/yBIMEzqWTtaw=;
 b=ExnmAsguAisqGSJl/3JJVOkuCbKZjGeqEVFktXpRggxw4l6zG25UvjQ1sxMrwLXXk5u1pHF2Pn4G2/r/01TnlwY0yTEU4cleyKaozL+nY/agvhW54vmF2AN7xoI+6oG3NRjg4/ICXxH1gpwn8DpDRIH0k8muRP57+LqGSmavnvosa3kaqWvIuvZPBdwA62n3+RW132hxZn1AjoiEGrqlhmXxyZdTpSC+Hb/UF1yTA6+R3sEFRaFziaAy3M7woyzEkEdMjrC0/bm35+MHd/jtz3kTGmq1zBsX05YEidChbNT4Dknc549wuzn9GTQsUOEZaI5Lgtzfp41b5Z35WHpryw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VR/8baPlLuzBAlbx6gGdtz1KstdWFy/yBIMEzqWTtaw=;
 b=uW+byjCq84yMPem4UZiJZDswzkWCJzxK0br7qIg69G3GOu/XChouJaLTnbIPglB3Cdp/D3XWEA/rnKK8k7tNI2SgQDuGknmbhBa2UACHD1HyEKxjrlDkfXmann8Ah/IqSDaYyRwrXfAUFKYtKpCg8TiDpDJHqxv1YBIxhO1KybsTvBpaGn5eatHl0iR1xsNDSifF9VypIjm0hysAW1a4kGEkKcTgSSw8DfGjJ65eG1UkvlR5+7sl8pVquktFJtcq02ht5BWEglaM/1qK19QDZHaKU3g62FlF2oCkZeWdGSUNi9BYN1JOc3zn+58deaxEzNHPLGsPDCmu5Fquiaa/ZA==
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5222.namprd12.prod.outlook.com (2603:10b6:208:31e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Mon, 20 Sep
 2021 16:40:49 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 16:40:48 +0000
Date:   Mon, 20 Sep 2021 13:40:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next v2 00/12] RDMA/bnxt_re: Driver update
Message-ID: <20210920164047.GA717451@nvidia.com>
References: <1631709163-2287-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631709163-2287-1-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: MN2PR01CA0036.prod.exchangelabs.com (2603:10b6:208:10c::49)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR01CA0036.prod.exchangelabs.com (2603:10b6:208:10c::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 16:40:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mSMLX-0030ep-Rb; Mon, 20 Sep 2021 13:40:47 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 649f6a12-0e34-46d1-c622-08d97c5566aa
X-MS-TrafficTypeDiagnostic: BL1PR12MB5222:
X-Microsoft-Antispam-PRVS: <BL1PR12MB522222929232FC87F239B9B7C2A09@BL1PR12MB5222.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /TRCXx+HTZ2sXfJW8p/jPA7AZSgF3UwF0QCIhRdj17ZaVCTyGssrZ9zcJ9FCKOW47D3eBcnVEzEA526ozCuuVCUlIOp7RZhiYjX0m9GMYmX6d8Q1m/vjOIPCj4uuYRPuFKU//DM2rVX3/+UTlN9/XVpOBOz597FcDHzYmAuxeaEbhWyUYlnfQRDn4GYawzEl9btiqIkNY3+U72qL7c+3C8B+jafIwnMDpF80wDEjMQBxrNX8bVJ2t4ZXnr1JEvxlrddCXvpnn4RVKYQFUJC226Vq44PvUVR/DaS5XL9Hq8gcQcvXRT7GQVZDeyiz/n7vY+veJZ6vuGTr3/hWe4Vi72jQLJ0DcdRfOASGnbeZA77GxGnG99FDOwGa9KDbfwmxBTI8ejFrqXZE8unqGBl+UgyK3LaJ4sKLXD7O3ahUIeaEXAZ5o1TSVJdyQ2l2zOjPieK/FtoPvlZfQoHSYROZnR5I94uEY9ieQP3s2Y0S8cynhTP7PU1SOk0Z/Oej/R11gBUFOeQ6/gX5BaiZh0bIA7x+Gv9/iPoO6HNkRRCKXvQD3VgffOg1Z+pap9Y+WANXgAkrQ2E4daNNYTuAvrZvCXMUEQnfYqTOoZ7C4Rp7a3D8UCnM//gbmWlLSLi0wg0hTo9bYyhxDDcWVKsN0vxuX2abTcb3C+JpD2ayVV/IcILVhtW9aAiFI2y2Cjp5QBrzW1koUbimtO8QbEOE0ERFEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(316002)(33656002)(66946007)(2616005)(86362001)(478600001)(426003)(15650500001)(186003)(2906002)(66556008)(38100700002)(1076003)(83380400001)(5660300002)(8936002)(8676002)(4326008)(66476007)(26005)(9746002)(36756003)(9786002)(6916009)(4744005)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xvTpM+2hE4ab5VIWhyBI+u2RdZv3BT1dcYCoFFX9kIhii3qA8VCKdAo5C2uf?=
 =?us-ascii?Q?xO3E4n4PirYpMCizVx+ADVk+U6F5eDUf65TiZQ7UybdPMe3JjO26dMlMakuZ?=
 =?us-ascii?Q?2ICaxnifJnlgSR4gF3BpjlflWlGvZesVujL1mSXqAX4X2JKrUrhVtU+c2DxB?=
 =?us-ascii?Q?5cmbNXsJg215t4LFwM/ouxsfvBTy+zOzXKKasIrdrLcDqPvG4JiBK+TSFA7e?=
 =?us-ascii?Q?e99HXj2+H+YWeWtwc3lna8tZqqAS+/N90pgLnv2q4wtE3bQZr4/lZu2gOfyN?=
 =?us-ascii?Q?QfM0oky7lmrRVssoDcx+wz6YQL4bGD63lik58DtJjMZq4ug+oAkg15RvFQlj?=
 =?us-ascii?Q?fwecHA37UiBaeLlz89S9ayvEEJj3dPLz7tEdQn+lVv2on0MWxpozRpHsNU/K?=
 =?us-ascii?Q?usNSMB/lntTSEe+cfoGjEaTHsrUiIf7pznKoEtBZ0aicCJo0asHTyomAp7O7?=
 =?us-ascii?Q?oaCA2aXnVQXshkaVe/T5E5g4maf0LIaH3E+l5Vr95q5Fdr2G8j/pBZzHttW8?=
 =?us-ascii?Q?XmIOo2yAa/nFE3iGl1fgZEIclZqqO8NiGZaAzW7uwRFPNDJGkNhIMomUum4/?=
 =?us-ascii?Q?gtrm1lw2pQwp6W45/DEOa65+maoTm38pDG+Gt/TVGO13ziSDhnXyiqwY/A6N?=
 =?us-ascii?Q?001wvfzHCz3a+a+kmdAZnYnE9QZlQCpMJ2wJ5Dvuyb89FKUSeZpkEcNf1eOP?=
 =?us-ascii?Q?YKhaLH6G9lO9ETmcQSqM2dAWvtJ4MwP86GsQtGr41i09gwyD9uWGx8YjrX76?=
 =?us-ascii?Q?01Knaw/Xe5YRDprPmk3KWURem8P+ZXG+F2/7tfoLCcC8qIeZrUOwW4yCGjfq?=
 =?us-ascii?Q?fMn8jThqspOjJinwp0I5Bsleqv4iL19Ur+oxHCfNbWR3cmFq/uSVckUcl4dZ?=
 =?us-ascii?Q?UAhNe19SSZIVXR9vbWb9tvnheB05y9O5QKQ81ygaDuXiHJlqPbHgPSvehyYc?=
 =?us-ascii?Q?5N1YbZZHs7LLj4DHez2cWQbsMljqrZFjRTpWxjy2LWjytgMe//T/cFklpuoW?=
 =?us-ascii?Q?gBKYDT6KLrvZlpafykOTF5QH/owjPlsDyughpbpbYt5wVXE/5+Xu+g+xM3jl?=
 =?us-ascii?Q?7/AzkFdZ/0J48y4Xtm3r1WUUAEYvRN+0rpMmlXA0CxbdiwSYEPfVWuHC2GJu?=
 =?us-ascii?Q?TDbbQk40QZXEJah1DYLDp7RqcZhMbQuzGYxhxStCxlm3JpLiU2HxMbIVxN63?=
 =?us-ascii?Q?YaRbzg7bptE/VIcC9+J24/aYcmHgElhhs8dotOml5aSUGZt+J4fCjq/zlxQh?=
 =?us-ascii?Q?DgCMmPD1hQIWvQqE3irQ8CUId4fVSJdgHKeu0THrHSsqcHqlsmPlWTNvmvUa?=
 =?us-ascii?Q?vBMK2tSVVAnZv2EGVpinIdAp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 649f6a12-0e34-46d1-c622-08d97c5566aa
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 16:40:48.7771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grHNSqjg5d2dUn2/cmRNG6UUuSWK1CiyQlnGhSdeHOy7cVQRGAxzD5YeebHMsCaN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5222
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 15, 2021 at 05:32:31AM -0700, Selvin Xavier wrote:
> Includes some feature updates and bug fixes for bnxt_re driver.
> 
> Please review and apply.
> 
> Thanks,
> Selvin Xavier
> 
> v1->v2:
>  Fixed review comments from Leon
> 
> Edwin Peer (1):
>   RDMA/bnxt_re: Use separate response buffer for stat_ctx_free
> 
> Selvin Xavier (11):
>   RDMA/bnxt_re: Add extended statistics counters
>   RDMA/bnxt_re: Update statistics counter name
>   RDMA/bnxt_re: Reduce the delay in polling for hwrm command completion
>   RDMA/bnxt_re: Support multiple page sizes
>   RDMA/bnxt_re: Suppress unwanted error messages
>   RDMA/bnxt_re: Fix query SRQ failure
>   RDMA/bnxt_re: Fix FRMR issue with single page MR allocation
>   RDMA/bnxt_re: Use GFP_KERNEL in non atomic context
>   RDMA/bnxt_re: Correct FRMR size calculation
>   RDMA/bnxt_re: Check if the vlan is valid before reporting

Applied to for-next

>   MAINTAINERS: Update Broadcom RDMA maintainers

Applied to for-rc, thanks

Jason
