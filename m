Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0B1360B46
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Apr 2021 16:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhDOOCu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Apr 2021 10:02:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60104 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhDOOCu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Apr 2021 10:02:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13FDtThf032413;
        Thu, 15 Apr 2021 14:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=UegrpDQcSmXaGPLm8m7uglZyqP+5mlbSvLnUGf3+TXI=;
 b=K4sMLzPs6+5CxX6a7R4XXMux+TFh5cNuSaNZpsUFXLamBbiGe/bl6aapL06vZo2QG/wM
 iyFLRsKBDyRsQ6CGlDBCSSq+j4DkaFTOePxi6qJ7nPlduIsG9Ig0qsMzMHnH2wH+J5hT
 ibI1FAV44odh2tr2S9Ul6n5udKSka0jVAKQfU/dSyEufJ3JPkUk8d7c56ZD1npCNEAIx
 KAStQVLjen+neo/6CXEaqj2jDx+yZEoJK/9CizX5LIhox+GMPXwox84+271f9eOo5p8p
 1V5wdSCTyg6nNn+4by/ygguDN6i6TqErAW7xecJrS5GtyK7htFIbld0j5il80IKXzK/V Qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 37u4nnnwr7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 14:02:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13FE1dVI187879;
        Thu, 15 Apr 2021 14:02:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 37unsvmw7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 14:02:21 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 13FE2K6w009438;
        Thu, 15 Apr 2021 14:02:20 GMT
Received: from [10.175.182.99] (/10.175.182.99)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 15 Apr 2021 14:02:20 +0000
Subject: Re: [PATCH] net/mlx4: Treat VFs fair when handling
 comm_channel_events
From:   Hans Westgaard Ry <hans.westgaard.ry@oracle.com>
To:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>,
        Doug Ledford <dledford@redhat.com>
Cc:     Jack Morgenstein <jackm@nvidia.com>
References: <1618487022-15770-1-git-send-email-hans.westgaard.ry@oracle.com>
Message-ID: <655a2db9-e4a6-3dc1-62d3-50c09de9805b@oracle.com>
Date:   Thu, 15 Apr 2021 16:02:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1618487022-15770-1-git-send-email-hans.westgaard.ry@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9955 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150094
X-Proofpoint-ORIG-GUID: KFCyiOIXcSs5MneAMuIez-JAdKewxyBe
X-Proofpoint-GUID: KFCyiOIXcSs5MneAMuIez-JAdKewxyBe
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9955 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 clxscore=1011 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150093
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 4/15/21 1:43 PM, Hans Westgaard Ry wrote:
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
>   };
>   
>   static inline struct mlx4_priv *mlx4_priv(struct mlx4_dev *dev)
