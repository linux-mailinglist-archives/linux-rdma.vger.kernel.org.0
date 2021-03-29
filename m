Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD22234D043
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Mar 2021 14:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbhC2MlV (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Mar 2021 08:41:21 -0400
Received: from mail-eopbgr770055.outbound.protection.outlook.com ([40.107.77.55]:26018
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231285AbhC2MlF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 29 Mar 2021 08:41:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijku2TtkGoNtz+O282Jef8jMOClebZgovHiIdR6TehGPmsxExqzJ1iyu8zTcKM20YRO8laMNKZLE0cNFleP93tYtabw2N8ZBb9PsHFkNG9OsEViGmGfERYR6Knn+FUQjz7OqxnlT9WgtxR+9JO7a0B9Wcgjx94X0YND9cVp7HFy2Gdl1mHSoROpuE9UtiR6JJXlDYGo1RTVoMa67cJLi5suyywYB70+JhVApdvxuydVuVCCrx8XyBejGZ8B02kjYEVcxTfL7fX+B6iyK7SSvTXZOO/Cx1laIPvgPFRT1WEeuRjhdU32MUNAB3pJWUlR+dLk7ENFPDMDqQdno1X/7hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTnIyGK9xA7bWXinYdgbQK+jL2jfb7cUY4L58YSLMUU=;
 b=Vp4W/SKOZ1dM+6bvLJdYZf8lB8gMcE1ziC1Szbd9QZZPWNGuql1nmYYkQgszaKsgmorkXQd99mcZg+yB3cLf90m+Sawe6mFKhBvdsbSx1ibS+r2ztyndLtoVi56RCa/bAOzS/C3FGbbJkYQyxJu13BhosokYUi1SUf3XX6tZroEC9LEspU++85iEwJjslNlzcNuXlBGxsDoUEUduPFzNGOKiHUMwK1VXEo9h5Y7jiXlTYawi5jQ/LpBY3qweROgBwQVRV+/oUElQ+ciyVaKr25U01YSlew5+VPKEk3ItUIotswWVgF2GXFu9U+wPWj8HPFAeQDuAYexvYy5NHGyCSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTnIyGK9xA7bWXinYdgbQK+jL2jfb7cUY4L58YSLMUU=;
 b=FpZXsM32xtAYg/IHue8e/Qy9n/x0l7JrCqNAmsPBL1hpY1CCt9d7thS+Q/yDcxMuU4mrCl6itPvnD4LWxPxOJNoZg9UzU0R/Q/QcPM2KCV6GKfRH1hU5xKvSyo9tNaqj0D/W3zwbuaqnd8jGeR1Ys7wEAXidh1HqkpC9q4w//oBcDhknJLQvglAbE/dWGVqktnAYonlJmrGq7tzNzaol10RW5wZ2ZGkDM9Sgf72UNRYkufTtLDqU8ilYffL0QP2jh8tsO+Sn0w+1w/84L8/ohftwrCxKBDWmmui0O+CocOQpddJ7URFirUX2Z+stLqQGH0sYLGwV+6rsKnGXzVXyuQ==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4266.namprd12.prod.outlook.com (2603:10b6:5:21a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Mon, 29 Mar
 2021 12:41:03 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 12:41:03 +0000
Date:   Mon, 29 Mar 2021 09:41:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next 3/6] IB/cm: Remove "mad_agent" parameter of
 ib_modify_mad
Message-ID: <20210329124101.GA887238@nvidia.com>
References: <20210318100309.670344-1-leon@kernel.org>
 <20210318100309.670344-4-leon@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210318100309.670344-4-leon@kernel.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0146.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::31) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0146.namprd13.prod.outlook.com (2603:10b6:208:2bb::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.16 via Frontend Transport; Mon, 29 Mar 2021 12:41:02 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lQrCX-004skf-7J; Mon, 29 Mar 2021 09:41:01 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b3d098b-dd3b-4eb3-ffec-08d8f2afe9cc
X-MS-TrafficTypeDiagnostic: DM6PR12MB4266:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4266A8CBA6DEECF9709596C3C27E9@DM6PR12MB4266.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bcVIZQ+juJhzbfhpFhjCwCnvPXbmMfhh2O9jQ9uXLp+VMbrcGZ7CU8cKnZT1q9Jae1BtFhonXjwBk4lfnO04yejGlPFHy17LCePUTAiZlC5ryoYSiulFAvhuLc/e44Yi30YKUMUcOqivqg7pOhJXg1E2A4wwWwlPThFTev79NP1db4otHnEy6jM9kZWSxU29zt0RkjnFd7A6M4li4PY4YVJrS0q9D0tzkfkywMjiQJgVxziBIoQiJqldx5kOwHAWVUN6oo+jrqfrIv0rX+BCoHdisOYATdraWE7xAhyCYhGbEWldPimnIKI6cekbNwILGUCrSPhLwOZlCe/j7RjqjmhnqOCWFe+EN+H2vrG4btqIwyy12EczX041tIP+Ve8ETHsAlmEdkO+j+KO/xFCFWt3iw/PnrXdO87ARTyjKKwPVQxQU4uaPwt1ihg52mE+SCnaBm1SNIw6WSmbR/YWpF6BjTyUQmc0JtlgUie5X0IOrxIwVB9/2I+Hym4HpmYhblT9fOgsCaJgWtncES6q+LCUgCoNblgI8DKfBQNV5/OIEpuCtOh0keWUrKRFIRLT4ij/R8AYdybU9mQ63rjH4D6j9hoDrP+ELR4cJqwxPRgvIp722tjwI+wfsotilpApFa1ojWXY6VlOzIsSLy5WUb3pUYi827K7IYouUDdZL/7jtzPwWxJuzrIVhx049FzhK9gysl6j8rSEKc/e8FBMP0mu8rDUxWRGsUilLOrcFK62BbrVCne0hFx8B1l0MofpmyeulXB85jPMLIkRBwP7oCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(4326008)(66556008)(2616005)(426003)(66476007)(54906003)(83380400001)(26005)(6916009)(478600001)(66946007)(86362001)(4744005)(9786002)(8936002)(8676002)(36756003)(1076003)(2906002)(38100700001)(5660300002)(9746002)(966005)(186003)(316002)(33656002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?y+jYMaKdvVk5CFxVWChLP9j4qSAKuu6J9PfB7mV8L1Rcvy6LGFxAZKL6cN8A?=
 =?us-ascii?Q?2ro+/cr4TBbUskAJCSCnquy2vVPnhx5jcK//znBq1XH9n6LV3f5Aks1zwtQd?=
 =?us-ascii?Q?1LWmUaiZekhm4hzK5Z0R2uOpijv2TybkyW+kNTu7WDfF2PrvL7y/8tGxRyVJ?=
 =?us-ascii?Q?2GR6dT6OViT8LAmoYMgY7zr7ydqs6wB0nJ5oiK2eRim7oWa1BLD+tvDEOwmx?=
 =?us-ascii?Q?f3ytWXkR6nGn75NQbXLfsndgAwfY8jbNX2ZwNNsmf/ttW3yFol9DaE7K5rXc?=
 =?us-ascii?Q?iEljcIZNdWfm8ncfCYQ+3CpEt8NWbQKI5Xbb1PYK9Osa8/4XjAD20hFahI5k?=
 =?us-ascii?Q?h2oZdnlOdPAZEAwqtUm35n27sUCoZQJW+mCdFcerfcBFBDibox2TBZ/EoMD4?=
 =?us-ascii?Q?dQpm4FYjA1YwK+qYILJi+Mt4n5nxoEyoSRZexkzn/ujdoJhmATj8FokLeCI0?=
 =?us-ascii?Q?MHV8bCZSqQwDHEfvIPheTqH0T0XTky1q2eYPV6TlsKUu0+T9ro13rzIzmyX0?=
 =?us-ascii?Q?9/Iz5gNYyk3ZoHVEaSEErfVVArFZZ+Nvc+iI+JT7SbycoX25bsK1yQE2xkIW?=
 =?us-ascii?Q?WxMTda/k34KXwuZ3T8W7B4SnaSuFJjiVz1dKBt1ZU1AnxGE7DPnlXupSDAId?=
 =?us-ascii?Q?0RejAQROIqC3fgNwEX3MmP0ZPvhVeOkCMe3+PDfprDGIYF0y+iLfiQxfMQoG?=
 =?us-ascii?Q?6CxkxL7dyqXznaDV4IxBCWIn6qqzJKeCS7M8jgQBRr8TEtPk6FKpS97jMteq?=
 =?us-ascii?Q?/lvD5loM4J/Vr4Y9E8F2guSnf9sPKDlAacqJPYS3qRM0xL+DXBaJivPiVL6B?=
 =?us-ascii?Q?YtDNC7VvBuBUBzfmwHotu5zQrM5wJJZ4N8i3XjbnJ2lTpnXpkpYI0jb5kXSq?=
 =?us-ascii?Q?xkOiCCUDa0pgP3Z3YnliwhYdBth5rwiyQgZylHivBM61qMSesaSx3ACw+rsV?=
 =?us-ascii?Q?Jk/oipc+1Vs4njVorQB9PTaUdaPjc5U8VlBQWyPJOBnTuhTMzLhJE5si7Pdw?=
 =?us-ascii?Q?TGwYv8AQaeT1KLYoI+efbOGgNw7jwhfE2F82ThBOvsdtD7+6MuQaN8nr5kfb?=
 =?us-ascii?Q?MkXaLzFIoZNsXpYTiDy1wq7hVcY8jD9ZqU9eQiVphoNiZOBI8EOLRufRxDmo?=
 =?us-ascii?Q?208hvqiE6a2OMlqOyEuu/X8XaamTKNlg7RBLJYhQf8Do1SreVfsLA6iwDrQF?=
 =?us-ascii?Q?XY06FbWOGHaKdhCHBq0IKFo7CZoA088ygWdhThU3wad8gkyzUesEJ8/GxKEh?=
 =?us-ascii?Q?7Rj00rKbq+gHlmMXsVsfMfIvPpnvg3J8yp7DZzWUp8C1UOi67Hwjdz2nydQg?=
 =?us-ascii?Q?KbNERaL0pYoaQP1HRRWN4o/+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3d098b-dd3b-4eb3-ffec-08d8f2afe9cc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 12:41:03.6755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nu1QYbRozrSGmWMOqliKqkH9LyoCkSkaxQNf7VyikK7dVJW0pqsRar/q1KcNp21t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4266
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 18, 2021 at 12:03:06PM +0200, Leon Romanovsky wrote:

> +static void cm_send_free_msg(struct ib_mad_send_buf *msg)
> +{
> +	struct cm_id_private *cm_id_priv;
> +
> +	cm_id_priv = msg->context[0];
> +	if (!cm_id_priv || cm_id_priv->msg != msg) {
> +		cm_free_msg(msg);
> +		return;
> +	}
> +
> +	spin_lock_irq(&cm_id_priv->lock);
> +	cm_free_msg(msg);
> +	cm_id_priv->msg = NULL;
> +	spin_unlock_irq(&cm_id_priv->lock);
> +}

Either the whole sequence should be inside the lock or nothing should
be in the lock..

Oh this is all messed up and needs a big fix. Review and include this
in the series and drop the above function.

https://github.com/jgunthorpe/linux/commits/for-markz

Jason
