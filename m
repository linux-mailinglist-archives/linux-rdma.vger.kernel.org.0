Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFCEA39FE42
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jun 2021 19:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhFHR53 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Jun 2021 13:57:29 -0400
Received: from mail-mw2nam12on2053.outbound.protection.outlook.com ([40.107.244.53]:31200
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231481AbhFHR52 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Jun 2021 13:57:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbgDmdzeVFH7VraxsQFBFUWbQrl2ZPQC4XXMyzjYZcZwIJ3jnoNnc8XY1E0NvYP5uejrGExLQ/J1rSqrxGmT/h/6PP/uiUztXylWj3rE2PiAKM6BnmtzyZfHm/XSNzQ+i8bghvNtLiAnvi0f32fc5nt28HSNkuKoRwuj/YIoSZ2/pmhnvhszoxm3Z1Ib5tsu0BmwmrKjG2zrCVwBd0mlMXJVyeuwq0VKFUmJa3GlhN02FX87QX01UlRxsCc+KEQWQpFcONolNQQRsgQwQd/dpfy7a3XKl9HlMqX/tx7ftfmuoeUTh0i7pCSI41hyoRpG7ybyaX4nO3y3FE1OHn/9QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vo6ryzaspn7XJEOH++UFgKKcKR+xZqbrj5lzwP7NKRk=;
 b=IVTps24Qh7kKLlWVQw3PV+o+adVKidpSfHXvRDZyswWypmH0pKyMUnVFCQUnDz1nJ++Ww8uKSumA6bHG3wiYQJgy0euBIJCXOTMoD+dXx943YbMlpDSK64CLkOez7CnQeicK4AF/cPp183x4wVvI1r8lU9c6qEW8I/X/4y6p01SHTQfkRbb8dkEycfr0HNtUYi7axMIHmv5NyeUgS5l9LO+JMt5HWKNnx4PKVogrbq5n91QnAJq+nSfXGnnLD6tSwi0Y0nPTJomYkn8iAIlz101Ko7dvXCljiVh3NkwecsknKdwbEEuqVDe6QQQO4MZYssERLEu1/qof7vYKrchWMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vo6ryzaspn7XJEOH++UFgKKcKR+xZqbrj5lzwP7NKRk=;
 b=RuLxso2XLiLQXomjYQYXIZnv+zApfsNQcbn4dPLZkWJCXGqlgB4ggOdVvSK61VGu6nwL+sI+JuT1mCqB+oyuBFjQfjRh/Odu4Dfj8rpNv78tqbODAit9i6g/55G9ePNKe+tcZPDvUZmboDz6FS9K3cDKKdtHlLXA09fyeZ7phhZzX+R/mjho+efeAxuheAUcNkYkhFMlppWOny+6mwUz9FXPUizMzEvR/8LVPSScRqYykxM3NPf8l+RR+5EiKJ+6WOtIDkNzSByZlwuSQ6BCFppB+svLT3+Ao2jgmf6ZpzTJxAS6Ikb/S4g88Ait6U0TV8FIAcJoAxv+L63wm1lhRw==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5032.namprd12.prod.outlook.com (2603:10b6:208:30a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Tue, 8 Jun
 2021 17:55:34 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%7]) with mapi id 15.20.4219.021; Tue, 8 Jun 2021
 17:55:34 +0000
Date:   Tue, 8 Jun 2021 14:55:33 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH v4 for-next 06/12] RDMA/core: Use refcount_t instead of
 atomic_t on refcount of mcast_group
