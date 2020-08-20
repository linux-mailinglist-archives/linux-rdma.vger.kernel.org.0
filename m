Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B1124B9C9
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Aug 2020 13:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgHTLzE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Aug 2020 07:55:04 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1416 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730968AbgHTLsT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Aug 2020 07:48:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3e62c20000>; Thu, 20 Aug 2020 04:47:14 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 20 Aug 2020 04:48:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 20 Aug 2020 04:48:13 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 20 Aug
 2020 11:48:10 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.51) by
 HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Thu, 20 Aug 2020 11:48:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+lXiehddlox+b1mpXeLERXVKNxFgGBt71PyIcyrSUi8eoNaU8GVf2BtaT6aID5n2LP1wruYx8aOkIjX7Z/ocyx2L2zcsTsb4JULg3KCLF1Wxp9M6g+bKILJdnznSTNla2v1RKGLDeOenhWsBHudLAbayW2ZalHg/nsjIPr5eALI1dPEHAmi99cYtW71dueIlQZV22jP9LVBwZBfx8EypjNcJsN3FizK0+mwYtAGGDDKWoAL/IDpldxcAdgxLYa6pAlDV6HOexjJ6mpdryW6s8PlLKA0EXNSrkgfkdsuFEiKQ08oSFlJoJeWmtXiC12JNkuh172MhyvC1qq0dgT7WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fC+/7c/DcpudtWtoa4gk7DswkAiNsJSzGiBIRxaiWXc=;
 b=ncs8GCVAYZwfVGRUj/bhm8RpQYG7Tlz31IFhyDZTW0Xfpf29EdeN8Sn/qDiWdY/KggNwwmbg2/tXdRZ2x0A8eDdfsXPVzZBrKFRrb+VRkqgCGpCg0OqozUUxCLDYQyohDFFx5x7+LkTcE4bCZ0xxvJnedbQ0lFS8Mn0ufn6PQpFmWhlH7NFgo/6x58i2RJQD1pO0K3zxZ8JgkujXZs9pRROFQt3ZftvZ7O9HQD3c5Bm6ea0CzF/MTDwY8uQhdD5R9a2bz+0yH11mmZbN9s+16fCh0/iixhuniROsj9b160/gQvT4dgYEn2UJ/WD/Z8vLsvYHy0fIWnGR6YvEGsTeZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3211.namprd12.prod.outlook.com (2603:10b6:5:15c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Thu, 20 Aug
 2020 11:48:09 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.025; Thu, 20 Aug 2020
 11:48:09 +0000
Date:   Thu, 20 Aug 2020 08:48:07 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH for-rc] Revert "RDMA/hns: Reserve one sge in order to
 avoid local length error"
