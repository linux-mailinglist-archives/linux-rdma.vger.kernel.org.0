Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681AB737350
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jun 2023 19:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjFTRzF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 13:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjFTRzC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 13:55:02 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFE71722
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 10:54:59 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b58c7cc06aso1350622a34.1
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 10:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687283699; x=1689875699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ivR0mS7hJnITdK5xHdkgjB3lfsPKe7tw9HMDgZ/r9Kw=;
        b=buLJ/++lrUkTweH28ypfxek5KIzHuTXpgpF8gnrkbmp+308W/v5InFiIJ9uDWEQqjU
         2Ku+b/Nsq0vtSr9e5FcxFTa8j6gktJlgFZ0RQ48msGxdsVICK4ie2TFZ//Js71GY9gvw
         DWyMff5Q5MESl7zMuMdrBEQ6EcmBzTvCCAnXoPsZsoAbjLIwOhoTsFvQCQtjcbx907N5
         UGw1+pPYyNxuScIAdFGsP34aZ6VcblzYhCJgb09FcNuYtec01IaXvl60/w4MH9oaZJlY
         IrB4Qa2FAO5olzt967eiCXIV3pe6I/+FInp2RFNR7DHe2aRn73h37Y4Yg3yEzoQNegsr
         bERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687283699; x=1689875699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ivR0mS7hJnITdK5xHdkgjB3lfsPKe7tw9HMDgZ/r9Kw=;
        b=lPzksvCeAlMFtIpUaK/Z6nJ0T+oSVRT+GcCoSSmkYL1VZgvYUuj8DQF98v0ZyicVtd
         iXH2286MzMtvIPbdzSMZJdUYIh2ttO3avM3sB0qnMLiE+qchl6ELptwD4LWHc9jw88hE
         u6En4lrR3kf3fTFm7eRsKO2ik6m1s8cyl1o5xxdDu9V0zMWSEmi2D3IAGz8xE5SoEhdt
         Mqdk28NWQnCzY3fdLkMZ5D0VtMYVKp7G35WptmnZ7GA4iuqq3yS4bm0OSZBHgLhG8x5s
         /0Oqnb9potMN3Z1rQZnprxBOJ3rSO+trsxOAQBgayeeE8OWUSazylAUl1hSVxtNBNg7E
         sWvw==
X-Gm-Message-State: AC+VfDwAU62VyWJkXqHQ++/iCsAMJIGFPsJE/tjKciAcUmnGo078Gega
        YoiCk2EMc3AShCHo6u59spyQwuX3e4k=
X-Google-Smtp-Source: ACHHUZ7vZ/rAQG0hndZJpLHZoEJEq1atxuT/w0fjIvX+yCAQ4iLcPdcahs8c6d7OA7mNDkDcz81jRw==
X-Received: by 2002:a9d:69cd:0:b0:6b4:662a:d20d with SMTP id v13-20020a9d69cd000000b006b4662ad20dmr6759566oto.2.1687283698922;
        Tue, 20 Jun 2023 10:54:58 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:81c6:3f2e:fd92:f64d? (2603-8081-140c-1a00-81c6-3f2e-fd92-f64d.res6.spectrum.com. [2603:8081:140c:1a00:81c6:3f2e:fd92:f64d])
        by smtp.gmail.com with ESMTPSA id n8-20020a0568301e8800b006b46b136155sm1165419otr.23.2023.06.20.10.54.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 10:54:58 -0700 (PDT)
Message-ID: <bf7eef3e-bfab-332f-ed5c-9a7a32703346@gmail.com>
Date:   Tue, 20 Jun 2023 12:54:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6.4-rc1 v5 2/8] RDMA/rxe: Support more rdma links in
 init_net
To:     Zhu Yanjun <yanjun.zhu@intel.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        parav@nvidia.com, lehrer@gmail.com
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Rain River <rain.1986.08.12@gmail.com>
References: <20230508075636.352138-1-yanjun.zhu@intel.com>
 <20230508075636.352138-3-yanjun.zhu@intel.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20230508075636.352138-3-yanjun.zhu@intel.com>
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

