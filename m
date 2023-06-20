Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7793A737608
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jun 2023 22:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjFTU2O (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 16:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFTU2N (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 16:28:13 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853801B0
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 13:28:10 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6b2c3ec38f0so3323443a34.1
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 13:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687292890; x=1689884890;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WXGtGbVb73wqE2+v/X8TFp9Co8shCIYenqh8XTIWVlA=;
        b=GpVxvl3WEZWO1C/X/aL9aJJaB729DjO3bmkqOz1Bw1h2f/jjdFaeohRlh0zmlHlf5y
         kF3LO9fGjiQU1XiEXY3AlsxFG2gwDtBAWqNXqWAm77zx01PI8p7FjeRFTAiYFpjf3Oh9
         KWeF8zO/7nze8kNfriek+DC7RGyX1En8LpBsg5tA3luvBEe8Be7NP1ulN82KBoBnnI47
         jA8d5gPFvxWvzlH0OxfgVcHRLq+1CaaZGr7+gxZY4TkXaNZR2ints2ssMRXOWSmWkYG7
         G94gVBxGovARWcGr81CxcIMokqvXQ3bzBon0Vj9gFUKqGKC1u2jBXY7wzvT64q2nDipA
         j9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687292890; x=1689884890;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXGtGbVb73wqE2+v/X8TFp9Co8shCIYenqh8XTIWVlA=;
        b=j9jnPVHCM5bH1nmRfd970P/BtMHqUnL9QK73am7d/PU3TnUOmcIW6GZpMJ6+fF3x3L
         lKgRanGm+uegJ6HHYbVcATxW9SNc6WIrqDPkqdbDqp/dq/RG/mnrj2HMbl8fgSuL8HLk
         Dm2E66VExSxrVMoIeoqdF/j4a6KIYx/7uIYbrHA6Q4z1Ig5W63YQ5JbSgmGs8TKoqKeD
         21r8DcryK6EY7E4WPD6tFQ6XmRiCeiMcoP+Sy+q1F+VC/ifbkH9PhstcqsOQHYNbsJPQ
         LNDfwxRO/JwyHCQEyqaTK9Ws3b344hZBatzx/OAEaTeGLTTnH/u36rzbGcysa7iuqA4S
         zlDA==
X-Gm-Message-State: AC+VfDyJz+Wpak4glJv3uQ3g3mWAEkL1uWDmRAGjF7Uafi/GvZuNbI/5
        PnLDDc8o878GokAcXxdTIGifE/vDk7g=
X-Google-Smtp-Source: ACHHUZ7OqZ1JwBaiUiv0ue2VYJuHCYTJtTOxGKzgtnaZlX+lAi//SiEPuamXt6qeJLM/SJ8cg/pQSg==
X-Received: by 2002:a9d:6b14:0:b0:6b5:901e:5b77 with SMTP id g20-20020a9d6b14000000b006b5901e5b77mr3421029otp.5.1687292889757;
        Tue, 20 Jun 2023 13:28:09 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:68fa:2239:ab57:606a? (2603-8081-140c-1a00-68fa-2239-ab57-606a.res6.spectrum.com. [2603:8081:140c:1a00:68fa:2239:ab57:606a])
        by smtp.gmail.com with ESMTPSA id f18-20020a9d7b52000000b006ac87b54ca4sm1278683oto.34.2023.06.20.13.28.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 13:28:09 -0700 (PDT)
Message-ID: <db1aa8dc-04f6-e437-9809-b5e63372d53d@gmail.com>
Date:   Tue, 20 Jun 2023 15:28:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv5 for-rc1 v5 5/8] RDMA/rxe: Replace global variable with
 sock lookup functions
Content-Language: en-US
To:     Zhu Yanjun <yanjun.zhu@intel.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        parav@nvidia.com, lehrer@gmail.com
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Rain River <rain.1986.08.12@gmail.com>
References: <20230428093914.2121131-1-yanjun.zhu@intel.com>
 <20230428093914.2121131-6-yanjun.zhu@intel.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20230428093914.2121131-6-yanjun.zhu@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/28/23 04:39, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Originally a global variable is to keep the sock of udp listening
> on port 4791. In fact, sock lookup functions can be used to get
> the sock.
> 
> Tested-by: Rain River <rain.1986.08.12@gmail.com>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe.c       |  1 +
>  drivers/infiniband/sw/rxe/rxe_net.c   | 58 ++++++++++++++++++++-------
>  drivers/infiniband/sw/rxe/rxe_net.h   |  5 ---
>  drivers/infiniband/sw/rxe/rxe_verbs.h |  1 +
>  4 files changed, 45 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index ebfabc6d6b76..e81c2164d77f 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -74,6 +74,7 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
>  			rxe->ndev->dev_addr);
>  
>  	rxe->max_ucontext			= RXE_MAX_UCONTEXT;
> +	rxe->l_sk6				= NULL;
>  }
>  
>  /* initialize port attributes */
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 4cc7de7b115b..b56e2c32fbf7 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -18,8 +18,6 @@
>  #include "rxe_net.h"
>  #include "rxe_loc.h"
>  
> -static struct rxe_recv_sockets recv_sockets;
> -
>  static struct dst_entry *rxe_find_route4(struct rxe_qp *qp,
>  					 struct net_device *ndev,
>  					 struct in_addr *saddr,
> @@ -51,6 +49,23 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
>  {
>  	struct dst_entry *ndst;
>  	struct flowi6 fl6 = { { 0 } };
> +	struct rxe_dev *rdev;
> +
> +	rdev = rxe_get_dev_from_net(ndev);
> +	if (!rdev->l_sk6) {
> +		struct sock *sk;
> +
> +		rcu_read_lock();
> +		sk = udp6_lib_lookup(&init_net, NULL, 0, &in6addr_any, htons(ROCE_V2_UDP_DPORT), 0);
This subroutine (and similar udp4) is currently called for every UD packet. This just adds a lot of
code to packet processing for UD packets. All to save a global variable. Not sure it's worth it.

Bob
> +		rcu_read_unlock();
> +		if (!sk) {
> +			pr_info("file: %s +%d, error\n", __FILE__, __LINE__);
> +			return (struct dst_entry *)sk;
> +		}
> +		__sock_put(sk);
> +		rdev->l_sk6 = sk->sk_socket;
> +	}
> +
>  
>  	memset(&fl6, 0, sizeof(fl6));
>  	fl6.flowi6_oif = ndev->ifindex;
> @@ -58,8 +73,8 @@ static struct dst_entry *rxe_find_route6(struct rxe_qp *qp,
>  	memcpy(&fl6.daddr, daddr, sizeof(*daddr));
>  	fl6.flowi6_proto = IPPROTO_UDP;
>  
> -	ndst = ipv6_stub->ipv6_dst_lookup_flow(sock_net(recv_sockets.sk6->sk),
> -					       recv_sockets.sk6->sk, &fl6,
> +	ndst = ipv6_stub->ipv6_dst_lookup_flow(dev_net(ndev),
> +					       rdev->l_sk6->sk, &fl6,
>  					       NULL);
>  	if (IS_ERR(ndst)) {
>  		rxe_dbg_qp(qp, "no route to %pI6\n", daddr);
> @@ -533,15 +548,33 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
>  #define SK_REF_FOR_TUNNEL	2
>  void rxe_net_del(struct ib_device *dev)
>  {
> -	if (refcount_read(&recv_sockets.sk6->sk->sk_refcnt) > SK_REF_FOR_TUNNEL)
> -		__sock_put(recv_sockets.sk6->sk);
> +	struct sock *sk;
> +
> +	rcu_read_lock();
> +	sk = udp4_lib_lookup(&init_net, 0, 0, htonl(INADDR_ANY), htons(ROCE_V2_UDP_DPORT), 0);
> +	rcu_read_unlock();
> +	if (!sk)
> +		return;
> +
> +	__sock_put(sk);
> +
> +	if (refcount_read(&sk->sk_refcnt) > SK_REF_FOR_TUNNEL)
> +		__sock_put(sk);
>  	else
> -		rxe_release_udp_tunnel(recv_sockets.sk6);
> +		rxe_release_udp_tunnel(sk->sk_socket);
> +
> +	rcu_read_lock();
> +	sk = udp6_lib_lookup(&init_net, NULL, 0, &in6addr_any, htons(ROCE_V2_UDP_DPORT), 0);
> +	rcu_read_unlock();
> +	if (!sk)
> +		return;
> +
> +	__sock_put(sk);
>  
> -	if (refcount_read(&recv_sockets.sk4->sk->sk_refcnt) > SK_REF_FOR_TUNNEL)
> -		__sock_put(recv_sockets.sk4->sk);
> +	if (refcount_read(&sk->sk_refcnt) > SK_REF_FOR_TUNNEL)
> +		__sock_put(sk);
>  	else
> -		rxe_release_udp_tunnel(recv_sockets.sk4);
> +		rxe_release_udp_tunnel(sk->sk_socket);
>  }
>  #undef SK_REF_FOR_TUNNEL
>  
> @@ -651,10 +684,8 @@ static int rxe_net_ipv4_init(void)
>  	sock = rxe_setup_udp_tunnel(&init_net, htons(ROCE_V2_UDP_DPORT), false);
>  	if (IS_ERR(sock)) {
>  		pr_err("Failed to create IPv4 UDP tunnel\n");
> -		recv_sockets.sk4 = NULL;
>  		return -1;
>  	}
> -	recv_sockets.sk4 = sock;
>  
>  	return 0;
>  }
> @@ -674,17 +705,14 @@ static int rxe_net_ipv6_init(void)
>  
>  	sock = rxe_setup_udp_tunnel(&init_net, htons(ROCE_V2_UDP_DPORT), true);
>  	if (PTR_ERR(sock) == -EAFNOSUPPORT) {
> -		recv_sockets.sk6 = NULL;
>  		pr_warn("IPv6 is not supported, can not create a UDPv6 socket\n");
>  		return 0;
>  	}
>  
>  	if (IS_ERR(sock)) {
> -		recv_sockets.sk6 = NULL;
>  		pr_err("Failed to create IPv6 UDP tunnel\n");
>  		return -1;
>  	}
> -	recv_sockets.sk6 = sock;
>  #endif
>  	return 0;
>  }
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.h b/drivers/infiniband/sw/rxe/rxe_net.h
> index f48f22f3353b..027b20e1bab6 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.h
> +++ b/drivers/infiniband/sw/rxe/rxe_net.h
> @@ -11,11 +11,6 @@
>  #include <net/if_inet6.h>
>  #include <linux/module.h>
>  
> -struct rxe_recv_sockets {
> -	struct socket *sk4;
> -	struct socket *sk6;
> -};
> -
>  int rxe_net_add(const char *ibdev_name, struct net_device *ndev);
>  void rxe_net_del(struct ib_device *dev);
>  
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index c269ae2a3224..ac9bb55820a2 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -396,6 +396,7 @@ struct rxe_dev {
>  
>  	struct rxe_port		port;
>  	struct crypto_shash	*tfm;
> +	struct socket		*l_sk6;
>  };
>  
>  static inline void rxe_counter_inc(struct rxe_dev *rxe, enum rxe_counters index)

