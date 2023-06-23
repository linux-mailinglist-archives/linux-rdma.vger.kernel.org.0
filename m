Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BAF73B857
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jun 2023 15:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjFWNA7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jun 2023 09:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjFWNA6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Jun 2023 09:00:58 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A901A1BC6
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jun 2023 06:00:57 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-562fe8dda4fso394844eaf.1
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jun 2023 06:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687525257; x=1690117257;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wmgx9+bHb74wxkRYarlKAmFMKF6B/SMQ3wnASj61dR4=;
        b=heYXn7TU5qpjBNB78SC0EbNNXadd+DgjpKvGQbONEz+Qhl71cf9M5adgwZjDIDqZA2
         R1kuSfpYpkuRGExdGfWa+YzflVQbo4D3W+aj5L+Li52Ft/N8Ap4f6/hbEjk7y1ZbIgqW
         I88OsQMnUCjJ2PqIPZFsrL05sHzMCVJ1WzTgIM4U+r8YEbBoeVn4PvUunOIynEadTKrt
         7LqG3ORfgOhNBheq9LA6iW2a4i8J506klTsItHZh9a027BlAtCzUWUeHxei2wJXZ5gvF
         gAH5TuHmprbef7jWWQVWzySy9diC752Wjicj2PTpHf5Dstiv0/t/Uz+qNGi5+Ok/zIBU
         OyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687525257; x=1690117257;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wmgx9+bHb74wxkRYarlKAmFMKF6B/SMQ3wnASj61dR4=;
        b=A2SNlxEOsp0eTGC3Zldi0Ca0qA90/jNM9mjO/rkouucu2dw1boU4x5ZTO2UMnXrylA
         gRKeCHzoFBj6a9LDlw/aDAqEEiDqer/VrxKQfgI1HYlLxgdgEfPtVbu/7HoSvrKdoBBi
         LkvO/XLA4Iu50HN13L/IvAuu76XOcmy3v/l3VJA86GzlBnYOzKbcVLQR3amtDSPHsplf
         FEheQVof4Z5x50uxUXBB2l3EiKhu5LMxFZUTwvpk7qswMgBJvZw43uKhOo/JxfxX18j5
         7vpUrRVn8nqErRe/7Y2YxjgobNy++HbE0nLu7Z/hXh/Hs96u6Yel74hmO8ZR3HdocHV6
         jsmw==
X-Gm-Message-State: AC+VfDxigfOBCvwdn2zwsRvaFLaEiYoMF1jL9+Bjftlr6mf6bDxRvCJl
        rsVqQ4nBQfqIOW3HBFP8hV0=
X-Google-Smtp-Source: ACHHUZ5+sdNwNjRlxWYgHT1qUFpzDhpWA6FxpLxQe2+Pdbz+nmBh1FBen9cL8aCqf7T8delnmaDvYQ==
X-Received: by 2002:a4a:a2c3:0:b0:560:77ed:84d2 with SMTP id r3-20020a4aa2c3000000b0056077ed84d2mr10678977ool.5.1687525255148;
        Fri, 23 Jun 2023 06:00:55 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:9b77:c098:24ea:7620? (2603-8081-140c-1a00-9b77-c098-24ea-7620.res6.spectrum.com. [2603:8081:140c:1a00:9b77:c098:24ea:7620])
        by smtp.gmail.com with ESMTPSA id bi5-20020a05682008c500b0055891855e28sm3592628oob.37.2023.06.23.06.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jun 2023 06:00:54 -0700 (PDT)
Message-ID: <349b54b1-e002-3c55-3334-50873d401579@gmail.com>
Date:   Fri, 23 Jun 2023 08:00:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 0/8] Fix the problem that rxe can not work in net
 namespace
Content-Language: en-US
To:     Zhu Yanjun <yanjun.zhu@intel.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        parav@nvidia.com, lehrer@gmail.com
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
References: <20230623095749.485873-1-yanjun.zhu@intel.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20230623095749.485873-1-yanjun.zhu@intel.com>
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

