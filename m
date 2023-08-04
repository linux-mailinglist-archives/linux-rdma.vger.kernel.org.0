Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AA8770A54
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Aug 2023 23:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbjHDVDc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 4 Aug 2023 17:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbjHDVDL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 4 Aug 2023 17:03:11 -0400
X-Greylist: delayed 544 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Aug 2023 14:02:19 PDT
Received: from out-111.mta0.migadu.com (out-111.mta0.migadu.com [91.218.175.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7DF59CF
        for <linux-rdma@vger.kernel.org>; Fri,  4 Aug 2023 14:02:19 -0700 (PDT)
Message-ID: <face8e0a-b3f6-85d9-ce1d-8afecdafe2a8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691182393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZL/Zfz+ulrtV+p+UIKOwsglDo56pQvjadHQdqAJUcn0=;
        b=JPUQAgcQ0PZJ+XFAl0EtbUGUO45TktXdQyDbd71Wm9uLPy0joN4Q1FX4HC/qy4c2Gkd4wH
        I5XoWHzy0TgZBCuUvDeUy6zqUfuMQbjNEET++ijXqOisg3T3D+MNCAmbq7kRhYVtzHgW9F
        OrjU9WYF3ECgdZZF7wu8+ja/QoPCUH4=
Date:   Fri, 4 Aug 2023 21:53:12 +0100
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net/mlx5: Devcom, only use devcom after NULL
 check in mlx5_devcom_send_event()
Content-Language: en-US
To:     Li Zetao <lizetao1@huawei.com>, saeedm@nvidia.com, leon@kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc:     pabeni@redhat.com, shayd@nvidia.com, roid@nvidia.com,
        mbloch@nvidia.com, vladbu@nvidia.com, elic@nvidia.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20230804092636.91357-1-lizetao1@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230804092636.91357-1-lizetao1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 04/08/2023 10:26, Li Zetao wrote:
> There is a warning reported by kernel test robot:
> 
> smatch warnings:
> drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c:264
>      mlx5_devcom_send_event() warn: variable dereferenced before
> 	IS_ERR check devcom (see line 259)
> 
> The reason for the warning is that the pointer is used before check, put
> the assignment to comp after devcom check to silence the warning.
> 
> Fixes: 88d162b47981 ("net/mlx5: Devcom, Infrastructure changes")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202308041028.AkXYDwJ6-lkp@intel.com/
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
> index feb62d952643..2bc18274858c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
> @@ -256,7 +256,7 @@ int mlx5_devcom_send_event(struct mlx5_devcom_comp_dev *devcom,
>   			   int event, int rollback_event,
>   			   void *event_data)
>   {
> -	struct mlx5_devcom_comp *comp = devcom->comp;
> +	struct mlx5_devcom_comp *comp;
>   	struct mlx5_devcom_comp_dev *pos;

The code should end up with reverse x-mas tree order.
The change itself LGTM.

>   	int err = 0;
>   	void *data;
> @@ -264,6 +264,7 @@ int mlx5_devcom_send_event(struct mlx5_devcom_comp_dev *devcom,
>   	if (IS_ERR_OR_NULL(devcom))
>   		return -ENODEV;
>   
> +	comp = devcom->comp;
>   	down_write(&comp->sem);
>   	list_for_each_entry(pos, &comp->comp_dev_list_head, list) {
>   		data = rcu_dereference_protected(pos->data, lockdep_is_held(&comp->sem));

