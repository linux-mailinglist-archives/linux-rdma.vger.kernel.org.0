Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 063BC3B1FE7
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jun 2021 19:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhFWR4H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Jun 2021 13:56:07 -0400
Received: from mail-dm6nam12on2056.outbound.protection.outlook.com ([40.107.243.56]:47840
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229660AbhFWR4G (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Jun 2021 13:56:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbwBMOUYIdk3R5eUQrRo9p92gi4FDI3zjZgPQ/jMImltj27+kxT575e2Tk1hlVe+AXkubuqqXGAt9w0vH3bMQhgxSF7H2r7m4U3IKcNLnN/2uTvyHcq3jsyUVELKmB5doRT08AklEwd5ScXUjwGykXjE3hIkg6blsphuLFZ5H9icDwpBMbInmghDchMkbYvAuXfYkOvi2PQxs4CEaYXYNlNaJ3gJxr/O6aepccV3800tz8pJGpVvKTBYJDq1gahFIw29Z/+7+IgH7kMn7/pdyNIK5tPi1o0DCISksGkqAIHmLU5Vk3isuzYrrjCTloUWP6+sXioUkE5fVyeaXytB5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlnpaRVxPIptqEuVqsrq4ecNUCCLbgCYDzbc8sCNDJA=;
 b=OJqQSUaeIsEQJei1ZsVhewn3bZqRr2jUDQwiqEzfOEhpAP4cTamxpaR44AQ3M5J6x0ZsHlchMbpbSxxFabhx/VGDXOKsClIcd//xpyQU8JAL+5nNsG4C1avQwNqfyZq0iZDywpcAe4ud2WWt7nE0upJhrYoaOSvbCaAcpJirq0ZkdzIPkOToOdbIe4MdntqNttzKLxlAc0QLBW0hgnh3yciZWKg+tx3YKvjqgBAWK/sNRnlAXirHQsvs4lsKnl9eK7G/7goI/JcDPjNcNgnTjJiVVBSSbrr49qXpuyB/tb+49s7QPX14g3Q8xnGkLWche6VjAE32bTDGTUbgISG3yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NlnpaRVxPIptqEuVqsrq4ecNUCCLbgCYDzbc8sCNDJA=;
 b=NMhJbff+DAN54kBsEYeoFdn2mrcMOWRLaNUeSH0ABEDYxzPrXT2eNexyKk4413po3LWjhO1mALty6n/ZIZinYtQAbrkNpMb00aAKiXU2nbQPhkP97y7qRMntWSQmCqLvephewF777SGbtuqw/QQpw/I/iUYdmVked2UyLfn5cTraH/YRuLA8CbSvJwZxeSy65kND4am75D/iD8Y3AeC9Z7w/QCYKV35cwAKtFAPbMolydHWTCKdXZGnUttKAadhrkCa79uTi5q5M9HFgZdFtBWio+mHgdxyLKPDaja4ys0h0IDII0ztOkx3Iao1TjlhWpjxGoEULeKDtFWMc+ugvUQ==
Authentication-Results: broadcom.com; dkim=none (message not signed)
 header.d=none;broadcom.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5080.namprd12.prod.outlook.com (2603:10b6:208:30a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 17:53:48 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4264.019; Wed, 23 Jun 2021
 17:53:48 +0000
Date:   Wed, 23 Jun 2021 14:53:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] MAINTAINERS: Update Broadcom RDMA maintainers
Message-ID: <20210623175346.GA2800751@nvidia.com>
References: <1624436089-28263-1-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1624436089-28263-1-git-send-email-selvin.xavier@broadcom.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR10CA0004.namprd10.prod.outlook.com
 (2603:10b6:208:120::17) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR10CA0004.namprd10.prod.outlook.com (2603:10b6:208:120::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 17:53:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lw74M-00BkcC-U4; Wed, 23 Jun 2021 14:53:46 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db016d58-f80b-4581-877d-08d9366fda1e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5080:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50807A5F84891D81CCFCD0C8C2089@BL1PR12MB5080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZzrSCuuXFAtbGNNDtWMYRuWhFpvIdaUWxpjbQ6DoMbFYmazm3b6IKrJaiogD6BcZ08ykpwLBQTO9crxvt1bjdJjw5MfKxdF3hiI8ke/qM3d7b06qsWKq2gujU7rBxMjmQteRXOZ0aS7xOEspeE5tHUovfEcsCB9+Yalt+trhsxtjCZZJIpUUFUrXtzs9ztpv8779h/6l2/eKn+JM+fqHGuqrDcam/SZFZnNrEGagSQDS2irTB5ER00YfU6+KQkH1yB/C0V/1E1NNjKNgN55uLfzOnMpmyYBKEVmxVw0MsbiglkBlVyIe6JWmLAMHjm8mRyuWdGLOCUfAH+8g8Ye6OsIr7lRmVfIMVi4WSVsJW/X38eK8lOlZgLadlTtkZ2E42+LSjUCjojjSbKj/B3E6Q+rM4QwLe9so/Vazg2nCw5UzKkJEZ2ADEw13JbOo3aBTn2ZRQxLPYnNDHnqyXsyyKlW/EX48sVVN/e+YukcJ1f57pSPxC3hnNha23pFyjEMybiTBp0N6zo1pPHuhjPMi+xHpSlFFsUQUuYofJ13QQV2M+V7y7GhnbXLTrI1E6nyuiPxrN0RYe0eovpeAuRavrMhMhcPeZ0P8uXyXYHaA18Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(1076003)(2616005)(86362001)(426003)(9786002)(4326008)(316002)(5660300002)(9746002)(8936002)(33656002)(8676002)(83380400001)(66556008)(36756003)(478600001)(558084003)(66476007)(26005)(186003)(38100700002)(2906002)(6916009)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rx0xgie3KR8ge9HE6eEb86mAzO8PdPB5kZ90EjAS983/6TPd5KSE2cPPNfnq?=
 =?us-ascii?Q?zWgHL/5EGhI6sKMJNoYJ+yOSQkOR9YpHRk9ry1VngmXK89MycJ0BI6z+9x47?=
 =?us-ascii?Q?DXgnC+OEEasi6yUVRiwZMtXc3ePYcnnoOq86FpMHC88IFxJjZASmwue83L10?=
 =?us-ascii?Q?CFsrVJnRxCf6JhZ/WuevyFR8CUK0PPGC8j4unLTvCaN/UcGfWubk4A41QHzM?=
 =?us-ascii?Q?adbuFk9k7BppA5d9pDNHltGjcWA2+rlgobBig/xUbsswEIuXdno3eBdo8Y+m?=
 =?us-ascii?Q?6sHMSQA45q3j2vUlDJGFLrmCsIY6GbDEvkWZbjCh1D/vKwj2AQs4cdNGZsAH?=
 =?us-ascii?Q?9/4TdsQyOV4up7mTZhvIop8NAAq/yJJzsXp2P6z5OurrqOs38gsxoTCtVMBg?=
 =?us-ascii?Q?KiG7TNCk7/hgzzwG3449zg82tkQ8GMRTLBeXWiunZ0s+JTUqOPeL992hY/Om?=
 =?us-ascii?Q?VHiGoG9v/oeNcSD73/fttMMYuwkq56h+rYyaIwBlNTgkbYaz6niqMLzNPHyf?=
 =?us-ascii?Q?+Rf939/89/ebpZ7WDpCAiBClLnCnRoAAVLVYUwj+qW+5W+194mGRv1n1Axuc?=
 =?us-ascii?Q?F8R/ljBIFRfUO5JaEqBm6sKiBGUQjICW+U8LMon36unNsXoVCvlQGUmP7rsg?=
 =?us-ascii?Q?ErvmlaCKAqZHA66lmJM4aJTLQoSRsWbcwE0RNJK3lSpl+gvBAlYEn2JUgSxc?=
 =?us-ascii?Q?T+eptSLKh2AfzH2PtXelGn12/QU0HnfA/mJtyr80Pb9w/QE+OkL5cHryWao6?=
 =?us-ascii?Q?qTxJ2MSPmM1+Di7ClKv+ijkXj3/4edKaOl/GvIixuv0EWnhi2BDlVpKSF2GA?=
 =?us-ascii?Q?iKcxClWMbu0cHX+Ctak1RRlwYc7qclKZRIqvg2yCLhMzbyA4FtFjmpxxZN60?=
 =?us-ascii?Q?8tzezw1RR3u29NygMvOSjIi3by+BzMOSHt9Ni39lIbP0o/ZIGF0cagXvEwhw?=
 =?us-ascii?Q?+B68PFhRWloNaeNEhizpfh0XX4JyhNBO2hmsGbpNlLDLjZlG8RFbHGb9SEMx?=
 =?us-ascii?Q?KImf2tNnx0Tu/csN9edsKTj39299F8+lbAT632cldHaYC0QSXsZUhcQCFKhJ?=
 =?us-ascii?Q?s4g0XF2/4lms5A3guJLJCavAA/2UgxQ7nxg5FMt1lelxdlvQhQeHGcQaYb/H?=
 =?us-ascii?Q?UwBbAqtPn8u62mBDwfUwgns35fEfBsh42jPNgW9afSQxgeRWOZuTJFAK1Urs?=
 =?us-ascii?Q?tmeEKuj8/cq5D+slCZKH58uvzMKoSu6w/bL+6+tABo2BG8o3oVszlm1Wj5Mc?=
 =?us-ascii?Q?lrbSf5COUbcoYVj0QNl4ZYdJon7yoPtqIvzz/ItzGStrc/xNzH+bcwGX8P/m?=
 =?us-ascii?Q?Cl3NKI87bazzcckzEy8jNbjR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db016d58-f80b-4581-877d-08d9366fda1e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 17:53:48.0619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scAF1ANujdQvweUCaX39JEY8fxMsbDnADC84lBJ3q+fYci8Nr/g9ECTnGJDaq8Fj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5080
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 23, 2021 at 01:14:49AM -0700, Selvin Xavier wrote:
> Updating the maintainers file as Devesh decidied to
> leave Broadcom.
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  MAINTAINERS | 2 --
>  1 file changed, 2 deletions(-)

Applied to for-next, thanks

Jason