Message-ID: <20210608175533.GA964838@nvidia.com>
References: <1622194663-2383-1-git-send-email-liweihang@huawei.com>
 <1622194663-2383-7-git-send-email-liweihang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622194663-2383-7-git-send-email-liweihang@huawei.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL1PR13CA0139.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::24) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL1PR13CA0139.namprd13.prod.outlook.com (2603:10b6:208:2bb::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.11 via Frontend Transport; Tue, 8 Jun 2021 17:55:34 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lqfwr-00434C-Bn; Tue, 08 Jun 2021 14:55:33 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a392604d-9a5f-42b9-fb20-08d92aa69d43
X-MS-TrafficTypeDiagnostic: BL1PR12MB5032:
X-Microsoft-Antispam-PRVS: <BL1PR12MB503213314044F4ED8CFB5DF2C2379@BL1PR12MB5032.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E53lZClPrjnsSDIe3dxiR+vUuUjW6MOclu25qI4kvdBHTGIAAKx4rQ8N0uXDZr7JHmqkj00y5SAb29qycUoEIp8+f7/xGxwcFoaHGLfMX5lNoH1i2MAlf8EeiHZOcLwB2TkXJepKjgQTO1CrgE+691OmxpYvBkF9LtZlBr+kc/xMh+u4kXMtOztSeUc8LduEZ1Y4hIn+AIsYpQq8nASnR8rL/L26haft/u21EVpJZGiL3t86TBAnjhXlRMb0qequGJNYLj4xRMS3CqVwmBZvU/29QNex82UCek/7PCFga4Fyo1eZJ0aazTSEoTWZmvfwKpCjR2jp69xENB2xyCyowhqet6UD29lca3bCdluNF34N6svD7JtHV+OTD2B9Z0xzwrAAg6/8598vEG+lVupLlPyv/SQ6a//aFsVspHRnYAOkJ4MZt0FHgSDhb9Iqo4VYbkWk7YkYyJ8N/m7gs2x/qgGBCZZL2fdFQWidrOhoHp6f28tmkxuWfFQtKynxZbU9iareAqb+UGzfbe76BGwLThQxZbx+smMMbzq1fuXrjkpogNua6Op3j0d1V3l2cLSqDB4d0AUgNc9R/jonK0A59ObqesVqC5GB0a9yWPXO+6CDwNX7waeZXLrxe7tVZZvNWBx1Unjh9lI5equJOLUGres0SYskMsVg1/U81y3ZzbA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(136003)(39860400002)(376002)(346002)(8676002)(86362001)(2906002)(6916009)(33656002)(8936002)(1076003)(36756003)(316002)(38100700002)(2616005)(9746002)(9786002)(478600001)(66476007)(66946007)(26005)(66556008)(5660300002)(186003)(83380400001)(4326008)(426003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RDwReLbnTLc7VM3Ei0FcBEGmv3EPcoYXhWqIEYRcYVAuFBwEDps3g4YWQ1Mi?=
 =?us-ascii?Q?sUOW7TNsmMPTVgW+LRL6r5AE2VDmWAvxzjyMGcZrtw4tk7WI0e90wUMQP+4c?=
 =?us-ascii?Q?oc63ZN/zkcj+fWWuDXhT2fgqr7mk1BEdZApBogifOMGnQOhRXOJLOm5zNerg?=
 =?us-ascii?Q?E//nRkHpyO0cM6UUwqLGqPIExw3zQalXydfNgVZR/dukRSE5p9LWAQ00rsgP?=
 =?us-ascii?Q?IYK20AoN4rtyl/tvWGIAPmh2jy4oeLtEhxVoMO8o3efCc8dwZgkoSWt8L/oh?=
 =?us-ascii?Q?PzJgcVHOQcoVV/L3WolLs5ho7/6MU+2USw68UkrOyHy1BGPcV8pfPYQuNgfq?=
 =?us-ascii?Q?9ELYBgOoR0+z5GGLHw6W+Zb9gouKNVLsIFbxkxYiZr9A/4gsfNPxROZcM85b?=
 =?us-ascii?Q?FvcU2efFhDMJHwpP/PTVxy0YCBvaGaYMpdBhf6g/covamfwJEa9OhIwB52jT?=
 =?us-ascii?Q?OSJMaBjBWXEmcrJ972//NLM1J5LFPAABSqaS2d7Vv+ghUkZsdqoKaXWxMpKM?=
 =?us-ascii?Q?QEQ82Effu/ONMalmPNc/dpH9Fq3hjP/kZk8ICvjat1BjzwdACZgZbbLQ6HWp?=
 =?us-ascii?Q?9/rK7/i1aL+eYhzYddoe/YmcdzRJXN9YLTac7cBZUP+IZK/ayVm32WcHwMyt?=
 =?us-ascii?Q?5RpxiWhICPYp5SX+hSCiUKW/C7BZi2gBOP71iIbtWiBfY/pcGEee3X89Cm4C?=
 =?us-ascii?Q?4pHAYrogMCncKZam7dVJxkEKB9Sc2FebJP+RHUY5EdfD50an/stCJ4p8Zq4L?=
 =?us-ascii?Q?BxqKNaelV5ZsihuJwn8NaI5Q1XGZPYqy/YVW70JUiy6zHz4GYpua3/i3cl9h?=
 =?us-ascii?Q?ggwrSq09dp7KStWDg1h25/o1jNttCcDFmjQtZWw+UaMBe4LUDzV6XzlZrGoq?=
 =?us-ascii?Q?Anzl2eInwUJuPIYNhLQOrGkvFNMmBtCQ0dZ7e0oZ7qozHTFJFur00F52Enqh?=
 =?us-ascii?Q?Ec5cEKvcPvTvgPFdYoGsK7y6aJE9hRM7l31bstbT9wUP5FmmMkCihGHH+zLJ?=
 =?us-ascii?Q?cuAKNAb10/RyCaqiCPMyslyIlElzwUh2ZsaS/h6p1Uq0jcYWPH6LxSoXEJpD?=
 =?us-ascii?Q?TX0dgybCvO9dT/uSIZ6qTkgTpQNo2ZJRWHxkG8u9F0G9XcM6OEjcxZhDDIz3?=
 =?us-ascii?Q?QIhjtAr+wu7fHq+GuPUL0BwflAooRWI1Z83WtQbLSg/SBb8SnprPvAq2nDoz?=
 =?us-ascii?Q?zOlK7Ivj3rKe2luCja+UqE3TtPso9LRzkwrOAnMTB7MaNR2AjRSiAGQRwkeY?=
 =?us-ascii?Q?xXMajURQTQ1lFSvqRDwiyf7XxK9+TdBoWGLc2/qRayLGr7TjEILW8h9pFtxQ?=
 =?us-ascii?Q?+pz/UufZbGGY91D3cuf2w3Ny?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a392604d-9a5f-42b9-fb20-08d92aa69d43
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 17:55:34.2744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gINqavbNQ1NwD0ubLpYU+5QcS2sfgPwgnjyV30p0RPLOiG+5T5IfZe7KypkZgHni
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5032
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 28, 2021 at 05:37:37PM +0800, Weihang Li wrote:
> @@ -565,8 +565,11 @@ static struct mcast_group *acquire_group(struct mcast_port *port,
>  	if (!is_mgid0) {
>  		spin_lock_irqsave(&port->lock, flags);
>  		group = mcast_find(port, mgid);
> -		if (group)
> +		if (group) {
> +			refcount_inc(&group->refcount);
>  			goto found;
> +		}
> +
>  		spin_unlock_irqrestore(&port->lock, flags);
>  	}
>  
> @@ -590,8 +593,10 @@ static struct mcast_group *acquire_group(struct mcast_port *port,
>  		group = cur_group;
>  	} else
>  		refcount_inc(&port->refcount);
> +
> +	refcount_set(&group->refcount, 1);
> +

This isn't right, when mcast_insert() returns an existing group we
need to incr not set the refcount. Change it like this:

diff --git a/drivers/infiniband/core/multicast.c b/drivers/infiniband/core/multicast.c
index 17abc212b87d05..cf99e17b81ce79 100644
--- a/drivers/infiniband/core/multicast.c
+++ b/drivers/infiniband/core/multicast.c
@@ -585,17 +585,17 @@ static struct mcast_group *acquire_group(struct mcast_port *port,
 	INIT_LIST_HEAD(&group->active_list);
 	INIT_WORK(&group->work, mcast_work_handler);
 	spin_lock_init(&group->lock);
+	refcount_set(&group->refcount, 1);
 
 	spin_lock_irqsave(&port->lock, flags);
 	cur_group = mcast_insert(port, group, is_mgid0);
 	if (cur_group) {
 		kfree(group);
 		group = cur_group;
+		refcount_inc(&group->refcount);
 	} else
 		refcount_inc(&port->refcount);
 
-	refcount_set(&group->refcount, 1);
-
 found:
 	spin_unlock_irqrestore(&port->lock, flags);
 	return group;
