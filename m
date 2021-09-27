Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD773419EF9
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Sep 2021 21:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbhI0TSo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Sep 2021 15:18:44 -0400
Received: from mail-bn8nam12on2050.outbound.protection.outlook.com ([40.107.237.50]:5089
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235964AbhI0TSn (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Sep 2021 15:18:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZrxPkQBeB4zyBK5jYFEPnw7oM6v6jG4PJdJehEXfakTfV7Yq+X4d1edJznadF4Dc1gE8+BEpQaBkzCbmDXjYEW1j08cpGHQk91QiILtPr5Og1lCUHJ55LcLT1umPpW7nnSi/8NoCa43YrWA5JLU1b1PNW7hwP0dnbzfo5bzgDzPSciIRV8JtINWFIOhgIgWq1UWrunSyP8ESZoCU48YZxrC22ZcrVycDp59o/0hMG5rScFasv8VQviJ+YrsmI7RpF+YXnYRkQDmouHKYd+OcGy2N0WXusDm1tq8EL7d3z389vYEIo9mmM7oBmbR+VnkhDMKyPqAlRU5b214H9GLIMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=H9tSwLGLBJSqfyzU/ngPzSQWpVLMZLdKunnfGaaG/KU=;
 b=f8K9tiiaHJoiRyuTMfDXvg18Z9yz2fmm2Nsl5olGtDSLnl7Lu26HsF+Gtc/ISF7pB79bJdYGp6tixLTmy+qBB52RVW44/9xwXSpG2oGgj0YVA/92ujuYOKXf2xflZZn06cZHj5ZG76wXLg1WcseMiwyBM7h/VrDbyWJF7zJRbgVWjomdt8i8jXNdqy2I1LiwBa41g1Pr/7RnKDoXI1Ff/ISsUYn+EqwoIAoVJ2X+cpAFAuTyCmFFcreakgEj1Va2rDoSZJicKO7Yt5eSdSFOBUvQWEehaSiewTPoy9Mp+4vP6LN4wMvliKn8v1akt3EoNCzpQY6uO98d83cU/U8GfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9tSwLGLBJSqfyzU/ngPzSQWpVLMZLdKunnfGaaG/KU=;
 b=ezvTFUu18HLt45mWDyrtzwAE3wjwGUI105V0z6l8L7RcrM7ym53NpEk4nYprPTwAGpThKLaJ/LqdSXh/KPPAYTJ+gRjhEzCmpyB97AWOCNW/DyPEz9+7STFMy9Kw2xiUgcYh74ktaQV2rINWTVyfynZX4pQT/VKx2+bEl/dew04QrEZSzqR1qOW2BYC+VFFc5idScpdlfW0146UnRg8FxuuRuTg7KgqTQXJdAKbOiLFCDwTF/kUj6DoWyhSE3djsEyhdqERAXTfz5DXCJkq08GNQorT2DwyGtKnrJYfxbtjrygoKCxhQgQag7yJ9+KdG+B0lbNSEWWE5KP05eByo3g==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Mon, 27 Sep
 2021 19:17:04 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 19:17:04 +0000
Date:   Mon, 27 Sep 2021 16:17:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Wenpeng Liang <liangwenpeng@huawei.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-rc 0/2] Bugfix or cleanup for CQE size
Message-ID: <20210927191703.GA1581987@nvidia.com>
References: <20210927125557.15031-1-liangwenpeng@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927125557.15031-1-liangwenpeng@huawei.com>
X-ClientProxiedBy: BL0PR01CA0031.prod.exchangelabs.com (2603:10b6:208:71::44)
 To BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR01CA0031.prod.exchangelabs.com (2603:10b6:208:71::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Mon, 27 Sep 2021 19:17:03 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mUw7b-006dYc-59; Mon, 27 Sep 2021 16:17:03 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28e6167d-0920-4528-8871-08d981eb63ac
X-MS-TrafficTypeDiagnostic: BL1PR12MB5269:
X-Microsoft-Antispam-PRVS: <BL1PR12MB526937EBC1DA24096B679C1BC2A79@BL1PR12MB5269.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHdynLKZLrHLLUmFzdX8bfw5I5G0MUVyIMAZR1y6O2UUYiwhp9AIsGm3MQz8sr1PDg0ErxLPNT88t8+nPP0Os44jeRIpactKTn1eK9n2vNlVAOnDjI226mhxrGvZE9/UmdG7KEJb/whv68h+d9lkLHaO6l1o/YOqr91vVK9/Ef9mbNtoUrovho19/PGtIjJUPmr2Qz0Azp3b+Nggxn4qjOr946mX+cD48oImO2S5ad2H4GdzP7EdKiq3jcnGytDKdBS0bqNWnnYAZ2FTZRjkkfPzSl7KC/8b94RVAgrL/1sW6pgeLAm5SdEijA3/aoi6uukZLO26ijFojjqPJsFB554Ep9Czh4s+f6LVkUeJSW/pDuFtG3bk63AanEBobmb6Vw+HzX60Ss67jzAl7Ok0v1GuZFt4M5P5hJjk3b24fiaMNGpQ0Fo5di5RhagPOCNhRUjt6dEgpNKyJgXiWIQHkyL9Lv4fEtMa/WVAbcQCCoORzGr46PQjyJjNJiIiYvcGw2xSBLoG0hR6X52eWfD/049O9X4chYeXfu/674JRaEKJevaYR8r2C+OEzXh49bpMOVGBrxPcbgebENsR5TacArwYNJmQrw96FJ+TA4UNaT5hn7dB8pRKlZkAkvcAvbbtKaLS7mhG9QQRb/AUTJOE9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(66946007)(8936002)(6916009)(1076003)(38100700002)(33656002)(9746002)(5660300002)(4744005)(9786002)(508600001)(26005)(426003)(36756003)(186003)(66556008)(66476007)(316002)(8676002)(86362001)(2616005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E1CO/vYe4p53PBATtLkO80D/hfhFHdOql0dUoOR1n53Y0AsOrTzP5Et047pJ?=
 =?us-ascii?Q?5VkeUrDM/W4PdLRYfbNtU01chuzKSUtGYi+4t+x4NyIOP6WOWigSdkxoVk7W?=
 =?us-ascii?Q?posF03BdAHGF4Q8NN0ouzDW9RPAf5PXdtBeqZ5IyIXltYOThJBmGfLeooC2z?=
 =?us-ascii?Q?3tM+e1VC3k9smRfHasM26zS5nsBD+FAZLa2ZmnnE+se+ZTm+k4W2oFTF9D+U?=
 =?us-ascii?Q?iWwh3kCblR1GOO94P4C8PUazPndBGCW1Nn4adMaeYlZa1Vv0hzjE9wmalOh/?=
 =?us-ascii?Q?oDLwOzuj7YSbw1vW76tHJrFDVaY8T++d95/ZuNyxrLifsJGWGAZcQgMiOAmq?=
 =?us-ascii?Q?ap58Cc0FSOXk5pmi5vNlaTOr5tOb+Q6MMKM64cJYrOckL+gYwrpPaxZ2E1o5?=
 =?us-ascii?Q?MlP4hCPAGV8YwcW5pcBwCfaiU+WJng9RiEMXjxZ75SuezUbU/fMabpJJMLEZ?=
 =?us-ascii?Q?JGeKSgpbKJmwZzGZU+baiAayWW1sVU7y8SFLS4ezw7zqbCQK3ID0miPUvuks?=
 =?us-ascii?Q?4uhqHd+pfKkY+ID6CaBy9tWlpaJ33xLMOvB+NO/cFHJqoMnvOqYe8wOgtOWH?=
 =?us-ascii?Q?4ULEdnyEqXZtHm4oSyR/7yLvL1rgkaf/aZygfVgsAXO1IYBFu0kxbqM6BFln?=
 =?us-ascii?Q?/Dd39RbX3MnWGjPZmkh9EV6IqjnoD7WYorNP0aYQCM6A/ixJ2GsrwURh7J2m?=
 =?us-ascii?Q?k9ZFuURX4CQ8z5GE0KTJUeeDv96ypfVF7WBRmJW7QYEaMm+zMBbEtvlJD19l?=
 =?us-ascii?Q?2DadGIgFXDrTUrd2aDBEzEhdQVU21D9N4PLymDYakXpHvW18fpj+CUeTNfEV?=
 =?us-ascii?Q?ht6StqfLfFRvOlnP97fKS03jI1hVO22PPzLFCrl/vogyFRcxZ9X/F3wGqd9D?=
 =?us-ascii?Q?R/NhC2nSo3q/AFbv/Az3RpBc1r7F7R5LU1LCj+dm09KpsGdbtWgZ1i+6IScN?=
 =?us-ascii?Q?ud+5h8o8YIwetg5GCqwf1JmePqACCS9weNmGBnSqZi2kcQQlNFl1BLXXCMf8?=
 =?us-ascii?Q?+EeuA1KEF7idT2lJxGVIeM6GUtRhnuwQss4DmCPFoyz8MpzorOSXUy3cLH1B?=
 =?us-ascii?Q?uIsGrUH/+NzrgJ9Hw04MBGkGVInBGSS4M/5+Ia/SA60mlBvT4wU+LlcOuwHi?=
 =?us-ascii?Q?4WCCkfOrtwu+zTHdnfdn4CX9iFzV0x7q2n7roh1vT8LiGWtF38XjkYmixGfM?=
 =?us-ascii?Q?3n4nG8OmLnj46naR9+tpitReVoJUxTH2pD6EydFms0+gKlj1GXoL6sNqqq/4?=
 =?us-ascii?Q?h+fk9KlHvlSLbs6cprLHMZtPCBCZ0yvAFKp9/Ej0Oh9jyLNPnHCOy57YvdNK?=
 =?us-ascii?Q?HTKCbCH0dftozi0HfoR8fRFB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e6167d-0920-4528-8871-08d981eb63ac
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 19:17:04.0618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSqRj7qPNKtoFs/CKbulNs68QUHKYtUD9Og6iat7EMKUyeqJyQc40MrkaWvpJvX/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5269
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 27, 2021 at 08:55:55PM +0800, Wenpeng Liang wrote:
> Specify the size of CQE when copying CQE, and add the check of CQE size of
> user space.
> 
> Wenpeng Liang (2):
>   RDMA/hns: Fix the size setting error when copying CQE in clean_cq()
>   RDMA/hns: Add the check of the CQE size of the user space

Applied to for-rc, thanks

Jason
