Return-Path: <linux-rdma+bounces-21536-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLpBEKlpGmoY4QgAu9opvQ
	(envelope-from <linux-rdma+bounces-21536-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2026 06:38:01 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 419AF60B431
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2026 06:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9133C301C914
	for <lists+linux-rdma@lfdr.de>; Sat, 30 May 2026 04:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F80348C7B;
	Sat, 30 May 2026 04:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iGLkmWOK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5036B31E848
	for <linux-rdma@vger.kernel.org>; Sat, 30 May 2026 04:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780115869; cv=none; b=fOI06SWWbVSIavNFi5BmcNDkoxvEZzw+d/abeyJ4Ax7SHwIc/BOBnnkiRPHSA0XaCQUDUOyFH1CyjDORB12S4COQoGYAmFBme8lLJ7ctvK7Vh6OMfn460C9Mncwq17YiU6gk8ODlZfbIqMqEDuyXX8tslaxNsUzqTDNI+0/w+vQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780115869; c=relaxed/simple;
	bh=nQbwH/d5mkUA4nJttq+UluSVAgUeMFJ8KwLxit0i6BA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qhSrSUMq1dWEanIRZyZxLGQco45ZuHaRhSGLNhDKltYI7AtPqDv1jz5qwjZbBseQiaQWccrrBbJZVFTwpTGnKL8bCR7bkXRH+YcX9WppsVewyeLj94fmJ+Pz55xbat1psnsAcTn2hSosRD8Zg1lcgVnhHlf29uOhXuH1h5tn8SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iGLkmWOK; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a671f568-30d3-4565-b951-efdd640ef891@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780115855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7xfIlwYTEB8CjsXMc/LptJjgpEfExSIX+oI2TngdEuc=;
	b=iGLkmWOKh9D0xTNG/YBCRTunsJdLX7OKCqVSW6DXgN6rtO/wANyFDjyqs441TN0A00I6+h
	qyIyH99kMu5CwDWnuV2EXfd3JWFVscmQMkPYAEiPH7v1LhcPy3z6nU0ul62/4amr4WBXSo
	grVhi2cBG/VKKZXtkuHewEbRffQwG68=
Date: Fri, 29 May 2026 21:37:31 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: fix UDP tunnel socket leak on rxe_newlink
 failure
To: Purushothaman Ramalingam <purush.ramalingam@gmail.com>,
 Zhu Yanjun <zyjzyj2000@gmail.com>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260530001251.11136-1-purush.ramalingam@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260530001251.11136-1-purush.ramalingam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21536-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 419AF60B431
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

在 2026/5/29 17:12, Purushothaman Ramalingam 写道:
> rxe_newlink() calls rxe_net_init() to set up the per-net-namespace UDP
> tunnel sockets before calling rxe_net_add() to create and register the
> rxe device. rxe_net_init() takes a reference on the IPv4 and IPv6 tunnel
> sockets, creating them if they do not already exist.
> 
> If rxe_net_add() subsequently fails, rxe_newlink() returns the error
> without releasing those socket references. The normal teardown path,
> rxe_net_del(), is never reached because rxe_net_add() has already
> deallocated the rxe device on failure. As a result the tunnel socket
> references are leaked and the per-net sockets bound to UDP port 4791 can
> never be released.
> 
> Release the references on the error path by adding rxe_net_uninit(),
> which performs the same socket teardown as rxe_net_del(). The shared
> release logic is factored into a helper to avoid duplication.
> 
> Fixes: f1327abd6abe ("RDMA/rxe: Support RDMA link creation and destruction per net namespace")
> Signed-off-by: Purushothaman Ramalingam <purush.ramalingam@gmail.com>
> ---
>   drivers/infiniband/sw/rxe/rxe.c     |  1 +
>   drivers/infiniband/sw/rxe/rxe_net.c | 32 ++++++++++++++++++++---------
>   drivers/infiniband/sw/rxe/rxe_net.h |  1 +
>   3 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index af39209d0fcf..bcc72b96ee00 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -243,6 +243,7 @@ static int rxe_newlink(const char *ibdev_name, struct net_device *ndev)
>   	err = rxe_net_add(ibdev_name, ndev);
>   	if (err) {
>   		rxe_err("failed to add %s\n", ndev->name);
> +		rxe_net_uninit(ndev);
>   		goto err;

To avoid introducing an unnecessary single-line wrapper helper 
(rxe_net_uninit), we have refactored the cleanup logic by directly 
exporting the core rxe_release_sockets(struct net *net) function. Since 
the tunnel sockets are managed per network namespace, passing struct net 
* aligns perfectly with the network subsystem's conventions.

Additionally, we have removed the now-redundant err: label from 
rxe_newlink() to keep the error path clean and idiomatic.

Here is the updated patch:
"
diff --git a/drivers/infiniband/sw/rxe/rxe.c 
b/drivers/infiniband/sw/rxe/rxe.c
index b0714f9abe3d..a83512afd388 100644
--- a/drivers/infiniband/sw/rxe/rxe.c
+++ b/drivers/infiniband/sw/rxe/rxe.c
@@ -243,7 +243,7 @@ static int rxe_newlink(const char *ibdev_name, 
struct net_device *ndev)
         err = rxe_net_add(ibdev_name, ndev);
         if (err) {
                 rxe_err("failed to add %s\n", ndev->name);
-               goto err;
+               rxe_release_sockets(dev_net(ndev));
         }
  err:
         return err;
diff --git a/drivers/infiniband/sw/rxe/rxe_net.c 
b/drivers/infiniband/sw/rxe/rxe_net.c
index 50a2cb5405e2..f540a9b8a094 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.c
+++ b/drivers/infiniband/sw/rxe/rxe_net.c
@@ -642,18 +642,10 @@ static void rxe_sock_put(struct sock *sk,
         }
  }

-void rxe_net_del(struct ib_device *dev)
+/* release the per-net-namespace tunnel socket references held for @net */
+void rxe_release_sockets(struct net *net)
  {
-       struct rxe_dev *rxe = container_of(dev, struct rxe_dev, ib_dev);
-       struct net_device *ndev;
         struct sock *sk;
-       struct net *net;
-
-       ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
-       if (!ndev)
-               return;
-
-       net = dev_net(ndev);

         sk = rxe_ns_pernet_sk4(net);
         if (sk)
@@ -662,6 +654,18 @@ void rxe_net_del(struct ib_device *dev)
         sk = rxe_ns_pernet_sk6(net);
         if (sk)
                 rxe_sock_put(sk, rxe_ns_pernet_set_sk6, net);
+}
+
+void rxe_net_del(struct ib_device *dev)
+{
+       struct rxe_dev *rxe = container_of(dev, struct rxe_dev, ib_dev);
+       struct net_device *ndev;
+
+       ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
+       if (!ndev)
+               return;
+
+       rxe_release_sockets(dev_net(ndev));

         dev_put(ndev);
  }
diff --git a/drivers/infiniband/sw/rxe/rxe_net.h 
b/drivers/infiniband/sw/rxe/rxe_net.h
index 56249677d692..c8605de62bbd 100644
--- a/drivers/infiniband/sw/rxe/rxe_net.h
+++ b/drivers/infiniband/sw/rxe/rxe_net.h
@@ -16,6 +16,7 @@ void rxe_net_del(struct ib_device *dev);

  int rxe_register_notifier(void);
  int rxe_net_init(struct net_device *ndev);
+void rxe_release_sockets(struct net *net);
  void rxe_net_exit(void);

  #endif /* RXE_NET_H */
"

Another commit is related to this issue and is currently on the waiting 
list:

https://patchwork.kernel.org/project/linux-rdma/patch/20260519023541.8594-1-yanjun.zhu@linux.dev/

The two commits conflict with each other. Once one of them is merged, 
the other will need to be updated accordingly.

Let's keep an eye on both commits and make any necessary changes after 
the merge decision is made.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun


>   	}
>   err:
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.c b/drivers/infiniband/sw/rxe/rxe_net.c
> index 50a2cb5405e2..b98f66099dea 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.c
> +++ b/drivers/infiniband/sw/rxe/rxe_net.c
> @@ -642,18 +642,10 @@ static void rxe_sock_put(struct sock *sk,
>   	}
>   }
>   
> -void rxe_net_del(struct ib_device *dev)
> +/* release the per-net-namespace tunnel socket references held for @net */
> +static void rxe_release_sockets(struct net *net)
>   {
> -	struct rxe_dev *rxe = container_of(dev, struct rxe_dev, ib_dev);
> -	struct net_device *ndev;
>   	struct sock *sk;
> -	struct net *net;
> -
> -	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
> -	if (!ndev)
> -		return;
> -
> -	net = dev_net(ndev);
>   
>   	sk = rxe_ns_pernet_sk4(net);
>   	if (sk)
> @@ -662,6 +654,26 @@ void rxe_net_del(struct ib_device *dev)
>   	sk = rxe_ns_pernet_sk6(net);
>   	if (sk)
>   		rxe_sock_put(sk, rxe_ns_pernet_set_sk6, net);
> +}
> +
> +/* release the socket references taken by a successful rxe_net_init() when a
> + * later step of device creation fails and rxe_net_del() will not be called
> + */
> +void rxe_net_uninit(struct net_device *ndev)
> +{
> +	rxe_release_sockets(dev_net(ndev));
> +}
> +
> +void rxe_net_del(struct ib_device *dev)
> +{
> +	struct rxe_dev *rxe = container_of(dev, struct rxe_dev, ib_dev);
> +	struct net_device *ndev;
> +
> +	ndev = rxe_ib_device_get_netdev(&rxe->ib_dev);
> +	if (!ndev)
> +		return;
> +
> +	rxe_release_sockets(dev_net(ndev));
>   
>   	dev_put(ndev);
>   }
> diff --git a/drivers/infiniband/sw/rxe/rxe_net.h b/drivers/infiniband/sw/rxe/rxe_net.h
> index 56249677d692..d55aacce2905 100644
> --- a/drivers/infiniband/sw/rxe/rxe_net.h
> +++ b/drivers/infiniband/sw/rxe/rxe_net.h
> @@ -16,6 +16,7 @@ void rxe_net_del(struct ib_device *dev);
>   
>   int rxe_register_notifier(void);
>   int rxe_net_init(struct net_device *ndev);
> +void rxe_net_uninit(struct net_device *ndev);
>   void rxe_net_exit(void);
>   
>   #endif /* RXE_NET_H */


