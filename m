Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483C5257C40
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Aug 2020 17:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgHaP0T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 31 Aug 2020 11:26:19 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:12412 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgHaP0S (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 31 Aug 2020 11:26:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4d166c0002>; Mon, 31 Aug 2020 08:25:32 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 31 Aug 2020 08:26:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 31 Aug 2020 08:26:18 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 15:26:17 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 31 Aug 2020 15:26:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRcdxMpJeyP42Hjc/lcdq34bgF8A8polsMatTnsEwCn/FCF3ujhUYVMucpDjxj3LdZppMRVaLb3AIHa1+xlQIX1cayqrXe3TmeE/714h0rzYQqhNh70IFMbcAWS1BMzwN4VRBHE2P+rTxJBPMWvH3lnR4UBp8RHB5f9YOcVbNQOrycOp3J1/OE/NyqBWjQwHdp50Uim2VetRRImMveeLFZDgi1qtC5nG1/pBN8wkF5Fc1Bwrjflk+dJeAs+4gM6s5cE1qUIo4SR5aA1t9rlYgEBBryZp5Ncyk8xEJhiL69ayeyeYfCsaghYKr9Khh9ha+PIlbmHsZYXgcCW+A+G4yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LXq5ROE/+VCwRqrfMD1XsnMrSn6yb05ptiYu+bI3lD8=;
 b=geeOp3t0tF2WqLM+YoLyjwfSrwu2O4F5/kBJkyw0V9P96UxJhLf/1xhyvCxl873g6o0/4rTePx7ADnxELZD0YaU7mGC9jX9V6YpOjamNWfXJmwU43WfbD7UrTe3KTxoPb9ruZn/j7/CQNgDK4lcqZHxY6XVHgMQ0yq2exoC6xApI8hRTkxx7m+m7tjy9lV531CQ+jONuzcUOsH9qHS5udZNfDYF8Z21k8oCtqz5U+/eSWiRPl6eVW/4hV3p26GsOMZ4YJ3zYZ9wqJNUWinapBj3GCxXj1gKtJpf7UqgzvYWJLejVFp+4eKtDTGOW9v18QbKqeJTcR9S/tLJ+XNb2Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2940.namprd12.prod.outlook.com (2603:10b6:5:15f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 31 Aug
 2020 15:26:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 15:26:16 +0000
Date:   Mon, 31 Aug 2020 12:26:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     <linux-rdma@vger.kernel.org>
CC:     Gal Pressman <galpress@amazon.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: Re: [PATCH] RDMA/core: Trigger a WARN_ON if the driver causes
 uobjects to become leaked
Message-ID: <20200831152615.GB628533@nvidia.com>
References: <0-v1-b1e0ed400ba9+f7-warn_destroy_ufile_hw_jgg@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0-v1-b1e0ed400ba9+f7-warn_destroy_ufile_hw_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:208:d4::33) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR04CA0020.namprd04.prod.outlook.com (2603:10b6:208:d4::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 15:26:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kClhH-002dWo-Cp; Mon, 31 Aug 2020 12:26:15 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2c75343-cf0a-4b3a-f3d2-08d84dc233fc
X-MS-TrafficTypeDiagnostic: DM6PR12MB2940:
X-Microsoft-Antispam-PRVS: <DM6PR12MB294013195357F798DB6FCFF8C2510@DM6PR12MB2940.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8WpMloFPWKJvEHQ+AYaHguro6XWb+5gSMMqzkt0HW/+2wyUQ+rocJACvNwOAf4RqhgpW/3bVHJNqAOTfR37IyVfTduURkXZLqC9fxqPEF/fi1Wpc31LVooGAk1eGD9D7s3uN/nZ0h7JwqeS9jvEfJn31PVNw0/NWEkcQkffJj0fe2rMRRRwCj/PPcGe4MhUyzKjOkha2V/Pcsv9cHB5ggvjqg3YY7vjp9kusFCYgdxPPUjjtubtD5RIYMarFlEr6dQeJZYJMRWGFcfcn78+c7MbDSfSCNAxPRKXDBIi3PuhX1j/c1IR2OrK79JbTIov7/Lx3aYoIH3QZOCDHrE+WJadjVdlGzkqmdHtrDFc7aoPH29zPErxIq3JZKOSdtb40
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(26005)(107886003)(2906002)(5660300002)(36756003)(86362001)(478600001)(6916009)(8676002)(1076003)(54906003)(33656002)(4326008)(2616005)(426003)(316002)(8936002)(66556008)(66476007)(66946007)(4744005)(83380400001)(186003)(9746002)(9786002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 7LFtBfDKwAA/6psq+1rTZopKVETtVYOf9IhGXItRmPMFL3xtMoHZYZL83Sxq0j+vUD5kH5/pGvNCxWY0tziAU8rByWY5OIIe9LgKdhiNlX29QKPTEMLKdElyJslCQwJmDQ79vXrfAsFFQv3SScZYHt/m8Gk9vxw7Nu1xVNbYczLpj3LBSpwtpXZzMWFfS3m2AxdE4umbX5nxfOsmDUmsDFEgGuvnkvR3TZ5canV66W/GLrPm3ED78CBzusZ1U5lrfwrnQ6EChxeYcp3t9eA9uX7sVDZARl+4bKGTtshqi5Kh+vOBbsQdiwa1oJ5YKDu6+ceoJOg/Czls1iZtrnle5MXdj7A9u6tUj5Y8iH7yPCO8hx3B0ai8B6f/AlRtk5MZsW3YsTEifjTdbJ253lXSOAD/RpOL3vwwR6MU1LGcfabLoApxoB3nBcDVt3+x5ku/h+zXmV/q2MjFzZNg6wbo5F4JaanQ6kPr7Y5G2u2ANEzmy3VW0b7/hHP2pF9Ow6NXUU8XuXMbe167qPxa4Sx4TVlRd2WXZJUvv0bPzqI+1cqPcKB6h0EYkDEbxHbM/HYcj1xt5EaPvKFvBcMu6ytSJSqpbK93lZSLHT3RHvd8jf+pF7oZMPr1x8k/LgDU3BuN/KAOrTuEoBKUZ6oRO/0ynA==
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c75343-cf0a-4b3a-f3d2-08d84dc233fc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 15:26:16.7223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ekrgvh09kFQo1O1ZlmrHQ3E8tpleai8jKaB+bqHwIx5xX1zAM7xw6hcVM5Jwrsm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2940
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598887532; bh=LXq5ROE/+VCwRqrfMD1XsnMrSn6yb05ptiYu+bI3lD8=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Exchange-Transport-Forked:X-MS-Oob-TLC-OOBClassifiers:
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
        b=QIrZkatLmgnmDucTzHVAdajl6NDQMa5GQrRTDCHaBq88b/yWBDPv8co0QAtkSM5kl
         YJXqV/pSzmZWCsEHATdXkM+KaX4wBUBkWIUddVevvqunHeieh7Bw6vjn4ng4gh26fu
         qPI3t3ORgIJeXkmmKvgmCba2qFiFHC4hYuacjSh2UmfolNm+dP0wkSjG+gU7GGDWj4
         J9FbXbi511n/2nuENxDl7RAl2qXNxbVRQUWMTlbDT0P/wxryvh0aRZHzYuKP7QfDZM
         zf/o7GPPU4hQvgQK8AQkkrfOSH0RbI21+lK+H8O0KYw9GIy2NAo9qm3y31iFV8ywr8
         UK+KrEhttdk1g==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 25, 2020 at 01:35:38PM -0300, Jason Gunthorpe wrote:
> Drivers that fail destroy can cause uverbs to leak uobjects. Drivers are
> required to always eventually destroy their ubojects, so trigger a WARN_ON
> to detect this driver bug.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Gal Pressman <galpress@amazon.com>
> ---
>  drivers/infiniband/core/rdma_core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Applied to for-next

Jason
