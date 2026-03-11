Return-Path: <linux-rdma+bounces-18030-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBvwGXPnsWmcGwAAu9opvQ
	(envelope-from <linux-rdma+bounces-18030-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 23:06:43 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D61D526AC17
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 23:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 132A630D3774
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 22:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FFF358391;
	Wed, 11 Mar 2026 22:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b5uQGk0l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C26E352926
	for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773266526; cv=none; b=tozmTfEez82XjCO5cD3cphVaTiYTMcobx4O8LjfmfhvX7bWXxKXQINSZp5a8cMFwEsSfGqguRaDDP1c3kpPpSm34SjTA8atW8Wgo3uuLTgELInXI5rdJiKs08y9Xb11oEY/z5pP4OmgaeehSvWsnEueqtQ9rk7gVSLRdjIGm5fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773266526; c=relaxed/simple;
	bh=UgLryemejYDkrKLQCHN3ggWk/1jIuVfpQTdJfgI4uBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4xNOOSAYEUxHj6upA0uNdiHJYo/A6cBZ3UuYpfXJzWsAZF2+krWl+/7lxc1qocduT2/Nz5CVcRE1kpRoVAekbAoh0i5ibOQvy5JORtKK35gGTCP/NIjhypNKxAba/R6bU3bhKUMgvZTpMcSWAVrvjRP0gDWMmmlcrO+251wKu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b5uQGk0l; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6a8b0983-a198-470a-8125-b0133ccb7032@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773266522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fDrvhZooVIidtSklPGb5zNTEhhukwtMPI7dovIzwlNw=;
	b=b5uQGk0l1X3OV/lTxvXyprilkWy7U8Brk1R90gGRI8/KRkeUHaUEpbicrDsgvaM0xZpr5H
	u8PQUi3+LziKEcY0+L8VaohJ3CJrdAXYTlqlBdeoO6IFzTwP7ILXaa+y555hPXey5KN1b6
	Qpt1MMcvNtjoRnIT5joPxYp2w9XXTIA=
Date: Wed, 11 Mar 2026 15:01:53 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/4] RDMA/nldev: Add dellink function pointer
To: Leon Romanovsky <leon@kernel.org>, Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: jgg@ziepe.ca, zyjzyj2000@gmail.com, shuah@kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
 dsahern@kernel.org
References: <20260310020519.101415-1-yanjun.zhu@linux.dev>
 <20260310020519.101415-2-yanjun.zhu@linux.dev>
 <20260310190140.GL12611@unreal>
 <5700c718-d10e-4b23-adfc-c14ee1930b18@linux.dev>
 <20260311085434.GW12611@unreal>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260311085434.GW12611@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ziepe.ca,gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-18030-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D61D526AC17
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/11/26 1:54 AM, Leon Romanovsky wrote:
> On Tue, Mar 10, 2026 at 06:58:00PM -0700, Yanjun.Zhu wrote:
>> On 3/10/26 12:01 PM, Leon Romanovsky wrote:
>>> It is an RXE‑specific description, but you are adding code to the general
>>> nldev path. Please clarify that this behavior applies only to RXE, and
>>> include examples showing when and how it is invoked. In particular, explain
>>> how the socket is cleaned up if delink is not called.
>> Hi, Leon
>>
>> You are correct that this logic should be driver-specific. I will add an
>> explicit check for RDMA_DRIVER_RXE in the nldev path to ensure this behavior
>> is strictly scoped to RXE and does not impact other drivers (like iWARP).
> No, you don't need this driver_id check, because iWARP doesn't have link_ops->dellink,
> but you should document the rationale and how it is triggered for RXE.
>
> Thanks

Hi, Leaon

Got it. The commit log explains how the netdev_notifier mechanism is 
used to clean up the related resources.

In the source code, additional comments have been added to explain how 
the dellink operation for rxe is triggered. For iWARP, this change 
should not make any difference because iWARP does not implement the 
dellink function.

The commit is shown below. Please take a look and share your comments. 
If you agree, I will send out the latest commits out very soon.

 From c05038dcdf69c5985837736a8926ba76d9f3e8e4 Mon Sep 17 00:00:00 2001
