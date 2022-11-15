Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9B662A36C
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Nov 2022 21:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiKOUwx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Nov 2022 15:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238559AbiKOUwg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Nov 2022 15:52:36 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2084.outbound.protection.outlook.com [40.107.92.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E595CB866
        for <linux-rdma@vger.kernel.org>; Tue, 15 Nov 2022 12:52:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=godZgIqLR/uyO1MvJzerR3Znbu9HoyKJ5GLQiNMAs+jjJG6bdf3urlK/Hj3K2aAGOKLyCIPY3HGvVEV3SzvMyahp4JS43S18D47Hjvxj9xv4npi6uOtG5ySJJc8KfcigDVmEbTsuODMioQuaXfiXzdo5xBmqZceY8G1QckPY7Yw4oRSh+clDfJ3PzIDKOgTLDWcujezVAegKPjnRA/I2ceADE3ujnfaFPCkgtAcii3zhcmDznHrNCa+7lcweBtaAdTIfazmuniP4KGwbfeqvGWrdfSdG1g3ZCEnuscLy/BwE/nbxnDNAwTZPPtqGUTSISGEA8t2TwzwN4XcK1QOe2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqQ8uzWNruH25HtUAlTjD7Ha1CFq1yaeQ62hwpQ2ynY=;
 b=WhfeJpaLD38CqJSs3XSrgcEejRJMn6+SDo3YvqXp6dTrE1hzZvBd9bWQ3CinMOE9uVJaEUw1tYSv22XsLnOUEA4RMCP/1f3PMr0w76CYzRPFzVunJ2OLi1jUqyeO3Y440XChYxEE2imSNT8WvUlV2iPoD0qntLQgH9yK58/a78Poo7qZcazJmWYFmwj1Cl6bS7bvCIiPkW1LAx29vW8nfJOZLz6xho/a4qJhokvvVAI7XbIua7Wc30i44/dOiGDKJS03RKkYyswj5Hu9oUWjovxRNVHdWruXqz/1H4rxMGfw79z1MHRZGlxhnd+JzTeBdlXeqX9fReijJ2omn0l+7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqQ8uzWNruH25HtUAlTjD7Ha1CFq1yaeQ62hwpQ2ynY=;
 b=St70E7jUpXNn/ctTBvPVBFGJAKe6br5dZNc77rxoOC7yDiwROv3zgs7TnjRSyhJJk7CfhUWgkpwvuhiEv+UEeVPxY7DnriheA6vf3M4wb8S+ZLOm4WbMlAZJ8sUdcEFLzuxd9SO1FwHoEjBkHS4UEteJzn4HuGGWhW/RQGEaGnbGUhiGD7Jdj5BmIIof78M9A8WyrN+BJX3T1EMYsvqeQ0uFlvkDEKaXO2VgIBY7iAr22P+IZL1LX2unmiL2bekEvxurcmkhUD5E2RVlpBjudRIyvJ0G18PFOKNbmEcv+wDJRDE3BpFkYqyt1S72wYfQXYgPqCdWn7zXRSo605H9XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 20:52:17 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 20:52:17 +0000
Date:   Tue, 15 Nov 2022 16:52:15 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bernard Metzler <bmt@zurich.ibm.com>
Cc:     linux-rdma@vger.kernel.org, leonro@nvidia.com,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] RDMA/siw: Set defined status for work completion with
 undefined status
