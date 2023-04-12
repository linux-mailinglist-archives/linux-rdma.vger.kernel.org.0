Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C6E6DFC9B
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Apr 2023 19:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjDLRW6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Apr 2023 13:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjDLRW5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Apr 2023 13:22:57 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501F52D55
        for <linux-rdma@vger.kernel.org>; Wed, 12 Apr 2023 10:22:55 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id cg4so3600397qtb.11
        for <linux-rdma@vger.kernel.org>; Wed, 12 Apr 2023 10:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681320174; x=1683912174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hCmnbNBkMz1sibsoINRecaXpVAo2jliVnlnN+PE5CQI=;
        b=XDKHXdmSS+wCInDF6umUKzTGDY7EQkp3XvovwCPrP3Sq/xFQSdZ1Fs+lNUNApXVIZ1
         UVrP8C4ENXe2cGROnE+sjG8ucwQF9HZOWpXB8sVzqqo/h8FYsolCvsIBjUCqSI2RQxUQ
         BMac/cWY3/Kv4qmSGq2T2/E5EKLRsXJGGh/vPKM5ugW8m4J/6vIFvwneNMDeVcffUiBx
         CeoXXg/btX8ONcQ1zXlPPqZiKs2YFH/sGXL0FtVJYLyLU0AKdYAGhioEATyi4wpQ4WmX
         DMU0NkuSmLidi9ZFha5bdXPfkd/pMIsN2s0+J4tV0S3iDKVkC9lAFVMv4xB55Gd3fzWs
         whzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681320174; x=1683912174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hCmnbNBkMz1sibsoINRecaXpVAo2jliVnlnN+PE5CQI=;
        b=TRC2wT/fo+iw/rYcBM6dLccGaDCSGphCJw2EYSJ3Ou3J/MLE0is7kLB+G5jBD1ngM8
         Od5qUyLi9B4wqkTpDXS+C2UoewGjhDFYbvaFxx9ahhUEHIFTpbe7DIKdmkMDehhKLu8c
         Fgq2Bw6KZD5PFVGbhnpgLtA4tP5p0BM9bT9Ci1PT5Ib2he9FaZPcZ2nbf7sL64h6UTAw
         f8R8RhEI3b2zu+MYBT5JtQL5usiwbVP9GiWsfNkyeqAWPAacWgkeyxmofy96NOHuI76k
         /Ha+IWOKJqe6a5kwnlS6SSZYV00u4O1dcBmB5XGm0ass/YqkIXK+pILQRbHFGWNiZd2g
         CVRA==
X-Gm-Message-State: AAQBX9c/uRr70YZbnIjpK8ROlpuwQ9oZN9f2Xg0+B714vBif8FQV8pc5
        F64JGxUG9/A6GTL9qZheigjW+vUPV9YJcAIr+p0=
X-Google-Smtp-Source: AKy350aHtc4JHJ+GG/iYGCAfo1Kj+JMZDeQZr8c3liIDNDLtpFGKquurNBfE7T1Ncio53R+4FxB4p2YTPpsjyV9LEqU=
X-Received: by 2002:ac8:7c53:0:b0:3e8:316e:3dd4 with SMTP id
 o19-20020ac87c53000000b003e8316e3dd4mr1088811qtv.11.1681320174299; Wed, 12
 Apr 2023 10:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230214060634.427162-1-yanjun.zhu@intel.com>
In-Reply-To: <20230214060634.427162-1-yanjun.zhu@intel.com>
From:   Mark Lehrer <lehrer@gmail.com>
Date:   Wed, 12 Apr 2023 11:22:43 -0600
Message-ID: <CADvaNzUvWA56BnZqNy3niEC-B0w41TPB+YFGJbn=3bKBi9Orcg@mail.gmail.com>
Subject: Re: [PATCHv3 0/8] Fix the problem that rxe can not work in net namespace
To:     Zhu Yanjun <yanjun.zhu@intel.com>
Cc:     jgg@ziepe.ca, leon@kernel.org, zyjzyj2000@gmail.com,
        linux-rdma@vger.kernel.org, parav@nvidia.com,
        Zhu Yanjun <yanjun.zhu@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

> When run "ip link add" command to add a rxe rdma link in a net
> namespace, normally this rxe rdma link can not work in a net
> name space.

Thank you for this patch, Yanjun!  It is very helpful for some
research I'm doing.  I just tested the patch and now I have success
with utilities like rping and ib_send_bw.  It looks like rdma_cm is at
least doing the basics with no problems.

However, I am still not able to "nvme discover" - this fails with
rdma_resolve_addr error -101.  It looks like this function is part of
rdma_cma.  Is this expected to work, or is more patching needed for
nvme-cli to have success?

It looks like the kernel nvme-fabrics driver is making the call to
rdma_resolve_addr here.  According to strace, nvme-cli is just opening
the fabrics device and writing the host NQN etc.  Is there an easy way
to prove that rdma_resolve_addr is working from userland?

Thanks,
Mark



On Mon, Feb 13, 2023 at 11:13=E2=80=AFPM Zhu Yanjun <yanjun.zhu@intel.com> =
wrote:
>
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
>     ping data: rdma-ping-0: ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklm=
nopqr
>     ...
>
> 4) Remove the rdma links from the net namespaces.
>     net0:
>     # ip netns exec net0 ss -lu
>     State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port=
    Process
>     UNCONN    0         0         0.0.0.0:4791          0.0.0.0:*
>     UNCONN    0         0         [::]:4791             [::]:*
>
>     # ip netns exec net0 rdma link del rxe0
>
>     # ip netns exec net0 ss -lu
>     State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port=
    Process
>
>     net1:
>     # ip netns exec net0 ss -lu
>     State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port=
    Process
>     UNCONN    0         0         0.0.0.0:4791          0.0.0.0:*
>     UNCONN    0         0         [::]:4791             [::]:*
>
>     # ip netns exec net1 rdma link del rxe1
>
>     # ip netns exec net0 ss -lu
>     State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port=
    Process
>
> V2->V3: 1) Add "rdma link del" example in the cover letter, and use "ss -=
lu" to
>            verify rdma link is removed.
>         2) Add register_pernet_subsys/unregister_pernet_subsys net namesp=
ace
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
>  drivers/infiniband/sw/rxe/rxe_net.c | 113 +++++++++++++++++-------
>  drivers/infiniband/sw/rxe/rxe_net.h |   9 +-
>  drivers/infiniband/sw/rxe/rxe_ns.c  | 128 ++++++++++++++++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_ns.h  |  11 +++
>  include/rdma/rdma_netlink.h         |   2 +
>  8 files changed, 267 insertions(+), 40 deletions(-)
>  create mode 100644 drivers/infiniband/sw/rxe/rxe_ns.c
>  create mode 100644 drivers/infiniband/sw/rxe/rxe_ns.h
>
> --
> 2.34.1
>
