Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF0340B76D
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 21:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbhINTEs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 15:04:48 -0400
Received: from mail-mw2nam08on2059.outbound.protection.outlook.com ([40.107.101.59]:51041
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229658AbhINTEs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Sep 2021 15:04:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUFEwqwcWd0pBIegUvLIhW9tGr1gPoWcPctr0GNqYp0DqjDcDPUiDu5GExXShw892WD7V8PlVxeMeea4JA1UFdhin1sk+k6NTURFkKeAKQ05Yp157V0Y5mlSfdb+AeK/lfWrRErcSvT/yDaDEOQBhna0ul8equb1ORrJY7nmb1hmBgrXGEfWfVuG55V/wqswpEGVWvhhPKFoukNERw7eBXe4Qweyyxh5yAzzY/LkfPNc9xDmZNPFzZspk4MffuFldH6IPxOp3/qKFITztgWaftP0oWLZ62oJIlO/5uS8yxRu62w6p8jmkGkgdG3NgzJz3yIn7iWUF9r81DMIOkey+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=KOsR96AuUPZ+PuNLPrUEFmT7J+lOGOnyMgYrJ4D4IN0=;
 b=RDUOjS+Gk7nN5Z7wuQf0ci2UGe9PNLvwkAGTZOgJ+OOpvfgaz1EPQ1yOi423xU7zX7urA9uFWwU+zttzTU+wfDcphqgzD8hxuXVvp/8eRQU4MJrC5WyzvEgPDZutBNuGG1Sf9eElFfG7JwZHB3grAStvLtnD+NijqxDSQINAkR+Ll/+LUkmEHw0RsseoeuTVVj+XVCPiYhZI8E7tkOldY0QGQVHoNoRRWVstk9Bv1IC+dZxLAUmK6YW2NnQdGewgM1BdV09FiC94EL9WG/h1CfQm5/q4X7smOgh5F47WOOy10tUwbB8P7H68KG+JFI3JhfP04uQjQkCh2dQYesEMmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOsR96AuUPZ+PuNLPrUEFmT7J+lOGOnyMgYrJ4D4IN0=;
 b=srgxvS0N+/fO6tyUHb0krOGUqvvd/0CPYz1S8Y5Xjni3SgrGMgwAG6GVXJeWa8PDuYBQigkn0XkHxWelf3JcFf8XBkjzkJ2V/g3IK2D8oZCk4SwF7dYD67rIfkbiV/rupK/5lOYxJ+z6kGpMGBnX5APTauoh1c5iMNv3Ekgdao/HHG7nVhcM8gmfmX8qg62XAtHhHTUfkfgGwPbwcKzLjTB69cGJPICUgr5D+BIC+Pc6DQ/JDHQFD6pNNJqwwQiFGaqL9dRmf09sL9rFnQmCB/2R3qWq1p4EX7f+hlEf545QAcZrBn2CjYd1jLpNJyEphd+RC5Jzz/dCOiafEJf/Jw==
Authentication-Results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5062.namprd12.prod.outlook.com (2603:10b6:208:313::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Tue, 14 Sep
 2021 19:03:29 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 19:03:29 +0000
Date:   Tue, 14 Sep 2021 16:03:27 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Junji Wei <weijunji@bytedance.com>
Cc:     zyjzyj2000@gmail.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        xieyongji@bytedance.com
Subject: Re: [PATCH] RDMA/rxe: Fix wrong port_cap_flags
Message-ID: <20210914190327.GA144382@nvidia.com>
References: <20210831083223.65797-1-weijunji@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831083223.65797-1-weijunji@bytedance.com>
X-ClientProxiedBy: MN2PR16CA0039.namprd16.prod.outlook.com
 (2603:10b6:208:234::8) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by MN2PR16CA0039.namprd16.prod.outlook.com (2603:10b6:208:234::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 19:03:28 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mQDiJ-000cWe-Qr; Tue, 14 Sep 2021 16:03:27 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a00c69e9-b89c-44be-5bad-08d977b2567e
X-MS-TrafficTypeDiagnostic: BL1PR12MB5062:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5062AAF964290ACF0D89B5D3C2DA9@BL1PR12MB5062.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C5kTWKBlYRSyz2suDttmuYklDsCFO4L/Bx4BlQg7edykkpnsfLZRmhPf13ljT5TR6VM9JHkpXq21MIwzdnDV70WqYvUWhzt9X97y2rJInOD7FiaM1tKn36chyPQNynI/8YsViUF1sTjRgkYklpWF0ZPVDJnMGPNBJtPKC1vDoqSDJP6DlDroWVRi1NqpRwrZ8w9meFgdB1gDuybATnt1+nEagTXbToq1xoeRjoxYP0sNcSCmZB5aJbMqXH8sZ55E/QGVcx/MbxvTdY484jeQTvPRxAxEAqEb2XI8Ew+LXw3DKQ7DJ3aL2nS2QkANpX95C1rX5Tzt8sCO+f3+ZWoWVBPbHfYO8/1s/JMEFB8QWM38NMCEnk+KHkA1ikXPcFXy8TD8hdE3h/PZVt7t3Fe9TOVOaiOHz2kNJO5qZx1ifM5atvKkR+qZd92b74DIfc1G7akvcojPmV1Dx25k/rXDAos+t484IDt5nQOmf8QeT4Z5s9kcf/CuXOlDrIf9XQumXtkEHl2oeYjLtCCJK0PS+37qn4+5e+l3k4rltf7mj/bNTRFO03zbn/BgvqvWymemB/K3DrLtz8xhCvghpu87oerpUc55fGUE8IZLZUmYgT14lm0GkLEzsbJNWLGyRBMMT/+WEq2rrmFpEWSZhSbvdP6ZE4byN2yjKgvPUPLUs1di5pAkpqGSobir4Mtr3kWdzJvhfIC7N+z6VE8mTitplw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(9746002)(9786002)(83380400001)(66476007)(1076003)(66556008)(5660300002)(316002)(38100700002)(8936002)(2906002)(426003)(478600001)(186003)(66946007)(26005)(2616005)(8676002)(4326008)(4744005)(86362001)(6916009)(33656002)(36756003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gjwm4G2mmBEageVvK7XYsOcIFtNs9H86t1/eJiu2c/HT+1Mwiu078N09gU7Q?=
 =?us-ascii?Q?t9O6E2p21rEdeF+HG2Xt2KOV09eS8/ykCD96Uk7nI3JfLf67QtWyY1Kmjyin?=
 =?us-ascii?Q?Cprj5endRYI9VbKwQ/HK18gPeUVtm+cO9UtMoA5Gy6BeCyzQSUVPaMy6d0NN?=
 =?us-ascii?Q?prEd38RR7ZHQHNIqGWPt/jGo/ZAI3NY1Tg7D2AMA+t0tmosoqYWwBDG1yk6I?=
 =?us-ascii?Q?8w7XBbNecgh4DURXEXQk76G7bePU3ogbbTUSbvKuRhE+2iZ4jxEaDde9eh/b?=
 =?us-ascii?Q?f2HObnVSEmFMvtXetq+hbtRgi4bgE9s9GBaWm2bWx+vqYmLgpB63nPaLN8gu?=
 =?us-ascii?Q?TgAjJoO0hDhAh9yFDfznvkkkXViW+l20gtaPxUw9B08i9IFCJedArsqY39/u?=
 =?us-ascii?Q?/lOHAtRzIM8/yAzCYg1w04TVAxUZEFA+en1wsJ3k5H4pmcruJZ6b4qJ9RdCJ?=
 =?us-ascii?Q?Lk5PmQ+oEyfNMaPKBlZwTjDk2P+L2l1cV+WHaLKVqAfZxCn9fSQKWe3t+FiW?=
 =?us-ascii?Q?5+NZI4X/lqyfI8/w27IhKfaMdqzBNyJMR8qXscfOMObKkGfC6FV/SM7lhgCs?=
 =?us-ascii?Q?/6HeljuTfLwWZeQslVlM5Qag1rNAME76bFchGd3dCqZnF52Fd5dyxBBQOxWm?=
 =?us-ascii?Q?O+E7WDzKYwpiQpoymDQP6dFCo/HGJgTxczJNpTtpaYOfZsqEOHOaoZIPwX3Q?=
 =?us-ascii?Q?jGiA6NNnbBYXVUaM7k0tXT5Mp+XiOw+xQmc5KoImQqfsW4BCmfi6bsppYVX/?=
 =?us-ascii?Q?qbSeoV+mevGVkL0q1P6+9O1+6FAB5GWnysM/3hhpTAiHpKI1zSFmKfrjJov5?=
 =?us-ascii?Q?6g7mXa82/dVESEXQO5A9UsjafmpRE1tG0W16X3sLyV62AQ9ZtJuE3nopdQt0?=
 =?us-ascii?Q?GMNimDukRyt8kzF55N+0JU0SkI7MzJuVoZG2LpHpdXxb+skJPsNMrpqeiU4Y?=
 =?us-ascii?Q?RS2yThuCHeia2NNdTWOJX1nT1QQC16Yokgyb7nMxRs4vB8a/ZKZcZnvMJHUF?=
 =?us-ascii?Q?l/CBHMAZ8wCqm6r4akoIkfD/efOi+p3VwGNzgZjUPAqIbJz0iqdZpyIjs6qN?=
 =?us-ascii?Q?/E7vrRxnRzA8gU3ibksGsNFWT8jy/WTDtbwfGamLVHj/wCayefAmdXyUxAjj?=
 =?us-ascii?Q?h772zQqP2uRa/1EqK8MzwNTVoMZu6EuASCW36mgxCnmUVe94Nrk8KosHHRsX?=
 =?us-ascii?Q?ubDZLLzii77nb/ToWuGZN2ETX7p2zdlevSgrltLTMAKN8OTRPab8niGbWSYk?=
 =?us-ascii?Q?n7djaWkvc4nu93/ggh3TkPfG/fcscsZVl2pFdzXzCwE0z8oxQzMOBVbmBkC0?=
 =?us-ascii?Q?7/v33xJ1pfLGYOS9TwJKv+yN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00c69e9-b89c-44be-5bad-08d977b2567e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 19:03:29.0304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esDMfHtIRUVTfyLJP2xW9LiDUd3mINAz37HsVDUiT4SQgu5ApkQSOi1VWf27JFMv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5062
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 31, 2021 at 04:32:23PM +0800, Junji Wei wrote:
> The port->attr.port_cap_flags should be set to enum
> ib_port_capability_mask_bits in ib_mad.h,
> not RDMA_CORE_CAP_PROT_ROCE_UDP_ENCAP.
> 
> Signed-off-by: Junji Wei <weijunji@bytedance.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_param.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
