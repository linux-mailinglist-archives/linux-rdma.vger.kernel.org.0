Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0931B45DFB7
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Nov 2021 18:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237447AbhKYRc1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 25 Nov 2021 12:32:27 -0500
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:50401
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230100AbhKYRa0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 25 Nov 2021 12:30:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEYZdCMCLrsUr59/u7FiyxI6sy08lLG9qGlR1uqXIdP06hjXsyteHanGhHrvfy4kzJ6vel5MfOgTcViqINZCTR2IXXyc377fhhebjrqKwICPZcudN3ED50oLLC+Pi2ElbbTiyXzKB1npTewiCsQdeCFkPf+k4cs9YK22Qpv7ddwag2gINenSIq2BuRB2dH12vYI5GpC80LPG68wqzdICxegrrjiXd4+qXFlc13Z9AnCIhaWx/Os2CtthdF3ZqVYVtbnRdXEM9OrqnGmmwALYyvUW3czzQ2FcQ0W8oFnie67ZP9agB8vdIdU2eXi1LYvHYNgIbfO8AHkOvWYq4egDAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drG8n16Kj3bHQU4k+6/zUoWsinVhfsTt4HI4YJ1Un5U=;
 b=SQVsbRhH2Mqthl37zh9etgIHthnHU+nZDMRcIi+D20DFHhBQhrLEuQxzhO4SfH5V4CGbZnI8PO62EIid1U2c0SbCsm/h3KkVEO7uTaRdP/eIbp1GCzIQm4xH5Rw0sZJ8mUZO2XSHK0q9LQwYz6/49BZrmw3GbINJIaLUcAIXb1fJ5jmFEt1bHYcKb++Rfp1E7dHTn/XlMuJBpEMkg+WjMMoAFtgu42++Aq+seZARVNWjMNo3LZ5IAugICd84LTQWrkGQ4OmUWojyzdqereThA0ocYok0eVqbGMSwURz62firC7rWbXU5FmvnqR6QemKcIuCa/NgqpKFRUBP4ZtaTiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=drG8n16Kj3bHQU4k+6/zUoWsinVhfsTt4HI4YJ1Un5U=;
 b=YT4MWIb73y0hI1uwkV1/hWMr4/vkHkCKT+xs0gbUKwY+kxyXJ77KYJnJawtugDLTnR0DU4vfVEDnZeYEbjyf2JjEibCG7JnOcwluIUVGsu1e5tLdeMvukHv9jR/nEoinoa7rNyNcwLMnpoao7bUAjbTIbkP/cpRNgOKWtB/nlN3ha4q4wQamD6qZPzjozuRHkDT5GZTU1ixyWYp+3lz7u3KCb2+R7DxqeOklq51TwE62UeOGHWrpVKi31UspjFF2bXKMRQ85gFGE09GR+noHMI5P9acqYPKffB1Tawe3wf1wTLvyjBbb0ja1plBkU9FeZvpfs9KqZkkGD5GwX9JYgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 25 Nov
 2021 17:26:26 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%8]) with mapi id 15.20.4734.023; Thu, 25 Nov 2021
 17:26:26 +0000
