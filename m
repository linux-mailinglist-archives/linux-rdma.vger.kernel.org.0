Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499A6217407
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 18:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgGGQec (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 12:34:32 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8745 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbgGGQeb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Jul 2020 12:34:31 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f04a3ad0000>; Tue, 07 Jul 2020 09:32:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Jul 2020 09:34:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Jul 2020 09:34:31 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 7 Jul
 2020 16:34:30 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.52) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Tue, 7 Jul 2020 16:34:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNiCN7upmbTcK04suoBDIHO88Jw1MkaDNEhy8iSjACOeQDdoIPtQV4GkJFoUommz/YM9FYGj8DmEatQ3Tkqg1yKB3xznhUodC5cmmcKBXxsDJtvtV1fbCPyi/WLn1eDECp/rlUVhrv4k7H6+RHpUyq82laZHGKJQclj2qB2ku6wHhE2B1f9j+1Njn9CK54Ktj1R/pRYafJirXMdmFLrAJ6CdlnBZfagzX2kMiZCJ19zXsiPCMsmy+BQzDE1PLmftJLcT1sQp/aCB9uaWOOC81Gj2/W1WnulV6al1y18H5ClYDVicuDdnrKy/qsJjT3xrkosQoKqUTvWleUU/p60ESQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxIGymIQJX7OYAA0wDvL7BtvAHloIpSjlzU6qzK+lMM=;
 b=iqX3bYp+8FfW4A/uuPdmcj3fGaFjXm6mMNrOnP3vDA1qbqRjydC3mhq2w2KkugXuxy/56FuwT1di+7SXeAqJhgMIxDY3zOk0LwOfK/uDUZyPM+YHpxVQthXVKBFb8Fv1bVnfXoXzaB44q03WBwzOUdP7JtKG/InRuw8tyWh1slvdFBAttaLFn6CcoM+bgUT5vgObJ1LOIHwh5y4Gb3ghoBvm2uinv48ETCVFrQ7LYQVtN20VnSOjLfgF1K2GK7OanMMpY2/5Eti63+VtSXd7Ej+KRLZaVtkyRPKpZl90bKvv4WavwLRwppsKApXzRqTk7rj6StDRXI9iwBVgRFxKWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2812.namprd12.prod.outlook.com (2603:10b6:5:44::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.29; Tue, 7 Jul
 2020 16:34:29 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 16:34:29 +0000
Date:   Tue, 7 Jul 2020 13:34:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Optimize MTR level-0 addressing to
 access huge page
Message-ID: <20200707163427.GB1381043@nvidia.com>
References: <1593525696-12570-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1593525696-12570-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: YTOPR0101CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::43) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YTOPR0101CA0066.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend Transport; Tue, 7 Jul 2020 16:34:28 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jsqY7-005nNl-8Y; Tue, 07 Jul 2020 13:34:27 -0300
X-Originating-IP: [206.223.160.26]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caacc38b-b683-49fe-54ec-08d822939e60
X-MS-TrafficTypeDiagnostic: DM6PR12MB2812:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2812F1BB70A77B1CADFB5A3AC2660@DM6PR12MB2812.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0457F11EAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IBjGrnb8oc/iRU0gYJt9wG3CYa23pYk5PGNCb6LroGC+N8e/KdhZN3h7FkOdrUaD9BrwWhQL2qix8YqSm9zKMJsQr6qIbK3t8RV/MDiHInD8e3B5Fy5nCpmivZAmhPi/I8OamNPBIHMdTEShQLo/Vz1DUf0zVk8GbKH5jgxglhG8QKwTx9ce9eSM7ESSlPqVKQi0rmHaX39PKoOZccP1Rh9f4CkJsn4NnAXsrmWpcEaPFLut1EQxzV3O4sxaLfJr5Pqi7F67NyqgpWRDySPvz+xbt4x91t28e35lCT84CVahHr6Vny99LsmGZF73tis8D2fgOPOqpYA//4ogm2W7vlJ7su1+cpd4qSmXLEs2z5amSrxUNHz3yyQT3h2yy47v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(316002)(4326008)(66946007)(66476007)(66556008)(1076003)(4744005)(2616005)(6916009)(2906002)(86362001)(5660300002)(36756003)(186003)(426003)(33656002)(26005)(8936002)(478600001)(9746002)(83380400001)(9786002)(8676002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: z879joSGjGfA3H7oS8/Owk1Sg8CdBTxJUykDWNKXaOKErOzHizJEHl7nyXdqnfIcnpk06DA2F/xxqUhtNQLBoohQDaIRoUKv9kTfa3ld0o2PRJNUwqpym1jbLJzJLo0Uy/Lnqj7JWbOank0iP3zpctWErbit7IWIlP/WzCHp72yC02HBFgjwSrI6+IbNtZbeV1odlZQr7sDEkc2IFXhnGCHVOyZuN3YFZJhN+XuEdxpjobOuwgv6d1shP/n5NXisdiqOEkLus0p4klNOVABAZb/Fgiiy6XBPUVHujlEeUmy1JqbwAI6B8wus7u4UUTARSwpQqMBf/vV7/SpmKFEksyz9/etkQ3ziQM8iU55ZRyVo8a+NG/rF5eLn6TNXrXFDr28ckXelnCHe+UaNicvmQ8YoHUygJgAyUcfWKIOjCL3AMW2VAS7fBggB5QClMS/ZIykZFCBXU/be7awACyJONjr0mllJNYGUnGaauzZKxT16C6kfj/CvUyfLyaawu4bw
X-MS-Exchange-CrossTenant-Network-Message-Id: caacc38b-b683-49fe-54ec-08d822939e60
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 16:34:28.7224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CMaA3eP8IO3kKqEirH9kh14us9XJsflgF7xhOAR3AuRNqnwIvcp9QGaNRdVdHD2r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2812
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594139565; bh=TxIGymIQJX7OYAA0wDvL7BtvAHloIpSjlzU6qzK+lMM=;
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
        b=J/yK+N+ToZrZ7BGH57sjylrJOyCCUDSMzGvZnikOnhsfWsTCNsjCAf1aCOFM01ZEC
         10JVKlFmjEQKx7u0xEKjT1VFYtPgiutp1V7bISt4nJjepqpV1ILC2eQ+LQJcMzkfMd
         qcxv+dOq4Wyf0YT+GFLhCMAQGmHC5Klq0tAPErdgSsVfbtUSUGuq/dN+BLlarMMU8R
         oRI+amwuE7ltTWc2BDSD5RtwmOF1V8cyKhyYXJsriNr4igQAS7pEqXCy8Fr6jPzZRf
         aHn9OJtC4y4MYfUfUEiwGoeJcM36/4wisMXEWZlv5USivlysH1Ysl5t/116MU5nAGY
         PUckJ+dGBLqwQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 30, 2020 at 10:01:36PM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
> 
> If hns ROCEE is set to level-0 addressing, the length of the entire buffer
> can be used as the page size. The driver needn't to split the buffer into
> small units because all pages are continuous.
> 
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h |  20 +--
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c  |   7 +-
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  |  44 +-----
>  drivers/infiniband/hw/hns/hns_roce_mr.c     | 208 +++++++++++++++++-----------
>  4 files changed, 147 insertions(+), 132 deletions(-)

Applied to for-next, thanks

Jason
