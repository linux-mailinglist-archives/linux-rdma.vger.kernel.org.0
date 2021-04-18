Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6039363577
	for <lists+linux-rdma@lfdr.de>; Sun, 18 Apr 2021 15:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhDRNSK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 18 Apr 2021 09:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhDRNSK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 18 Apr 2021 09:18:10 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67235C06174A
        for <linux-rdma@vger.kernel.org>; Sun, 18 Apr 2021 06:17:40 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id j7so592538eds.8
        for <linux-rdma@vger.kernel.org>; Sun, 18 Apr 2021 06:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ytsGpC789Qj444BG8Jc3Cth3L8ENInp9vZ5TCibllqE=;
        b=VktEjKzAh9hUiEDxnAq2NFGKavl0h7peVruSBKASis93l3D/1iYl5XH9k5nRlEFIGo
         U+Cu9Ung+bYNnM7XM9Wm8oWN1lz5VJdQi1ytAbo4pj1X82su4tkTKxv+2GoTObVFd3ao
         VXEf1gjgaecGSrXgWvCqDfSoVE12BLjjsiJmu0V+a4a9AuzSeFR1M9V9rtMMIOOOPTDs
         4K2f++NzJ7VsPMOO7nMXXvAC5u7cwmZ9N+17lMngj3HJ+gz+FFngz1+Avn/a6FX7oIn5
         ADO32iwzZWZ4RYscknw6FKlFv1EfLscIXRIaLar8Jib/v54EdcWIoTy1KOgVk4Lfnmtp
         8c3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ytsGpC789Qj444BG8Jc3Cth3L8ENInp9vZ5TCibllqE=;
        b=Dcl2Ib/AXvwJNZT03pDgBs7xXU00PpjtCFb9MKBxS6Y/DjsY4voJcXIfCnRJt2dBgp
         GYajU6RiIikT+c+dMvQOn7hkiNHIJAZg3VspV0eBJTxzow6ejpPIQnX314yYzL/kMt9f
         rOx3aJJzfJH1GprZLZPDw+Xzh+bjcrTs5uJhi6aWPAG26enJ+mwg+NaChUoQDZnNBDXc
         HQgwgzQTw0uJzoLfY8CA/jbI5F5f0maXpQn3Fef4qThn6ncd3wfA2K7rfWt/VWdots+U
         UkyT9rHNfLP4RL7auTbQDw4RKlsf5lVVRXc7qasB/mTgVJsyEvRzf6/XJQ7JGa1BeV4w
         tHlA==
X-Gm-Message-State: AOAM533IFdmr289okkd6+WEjE617ekYerQ8sTmWUj/la/TqN8d07qE7g
        PLGg2Y9XuBPLIQlUpT9fO2CmYCkeYeeVow==
X-Google-Smtp-Source: ABdhPJxSmBVayl8UkOag7prruu0zzYNV60zV/49akfGUg5v9YNfsEt55YC3/E/9pRb7i+9YNdaaV9w==
X-Received: by 2002:a05:6402:37a:: with SMTP id s26mr1876944edw.159.1618751859130;
        Sun, 18 Apr 2021 06:17:39 -0700 (PDT)
Received: from [192.168.0.108] ([77.124.61.96])
        by smtp.gmail.com with ESMTPSA id q10sm6952562eds.26.2021.04.18.06.17.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Apr 2021 06:17:38 -0700 (PDT)
Subject: Re: [PATCH] net/mlx4: Treat VFs fair when handling
 comm_channel_events
To:     Hans Westgaard Ry <hans.westgaard.ry@oracle.com>,
        linux-rdma@vger.kernel.org
