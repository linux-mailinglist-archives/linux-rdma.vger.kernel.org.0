Return-Path: <linux-rdma+bounces-243-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A868042EA
	for <lists+linux-rdma@lfdr.de>; Tue,  5 Dec 2023 00:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E96A2813A7
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Dec 2023 23:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C416E39FFE;
	Mon,  4 Dec 2023 23:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tEM7N6OQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2047.outbound.protection.outlook.com [40.107.237.47])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00592AB
	for <linux-rdma@vger.kernel.org>; Mon,  4 Dec 2023 15:54:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1Y2g4dms4GGFBCC/dSMwuyJWJZB9CY7VMOutYc/wjgMAL5FjcD8K4ZwhZUqU1lRDGXbXH7sWRUdy0CRn6uxNU9IDCvY7Y9jVFYPZ4HUtioOp9Cbz/u7G55FBp0qHpveKbgVdgCk0Zh988TtyzwWzOXUgHfDrjDCt/e5vl8qCAn221+/eV2/Rg7Bl0EgG5bch506oKH4h5G2LQSXH1hSI1f4NapDfUSXXvzMC3Cz6ipZ+ZY0KbIqfCHYMzu/uOZJEBw7ai9CpRrtqAJUd1UUQQMps6oJJGqZxTynBfudKTVqV9giBMTE4P+QAr38ip8GIsr+GyLWlPeOZaj02GxEcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naQA5jas2PVg+8m/A786DZQTDvbtxpMoViWpQZ1UUek=;
 b=aIzgv/lXxN6MpVzckokZxzNPtugS+6B8rIxrz7/hgsyu8dJAsdMhrCO+wTbElH0pt2I+tBxIpylMvSlfXIwa7Fcg8Ut1QEITn9bUOz8s30c1Wdr2WNrNSCBwgX1EMhavSk4Zx98bhn8ZL8/hEBwxDPDIWThbargh5f3YK2SgTWTeNV0NDss6Z7LrQnPC2+zyZL42rOcSbHLsoSOSzZYw76evuDbrMCzQkG5juZkH+VKoh7gTqJSHTPzuftfqEyOyaouvbbsiOg6YM0isQ3/DO1aUgTZQr2MsjBFj0VNL06QGDGRDjJdb9OEfdq19YLS2kgK4TLpaKYn0UpROFdRgWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naQA5jas2PVg+8m/A786DZQTDvbtxpMoViWpQZ1UUek=;
 b=tEM7N6OQQliCbN3BAbXSulAMLeJbGNQMKQg8GJpyTP40W46nfWspYsmJCuDXGaIlR9g7zEyIC3JLmS98LtmqtyU0nNFtZCu139b1VqMMi99JQc1eatRMOY0W6j09M95ZKg3YLYPS/XXqfhEXb3XK5sCskg9UdjNikxXJKvhqn7PBYKBABZBZnSjDDBSHyLDQ/C5qE7lo3IV/E0kFb3A0dvi922H8z6Qho2d1bN04H1SZgqqn0pWSOZQtFKgqehRu6sNNlqmMXIrNRgi2+oWcTK8fwOqhaKJJDleNFqMDp0Nk6LRsY8OtDMWQ1C4kYHn/Z5xWlzH1Rzn1w3AfFrWQRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA3PR12MB9091.namprd12.prod.outlook.com (2603:10b6:806:395::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 23:54:50 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 23:54:50 +0000
Date: Mon, 4 Dec 2023 19:54:49 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shiraz Saleem <shiraz.saleem@intel.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 for-rc 0/3] Fixes for 64K page size support
Message-ID: <20231204235449.GA2767549@nvidia.com>
References: <20231129202143.1434-1-shiraz.saleem@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129202143.1434-1-shiraz.saleem@intel.com>
X-ClientProxiedBy: BL1P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA3PR12MB9091:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f68f108-79ff-4c34-49e8-08dbf5246734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cnuKDh9OGdyeuIwi6ZylmB4nprsp4mOAqoHTc3I8IKrRCtVX0iRLhVruh6PpFAdxLMWR7Mke8ocYTtOCwPTQdti4GglqwUBiLrKtIWEVQHXIxQX18mJk4W7ImyndARtaYNYugiDTF1HdXUsiQhKFmeCVQdFVWozIjjKCUU1Au+HR9mC1miEEulXjwgKtMLpVkFD4NPh68Uw6BNuRryAIKOn0gIUpcX1xNvyBM8VmeuFvCgVfFzJnTvW2NC8zEedn0LUOEPb5jydB26VB4oBTRK3C+10LzkDA0ThKPh5YzgwjxcgqE3zNKd/4NbG4Dqkgjdmz4UwvvQkG9jAkVubv+YQNOKzetbswCg3xD6TXGu3FSO8wNs75Q7wZtCBUnpenV0JGCImSJDFu2jlLzUTjeJEgd2qv7nijRWBR+iVBuYD43OEaY3NBRzMvEQoVqXHd2fEn3DRPtbbhlD8frM4YN+Bpa9T97PN0HTGvZf4XJhGm1N6od2HQ0Q3o9ICaFknB0BRJv6mVAM4lOxx0BjenfY6ZbFm1/hKocgZgOGqS/5VdpvRpjvGqJXS9Bl7E+Bs4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(396003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(36756003)(86362001)(2906002)(4744005)(5660300002)(41300700001)(33656002)(1076003)(6512007)(6506007)(2616005)(26005)(83380400001)(6486002)(478600001)(8936002)(8676002)(38100700002)(4326008)(6916009)(66476007)(66946007)(66556008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L1v61+hRbDoSOxqRLedi/Wv8zRsS1S50HdylLU3uD00xBv2rEH7TjU5ZcD79?=
 =?us-ascii?Q?YBQoHgGAG5lRj2e0yqbcqotMNN8NVpWTcUeVlYENYyZypOdsQA7iWdkMReh9?=
 =?us-ascii?Q?rzszlROHFqNkfjEsITLhysslpHPAdKusJYoYjEqhEwF9UWCIwmGNoEQI+M4X?=
 =?us-ascii?Q?J3D/iK09N114wVmR6SNTQRMtSHn0Gf/mEoaShplfG3Kn09yMn5kmpxL/14Ix?=
 =?us-ascii?Q?/pj0g6zdSreLRgVjt4Sc17HNPBUs+GKivOnYnfnjiEEKWDA80rKB9kXIbrXh?=
 =?us-ascii?Q?OkPIPJu5mMzqiCJZg9BNJjsEdjVSwZjOgrWKLuf7ACCFM/V5VYCc9I6Lzf/C?=
 =?us-ascii?Q?yr7KF6MqL7/wy4FQ1/RLRgXKaEaHb2+VeJEbffT5xbWnCwuVoSe9zc+bwKBR?=
 =?us-ascii?Q?+m6aUYX/eva8uIhOVZlPhrxF1qK9E819Y0goPp1dfvGO0VBGo0jszuFtDPZg?=
 =?us-ascii?Q?OOs92gO8UnLyMIFnfsU8crVp79I84hDae6kXpsgmIedQN79/7mbTzJimu0Cs?=
 =?us-ascii?Q?JH9uguEMjHQZsEA+psasasndarhx/jZbht+55vCCqyX0Wo3WTOvsYLtBfAm1?=
 =?us-ascii?Q?TzgOITq5gfODmGFLiJGJAJiOKvt4Aqg9dLkcLr4by+ohcUapa2DclGJZFC1/?=
 =?us-ascii?Q?rfTu9tGzEzZBF3khN8trAKkQW8RK8a7BnJzkvm02inBXOHTwgCafaxFdK5ah?=
 =?us-ascii?Q?Cse2mmEB0VcypcL37Qgx1w4kl4oFpIH/++qPAoHu6UfBAmxUHTPr5H82ZCDr?=
 =?us-ascii?Q?1M7r/h1+VK2E0AyjfsLBXoUG/l9mXJy7X2eBPst0y2VGX8HloZvaZrcJ4+Vs?=
 =?us-ascii?Q?fElAZ5OS0KKaO8CCgRWBQHApVRHQU1v5/8xkPFPzxZoLaR2fyKH/KIfNPM78?=
 =?us-ascii?Q?YpHFQC51iEsu+3q9NvaedeE3uaY9ifhRwOrk/zgF7OYrgHooBOffbFwvFctm?=
 =?us-ascii?Q?aUkE+sZ7tkvjjkONysq77HDnF0n6VMOoBrkKvPwilTDkJuz/iAM1u/Q6jdee?=
 =?us-ascii?Q?fPxAROxclUgQ9/XeKfEBE/nyN5Q4MUPIqPVvKrdek5DvFg0bqOePIrFX/eHN?=
 =?us-ascii?Q?/3HPTYlqUCXfWalPwccnqONYCmoRf4LblnNEmDyAWbzkxRVowcVH2QdwY8VG?=
 =?us-ascii?Q?MlX5H58VYlCIqEQUtTZgtfaHIOqVmS/C45qaCvlrLLcKFpecGiOxNSdpLK9B?=
 =?us-ascii?Q?2g28KFBq4v6ChFiprw4By8aTcbXbI44UsyH8nPPVeB/RXYh06fPiut/a9I3L?=
 =?us-ascii?Q?YjL/4JQ4QTsxUIS3kwTvbT1hzth4BK/cu12bije5xxsiJ+ye1N8zcNHOKllO?=
 =?us-ascii?Q?bVBKTgQq8REmSo55o696/Ih8uBq+6Zd9XYHsJTgnQlTWzeA3IbQtjkbx7hc0?=
 =?us-ascii?Q?Y+RU5f1TYsKczU0ll96UPKsFJFKhp3FITDYlMBWEHTrUEqTMe1Eukiw5cKbC?=
 =?us-ascii?Q?+de+DTJiegvsNNZMD90qxnuZYog+moNrBRVMOSs30lJYXbeDV1Il2tX+fEtO?=
 =?us-ascii?Q?Px+bxlMlAPKGZdcDMed0b8RyJJLAnhYqmsKu2Foq9LEzCZNg6dbAJw3k1lOV?=
 =?us-ascii?Q?4omxiLldgZCPVvegbZM+2ARj8wienR3EsQVwiK8t?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f68f108-79ff-4c34-49e8-08dbf5246734
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 23:54:50.3235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RbqsxVwwetCcnqs7mkJITXSdek5a3kNU4DiWfmI2YCX1EWRf+9zH8+55h2F8bTnI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9091

On Wed, Nov 29, 2023 at 02:21:40PM -0600, Shiraz Saleem wrote:
> This is a three patch series.
> 
> The first core hunk corrects the core iterator to use __sg_advance to skip
> preceding 4k HCA pages.
> 
> The second patch corrects an iWarp issue where the SQ must be PAGE_SIZE
> aligned.
> 
> The third patch corrects an issue with the RDMA driver use of
> ib_umem_find_best_pgsz(). QP and CQ allocations pass PAGE_SIZE as the
> only bitmap bit. This is incorrect and should use the precise 4k value.
> 
> v1->v2: Add a umem specific block iter next function
> 
> Mike Marciniszyn (3):
>   RDMA/core: Fix umem iterator when PAGE_SIZE is greater then HCA pgsz
>   RDMA/irdma: Ensure iWarp QP queue memory is OS paged aligned
>   RDMA/irdma: Fix support for 64k pages

Applied to for-rc, thanks

Jason

