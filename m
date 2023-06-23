Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DF873B11C
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Jun 2023 09:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjFWHPR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 23 Jun 2023 03:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFWHPP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 23 Jun 2023 03:15:15 -0400
Received: from out-9.mta0.migadu.com (out-9.mta0.migadu.com [91.218.175.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAF9212F
        for <linux-rdma@vger.kernel.org>; Fri, 23 Jun 2023 00:15:13 -0700 (PDT)
Message-ID: <8e13254c-f8f5-f9ce-14fe-f8fd21c0c6bd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687504511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TKeMAk+ckAnwN3KfmDSHnsgaQ9kJFrxNyYpqc3wg5CA=;
        b=epio+Lr4FV6iiwuRwg7g+mxyxpkF+1570YcuwwUpTBx3Ngj26nQp4n3xC+HTgKggnHmsTb
        rXBb0r4GigYiI1p6CipeoRrIbQL6cyRDXsD4sh220r42VniAFMXOYQPwzCLfNpoHCn6sUU
        z2V68lihQLH6xPg8qEGvYmA6oSPEH9A=
Date:   Fri, 23 Jun 2023 15:15:04 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v6.4-rc1 v5 0/8] Fix the problem that rxe can not work in
 net namespace
To:     Bob Pearson <rpearsonhpe@gmail.com>,
        Zhu Yanjun <yanjun.zhu@intel.com>, zyjzyj2000@gmail.com,
        jgg@ziepe.ca, leon@kernel.org, linux-rdma@vger.kernel.org,
        parav@nvidia.com, lehrer@gmail.com
References: <20230508075636.352138-1-yanjun.zhu@intel.com>
 <4f097d4a-85f5-392f-53bb-85ca0d75e16f@gmail.com>
 <fbba95ad-a0f7-435e-c152-d6094b70bb1f@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <fbba95ad-a0f7-435e-c152-d6094b70bb1f@gmail.com>
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


在 2023/6/22 5:27, Bob Pearson 写道:
> On 6/21/23 16:09, Bob Pearson wrote:
>> On 5/8/23 02:56, Zhu Yanjun wrote:
>>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>
>>> When run "ip link add" command to add a rxe rdma link in a net
>>> namespace, normally this rxe rdma link can not work in a net
>>> name space.
>>>
>>> The root cause is that a sock listening on udp port 4791 is created
>>> in init_net when the rdma_rxe module is loaded into kernel. That is,
>>> the sock listening on udp port 4791 is created in init_net. Other net
>>> namespace is difficult to use this sock.
>>>
>>> The following commits will solve this problem.
>>>
>>> In the first commit, move the creating sock listening on udp port 4791
>>> from module_init function to rdma link creating functions. That is,
>>> after the module rdma_rxe is loaded, the sock will not be created.
>>> When run "rdma link add ..." command, the sock will be created. So
>>> when creating a rdma link in the net namespace, the sock will be
>>> created in this net namespace.
>>>
>>> In the second commit, the functions udp4_lib_lookup and udp6_lib_lookup
>>> will check the sock exists in the net namespace or not. If yes, rdma
>>> link will increase the reference count of this sock, then continue other
>>> jobs instead of creating a new sock to listen on udp port 4791. Since the
>>> network notifier is global, when the module rdma_rxe is loaded, this
>>> notifier will be registered.
>>>
>>> After the rdma link is created, the command "rdma link del" is to
>>> delete rdma link at the same time the sock is checked. If the reference
>>> count of this sock is greater than the sock reference count needed by
>>> udp tunnel, the sock reference count is decreased by one. If equal, it
>>> indicates that this rdma link is the last one. As such, the udp tunnel
>>> is shut down and the sock is closed. The above work should be
>>> implemented in linkdel function. But currently no dellink function in
>>> rxe. So the 3rd commit addes dellink function pointer. And the 4th
>>> commit implements the dellink function in rxe.
>>>
>>> To now, it is not necessary to keep a global variable to store the sock
>>> listening udp port 4791. This global variable can be replaced by the
>>> functions udp4_lib_lookup and udp6_lib_lookup totally. Because the
>>> function udp6_lib_lookup is in the fast path, a member variable l_sk6
>>> is added to store the sock. If l_sk6 is NULL, udp6_lib_lookup is called
>>> to lookup the sock, then the sock is stored in l_sk6, in the future,it
>>> can be used directly.
>>>
>>> All the above work has been done in init_net. And it can also work in
>>> the net namespace. So the init_net is replaced by the individual net
>>> namespace. This is what the 6th commit does. Because rxe device is
>>> dependent on the net device and the sock listening on udp port 4791,
>>> every rxe device is in exclusive mode in the individual net namespace.
>>> Other rdma netns operations will be considerred in the future.
>>>
>>> In the 7th commit, the register_pernet_subsys/unregister_pernet_subsys
>>> functions are added. When a new net namespace is created, the init
>>> function will initialize the sk4 and sk6 socks. Then the 2 socks will
>>> be released when the net namespace is destroyed. The functions
>>> rxe_ns_pernet_sk4/rxe_ns_pernet_set_sk4 will get and set sk4 in the net
>>> namespace. The functions rxe_ns_pernet_sk6/rxe_ns_pernet_set_sk6 will
>>> handle sk6. Then sk4 and sk6 are used in the previous commits.
>>>
>>> As the sk4 and sk6 in pernet namespace can be accessed, it is not
>>> necessary to add a new l_sk6. As such, in the 8th commit, the l_sk6 is
>>> replaced with the sk6 in pernet namespace.
>>>
>>> Test steps:
>>> 1) Suppose that 2 NICs are in 2 different net namespaces.
>>>
>>>    # ip netns exec net0 ip link
>>>    3: eno2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
>>>       link/ether 00:1e:67:a0:22:3f brd ff:ff:ff:ff:ff:ff
>>>       altname enp5s0
>>>
>>>    # ip netns exec net1 ip link
>>>    4: eno3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel
>>>       link/ether f8:e4:3b:3b:e4:10 brd ff:ff:ff:ff:ff:ff
>>>
>>> 2) Add rdma link in the different net namespace
>>>      net0:
>>>      # ip netns exec net0 rdma link add rxe0 type rxe netdev eno2
>>>
>>>      net1:
>>>      # ip netns exec net1 rdma link add rxe1 type rxe netdev eno3
>>>
>>> 3) Run rping test.
>>>      net0
>>>      # ip netns exec net0 rping -s -a 192.168.2.1 -C 1&
>>>      [1] 1737
>>>      # ip netns exec net1 rping -c -a 192.168.2.1 -d -v -C 1
>>>      verbose
>>>      count 1
>>>      ...
>>>      ping data: rdma-ping-0: ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqr
>>>      ...
>>>
>>> 4) Remove the rdma links from the net namespaces.
>>>      net0:
>>>      # ip netns exec net0 ss -lu
>>>      State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port    Process
>>>      UNCONN    0         0         0.0.0.0:4791          0.0.0.0:*
>>>      UNCONN    0         0         [::]:4791             [::]:*
>>>
>>>      # ip netns exec net0 rdma link del rxe0
>>>
>>>      # ip netns exec net0 ss -lu
>>>      State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port    Process
>>>
>>>      net1:
>>>      # ip netns exec net0 ss -lu
>>>      State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port    Process
>>>      UNCONN    0         0         0.0.0.0:4791          0.0.0.0:*
>>>      UNCONN    0         0         [::]:4791             [::]:*
>>>
>>>      # ip netns exec net1 rdma link del rxe1
>>>
>>>      # ip netns exec net0 ss -lu
>>>      State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port    Process
>>>
>>> V4->V5: Rebase the commits to V6.4-rc1
>>>
>>> V3->V4: Rebase the commits to rdma-next;
>>>
>>> V2->V3: 1) Add "rdma link del" example in the cover letter, and use "ss -lu" to
>>>             verify rdma link is removed.
>>>          2) Add register_pernet_subsys/unregister_pernet_subsys net namespace
>>>          3) Replace l_sk6 with sk6 of pernet_name_space
>>>
>>> V1->V2: Add the explicit initialization of sk6.
>>>
>>> Zhu Yanjun (8):
>>>    RDMA/rxe: Creating listening sock in newlink function
>>>    RDMA/rxe: Support more rdma links in init_net
>>>    RDMA/nldev: Add dellink function pointer
>>>    RDMA/rxe: Implement dellink in rxe
>>>    RDMA/rxe: Replace global variable with sock lookup functions
>>>    RDMA/rxe: add the support of net namespace
>>>    RDMA/rxe: Add the support of net namespace notifier
>>>    RDMA/rxe: Replace l_sk6 with sk6 in net namespace
>>>
>>>   drivers/infiniband/core/nldev.c     |   6 ++
>>>   drivers/infiniband/sw/rxe/Makefile  |   3 +-
>>>   drivers/infiniband/sw/rxe/rxe.c     |  35 +++++++-
>>>   drivers/infiniband/sw/rxe/rxe_net.c | 113 +++++++++++++++++------
>>>   drivers/infiniband/sw/rxe/rxe_net.h |   9 +-
>>>   drivers/infiniband/sw/rxe/rxe_ns.c  | 134 ++++++++++++++++++++++++++++ip netns add test
>>>   drivers/infiniband/sw/rxe/rxe_ns.h  |  17 ++++
>>>   include/rdma/rdma_netlink.h         |   2 +
>>>   8 files changed, 279 insertions(+), 40 deletions(-)
>>>   create mode 100644 drivers/infiniband/sw/rxe/rxe_ns.c
>>>   create mode 100644 drivers/infiniband/sw/rxe/rxe_ns.hip netns add test
>>>
>> Zhu,
>>
>> I did some simple experiments on netns functionality.
>>
>> With your patch set applied and rxe0 created on enp6s0 and rxe1 created on lo in the default namespace
>>
>> 	# sudo ip netns add test
>> 	# ip netns
>> 	test
>> 	# sudo ip netns exec test ip link
>> 	1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>> 	    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>> 	# sudo ip netns exec test ip link set dev lo up
>> 	# sudo ip netns exec test ip link
>> 	1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
>> 	    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>> 	# sudo ip netns exec test ip addr add dev lo fe80::0200:00ff:fe00:0000/64
>> 		[rxe doesn't work unless this IPV6 address is set]
>> 	# sudo ip netns exec test ip addr
>> 	1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
>> 	    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>> 	    inet 127.0.0.1/8 scope host lo
>> 	       valid_lft forever preferred_lft forever
>> 	    inet6 fe80::200:ff:fe00:0/64 scope link
>> 	       valid_lft forever preferred_lft forever
>> 	    inet6 ::1/128 scope host
>> 	       valid_lft forever preferred_lft forever
>> 	# sudo ip netns exec test ls /sys/class/infiniband
>> 	rxe0  rxe1
>> 		[These show up even though the ndevs do *not* belong to the test namespace! Probably OK.]
>> 	# sudo ip netns exec test rdma link add rxe2 type rxe netdev lo
>> 	# ls /sys/class/infiniband
>> 	rxe0  rxe1  rxe2
>> 		[The new rxe device shows up in the default namespace. At least we're consistent.]
>> 	# ib_send_bw -d rxe0 ... 192.168.0.27
>> 		[Works. Didn't break the existing rxe devices. Expected]
>> 	# ib_send_bw -d rxe1 ... 127.0.0.1
>> 		[Works. Expected]
>> 	# ib_send_bw -d rxe2 ... 127.0.0.1
>> 	IB device rxe2 not found
>>   	 Unable to find the Infiniband/RoCE device
>> 		[Not work. Expected.]
>> 	# sudo ip netns exec test ib_send_bw -d rxe2 ... 127.0.0.1
>> 	IB device rxe2 not found
>> 	 Unable to find the Infiniband/RoCE device
>> 		[Also not work. Turns out rxe2 device is gone after failure. Not expected.]
>> 	# sudo ip netns exec test rdma link add rxe2 type rxe netdev lo
>> 	# ls /sys/class/infiniband
>> 	rxe0  rxe1  rxe2
>> 		[Good. It's back]
>> 	# sudo ip netns exec test ib_send_bw -d rxe2 ... 127.0.0.1
>> 		[Works in test namespace! Expected.]
>> 	# sudo ip netns exec test ib_send_bw -d rxe1 ... 127.0.0.1
>> 		[Also works. Definitely not expected.]
>>
>> My take, it sort of works. But there are some serious issues. You shouldn't be able to use the
>> rxe2 device in the default namespace. It would be nice if you couldn't see the rxe devices in each
>> other's namespaces (Like ip link or ip addr hide other namespace's devices.)
>>
>> Bob
> Forgot to mention. It also is definitely not good that a process in the default namespace can destroy
> a rxe device in the test namespace by trying to use it.

Thanks a lot.

I am not sure if it is correct or not to destroy a rxe device outside 
this this net namespace.

Because to irdma/mlx5 rdma devices, we can also destroy them with the 
command "modprobe -v irdma/mlx5..." outside of the net namespace.

I am not sure if this is correct or not.

Zhu Yanjun

>
> Bob
