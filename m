Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7273389539
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 20:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbhESSXq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 14:23:46 -0400
Received: from mail-bn7nam10on2042.outbound.protection.outlook.com ([40.107.92.42]:11888
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231349AbhESSXp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 14:23:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U0Frhwukiu/rMzlkxtst4mQl5wqjw3qLFjCZf1dmNImmwS/MWmfGgvWDHcA89CYC/PO4l7PCCujSHAxpvCmlc5ZbOxD3IeXNTH4p3Yxa5wZGhDNHtYn15Gv5q1+nU9P79PU+MRPM/6W9d32r57NJVFP2penvAcbOJ2CxUstVrvLymGD+zT9PLxtB4xNJgT2CSc8mImUWPaTKtHg6aptwqDJosGvUkbzZIHBYQ+M8nejclHFP0WdL7CyDUHAVLTzwQJhXMSWDhijti7QhGOC7Toan6bm5OfaVRt6ex6y0EcpKIKlC7d2kKkFom0TzNiaODpAY30I0whw3nAcUb2aJ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kO7pCP740fRExmQvDnzPPEZUyD6luv8naiZ1rnK0xKg=;
 b=dDiLVibGze3VFIihUuInm7j5hOXtSHEx7RODbjMDQgWCVhfs9GDBGXniSA+IAuxRK5DlAbkcVy95sWgRIDHRGTC2nBjU+0CgwIdAbNhvZK7/rvuQ/je0Ls0KK2OsPPwCMU6z1IedA9QyTC2uCU3BVliiA6qUOnpczWRKwXTRe+vBr4WhwFiRJlaxjATuWqmbpX224dQl6cSlFLrqn9kqe6Dp4QgLRvedYJ1J0DnR/iIm1L6m32LR8UFejpnWLY6Ibh9DNw3QsjdHXXevnviyrSpCT10B89ovDLXo+KvNUiHCcvdy5Kvzz7VkSb9X6RzEtvW74WVmrtmVy58GfC7pEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kO7pCP740fRExmQvDnzPPEZUyD6luv8naiZ1rnK0xKg=;
 b=HcMT+t3s7v7/f8ur1kElfMLkuwIvXbmgmK2R0Y6n9pfNY7e8MA4flmHrHqK8NNzatapka72EEGLOw3cn8xLhmXc0QNSftANA+I57NbsisagbdnUmH+Q9P+VVGmafcwEYWybWSXZm044WDQAm+Zz5JTC1dslTrJhcq4zv8AYgE3zZNmX/nZ6KtCFaqxmE2D8tf2Zb2kRwsTYkplKAyWEfWNz1r6pnhQLPNAvA5iTAKjhOqmBzzmz64SuWqom/Mqw7T4fGyhwQWTDtKlGUDv2Mcge8hvGJLdUI+UhzNpxxxNj6y6bIk5FA+B7i3jatBEoDeachBVRf9vgf1NJhXyKTjw==
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1148.namprd12.prod.outlook.com (2603:10b6:3:74::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 19 May
 2021 18:22:24 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 18:22:24 +0000
Date:   Wed, 19 May 2021 15:22:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Fix query DCT via DEVX
Message-ID: <20210519182223.GA2577268@nvidia.com>
References: <6eee15d63f09bb70787488e0cf96216e2957f5aa.1621413654.git.leonro@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eee15d63f09bb70787488e0cf96216e2957f5aa.1621413654.git.leonro@nvidia.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR19CA0024.namprd19.prod.outlook.com
 (2603:10b6:208:178::37) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR19CA0024.namprd19.prod.outlook.com (2603:10b6:208:178::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.33 via Frontend Transport; Wed, 19 May 2021 18:22:24 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ljQpr-00AoTM-3p; Wed, 19 May 2021 15:22:23 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 13f2fb15-eef2-4d8b-5f25-08d91af30caa
X-MS-TrafficTypeDiagnostic: DM5PR12MB1148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1148C3C33313411A65FD3F69C22B9@DM5PR12MB1148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lbSmJEV+e2hho3kLOl9nyOVCOGlmR8yIPFYKBaWDqZ+wYApqgUinE1jNZCfCjcWM02Oxn0WCiER/2UFfQ0suKoB8e6ZuCPyduw8r2vFZT4HZNyq4Qwf9Q/us75hGrsNZmIXrIFjxmILVlluxzxj5MXaVZdJb3JFO8nMtam5rYKJkowazwsKZAjba8WiOn5/KbCAg5oET3YZtJblU/x2MxhLltMMFGQCdIKKvwURemZZyL12MlqYzpZReEWZvllyTbUyQlpny0b1d/v0YsBlmlbeX1xB0bzWUWZR5FaHztV8tjrVwGDyV4LDM6OZH5C3YgsDccPN2aisSrfvkXCswJkYZb1iGr8lyc2bHB1WShZkRRTuyI4/QxRrOCK3WFtW4dkch1I20PnP1Z2ntgm2v4Kjl0ADsCtdKqtX5PdU9W3YznP0XcgmZpLn3A8eyYvP72/l/r5hHR9gB+jPeig4Gkw+eRsLh4Y6722bzXsDjmXQvh4KTAN7WrXfbbQFM866BAkuAejvRKj4HOeTnO9a0aRbKNEW/cA3Rz7NBje9WboDZfgX8NlWr8B7pd9I3CXinGYG16BXOWippmhbvyH1do5rqYhHFFaHkm4Eecj0UCqc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(86362001)(66556008)(2616005)(426003)(36756003)(66476007)(83380400001)(66946007)(478600001)(107886003)(4326008)(9746002)(8936002)(26005)(9786002)(1076003)(4744005)(8676002)(33656002)(5660300002)(38100700002)(6916009)(2906002)(54906003)(186003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?DHHNC6YVlEnzBZ/2e7WZoNEhUP9qfG4F3yoW4k06Q5vzhCfpbsWBeaqPStUJ?=
 =?us-ascii?Q?luClO8p1nmXlwkSV+ikZZ/6xXuOa31bq4iPZFmrt+31+aiDwNT/+wQu3fQi8?=
 =?us-ascii?Q?J+JBOiYbMMaptMug4WMcMkznqxtlf1KnOJ1OETue4STbX+YxUdk6HGqlQuzQ?=
 =?us-ascii?Q?yb8dw1Ttv9mV+Z8heMWG8iW2nLlnkfJNMJEEhPtk8Y/BG7rQ0Lt5cwc5h7NU?=
 =?us-ascii?Q?pNu2HjyTZpFM4hyFillZ9k4pJJSusx/ah94m7UV9hgOXU92I7VM4omSowuH1?=
 =?us-ascii?Q?a5URlpCFGdxgOmwJ/oFQNTJaLLh+O5gjKAPZX4bhw15jtoY+PxXgCN5t9PAe?=
 =?us-ascii?Q?hr98jKq0qp6Rxm8eJcAE99VJE7j7LlGQ377INxIbwzSsuBLsqP8vfeLp3v0i?=
 =?us-ascii?Q?HWBib1zMnWVm/YSqVmZVNyZPWKmEHzsJWia6nC2hUvVli/F5hXs1W+hLARbZ?=
 =?us-ascii?Q?5Kqv1kCJaVZ12G/LcLxMcwRCBOe0/F46NwdhxdzZgJq6f6dwkVjhFQzDVetU?=
 =?us-ascii?Q?j9M10aY0EXhYxG1PsKXzTg2Sh2TdtSv5w2yLzNrtHEN+xlpiKHzzwQ3+ObLZ?=
 =?us-ascii?Q?5y0nza5e8QTUoq/4LbQP3vRv7L+VEbEozHSby6WKyIIKNPPMdLDI+UZECj3r?=
 =?us-ascii?Q?wpV6VEBdehQ3opyOwX4bkJorE15XOC+O0c7pq88jtyYxI2DS07Ej31V7Kb6G?=
 =?us-ascii?Q?5Wr+RU9YRJzao6EsgpDpVmGc6iJXc8C+uklqwGhcCib4bRIDlaglazMSD9qe?=
 =?us-ascii?Q?/IWk8wWaa/8PCEau+uQMUUoJVYUQA1YC+TuOFxxoiRTFWY03tWRR78mi3/Dt?=
 =?us-ascii?Q?uxfYWeo1dXW4w8BkItpHF3xYFSyjdp9LNWLSBSyqbgebqSzberUKqJvZ6XYt?=
 =?us-ascii?Q?iB83DI+/Y5arGNft2wvUAtTrZlZ97KqDB5EqbFqTQJMuUd2i1j8QJSwA/Rs2?=
 =?us-ascii?Q?9mawrBkyF6dkcDWC8ubP8da6oKhzDTZLbw5CvmOC0wqs7ayny38b9LpubGW4?=
 =?us-ascii?Q?mcuRnWp74AuFhM4V9F+OI1NUeZcnyyLyWM5FF5G5RfpoJ466ogZ9/+tTHLub?=
 =?us-ascii?Q?+qhG2+QBAr6QCYNcg1b8BFe+zw9ae63Iz1nAk+OBL0H0XnW1U/vvYebpI/Yx?=
 =?us-ascii?Q?gOJonmI/qedSnmABPEl6+dj70BzUnvPmgjK7x39rLTG1nrOUMO3MP4rqY6Lh?=
 =?us-ascii?Q?Qjnp9zNP7qEZhsVRbfyWjP6fdWuDVxfcBLtncyE4b+8WAsfZJKTHgb6zLM8Z?=
 =?us-ascii?Q?2UNrzJJMnLhVeRgC1AXHtoM7Z3EfTGP2GrXojtzByQdxjv8VZqi9zxWNsovy?=
 =?us-ascii?Q?br25zPjB9OvnUgBqDgdGpsCC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f2fb15-eef2-4d8b-5f25-08d91af30caa
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 18:22:24.2872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XqSLnCD3KYiPhWTNNfLjQeBiPDDuL637lLlZ1kj3Q5l+yVVdK8XG3iw6WQsGff9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1148
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 19, 2021 at 11:41:32AM +0300, Leon Romanovsky wrote:
> From: Maor Gottlieb <maorg@nvidia.com>
> 
> When executing DEVX command to query QP object, we need to take
> the QP type from the mlx5_ib_qp struct which hold the driver specific
> QP types as well, such as DC.
> 
> Fixes: 34613eb1d2ad ("IB/mlx5: Enable modify and query verbs objects via DEVX")
> Reviewed-by: Yishai Hadas <yishaih@nvidia.com>
> Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/hw/mlx5/devx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Applied to for-rc, thanks

Jason