Cc:     Jack Morgenstein <jackm@nvidia.com>
References: <1618487022-15770-1-git-send-email-hans.westgaard.ry@oracle.com>
From:   Tariq Toukan <ttoukan.linux@gmail.com>
Message-ID: <da86d726-bd86-2d9d-b152-c1a2785a408c@gmail.com>
Date:   Sun, 18 Apr 2021 16:17:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <1618487022-15770-1-git-send-email-hans.westgaard.ry@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 4/15/2021 2:43 PM, Hans Westgaard Ry wrote:
> Handling comm_channel_event in mlx4_master_comm_channel uses a double
> loop to determine which slaves have requested work. The search is
> always started at lowest slave. This leads to unfairness; lower VFs
> tends to be prioritized over higher VFs.
> 
> The patch uses find_next_bit to determine which slaves to handle.
> Fairness is implemented by always starting at the next to the last
> start.
> 
> An MPI program has been used to measure improvements. It runs 500
> ibv_reg_mr, synchronizes with all other instances and then runs 500
> ibv_dereg_mr.
> 
> The results running 500 processes, time reported is for running 500
> calls:
> 
> ibv_reg_mr:
>               Mod.   Org.
> mlx4_1    403.356ms 424.674ms
> mlx4_2    403.355ms 424.674ms
> mlx4_3    403.354ms 424.674ms
> mlx4_4    403.355ms 424.674ms
> mlx4_5    403.357ms 424.677ms
> mlx4_6    403.354ms 424.676ms
> mlx4_7    403.357ms 424.675ms
> mlx4_8    403.355ms 424.675ms
> 
> ibv_dereg_mr:
>               Mod.   Org.
> mlx4_1    116.408ms 142.818ms
> mlx4_2    116.434ms 142.793ms
> mlx4_3    116.488ms 143.247ms
> mlx4_4    116.679ms 143.230ms
> mlx4_5    112.017ms 107.204ms
> mlx4_6    112.032ms 107.516ms
> mlx4_7    112.083ms 184.195ms
> mlx4_8    115.089ms 190.618ms
> 
> Suggested-by: Håkon Bugge <haakon.bugge@oracle.com>
> Signed-off-by: Hans Westgaard Ry <hans.westgaard.ry@oracle.com>
> ---
>   drivers/net/ethernet/mellanox/mlx4/cmd.c  | 75 +++++++++++++++++--------------
>   drivers/net/ethernet/mellanox/mlx4/mlx4.h |  1 +
>   2 files changed, 43 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/cmd.c b/drivers/net/ethernet/mellanox/mlx4/cmd.c
> index c678344d22a2..24989e96ab9d 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/cmd.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/cmd.c
> @@ -51,7 +51,6 @@
>   #include "fw.h"
>   #include "fw_qos.h"
>   #include "mlx4_stats.h"
> -
>   #define CMD_POLL_TOKEN 0xffff
>   #define INBOX_MASK	0xffffffffffffff00ULL
>   

Unrelated change. Please revert it.


