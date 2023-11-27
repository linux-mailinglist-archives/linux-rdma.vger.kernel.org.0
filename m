Return-Path: <linux-rdma+bounces-102-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C197FA932
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Nov 2023 19:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A7B0B21069
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Nov 2023 18:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF93434544;
	Mon, 27 Nov 2023 18:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jLlqVZIY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEEC1A1;
	Mon, 27 Nov 2023 10:46:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkJO9umZOFXmEq8CtFmXJZRrLbqfpY5C/rHjEgH/OpEcFfX+wsOGdgAPLr/N9MPtbUM/9e7qzH/uesOXajVPH+nhFZVoGRar0QsOwwQclzc/AdWorOVFf8LS7S5kilCtpUrKjnEoaonrGUgMeAdF6sgfBhsEg8HNoXfbQBFbuLeRjg5Qj8JiROMciBmkyJ1qvPs5YQbw7eXOWKQidMxhWmEdp8oLqLK758GIqCRGw/cHc+WoVmWxNB35Chz+3aQud1mtTwg6FqmLUJGRJbyfUlT3HQFKoMNhkv+bhmoKt1u5Xt1p0WTcbpyeE2T10TbrpaxkcmGm/Q932biY8UbohA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94jj/YkOjWhkBcTZv0ClnpS+kI1dIQYwLDyVWjwVkzs=;
 b=VG+1F8Gr7UMoicoBN1Y7gfW9UrJkNFDIdnO8NWiGmVJes1uVbx59HzQl+zS/qf9f8uIyfHXqb5HJxHEXc5kJbK0U/MSmf28rI5Rg8465Sg23lGrv4SOTnBHZoh6XmsGpmStpMlS6OYT9Mnqa3n5ntoy/kq+pnCePkx+YrUeazKPIeyvsYZS649Fr5jDA7HnE+xq4vJ6i7uSjGlEDIFDJ8aCtvt0mRlVeGEBiC5I3mrlekYxuJpDEHZT/9jzNB1brKJBPdXqPayywsvJBV7vQsrrs2M2yLWhWeyDm3V6+UthF2tBv3PvrgM2UPxthuefkfZEhSWa466GACsRdm4Jrvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94jj/YkOjWhkBcTZv0ClnpS+kI1dIQYwLDyVWjwVkzs=;
 b=jLlqVZIYOyW75Iky/x7zyWEXh6h4Awv69C7R3mHGoHro98cvPchqDjK/9MVcr1oYR1UKyFr0u7JcyarNy/QjKxtfzU/ihrL6xYc6GAvhnIGCvCUa3hSPqiEyfUHFl1JCmg1JX3TNl9KlgoufUAYOQUXXfwXQJGIaXc9HgtpoUJeOQH4UfWRtlTsn/eGHx8YQbFg8flC2LEg++r7rPPhnQsVgynne5KzJqO1+fBBZqCBcs0TwsNWacmnPLxKorPkTrw2lObQ0MwD3RAKpE9b6rQa9bjxU3gZI1VkbmdlDXw5kS7BfBLodC560bUyFBTS5VNbuNpARxF2uwQH8h5RtBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Mon, 27 Nov
 2023 18:46:24 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117%3]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 18:46:24 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>,  Leon Romanovsky <leon@kernel.org>,
  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni
 <pabeni@redhat.com>,  Dragos Tatulea <dtatulea@nvidia.com>,
  netdev@vger.kernel.org,  linux-rdma@vger.kernel.org,
  kernel-janitors@vger.kernel.org, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net] net/mlx5e: Fix snprintf return check
