Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7CC45DFB8
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Nov 2021 18:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242518AbhKYRc5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Nov 2021 12:32:57 -0500
Received: from mail-bn8nam11on2080.outbound.protection.outlook.com ([40.107.236.80]:14688
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242532AbhKYRa4 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Nov 2021 12:30:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+Ev+vRgfwXf0fMT5RJYHU0jdKi4rW/yReK8Z/DHl12yBj97VUGiiMWbchRozhYCg4pHGn9tc/KIlyGM65qKEYw4TufIsi2aNp+5R6S23vgbtVwzukLe2uBrMQaH4kQOytn5YXnpiZTXcE4xDK0jj8BIQQMylIKsYPf97NPrRNpKqzTAQcuyQYfndQJZboixGC00z1GyJBwFcjAPXTrHuRBsaoCyrGkMnI5EAxyX9w6meOuCIeM0UrL1BIgIqaCJon07Myl8/hsy80nXt2Fg4afhbvS73m9qXm2kLJZKnz+oguZe4APAqdhwvjb0VEfRVSWZC5mE3HtQ5b1mzYqQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgyLLqHYvHgIHTfnvEnjq5oX/i8cSuCI08R7XJ9EoiA=;
 b=CSTg/2XIkZEH9nUV1f91FwBydyTHRl2FoI8oR0ZbKdsbBcGvr/vwu/JhXBXPelTSivLQQBghi4963K0kChUM80GHw591hPWViK+OpAyLRJPbjN3ZiQeRV/gSKWzdeVO4iqpfFLMqCRGZPXnoMjsEOTqBesj6xTBS0gtTCBMubGgXM58XDMCfAxJu+ZAgHTkAs96t5hDRrVZ1gSqLvSKBinCf68X58K+YcutqQQGGD/qLA98xeqrdx7aMpCX769iFc/OpbVwsbW2wDedmCzbO3Y/pQ4umbJnI0lHI8Ex/wjx9JsW/nk64l857sfxO7A7eNc5ATXWcctrr2JehR16srA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgyLLqHYvHgIHTfnvEnjq5oX/i8cSuCI08R7XJ9EoiA=;
 b=r7o+LhZl8k4ApRPKMXzBPGk9M/1hLJYztBUoZlOlGXg2qYjJEq5J2E18NTQnslwUT/uMuCYnYuN8WhwmBWJqDB/7VwcJoqHyehD7Qwb1GW+uAx9EwaxH6EwU+4jDmTZ/JXrm+6iRIcErxTgSosHT1j1o3gd6+g7pOZ1s2y4TRdthn+TwSI0JqFfS8BPlSxm05w1ibUSaIvw6JhFKm+7N0hJbK+mQNHFjyvqzzbwCYEeuewwitu/ziRRYvUkvaLGOpLXFzeNfKx5ukSO3bd22ernbS1ZepQ5BpSvnmPr2eHM2QnC//E1votH4kdZwFxCWFXfkH21Zo5H53PiPfGASoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 25 Nov
 2021 17:26:39 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.023; Thu, 25 Nov 2021
 17:26:39 +0000
Date:   Thu, 25 Nov 2021 13:26:38 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH for-rc] RDMA/hns: Fix the problem of mailbox being
 blocked in the reset scene
