Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B35135D056
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Apr 2021 20:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244938AbhDLS26 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 12 Apr 2021 14:28:58 -0400
Received: from mail-dm6nam12on2068.outbound.protection.outlook.com ([40.107.243.68]:35852
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236853AbhDLS25 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 12 Apr 2021 14:28:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVkOr8ZCLnCc6s/2NCZ9WrvX2HkWMfhjynH0KwjN7wY/MgaGb9eQRy6zMR1R+uFl28xqrVd4F4QffocfwqtRSIYbuG8b931Pcxcm1i5i11LpkY1ScOHOLtoQAySXITjLgzrzysx8LDaW+UTJ/R9mZL95686BJS9JvK59Pd7BbJtZpSxUmcV/JAGXgs0Q+Pqi0frbQ48Ou0+mD0wOArdBBs9A5zqKGXzTzOAAprEsSOl56iA9vIC8cbs1TCWKf6D7FMZCq3FDXyGjdvHlH+tBGVOjmJgbPAdnQagY1TRe5KfALJ3hcILSXzBiNCKpjnRmn1luQxnjOeTjRA0+viu0Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1op1aNTpji9NBytVppL6zYH+69bJpCTtN9jn2UNDuI=;
 b=WIDfjCCrDsud3Tm9McMdqy9WUfuc69G7Tpwg8iB0zgw3II6gHIwmxDwWz5GHS1A6vlH7aTerAIuAkj+RBpYzyo7BWMqgBHlZJFAMV4TrNhtR7UG6y97dBvXFM49PuDGhtelcZab8yS7XCUECAfVgMaX5uT+2QTYIf53wQXJs41siHHCKlHbRTxucaWaMT8rC/bjS+2wg68QQF0Zlzh4lyYVJLjzFUN32Kbbg5TQ4sBwMpb3fWvtCX3RLn0KmkrNAbzWUvKb2BpwNClESZ0hhcc6kpbtuu5GpRCmvosw4JUaxGVZJAgW93vulA6k3ip+Fe7H1zLa4riFr+wzbJlGI1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1op1aNTpji9NBytVppL6zYH+69bJpCTtN9jn2UNDuI=;
 b=laiZOWwwpi2GdiGtLHfLs7be/ZXvYOuhPehUdZbjSPDCiSDIxuZ5g95qfnbj5SIWACkIwOY6Qj+YR17K1s0b4/ofdcEZN8XHqdoM4Ifh/OxkdTVJm4ClR7sruJEFgxj6ZGiL76lIyhP9d+Kbkj+757uj2eQjUe0WwNUApenkCoW0QjeIgo5GDvmB3ISL1/ngOWcMHC/OUphP0QtmIyPcND4qlI+yqGGKlgRMENhdH+djEIGDiymvlkIf4Bp/acRairAoywf9pJLtIEMrF2uBSaQmgIYA0meP2rckpuLNVj2+s7kIc08fMVHgxl6w22qkPbS+mhUDBEz5CStPpciXTg==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1881.namprd12.prod.outlook.com (2603:10b6:3:10f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Mon, 12 Apr
 2021 18:28:38 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 18:28:38 +0000
Date:   Mon, 12 Apr 2021 15:28:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wang Wensheng <wangwensheng4@huawei.com>
Cc:     selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com,
        nareshkumar.pbs@broadcom.com, dledford@redhat.com,
        eddie.wai@broadcom.com, leon@kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        rui.xiang@huawei.com
Subject: Re: [PATCH -next] RDMA/bnxt_re: Fix error return code in
 bnxt_qplib_cq_process_terminal()
Message-ID: <20210412182837.GB1158895@nvidia.com>
References: <20210408113137.97202-1-wangwensheng4@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408113137.97202-1-wangwensheng4@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0192.namprd13.prod.outlook.com
 (2603:10b6:208:2be::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0192.namprd13.prod.outlook.com (2603:10b6:208:2be::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.8 via Frontend Transport; Mon, 12 Apr 2021 18:28:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lW1Ib-004rUr-28; Mon, 12 Apr 2021 15:28:37 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b18b8b0-f45c-4199-ea4e-08d8fde0ca6e
X-MS-TrafficTypeDiagnostic: DM5PR12MB1881:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1881DF46A9D50F5895D92C15C2709@DM5PR12MB1881.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 57d1ydqoBvulA8dKx8JoEDyhQscbPpOTFTfvn3bTIDc09/KWQ+lIENh7pa4AxNfir5/uUtXsVM6ys8EhjykkktFlK8m7DdVvdexCh4psINUdv1QzZoOsN05AsxTtcfHBPEZH5sWs8ycf4PpnDhYZKO66Qxf0UpYpDawnLG7Ag2MwBmREfPEztQa0S2NvxqTcf1eiBCRpSsHJN9DYLkow2bh6XUjIYNa+jZy4WTG8RuWzWQGkVSbJLn8hqhsL7SWECoM4QEC97YpQNii+eS6xY8jrEpoCROwREGSvVr2MNp7MLzT1ggIYALLoB0Ie4Wj/67y8WIhjnEnewJzbA5/YG8iQj47ID+NNtpZP056vQDF/dMp/AtMJ7H6HJVffDQj3yTmouby/GsUtd1HylZoRcHfQylwaXKtqjlkirUzGImHoE6RvviHeUlBdJ+qZjFprVCNyw3mMfaQToGWXDP/L2arI7U2xoXM6bAg8kkLwXIg3qyhLRhjg/B6Jg3AXzTe/yZL+JmMO2EUpE0hURyc1XRocXkTq6iZpd0BjZuP9p6RenV0ZO0iDzfoZ1vjJp2RB1t4GgPYiGTOPW2zsxC4RUnyg953bn4uIB6wuBc8rnMU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(33656002)(478600001)(4744005)(9746002)(9786002)(2616005)(66476007)(2906002)(26005)(36756003)(8936002)(186003)(86362001)(4326008)(426003)(5660300002)(66556008)(38100700002)(6916009)(316002)(7416002)(8676002)(66946007)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mkMuFedSOhhGZn7wZhUq+2Su4DPIoilIRFylAkswI/JsZeZ865FjXmZVySmk?=
 =?us-ascii?Q?kaKhGc1/AxMdRmJ5ElMAJIAeoSh4DPy3KWJUkesSmRbzZcAov51j5nhQxnWv?=
 =?us-ascii?Q?XnHP91DkhGUbLpG8MAe1DvJHCOZxCySaditNipOBI9yhhvDTp9rNfZUqOtrb?=
 =?us-ascii?Q?CK6pV/Y9aJI1Q5qtZ8/3b08WYSnNnD1+tcvzgIstG/ayD1liIOUZgBqXVkV/?=
 =?us-ascii?Q?7NlgrU51kwDMCCJiPCMjcze8FYmTc+uhbnd+5SDWAP3SfvjEAyjB+wwZYZu0?=
 =?us-ascii?Q?AIBuyQSVAIeAPtTq9BSnlXZv79KRZQZi2hCSiFCj9ypiYCa2ht7368KQTfYz?=
 =?us-ascii?Q?2Isf8r6yQGAGMH14K7Lwnmx4r8z+5EcKWlFdd0QgNBZJL76q32AXgbLK6rnr?=
 =?us-ascii?Q?ULW4UNn2rG5Fqh26V+V5QB/rD514OUrq15wgPkstX9dnCSHtRfzWITw268Gp?=
 =?us-ascii?Q?D+gmBBFVkgPfIAoZV1pN6vAnsXgixC+xd+YBIhwLheL5TfQ8U2x1N3SaK5TB?=
 =?us-ascii?Q?4qnynYgW3Vp1MEOzcA9PkZKLuo0/NyHrhWt3S10+89apeYblvjyR/i/xnCv6?=
 =?us-ascii?Q?C51y2kSHdQc/ZQqIpzBulYs8Xy5e87PW6r0MKrQL783AJ16WMPukqHrkWjZJ?=
 =?us-ascii?Q?TMjRXZL031iu8UvF8Z8i9/p5hz905URhry/d1Ayg3JWsOANd6G/KJZJjY81Y?=
 =?us-ascii?Q?PkfPEutsIcIuusIEwKzKbtEWa8f7dnrjWQxeFwbhRgB1ZQ53zGb6tFM1x9x1?=
 =?us-ascii?Q?TweZk7ohxwp3w5/HgvuzNFkeKJiRBGgor+BN/0K/8jHKec2J5GhlEbt4zUAc?=
 =?us-ascii?Q?38/o/9ar2V0gYhBLFWLg+HpIDeWAuI7LEuUGY6Za0kQXKJ66Fj/baCjOcjAO?=
 =?us-ascii?Q?ZZJBTuVvCi6hZ4Upyiy9oxjxkzouKFUVk9lg8vbGETg1u6ECv5RN7ODExHO+?=
 =?us-ascii?Q?zwuGjLQ+JepFDZORoRsgiOtyQqGzAo/Z/JpoSBlxciJVsRKvLRGvhYkqOBpe?=
 =?us-ascii?Q?ms19H/o1sUj07Ka0QA45fTlmjo9BjvL3imCr70nknq/QzkTsl6L8GdS3/JYS?=
 =?us-ascii?Q?mKz1q6MPPdOPd4Zx6cjj4Fi4QAQ0zw2lNA4PamxJ2HP0RefTMcZ+RLqPBt3I?=
 =?us-ascii?Q?ZGZBY9/WoKah7+lJnw7JjwSQibbX/NqS/LmETDI2tiPVRQxmG2WSqQ0qj49E?=
 =?us-ascii?Q?ODdcqjpkF6G9tSiMhZrXbPTKfoDwlVYaPBDmjY+f3ENmvhNTCuTBelHjrjqg?=
 =?us-ascii?Q?HKI/A+BDsXxdDq2hjl7y2LiSwIn3gsNoi0fgI5K5pmq1rpFB6WjvetqewYgS?=
 =?us-ascii?Q?B/ajq6cH+8hz/vG/mgA0Yfjid6IqqpT30qTFu4Jjtb7j3w=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b18b8b0-f45c-4199-ea4e-08d8fde0ca6e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 18:28:38.6201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YDFs5MHJC+B1hpcOifxOHDWG2sMn4+mD6rsSpiEAnQcJE5Rcbh51R5DcXID22M+N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1881
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 08, 2021 at 11:31:37AM +0000, Wang Wensheng wrote:
> Fix to return a negative error code from the error handling
> case instead of 0, as done elsewhere in this function.
> 
> Fixes: 1ac5a4047975 ("RDMA/bnxt_re: Add bnxt_re RoCE driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-next, thanks

Jason
