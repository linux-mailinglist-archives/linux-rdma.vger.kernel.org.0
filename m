Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974156DFAF9
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Apr 2023 18:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjDLQOm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Apr 2023 12:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjDLQOk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Apr 2023 12:14:40 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2045.outbound.protection.outlook.com [40.107.102.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE141993
        for <linux-rdma@vger.kernel.org>; Wed, 12 Apr 2023 09:14:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/Vy4ikIO1Wmqrasc9+n6NYsdzwI6Qwsi9jxOjgQV9u9ygqKPmCmE5pA+ZQbbartY2jaIRCbZmkFuy7AnGxxz5c5vHR61dJr86CqWq4ZoUVmmhr/t1cLzR4RCILQaDgulNxSAF4X5AeBS/1nzvEec98XBG2SPaJdwLDetnGMgob45rcIp4t3ePhsNF5i2TiMKp0lcE+2UqVLnFLaSR56+NzZ6AQ8i4fupEjUka6XNuxO/ei3whg79u18rwIoljFL4rkKmvnhEUZrB8/SuVNXR++5L2Tg7eW/r4fMDQQgp9dTdOvZUsB+KJqw91O1SoseuwOUN2PrGVuymHSilJI4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgGfN3qMS2ENloaPNyBaOnHAfujHwpQxABeoZInQlVY=;
 b=fGORfUSVnYyOZv94gTaSXcWpuR2/K949ExVutPMD9ZnX67yzPmiOEzhgBlBB1EVntMuuMFfEqS9/pETXVTgmNPDmw6FT9S/+aF+fEts9uoaa8i5a60wYzEUiP9eFhTyQOLql28djm+mdfbzeVQMFuos9PLZ3tVuDkJXuRwFTQhomm0SJzyyfIv+Jt8wMIXGrQlzTyBsqkz9sWW39wu3W7fQI+WxZ4YcXmW4Xi05pCNAvnais3oBDX6PwxqkUciuYKFdwBqtu86HU137/BQQ8e+fVMDVgcnLLVhBu6DnR1JCveCv1cAQ81QYsK9YMbL4vLcKYxyardpzzz87CL4/5Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgGfN3qMS2ENloaPNyBaOnHAfujHwpQxABeoZInQlVY=;
 b=JSa7+QPpH17MLSgflCGfIM9+pMD0ajz8NEq9q2Vs9JJkxnSKTbMP4h7hFfY+UJZy6P4YVSbirYTC7ieJc9pwWprIvRYswTXGu6zMLZ+Vvmjd3YL6cNpqaDSwbumFQMBjpZ7ZfNeAnRgepCE6lTPnkNUxUvERBd/USAbLApd7NuxWm/MVmv3ov7iN+BbvXwItMcAjHSq6oYOyf5Quct8TiOe/nQRCsH8/vK0AD4wB1iAIeBtBBr/0TqdmtKhZ6+iIKncOttz0kbvvzMMMkrxW7P3jS7m8MO4lIbxtAQznZlBEsS7YdbjkZ8Z9/tMZqh7NJaZWHbhXPhlpFQtXr0gcsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ1PR12MB6146.namprd12.prod.outlook.com (2603:10b6:a03:45b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.34; Wed, 12 Apr
 2023 16:14:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::6045:ad97:10b7:62a2%9]) with mapi id 15.20.6277.038; Wed, 12 Apr 2023
 16:14:27 +0000