Message-ID: <20211125172638.GD490586@nvidia.com>
References: <20211123084809.37318-1-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123084809.37318-1-liangwenpeng@huawei.com>
X-ClientProxiedBy: BL1PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::32) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0177.namprd13.prod.outlook.com (2603:10b6:208:2bd::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.7 via Frontend Transport; Thu, 25 Nov 2021 17:26:39 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mqIW6-0023f1-9q; Thu, 25 Nov 2021 13:26:38 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4013816c-4e0a-498e-4bf1-08d9b038bd74
X-MS-TrafficTypeDiagnostic: BL1PR12MB5128:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5128249A16218754D2E628AFC2629@BL1PR12MB5128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VWW0N+X7L9ErdDeLzLFw87BBlQPNrCfNAi0esO6SmKoWUt27ktGq3yIjOntdpSJNfZ9T7tKtUwRuK1o8H45Jl61LgaRdwLyRqYhHDuV/bmmNBPqfkhhoOGXoppY1KyEdaqBGpZO4XoI+B7CmidvvnF0o+EJdDNb6CNGpmt3lBzuFk66IaqTiI8rJiBystLbnbGHONhyo/YPGpVVkeCi3dYEFBJouW+tYEyphYvgSrmS6XPXPQkrXeEtFeV5hX+iMc8twYH4Ue+k0lzu9C+xIZqV8apSbeI7A7uzX0KbsBdYFwbxj/e1vgXcyzJiJ6f21hXo9JXt4rEGwihbQdAON/9o4iEnIoBqKlVjodUf8bJGIxNtYDeHZFN9+kKtvT/pUyIeJAq6m4/JVyqGRZOPoHdXAcVgIcLpxR+t8ms0G6ns7fSJkm2kFi2sHDGDamXRM8VVPUnGRhbMNFmzsObRN34BBIvHGV5RssVXDNd2uaPestzXThyCV7lKmW7p72Et5n4lgk0HOMrJghIxqiDHHmFws87eVZcpOPSSnR3k+SHEnVqeCDywzJrH02O+ZNG6lTHte1tbR9g3PExY1NHklpHQYWFcy+uaeRu978cNJoLF1Rvn/RUi1WH4P/5qCDPOqjeCW1Z4MjI2vkimm2VFDbXY04OwQHTc5LReCKQMRiTI0Si2Bj+GSI/atwj86j7/wRBUWkmMyh/G1J8XCZL0P1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66556008)(15650500001)(9786002)(2906002)(8676002)(38100700002)(5660300002)(186003)(8936002)(508600001)(4326008)(426003)(33656002)(6916009)(83380400001)(1076003)(9746002)(26005)(36756003)(2616005)(66946007)(316002)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nx6EBacKfSWwBqIxaxhgvypJkXlhDf1xeMYaV6zgw2M7RX7YSTGHauCWw6nT?=
 =?us-ascii?Q?gHFftBQyaKPf/D2VK4EhiFrR3CuEOGJAyjMW/aZ3GzMoZ7Evs2zm8aWh7q3/?=
 =?us-ascii?Q?fhxvKPp+K2Zppb7CuaseimvnzTGHS0mra5KVChRSwL82O6iCdcmThrJiHkgs?=
 =?us-ascii?Q?ShBELO6nTir5SHfpcu/jn0XOR/VEXiCE1WCO1RBqBLK0fToJO3oICsTwm+Bq?=
 =?us-ascii?Q?OkiO+aq7b1rFeTCVB5XHhvw1tMZIAtD7JI7I5foNCSSNjo/i4WxzpWb5gLG1?=
 =?us-ascii?Q?td166eaXNDKCMcj4g2cg46zL69ySTeAvKes9FfGtG0IkaIoFSGJysXIXRvEX?=
 =?us-ascii?Q?cEbDQComMwp/X4lCIx3tI1CawMLv9mYfqPp4v3Lh+sPMrSSWsWdth9Fvq8ZB?=
 =?us-ascii?Q?C3BqTROyz43dLvyMCxl4CEmbvQ0HNOMF62Y0Fc5Y4n+0UWGL/ZF6EZnhcsNG?=
 =?us-ascii?Q?dU1PDIz4mwUa+6I7pDxcS7uvKjG07ucwEuF5qHkPI7Jg0GcJLd2+kNGi7XFZ?=
 =?us-ascii?Q?SM6cSOGt1rnjE8BSARwgj3eT0gRzXNGRQC2U+rTwP49VIKejr2YfGZRjJiVY?=
 =?us-ascii?Q?KPb10y0Xge/ze9jXsexQq4bfbhBXddPo30NJti/BOiWT7paP1t75aTeamsax?=
 =?us-ascii?Q?sVHB7nh8vt3VIryHMUXKi74Hw6MJLusxftBARgOYASGKHt+SPp9HI8U1qo7V?=
 =?us-ascii?Q?gfyzQL8dfN0J4GogbQhHDuxvyVKRoB7IoxmWB2LnYrrzw8pLB/9dlJwGnfA2?=
 =?us-ascii?Q?h14574lcxU75NjxN0qkaUSNAhC6+7nr715oXttoWLoZqlnoWcAC4JYHj4xeT?=
 =?us-ascii?Q?ecH0SBYobaE7M6cAT9WQKgKjvcGPyw3yHDZyHpVM8kQxb+y8Q8bZ5FoqhzJ+?=
 =?us-ascii?Q?uyYyMSS2LxzuIEVbTYagNxNrWD6la/95RJK9iEgjK8c2OmtQtiO3HuOVADJD?=
 =?us-ascii?Q?gmpnbmLnIKAzTxx7UO48ztyyydXUM8WqmrSxMqL1S8xKy2hlJLDboLHS5K5B?=
 =?us-ascii?Q?mT4KZzBzP6xQt1PPpM+YS62eyjAfvmyvQZyRK13j4v+azjnk6nf0nBFga4vN?=
 =?us-ascii?Q?D8JO6+bhNa0CKRcEfKGSx7Zwn3DGzEyB8X4AU4sWk964j1Qt4MZXTOduFD1z?=
 =?us-ascii?Q?JKpoDti48lSlkIfJ0IC6OhsC6D8XBYrrlUUiJ+X03xjdeVU0Yv0q7DRH0xAv?=
 =?us-ascii?Q?soi93wvEop2QyQDQnF8WJXjJ1A8QSwKyg6oZcci6PBW+LHttKrwZu9yQGu5C?=
 =?us-ascii?Q?zaOk/GacUbYBvOvMJFIqoSDkarYsUmtNoYTaVmRF8NbTPQSI255+7iNBZIti?=
 =?us-ascii?Q?lxjABYoLopiVhsKJX3vTK4zIBqjH8lZk1ihgKR603bufeZtGm7DG5WiKdu0s?=
 =?us-ascii?Q?/HWcxH71k+qxNL1QdSdvxkU0q5ilPK1ca8b8ZtFLAYfBVRz7z76dIMiugZ94?=
 =?us-ascii?Q?JT1WjG6IYFqmimVjiQb2D9m/q4Bcqb00czLFvfpPtGin+xtaPAPJlp+GrAm2?=
 =?us-ascii?Q?csf4dQRn0yCJuAB0hQ+5VJb+31jiyjQ1rAgWP2Z+Du2WuwP7tr6zb02LoG5G?=
 =?us-ascii?Q?MCfj5rcpAw6sshyvq2A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4013816c-4e0a-498e-4bf1-08d9b038bd74
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 17:26:39.3804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kq/TWiso9tEtg/SVpW/V3l8ZxU2w9qK92A2CA0uF+0KR3jYs43ijSFzVhYCg2aIu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 23, 2021 at 04:48:09PM +0800, Wenpeng Liang wrote:
> From: Yangyang Li <liyangyang20@huawei.com>
> 
> is_reset is used to indicate whether the hardware starts to reset. When
> hns_roce_hw_v2_reset_notify_down() is called, the hardware has not yet
> started to reset. If is_reset is set at this time, all mailbox operations
> of resource destroy actions will be intercepted by driver. When the driver
> cleans up resources, but the hardware is still accessed, the following
> errors will appear:
> 
> [382663.191495] arm-smmu-v3 arm-smmu-v3.2.auto: event 0x10 received:
> [382663.336320] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x0000350100000010
> [382663.349860] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x000002088000003f
> [382663.362217] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x00000000a50e0800
> [382663.370690] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x0000000000000000
> [382663.385557] arm-smmu-v3 arm-smmu-v3.2.auto: event 0x10 received:
> [382663.487465] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x0000350100000010
> [382663.534555] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x000002088000043e
> [382663.546569] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x00000000a50a0800
> [382663.554642] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x0000000000000000
> [382663.565023] arm-smmu-v3 arm-smmu-v3.2.auto: event 0x10 received:
> [382663.575860] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x0000350100000010
> [382663.585248] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x0000020880000436
> [382663.595860] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x00000000a50a0880
> [382663.804870] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x0000000000000000
> [382663.942132] arm-smmu-v3 arm-smmu-v3.2.auto: event 0x10 received:
> [382663.962770] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x0000350100000010
> [382664.100535] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x000002088000043a
> [382664.178632] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x00000000a50e0840
> [382664.218997] hns3 0000:35:00.0: INT status: CMDQ(0x0) HW errors(0x0) other(0x0)
> [382664.223572] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x0000000000000000
> [382664.257988] hns3 0000:35:00.0: received unknown or unhandled event of vector0
> [382664.271027] arm-smmu-v3 arm-smmu-v3.2.auto: event 0x10 received:
> [382664.546592] arm-smmu-v3 arm-smmu-v3.2.auto: 	0x0000350100000010
> [382664.555942] {34}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 7
> 
> is_reset will be set correctly in check_aedev_reset_status(), so the
> setting in hns_roce_hw_v2_reset_notify_down() should be deleted.
> 
> Fixes: 726be12f5ca0 ("RDMA/hns: Set reset flag when hw resetting")
> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 2 --
>  1 file changed, 2 deletions(-)

Applied to for-rc, thanks

Jason
