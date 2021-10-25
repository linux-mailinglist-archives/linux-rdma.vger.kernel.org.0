Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD1F0439DAC
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Oct 2021 19:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhJYRia (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Oct 2021 13:38:30 -0400
Received: from mail-co1nam11on2074.outbound.protection.outlook.com ([40.107.220.74]:51712
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230505AbhJYRia (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 Oct 2021 13:38:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhRr6pFKqm0kEpDm/gS1JxfNUb9oUeUVQ66EChg+yYoBlMoCqtGqSH/Eg+en+8jrtDbpTv4dCFlriPizOoa6Cj7M8VCsGyexc7eDzvs9QlNUlJUXO72XQEuQQkjiAJGmxZxl4gOiQ6NXbnAzXogoypemvuNuvFag40KW1yA6yyt8i9Xo6G3LpXHa6D1zNAsf9RXwTiYzjiN4NrGvpJVRlphsOA4kr9y+sHqAqQSWetbw5rpzjZSsBclFM41iPsSr8PtMcNWUkPylF0wTStruzFKJwpLz1BBz4G6m3NITK3hclstEFDr44Pw/6HDCmRdH3zhjCvvlpXIuD0M5kQ3kbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hakN5k21GX9Tev81XTZcTekflF2A7r1eSkakepTivM4=;
 b=J+gMEEi/6v7VVB+im3n8hzV8RPo9HaqFhX3t7GJrGCZ7uDpwascfQ2uylUcNAg7j/+hUlZ7I8iXbDfneEPG/6l8oS69uDvsglWuuufC4jOHwPnjuu1KInhhvsToOb+wr6ubLwK66rmfDFo/NqAprGdVVx06dbuvyISjkK8UCsFW+0ro6gT4Gjks61TlQUMeabm5rFv6WoJCv54/MKuADPMJnUusGmD8gDxsIGxEfyWNli/NFFNK9WDUTXf9PkPAAGkee8zLjU9BGKl+7gbtSTtwfacQLRAViVhvno8c3sBWhd84VKKS0NCX3t7n0sTthwn3VYG3lcCukfNikl03XpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hakN5k21GX9Tev81XTZcTekflF2A7r1eSkakepTivM4=;
 b=BGArhWcfk9yC5IlxWlY24u7VmJ7VPmyiQqaCoUvxV2wp6WTS/Cbbdyw/c5EBVlhK3vc8aHbFYGO8KGGmyRXvWLTk6N1upDSsWG7pcjFTULLPgWoYkLnUKiJHwlnm6MKvYRkv2Xuaub8g6OTdRhOWyjHPMqq2jbdDKXZbiRuZsP9D68ReZrFc+6qjhj/5Zz3KaVj8okDh7RNDwsc1Va1gKSsCrUL5xil8oIyaMLwAJj9dUew9Y6ydJCzmJEBnKcp+HPZ9EB/0wXl3LyZ1rljeU2CKgdIZBKIymNbo0DuGOa87romR2Nb3o+pfYfz3IHPOY8bhMhVjprCzRRWppiOK5Q==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Mon, 25 Oct
 2021 17:36:06 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4628.020; Mon, 25 Oct 2021
 17:36:06 +0000
Date:   Mon, 25 Oct 2021 14:36:04 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 0/3] rdma: prepare for const netdev->dev_addr
Message-ID: <20211025173604.GB427940@nvidia.com>
References: <20211019182604.1441387-1-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019182604.1441387-1-kuba@kernel.org>
X-ClientProxiedBy: YT1PR01CA0126.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::35) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0126.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Mon, 25 Oct 2021 17:36:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mf3tE-001nLa-Jz; Mon, 25 Oct 2021 14:36:04 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43c5def3-8f5d-4ee9-6ad9-08d997ddecc3
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53362E53FDFC2C44A9F2A47FC2839@BL1PR12MB5336.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YV7r6pHV1QXFRX2kmRikGrB8cIe7HFalgfzUUgfTRdbqellfhDc54U8+3j4VF2q+FGZMaDvtf7YoUP3BhM0LDthzPO//iHCuv2R9zwMAJTdhobxCjF40cyeTGSmwHF0/ewN0Qk3ZqofqiJUoi/vJbjpE/0sG7G/4HPOxvwSpei9Y/S4O16JuqaO2zeNZVcvH13yQbkVHF9nnDoY+bgHA9IXzYyP0fDVVPScPCU878NC8IEBju3jh6hO3dAgrQtb+GrmrzEWRKtuyfFo/gw4QsGD3r0FceT9elLY46c5o5/N457iSjCOhSMFVg8v2BWfaJ/IoPVPXAL3A843BNaxHaDlfKmOSE37w/lVgEAYt4uBPNfZnuyoaB3p5wzZAxy4TgZ1gt3qFde8j27mpwVph7IqyGwXVtFahJkMxmzEZz8YIn8pvCiqt9Lcgb4gnhriTwNceD75XWzM0XrOf/OmtdZmcpGfykNWWaETb7qlgbdG3T4BWduzcq6tjbp0qa4jQEPUHXvEFgVysroPik5oz5g43mfe9QMrC1WxCzOmXA5DHG17/ePWa8JQb09cdH0ZxoL2E05fbf0elTB97Ww6ahHo6j0kpqxcaZe6Xdwtx/dtUQE8uGLWXRTSY3dNScCq9Ew9HwQRvNayGf0wF4aag33/wgpbuWg1YQaWCIo2zHd2JlknJRRtiZg1px8EC+l4vMdEFpeedPM8MSRxVvvvy0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(36756003)(83380400001)(66946007)(66476007)(2616005)(8936002)(86362001)(66556008)(4326008)(4744005)(426003)(6916009)(26005)(38100700002)(33656002)(9746002)(8676002)(5660300002)(1076003)(2906002)(9786002)(508600001)(316002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SZCMxPOjpE8XALoE3ZclFc32l1Lgl1+rGe7wMa8zaPsCZ6NuyPF4MMEWlT1s?=
 =?us-ascii?Q?EbQDirPNEWCKVW/vlmFENx0hSdgNxi93Lndq0ygaPx+AQsETYKhaNHz3pKlc?=
 =?us-ascii?Q?4Q12gCgPCxtPonZQjb4biKusrjDeuZM9Y7KfEpW9re6tMsE7XL+dQ8E0zOza?=
 =?us-ascii?Q?gM59SaJO2Uj87340fTbvEZb6/iJSYerjXF3u5PxY43WZS8UhgOgVisvSGPYk?=
 =?us-ascii?Q?orU4aXub/rB8CQhOTj706uQ5UyB6k9y6rhycim8FqBegDkm0MhlcFX08l6wp?=
 =?us-ascii?Q?aYZlOiKpVaZ+E6l+GzPtjNGEShez0+3hbCRqBgiBRFj8L6t2Vbm2FLiYHY9E?=
 =?us-ascii?Q?WRnB+j6zYyLNNYYCz7IgFTEo1U8I0s5eehfDYYI6t2pc+nLjtXfK/GUsc1wt?=
 =?us-ascii?Q?3qMrsE7d79uwOawfyZz+2c9bpYT+4E2Ojbc6hdY8QxQvLOSkRtk2UAdGq35h?=
 =?us-ascii?Q?MJ348Rxe00zBNCy/SSahzh5vvcl2GPevzbeB1RvYQ7VAV5ULOqa/AxedRYlN?=
 =?us-ascii?Q?sUo63H284zu/FvVC/49oVK4YtcyVhKxEVyivXtFophyZNKvb48G04GxxpLuE?=
 =?us-ascii?Q?6e5MwNyM7kD5jnDWbGUKJUypXOMh2yWSo1w5K/r1C818RbeScV5izKun74gF?=
 =?us-ascii?Q?hzjPM6qr5k/wdTVV1HcqEGZ12cHIAqRfesC36xmwZOsCI3S2A2nJKnXR+WiV?=
 =?us-ascii?Q?cH2sPzyacGdggiVx4rkBDqGlLLlZWg82nqG36DSVepwjmnEVQmj89O95cBsl?=
 =?us-ascii?Q?6cF4fbl39xYk1nk9xBKlL2IscVT/XvNNuvn4F7GxUrFsCMinyrAbYNeP48NF?=
 =?us-ascii?Q?lxn25le1nb3VW4o5Nk1S0D6+bJLSl7rXozwxs+iTCYzHjV5ytldZ6E4j2wkw?=
 =?us-ascii?Q?X7oeXfHgg9HwYBXcOSk90Pfys5dAdD9C+8jyou9Vl6J6bkOonp01R6yFUOiM?=
 =?us-ascii?Q?Bkdh9tjHmEQ0FU7LHjtfO2M0j3L6bdXbyVxAIu5xi4nRjowCRQBANWDRMtpM?=
 =?us-ascii?Q?iew9U6MKeWpDIQHg1rO0JUFRJ96x1hwIQ6U8NMZH1C8y9L8xKZewNYbh7AWT?=
 =?us-ascii?Q?W6choCkNXk8Mv72+3jvlzA3u9w7fY9o6jEXMJxhxUoy7ilvJlwRl7BvB/kXr?=
 =?us-ascii?Q?ztAZUh1hnRyvkpOH56vXRzoy8OLnmSXR6TvL/LW6TWI5Qq2o1GdLoOc9tTem?=
 =?us-ascii?Q?aG88MYSicYjw0E+qrw6ABYEO6gFT/Axq+hsEMojkwxtNvK9cjNgRiKDg22QT?=
 =?us-ascii?Q?JLuyFmg2F4AmGI/U542rG2neiGWlaamEFAbOjo90rqCwYMJqtyNGRL9lkfSz?=
 =?us-ascii?Q?LHOw96Tr4eSweqkhUSFrwrLfebs3T2G+FK7aXYOz2ewcFvl+5xeF57KlJoXd?=
 =?us-ascii?Q?h/O8+xqjaOgeg2mXjL0ntYjYFcmPRwujiiuVHKl1cGgzkGf+88hC601jV/HZ?=
 =?us-ascii?Q?rI7hOopTuLn0cmxaj1FGtuabPSwzoHvBkcqJ6m/NlhGoSa2inPMX4mYC7lVc?=
 =?us-ascii?Q?iSy/I0h8PCVEQOsXHXzJmm3CSxlXBzFNFBK8cU/C8/r8yBR8UKcVx/3Hprd6?=
 =?us-ascii?Q?prqfeh1vrtqkf24G+UY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c5def3-8f5d-4ee9-6ad9-08d997ddecc3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2021 17:36:06.6965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQLkxbnILqxOwo3aDJVsA11/XCjNCGxoVYJfHAKhHz70CLZAFWxaaW+l4GVrirXD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5336
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 19, 2021 at 11:26:01AM -0700, Jakub Kicinski wrote:
> Hi!
> 
> These are RDMA changes needed to make netdev->dev_addr const.
> These can go via rdma-next.
> 
> Jakub Kicinski (3):
>   ipoib: use dev_addr_mod()
>   mlx5: use dev_addr_mod()
>   RDMA: constify netdev->dev_addr accesses

Applied to for-next, thanks

Jason
