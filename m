Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6637E73C768
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Jun 2023 09:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjFXHk4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 24 Jun 2023 03:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjFXHkw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 24 Jun 2023 03:40:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBE0272D
        for <linux-rdma@vger.kernel.org>; Sat, 24 Jun 2023 00:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687592450; x=1719128450;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=76iMsoBzLMB23xO1qFOsLObjj8vXnJ3mnu4nUAoBWdg=;
  b=a+CK5uYnj0VGCQeNd8/wq2xZ8irpIHE0hmfxqL4XY8XbKfZhM5jSfTJv
   WKlghOGK5t70zgkdqbWmaLlC8vxLzaBexDw6D01JMNPnZ2cnDxECf96yG
   713KU41KHM1xxRcx69oudIGpLwz6qROeQJT9f5wWKNfs/VSkmBCl73d/m
   rIh1/rvVGy6tfFd6RMOSHow9J247hWgXRkNGcEmt9MBdYZQ69TtEPhn8h
   X/aUyVJdBK8FgLJk9ACBui02vxbsYgri6EXkb5tNe8NOXNIpm7JVO4TC6
   DqBZUSO1mH+T2plOGc2bhnXSMc1t5KjBjiZduBXTL/U4M4Nm5/VW5SSS7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="340517859"
X-IronPort-AV: E=Sophos;i="6.01,154,1684825200"; 
   d="scan'208";a="340517859"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2023 00:40:07 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="750240645"
X-IronPort-AV: E=Sophos;i="6.01,154,1684825200"; 
   d="scan'208";a="750240645"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orsmga001.jf.intel.com with ESMTP; 24 Jun 2023 00:40:04 -0700
From:   Zhu Yanjun <yanjun.zhu@intel.com>
To:     zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org, parav@nvidia.com, lehrer@gmail.com,
        rpearsonhpe@gmail.com
Cc:     Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH v7 0/8] Fix the problem that rxe can not work in net
Date:   Sat, 24 Jun 2023 15:39:19 +0800
Message-Id: <20230624073927.707915-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Zhu Yanjun <yanjun.zhu@linux.dev>

When run "ip link add" command to add a rxe rdma link in a net
namespace, normally this rxe rdma link can not work in a net
name space.

The root cause is that a sock listening on udp port 4791 is created
in init_net when the rdma_rxe module is loaded into kernel. That is,
the sock listening on udp port 4791 is created in init_net. Other net
namespace is difficult to use this sock.

The following commits will solve this problem.

In the first commit, move the creating sock listening on udp port 4791
from module_init function to rdma link creating functions. That is,
after the module rdma_rxe is loaded, the sock will not be created.
When run "rdma link add ..." command, the sock will be created. So
when creating a rdma link in the net namespace, the sock will be
created in this net namespace.

In the second commit, the functions udp4_lib_lookup and udp6_lib_lookup
will check the sock exists in the net namespace or not. If yes, rdma
link will increase the reference count of this sock, then continue other
jobs instead of creating a new sock to listen on udp port 4791. Since the
network notifier is global, when the module rdma_rxe is loaded, this
notifier will be registered.

After the rdma link is created, the command "rdma link del" is to
delete rdma link at the same time the sock is checked. If the reference
count of this sock is greater than the sock reference count needed by
udp tunnel, the sock reference count is decreased by one. If equal, it
indicates that this rdma link is the last one. As such, the udp tunnel
is shut down and the sock is closed. The above work should be
implemented in linkdel function. But currently no dellink function in
rxe. So the 3rd commit addes dellink function pointer. And the 4th
commit implements the dellink function in rxe.

To now, it is not necessary to keep a global variable to store the sock
listening udp port 4791. This global variable can be replaced by the
functions udp4_lib_lookup and udp6_lib_lookup totally. Because the
function udp6_lib_lookup is in the fast path, a member variable l_sk6
is added to store the sock. If l_sk6 is NULL, udp6_lib_lookup is called
to lookup the sock, then the sock is stored in l_sk6, in the future,it
can be used directly.

All the above work has been done in init_net. And it can also work in
the net namespace. So the init_net is replaced by the individual net
namespace. This is what the 6th commit does. Because rxe device is
dependent on the net device and the sock listening on udp port 4791,
every rxe device is in exclusive mode in the individual net namespace.
Other rdma netns operations will be considerred in the future.

