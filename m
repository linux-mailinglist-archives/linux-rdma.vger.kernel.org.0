Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA2A77D2C0
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Aug 2023 21:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjHOTAG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Aug 2023 15:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239712AbjHOS7b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Aug 2023 14:59:31 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D261FFF
        for <linux-rdma@vger.kernel.org>; Tue, 15 Aug 2023 11:58:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2q3r2Okh0vfqUej8Ioei7D/WTnciVLhhQinsYihwLBOPkPiUL5ghjrEyjTwCFKVJp4KWLnU4nH1IkLvlT6Wo8E0exZL6wsoii/EUXsk9H6LfwCMJCjA1Z9ZSEB68vvwV+tin5+mCtCRotFqaPguxI1NEVQFxwpgDF/A3Gl92TXo83kW7h97CFqOebQJ+PfbNo0cPzWmU1kYvBx1HX4c/iqDwMGfXgZcbJ52xzzqfFOwvuoePek/K0Q9BczXnRIf+7xjjQ/Q6uX917QR+Fj/F7IPM5/KoRamEqjDagSpvJOfzNSQVSJIkToZrmijd9D4oZb1VKu2LGptaMG5kSgLHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7Cyr5ttjrpeREc/fBs+P4ATQLwfXe6puD7YZOKADfE=;
 b=Xnu9DgtJa5lQw1FoHwyq+Ju/cxSFuvQ4sGDaCFEVnISJM1UUyFfIPeKU1oTCkV66ziYz+fSo74oCcQnLNlFAtB4HnkKmhpCIFg3+Cti6yXAeQC9GRT1ALdYys2vFw7x9z18XsS7tZat/lHHr37ryeqKsj/R5OJjlcQtm6oTLD4RvSswMMvHLOBJsCL7UvG1TECgFbb1qhqJYrUHm9moTRX1nGVpwX68FVW7+1c6oqnIvDZbBMcVGXgf99FZ/GZ9S252q0HnDd1dr4Lls/ayAUieHdayH8wDIHba9avMoOEJLZI6NqIG6ePAP0gwUHGZ0qS8Cni982/SkW6NJQxgJ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7Cyr5ttjrpeREc/fBs+P4ATQLwfXe6puD7YZOKADfE=;
 b=YYfFDuUeSN8aAW5gdrVzPksmjcQhkFeF01y/nPF0mU/9n+e55+WLifhIIVwdK6K1UWu1JPvHZJqk4BGRL777ltTmIuU6sxN0m/wNVHyAlrhdxrq961IHBI5BCZFCY1rR5AFV3IU1p6YpeOdBw+BZYra4IguyP3gdkwm9iuU0kmRIaFlSUhW7j9T4qLx5avWe8j/6F0Y+ojurU/aCIJXm+8jIJ6sAyF6F+euadwh/aElhmTisAArj6D6HdmyIALJurXGZzmiGKdoKiKzvT0Gp7VfsDj1X7kSMZBkDCN+piH7RS9N+dvF4ouIXlpEe0gvO0AkNL9hPvkY14bfl/MkBnw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Tue, 15 Aug 2023 18:58:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 18:58:42 +0000
Date:   Tue, 15 Aug 2023 15:58:38 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        andrew.gospodarek@broadcom.com,
        Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Subject: Re: [PATCH for-next v2 1/1] RDMA/bnxt_re: Add support for dmabuf
 pinned memory regions
Message-ID: <ZNvK3m+FqoD0t+vj@nvidia.com>
References: <1690790473-25850-1-git-send-email-selvin.xavier@broadcom.com>
 <1690790473-25850-2-git-send-email-selvin.xavier@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690790473-25850-2-git-send-email-selvin.xavier@broadcom.com>
