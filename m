Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71BA212B3D
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2020 19:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgGBR3R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jul 2020 13:29:17 -0400
Received: from nat-hk.nvidia.com ([203.18.50.4]:35042 "EHLO nat-hk.nvidia.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726931AbgGBR3R (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Jul 2020 13:29:17 -0400
Received: from hkpgpgate102.nvidia.com (Not Verified[10.18.92.100]) by nat-hk.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efe19690000>; Fri, 03 Jul 2020 01:29:13 +0800
Received: from HKMAIL101.nvidia.com ([10.18.16.10])
  by hkpgpgate102.nvidia.com (PGP Universal service);
  Thu, 02 Jul 2020 10:29:13 -0700
X-PGP-Universal: processed;
        by hkpgpgate102.nvidia.com on Thu, 02 Jul 2020 10:29:13 -0700
Received: from HKMAIL103.nvidia.com (10.18.16.12) by HKMAIL101.nvidia.com
 (10.18.16.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 2 Jul
 2020 17:29:13 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.51) by
 HKMAIL103.nvidia.com (10.18.16.12) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 2 Jul 2020 17:29:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bP3eRRX7r02wLKIzUXthdymVqs+QdtqLl5K6pa03/SNKEPKYA6GEHu4Un62hGXMyJTxgFDPDwkMO5B2csN5AYluTmZZZo9ERuJZ8aBGH//HWGx+nUwC1rN3uxGUSjZ0Bf7hqK2ILbWZwHDoU6GCS6FuLntspT2Ta4WZEWU8r0Xlhl7bN5Dtp94nXG9IUm0lt+vmBB0+stzdGU/PqGUnIb2YxNfWbboBt1giJpcL19tHYESAkF7asNdaBy92Sp0/2I/EdwreHTiomCn1BueSDuwHJIbsgrIvphX9kHEHMOhY/z7/uBxBUW9gCkUkYEB2GvlZpdkqmzxNC1gMASk+9Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYB7ohjJ23HoYD0X1ILi39xe//534eR/Gq3myQ9zowE=;
 b=KzCfWBMMhL863WM0acuKUzNUR+6wB0Wv7IX+B3iCX+er3G1kN382phNQYpI6vx/ZEt5X/yLb3mE/T8FvhlIVmMflxa8p9yVUmvQdGhjDNr0y4IMlyp1DoIO5bFVo65MNrcW+QMbqTysHeYO30YU+titY3I1c+OLqCiTJQ42DyBiOeaHkgtT2PgAGQ4yOxF2lrmM0wHybGrGmb+WuorxNCk8dgOX7mTK0l6yuGOqYV1CwtOEa7lP+WR7OwLAgBz24L7O1GU2J1TjNNW3+9p1MYh9R5j4VmVH0JadnAzgdMbY45t7Y7fl9s++iQw1rueNxmQP38u8oc6F8U0cCHpmhsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2809.namprd12.prod.outlook.com (2603:10b6:5:4a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Thu, 2 Jul
 2020 17:29:11 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1d53:7cb4:c3d7:2b54%6]) with mapi id 15.20.3153.027; Thu, 2 Jul 2020
 17:29:11 +0000
Date:   Thu, 2 Jul 2020 14:29:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     Hillf Danton <hdanton@sina.com>,
        <syzbot+4088ed905e4ae2b0e13b@syzkaller.appspotmail.com>
Subject: Re: [PATCH] RDMA/core: Fix bogus WARN_ON during
 ib_unregister_device_queued()
