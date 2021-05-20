Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872DF38B347
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 17:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbhETPbu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 May 2021 11:31:50 -0400
Received: from mail-bn7nam10on2064.outbound.protection.outlook.com ([40.107.92.64]:57773
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233009AbhETPbu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 May 2021 11:31:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGRUQ37vsVju+cORObMmKnsa/Ixhcsed5v5MKEXXb8hetgya3PcmimD3DPZ25mjwgyIccX2fgUr7pF4QlIA/2r9iZWL3k1CNBsQSyaKqX25fgpOCt0dwjwypfACUCp6x9STWnbUpKosxibPF7tJRmFru1qF02aA9dYQySV8vN9K3EyF3X+eHlCr5z6K3U/D7sRKIsUIgWfTZJfsmSucTMY9NVXxUIduW2aLkI6FFydRPp9R9AaZ2+3cu7yo1yBU3v8z93g1Aoc1YpSmoxteRHWFYNTuuZl5Kd1/zjKgW17vQAOiKF42kqFKvqTTNTbb+buUIF1SNynMSAdzqB7ffew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=An/jRkKzopvz/g9SSSWxEtz5Qy/vjm3YLIMDHiRgRk8=;
 b=TJnAm5B7A+mpW/nYVauWCmjFAoFUZ6rqLbnTx/Hlh9e9aH2Hr08/a2fZmPNr1VQ8WKMIkg1WMly5sypZjrdtVn3oAE0b86E/tHVYY2lN8/IFJA1ScsR5J8VHlvGBF3F07TAJuV5zoNFMxVamiGSeGS+0SQgjcw+eF6neprapbWH2T/2vv7+Y/V3UJ8DzAxOpVz7QMjUDGwaTaU/4UfJs1w4s4QBHov/4fZTcpf5/n7YoHdrvduo7uo5vVVgwo8qTFBBec1pngj29ybnX9lwhd4fN/1HAYf1Ra7boPEUsWoQLsZc2qER/zdFxHiO6dkgNQs/E6HIGLVq2giiB+EDcrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=An/jRkKzopvz/g9SSSWxEtz5Qy/vjm3YLIMDHiRgRk8=;
 b=C8Xv0OW5gNs9gcbBiJMRMUQwMivWlKonTK+MMK9N8ladUl5Ajz48xCpRSdq7jaJ+0Bxs02o/TuzeXng/uZv8MoOhv5C8WcGqzZdzRD+va151AHFV8UZrLqiRb0RtO3VixJdwS82Z1BsOTUXXxZB2sg8xnYumqy/gUjx42CeJ6biNjrAZ0nqS1BgvUFukbRqr+AGXPXTsvQGBS8y38MraiY6XpxeRoli8LnnzaJMOiajZsunK6At7QWmfUiY9mvZWgt8o2PtKNpuQ5wrzRCxAUVI3mFFzEAfuXIf4Qx6Bn4YbwFX5+sKn04FSku5lBLpC8wUJGanxZ75yRjoiJEdqKQ==
Authentication-Results: hisilicon.com; dkim=none (message not signed)
 header.d=none;hisilicon.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4402.namprd12.prod.outlook.com (2603:10b6:5:2a5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 20 May
 2021 15:30:27 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4150.023; Thu, 20 May 2021
 15:30:27 +0000
Date:   Thu, 20 May 2021 12:30:26 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     bharat@chelsio.com, dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/cxgb4: removing useless assignments
Message-ID: <20210520153026.GB2748036@nvidia.com>
References: <1621503577-18093-1-git-send-email-tiantao6@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621503577-18093-1-git-send-email-tiantao6@hisilicon.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR11CA0029.namprd11.prod.outlook.com
 (2603:10b6:208:23b::34) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR11CA0029.namprd11.prod.outlook.com (2603:10b6:208:23b::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.24 via Frontend Transport; Thu, 20 May 2021 15:30:27 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ljkd0-00BWxi-AT; Thu, 20 May 2021 12:30:26 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1ef39f5-02d3-4447-d88b-08d91ba431c7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4402:
X-Microsoft-Antispam-PRVS: <DM6PR12MB440239914B828BBC48C68513C22A9@DM6PR12MB4402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bvV/s+ogtYN0LF8JJQGbLGgEjFrmO/FVnf4QAtGuAiTVjGtTH1mN15RCLvDRoUq11rvz4qjoLmiSGDbtfSH2svBSZjEUJC2vOXr99xqdTgXoR45soPaeeHKkW3welVsElH4dG4b4ZAs5/cMw+ikUo4k/nLfIs3Wm6TBq8L0460epHLHOB+iRL5UUxERptrgv09bbFvccpi1dWkq+nlsVlZ5ynwC5vdaXOHFr7hP/l7vI/hhjb1vzHM1gA4Xra8+EcI/qKA2RGgDnAIodqV6epZikV2qfxWO8+BxA2D3uz7AZ/4FPHbyyvY9ZNF4Kbg9h2OkAe6oZMyEKa4gCNh9zDjk93S4dHvvbaq6ceJsH7aGyd4VE8tOIVHVv33BCYJy7PtCk1+W8KpYpqoeV8MCID/O6eEVJEQfREzgfQAigmV2vTMssh4l3ICH3PstR/Y1KNJpsWFOHm2ZYlUrdMwbfT0lSd4NGj619CyFIMJh2j4CIMpwWILuY20jcmvKxI7yD0Umwy5RCK3jxZdxBeF5UGamCAwI/o4HlxxOGjNsdKoH1VI6ynyFRg6KHAc8PbQRCo1J4j8g31o5XmT3gaUqrl7xT6EIiHzDhykKjqH/sv1g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(86362001)(8936002)(83380400001)(4326008)(33656002)(186003)(9786002)(8676002)(426003)(316002)(9746002)(6916009)(4744005)(478600001)(66946007)(66556008)(66476007)(2906002)(38100700002)(26005)(36756003)(5660300002)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Mdvl7oHc740YMLGKFS1NzVp34SXrSIXZsvkNqawxERhIc4Awz+fbo+WY4KIi?=
 =?us-ascii?Q?sAfqwOaKqyQRJftkt+RR5cxpIZaELKRtlFHEF/RN7U0ZXP5JEqHyIWrkx9BE?=
 =?us-ascii?Q?2/p4WUuThMRGXuQL7ekLgO1DUmV1r1h2Zd19JmjOek04OzIdxBlY71TUFdVW?=
 =?us-ascii?Q?7y9HDCZHHQo3ecTojjbkdSj4XL6d2J5+DU28rEJRf1Pu0DmTzNmke4uLMbkA?=
 =?us-ascii?Q?pqkfWaBLDBgvKHg0Uw1KxYRm+IYlgL6yyAI+XO1U8E8vyhHvWam8VD3gVv15?=
 =?us-ascii?Q?tWX8O1DmGApE9vhltnI5r6XHRhHLS3+c6syIxuvXpVPswKb2t812W2/Id1Li?=
 =?us-ascii?Q?fU09rpDkag4UUvgCV70mEw/eDIWQZd9B8nj8xfwLxAPr4d45a8beoYzzByc5?=
 =?us-ascii?Q?xBLhpZGbLpz1bjM/omWGFmdu+RpUHORdgRMtB2uOHZkdYffQ+pgL1EDkPRcJ?=
 =?us-ascii?Q?jI0TxEXYGB1y4CXdRiXVt/WbYd2PbqraM0UkIxpLVJpVvOJ2MOP75m/cWH8w?=
 =?us-ascii?Q?+vHOJd6P8LFarI1Aso2Af7mnnw6RgrPzzHEIsbNGecJJDjX4dN6dF/HrZa2E?=
 =?us-ascii?Q?nvZwZYrur+ivlO1ny75FMQzEvhdtn+eOPQlOEsag/2Iwc4vCsDABeuj5hwZI?=
 =?us-ascii?Q?fFfr46X4H8EyM2gECYxJCAxvatxVOc2xwOYREw5BHDpstP9/+l9HHGNJ7HJg?=
 =?us-ascii?Q?aaelVXdvyEkS61sNnnkL2N1bKIpudrxNNuo5jJjx2nQX4Hh3/bosvx6vAvgC?=
 =?us-ascii?Q?Jcx+1mj1fccv7phrTVIA5QSUlhirK9QFuEBPSuhTGut5yO+NtDtRwXnsEDAS?=
 =?us-ascii?Q?VknZdutx5rYVs//EngsZj57yDUb65BpsRzNnm6pEmG0Pk9l8UCVUZ4iTkE8G?=
 =?us-ascii?Q?1sbX/Fra8b+Dl55YOmzIpdIDfzGYdqXH7/v8byd5ilRx28awUk2l7r5T+CFu?=
 =?us-ascii?Q?cJb3imucC51eWaIoLqy9X+sJkcu9CrGCJhiP4cE/Mx+YGF+7li2XEIrUXaVl?=
 =?us-ascii?Q?K88wNJc/NrhIP8EpKniMpzsmUtuLbw808aq4KXvIhes6M4KhUvoF9AWM+ej5?=
 =?us-ascii?Q?0xXVTN8a55xy26IzzAegOELVimzBvXdvBku8xFh/4YKoKQ/BtstGbefjuJ5G?=
 =?us-ascii?Q?FjajkJDoyLe60ipx8+9fYaF+rgvM2E5yxt69xIcyKYhNs+dTL1W+69tTo1eq?=
 =?us-ascii?Q?2cLGaVID7Nna/Lx41MdpkUwZSpuM1nO4SZE1qRrFkItD+LWIMS96PIocWsYu?=
 =?us-ascii?Q?8PAf9t1ortr+ZEFZkm7ZZOljhrn4dgU3QKtlgzWHeGcmURzD5AsGenvcNZJe?=
 =?us-ascii?Q?dtt7DQgamrKFJInoDo0RbQ6N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ef39f5-02d3-4447-d88b-08d91ba431c7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 15:30:27.5811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZiMyMgYBmLhwqF5OYXIN95JyMM2IHZYIif4Ocu7nlbuWUEt5KE2Fu9OPYZy9W6gU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4402
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 20, 2021 at 05:39:37PM +0800, Tian Tao wrote:
> If go to the err label, abort will be assigned a value of 1, so there
> is no need to assign a value of 1 here.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/infiniband/hw/cxgb4/qp.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to for-next, thanks

Jason
