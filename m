Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185987EEC5D
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Nov 2023 07:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjKQGrs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 17 Nov 2023 01:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQGrr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 17 Nov 2023 01:47:47 -0500
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6C2B7;
        Thu, 16 Nov 2023 22:47:42 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VwYgjMP_1700203659;
Received: from 30.221.132.130(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VwYgjMP_1700203659)
          by smtp.aliyun-inc.com;
          Fri, 17 Nov 2023 14:47:40 +0800
Message-ID: <a0c9e8d5-14fc-3eba-f891-ef7c3ee9bd03@linux.alibaba.com>
Date:   Fri, 17 Nov 2023 14:47:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net v2] net/smc: avoid data corruption caused by decline
To:     "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
        wenjia@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com
Cc:     kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
        tonylu@linux.alibaba.com, pabeni@redhat.com, edumazet@google.com
References: <1700197181-83136-1-git-send-email-alibuda@linux.alibaba.com>
From:   Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <1700197181-83136-1-git-send-email-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2023/11/17 12:59, D. Wythe wrote:

> From: "D. Wythe" <alibuda@linux.alibaba.com>
> 
> We found a data corruption issue during testing of SMC-R on Redis
> applications.
> 
> The benchmark has a low probability of reporting a strange error as
> shown below.
> 
> "Error: Protocol error, got "\xe2" as reply type byte"
> 
> Finally, we found that the retrieved error data was as follows:
> 
> 0xE2 0xD4 0xC3 0xD9 0x04 0x00 0x2C 0x20 0xA6 0x56 0x00 0x16 0x3E 0x0C
> 0xCB 0x04 0x02 0x01 0x00 0x00 0x20 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0xE2
> 
> It is quite obvious that this is a SMC DECLINE message, which means that
> the applications received SMC protocol message.
> We found that this was caused by the following situations:
> 
> client			server
> 	   proposal
> 	------------->
> 	   accept
> 	<-------------
> 	   confirm
> 	------------->
> wait confirm
> 
> 	 failed llc confirm
> 	    x------
> (after 2s)timeout
> 			wait rsp
> 
> wait decline
> 
> (after 1s) timeout
> 			(after 2s) timeout
> 	    decline
> 	-------------->
> 	    decline
> 	<--------------
> 
> As a result, a decline message was sent in the implementation, and this
> message was read from TCP by the already-fallback connection.
> 
> This patch double the client timeout as 2x of the server value,

Is the client's timeout doubled?

 From the code below, it is server's timeout that has been doubled.

> With this simple change, the Decline messages should never cross or
> collide (during Confirm link timeout).
> 
> This issue requires an immediate solution, since the protocol updates
> involve a more long-term solution.
> 
> Fixes: 0fb0b02bd6fd ("net/smc: adapt SMC client code to use the LLC flow")
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>   include/net/netns/smc.h |  2 ++
>   net/smc/af_smc.c        |  3 ++-
>   net/smc/smc_sysctl.c    | 12 ++++++++++++
>   3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/include/net/netns/smc.h b/include/net/netns/smc.h
> index 582212a..5198896 100644
> --- a/include/net/netns/smc.h
> +++ b/include/net/netns/smc.h
> @@ -22,5 +22,7 @@ struct netns_smc {
>   	int				sysctl_smcr_testlink_time;
>   	int				sysctl_wmem;
>   	int				sysctl_rmem;
> +	/* server's Confirm Link timeout in seconds */
> +	int				sysctl_smcr_srv_confirm_link_timeout;
>   };
>   #endif
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index abd2667..b86ad30 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -1870,7 +1870,8 @@ static int smcr_serv_conf_first_link(struct smc_sock *smc)
>   		return SMC_CLC_DECL_TIMEOUT_CL;
>   
>   	/* receive CONFIRM LINK response from client over the RoCE fabric */
> -	qentry = smc_llc_wait(link->lgr, link, SMC_LLC_WAIT_TIME,
> +	qentry = smc_llc_wait(link->lgr, link,
> +			      sock_net(&smc->sk)->smc.sysctl_smcr_srv_confirm_link_timeout,
>   			      SMC_LLC_CONFIRM_LINK);
>   	if (!qentry) {
>   		struct smc_clc_msg_decline dclc;
> diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
> index 5cbc18c..919f3f7 100644
> --- a/net/smc/smc_sysctl.c
> +++ b/net/smc/smc_sysctl.c
> @@ -51,6 +51,13 @@
>   		.proc_handler	= proc_dointvec_jiffies,
>   	},
>   	{
> +		.procname	= "smcr_srv_confirm_link_timeout",
> +		.data		= &init_net.smc.sysctl_smcr_srv_confirm_link_timeout,
> +		.maxlen		= sizeof(int),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_jiffies,
> +	},
> +	{
>   		.procname	= "wmem",
>   		.data		= &init_net.smc.sysctl_wmem,
>   		.maxlen		= sizeof(int),
> @@ -95,6 +102,11 @@ int __net_init smc_sysctl_net_init(struct net *net)
>   	net->smc.sysctl_autocorking_size = SMC_AUTOCORKING_DEFAULT_SIZE;
>   	net->smc.sysctl_smcr_buf_type = SMCR_PHYS_CONT_BUFS;
>   	net->smc.sysctl_smcr_testlink_time = SMC_LLC_TESTLINK_DEFAULT_TIME;
> +	/* Increasing the server's timeout by twice as much as the client's
> +	 * timeout by default can temporarily avoid decline messages of
> +	 * both side been crossed or collided.

'both sides' or maybe better for

'..avoid decline messages of both sides crossing or colliding.'



Thanks,
Wen Gu

> +	 */
> +	net->smc.sysctl_smcr_srv_confirm_link_timeout = 2 * SMC_LLC_WAIT_TIME;
>   	WRITE_ONCE(net->smc.sysctl_wmem, net_smc_wmem_init);
>   	WRITE_ONCE(net->smc.sysctl_rmem, net_smc_rmem_init);
>   
