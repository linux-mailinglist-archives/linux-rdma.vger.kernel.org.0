Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 800967D8F0C
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Oct 2023 08:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjJ0G7F (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Oct 2023 02:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjJ0G7E (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Oct 2023 02:59:04 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016651AA;
        Thu, 26 Oct 2023 23:58:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Vv-4-7R_1698389935;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0Vv-4-7R_1698389935)
          by smtp.aliyun-inc.com;
          Fri, 27 Oct 2023 14:58:55 +0800
Date:   Fri, 27 Oct 2023 14:58:54 +0800
From:   Dust Li <dust.li@linux.alibaba.com>
To:     Wojciech Drewek <wojciech.drewek@intel.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cruz Zhao <cruzzhao@linux.alibaba.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>
Subject: Re: [PATCH net] net/mlx5e: fix double free of encap_header
Message-ID: <20231027065854.GB92403@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20231025032712.79026-1-dust.li@linux.alibaba.com>
 <5a89b15e-e4ca-4e06-9069-6f005c6884f2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a89b15e-e4ca-4e06-9069-6f005c6884f2@intel.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 25, 2023 at 11:06:25AM +0200, Wojciech Drewek wrote:
>
>
>On 25.10.2023 05:27, Dust Li wrote:
>> When mlx5_packet_reformat_alloc() fails, the encap_header allocated in
>> mlx5e_tc_tun_create_header_ipv4{6} will be released within it. However,
>> e->encap_header is already set to the previously freed encap_header
>> before mlx5_packet_reformat_alloc(). As a result, the later
>> mlx5e_encap_put() will free e->encap_header again, causing a double free
>> issue.
>> 
>> mlx5e_encap_put()
>>     --> mlx5e_encap_dealloc()
>>         --> kfree(e->encap_header)
>
>nit: I think it should mlx5e_encap_put_locked not mlx5e_encap_put to be precise.

You are right.

The original version is mlx5e_encap_put, I mistakenly used the name of
the old version when doing git blame.

Best regards,
Dust


>
>> 
>> This happens when cmd: MLX5_CMD_OP_ALLOC_PACKET_REFORMAT_CONTEXT fail.
>> 
>> This patch fix it by not setting e->encap_header until
>> mlx5_packet_reformat_alloc() success.
>> 
>> Fixes: d589e785baf5e("net/mlx5e: Allow concurrent creation of encap entries")
>> Reported-by: Cruz Zhao <cruzzhao@linux.alibaba.com>
>> Reported-by: Tianchen Ding <dtcccc@linux.alibaba.com>
>> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
>> ---
>
>Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>
>>  drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
>> index 00a04fdd756f..8bca696b6658 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
>> @@ -300,9 +300,6 @@ int mlx5e_tc_tun_create_header_ipv4(struct mlx5e_priv *priv,
>>  	if (err)
>>  		goto destroy_neigh_entry;
>>  
>> -	e->encap_size = ipv4_encap_size;
>> -	e->encap_header = encap_header;
>> -
>>  	if (!(nud_state & NUD_VALID)) {
>>  		neigh_event_send(attr.n, NULL);
>>  		/* the encap entry will be made valid on neigh update event
>> @@ -322,6 +319,8 @@ int mlx5e_tc_tun_create_header_ipv4(struct mlx5e_priv *priv,
>>  		goto destroy_neigh_entry;
>>  	}
>>  
>> +	e->encap_size = ipv4_encap_size;
>> +	e->encap_header = encap_header;
>>  	e->flags |= MLX5_ENCAP_ENTRY_VALID;
>>  	mlx5e_rep_queue_neigh_stats_work(netdev_priv(attr.out_dev));
>>  	mlx5e_route_lookup_ipv4_put(&attr);
>> @@ -568,9 +567,6 @@ int mlx5e_tc_tun_create_header_ipv6(struct mlx5e_priv *priv,
>>  	if (err)
>>  		goto destroy_neigh_entry;
>>  
>> -	e->encap_size = ipv6_encap_size;
>> -	e->encap_header = encap_header;
>> -
>>  	if (!(nud_state & NUD_VALID)) {
>>  		neigh_event_send(attr.n, NULL);
>>  		/* the encap entry will be made valid on neigh update event
>> @@ -590,6 +586,8 @@ int mlx5e_tc_tun_create_header_ipv6(struct mlx5e_priv *priv,
>>  		goto destroy_neigh_entry;
>>  	}
>>  
>> +	e->encap_size = ipv6_encap_size;
>> +	e->encap_header = encap_header;
>>  	e->flags |= MLX5_ENCAP_ENTRY_VALID;
>>  	mlx5e_rep_queue_neigh_stats_work(netdev_priv(attr.out_dev));
>>  	mlx5e_route_lookup_ipv6_put(&attr);
