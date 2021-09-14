Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D41240B7C1
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Sep 2021 21:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhINTS5 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Sep 2021 15:18:57 -0400
Received: from mail-mw2nam12on2071.outbound.protection.outlook.com ([40.107.244.71]:22165
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229869AbhINTS5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 14 Sep 2021 15:18:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBQ6w8AAy6wQh5lhhNcITGOS4UqGB2drymZe2TtOp/myVE9NNy2fpm6D6q8eFqPpIJN1ZiUgomOf6q3b+WhKw5kIGccvfqv5SWshVStB6178vric6A3k4+epivb+T26u73gSZwtkkJ2p02m48AvA5H9RTn0+7FgPqdrOrD6mMPE3Azm+7BjsBPzDzGpFXcKoQYBMF81CgM212Xe+Vn8DJ9EYhPrBjD7F4fE4nlB5TD8ulRrKHSmayx1JniprAA5wq6I4fpV1TtJrHsd2kNCUrtX1tjnVUimJZSl/QGEt1WDa7uyu00ZVQrxATpkDVzXIxbGVj7nyNkr+k4enllJt9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=k1WYXQnj3YUACV6b5WQSlL2Rf7c/cNUiZ4TigjaOmpc=;
 b=m9lg2/MaQ6Fqq7nHJfcIawP+IM+CVqI417YQu+HjPlZyR9p+N6CgooJL51C3YbRxPv+85vm79yhOLQQiyuD5joBXKTlh6Hxiqe31JW5M1ZS06zc/jyHz16yfmmzbhtTUSO8U//rVnenWRNFo+FBnj3CNc9QE5cOaSv3Q0y6NWAd5VrXDfVWe2FioipfYKtqT1HAYcLFKkhMfk/sHlf/9HNG9S58jeXr69oIR1+aip419AE4dGkkmv6ARR7Yl2eTp+wVc9YeOTNdO+4tVkGGlpF7FoXMR0YYTYPRgk2ZwiBcaCt1VO2ZLnUc1gldtzLj2aT1RlOU+NNaz/wpG5HoNqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1WYXQnj3YUACV6b5WQSlL2Rf7c/cNUiZ4TigjaOmpc=;
 b=W9xPzAT/Hawt3D58E+hSXO8GeluxxbmyiXyHKKX5mGvFU4Yur/5wE5hx2bKGClw7uyJtL9ZBszMheALbmdBnsiUaJ141wMYHiAAxTE+G5gVtM5stvX8f745AeLQRa685qyaWZA/bVYluZaiTjH0Gs6ysVTqBmRsfffBlKb3pyggaCfALnHG02TIZANsjIzvH0pvGi3RaiKJThvomNVisWmqKCNTC3ghxtDUsV37hyNCgmNezyW6g5Bbid6XCtSeD5cC1vYo2h9YjXUapI3fzL5DnpX3sP7f8qntfhKPPycl9j8ooECI2dH8VjtbB1UsYPRlbUXljIKbSmcAUVzdeOw==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5351.namprd12.prod.outlook.com (2603:10b6:208:317::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Tue, 14 Sep
 2021 19:17:38 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 19:17:38 +0000
Date:   Tue, 14 Sep 2021 16:17:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org, leonro@nvidia.com,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH 1/1] RDMA/rxe: remove the redundant variable
Message-ID: <20210914191737.GA149861@nvidia.com>
References: <20210915012456.476728-1-yanjun.zhu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915012456.476728-1-yanjun.zhu@intel.com>
X-ClientProxiedBy: BL1PR13CA0401.namprd13.prod.outlook.com
 (2603:10b6:208:2c2::16) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (142.162.113.129) by BL1PR13CA0401.namprd13.prod.outlook.com (2603:10b6:208:2c2::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.9 via Frontend Transport; Tue, 14 Sep 2021 19:17:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mQDw1-000czs-F2; Tue, 14 Sep 2021 16:17:37 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d605f254-c42a-4c80-89f1-08d977b450b3
X-MS-TrafficTypeDiagnostic: BL1PR12MB5351:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB535174DD248DBCE9C162C933C2DA9@BL1PR12MB5351.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bX1OY7xjSpSCgTXZFZUmO6wVklWzE4MxeWiWUly+qSZggVKPFYte+0+yV/ndiVtDrJZ4q7Z486CYHbB0OXCsD919rvw8tt4epBN08oYXzUKaUKaAj2nP+Mzg9CojA6LBjFKDzUtKk0r2ys62ti8+Vu6jymvl4/hwvLaM2IRXdyEWhkleCDt/FYvrGXy0PTOK6++wK6QOJWt3715cbIC+DMwxfAR0Ek/H2YfPeeXM+QGLwLvQIcMo4VKE0xfWzuyLReOBs4QqoSZ2ongvDd501l4rjzPaDJ66tIz6MSpiW5+RWyeC4Jt2hFD9sS6aCf3YaG2mUq0A4ASjvKMLU1km8P4nAL0D0AXc5WD458hA0WxCvRL9flqEeIPViCgO3RvhQHm0NFDhc4uaz9Oy2Mq4l1D8q9dc0ZnIaQbLMPaospL5qwqtSsW2mqnAIRKz0RvZCx4wSRyESpoXjaE39+19w4t36xJvTdK0k7fxrbbT47vIburs0sh9O4sVuCb9wg2aYYgBxu8k86X+sR1dxiAe7WBH7xmGCYSjsn3qP6NyhAUoof+86QzAFNEg/rU83+xkZwqsAND8ZHH8qcFgmlUUHo+sOCj1wMpdB6cyMTPUp96kgXOZ0bFcjcNAv4aK05N6PbffxSIZqhixwnpfSYlJpoZsY9lvIeu18Zhftw9KWBhh3FEShy70PVIkdh8lt/OdvCeqoR3KN2Rxy/Mxdke00w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(4744005)(5660300002)(478600001)(86362001)(83380400001)(9786002)(66476007)(26005)(2906002)(36756003)(8676002)(8936002)(38100700002)(33656002)(9746002)(2616005)(426003)(316002)(186003)(4326008)(1076003)(66556008)(6916009)(66946007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MlpuVNCjVhQrX7uPO1XdiBLNQJP6akQqwXmp/u9uo+X1T5Ta3POBJ8QEsHXU?=
 =?us-ascii?Q?lJMqjDmg1QRuRTRtuHHVLBUhxx3hspJWcKoi7MdfAAB/d2u+z4Rm6/kZaBkz?=
 =?us-ascii?Q?357V7ECU4Awd3m8EGbwHMP/PrwSvFMNDKZpV0ff9TehHpLt+afcekDyeVugV?=
 =?us-ascii?Q?I5xOzusIDy6kapj1ndgkcTenbn3fXUktjO5nENIOigRfUGiIlRWfMuqhu3EE?=
 =?us-ascii?Q?Z+4ZlnMD0H087E0wxYG14Gz087R3dMxHyAdwbjK8OQxvcqCZOlJ5ai3QrrGp?=
 =?us-ascii?Q?47X6VkzSEJBcRRultE5pH+WPy+1YS4eQXQ+eN2qbWlXVyKwgkTiD1+LtHBW9?=
 =?us-ascii?Q?CQzuNVIG+SE+KX4zpSmSgN+9DG8BDAuLMOpnD0vzO3lC4XqSD9gguKpXODv/?=
 =?us-ascii?Q?iiPLcfnOX0pPmd0H3WmI7Pcydre1f6WpaJqb25RyhSzBcBg6XfjQ+4BYk4H9?=
 =?us-ascii?Q?eemH9fs8Pm7SxH2/r0etAmtV8WteUoLOdktEbwuCEYgcIvGitxB6KDVfiV6J?=
 =?us-ascii?Q?CnwlMw/szLSy89DoNDFnG8RinuP53f4E7NP+5+YhKWucaUavlg04EIw06xVY?=
 =?us-ascii?Q?woNuWpOhoI+l2jTXqWty0+buPCXsh5sgm6Xl7iZ0qvGSyK6R7Oi8Jh+8u4OR?=
 =?us-ascii?Q?CivrxmJOh7WScWERCnGkrJcOS4qp/jnLWeilqkKkMlJFLUSWWEQI6LGltCwl?=
 =?us-ascii?Q?8yBl/a+o55rg70O6pO4Hn1eHG5gg8KXROEoOoIRFRciIBv9+WIjBBnrXkITa?=
 =?us-ascii?Q?MyoOatEfkvL6Ett5ceiB1A5JOGP+yNZzR87bc2qcBRqbN6YCY6WQZtSx4A90?=
 =?us-ascii?Q?LNPp11BUaRiuq/yb0NiR4Vc362A/QLhzYv3xCwHGxvGpihqgyJ08+SdLF/AO?=
 =?us-ascii?Q?bd/0OdWHwyCBGlVJ5PHUXyO+SUeP4MuUXOgxhNIbND0i+DQfc5OzedllmkNK?=
 =?us-ascii?Q?mnyb0ciJvDXlm9VRZD9yTiqixlY+FU0VxUi4uQNcz/QlNIgascUJXtjGsqCi?=
 =?us-ascii?Q?qK2Ir5B6t0r3dzpqKByCNeqac13RaVIfrRVg5aPcg5FH0Td9MRVFdQEDawCN?=
 =?us-ascii?Q?t03Ze5XFdSENcmCI9pa1477UhclwNG/oUevD8QVB1iSEAR72KMVi346vsWs5?=
 =?us-ascii?Q?JrIiq6KGRxN51RPTfS9RjLY7qYL8QNosOjTDpKnEP/Yn4ErsKBwcW7HZ2aUe?=
 =?us-ascii?Q?mxblGukW2ryu5osleQzD/M2kvHkhsMafi5fh/dab2viWLnK1/AFUlcnRRy0E?=
 =?us-ascii?Q?or1uEV6csxdFf92+81yarYVqB2e7cFJOhygko3m7Q0FUPIkv7LjrrukYYgdH?=
 =?us-ascii?Q?m0zwKNr9KOthyD4K9IlaVKBB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d605f254-c42a-4c80-89f1-08d977b450b3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 19:17:38.4066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iYvG0FE5yq7pGQW+Q4W+TpdNx+I3WA5bM9SKXd3yZdcNm45GPTDqyYMMhPhiRNn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5351
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 14, 2021 at 09:24:56PM -0400, Zhu Yanjun wrote:
> From: Zhu Yanjun <zyjzyj2000@gmail.com>
> 
> The variable port is not necessary. So remove it.
> 
> Signed-off-by: Zhu Yanjun <zyjzyj2000@gmail.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Applied to for-next, thanks

Jason
