Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84DC737807
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jun 2023 01:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjFTXwC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 19:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFTXwA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 19:52:00 -0400
Received: from out-14.mta0.migadu.com (out-14.mta0.migadu.com [91.218.175.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DAACC
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 16:51:58 -0700 (PDT)
Message-ID: <1be7809d-17af-f0a6-d4cc-0de4a587e7a6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687305117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vELUTWKCCxK9RTPuuMh6l8EO4XucRUW3iFtVRxRWA8c=;
        b=mFaEqN8yyIUugM/564OEsclaMWCrbncBbH+wF4tRdDTrSCIKQon74nqU+0kC+DBY1N+5fj
        LbHtjxiLS64j/8vSSjgXFqWQl0qTTHIAyEYtMVpcpPPlCnQ+KAGdqkxHCl8xn+Ry67v5Un
        0OJfi3ZEAqwkQY9lypvSc7CHLZ/Z0So=
Date:   Wed, 21 Jun 2023 07:51:51 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v6.4-rc1 v5 2/8] RDMA/rxe: Support more rdma links in
 init_net
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        parav@nvidia.com, lehrer@gmail.com
Cc:     Rain River <rain.1986.08.12@gmail.com>
References: <20230508075636.352138-1-yanjun.zhu@intel.com>
 <20230508075636.352138-3-yanjun.zhu@intel.com>
 <bf7eef3e-bfab-332f-ed5c-9a7a32703346@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <bf7eef3e-bfab-332f-ed5c-9a7a32703346@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2023/6/21 1:54, Bob Pearson 写道:
> On 5/8/23 02:56, Zhu Yanjun wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> In init_net, when several rdma links are created with the command "rdma
>> link add", newlink will check whether the udp port 4791 is listening or
>> not.
>> If not, creating a sock listening on udp port 4791. If yes, increasing the
>> reference count of the sock.
>>
>> Tested-by: Rain River <rain.1986.08.12@gmail.com>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>>   drivers/infiniband/sw/rxe/rxe.c     | 12 ++++++-
>>   drivers/infiniband/sw/rxe/rxe_net.c | 55 +++++++++++++++++++++--------
>>   drivers/infiniband/sw/rxe/rxe_net.h |  1 +
>>   3 files changed, 52 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
>> index 89b24bc34299..c15d3c5d7a6f 100644
>> --- a/drivers/infiniband/sw/rxe/rxe.c
>> +++ b/drivers/infiniband/sw/rxe/rxe.c
>> @@ -8,6 +8,7 @@
>>   #include <net/addrconf.h>
>>   #include "rxe.h"
>>   #include "rxe_loc.h"
>> +#include "rxe_net.h"
>>   
>>   MODULE_AUTHOR("Bob Pearson, Frank Zago, John Groves, Kamal Heib");
>>   MODULE_DESCRIPTION("Soft RDMA transport");
>> @@ -207,14 +208,23 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
>>   	return err;
>>   }
>>   
>> -static struct rdma_link_ops rxe_link_ops = {
>> +struct rdma_link_ops rxe_link_ops = {
>>   	.type = "rxe",
>>   	.newlink = rxe_newlink,
>>   };
>>   
>>   static int __init rxe_module_init(void)
>>   {
>> +	int err;
>> +
>>   	rdma_link_register(&rxe_link_ops);
>> +
>> +	err = rxe_register_notifier();
>> +	if (err) {
>> +		pr_err("Failed to register netdev notifier\n");
>> +		return -1;
>> +	}
>> +
>>   	pr_info("loaded\n");
>>   	return 0;
>>   }
>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
>> index 2bc7361152ea..1b98efa2cf66 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_net.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
>> @@ -626,13 +626,23 @@ static struct notifier_block rxe_net_notifier = {
>>   
>>   static int rxe_net_ipv4_init(void)
>>   {
>> -	recv_sockets.sk4 = rxe_setup_udp_tunnel(&init_net,
>> -				htons(ROCE_V2_UDP_DPORT), false);
>> -	if (IS_ERR(recv_sockets.sk4)) {
>> -		recv_sockets.sk4 = NULL;
>> +	struct sock *sk;
>> +	struct socket *sock;
>> +
>> +	rcu_read_lock();
>> +	sk = udp4_lib_lookup(&init_net, 0, 0, htonl(INADDR_ANY),
>> +			     htons(ROCE_V2_UDP_DPORT), 0);
>> +	rcu_read_unlock();
>> +	if (sk)
>> +		return 0;
> After this patch 2/8 attempting to execute
> sudo rdma link add rxe[n] type rxe netdev exxxx
> more than once now succeeds and both devices show up.
> I would suggest that you merge patch 1/8 and 2/8 so patches don't break the
> driver.

I split the steps to implement net namespace into several commits. So we 
can find out

what we have done to implement net namespace. The viewer can easily 
catch the steps.

Your suggestions seem to make sense. Let me consider sorting out the 
commits.

Zhu Yanjun

>
> Bob
>> +
>> +	sock = rxe_setup_udp_tunnel(&init_net, htons(ROCE_V2_UDP_DPORT), false);
>> +	if (IS_ERR(sock)) {
>>   		pr_err("Failed to create IPv4 UDP tunnel\n");
>> +		recv_sockets.sk4 = NULL;
>>   		return -1;
>>   	}
>> +	recv_sockets.sk4 = sock;
>>   
>>   	return 0;
>>   }
>> @@ -640,24 +650,46 @@ static int rxe_net_ipv4_init(void)
>>   static int rxe_net_ipv6_init(void)
>>   {
>>   #if IS_ENABLED(CONFIG_IPV6)
>> +	struct sock *sk;
>> +	struct socket *sock;
>> +
>> +	rcu_read_lock();
>> +	sk = udp6_lib_lookup(&init_net, NULL, 0, &in6addr_any,
>> +			     htons(ROCE_V2_UDP_DPORT), 0);
>> +	rcu_read_unlock();
>> +	if (sk)
>> +		return 0;
>>   
>> -	recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
>> -						htons(ROCE_V2_UDP_DPORT), true);
>> -	if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT) {
>> +	sock = rxe_setup_udp_tunnel(&init_net, htons(ROCE_V2_UDP_DPORT), true);
>> +	if (PTR_ERR(sock) == -EAFNOSUPPORT) {
>>   		recv_sockets.sk6 = NULL;
>>   		pr_warn("IPv6 is not supported, can not create a UDPv6 socket\n");
>>   		return 0;
>>   	}
>>   
>> -	if (IS_ERR(recv_sockets.sk6)) {
>> +	if (IS_ERR(sock)) {
>>   		recv_sockets.sk6 = NULL;
>>   		pr_err("Failed to create IPv6 UDP tunnel\n");
>>   		return -1;
>>   	}
>> +	recv_sockets.sk6 = sock;
>>   #endif
>>   	return 0;
>>   }
>>   
>> +int rxe_register_notifier(void)
>> +{
>> +	int err;
>> +
>> +	err = register_netdevice_notifier(&rxe_net_notifier);
>> +	if (err) {
>> +		pr_err("Failed to register netdev notifier\n");
>> +		return -1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>   void rxe_net_exit(void)
>>   {
>>   	rxe_release_udp_tunnel(recv_sockets.sk6);
>> @@ -669,19 +701,12 @@ int rxe_net_init(void)
>>   {
>>   	int err;
>>   
>> -	recv_sockets.sk6 = NULL;
>> -
>>   	err = rxe_net_ipv4_init();
>>   	if (err)
>>   		return err;
>>   	err = rxe_net_ipv6_init();
>>   	if (err)
>>   		goto err_out;
>> -	err = register_netdevice_notifier(&rxe_net_notifier);
>> -	if (err) {
>> -		pr_err("Failed to register netdev notifier\n");
>> -		goto err_out;
>> -	}
>>   	return 0;
>>   err_out:
>>   	rxe_net_exit();
>> diff --git a/drivers/infiniband/sw/rxe/rxe_net.h b/drivers/infiniband/sw/rxe/rxe_net.h
>> index 45d80d00f86b..a222c3eeae12 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_net.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_net.h
>> @@ -18,6 +18,7 @@ struct rxe_recv_sockets {
>>   
>>   int rxe_net_add(const char *ibdev_name, struct net_device *ndev);
>>   
>> +int rxe_register_notifier(void);
>>   int rxe_net_init(void);
>>   void rxe_net_exit(void);
>>   