> @@ -2241,48 +2240,58 @@ void mlx4_master_comm_channel(struct work_struct *work)
>   	struct mlx4_priv *priv =
>   		container_of(mfunc, struct mlx4_priv, mfunc);
>   	struct mlx4_dev *dev = &priv->dev;
> -	__be32 *bit_vec;
>   	u32 comm_cmd;
> -	u32 vec;
> -	int i, j, slave;
> +	int i, slave;
>   	int toggle;
>   	int served = 0;
>   	int reported = 0;
>   	u32 slt;
> -
> -	bit_vec = master->comm_arm_bit_vector;
> -	for (i = 0; i < COMM_CHANNEL_BIT_ARRAY_SIZE; i++) {
> -		vec = be32_to_cpu(bit_vec[i]);
> -		for (j = 0; j < 32; j++) {
> -			if (!(vec & (1 << j)))
> -				continue;
> -			++reported;
> -			slave = (i * 32) + j;
> -			comm_cmd = swab32(readl(
> -					  &mfunc->comm[slave].slave_write));
> -			slt = swab32(readl(&mfunc->comm[slave].slave_read))
> -				     >> 31;
> -			toggle = comm_cmd >> 31;
> -			if (toggle != slt) {
> -				if (master->slave_state[slave].comm_toggle
> -				    != slt) {
> -					pr_info("slave %d out of sync. read toggle %d, state toggle %d. Resynching.\n",
> -						slave, slt,
> -						master->slave_state[slave].comm_toggle);
> -					master->slave_state[slave].comm_toggle =
> -						slt;
> -				}
> -				mlx4_master_do_cmd(dev, slave,
> -						   comm_cmd >> 16 & 0xff,
> -						   comm_cmd & 0xffff, toggle);
> -				++served;
> +	u32 lbit_vec[COMM_CHANNEL_BIT_ARRAY_SIZE];
> +	u32 nmbr_bits;
> +	u32 prev_slave;
> +	bool first = true;

Please maintain reversed Christmas tree when possible.
Split declaration from init if needed.

> +
> +	for (i = 0; i < COMM_CHANNEL_BIT_ARRAY_SIZE; i++)
> +		lbit_vec[i] = be32_to_cpu(master->comm_arm_bit_vector[i]);
> +	nmbr_bits = dev->persist->num_vfs + 1;
> +	if (++priv->next_slave >= nmbr_bits)
> +		priv->next_slave = 0;
> +	slave = priv->next_slave;
> +	while (true) {
> +		slave = find_next_bit((const unsigned long *)&lbit_vec, nmbr_bits, slave);
> +		if  (!first && slave >= priv->next_slave) {
> +			break;
> +		} else if (slave == nmbr_bits) {

Unnecessary else, as if block breaks.

> +			if (!first)
> +				break;
> +			first = false;
> +			slave = 0;
> +			continue;
> +		}
> +		++reported;
> +		comm_cmd = swab32(readl(&mfunc->comm[slave].slave_write));
> +		slt = swab32(readl(&mfunc->comm[slave].slave_read)) >> 31;
> +		toggle = comm_cmd >> 31;
> +		if (toggle != slt) {
> +			if (master->slave_state[slave].comm_toggle
> +			    != slt) {
> +				pr_info("slave %d out of sync. read toggle %d, state toggle %d. Resynching.\n",
> +					slave, slt,
> +					master->slave_state[slave].comm_toggle);
> +				master->slave_state[slave].comm_toggle =
> +					slt;
>   			}
> +			mlx4_master_do_cmd(dev, slave,
> +					   comm_cmd >> 16 & 0xff,
> +					   comm_cmd & 0xffff, toggle);
> +			++served;
>   		}
> +		prev_slave = slave++;
>   	}
>   
>   	if (reported && reported != served)
> -		mlx4_warn(dev, "Got command event with bitmask from %d slaves but %d were served\n",
> -			  reported, served);
> +		mlx4_warn(dev, "Got command event with bitmask from %d slaves but %d were served %x %d\n",

Not clear from the string what these newly printed values are.
Improve the string/description.

> +			  reported, served, lbit_vec[0], priv->next_slave);
>   
>   	if (mlx4_ARM_COMM_CHANNEL(dev))
>   		mlx4_warn(dev, "Failed to arm comm channel events\n");
> diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4.h b/drivers/net/ethernet/mellanox/mlx4/mlx4.h
> index 64bed7ac3836..cd6ba80f4c90 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/mlx4.h
> +++ b/drivers/net/ethernet/mellanox/mlx4/mlx4.h
> @@ -924,6 +924,7 @@ struct mlx4_priv {
>   
>   	atomic_t		opreq_count;
>   	struct work_struct	opreq_task;
> +	u32			next_slave; /* mlx4_master_comm_channel */

Move it to a more specific struct, consider struct mlx4_mfunc_master_ctx.

>   };
>   
>   static inline struct mlx4_priv *mlx4_priv(struct mlx4_dev *dev)
> 

Please submit to netdev mailing list, and CC needed maintainers.