Message-ID: <20200702172905.GA719475@nvidia.com>
References: <0-v1-a36d512e0a99+762-syz_dealloc_driver_jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v1-a36d512e0a99+762-syz_dealloc_driver_jgg@nvidia.com>
X-ClientProxiedBy: BL0PR01CA0032.prod.exchangelabs.com (2603:10b6:208:71::45)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by BL0PR01CA0032.prod.exchangelabs.com (2603:10b6:208:71::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23 via Frontend Transport; Thu, 2 Jul 2020 17:29:11 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jr31F-0031B4-VL; Thu, 02 Jul 2020 14:29:05 -0300
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 898f6406-2e67-4496-0df7-08d81ead6ed3
X-MS-TrafficTypeDiagnostic: DM6PR12MB2809:
X-Microsoft-Antispam-PRVS: <DM6PR12MB28094F20DFF90A0F041E6EB6C26D0@DM6PR12MB2809.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GGtKTSpzVi7U1249VD+NPt0YSGOPHn8G1CzEtN2Fs6IxJ2ECmrGSGaL4KCA6c/pG0QRbqeRfobIJf2G70Ll9HvU7QJ3t/xHwAJGOOKkHL7k2O/tUgXlp5qR6OGhANoaa+KgcEVKEwGyZVn1PlDVXSR6oulR35ladKpvIPJsLTmDbqzbc5W692OhQCMPEEc/h2SQM6NoFu9Ws77K2mk8knXW1H+AMWq4vCpKmqF8luvSNRGEBN3Cxn8wkFmS0w3tuMSHGwmInRNvC6zqSnMfojwh+iaqPoWWO5NpA7v1XSQHtdKx+nmsMlalB11gszgxGsCc0bAKsLJ+WqcsqYBhDeo7/h9vcUaS3qCA/H4aTOn7IFymzQzR5wMnXCC0O19oE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(1076003)(66946007)(478600001)(83380400001)(9786002)(66476007)(26005)(8676002)(316002)(9746002)(66556008)(2906002)(6916009)(426003)(186003)(86362001)(5660300002)(36756003)(2616005)(4326008)(8936002)(33656002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: c2gUbUGO3G99mnODckhkUhDcymxxDcLPq5Pg0pzSkPzUaPVtK0vvJWrlazeihdBSu1qgdYakEr/bvvbELrhgZ2AAbTnZ+BXxcCWpkZbcAknAVS8H06QI6QTe1DKRmDAJ+lmyOA+ZjN6tf+oriVRHrQXXld0LWLJaQikBcYZkrbmhyeuhjq8+NhCBE8GVWy9372qc5coY4MvQYxiulhDygLvYE7op+kTVs1IvueO9vhH5Nnx5BKCEQ4GWSN1JETcMju+2ilmtvVou2hn9BmIB+tIvQtnySvXPPDMPrkocQMggJXd1yG/LlTudyKVGGv2DRj9oU6VwV91qQKjvjQqjz5LEDw0kiyfCr7kylgqjgjmTMiPUUlFF123HodvlrM9UqhCj5fhI+3uaI0asPF2lAL8OZSjSbvteK+Q1olGZprON9167tgmYgkk/LRPF/qH3Z2UreAmaCJEaAbC3m/AD8Jjo/HxwsfdUca41UvoPC37Ldddsw1x7VQ7toC49qYs0
X-MS-Exchange-CrossTenant-Network-Message-Id: 898f6406-2e67-4496-0df7-08d81ead6ed3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 17:29:11.2035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Dd0EUWS4aLRUqdUqw8qGW6jQsobNNAakKeiaMS6G2m8c6/Rbr4RxOX/XLVtK5Lz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2809
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593710953; bh=bYB7ohjJ23HoYD0X1ILi39xe//534eR/Gq3myQ9zowE=;
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
        b=CGFOpztF05/dr1oCIAeGVyRG7JCMBS+Us3iedWUzBe5YLcB1CpUWnxHttX35O0k79
         j8noZcvcWMiV0jfjnOj8wA+4RhE9fvY/RInGNN6fcbFtBp66gMkZtt/S7LeGFhhlmA
         J+Ru79chJyjjUnnFK6docKw2urvPgPukaYed/9xLEG8b40PNIdyDY1AVspeuq0XRPD
         /Kp0x6JOEq/cOv+mv/0qfTzIEbIOGBlh73iUJ8rucey/s5zLsvV6xjfJJwRJBWHf55
         93wmiNCxnzNmsrwxTOGWnUGg58alBelI6iQSGn4FacQp3xMCOqQd32E9AC2F4P3S7I
         lS6lOwf8JDI2w==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jun 26, 2020 at 02:49:10PM -0300, Jason Gunthorpe wrote:
> ib_unregister_device_queued() can only be used by drivers using the new
> dealloc_device callback flow, and it has a safety WARN_ON to ensure
> drivers are using it properly.
> 
> However, if unregister and register are raced there is a special
> destruction path that maintains the uniform error h andling semantic of
> 'caller does ib_dealloc_device() on failure'. This requires disabling the
> dealloc_device callback which triggers the WARN_ON.
> 
> Instead of using NULL to disable the callback use a special function
> pointer so the WARN_ON does not trigger.
> 
> Reported-by: syzbot+4088ed905e4ae2b0e13b@syzkaller.appspotmail.com
> Suggested-by: Hillf Danton <hdanton@sina.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/core/device.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> As outlined by Hillf, seems like it is OK.

Applied to for-next

Jason
