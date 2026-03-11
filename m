Return-Path: <linux-rdma+bounces-17925-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLgwCj3MsGkKnQIAu9opvQ
	(envelope-from <linux-rdma+bounces-17925-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 02:58:21 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A2725A8D8
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 02:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 995B5315ADB1
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 01:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04E42C11DF;
	Wed, 11 Mar 2026 01:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vmrl8RUu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E7A1A3164
	for <linux-rdma@vger.kernel.org>; Wed, 11 Mar 2026 01:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194297; cv=none; b=fPywdPNUv1l68cHdP5dL/efVxJ/UAPPOucMf8bKJTD+m/FUXDXuGsz/u1XeeVb+MlXgkNmfcFUfEjTWF5lAT4Ua5dA05s//6DYnIvQ1W2OkSka6HjT/nxz/DKwogRD2SsoKUDth3T95hnjxGdm6yXHCv7o5shJW+f2xEvzdCSQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194297; c=relaxed/simple;
	bh=JMfa1B+audu66qnk+xX41IEO8i/8VaO1+MLN7haejrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P9wEOPo731zGGQJuPH1BpDww3THLrB7kiYwjEkh4EWAybWVjcQohihqk6xVQUKMqtKL8axnm7OMIKR6jKYUlVdunjBUH0o6u2UL4EgIjrStWqgTMm7nFAnEUY1S4IOfyBaMZKRq+qiE/1b+RFZtMSK9HeIkBYvSq0q5ofPAmbSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vmrl8RUu; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5700c718-d10e-4b23-adfc-c14ee1930b18@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773194284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bsndf7VI0hICz2YhwbWZPyxqs4wH7whyFv5rpvSke9g=;
	b=vmrl8RUu34aIPjgC3tJvs5WNod5qAzqdPx4y7iHnSS6PNIbnDVx5gCLzJ6+3r3fTD73eRd
	fRGv9rLzNX+zRk+wkdygKAFrLSVrK6wz8vXJTcij+oIILjZdhfDlp5Yphegdwq4ujEdFWr
	Xjrg11iinvrIkiKCgtMijCNrrKHgdHg=
Date: Tue, 10 Mar 2026 18:58:00 -0700
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260310190140.GL12611@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: B9A2725A8D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ziepe.ca,gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17925-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/10/26 12:01 PM, Leon Romanovsky wrote:
> It is an RXE‑specific description, but you are adding code to the general
> nldev path. Please clarify that this behavior applies only to RXE, and
> include examples showing when and how it is invoked. In particular, explain
> how the socket is cleaned up if delink is not called.

Hi, Leon

You are correct that this logic should be driver-specific. I will add an 
explicit check for RDMA_DRIVER_RXE in the nldev path to ensure this 
behavior is strictly scoped to RXE and does not impact other drivers 
(like iWARP).

This function path is primarily invoked when a user executes the 
administrative command: rdma link delete <dev>.

Regarding socket cleanup: RXE does not rely solely on this path for 
resource management. It monitors the underlying net_device state via a 
registered netdev_notifier. Even if delink is not explicitly called 
(e.g., if the parent interface is removed or the driver is forcefully 
unloaded), the rxe_net_event callback ensures that the transport sockets 
are forcibly closed and all allocated resources are released when the 
parent net_device is destroyed.

The code diff is as below:

--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -1824,6 +1824,12 @@ static int nldev_dellink(struct sk_buff *skb, 
struct nlmsghdr *nlh,
                 return -EINVAL;
         }

+       if (device->link_ops && device->ops.driver_id == RDMA_DRIVER_RXE) {
+               err = device->link_ops->dellink(device);
+               if (err)
+                       return err;
+       }
+
         ib_unregister_device_and_put(device);
         return 0;
  }

Zhu Yanjun