Message-ID: <Y3P7//cTbZXXMMA+@nvidia.com>
References: <20221115170747.1263298-1-bmt@zurich.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115170747.1263298-1-bmt@zurich.ibm.com>
X-ClientProxiedBy: BL0PR01CA0002.prod.exchangelabs.com (2603:10b6:208:71::15)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: e17f40cc-40d4-49c1-63dc-08dac74b47d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TeTmwAKvHXKlo+m4nIiNGozqgadRSeL5ux4WvHZSzaAIpHoYWHw8HCudnDKkOBTMMIbvDO3UDXm1OeqRQpmiXG7PwXIz6yC8ecTi0ee6IySvlvBbpq0XBvL2+DkVlNYgyrtnwRwNyRrtBRSteCgV7RTRBBGiz+K2UKkwHc+ngzo9VntQRbtGSmvpNQGfXo3OpSp6hW23hwz+FvI9ATff4OWlC13LHH1YShGgC1hQTPY31FiJWVBKoQuKQji+ZUrtoKDJa5To2ciVezUDnqSKSk/W7VJkySC6OZeBw/SY3dAwf6hDeVADK1eRyb3yVKatCd1xGo9cchrxWc77zZIKBVvic4NfHjGtsUkXKfF6cRh9R1RdCnTAVlRrhGTY5mKEe2vUcwnJbclu9i98hmVAObAtSjcuo5PmuDWmUAVpruCkIWz4gTu1PSQmiVktqci3Eq3uFbKAlimcdV82DwZxQog3Ullo1fTkFvan7NxLHuXauzjKtPsAii0pdd75MFIk0zmC5yCc9aSbdNMt5NL0rebzB2wp8+I70g/yyRRGATR9nSR5FSN/HGW19YkHpynz2KV0QrzFMpCtpBVrax70znMl/vhFrJSCnqd2LSiwNrLC2KZU9NcFqcejJQuZzvefTCZHNmL+YbidMqYVX7GKiEba+c+b8ez6QZp9obEO/+Mst/nWl9Od9+34oe4qSnYSddY+Ibk6mxAu8NgE0mJLZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199015)(83380400001)(5660300002)(316002)(8676002)(4326008)(6916009)(66946007)(66556008)(66476007)(8936002)(41300700001)(186003)(86362001)(2616005)(478600001)(6486002)(6512007)(26005)(6506007)(38100700002)(36756003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DaBQyRDeO7tmu+GOvxGozIdmbjk/z1KBkjEAMYxODtSRXtXLsoGGNW6ZBWz6?=
 =?us-ascii?Q?gtDMFv0Fgcrf1oTfXIzFluSOgWXSqGTTpWD/X36rBgFVLiuUOrTBZ55faFp7?=
 =?us-ascii?Q?uFSeqXg0hP6yNiNpnQw8dxJcHSm/06SdXYwsyiFrYoBX2p7sYOlB4JvowDmZ?=
 =?us-ascii?Q?IR1P/whlHxHLa8hElsP0esiru/kSf/LgeGWFz4+/P3IhCOilx+DDBywi3mNl?=
 =?us-ascii?Q?b9VQu2wux6JclTY6iVzaaWwMMuaayXIZMWFEmJgoGYEqmU/v2CH/wW6DBfYV?=
 =?us-ascii?Q?OxLAoZoiDJi/MoDoVb1c9j6AHRmqA5S76jfMmoCCgby9WJnkdctKSqQxDsNb?=
 =?us-ascii?Q?9q7Uh0ic6SFk0zq7Kl1VV84DllK0ybnLv8BB3BTer7duvn5nonPgpTCQtfPN?=
 =?us-ascii?Q?zn440/Qc30P+RpvW8PYp0F3GxlyewI5xH51lY9IlVG1Vbe3sUWpkiwE9kGIA?=
 =?us-ascii?Q?1c4khn05xB3XvLjhuW9B1kgVf4RYbr5GlxcmuzNR6IwmPFCIoFQQL1vkK866?=
 =?us-ascii?Q?I+H1nJHfz44PC9abQuEg07BxlProaKdzg5hSKdnKr8Tiv7ltVwaaPlAWikQB?=
 =?us-ascii?Q?A1OdWJhU3Lwv70/Q8Qj2zKfoW2EA8kMfHvSWarEKKNL39q1bmpm4yEKNTH+k?=
 =?us-ascii?Q?0NrCuNGI+5DG5qQsjy1z/gvbW2Kdfp8auZZapm88TnTaeTtaCu+8Jl8KZUie?=
 =?us-ascii?Q?Ka1ICc0hWOEzKi2wGJn+qiS68y9rWNi8241uBkGZz6rMxJiASSaoMlpgbN03?=
 =?us-ascii?Q?8S3ugtvtMB1yVphuFD+p7CGpuaGJqxr3VFd+V4tsioUUZYpNK040M1XsCRR4?=
 =?us-ascii?Q?+eIChUQRBOcgVQAP+Exfp/Ls78DABt6OqM3CPCXD5hoc/SZKM+FPNGqXYNmg?=
 =?us-ascii?Q?iPY9JNIcRllpIT18/FZ0XfFvD+AZGTbk6BGloLnimyYekgTvlhHx1Gg73m11?=
 =?us-ascii?Q?R1x4ZUzObIlFnakE56voRryNgJ/D2bPyRJML9XRTGnb9zYx1YPu6l+uQdQmi?=
 =?us-ascii?Q?B8RbNoCrDI6zKnPYMjzQ6vNK9O1Q5PbzTflSaAzw9MWDD3pGqhioypgAGDNh?=
 =?us-ascii?Q?zIT8IC7QuSJs96eT7fma/9WxaclskUa1R5QlA2ANDw98ZwC6x0icYqPcuD3h?=
 =?us-ascii?Q?BVM1qLTaiyODgrjTxhwW0z2ODcYnbPkvROgJNWdY04aZ0jgks4QNvjR/NTuH?=
 =?us-ascii?Q?13Tso+0Gi2XjxYy1wFTRItnMpim5mkBaO3XTKK4T4Cej8MTAtunxFJ5OFYm1?=
 =?us-ascii?Q?YNVQvSKaW0nfWbSANRzUJVgrzcWoegEZ8vibCchaUXJcXaWQP9U7CnUzm+HA?=
 =?us-ascii?Q?jDbZ9+lJVCy66hmQ5PEyef4tn7eJ6Q+f7DXGGtLeYPFVgMrjDfDMoDX3w8kk?=
 =?us-ascii?Q?PySaY/RAGtmc1yVBpM1Cqre4eyrHoHNMbHtKdJTIUzT8PPBoSWzwqX0y7njN?=
 =?us-ascii?Q?J+CQl0Our5p6TB1qU4mykA96QQiaFE4h281Z73FNpV0SHhlgMF3lBkMma/jr?=
 =?us-ascii?Q?4pHQeaLrJAxBddhuRDA5IiFYd6eVpe/5ldG33Urs+QpcJwHc0wJKfgCZ/2aA?=
 =?us-ascii?Q?ZuLmpi+RkAwnGkHc0ec=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e17f40cc-40d4-49c1-63dc-08dac74b47d9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 20:52:16.9500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhL9WJAe3KGFs7OZdjp+PYPQFEgruTaJKbFT3ngKy8NkIaNvf21HazsLJbABk5K7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 15, 2022 at 06:07:47PM +0100, Bernard Metzler wrote:
> A malicious user may write undefined values into memory mapped completion
> queue elements status or opcode. Undefined status or opcode values will
> result in out-of-bounds access to an array mapping siw internal
> representation of opcode and status to RDMA core representation when
> reaping CQ elements. While siw detects those undefined values,
> it did not correctly set completion status to a defined value, thus
> defeating the whole purpose of the check.
> 
> This bug leads to the following Smatch static checker warning:
> 
> 	drivers/infiniband/sw/siw/siw_cq.c:96 siw_reap_cqe()
> 	error: buffer overflow 'map_cqe_status' 10 <= 21
> 
> Fixes: bdf1da5df9da: ("RDMA/siw: Fix immediate work request flush to completion queue")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Bernard Metzler <bmt@zurich.ibm.com>
> ---
>  drivers/infiniband/sw/siw/siw_cq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