On 5/8/23 02:56, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> In init_net, when several rdma links are created with the command "rdma
> link add", newlink will check whether the udp port 4791 is listening or
> not.
> If not, creating a sock listening on udp port 4791. If yes, increasing the
> reference count of the sock.
> 
> Tested-by: Rain River <rain.1986.08.12@gmail.com>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe.c     | 12 ++++++-
>  drivers/infiniband/sw/rxe/rxe_net.c | 55 +++++++++++++++++++++--------
>  drivers/infiniband/sw/rxe/rxe_net.h |  1 +
>  3 files changed, 52 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index 89b24bc34299..c15d3c5d7a6f 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -8,6 +8,7 @@
>  #include <net/addrconf.h>
>  #include "rxe.h"
>  #include "rxe_loc.h"
> +#include "rxe_net.h"
>  
>  MODULE_AUTHOR("Bob Pearson, Frank Zago, John Groves, Kamal Heib");
>  MODULE_DESCRIPTION("Soft RDMA transport");
> @@ -207,14 +208,23 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
>  	return err;
>  }
>  
> -static struct rdma_link_ops rxe_link_ops = {
> +struct rdma_link_ops rxe_link_ops = {
>  	.type = "rxe",
>  	.newlink = rxe_newlink,
>  };
>  
>  static int __init rxe_module_init(void)
>  {
> +	int err;
> +
>  	rdma_link_register(&rxe_link_ops);
> +
> +	err = rxe_register_notifier();
> +	if (err) {
> +		pr_err("Failed to register netdev notifier\n");
> +		return -1;
> +	}
> +
>  	pr_info("loaded\n");
>  	return 0;
>  }
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 2bc7361152ea..1b98efa2cf66 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -626,13 +626,23 @@ static struct notifier_block rxe_net_notifier = {
>  
>  static int rxe_net_ipv4_init(void)
>  {
> -	recv_sockets.sk4 = rxe_setup_udp_tunnel(&init_net,
> -				htons(ROCE_V2_UDP_DPORT), false);
> -	if (IS_ERR(recv_sockets.sk4)) {
> -		recv_sockets.sk4 = NULL;
> +	struct sock *sk;
> +	struct socket *sock;
> +
> +	rcu_read_lock();
> +	sk = udp4_lib_lookup(&init_net, 0, 0, htonl(INADDR_ANY),
> +			     htons(ROCE_V2_UDP_DPORT), 0);
> +	rcu_read_unlock();
> +	if (sk)
> +		return 0;
After this patch 2/8 attempting to execute
sudo rdma link add rxe[n] type rxe netdev exxxx
more than once now succeeds and both devices show up.
I would suggest that you merge patch 1/8 and 2/8 so patches don't break the
driver.

Bob
> +
> +	sock = rxe_setup_udp_tunnel(&init_net, htons(ROCE_V2_UDP_DPORT), false);
> +	if (IS_ERR(sock)) {
>  		pr_err("Failed to create IPv4 UDP tunnel\n");
> +		recv_sockets.sk4 = NULL;
>  		return -1;
>  	}
> +	recv_sockets.sk4 = sock;
>  
>  	return 0;
>  }
> @@ -640,24 +650,46 @@ static int rxe_net_ipv4_init(void)
>  static int rxe_net_ipv6_init(void)
>  {
>  #if IS_ENABLED(CONFIG_IPV6)
> +	struct sock *sk;
> +	struct socket *sock;
> +
> +	rcu_read_lock();
> +	sk = udp6_lib_lookup(&init_net, NULL, 0, &in6addr_any,
> +			     htons(ROCE_V2_UDP_DPORT), 0);
> +	rcu_read_unlock();
> +	if (sk)
> +		return 0;
>  
> -	recv_sockets.sk6 = rxe_setup_udp_tunnel(&init_net,
> -						htons(ROCE_V2_UDP_DPORT), true);
> -	if (PTR_ERR(recv_sockets.sk6) == -EAFNOSUPPORT) {
> +	sock = rxe_setup_udp_tunnel(&init_net, htons(ROCE_V2_UDP_DPORT), true);
> +	if (PTR_ERR(sock) == -EAFNOSUPPORT) {
>  		recv_sockets.sk6 = NULL;
>  		pr_warn("IPv6 is not supported, can not create a UDPv6 socket\n");
>  		return 0;
>  	}
>  
> -	if (IS_ERR(recv_sockets.sk6)) {
> +	if (IS_ERR(sock)) {
>  		recv_sockets.sk6 = NULL;
>  		pr_err("Failed to create IPv6 UDP tunnel\n");
>  		return -1;
>  	}
> +	recv_sockets.sk6 = sock;
>  #endif
>  	return 0;
>  }
>  
> +int rxe_register_notifier(void)
> +{
> +	int err;
> +
> +	err = register_netdevice_notifier(&rxe_net_notifier);
> +	if (err) {
> +		pr_err("Failed to register netdev notifier\n");
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
>  void rxe_net_exit(void)
>  {
>  	rxe_release_udp_tunnel(recv_sockets.sk6);
> @@ -669,19 +701,12 @@ int rxe_net_init(void)
>  {
>  	int err;
>  
> -	recv_sockets.sk6 = NULL;
> -
>  	err = rxe_net_ipv4_init();
>  	if (err)
>  		return err;
>  	err = rxe_net_ipv6_init();
>  	if (err)
>  		goto err_out;
> -	err = register_netdevice_notifier(&rxe_net_notifier);
> -	if (err) {
> -		pr_err("Failed to register netdev notifier\n");
> -		goto err_out;
> -	}
>  	return 0;
>  err_out:
>  	rxe_net_exit();
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.h b/drivers/infiniband/sw/rxe/rxe_net.h
> index 45d80d00f86b..a222c3eeae12 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.h
> +++ b/drivers/infiniband/sw/rxe/rxe_net.h
> @@ -18,6 +18,7 @@ struct rxe_recv_sockets {
>  
>  int rxe_net_add(const char *ibdev_name, struct net_device *ndev);
>  
> +int rxe_register_notifier(void);
>  int rxe_net_init(void);
>  void rxe_net_exit(void);
>  

