Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26753F7BBB
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Aug 2021 19:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbhHYRu6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Aug 2021 13:50:58 -0400
Received: from mail-dm6nam10on2074.outbound.protection.outlook.com ([40.107.93.74]:41185
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242258AbhHYRu5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 25 Aug 2021 13:50:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdfnBtj1OK88FQoIjvecopWD9lt/simdTpmbnwLglKFriHWwpdNR2D+/VJ/IEtZGuHyvIqQ+gIcbMd10pLB2u9lNn2hApvDOYYXQdSQPjcmNWJJ/aHsZvHHHsPUrGY26dqlblstLM2kn7ULSPgEKGppwSpNDJiTyYv+KbN8fOlRW3kp0mAfNCgow8YAQ8iqSvBQhdLZZ+IuNc4oscCHZJPVT72A9iAy3cvzJNXzJbW3ZCBg9CannFsLG6EWK7Hd2l+nUVX2WSYkk9chPCP+2qBnURKKiWMpkp7VSVDYzbvbbbues23b0O2AUU90HZutlKxy1jOobVQsj8TUPc97LIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K35TaSsnMxBk0q6EgLZjYw+Vo6Ugwxd+weVHdDKcrDM=;
 b=YsQ+7ukYbQlnaqBmSifTBIv4L3traIcPSpzxNy1lTcu4oupPEd8WiicwaUWS7UhD80iBhOo4BSnP2U65nbOA7RcpaFcTAMNiAs23WlZ3edLBXodF3N6YoLdRhr9srGpZXmGhOt64+pYcwNZJ4ODdnVOmmF2KQd4C+mAxD2vzIbSWV3R87HyY+WwmJ8gFBpxoP3XASCMFLfF1yshM3ZEPYtiLXNnBDOaxp4oumWx9gVo44bQx/QKPFeNwGx4NF/q8kky6Q4KtiqTHTYw3mnEFGREo8CmcKdumtkfgQ0f0ENtd2iZlNDyyWf59xtbExsSrrPLrIcMdTpq3C0tgXwPOnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K35TaSsnMxBk0q6EgLZjYw+Vo6Ugwxd+weVHdDKcrDM=;
 b=LN9ovPGO+3AHNPVJtwY3XLBsD0/+r+cTb2a0BWBtJyMp9Kafj8gSuOklfAMA3DCmfQRinhGkB4my91BtkGC5RChbKW+3j4I+hYbnWleBN17C+giuw7JTOAtx8PZvjG6BbLCuhYPNZIYir7/e8vPGolkYNK/E8wAnuZA+QzpluhHrQCsjg+98umpgTJyYtcG7VAaQz0xX8g0adSxbgsuF3GekfxQnUMevKb2DQBN517XsEftppe+VeNxNhPJ9rXCgZWtmxT71xdsYkMZth76H6ljdQregMAY8gU2jCszkyehfgylYbvwAOrixu9wyBbBMUg5R6Hodhf7RRZVbycdngQ==
Authentication-Results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5142.namprd12.prod.outlook.com (2603:10b6:208:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 25 Aug
 2021 17:50:10 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::1de1:52a9:cf66:f336%8]) with mapi id 15.20.4436.024; Wed, 25 Aug 2021
 17:50:10 +0000