Message-ID: <20200820114807.GA2357512@nvidia.com>
References: <1597829984-20223-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1597829984-20223-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: BL1PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:208:257::11) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL1PR13CA0036.namprd13.prod.outlook.com (2603:10b6:208:257::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.10 via Frontend Transport; Thu, 20 Aug 2020 11:48:09 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k8j39-009tIy-Dx; Thu, 20 Aug 2020 08:48:07 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54fc4292-d10e-4e87-30c1-08d844fee8e3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3211:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3211A28C5A5BBFA5F840D70DC25A0@DM6PR12MB3211.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kDb/rn/35LXC7qBBc9hohdr+LnQKBIrHT+LM3GjxXUm+TGr02ByLH52t6F4ywUloF2LUogiOW4IqvOlkkxVXOs88B3QTr44XBOIv/Ym94NejGhKqLL1NFzsjZagywahf8q6xhr+tusyUVw5cR2Is+/vAIqy+0NSTabkk2UzXftkZUzIVw3GUtXFokws6s1Kr7Gxmmr1214SlWfsXmJiVpvXtZzDMQGaf+ELgCj2Rf+JOfm1QboT9ZasYyys0C6jnIF17t9uM8Meu1iLQWh1s2sIsygG0NceCw0Q+BdozFxZQfyvCxUuWFc38/xvoq6JD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(66946007)(8936002)(2616005)(66476007)(1076003)(4326008)(478600001)(9786002)(66556008)(9746002)(36756003)(2906002)(86362001)(5660300002)(426003)(26005)(316002)(4744005)(33656002)(83380400001)(186003)(6916009)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: suPmb/wjnkoEcP3RteaGuonKQPCFYrZQjy8Gh5Fxgzi/fcJBDkBO0xbI6WY14zc2FrUx6yOApAWNTiBIXJKAR1Lr+ZsuGmjlOzOGVXBHR0zi/Zb5J/io8bUt11gr/yab6+cM8quH3Dw/lmt5bu2TG5Y1hJLQoaF/k+w7wPNoR7t8e8iCUa2FKjsiG2TqMONyWQDGBzpNSAZ8q+5QCXmAf8SV5wjfJcneEXbzRAB3FvJODR9Lu+k6CpPQc3yEaqo9NEkPoUwmG0Sdvd16cVEWnqt0kYPhM9uZOk35M62+lznWkpdzDHa9L1RS7nVcdosTTueZdUhEDsQEGoZwLqnjDpToojGl0xVES+cQ1Ps8Eonkwz6oPOtpGTK4MCZgCaDDJsuP2y77vIYtIMIdNgP5Kt2fbqFL4tx7cnN5pOEdTZkoLc73717gb3ESZmp4NcHZU/1AD1ud6xMhff77fsZSiB47nNKZxqd8TGKNNmnAd88GkHOTn4UAWq75J3r4Zz6eSikJHOGKJoho0SQl42xIOGeara1RnXvkwQfGDdVe6vZYf4Z7CL46JaqbKGzRoBUtQe2kk95NMCEy1ugj5Et6RYKwkM2ZCTccncwBNiADzJpogjy+Cbl44lhFMc65L8sqcivFDQmDvdjXQDtfGei8VA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fc4292-d10e-4e87-30c1-08d844fee8e3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 11:48:09.5538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CzV0tdKJv2z41Jsph7OlIUSMszMW0pIp4s/43QU1LhbUsdHZrP/9EMglG99+BUbv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3211
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597924034; bh=fC+/7c/DcpudtWtoa4gk7DswkAiNsJSzGiBIRxaiWXc=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=GJTbRI1aTY52YnYr7brgs1rCpgUIJ6wxgocLK+za5zLWXs91YViHF1NIhh0y3O/Lz
         diXf7bI2mBO4pZFMmLqksCO97HeOMVpXXPRaSzaZJvO0ep8TnRgSKjRwYxcIDryV8w
         9ZtzPYcJQogi8HGBCeTUMizvQuRBmQa/FeICb8KhcrcDon4/FqjdNx81YjUThuGGUz
         4SI3YCMDsGCkrKURPql7LYnC2u7lL4mCvg2NmybhQsg6/KzTxsKZE3EZ90pFvIP0yu
         deW3Cfkky75G/JuduM3tLBNOMkQiOPhwes6RiFyTpCr8Q1vKIUDFbg82MrqU5zvzFs
         P/YQHkx1KZDWg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 19, 2020 at 05:39:44PM +0800, Weihang Li wrote:
> This patch caused some issues on SEND operation, and it should be reverted
> to make the drivers work correctly. There will be a better solution that
> has been tested carefully to solve the original problem.
> 
> This reverts commit 711195e57d341e58133d92cf8aaab1db24e4768d.
> 
> Fixes: 711195e57d34 ("RDMA/hns: Reserve one sge in order to avoid local length error")
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_device.h | 2 --
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 9 ++++-----
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  | 4 +---
>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 5 ++---
>  drivers/infiniband/hw/hns/hns_roce_srq.c    | 2 +-
>  5 files changed, 8 insertions(+), 14 deletions(-)

Applied to for-rc, thanks

Jason