Date:   Wed, 12 Apr 2023 13:14:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     error27@gmail.com, leon@kernel.org, zyjzyj2000@gmail.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Fix error in rxe_task.c
Message-ID: <ZDbY39Oh9oue6VRm@nvidia.com>
References: <20230329193308.7489-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329193308.7489-1-rpearsonhpe@gmail.com>
X-ClientProxiedBy: BYAPR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:a03:74::16) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ1PR12MB6146:EE_
X-MS-Office365-Filtering-Correlation-Id: 3db4dcf9-c98d-424a-bebb-08db3b70fcb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ns+dkV2+rMU2OySoZ97xDdBPgV4ZjbWiawcFOGZaF+DGMZnNBxFttGw3oZoD3e8UhgjOdnrKNsRcoYEOU/ETAxyMWQV1dtiCWHIxDU0xl+oORlDfWv1xq2n6gDm5TagSPC3lNPpVT6lKTzCX8tR3sAzsZtUBZZTsBO4NDWGJy22kFX0H5athbNtTOqadOrWcaG7pizZ26fDG/+do13uZv+fO7ANHEHNHe2tvW9skR9w77TbC6hmoQnQH2KgfFcWf8WB6BAiCrpLA8BIYlHWERYf3WKbui9vof8SYntR7pPM1qnbW/JE11gahxvxFD4e2N1UYZCV5GlwkjQJflWgor0uRhSy9DJVfkvOuNLxShveRBHXTjDRDNgpNfT4/xQ7sXDM3k5DfSGGyA9tmV19q8YJJnVFwWji9ET6to8cCDXavQNsbD8GnJpYQ+9S4xBbLYQU3R17H5sv2ZhR4rcQjfxo3hZ/MjuHKco2Jq3rT0oWvEbUReUU3mIuvoOQqaU6Rvzcw57O9br/bB0MHNbIpl6Zmci3um7Bmre9yH83K85fhnASBjf0d3/uR0M6NI0Ky/JPZmtfkV3oQN1rKcTAv7iqwHGh2ffkfZBT0N0wJwFE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(6486002)(66946007)(41300700001)(6916009)(478600001)(4326008)(8676002)(66476007)(66556008)(966005)(86362001)(316002)(36756003)(83380400001)(2616005)(26005)(6666004)(6506007)(6512007)(4744005)(8936002)(5660300002)(186003)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MczW9p9L4VPrLVDB/YDdogrxfDFMgq022jIeG9rzomMHct2HKL1/aQB8RsHN?=
 =?us-ascii?Q?Ux4D+RKL9mImMvwvLzNYPlx9Nji639DBhzARRdei0l2xVa6sNXLNDK3+d/PV?=
 =?us-ascii?Q?1yMb3jmRf/P351ZgA9NxuLD2oKs5GeEiBw6XZg81HHMBESNSzxB5smKgqXBy?=
 =?us-ascii?Q?0IYYuucKV2THSyRLdkaUi4USErfbALO//j9YJcojTsFfeYx0uQXPHnP+uqPh?=
 =?us-ascii?Q?ElT+uFrlbxIs46lRdFE6a3+tZj0pjnV4wV+exQlljU05yxOKb+bemn6UJxzy?=
 =?us-ascii?Q?1XRieeedwXcj52iQNx9v9cc4URG+T66J9SCmZlh2Cx7LusOJt4uwJVAKRlR4?=
 =?us-ascii?Q?2Rv5QcQSloSQrxdGP2J8CJQdOacTIN2nW0A/6IO3uoyx7q05QoDRFlo/B/9p?=
 =?us-ascii?Q?m04Rr62rdcSB9SQH6WjTkXqhUCxqbzr9BtEnlAlHOZX87oFytvjdHz4ycNuP?=
 =?us-ascii?Q?OX76OCEdvuKzkxranq7sHWUB6RB61+KUhc653Nrtp+IhnPib0CzfHlIBqCm8?=
 =?us-ascii?Q?4sDnNCdQHLTqnpN+h+WYlAm+pWJ6vLuUAcfpwxxSL8/urMeatFfHr+b0Q2gH?=
 =?us-ascii?Q?zlbw/z9tJJWI2cVwkvotZpujfrSS4sUMOecWSJ2gpIXgzQcgELPXDyZBT/+N?=
 =?us-ascii?Q?sXPpWt9vgJ+pyygLHKFkLZdvKvdmWjnkcKbsD/PBGeYuzG/T2FKN6Q+yfdzx?=
 =?us-ascii?Q?ntZL9dMaJHGL2Ejit/pKelPHvj+9T00W7Er1MbK6/5+MSXBJg5+Oc+olvu9Z?=
 =?us-ascii?Q?wqt8GvFfML/9v0JiNOeDqgsAmjSGWP0Z/0rto8qSKzQQvPkOTtyPIZ44asPX?=
 =?us-ascii?Q?ReqNJsTqnjKwM8yD9oHFQbszshOBCh0y9O4PPvxYKvZzK5Fc2mZFloJze1Wm?=
 =?us-ascii?Q?5Iumm3uCRU4DQx7vra3nqFFODfmG82pK9DWp2inaeMu05rY87hI+Vvw3M7bA?=
 =?us-ascii?Q?G0TOBikyZ4BRuZmNBjUkGM6+I+sO5gTyZiOi+MhL6hCBgJsI39SqkAE+Gp34?=
 =?us-ascii?Q?dJLLzh+X6JlUEHqwaCIUD5BlWBtq+5Luqh/0rwB2OnnoauE94gsuRk/N3Sea?=
 =?us-ascii?Q?K64gfdi0kRhA6xgsThC0kepRA7f4PSRHaAiHqOu/NahqE9OXy+k0H3LgsKiA?=
 =?us-ascii?Q?mneFzhi3/pOKjWqE1/8qWWAlWoPiyZObQV/oGCHp2PXgYdgnM5tbz3juQSZ1?=
 =?us-ascii?Q?jtzYAoS154IyqijNXVUJBj7vsRbm6Td9YAdgBQ+TwKboWl+33jWhOFXzK8Mu?=
 =?us-ascii?Q?/XBnpOik8P16mF5KlgaQvjXle7R4kKV5b/H+y9IG1AgVZW60+xNl5pgUisco?=
 =?us-ascii?Q?xVUX0KxYcmjdeBHY8+S0Jtpvrz+8pE9CyeHdZGiKBCTay1eAYdQQ+VGuogmI?=
 =?us-ascii?Q?jxIju87D7+yG46JHWarFQmo7h8WH6AvlTvV9GDm3ecnyUf8UvZSyzSdeA3YL?=
 =?us-ascii?Q?xphl0E4uKNrI7/rHPebTysdAMEaf7EAvOOTxf1OIKYCbScnlO/WWXpDggkEP?=
 =?us-ascii?Q?S7vpsVSUEXN09GqIjZYgQ0Bzy4+RF6rECRU0ZoUGBcGjiF1v1dW/AqskHD6d?=
 =?us-ascii?Q?2+PYvXVbY2bEs2CSE/nPwfW10LTyUkY8jf1tNrzb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db4dcf9-c98d-424a-bebb-08db3b70fcb3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 16:14:27.3199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +KMx+BOIvzwnlHJ8TruC2iLHMSlWXDOOY3g2R4axmw8y9NQtnGqPNKDfZJhUdUY5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6146
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 29, 2023 at 02:33:09PM -0500, Bob Pearson wrote:
> In a previous patch TASKLET_STATE_SCHED was used as a bit but it
> is a bit position instead. This patch corrects that error.
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/linux-rdma/8a054b78-6d50-4bc6-8d8a-83f85fbdb82f@kili.mountain/
> Fixes: d94671632572 ("RDMA/rxe: Rewrite rxe_task.c")
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_task.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next

Thanks,
Jason