Date:   Wed, 25 Aug 2021 14:50:09 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-rdma@vger.kernel.org,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>
Subject: Re: [PATCH] RDMA/irdma: Remove the repeated declaration
Message-ID: <20210825175009.GB1200145@nvidia.com>
References: <1629861674-53343-1-git-send-email-zhangshaokun@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629861674-53343-1-git-send-email-zhangshaokun@hisilicon.com>
X-ClientProxiedBy: BLAPR03CA0050.namprd03.prod.outlook.com
 (2603:10b6:208:32d::25) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.113.129) by BLAPR03CA0050.namprd03.prod.outlook.com (2603:10b6:208:32d::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Wed, 25 Aug 2021 17:50:10 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mIx2P-0052G5-8V; Wed, 25 Aug 2021 14:50:09 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 858911e8-37ba-4a95-a172-08d967f0c869
X-MS-TrafficTypeDiagnostic: BL1PR12MB5142:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51429825A39E32787C7B6229C2C69@BL1PR12MB5142.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n6pVorIZBorC88/EnDLLVH6ASQnGvwzvWm9QoSGM90g7ENBeRCmCBbfs1HmxuduRaG4F8LH52KGZvVQHDd7yEldEflIEh8X5IQmYdhlgsWiOo65OeGafzn+Ue3B6ESeOjppzM2HDYATCrgWKmplK2kN6hcvBCujrRJU/WvftTZjNGc76X9CuPNgguWH00KpzGV99us5yuXh6uWM3VpUgZlCKNfGAh6Lqg2zFaRasp01XvkkqDDX9LeWQ1GlC7Y5hJGge8jGEv6fQTh1twXTCNOcsUnFIALAmkeZbWC1hIVlXlsLVQvAItA6NaLhuFkfkOeGs6uabeXGKdgr1UxqX8Ao3zROz3dWasUj08xhzWOLv3f7ulXxePUgzeNvJzWgKXZfuK8+9ef8WFNsj1Fp8uBllBIXe2BdZfF6jiArvwKyJ3S+K5eAVRiRtr+cQyvGvMxwelo1ciouIGB15i1f7EPSjbfXXYDUAbIFqcpzX5o6GR/vTbi16oDskwwaLfEjJwt3RqqsnNHAoZFK/tGqJuc08QWT6dbz6X6/oTR+h5AzIlE74q7SgkC5Hm5U8FTpQ1xcqVh9MwjRhVuuC1uvmua1aV8EzZXhXzE0Z/Ar0l1PQVkZYRtUATwkKJ0k5P40zaUMrJFUULmSnUgaQp0IbNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(366004)(39860400002)(38100700002)(54906003)(9746002)(86362001)(8936002)(2906002)(8676002)(26005)(9786002)(426003)(4326008)(2616005)(5660300002)(316002)(186003)(4744005)(33656002)(66556008)(66476007)(36756003)(1076003)(6916009)(478600001)(83380400001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IDwE6cp6xzY++5zexukdv0nyQnpakGwDnr9ed3vTTxJmdFpNfyN4oYs5aFXz?=
 =?us-ascii?Q?ZLuzh1AH+iEjJzjT4GmDmTwi6KrJSDlCY1aa6Bhb50TXfYfaSRHaHzp2iAvd?=
 =?us-ascii?Q?UVO9JFbPR+FW5EkYUCphxyNfIiaQXn74Tgrtgy1wmMBq+BG74X7HjQO4Cq/+?=
 =?us-ascii?Q?EDV5aOgWZsLt19UVOTYpgncslp482BvvKUg6QnnEYM89s5R8QML6jR2ZPOms?=
 =?us-ascii?Q?w5IEvWVTFfAx0eQ/OQxaU5A9z8KMUBlF4xmBe9LokTa02UR7DkeP2MsaNboi?=
 =?us-ascii?Q?/kwy7zPuxr2xrUQyx6dJL8897LO8IfkOmNZU7WFELqKSkh8X6ReLozFuvaRR?=
 =?us-ascii?Q?4cGewM6r44dfj9aGlJlVcL26Ej6jaoFJLcfgzyjYtVCjbfDpX8rzCXUAFZT8?=
 =?us-ascii?Q?vZ4lieX1oFOwtDL7ACmapanWpVSWE0kHMaNYd8r2gyHqY4oiPk4TNn9Fi24o?=
 =?us-ascii?Q?FVt0YhcLbYQhNuAL422Zn7AT+bxAi4XSokQkRBch9Nj38pCPiyzvzVBCj/yq?=
 =?us-ascii?Q?sFpxX//zfseR7t55/63WGTp5tA9tjYZeXp8YtFwkkAW8u9lRGX26yqDDalwA?=
 =?us-ascii?Q?NoCE5HG6Hlz6k8btI/5iyLzX6dhOoPn8F5DOxFcYdWK4z4243TGz2TEJwtAg?=
 =?us-ascii?Q?nod6CnEnCMgrPVlbHX3IbPFNEns3llzQmfGvlyzba7HTxun83njyPGHEP4dn?=
 =?us-ascii?Q?wSVoKB6LAG3lmOuPeSQpLx0GaSdxcKgdavwoc1K7/vSmndCUcefcCWTi7oHT?=
 =?us-ascii?Q?9UHuC6XTcdszfCZMLGTIk3GmkbkRoW4bD4Gj3gJxRZwsKKS3A8l8hEk7unYT?=
 =?us-ascii?Q?1xzDbV0yGJJOEj4lvxys45pRR7zI1X20shTzV0O4huTKZYXaX7WO0iFZISCP?=
 =?us-ascii?Q?WGEhnV1kqvKiFOOOn9HYnL+TkVevpmU1zkxNjIoj+w808LKEmymuCUj1knnf?=
 =?us-ascii?Q?hkQnDxzmVLoOXqYwLpnsFU7Tmu+Df/l+kz/WMyjwfa9D7QdVF+bujq7lx5IQ?=
 =?us-ascii?Q?QBqzkj+M1TLSPuZtwuKqLbq9/EAES8DnifFNBdiBrZ+z5Kb6NVKdJ0vsoHOc?=
 =?us-ascii?Q?YZALen1FASbBjvl4LNo7JQUGgiPpY1zQm8zS/a24ZE9cbZDGPghxaqyJA3Dl?=
 =?us-ascii?Q?T8crx5HEMxwtmDcwRoTA/FICTBbGJsr5gyPaEdV/F14qNQr1tMTmV94ODv7U?=
 =?us-ascii?Q?GkVaZStAIqQ5Le4CbMxeh5XJ5PzhtevjYcB5vDb32zrTyaOF/ePLD1ZPUYMv?=
 =?us-ascii?Q?mKzoA0POIGa3drfit9bQFIey2wY01GRuNcRFt/0ZpugONM/m0GpeqATF50/y?=
 =?us-ascii?Q?mv5XeUiLB0TTsBRavxwdSjtG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 858911e8-37ba-4a95-a172-08d967f0c869
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2021 17:50:10.4312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0iT8N6w54hGxtZdHdh7QeAPXtcJM8ltGmGEPG3XtK5Hgrpw1sJQ8jWPJFRCIk56F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5142
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 25, 2021 at 11:21:14AM +0800, Shaokun Zhang wrote:
> Functions 'irdma_alloc_ws_node_id' and 'irdma_free_ws_node_id' are
> declared twice, so remove the repeated declaration.
> 
> Cc: Mustafa Ismail <mustafa.ismail@intel.com>
> Cc: Shiraz Saleem <shiraz.saleem@intel.com>
> Cc: Doug Ledford <dledford@redhat.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  drivers/infiniband/hw/irdma/protos.h | 2 --
>  1 file changed, 2 deletions(-)

Applied to for-next

Thanks,
Jason