From: Zhu Yanjun <yanjun.zhu@linux.dev>
Date: Fri, 23 Sep 2022 16:52:45 +0000
Subject: [PATCH 1/1] RDMA/nldev: Add dellink function pointer

The newlink function pointer was previously added to support
dynamic RDMA link creation. In the RXE driver, this path creates
a transport socket listening on port 4791. Consequently, a dellink
function pointer is required to ensure these sockets are properly
closed when a user administratively removes a link via rdma link
delete <dev>.

Furthermore, RXE does not rely solely on this nldev path for resource
management. It also monitors the underlying net_device state via a
registered netdev_notifier. The rxe_net_event callback serves as a
fallback mechanism to ensure that transport sockets are forcibly closed
and all resources are released even if dellink is not explicitly called
(e.g., if the parent NIC interface is removed or the driver is forcefully
unloaded).

Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
  drivers/infiniband/core/nldev.c | 12 ++++++++++++
  include/rdma/rdma_netlink.h     |  2 ++
  2 files changed, 14 insertions(+)

diff --git a/drivers/infiniband/core/nldev.c 
b/drivers/infiniband/core/nldev.c
index 2220a2dfab24..34f5faf80d9c 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1824,6 +1824,18 @@ static int nldev_dellink(struct sk_buff *skb, 
struct nlmsghdr *nlh,
          return -EINVAL;
      }

+    /*
+     * This path is triggered by the 'rdma link delete' administrative 
command.
+     * For Soft-RoCE (RXE), we ensure that transport sockets are closed 
here.
+     * Note: iWARP driver does not implement .dellink, so this logic is
+     * implicitly scoped to driver supporting dynamic link deletion 
like RXE.
+     */
+    if (device->link_ops && device->link_ops->dellink) {
+        err = device->link_ops->dellink(device);
+        if (err)
+            return err;
+    }
+
      ib_unregister_device_and_put(device);
      return 0;
  }
diff --git a/include/rdma/rdma_netlink.h b/include/rdma/rdma_netlink.h
index 326deaf56d5d..2fd1358ea57d 100644
--- a/include/rdma/rdma_netlink.h
+++ b/include/rdma/rdma_netlink.h
@@ -5,6 +5,7 @@

  #include <linux/netlink.h>
  #include <uapi/rdma/rdma_netlink.h>
+#include <rdma/ib_verbs.h>

  struct ib_device;

@@ -126,6 +127,7 @@ struct rdma_link_ops {
      struct list_head list;
      const char *type;
      int (*newlink)(const char *ibdev_name, struct net_device *ndev);
+    int (*dellink)(struct ib_device *dev);
  };

  void rdma_link_register(struct rdma_link_ops *ops);
-- 
2.53.0

>
>> This function path is primarily invoked when a user executes the
>> administrative command: rdma link delete <dev>.
>>
>> Regarding socket cleanup: RXE does not rely solely on this path for resource
>> management. It monitors the underlying net_device state via a registered
>> netdev_notifier. Even if delink is not explicitly called (e.g., if the
>> parent interface is removed or the driver is forcefully unloaded), the
>> rxe_net_event callback ensures that the transport sockets are forcibly
>> closed and all allocated resources are released when the parent net_device
>> is destroyed.
>>
>> The code diff is as below:
>>
>> --- a/drivers/infiniband/core/nldev.c
>> +++ b/drivers/infiniband/core/nldev.c
>> @@ -1824,6 +1824,12 @@ static int nldev_dellink(struct sk_buff *skb, struct
>> nlmsghdr *nlh,
>>                  return -EINVAL;
>>          }
>>
>> +       if (device->link_ops && device->ops.driver_id == RDMA_DRIVER_RXE) {
>> +               err = device->link_ops->dellink(device);
>> +               if (err)
>> +                       return err;
>> +       }
>> +
>>          ib_unregister_device_and_put(device);
>>          return 0;
>>   }
>>
>> Zhu Yanjun
>>
>>