X-ClientProxiedBy: SJ0PR13CA0147.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b8baa34-b336-4a09-2f8a-08db9dc1a4b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e/HAkq8zwng6jHKuc4ELJS7iLmhlmncl/JR9z8rgnTASAm1hr6tZyDsHNUH97Lb8sjOiqfyMTtboOgLAbT7pf7FpplHPjaxcbY+jyQX0nB+c5q/KNtfJX79TP3fHM+m/+MaC2iiFjkf9yaj65vYiL9DfQ+p8Ib4n5p45g554byXHFDnEqfSH6yGE24uSgtAJFjrQz1o40d/mGxdyp0BEcmZDqJPTQNFsMvCwM2nwW9WsAC6Y2qqRCqHCaAlU9/1y30rF9MKMgftMCpZWcZQBHJHU+zARFGpWH6vEXwE37HLvoNFM0r0ygfhwmBIUQ58oBRVVUtFTTwPbeADRJ7DYoOKitAJEeBGfuQhzvr+MpwyumbpfQCPspvW6gNoS5LdMxKm2yF8CNnupRA4GhvM9AyKPvtVZKhCyOZczV4WFAeMwPSWTQic93Hk4USXRaosljfvfpJDrl29kJa+rMbNieFFx/GD9jWDLKqKCa/sCLt41/An0qcowHDsaItmIPR6ERwjtoCbT+bLwKLoDy03TXn0H3NSchAj490yyTY9jTKzBRnW9idl0S6an8+MPzFm1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(396003)(136003)(1800799009)(186009)(451199024)(6916009)(5660300002)(478600001)(8936002)(2906002)(4744005)(6506007)(26005)(8676002)(6512007)(6486002)(38100700002)(36756003)(316002)(66556008)(4326008)(66946007)(66476007)(86362001)(6666004)(2616005)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lJ50SYwUJEu6zjuDr8NQyvCgUSef0ztDCm/71WcIqtmXsKVUiBhpr1VnAuNg?=
 =?us-ascii?Q?0/ihEaHc+sBUUermhrqWbBbDp83wa0jW9QlodXqTukfdj8pRmLwgbaDTpGwf?=
 =?us-ascii?Q?P46/pie+Y5kvxfVtWeL4h+WQxZ/6GR9OvEkl0+l0TSsfwf+BOdxACtgE4IP7?=
 =?us-ascii?Q?cwvIZ5uJI8Mqb4v2LcZJ1rwF3DcU5R//JsbeTkDc/kfmIEd/JwpQBVNYdHWv?=
 =?us-ascii?Q?hNZUnmvKfhUYkU6BV2fgpTyAjHPkHEIWGyHefk8T4Civ6oMBI7WrjyO1QJTq?=
 =?us-ascii?Q?kJPGKflIK5VJxsdJCrgXQW5GCaBBy1GzEExqhhPTj+vgL2zY/1DawQXea2u2?=
 =?us-ascii?Q?e7msftJzLRc0kZBN2soZDCiI15z193L8+wsrnH7fi2RuHXu3nv5b40WDE4ji?=
 =?us-ascii?Q?A6TzLvlcvxBs8vHZEc2y/2iLO9UsvqMnSnyiz4Kf2h9BhHvgpR9ZLisAapow?=
 =?us-ascii?Q?u55JVtxQztvSQU3t8RZToNmZosSQjHpWJMibiLePAH2IDZ05EWt5PFAwfYYy?=
 =?us-ascii?Q?73wq62J7hXaSqsPfNO4WBzZ3ggQfPrty4IaeJVJ5HUgEKZiZ1PJAeNZ978EK?=
 =?us-ascii?Q?+Hkv/KwGieM18qayJzqNSe9dWoRuEaH87baCFDuF/Uz4wdQ/K5pg7hQUNwN6?=
 =?us-ascii?Q?0divfb8LlIdzIpyI6CYoCZLvGOrijFuA9H5d+/mYl49e+nyfpp/6veo5BL9Y?=
 =?us-ascii?Q?Z8rbxmrVJ/xZHV86CLHqxy8pLfgX6A0jikk2/nd4TQvX+Dttivxsdlkyinq0?=
 =?us-ascii?Q?mvFKQ29ROId2n0BOzV6ALwReDkQev+XvaQHskHve3QFEsxq04ktFDCgWzgCc?=
 =?us-ascii?Q?5J13IIavfZvwXCrXkXMcEjH8wCJ5e+/hp7JrdqbW4EWR1eH5QK8DcOc6Ij9t?=
 =?us-ascii?Q?30/8dIG7uMGrNd9r1vIs+2D7ryfvSorLtMkfhwBnbK2OXibeFeRA43NUPrdP?=
 =?us-ascii?Q?d3gcW9mLGvjDwQbJmYvKTkrTFZmJYHAjEBxU5G0lx+s3+VqQh9lQ033wUO6x?=
 =?us-ascii?Q?bNF9oUHXIePS3cmt3osZg+SfNfQfXCbwubmW9svAQlRlXP8gKT2cBwUyV/eG?=
 =?us-ascii?Q?OcW+08QRAGi0C7amuwBX2AJ8XULSWbK6wS/jwY+gZpzPAHcXrQ/ygck03V9w?=
 =?us-ascii?Q?l3aPSynCvXegsTulq0SvU2t6tXY+ubDr23ccZctFSjr/1pZNw9q61TslkHHF?=
 =?us-ascii?Q?kEU8Fsm/bPSQvD9mMfeVpRR/4dFGDZRRkhMWRgdMh8Omuxw+sPpPR/RNrNpr?=
 =?us-ascii?Q?q7nFB1B9M3ptG2myBiiaqTqZFmLfAtaOMnijMOQnVW9IZrvJvwjL4JAr9/UE?=
 =?us-ascii?Q?sWcijQ9TPqcvRcvbPJL/LqiqSIpKtVHA4ozK7R8iS6dGUIM//zlxI8DLza/s?=
 =?us-ascii?Q?JkQYksxMm3a/1YBWUZJHk8t4dI7ag+mP8/tBpUhmgpcAMLhGfLGDnabZ1zbE?=
 =?us-ascii?Q?V/4q3AZDC70SqezGqKFIbSZBTpISYWhbm0/+zdtaFMx0qNDXSMol67MqKAdd?=
 =?us-ascii?Q?fahIyz6oaHHXXUAuj7tv4Z6AL7iaRnM2MknfDjNxsv67RThUsP+z0K132zG7?=
 =?us-ascii?Q?cbTFIFYeCrHh55M9kQniX5kvy8b3boZ8AYy1Fhy2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8baa34-b336-4a09-2f8a-08db9dc1a4b6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 18:58:42.3999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xwp4e24dXT01Z7qWlT1sdHbDJkhGoPr4Ntken8G2GXYAE69bU35j6FT9a5XP3taa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jul 31, 2023 at 01:01:13AM -0700, Selvin Xavier wrote:
> From: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
> 
> Support the new verb which indicates dmabuf support.
> bnxt doesn't support ODP. So use the pinned version of the
> dmabuf APIs to enable bnxt_re devices to work as dmabuf importer.
> 
> Signed-off-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 83 ++++++++++++++++++++++----------
>  drivers/infiniband/hw/bnxt_re/ib_verbs.h |  4 ++
>  drivers/infiniband/hw/bnxt_re/main.c     |  1 +
>  3 files changed, 62 insertions(+), 26 deletions(-)

Applied to for-next, thanks

Jason
