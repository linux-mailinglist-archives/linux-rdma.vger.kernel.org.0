Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC987375FE
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jun 2023 22:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjFTUVU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Jun 2023 16:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjFTUVT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 20 Jun 2023 16:21:19 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E77CC
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 13:21:17 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-55ab0f777afso3484454eaf.1
        for <linux-rdma@vger.kernel.org>; Tue, 20 Jun 2023 13:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687292476; x=1689884476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MMn/Gv6jtrfHfyWNN2aWiuPnQttFk/47JZgZJKZOu5A=;
        b=MPvXeFe4HJ0KhhxPXunjHBFRCmJbjkk7r1hNQJF2mdLvQeZ3L8tFB2jyQTuXHCqUHX
         eiWT5NRK9DKYrybAFVWh1QzeyZ58YsYPUGKPe5Wokhv4OFykGGVWEG/QwHbzaEhH6lll
         rEBP2YfoUDKinj5NbhrxIMYOY7aKJjoyX1y/yqAnkUDIYpN/H21VNFFoevwVJs6fZl0P
         Fgmdc928V94FERZ2x5UB1CXXEfDxhp7ZpjtCgPvqqYQOhT4Wk2bfp2l2WjAlkRE/lSj6
         gTlwt7JXpRMfv/5JsnLUHsYEDjBLd1Xaf9pZfTnpYcSlccT6o5llWXCRuzzTuZVmwAbr
         N7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687292476; x=1689884476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MMn/Gv6jtrfHfyWNN2aWiuPnQttFk/47JZgZJKZOu5A=;
        b=Y3eGvSy9woR23kLvMOIUtNKexlFu1Ra6AxE+/F9SkAlYDKeHGDQQ9P3kXaGDd6+boo
         TcqRWJUCMsypxewmR3V0s98/E0dLaWCkGV4OMxeMtbrM/534K2WkyU3HaBpJ3s1ui48k
         ymLVcpVuGM/nuCdX4oyaOMZI/wtEZqNI8BBaPewvSDArOU4zuoQ6jW7PhwDtZWHajsq9
         TY3dlLmr0LR4VG4kd0Ve4By9RgRjvBpS7Rg81JzW3qnUDTn3h7SKyuCn82iiy0BURFCF
         ZG37Y8ORNMI1bFUarTypZuYTBTNB5TggKxVDa6sFoUnz2FSR2XbXSRb/2b4tUmKakMzJ
         IcCw==
X-Gm-Message-State: AC+VfDxmuc25IjpMgohSRSz3syqRMRBKbf2xgOx5fMesfZSfQNupZ/Le
        6kZPAvIVJ6BDTOhqorCNhUg=
X-Google-Smtp-Source: ACHHUZ7Pl8gAEFoRs8Ru0L9ftNsFult+1wML4nlxGIqqkw21YWGOuWqqg5ZsH5mf5iy/qdD0YI3ZNA==
X-Received: by 2002:a4a:ddcc:0:b0:560:aa1d:fe01 with SMTP id i12-20020a4addcc000000b00560aa1dfe01mr85034oov.2.1687292475947;
        Tue, 20 Jun 2023 13:21:15 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:68fa:2239:ab57:606a? (2603-8081-140c-1a00-68fa-2239-ab57-606a.res6.spectrum.com. [2603:8081:140c:1a00:68fa:2239:ab57:606a])
        by smtp.gmail.com with ESMTPSA id h3-20020a4ab443000000b0055ab0abaf31sm1319410ooo.19.2023.06.20.13.21.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 13:21:15 -0700 (PDT)
Message-ID: <28959f27-46a2-6b51-e0cc-f80546d0f27f@gmail.com>
Date:   Tue, 20 Jun 2023 15:21:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCHv5 for-rc1 v5 4/8] RDMA/rxe: Implement dellink in rxe
Content-Language: en-US
To:     Zhu Yanjun <yanjun.zhu@intel.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        parav@nvidia.com, lehrer@gmail.com
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>,
        Rain River <rain.1986.08.12@gmail.com>
References: <20230428093914.2121131-1-yanjun.zhu@intel.com>
 <20230428093914.2121131-5-yanjun.zhu@intel.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20230428093914.2121131-5-yanjun.zhu@intel.com>
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
> When running "rdma link del" command, dellink function will be called.
> If the sock refcnt is greater than the refcnt needed for udp tunnel,
> the sock refcnt will be decreased by 1.
> 
> If equal, the last rdma link is removed. The udp tunnel will be
> destroyed.
> 
> Tested-by: Rain River <rain.1986.08.12@gmail.com>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe.c     | 12 +++++++++++-
>  drivers/infiniband/sw/rxe/rxe_net.c | 17 +++++++++++++++--
>  drivers/infiniband/sw/rxe/rxe_net.h |  1 +
>  3 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index 0ce6adb43cfc..ebfabc6d6b76 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -166,10 +166,12 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
>  /* called by ifc layer to create new rxe device.
>   * The caller should allocate memory for rxe by calling ib_alloc_device.
>   */
> +static struct rdma_link_ops rxe_link_ops;
>  int rxe_add(struct rxe_dev *rxe, unsigned int mtu, const char *ibdev_name)
>  {
>  	rxe_init(rxe);
>  	rxe_set_mtu(rxe, mtu);
> +	rxe->ib_dev.link_ops = &rxe_link_ops;
>  
>  	return rxe_register_device(rxe, ibdev_name);
>  }
> @@ -206,9 +208,17 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
>  	return err;
>  }
>  
> -struct rdma_link_ops rxe_link_ops = {
> +static int rxe_dellink(struct ib_device *dev)
> +{
> +	rxe_net_del(dev);
> +
> +	return 0;
> +}
> +
> +static struct rdma_link_ops rxe_link_ops = {
>  	.type = "rxe",
>  	.newlink = rxe_newlink,
> +	.dellink = rxe_dellink,
>  };
>  
>  static int __init rxe_module_init(void)
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 3ca92e062800..4cc7de7b115b 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -530,6 +530,21 @@ int rxe_net_add(const char *ibdev_name, struct net_device *ndev)
>  	return 0;
>  }
>  
> +#define SK_REF_FOR_TUNNEL	2
> +void rxe_net_del(struct ib_device *dev)
> +{
> +	if (refcount_read(&recv_sockets.sk6->sk->sk_refcnt) > SK_REF_FOR_TUNNEL)
> +		__sock_put(recv_sockets.sk6->sk);
> +	else
> +		rxe_release_udp_tunnel(recv_sockets.sk6);
> +
> +	if (refcount_read(&recv_sockets.sk4->sk->sk_refcnt) > SK_REF_FOR_TUNNEL)
> +		__sock_put(recv_sockets.sk4->sk);
> +	else
> +		rxe_release_udp_tunnel(recv_sockets.sk4);
> +}
> +#undef SK_REF_FOR_TUNNEL
> +
>  static void rxe_port_event(struct rxe_dev *rxe,
>  			   enum ib_event_type event)
>  {
> @@ -689,8 +704,6 @@ int rxe_register_notifier(void)
>  
>  void rxe_net_exit(void)
>  {
> -	rxe_release_udp_tunnel(recv_sockets.sk6);
> -	rxe_release_udp_tunnel(recv_sockets.sk4);
>  	unregister_netdevice_notifier(&rxe_net_notifier);
>  }
These calls are moved to rxe_net_del which is called by an explicit unlink command.
But if rxe_net_init fails and returns an error code this will never happen.
This will result in leaking resources.

Bob
>  
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.h b/drivers/infiniband/sw/rxe/rxe_net.h
> index a222c3eeae12..f48f22f3353b 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.h
> +++ b/drivers/infiniband/sw/rxe/rxe_net.h
> @@ -17,6 +17,7 @@ struct rxe_recv_sockets {
>  };
>  
>  int rxe_net_add(const char *ibdev_name, struct net_device *ndev);
> +void rxe_net_del(struct ib_device *dev);
>  
>  int rxe_register_notifier(void);
>  int rxe_net_init(void);