On 6/23/23 04:57, Zhu Yanjun wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> When run "ip link add" command to add a rxe rdma link in a net
> namespace, normally this rxe rdma link can not work in a net
> name space.
> 
> The root cause is that a sock listening on udp port 4791 is created
> in init_net when the rdma_rxe module is loaded into kernel. That is,
> the sock listening on udp port 4791 is created in init_net. Other net
> namespace is difficult to use this sock.
> 
> The following commits will solve this problem.
> 
> In the first commit, move the creating sock listening on udp port 4791
> from module_init function to rdma link creating functions. That is,
> after the module rdma_rxe is loaded, the sock will not be created.
> When run "rdma link add ..." command, the sock will be created. So
> when creating a rdma link in the net namespace, the sock will be
> created in this net namespace.
> 
> In the second commit, the functions udp4_lib_lookup and udp6_lib_lookup
> will check the sock exists in the net namespace or not. If yes, rdma
> link will increase the reference count of this sock, then continue other
> jobs instead of creating a new sock to listen on udp port 4791. Since the
> network notifier is global, when the module rdma_rxe is loaded, this
> notifier will be registered.
> 
> After the rdma link is created, the command "rdma link del" is to
> delete rdma link at the same time the sock is checked. If the reference
> count of this sock is greater than the sock reference count needed by
> udp tunnel, the sock reference count is decreased by one. If equal, it
> indicates that this rdma link is the last one. As such, the udp tunnel
> is shut down and the sock is closed. The above work should be
> implemented in linkdel function. But currently no dellink function in
> rxe. So the 3rd commit addes dellink function pointer. And the 4th
> commit implements the dellink function in rxe.
> 
> To now, it is not necessary to keep a global variable to store the sock
> listening udp port 4791. This global variable can be replaced by the
> functions udp4_lib_lookup and udp6_lib_lookup totally. Because the
> function udp6_lib_lookup is in the fast path, a member variable l_sk6
> is added to store the sock. If l_sk6 is NULL, udp6_lib_lookup is called
> to lookup the sock, then the sock is stored in l_sk6, in the future,it
> can be used directly.
> 
> All the above work has been done in init_net. And it can also work in
> the net namespace. So the init_net is replaced by the individual net
> namespace. This is what the 6th commit does. Because rxe device is
> dependent on the net device and the sock listening on udp port 4791,
> every rxe device is in exclusive mode in the individual net namespace.
> Other rdma netns operations will be considerred in the future.
> 
> In the 7th commit, the register_pernet_subsys/unregister_pernet_subsys
> functions are added. When a new net namespace is created, the init
> function will initialize the sk4 and sk6 socks. Then the 2 socks will
> be released when the net namespace is destroyed. The functions
> rxe_ns_pernet_sk4/rxe_ns_pernet_set_sk4 will get and set sk4 in the net
> namespace. The functions rxe_ns_pernet_sk6/rxe_ns_pernet_set_sk6 will
> handle sk6. Then sk4 and sk6 are used in the previous commits.
> 
> As the sk4 and sk6 in pernet namespace can be accessed, it is not
> necessary to add a new l_sk6. As such, in the 8th commit, the l_sk6 is
> replaced with the sk6 in pernet namespace.
> 
> Test steps:
> 1) Suppose that 2 NICs are in 2 different net namespaces.
> 
>   # ip netns exec net0 ip link
>   3: eno2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
>      link/ether 00:1e:67:a0:22:3f brd ff:ff:ff:ff:ff:ff
>      altname enp5s0
> 
>   # ip netns exec net1 ip link
>   4: eno3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel
>      link/ether f8:e4:3b:3b:e4:10 brd ff:ff:ff:ff:ff:ff
> 
> 2) Add rdma link in the different net namespace
>     net0:
>     # ip netns exec net0 rdma link add rxe0 type rxe netdev eno2
> 
>     net1:
>     # ip netns exec net1 rdma link add rxe1 type rxe netdev eno3
> 
> 3) Run rping test.
>     net0
>     # ip netns exec net0 rping -s -a 192.168.2.1 -C 1&
>     [1] 1737
>     # ip netns exec net1 rping -c -a 192.168.2.1 -d -v -C 1
>     verbose
>     count 1
>     ...
>     ping data: rdma-ping-0: ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqr
>     ...
> 
> 4) Remove the rdma links from the net namespaces.
>     net0:
>     # ip netns exec net0 ss -lu
>     State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port    Process
>     UNCONN    0         0         0.0.0.0:4791          0.0.0.0:*
>     UNCONN    0         0         [::]:4791             [::]:*
> 
>     # ip netns exec net0 rdma link del rxe0
> 
>     # ip netns exec net0 ss -lu
>     State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port    Process
> 
>     net1:
>     # ip netns exec net0 ss -lu
>     State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port    Process
>     UNCONN    0         0         0.0.0.0:4791          0.0.0.0:*
>     UNCONN    0         0         [::]:4791             [::]:*
> 
>     # ip netns exec net1 rdma link del rxe1
> 
>     # ip netns exec net0 ss -lu
>     State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port    Process
> 
> V5->V6: Fix resource leak problem when rxe_net_init fails. And fix some
> 	style problems.
> 
> V4->V5: Rebase the commits to V6.4-rc1
> 
> V3->V4: Rebase the commits to rdma-next;
> 
> V2->V3: 1) Add "rdma link del" example in the cover letter, and use "ss -lu" to
>            verify rdma link is removed.
>         2) Add register_pernet_subsys/unregister_pernet_subsys net namespace
>         3) Replace l_sk6 with sk6 of pernet_name_space
> 
> V1->V2: Add the explicit initialization of sk6.
> 
> Zhu Yanjun (8):
>   RDMA/rxe: Creating listening sock in newlink function
>   RDMA/rxe: Support more rdma links in init_net
>   RDMA/nldev: Add dellink function pointer
>   RDMA/rxe: Implement dellink in rxe
>   RDMA/rxe: Replace global variable with sock lookup functions
>   RDMA/rxe: add the support of net namespace
>   RDMA/rxe: Add the support of net namespace notifier
>   RDMA/rxe: Replace l_sk6 with sk6 in net namespace
> 
>  drivers/infiniband/core/nldev.c     |   6 ++
>  drivers/infiniband/sw/rxe/Makefile  |   3 +-
>  drivers/infiniband/sw/rxe/rxe.c     |  35 +++++++-
>  drivers/infiniband/sw/rxe/rxe_net.c | 119 ++++++++++++++++++------
>  drivers/infiniband/sw/rxe/rxe_net.h |   9 +-
>  drivers/infiniband/sw/rxe/rxe_ns.c  | 134 ++++++++++++++++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_ns.h  |  17 ++++
>  include/rdma/rdma_netlink.h         |   2 +
>  8 files changed, 285 insertions(+), 40 deletions(-)
>  create mode 100644 drivers/infiniband/sw/rxe/rxe_ns.c
>  create mode 100644 drivers/infiniband/sw/rxe/rxe_ns.h
> 

I am OOO until Monday evening. I will try it then.

Bob
