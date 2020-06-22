Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B40203E85
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Jun 2020 19:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbgFVR4B (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Jun 2020 13:56:01 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8292 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730067AbgFVR4B (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Jun 2020 13:56:01 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef0f0a40000>; Mon, 22 Jun 2020 10:55:48 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 22 Jun 2020 10:56:01 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 22 Jun 2020 10:56:01 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 22 Jun
 2020 17:56:00 +0000
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (104.47.45.51) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 22 Jun 2020 17:56:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAIBDLgt9kttHxXm1LMNgiBZrqFEsOd6nUs4DHqPMwNnwY+uIzF1560+6slU9ys25p58S2mfzdrpdiqrIFk8o8UA+FQawr7JtKda3bmCZiGJTq3B93Anoj238v4TV2sHDuIzkSN10HqT8VxCRkv4jjTIwgLXJnEku0TREefHjvx9lVsyQVonCQm5ljMoV38QOqc1TKzlAcVLRgJ9mabCSY+S4yhOSb4bAGvKObt78KVmSeM44eeCAraduCt7VnfTSd6bxdZ0skana5xNTpXackTUsOgY/GupKp1gEgPysFuf1SKHkAhaPX0yq4ouk2R8JE+4lM5bLKnEhhR919/Y0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUkHYxTAhki86mr+XVkcAGmgTvXkAOyW+3ont9mnYLI=;
 b=U6y2+QMv+z5MNYWA7GAfs6vza0SWGGp8uC3MALcWFTx4qi4+r7wFPHT3MMUwqCXKtUBNXIX69s4I2qotZ3fVvaVesFf6x4twBO9pWNjbfGsoUBeB3DZmf2KfsOBLvvgj+4NA+KJiJBo+KqFV0kypaOcnQF0xwmRIjiP301KHaK8fDddu733Xl89lWtVO8On/yWoSf7j/7l93h4BjOxGfXXL6iHC2YH3qSlqp+IoJvKX89LASnKYZ54Bp1X3XEVSyBLuYXyQLF7Ht2Lo5tZGuGxzlRgeEDGUp/NG3P0BJHWZpuDdRCTx/eQbrh9AhfciEotTVeSAwp6FGxn6bnfRimA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB3827.namprd12.prod.outlook.com (2603:10b6:a03:1ab::16)
 by BYAPR12MB3639.namprd12.prod.outlook.com (2603:10b6:a03:db::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 17:55:59 +0000
Received: from BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::e1bb:1f91:bd87:9c6b]) by BY5PR12MB3827.namprd12.prod.outlook.com
 ([fe80::e1bb:1f91:bd87:9c6b%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 17:55:59 +0000
Date:   Mon, 22 Jun 2020 14:55:54 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Kamal Heib <kamalheib1@gmail.com>
CC:     <linux-rdma@vger.kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH for-next] RDMA/hfi1: Remove hfi1_create_qp declaration
Message-ID: <20200622175554.GB2892511@mellanox.com>
References: <20200622094709.12981-1-kamalheib1@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200622094709.12981-1-kamalheib1@gmail.com>
X-NVConfidentiality: public
X-ClientProxiedBy: MN2PR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:208:23d::24) To BY5PR12MB3827.namprd12.prod.outlook.com
 (2603:10b6:a03:1ab::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (193.47.165.251) by MN2PR06CA0019.namprd06.prod.outlook.com (2603:10b6:208:23d::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Mon, 22 Jun 2020 17:55:59 +0000
Received: from jgg by mlx with local (Exim 4.93)        (envelope-from <jgg@nvidia.com>)        id 1jnQfi-00C8UV-9C; Mon, 22 Jun 2020 14:55:54 -0300
X-NVConfidentiality: public
X-Originating-IP: [193.47.165.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 19602555-af0d-4634-598b-08d816d5856f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3639:
X-Microsoft-Antispam-PRVS: <BYAPR12MB36391B024438DD11CA2A6F0FC2970@BYAPR12MB3639.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OEAsozH2aETP1KgRzBVSf0EthP4jfVcBBxSs2N+SBtjJO5HQbAfYTMlrJdILlWQlKwMuQV8LvVazWrzIGLtvX8dwxKbX68EaQSI0kN+8WuPjAGqem+X8CDMtN0MOAIru176k688mrZK1SeGeqML+5HC16tFrRyvO+XQiuO3FJyMPcbLHsMluLXFwW5k+GwkBU0+ffswsre7GBTsSOMJgMAU/6gSHAB1PPvNdkrboKRleLWBpySK4y9WEygD4lDTbNS30+/icnPK/RVggDCt0I1NRa5nyCdBCCkkXsm5tD0i2JQlUWhl49SbpP+RKaRZY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3827.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(346002)(136003)(396003)(376002)(33656002)(478600001)(2906002)(66476007)(66946007)(66556008)(9746002)(5660300002)(9686003)(9786002)(558084003)(4326008)(1076003)(186003)(6916009)(36756003)(86362001)(54906003)(26005)(426003)(8676002)(83380400001)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: D6Af3zYF52pcdzqSKRGXIAkXJoYh5bMES2eCly2IUv3JmPU8LRjSgvtpcZmGMmTM5RT7Ihv4gUqDX6zBtkcokuJ83s9Z7HzttR7s4M286ywIoB7zA9LudmxYk2nTHi4zxxxV2Cw4t5MplspTiQOkP4Qfm6OF2bZeTfhW+LG2o9SOJPiucmDomNnD95POcTRl9eFEuFvgWzMx39xc26PLHrzEZR5aSnGmFdXatQAKrgFjS5NkFcN+Ha+/sglh/sDO0IOPxXZFuE1LyJRPoLYm5TDy7O8i4KHM5rPdrlhJp+ddJIf5tp9j6PESCuwSgbVpq2lHdliPyvFn/GyJaNiNbegTmNgm6TEsTPB1UmrI446nZAxNlTwDXx9wpsR4WdVL7etcafEU1HfwQioCe4kiE7uLxX+xA3Wh0Xt2KzvZzw9/Kmu9kDeWK8qMiCK/zUGv5bFAq1CUZXbjPd7/ZNyAD95OYYdMDlMzbhSuE3naEJM=
X-MS-Exchange-CrossTenant-Network-Message-Id: 19602555-af0d-4634-598b-08d816d5856f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 17:55:59.7666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lo0LdO1nJLR3tHtYNNze5crSd1RxTLXDCHw6Z90XdgYWfoMuP4rY++39Y/Am4rUB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3639
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1592848548; bh=xUkHYxTAhki86mr+XVkcAGmgTvXkAOyW+3ont9mnYLI=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-NVConfidentiality:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-NVConfidentiality:
         X-Originating-IP:X-MS-PublicTrafficType:
         X-MS-Office365-Filtering-Correlation-Id:X-MS-TrafficTypeDiagnostic:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-Forefront-PRVS:X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=R4/X7nNJB5tlggNpDl8WgPyyOX6FlFaMw2IynNRIwjG+vOG2JTWD0p79R9811aTEv
         2S88RxzQYwL1GYin6bMwl1u9nfVqZbcVmexlJqd8f+MW9Mbpt/mMQbNhQvK5ezgUQL
         Xb0IaSl0+Eog50R5v4FmqkooYQratj/zJDU/I9QmaFo/BTGA7/rahf1wTr1qt0clRn
         IOQUrtJIJIGs8V6g6oVGLZwcRnvz7nBSGY+RJFyf/HcAh+zliV7hWma2av+95JQdLH
         MLUCnUFYN8LNzXMMN9WuE5OfZ7sfwB36lDu5bp8B71oX8WshAia78wa0zXUvhQtBqu
         8tYzGicTifY5A==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 22, 2020 at 12:47:09PM +0300, Kamal Heib wrote:
> The function isn't implemented - delete the declaration.
> 
> Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> ---
>  drivers/infiniband/hw/hfi1/qp.h | 14 --------------
>  1 file changed, 14 deletions(-)

Applied to for-next, thanks

Jason
