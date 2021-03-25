Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3AB349723
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Mar 2021 17:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbhCYQoj (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Mar 2021 12:44:39 -0400
Received: from mail-dm6nam11on2045.outbound.protection.outlook.com ([40.107.223.45]:18016
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229836AbhCYQoJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Mar 2021 12:44:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvYgnr0Ozo+8hv2tQUCZdpwvTmmvO8Nym2anEaaqs/8nK+mVpkuCFzj59KoWmfBIuK757DH29VmgWK5yDbXGHGguhB0DvSpdCapVUSEoJtZAT7yzRzg7ceM0Th4cmV6QUZG54ODIXSXA/FJvbTMLh0h+9SxyTZlz418rVP0QtJQ7i8w30Bm5N6IgC/Zou8PnLiZZ7V9swAyzDuaOO8wirbjYj8CdyNsiK8TYKEanzkNMiyLkxhSRQLVIohuKeY8imWWAxogtKMvGKF9+ghd1BhIJl3wUalavxiaoYfvAwG2bK5ggC8YEp5p0t1q9zZOzbyvHnM49fBYmPbDcwlJaSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiJ/IER4e6xRPymScZhN3nAGkbVp35WLRmMb8wCKKsA=;
 b=fCJjNivfAZCLdLhuO3BQshRrKRAq86Rh4bU+EkK+xz5WEf+dQU+ZUR+vgbwuRXsrJFQF9RlfUZ3IUAoaZz5LaorOnCeugv9zt5shyY6yhfkbxvZQDwDH82ybNTrjT6rYSrErqF6KMy2VcniIHlADV+edbgts3iUjEgaTF9g5bXe8XFnP6bYJo+ci7gCGUkrCtpAVWLhMVs2eKVPvcpZs+H320ZHHH0AMAydzfzo9cLVwoQ5CCxRHHDr25Zdf1VJCnMD/O2lQ4W1mm4n3Xi52ptP5j1z62sCHEQAplUwAkGPnkSIyT9Mgth+nVjz2nWXizIy2jXDTTEeWUsvjZRY6HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiJ/IER4e6xRPymScZhN3nAGkbVp35WLRmMb8wCKKsA=;
 b=R8lT6EKYULj4yZFiomklQLidsCf9g84e1S712AWQkU6WZOn3VxP0Hw4d8G7DzJC6eACeUhxYZwFukDkwbdk8SBzgJirpLlfOqtkkP1FS4FRJiAK3GxN0n1n6Z3ko/TrP0+njrIuCMRIwv9BUqdcLyAfptZollb5U/V6PcmxfI1pMdILWfK8nsdlemBsd4iM4JevjC4lOPW4cQ2LEYUs4WDrE3bjwAT0ZUsjZXRWPPu1LjDD6Eyo08k/oBxmXx43nBa+3yXP6+G3jaYKdDKhuQeQoMdgT7rON4+1/4tl0kTyE5uCdkrNe6ICwtAZY2fhDM/2n4XcVJKdyvALB4npAIA==
Authentication-Results: chelsio.com; dkim=none (message not signed)
 header.d=none;chelsio.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3513.namprd12.prod.outlook.com (2603:10b6:5:18a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 16:44:08 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Thu, 25 Mar 2021
 16:44:08 +0000
Date:   Thu, 25 Mar 2021 13:44:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 for-rc] RDMA/cxgb4: Fix adapter LE hash errors while
 destroying ipv6 listening server
Message-ID: <20210325164405.GA647852@nvidia.com>
References: <20210324190453.8171-1-bharat@chelsio.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210324190453.8171-1-bharat@chelsio.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:610:b0::17) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR03CA0012.namprd03.prod.outlook.com (2603:10b6:610:b0::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29 via Frontend Transport; Thu, 25 Mar 2021 16:44:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPT5Z-002iYg-FN; Thu, 25 Mar 2021 13:44:05 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b81cff57-9589-4f0e-2824-08d8efad34da
X-MS-TrafficTypeDiagnostic: DM6PR12MB3513:
X-Microsoft-Antispam-PRVS: <DM6PR12MB351318A5DF17744DF59100E6C2629@DM6PR12MB3513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:256;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lbahSStBF1pkHcS8rizttCWmu+WNpGEER57CJMGa6dujyxhZVT/j485+7K34sbr952R1XBMg7d+8b0i/5kHuQvriw7qak3O+7a7FqdWFC2Nf/V34P8WiKWy88pk5mgIOBf23177PBVrF5q0YpLY9Za3fxqgWuQlWBj9o5DZrUW56UwoO5O+V1E9jXXYcfp7+UeRRRH1g8orjihi4HG9r/RDpKoT9vckTA9k+5tWqHPWFS8YMVmkSCNN/1ESfchtUQrM5NZ5ysdiHB8Qy0dgWFpQthH68lpT25FBpghfhIB/f1MuIakrTZ62rGbpINFBg+INYax+EWMubn4eNHNq0y56JIXPCQiW/60lGGMQXy8azU7VCueGA2KMU93xmtExBEMK3/SlV5dqYRDvI2Yg+eRFYK4aFsmWpMc84cJkMhSz0nZT5mJlyr82iD+AHr7tNFGf1jhiv2SpcIZjuMdQXFBHLTfqJNhMzw5t9YtJfRyERbBAa+t82nHPqUj8r+yQWYsPA4iL9ZgLy7D3DKVh+s0vKeZDfzFo1QRZPyV7UiKgTIFd4/WcoogKPu6MyfXjOUIV5TpZ/1Vh8i5rXOuf2W1wtHJzB6c2Zpjjm00QzNwkRnDvkKp5ByDZtLPY5vr1xML1R+Iw59zC3bM/98JY0bGqlyS0pjA//6hx4ctRKN0Zq4H8g5gqOVgCfJYsBEbnR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(136003)(39860400002)(346002)(38100700001)(5660300002)(4744005)(6916009)(2616005)(1076003)(316002)(426003)(478600001)(2906002)(33656002)(8676002)(86362001)(186003)(9746002)(4326008)(83380400001)(66556008)(66476007)(36756003)(26005)(66946007)(8936002)(9786002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BHTLJYGAE4jpcT1RThQ5sPDkwQ/uVX8ZH/cpT8ffan49uMXLRltEgQZ91xhX?=
 =?us-ascii?Q?E5pitBuApBFntOH2nPwPjiBJKiL7TT4iFbHiseOCqmjtxm5kvQrSc6YeW/8q?=
 =?us-ascii?Q?q7dnyxpbHgqDjlBB4MBsC2HklvjB+VbSCtxG+NXY1vdgFdNIaC8wvv3iDowv?=
 =?us-ascii?Q?YffcPMHvOMR9uvCYG7jeJ53QxP0hi4tzak8wefLrM78WY3pPnwycPVZwKVV8?=
 =?us-ascii?Q?dw+oxlb6j+0Q4IpgsMcI4ftSVUwmmiWcYpiO3LIKsnVJL5YKk4Xj4bfMoYm6?=
 =?us-ascii?Q?kWpRBXbEuzLgze1/5krXJJeLLNBhXBUTh+4t9Pn3aeBn+wYUu+gfPwZNgBlx?=
 =?us-ascii?Q?96NoVe0ud9sJBWckUqqkbTA012txGkPb6As80trDlPmqHKymbaxrhviKCLqL?=
 =?us-ascii?Q?BGkc6UcYZyPM7ayBH3bXe5hwpo4uK1t3ikLb0fTcPcV1sQ6QqkkGo36JccV4?=
 =?us-ascii?Q?5ttAH5rYXXMfnmTb6zrHN1nKLlwtNiWilGeesPGNn11YLnd9m395U7meekjY?=
 =?us-ascii?Q?q7Z5AKRPbCHf/bpkauOrMA4sZcfcdDeuCqEVKZ8h+wHpCjVgVBqh/vO0aj4w?=
 =?us-ascii?Q?+O9/GoLitezyyGLyZI9Jd780xUPDTJFTRTo6/Bp3Ek1jDy+RRvj2ub/SUNmv?=
 =?us-ascii?Q?4VjpsWYKN/1J8MJDqot4WgKFnlf92jqO/25F1qe+DtmSr8DASzQc0Uon5BKg?=
 =?us-ascii?Q?hTU0fXMDq6x1seLNhi8A8Oi2Ft4jg9Ldw9fE22KDfC8adKzOedyfG44B3CE1?=
 =?us-ascii?Q?ZGToXFTEfpor2HSrmreGKqF+o9MlmSFTdjE8aUFCfIIwL7VTIaInXBgm6YDK?=
 =?us-ascii?Q?kcQIUDpuWzKCEGekJ5amFAsdK50CM5v8nAcUUxzEXZg2vMBZgyuDcmfeCCOn?=
 =?us-ascii?Q?FE2P/eynAy3JBs3Ypi6WGl3dPihPTvl6s/5rC0RRFdsSvUEPaOUbb0p/vw4w?=
 =?us-ascii?Q?oYwT4/dpev0dd7MCxa+DzvWQkraZ4ZkWcVsTzrzcgjTSWBsd8dQCmNM48fhA?=
 =?us-ascii?Q?NJ9K3kIqx3AKIiBirMEh2k5yf4emM3elnXGx3Onmh+Is3bHdLTbB1Qo4zYMy?=
 =?us-ascii?Q?uPuKg7hKaTE097+uRc1M/P65MCgHSxWPRDjNnZb4Mqm6wWyeRE29Pn7em0IU?=
 =?us-ascii?Q?lqjHXRdEM2HP2TOaqURlyot0GWd/4H/U8LqKBXgfgsjeEfKVGQiCAYte4TeH?=
 =?us-ascii?Q?pOh1n/4my+27k5Y1hjvSSufWEqKkXXPivv3vsY5i29h1trVhl1C0xpqX9Bcz?=
 =?us-ascii?Q?g6QLw1tmZqw5mRzo0jB+AQZnXJx84nYgcsSKXtiDc969dVAq/HGXpC+Yu7Bp?=
 =?us-ascii?Q?dAwbiDT/9UNyyjCZEvzdPGVp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b81cff57-9589-4f0e-2824-08d8efad34da
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 16:44:07.9841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GcivYY1gUEpNc1pTok2tg68qbC+EneYkAi8UtbHfL06uR1L+pNRgOF/CkPlFChVh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3513
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 25, 2021 at 12:34:53AM +0530, Potnuri Bharat Teja wrote:
> Not setting ipv6 bit while destroying ipv6 listening servers may result in
> potential fatal adapter errors due to lookup engine memory hash errors.
> Therefore always set ipv6 field while destroying ipv6 listening servers.
> 
> Fixes: 830662f6f032 ("RDMA/cxgb4: Add support for active and passive open connection with IPv6 address")
> Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Changes since v0:
> - modified commit description to inform the severity of patch.
> Changes since v1:
> - removed extra variable as per Leon.
> ---
> ---
>  drivers/infiniband/hw/cxgb4/cm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason
