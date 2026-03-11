Return-Path: <linux-rdma+bounces-17954-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL2bB9QtsWkVrwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17954-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 09:54:44 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CA925FCC5
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 09:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7EF4C3011781
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 08:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229543C3C14;
	Wed, 11 Mar 2026 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBEfJdHo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425763B8947;
	Wed, 11 Mar 2026 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219278; cv=none; b=WoEk4st/w2OAMaTe4A4uPoAz75kuyzud2b/izu6v7dW7WLDNpVW3DubsY3m5bp26LS+eV6gL/iD+/ExrWPftAbwHEisznbMkbHOQbShhsphO8OMfTYh7uEipJ072AGlxjOzy7u0+1L9NBLuBPoGMGmuldAzKKnEsHsAiP9IQCiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219278; c=relaxed/simple;
	bh=cDsCbaGsbMG3BZVDA+KavpaJ3ef+jAdCjRm6CO57PCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ylm88KbUSdsTwwjrqbXmciT02BhT6LV+KCq57y40Y1K2MeFbM6ONxRtqosmeZ282pFAqGRY348Qtx7etGOK4Ilh2Riu/WdBwg/Mw3XNU+iaDPepsJ+5WI6Yu1HvN1Rlhg3UcyIuI/M6Da3jRlZ0TVQVsWBO6RqgYa0ABtY0QX8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBEfJdHo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111D2C4CEF7;
	Wed, 11 Mar 2026 08:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773219277;
	bh=cDsCbaGsbMG3BZVDA+KavpaJ3ef+jAdCjRm6CO57PCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UBEfJdHo3IRuuuhTfptvJgfLiqtvU4+ssSrWTbQ5wXt/qiL0dIWdmgzG3yw03nzKO
	 KOOqjcxBw5XiYwBEMUG+l8AcQLknSwslsbI8RWe55A5AMr7qQR1MbtDk0JbipodWef
	 eOnemS4xwEKINhmm2CKSDeiaBieqcoQmggn604u/2kyU76EluNEU7o3YgsWO8YPomu
	 uX7M9Ljq5OAmZsxZG57v4kmXGez9fh5JqFUsdQHJi7oyB0nv4Q596rMxfEYtCe1O87
	 jy9My3aiRdO7xOInF4st7ZX6hZ+kJFn8rqjTUfv5QEmy6ZT06EXH8ofcTYVURmc6z3
	 ItbVWtHRpzW7Q==
Date: Wed, 11 Mar 2026 10:54:34 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Cc: jgg@ziepe.ca, zyjzyj2000@gmail.com, shuah@kernel.org,
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
	dsahern@kernel.org
Subject: Re: [PATCH v5 1/4] RDMA/nldev: Add dellink function pointer
Message-ID: <20260311085434.GW12611@unreal>
References: <20260310020519.101415-1-yanjun.zhu@linux.dev>
 <20260310020519.101415-2-yanjun.zhu@linux.dev>
 <20260310190140.GL12611@unreal>
 <5700c718-d10e-4b23-adfc-c14ee1930b18@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5700c718-d10e-4b23-adfc-c14ee1930b18@linux.dev>
X-Rspamd-Queue-Id: 88CA925FCC5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ziepe.ca,gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17954-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 06:58:00PM -0700, Yanjun.Zhu wrote:
> On 3/10/26 12:01 PM, Leon Romanovsky wrote:
> > It is an RXE‑specific description, but you are adding code to the general
> > nldev path. Please clarify that this behavior applies only to RXE, and
> > include examples showing when and how it is invoked. In particular, explain
> > how the socket is cleaned up if delink is not called.
> 
> Hi, Leon
> 
> You are correct that this logic should be driver-specific. I will add an
> explicit check for RDMA_DRIVER_RXE in the nldev path to ensure this behavior
> is strictly scoped to RXE and does not impact other drivers (like iWARP).

No, you don't need this driver_id check, because iWARP doesn't have link_ops->dellink,
but you should document the rationale and how it is triggered for RXE.

Thanks

> 
> This function path is primarily invoked when a user executes the
> administrative command: rdma link delete <dev>.
> 
> Regarding socket cleanup: RXE does not rely solely on this path for resource
> management. It monitors the underlying net_device state via a registered
> netdev_notifier. Even if delink is not explicitly called (e.g., if the
> parent interface is removed or the driver is forcefully unloaded), the
> rxe_net_event callback ensures that the transport sockets are forcibly
> closed and all allocated resources are released when the parent net_device
> is destroyed.
> 
> The code diff is as below:
> 
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -1824,6 +1824,12 @@ static int nldev_dellink(struct sk_buff *skb, struct
> nlmsghdr *nlh,
>                 return -EINVAL;
>         }
> 
> +       if (device->link_ops && device->ops.driver_id == RDMA_DRIVER_RXE) {
> +               err = device->link_ops->dellink(device);
> +               if (err)
> +                       return err;
> +       }
> +
>         ib_unregister_device_and_put(device);
>         return 0;
>  }
> 
> Zhu Yanjun
> 
> 