Date:   Thu, 25 Nov 2021 13:26:25 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Doug Ledford <dledford@redhat.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: [PATCH] Remove Doug Ledford from MAINTAINERS
Message-ID: <20211125172625.GC490586@nvidia.com>
References: <12fe41e3d0a515e4fcf5c9e62ac88c39e09c1639.1637616139.git.dledford@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12fe41e3d0a515e4fcf5c9e62ac88c39e09c1639.1637616139.git.dledford@redhat.com>
X-ClientProxiedBy: BL0PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:208:2d::48) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL0PR03CA0035.namprd03.prod.outlook.com (2603:10b6:208:2d::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Thu, 25 Nov 2021 17:26:26 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mqIVt-0023ed-Lw; Thu, 25 Nov 2021 13:26:25 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9105ecde-8e9e-41ef-277b-08d9b038b5d0
X-MS-TrafficTypeDiagnostic: BL1PR12MB5128:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5128AD4B5A5950436526F173C2629@BL1PR12MB5128.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OKBg20LwaTaYcnadW3szZ9LP1Xz1J58eABDxURvhRNIEhFumPYbR2IozeJ21p1JC9wWDzazutmTaukvadhOWaFOWYxzGVoFiPM/lyOmCCy8QzxGyvpGJejpu0zBtHaKRuyjxQms0TS5ZwOquCGmx41CKoA3Vl8nikMwCtrrCHIsVtXB4clArka8bc0vFemFzGikt2/8bdO6fhK7uoe+YJfDaHY0+Ti68+dAHzf4IASQUKsJnNnJzfgFztuiMzIXPo3jq83pgVX78+/G2vaKrsSxgPOZQu8jqCUSvXD0k6ymp49PqWfenU9eavcQ73Rw1xf1PyKsxLojem1+on9u7IO4/XnBKptTLdeGxyH3GPN1269dj97uQKgG+hAe75eQ8+bb6pLllw1bTDv0J32mqfJuxEyr/hkGz1NMw1OYF/Ba7kEbon2yJcG3yGcqhNUvv4qWcQDsZ4bldK+kdPtcyAmRbwYeACw2tmYYxfWYBkmLxgrCj5CsdElNIobPKEO3Kmb9+/cnaK3czxREt9PdZIb0B8iLQS+WDB6NVfXY5Gx5646bIVw2XhS89jAddcNJGNnGX+mK0voiiEEocwhpeTKVrEI2emksQUwNtolo8NuZM/3XKrUU4W+itEfm3+vQT9SQbftB4Gr2RUAaro+iPbM2JwSGR4ogxuTvYjC5Ywr1pWYoUKcm69uBXIdSBlesKxJhi5dmP20HxCRIPIFRBWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(66556008)(9786002)(2906002)(8676002)(38100700002)(5660300002)(186003)(558084003)(8936002)(508600001)(4326008)(426003)(33656002)(6916009)(83380400001)(1076003)(9746002)(26005)(36756003)(2616005)(66946007)(316002)(86362001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OWxVdufxlNV0BhfRk0/07HiQH+n0sYre6GkqaZRcdlq+C+ZN90HOC2+pprKO?=
 =?us-ascii?Q?ogT/8cr8PHTMPRENhpVBn/pcYip9ivD+zX5rWU0N2fuUFru29W8hF4e7xk7Y?=
 =?us-ascii?Q?in1bboD9LPTPIBWVE1so+yAkivxZ5ZYd2XEEcW9AgO8iPuL8QHgzo9eIs+99?=
 =?us-ascii?Q?/YDDTtv1EflwZ4M5+RTPVGk5P5SJ141BJ9qkoxIbfwX0rZxJjDYyiz3r5Jsd?=
 =?us-ascii?Q?QAJ0AHBSWUQB3iJ71ip071sha8uf7s3Qf6SQ8bvor8sAZNe5POx2x0H795lO?=
 =?us-ascii?Q?s1qbczfBFz2q23dVgSJGAizgmMFohcwGs1L/ewPHK8tZA3ixG3ZwiouUirrZ?=
 =?us-ascii?Q?1wj6s7XYu8xxaNeX4g2WHarcQ3u2abVH9dNhATnFtNQaF5iaTRs4jyrqGEDq?=
 =?us-ascii?Q?vqjgdZGuU6aCwGtQsUXIFqMzEEuP/PFe1o4K3dg3m4kl0dUBjKhnuaXbBPdl?=
 =?us-ascii?Q?Vpr6GWaM8YYxYSvBZFMpvXIJ1jaGNsot16eDiTdC0mG6T/5uiQgREAolssa5?=
 =?us-ascii?Q?DgLnteKyIklICR3bwGkLwx4XX93at3nnwBNowG+Qxb3neLouJq3XWaw7gGJ+?=
 =?us-ascii?Q?RGTDHThjTETufmnWkBU01WKeGUbJwXLrLyXo2wcn6QBA6MlkPrEqiTKI+CCE?=
 =?us-ascii?Q?gW6CmTTga8XBIBwnT9n0qEhae4U6n6NBSRWb6Vj17xX93aTHS0iAITVNv4ka?=
 =?us-ascii?Q?r5M0/1oHcU8qRssSMaXXY4wFkM3GaWMWa8Ts6c2in6wOyo/5aRr/y/lSRyqs?=
 =?us-ascii?Q?mHpH1mJrlmxde+iZ2SRZPBiiRWu5WArKE67T1zngqwHCtCDKuUfGPHGZ0Bah?=
 =?us-ascii?Q?6CxuZ7ahSR1s8+zA9MkaC4c6kCwaryWuGN3GozC93CXUTty2JXaKKPEw36zt?=
 =?us-ascii?Q?JTIPL0VwWmIpxYq1QBnG5sabXV7hr+oYpq6wW36OgyWAxyGkWXBDnAMOQEcR?=
 =?us-ascii?Q?z8Lktfr2Q5q7F5qyROppgKT8gWf0v+ravFFeregLSu/4dyTa0NMk6R3BAAMJ?=
 =?us-ascii?Q?bSedRhusc/TUa/EAcwwriSWlQzEKgiVH8NKVI03UtFRPJTlhWauh6zjcGVny?=
 =?us-ascii?Q?EvUqSjuIMtWZxxoFVhCZWVqQd7yboMBOA407Odv8wTJ431miW8IXTG/4Vwom?=
 =?us-ascii?Q?wB5LfkPXa7ZiGDxYDmPraS/JvoAtlX+bCbbi8v8Q9YW8vd7OVSv/gkOwtmV2?=
 =?us-ascii?Q?Tw8X51pzWYbenVPp0PJ4/rwzE8QALPsGDRt0YzLh+h267S2LJ64wcYUMzmaR?=
 =?us-ascii?Q?S9AlvGgn9NyG2SZg/7wiBX6a0US/qINGullyPzSyZTyOCghKYwq/ni0Q2Vk2?=
 =?us-ascii?Q?ty6i57SW//kE9BPReJ63k8lerBIAgbyvOik/6Y1jI247KQ95vLe5+qVjllMC?=
 =?us-ascii?Q?Phwq0X9hJVArgyxN37mENI4Xx7Obo0kqLldT5uBJyYc1X8XMfbnKl2pwdghU?=
 =?us-ascii?Q?Rkyv7uuRAaTGCBpZIP47c+XKZBLmkPBI1hMo/dELydPflVIQNblD7Gw7U4Rt?=
 =?us-ascii?Q?EtgR4EA/MgWQRuDkc07splMjdML7W5T1bfGjJp00BkayGSV8wHxBMtfnZaIu?=
 =?us-ascii?Q?xGWdXgnl9tZbEbHU3Cg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9105ecde-8e9e-41ef-277b-08d9b038b5d0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 17:26:26.5676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBO3RUkwIHQFVLLzMmKMjIrc0EQIJe7z0kjfLPBSH/WBePf0kIxX7kqYdT4OwrU6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Nov 22, 2021 at 04:22:19PM -0500, Doug Ledford wrote:
> Signed-off-by: Doug Ledford <dledford@redhat.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-rc, thanks

Jason
