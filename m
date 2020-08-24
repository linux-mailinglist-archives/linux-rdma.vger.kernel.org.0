Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEB7250588
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Aug 2020 19:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgHXRRL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Aug 2020 13:17:11 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:3814 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgHXRQ4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 24 Aug 2020 13:16:56 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f43f5ca0000>; Mon, 24 Aug 2020 10:15:54 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 24 Aug 2020 10:16:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 24 Aug 2020 10:16:55 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 24 Aug
 2020 17:16:51 +0000
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.50) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 24 Aug 2020 17:16:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YKlgBrCD/iqHEPpsVVPvapzvMa2Z7XE/0a+gLyvcmtaLwxVT76HdH/EPTFhWPBtyT4+2Rn7JHPeIGWywWCXls32qmBwZpXm/LIGdQXmrKCdwul0RzFGbBdrNAhRcFk95MovQn6MwQpNatRQlH8z+4farGEGytnwVxSqvuWZEqlJnPJRlLR72TCLjrB4afJ0yXrnQB3LsH9jqEbVDl/5gETofkBuEOouDK5xDCCuFkypM9NfVDQVt8rDE24kOHlp2sxw+f1QnnN6QpCFiQkm4bJ5oIWJkxGCLUwraO1EebMrdBlO2dzTuMwjeLi/o/kEgwegJHT3sLjXkGK0DF6TlxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUMe263BtwflK0fselhANmbFasBes538JZKqNN9RoRs=;
 b=mE5jc0p8rYX23EhiNo9I9YES1BKfdlH4OmDkUiHMHmKr1JNBtWE/XFJMk8muLIqIqSsZYh7Z1H4zRNsBAVVCThVkXgG/Xd0sAuMZaBNTlhuW3heAWxSYzG/mDbMyse3zKeQSOrDLXto+axyj21POWBy1HoiZX+LHF3SvE2ct5WLKc+umCBAaClLGFVzG5+2sqpu3HNiSjYrAZXanRlNK15zLhAudEl6FBvk/c6GzSym7GqAiYVj5hjvjeROzyWEVA6Rd4RTkq5Y5+kELm4BPvMZAuRtPgto419l2B7D3+5w+Q0RyAasU0FpnCVeBF4LfMEb1pnqApdWnRu6susScTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Mon, 24 Aug
 2020 17:16:49 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.026; Mon, 24 Aug 2020
 17:16:48 +0000
Date:   Mon, 24 Aug 2020 14:16:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/hns: Add a check for current state before
 modifying QP
Message-ID: <20200824171646.GA3214426@nvidia.com>
References: <1597665532-48406-1-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1597665532-48406-1-git-send-email-liweihang@huawei.com>
X-ClientProxiedBy: MN2PR22CA0005.namprd22.prod.outlook.com
 (2603:10b6:208:238::10) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR22CA0005.namprd22.prod.outlook.com (2603:10b6:208:238::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Mon, 24 Aug 2020 17:16:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kAG5O-00DUEF-Ej; Mon, 24 Aug 2020 14:16:46 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a11a43e-0f92-415c-12d6-08d848517c2d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2939:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2939EF1B1E7DAD07D3E5628BC2560@DM6PR12MB2939.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9dRxd8YCmU8+zRORBKNY9updgMcYtpIog3xPPnsobNfHcpX4t3kvnWW+HsCIeI1TlWDJQnSLEiwlXmB95wDIKisc1y406f5Sk6Qf8ZjbX7FK2NMNQjikUjS1uGub37EuKQkaiHBTRqKxuaS0O7Tkxyqod7QEbZwflkh9FLB2ApXFwCLQynDz9ehrrXVkzBjNIfvwQ4jOiOQzAG7ntSg+h6xgXP5IPx1ow9bH6UVMYQxYd+KyL14vsK7CxLdBSqFPrb8+KI9jDcR4Wvo/X9JSKDJCbFqU9iE0eKcBUDzIAj/15W8w0rHnt9RzPrO79fP0I0RFMRKdaI65NTWCFk89JQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(396003)(136003)(366004)(478600001)(9746002)(86362001)(4326008)(316002)(36756003)(9786002)(1076003)(6916009)(4744005)(8936002)(83380400001)(33656002)(2906002)(8676002)(2616005)(426003)(66556008)(66476007)(186003)(66946007)(26005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: RHG0D135/Qu06opkYud6B/KgFZrGhPj4CBwG0kPuvFLaks5spoKZtpLZ5El3eLQRHUZ2GFSnZ9CmhpCEh1hoW7jyPRLEWL4TV7CC5QQrOOD9arcClLV16MtL+sEBXPaLAdeWllMgI51UeEj38TpDn1yDd01blOCSIIrDq7jywElqIbkI5Z/9nikdXymuijUC48zEaWeGqj8oSF3nUANlgaLLDGGyPwarGf4l1OTw3GueK8x8ViIvlCitWz4fw90gY6e4rhl6NMFK3A793/99KMZiDvr6Bg0TecuskROXAOJ2O2gbYJC9e49BbwVGf9m8whLVpEb5LGzoeEengZ581fJAaPSoQkbmtOvIflxEwNCBEPF+h4WS6D5QHnsBA5gM0xwShbeORRUJOnCbrl+VbOyRrL8JoGtrOnsmsBhMZRRj/+2o4DlMLorDJIxXGu24jujh/2SGQUx32hzHrltsKjY6KYB7yU7imc4/wbpAMSs9NmOXpwQLPZnCUTzctqp7XAixvhhvvkBt6uykwtR2C+YTElz7e+7qGxB4R5rzp7hmRTqray5CWHxGZ14c2DQzOX6xqpcpkf8MNrPakpZPTHj2Xx1pxr/j/Wp7VWP77fIGxNiFsmTLSeG/iW60hifyex46GPtT4meCz/lbG+ZmTQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a11a43e-0f92-415c-12d6-08d848517c2d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2020 17:16:48.8483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Hau3s4txn5PRvflmI6CtCaSyMKihfSzTEmJFXpspl0SUDtqmco+uKcCjzUcStdU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2939
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598289354; bh=bUMe263BtwflK0fselhANmbFasBes538JZKqNN9RoRs=;
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
        b=jKpWJhUSvs8UtJhN0WTc5iMP/gbRpBrcRQrzOHBHjCl0jpsYTplvwU/qlxOBr+jJs
         Qz735TH2+ycUz3tjEu28Tf9M+fJShLiOldQ8k0clHuDJRaljz+kHTdRKcXsY3x9xJm
         diCfMLIJ9xpIOnlpDMduZkutVkLgnidZUwqGcF8WusLWYLktCnU8htUUAhCsamtEn5
         BW4ZnpSKEuyB8Oxr9NCv7gfLCdZHPUg0gdtIrLfqHxJRHgM1KzpB9VbfBvJccxadJQ
         NfAHBDXaWtLSJ9EPfzaPR7KarQWVMDZcOedGbcuM2/dGMOW3Xk27taXNY4naNoWMzZ
         tHDNSNyGUf6HQ==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 17, 2020 at 07:58:52PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> It should be considered as an illegal operation if the ULP attempts to
> modify a QP from another state to the current hardware state. Otherwise,
> the ULP can modify some fields of QPC at any time. For example, for a QP in
> state of RTS, modify it from RTR to RTS can change the PSN, which is always
> not as expected.
> 
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_qp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

This looks like it needs a fixes line?

Jason
