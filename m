Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B044840BFAE
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Sep 2021 08:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhIOGfp (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Sep 2021 02:35:45 -0400
Received: from mail-dm6nam12on2089.outbound.protection.outlook.com ([40.107.243.89]:60801
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229484AbhIOGfp (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Sep 2021 02:35:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZZl4ubm1hvpIboaVOy4xwpChkoCJBGN1HuLYtjSw5dGEFdEo4eIlwBwzm1YeIrJCQaDddA/1nq2lkBG5rCwyVTb7zGkNDXzwZBQcYcgAjy6YvJmk89BcjUMRJbkZkmRZOKEUBXYD11E7Rldp8Z2fJPuBb/b9dvSlogOAjBZa0454gsXSQTbb/McAl4QXnZ2skowSyahG6OaCN+9f2dvWCV46+Y/JxP2//J6udIB2JzRuRuhGHCjEOjdqD7lLjjjLOSBCoydiiUSwlh+wlAc8By7Vng4CA6Sm6ZFqn1WCwm6VeOEzbU6HwJ+67IJJoegTZE16UzcU8nDZ+/3UQKYQ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=C5/QullHbFtDX61N1pdSEWoGS3XO5CsR1PSH7puMshY=;
 b=CGUjBmsqfS3TjWDhj+ER1d2FUNwJqQvdQQURAIhktJg7uMse/er40RpXKFg70YA2pXnD37i4PUReRgalJg1pk9FvKKwUqldkWorrcr/FAAf1Io/oLqNOfhAyDM1xefJOPZZyXUcP/+JMdTE7ZaqP+2bbyxxxf5ob/dzOlyqn4FLL/jHVPkagBKVC/wgXDETRswFgMABfgoPQMMvUHpMGHlb4f7VaVbCac0wYQMwUcOmDujyA2MJwwlfHi4upDxL5sEEj0HDSkVaLNDUt3WV4uz0qJHZztKj5wpsJNdpzoTvrMIdbjDI38gp40bsGv/HkMhCOBEvT6DfIbuiJRni16w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5/QullHbFtDX61N1pdSEWoGS3XO5CsR1PSH7puMshY=;
 b=CddFtT2SPLRn1rfr5/53EoOx2khZRU0kMfd14Krha9254pPm55c8TieiGmwQcNHHTK7p+CaRghmMgrNpJSVKReUEKvNyX9VxP4EvnN5yggquRssjDo7OT7JFhQVi9bxYW9yeCliuz8chWXxVzt8mPJjbB/KYSfmvRZFnzu/JB+Og980WUCEzgXo+vUHbiVCft1np+KDYR23qZMlRgOtxQ+EFzjhKPlNaVbIiQjl6zfM9UNiTtTj5/gg2mrVphQkk+bzzhz0CeD42Vk9e9O0bfBEITMPErsft4FW6aAIFIu0BvG28uQJj6rCkm61bwl7bM5k87AHxdHWzZ3pTSIfaLA==
Received: from BN0PR07CA0027.namprd07.prod.outlook.com (2603:10b6:408:141::29)
 by DM6PR12MB3545.namprd12.prod.outlook.com (2603:10b6:5:18b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 06:34:25 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:141:cafe::62) by BN0PR07CA0027.outlook.office365.com
 (2603:10b6:408:141::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Wed, 15 Sep 2021 06:34:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 06:34:25 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Sep
 2021 06:34:24 +0000
Received: from [172.27.4.155] (172.20.187.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 15 Sep
 2021 06:34:21 +0000
Subject: Re: [PATCH] RDMA/cma: Fix listener leak in rdma_cma_listen_on_all()
 failure
To:     Jason Gunthorpe <jgg@nvidia.com>, Tao Liu <thomas.liu@ucloud.cn>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <haakon.bugge@oracle.com>, <shayd@nvidia.com>,
        <avihaih@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <thomas.liu@ucloud.com>
References: <20210913093344.17230-1-thomas.liu@ucloud.cn>
 <20210914195444.GA156389@nvidia.com>
From:   Mark Zhang <markzhang@nvidia.com>
Message-ID: <4b711688-9a82-03f1-844c-cf1557892679@nvidia.com>
Date:   Wed, 15 Sep 2021 14:34:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210914195444.GA156389@nvidia.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d94590b-d4cc-4f18-2438-08d97812dc7a
X-MS-TrafficTypeDiagnostic: DM6PR12MB3545:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3545D1281FC534B02014F818C7DB9@DM6PR12MB3545.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6MzWdGGvymDSWWzeSNWWglVRglTCh/0bCL02wcsVAr57Ox6w1Put6zKLsjya01Ed3ZdYbe29og/4Q5NsENmo2/Czi5h6ATXY1LOqLCNNk9tRyhfqv13F7laaQe8bWxL8fZFQ7KmjcvFkJTMaWDmYvaLiwCEdakPZgWlWvM1rz5HkoPwS2QOUrh8RIWJk4Q+X+/2hSJSuyBJeQVWCYRoogcSsmuJu8gBrWRyXXHVR6e8iPUREQbVIfaVg+i3oj8DqTV8uK+aqqF2xhVyHqRd3EGfjjIAFWfmgv1kdIgvOxmIu0OknR+NXjIOp2biYJZNBV2LcK7SnJZ0XMUZxfONtpCcPic6Qy3tZ1QR7+n3enjsg1kheHdDerc+PVPI2D5El6HYwqFxwzIjDcV87+qLTyLqPX2JaZn6KQlJ4KNRHOy94Ea6OYBU422YGc1nS/Jw0GvKpxd6a+HEP9VuX3ghWg7BBa7kvlBoIqtiWBVOvW+Xl0mTSZuwKfvkUqqFvIZ67V2M1scq4erAQ017pmiimJxD6yMqU+wxyUx21LM1Bj7dR/ySSzMUNquT4wYIlrQ06R2VVTbmgFymgvHQAtFXJj8Y/YhbRCxhOwx43Kezs2MjAsS8+Vxx8e563qG3KybskTb5Wvo6Bk4G9H82qR2Ae/dEkJ5gMwAHXcLKQk3M70zwkE99S6fTqHqfE5SX0MgRnH1SyEfXC/401XInS/IKZeM0UYq7iO7MFhOanIXq0IgsoV1Xgycye0ij1Mg7SMJ1TzBATbH+JF2x+YgY5OCH38kElg7TGyfOSpiJPwqPm9Bu8FRsshRh7qhj7NwzssuKL
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(136003)(46966006)(36840700001)(86362001)(16526019)(16576012)(26005)(83380400001)(478600001)(2906002)(110136005)(36860700001)(356005)(316002)(5660300002)(186003)(8676002)(54906003)(47076005)(36756003)(4326008)(31696002)(966005)(82310400003)(70206006)(36906005)(70586007)(8936002)(336012)(82740400003)(31686004)(426003)(53546011)(2616005)(7636003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 06:34:25.1683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d94590b-d4cc-4f18-2438-08d97812dc7a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3545
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 9/15/2021 3:54 AM, Jason Gunthorpe wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Mon, Sep 13, 2021 at 05:33:44PM +0800, Tao Liu wrote:
>> rdma_cma_listen_on_all() just destroy listener which lead to an error,
>> but not including those already added in listen_list. Then cm state
>> fallbacks to RDMA_CM_ADDR_BOUND.
>>
>> When user destroys id, the listeners will not be destroyed, and
>> process stucks.
>>
>>   task:rping state:D stack:   0 pid:19605 ppid: 47036 flags:0x00000084
>>   Call Trace:
>>    __schedule+0x29a/0x780
>>    ? free_unref_page_commit+0x9b/0x110
>>    schedule+0x3c/0xa0
>>    schedule_timeout+0x215/0x2b0
>>    ? __flush_work+0x19e/0x1e0
>>    wait_for_completion+0x8d/0xf0
>>    _destroy_id+0x144/0x210 [rdma_cm]
>>    ucma_close_id+0x2b/0x40 [rdma_ucm]
>>    __destroy_id+0x93/0x2c0 [rdma_ucm]
>>    ? __xa_erase+0x4a/0xa0
>>    ucma_destroy_id+0x9a/0x120 [rdma_ucm]
>>    ucma_write+0xb8/0x130 [rdma_ucm]
>>    vfs_write+0xb4/0x250
>>    ksys_write+0xb5/0xd0
>>    ? syscall_trace_enter.isra.19+0x123/0x190
>>    do_syscall_64+0x33/0x40
>>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> Fixes: c80a0c52d85c ("RDMA/cma: Add missing error handling of listen_id")
>> Signed-off-by: Tao Liu <thomas.liu@ucloud.cn>
>> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
>>   drivers/infiniband/core/cma.c | 22 +++++++++++++++-------
>>   1 file changed, 15 insertions(+), 7 deletions(-)
> 
> I'd like to see a bit more than this, I reworked the patch slightly
> into this below. It is in for-rc so let me know if it busted up. Thanks
> 
>  From a17a1faf5d3e2e19a75397dfd740dbde06f054c3 Mon Sep 17 00:00:00 2001
> From: Tao Liu <thomas.liu@ucloud.cn>
> Date: Mon, 13 Sep 2021 17:33:44 +0800
> Subject: [PATCH] RDMA/cma: Fix listener leak in rdma_cma_listen_on_all()
>   failure
> 
> If cma_listen_on_all() fails it leaves the per-device ID still on the
> listen_list but the state is not set to RDMA_CM_ADDR_BOUND.
> 
> When the cmid is eventually destroyed cma_cancel_listens() is not called
> due to the wrong state, however the per-device IDs are still holding the
> refcount preventing the ID from being destroyed, thus deadlocking:
> 
>   task:rping state:D stack:   0 pid:19605 ppid: 47036 flags:0x00000084
>   Call Trace:
>    __schedule+0x29a/0x780
>    ? free_unref_page_commit+0x9b/0x110
>    schedule+0x3c/0xa0
>    schedule_timeout+0x215/0x2b0
>    ? __flush_work+0x19e/0x1e0
>    wait_for_completion+0x8d/0xf0
>    _destroy_id+0x144/0x210 [rdma_cm]
>    ucma_close_id+0x2b/0x40 [rdma_ucm]
>    __destroy_id+0x93/0x2c0 [rdma_ucm]
>    ? __xa_erase+0x4a/0xa0
>    ucma_destroy_id+0x9a/0x120 [rdma_ucm]
>    ucma_write+0xb8/0x130 [rdma_ucm]
>    vfs_write+0xb4/0x250
>    ksys_write+0xb5/0xd0
>    ? syscall_trace_enter.isra.19+0x123/0x190
>    do_syscall_64+0x33/0x40
>    entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Ensure that cma_listen_on_all() atomically unwinds its action under the
> lock during error and reorganize how destroy_id works to be directly
> sensitive to the listen list not indirectly through the state and some
> other random collection of variables.
> 
> Fixes: c80a0c52d85c ("RDMA/cma: Add missing error handling of listen_id")
> Link: https://lore.kernel.org/r/20210913093344.17230-1-thomas.liu@ucloud.cn
> Signed-off-by: Tao Liu <thomas.liu@ucloud.cn>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>   drivers/infiniband/core/cma.c | 28 ++++++++++++++++++++--------
>   1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 86ee3b01b3ee47..be6beee1dd4c5e 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -1746,16 +1746,17 @@ static void cma_cancel_route(struct rdma_id_private *id_priv)
>          }
>   }
> 
> -static void cma_cancel_listens(struct rdma_id_private *id_priv)
> +static void _cma_cancel_listens(struct rdma_id_private *id_priv)
>   {
>          struct rdma_id_private *dev_id_priv;
> 
> +       lockdep_assert_held(&lock);
> +
>          /*
>           * Remove from listen_any_list to prevent added devices from spawning
>           * additional listen requests.
>           */
> -       mutex_lock(&lock);
> -       list_del(&id_priv->list);
> +       list_del_init(&id_priv->list);
> 
>          while (!list_empty(&id_priv->listen_list)) {
>                  dev_id_priv = list_entry(id_priv->listen_list.next,
> @@ -1768,6 +1769,20 @@ static void cma_cancel_listens(struct rdma_id_private *id_priv)
>                  rdma_destroy_id(&dev_id_priv->id);
>                  mutex_lock(&lock);
>          }
> +}
> +
> +static void cma_cancel_listens(struct rdma_id_private *id_priv)
> +{
> +       /*
> +        * During _destroy_id() it is not possible for this value to transition
> +        * from empty to !empty, test it outside to lock to avoid taking a
> +        * global lock on every destroy. Only listen all cases will have
> +        * something to do
> +        */
> +       if (list_empty(&id_priv->list))
> +               return;
> +       mutex_lock(&lock);
> +       _cma_cancel_listens(id_priv);
>          mutex_unlock(&lock);
>   }
> 
> @@ -1781,10 +1796,6 @@ static void cma_cancel_operation(struct rdma_id_private *id_priv,
>          case RDMA_CM_ROUTE_QUERY:
>                  cma_cancel_route(id_priv);
>                  break;
> -       case RDMA_CM_LISTEN:
> -               if (cma_any_addr(cma_src_addr(id_priv)) && !id_priv->cma_dev)
> -                       cma_cancel_listens(id_priv);
> -               break;

If this case is removed, is this code path still good?

cma_add_one/cma_remove_one
   cma_process_remove
     cma_send_device_removal_put
       cma_cancel_operation

>          default:
>                  break;
>          }
> @@ -1855,6 +1866,7 @@ static void cma_leave_mc_groups(struct rdma_id_private *id_priv)
>   static void _destroy_id(struct rdma_id_private *id_priv,
>                          enum rdma_cm_state state)
>   {
> +       cma_cancel_listens(id_priv);
>          cma_cancel_operation(id_priv, state);
> 
>          rdma_restrack_del(&id_priv->res);
> @@ -2579,7 +2591,7 @@ static int cma_listen_on_all(struct rdma_id_private *id_priv)
>          return 0;
> 
>   err_listen:
> -       list_del(&id_priv->list);
> +       _cma_cancel_listens(id_priv);
>          mutex_unlock(&lock);
>          if (to_destroy)
>                  rdma_destroy_id(&to_destroy->id);
> --
> 2.33.0
> 