References: <d17868ea-cef9-4f8c-a318-9f98b8341f5b@moroto.mountain>
Date: Mon, 27 Nov 2023 10:46:17 -0800
In-Reply-To: <d17868ea-cef9-4f8c-a318-9f98b8341f5b@moroto.mountain> (Dan
	Carpenter's message of "Mon, 27 Nov 2023 16:00:53 +0300")
Message-ID: <877cm3826e.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::21) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: 21814e01-ed06-4275-268a-08dbef792801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fjBO+hueKFRk996IsadqJrQhYerWKPJhh3e+NkXILl28a1auZdWfSxv9PmAv+lCbbsNmXy1k4Xlh/vUt2rreR/HnXUJd+EYAJAJX/4MaPCycdFsc/vNdPhbrFnK1PnnLQCKg0LywEWPVoCi3rnZ1WnNhJF5c2tuZpYNSXx9XNVRO0NGZVuXBvPioohg5ArKJwr++yqClit6vmbH5tmdTbVzVQS8b4b1mGnwgIp2OG8vIVIrX46+/IPYfkVoFw2OpKrss+jpu1ferMzVZeb8d0sLu3/mrnMGhtNXUst+n2eAis8wJUtD5my6VysUnLx0YDL8lzdLE8ndjD2TkAKc77vPiprtX9e9DuhvE9IBDrtPP4m6D1uofqgFw4RnzHrADupakk0Igabt/nyHDDgibZG0544WqypLB1kTbnLX05C3WlBUAdVW9D5yGQaPwcGWpkXlEndiJAZ3EGvO7N77piZb3SCcoGutI06FRXEb5AyEk0WXDR5wI89DDi9Wrja6hcM+XWflsbcKiappP8tn0rFzMjqkHHEMKjRVptoS0Kl90tDVA41SoPGMJemSxZFDboAAKVvCnYjBQANDuU3OWQNMMsp10crpDHhSbuFlJNVG7wnOd2ZUahH8+E8bMNTKS7ervR3A4Tx2N1H4lnkvfGA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(4326008)(41300700001)(2906002)(8676002)(8936002)(2616005)(6512007)(6506007)(86362001)(316002)(6486002)(66556008)(66946007)(6916009)(54906003)(7416002)(5660300002)(66476007)(478600001)(26005)(6666004)(966005)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gc5dma+5YlzqO3OQqdnB8J9K/W4h9R5Fr4Syiqq2uGABptic2eg5RpR5npE1?=
 =?us-ascii?Q?w58r/gNe7cPA57PAMOVJgfJc2N5+2y7A8jCp8u619OMBQI8ivrTwQ+7241Gb?=
 =?us-ascii?Q?38Jpu1hRBCb939TPOH1G8zsuzHRmkQrYZ16mhVxbrj+yesiq2IeSYUY+ccCD?=
 =?us-ascii?Q?TTTFdOOmKXHsZRD11g4PxO2ostyi8TnqrCkM09vJSnkWuQEt6YDaqM6kZK2b?=
 =?us-ascii?Q?TkNTIic4Ra5/ENzK2ikhhCJsQbgOS4GyOMYc5DCTkeTYbmM2WkB59FDD4wWZ?=
 =?us-ascii?Q?WFgy7tm3yqJTGuUXgpP71jDzDA+p9NmTfaHRp5QWzxsU4DG0LglI/e7/cjJR?=
 =?us-ascii?Q?gd1Xk2M0g8YdYeZXD+utGHUSANg5KPx+ELvD3ugqWgeZbcvSfpUndWOE4cpu?=
 =?us-ascii?Q?zEN4Jn7wq9fPYayWr3Yk53RBa1S0QIrO3e0rjHlY9V2vddzXo2YNWng7dqPR?=
 =?us-ascii?Q?fsBFuJd52XNKVX6Nkl/k7a7WRS9pVTwcjFxZvGnuhqAI7fx4FEcoInESDAlP?=
 =?us-ascii?Q?8XrC0W6qTzGw+FOnP64bdnYCMOkvctK8i+JyqwVI7XVzOp8JKwu/pcr+mvV2?=
 =?us-ascii?Q?Mazke1dKQZx8JtmaKXTJ7Je4Eopsb1SB4mqlJDPC85phOMcNbMp6ylsEfCkR?=
 =?us-ascii?Q?IrYb/fb61wF77LfJzJnYKrUbrh1lK0cSgSkpCKLSxJPImVM+phLyHx00mjao?=
 =?us-ascii?Q?jpaqRO8rWc1rFj+i8OIoUlsKLx9JuJJXq0bXt7iJRrEWLwraVAKIEuCaEdr2?=
 =?us-ascii?Q?WKtjW6Y1haZw2ruMrVyduikpdJ81Bd7dB7WHUu4ynRn/GBnfodYt/7BFpRCx?=
 =?us-ascii?Q?Vg8pINGLdYnkBVVh1q9xcf7PTXepuo9Wl329pimrIgIDpTZ+n0CKGTpDE9ED?=
 =?us-ascii?Q?DHlJQFX1Fj6eSTBYl9t2d6ACwlhp5lfpeCAI5hhITCdfROXhbwvIJNxdb0wt?=
 =?us-ascii?Q?kxbJ3ICt+Q/KyyWyZaEr6jJCGlChIh+VExAZ/NE4NyKPvV2YCzAhFr58I9E+?=
 =?us-ascii?Q?gDJtY9VHTmwpPSeDChNg9QWN6UpLGo9ROsuccg59Vn3qSY3tvEpe3fAAhWiQ?=
 =?us-ascii?Q?USLCC+msG/pvGW7gq2cRirwS/gFhAG5/4nm2uyVFsJI8J3jXZo3lVDs0L5Up?=
 =?us-ascii?Q?rj3geOp8hZFdJSUG3+QeC/lchvojQkNltV7orZvVMflcLwVtRwRPwbjjleVl?=
 =?us-ascii?Q?QyBBlPQqh4KtSVyt4l1JJhb7IUIDKUFMaXD37eE3JCJGCacAw1P6wTistwjf?=
 =?us-ascii?Q?IqBZ85uptA2vErTo6cL+Ozxo8u8UDxgaAcB46sCSCBk+BJiVzKkDwVeON8CQ?=
 =?us-ascii?Q?xiR60xqFVKEFaoq7/28QTYFRcxjEWXxgS3DilfjBBctHyi5uZNznM82ygTR3?=
 =?us-ascii?Q?dwfhOCKcE+cg373VRqsclvvDZBl7DglmX6BUe4/01gwfKImzaMQ5xgD8NEPQ?=
 =?us-ascii?Q?IaJLvzQojR6wROm+hIed1gNBGq2C92KenTzTM9Xnxm1E6A6MaWXPt29OTm4v?=
 =?us-ascii?Q?oAH/5/w6wBFnfbdoskULZQ/MTdUl8wEfNdVQUSWgO6RMNI1+clY3N0aKqcyi?=
 =?us-ascii?Q?oqlEQQzViD7iA4p5w8pGBGTkDYmnYPAGZM5PnfRcu8qm3ztF6ZsZOyC4zJcq?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21814e01-ed06-4275-268a-08dbef792801
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 18:46:24.6021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xBPxZx09CqoTHFLl+OfrLl/1iAK8h13f/YQkjh7Fc+85TBnGsQQy0W4NU01VwT7PLr656miolzz8ZN9Cyr1ADg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003

On Mon, 27 Nov, 2023 16:00:53 +0300 Dan Carpenter <dan.carpenter@linaro.org> wrote:
> This code prints a string and then if there wasn't enough space for the
> whole string, then it prints a slightly shorter string.  However, the
> test for overflow should have been >= instead of == because snprintf()
> returns the number of bytes which *would* have been printed if there
> were enough space.
>
> Fixes: 41e63c2baa11 ("net/mlx5e: Check return value of snprintf writing to fw_version buffer")
> Fixes: 1b2bd0c0264f ("net/mlx5e: Check return value of snprintf writing to fw_version buffer for representors")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---

I have already sent out patches targeting net for this on the mailing
list. That said, thanks for the follow-up.

  * https://lore.kernel.org/netdev/20231121230022.89102-1-rrameshbabu@nvidia.com/
  * https://lore.kernel.org/netdev/20231121230022.89102-2-rrameshbabu@nvidia.com/

These have been reviewed by Simon Horman.

--
Thanks,

Rahul Rameshbabu

