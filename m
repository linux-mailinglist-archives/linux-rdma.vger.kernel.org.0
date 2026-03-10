Return-Path: <linux-rdma+bounces-17882-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oLQJLh5AsGkehgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17882-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 17:00:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B012542FD
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 17:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D94A33313BF
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 15:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265233B27C7;
	Tue, 10 Mar 2026 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="teuRhIkd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB5D301493;
	Tue, 10 Mar 2026 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773157684; cv=none; b=JgHjhfOFgNHM/VhEyh9ugUtZtbtZ9Ewz5e4MNis01kHJ6/if8Z/SvsqJNzhd+zA2M8h7RMNceAfSXfFIibrVip0G996uomg6KJ+Fwv+Ya0AUhvBYEZzzA+o2JrAB5Eo9AjUhpycIVZZGD8V/ZVFbsybJuzlP08vXX85AfAcagzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773157684; c=relaxed/simple;
	bh=Q+glRiJAArKrT+s3VDs/Io+eURZVMnfVXEi7/JrppYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RHoTqlXyXMNaU5Ne3mdg3e43n6HLXVk5azML0SdB8dXt/whSsDGezRWjvJsdePvJRkGGBEV/dNeGBJqleNtQeKx3eMiKL7aYtleeDey6zVOCG9o2ikWw+iB6+eVBRsiU4J5wM9zulpTLfSwH9pLRISX9lxza+j+2Wz8B6KqI3Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=teuRhIkd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D53C19423;
	Tue, 10 Mar 2026 15:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773157683;
	bh=Q+glRiJAArKrT+s3VDs/Io+eURZVMnfVXEi7/JrppYc=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=teuRhIkdJWjnYhdMIgMKuyyteyn9xzWYDv4F3JG9/npBhXR4mHQSLZAdZXlrv++yY
	 FIDaWzjf46sL/Ib0jiTDFfdDFDF2OF4FDSAdxHqJl4hgp+BDYx9KH4Gs7TzkcpO1b8
	 CKus/nd6f/IpLWlzbOttu188uzpDZu/LRUh/OG03hfqX4oSazXlLkMwshzdjQ7Fq3B
	 bqqTvGpaLsmTHIzTf/5fM6+/ubPSi7xoUrcC4O7Be8oU6b1rw+akKqqJT16dq7nH6X
	 MKTbjO11Pqy0wkn25VQ5U9Jecp4PCkGgZiuclMtYbGJ26CcAlnpVzNBrBS+Jow+gAW
	 Usjmk6KQbL74A==
Message-ID: <6938b5e4-8b2d-4d4f-8e56-93f50b29348b@kernel.org>
Date: Tue, 10 Mar 2026 09:48:03 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] RDMA/rxe: Add net namespace support for IPv4/IPv6
 sockets
Content-Language: en-US
To: Zhu Yanjun <yanjun.zhu@linux.dev>, jgg@ziepe.ca, leon@kernel.org,
 zyjzyj2000@gmail.com, shuah@kernel.org, linux-rdma@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260310020519.101415-1-yanjun.zhu@linux.dev>
 <20260310020519.101415-3-yanjun.zhu@linux.dev>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260310020519.101415-3-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 34B012542FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17882-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[linux.dev,ziepe.ca,kernel.org,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/9/26 8:05 PM, Zhu Yanjun wrote:
> Add a net namespace implementation file to rxe to manage the
> lifecycle of IPv4 and IPv6 sockets per network namespace.
> 
> This implementation handles the creation and destruction of the
> sockets both for init_net and for dynamically created network
> namespaces. The sockets are initialized when a namespace becomes
> active and are properly released when the namespace is removed.
> 
> This change provides the infrastructure needed for rxe to operate
> correctly in environments using multiple network namespaces.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/Makefile |   3 +-
>  drivers/infiniband/sw/rxe/rxe_ns.c | 124 +++++++++++++++++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_ns.h |  26 ++++++
>  3 files changed, 152 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/infiniband/sw/rxe/rxe_ns.c
>  create mode 100644 drivers/infiniband/sw/rxe/rxe_ns.h
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