In the 7th commit, the register_pernet_subsys/unregister_pernet_subsys
functions are added. When a new net namespace is created, the init
function will initialize the sk4 and sk6 socks. Then the 2 socks will
be released when the net namespace is destroyed. The functions
rxe_ns_pernet_sk4/rxe_ns_pernet_set_sk4 will get and set sk4 in the net
namespace. The functions rxe_ns_pernet_sk6/rxe_ns_pernet_set_sk6 will
handle sk6. Then sk4 and sk6 are used in the previous commits.

As the sk4 and sk6 in pernet namespace can be accessed, it is not
necessary to add a new l_sk6. As such, in the 8th commit, the l_sk6 is
replaced with the sk6 in pernet namespace.

Test steps:
1) Suppose that 2 NICs are in 2 different net namespaces.

  # ip netns exec net0 ip link
  3: eno2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP
     link/ether 00:1e:67:a0:22:3f brd ff:ff:ff:ff:ff:ff
     altname enp5s0

  # ip netns exec net1 ip link
  4: eno3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel
     link/ether f8:e4:3b:3b:e4:10 brd ff:ff:ff:ff:ff:ff

2) Add rdma link in the different net namespace
    net0:
    # ip netns exec net0 rdma link add rxe0 type rxe netdev eno2

    net1:
    # ip netns exec net1 rdma link add rxe1 type rxe netdev eno3

3) Run rping test.
    net0
    # ip netns exec net0 rping -s -a 192.168.2.1 -C 1&
    [1] 1737
    # ip netns exec net1 rping -c -a 192.168.2.1 -d -v -C 1
    verbose
    count 1
    ...
    ping data: rdma-ping-0: ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqr
    ...

4) Remove the rdma links from the net namespaces.
    net0:
    # ip netns exec net0 ss -lu
    State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port    Process
    UNCONN    0         0         0.0.0.0:4791          0.0.0.0:*
    UNCONN    0         0         [::]:4791             [::]:*

    # ip netns exec net0 rdma link del rxe0

    # ip netns exec net0 ss -lu
    State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port    Process

    net1:
    # ip netns exec net0 ss -lu
    State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port    Process
    UNCONN    0         0         0.0.0.0:4791          0.0.0.0:*
    UNCONN    0         0         [::]:4791             [::]:*

    # ip netns exec net1 rdma link del rxe1

    # ip netns exec net0 ss -lu
    State     Recv-Q    Send-Q    Local Address:Port    Peer Address:Port    Process

V6->V7: Fix the crash problem for drivers like siw.

V5->V6: Fix resource leak problem when rxe_net_init fails. And fix some
	style problems.

V4->V5: Rebase the commits to V6.4-rc1

V3->V4: Rebase the commits to rdma-next;

V2->V3: 1) Add "rdma link del" example in the cover letter, and use "ss -lu" to
           verify rdma link is removed.
        2) Add register_pernet_subsys/unregister_pernet_subsys net namespace
        3) Replace l_sk6 with sk6 of pernet_name_space

V1->V2: Add the explicit initialization of sk6.


Zhu Yanjun (8):
  RDMA/rxe: Creating listening sock in newlink function
  RDMA/rxe: Support more rdma links in init_net
  RDMA/nldev: Add dellink function pointer
  RDMA/rxe: Implement dellink in rxe
  RDMA/rxe: Replace global variable with sock lookup functions
  RDMA/rxe: add the support of net namespace
  RDMA/rxe: Add the support of net namespace notifier
  RDMA/rxe: Replace l_sk6 with sk6 in net namespace

 drivers/infiniband/core/nldev.c     |   6 ++
 drivers/infiniband/sw/rxe/Makefile  |   3 +-
 drivers/infiniband/sw/rxe/rxe.c     |  35 +++++++-
 drivers/infiniband/sw/rxe/rxe_net.c | 119 ++++++++++++++++++------
 drivers/infiniband/sw/rxe/rxe_net.h |   9 +-
 drivers/infiniband/sw/rxe/rxe_ns.c  | 134 ++++++++++++++++++++++++++++
 drivers/infiniband/sw/rxe/rxe_ns.h  |  17 ++++
 include/rdma/rdma_netlink.h         |   2 +
 8 files changed, 285 insertions(+), 40 deletions(-)
 create mode 100644 drivers/infiniband/sw/rxe/rxe_ns.c
 create mode 100644 drivers/infiniband/sw/rxe/rxe_ns.h

-- 
2.27.0

