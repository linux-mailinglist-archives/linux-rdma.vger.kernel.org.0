Return-Path: <linux-rdma+bounces-22545-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5CroJmtWQWownwkAu9opvQ
	(envelope-from <linux-rdma+bounces-22545-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 19:14:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA95A6D4828
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 19:14:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ImqHigvR;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22545-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22545-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 696D6300B3F7
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Jun 2026 17:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE242E7F3A;
	Sun, 28 Jun 2026 17:14:09 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68FC2DF6E9;
	Sun, 28 Jun 2026 17:14:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782666849; cv=none; b=SY7CxtQkSCCXfxSP6bQmebQkHCwsQETqS8WT7QmfwW/s09JvIAPW872nxgbJLUDsbUZoGeRll2IMzufVFxmsEPgx4T0uTn5So6K/EOvc/AaOQ8WNGGk6r7aQrT2VVQ1ZeHlAPqVUz4JUZ5+xN8/Rv3PZC4UFADhTaEgtoNouI9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782666849; c=relaxed/simple;
	bh=i74Z0u0srxyj5f1t9MAmQa6W7wE/osflRIc+NxsauE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VyttR/TWT3t7i8wrggswCVS4t5lr7iuatiKLuMcm5pv4DjLCdd0CWU9GdGSGalMg2IKweC36fF1XyQD4SlUANpQrLa9zBh1yzL8VqW16g9oPiqc2wqS3cK8GtF8vmAi8M71/+6I+ZH/64P8OGinN+j1d5rDamnh3Q4PU1XlUAFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImqHigvR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103051F000E9;
	Sun, 28 Jun 2026 17:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782666848;
	bh=9lGiDrKhDinjnXy4mzb89Q99lUH+tY3SY0KOK0lC7DA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ImqHigvRPAII/mrx//hPblk4b/IseAqJgr4a3u8LnfyGw7NUXXA1WYeGC5/Rridfj
	 /vdYkuFq6o02cWxAzQ9XX5466zUktflPaaMb8DqKqrQT+OdruiwVcRIr1EzutbT8iU
	 YQliki7ZQ9QdZlJyn6bPZaPWnuMKeZhXYm5l3Yyy3kBfeA3lQofjfNcPM5d/JfPE8M
	 oP7Ks3HT2ZMHOmtAvoJnfcRMJC2kqchhtiKXK7d/vqEnCfUx5kYG0+AJ70D7D00j3a
	 Ex0FIfhdKvWIgiKaFNSf037T1vZ9goT0W4QBT34Qbo8a8Lgpiab6/MrBwtQWu8SBaz
	 QZLxAsSdAD/2A==
Message-ID: <225e2dfb-d4af-4b86-a233-9c0ee9c1da2b@kernel.org>
Date: Sun, 28 Jun 2026 11:14:04 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 0/7] devlink: add per-port resource support
Content-Language: en-US
To: Tariq Toukan <tariqt@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: Donald Hunter <donald.hunter@gmail.com>, Simon Horman <horms@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, "Matthieu Baerts (NGI0)"
 <matttbe@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Or Har-Toov <ohartoov@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Daniel Zahka <daniel.zahka@gmail.com>,
 Shahar Shitrit <shshitrit@nvidia.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Cosmin Ratiu <cratiu@nvidia.com>,
 Parav Pandit <parav@nvidia.com>, Kees Cook <kees@kernel.org>,
 Adithya Jayachandran <ajayachandra@nvidia.com>,
 Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Petr Machata <petrm@nvidia.com>
References: <20260609053953.487152-1-tariqt@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260609053953.487152-1-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22545-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:stephen@networkplumber.org,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:horms@kernel.org,m:jiri@resnulli.us,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:shuah@kernel.org,m:matttbe@kernel.org,m:chuck.lever@oracle.com,m:ohartoov@nvidia.com,m:cjubran@nvidia.com,m:moshe@nvidia.com,m:shayd@nvidia.com,m:dtatulea@nvidia.com,m:daniel.zahka@gmail.com,m:shshitrit@nvidia.com,m:jacob.e.keller@intel.com,m:cratiu@nvidia.com,m:parav@nvidia.com,m:kees@kernel.org,m:ajayachandra@nvidia.com,m:danielj@nvidia.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:gal@nvidia.com,m:idosch@nvidia.com,m:jiri@nvidia.com,m:petrm@nvidia.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,m:danielzahka@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[40];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,linux-rdma@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA95A6D4828

On 6/8/26 11:39 PM, Tariq Toukan wrote:
> Hi,
> 
> Currently, devlink resource show only supports querying a specific
> device and displays device-level resources. However, some resources
> are per-port, such as the maximum number of SFs that can be created
> on a specific PF port.
> 
> This series extends devlink resource show with full support for
> port-level resources, including a dump mode, per-port querying syntax,
> and scope filtering. In preparation for these features, the first two
> patches refactor how dpipe tables are handled to unblock dump support
> and ensure errors in secondary queries are non-fatal.
> 
> The series is organized as follows:
> 
> Patch 1 splits the dpipe tables display into a separate function.
> 
> Patch 2 moves the dpipe tables query into the per-device resource show
> callback, ensuring it behaves correctly during a multi-device dump.
> 
> Patch 3 fixes a pre-existing memory leak in resource_ctx_fini.
> 
> Patch 4 adds dump support to resource show (no device required).
> 
> Patch 5 shows port-level resources returned in a dump reply.
> 
> Patch 6 adds DEV/PORT_INDEX syntax to resource show.
> 
> Patch 7 adds scope filter to resource show.
> 
> With this series, users can query resources at all levels:
> 
> $ devlink resource show
> pci/0000:03:00.0:
>   name local_max_SFs size 508 unit entry
>   name external_max_SFs size 508 unit entry
> pci/0000:03:00.0/196608:
>   name max_SFs size 20 unit entry
> 
> $ devlink resource show scope dev
> pci/0000:03:00.0:
>   name local_max_SFs size 508 unit entry
>   name external_max_SFs size 508 unit entry
> 
> $ devlink resource show scope port
> pci/0000:03:00.0/196608:
>   name max_SFs size 20 unit entry
> 
> $ devlink resource show pci/0000:03:00.0/196608
> pci/0000:03:00.0/196608:
>   name max_SFs size 20 unit entry
> 
> This series is the userspace counterpart to the kernel series:
> https://lore.kernel.org/all/20260407194107.148063-1-tariqt@nvidia.com/
> 
> Ido Schimmel (2):
>   devlink: Split dpipe tables output to a separate function
>   devlink: Move dpipe tables query to resources show callback
> 
> Or Har-Toov (5):
>   devlink: fix memory leak in resource_ctx_fini
>   devlink: add dump support for resource show
>   devlink: show port resources in resource dump
>   devlink: add per-port resource show support
>   devlink: add scope filter to resource show
> 
>  bash-completion/devlink     |   8 ++
>  devlink/devlink.c           | 202 +++++++++++++++++++++++++++---------
>  man/man8/devlink-resource.8 |  34 +++++-
>  3 files changed, 192 insertions(+), 52 deletions(-)
> 
> 
> base-commit: 7340b539841dc739bc0b813e8e86825bc1eb5a4c

applied to iproute2-next with the fixup recommended by Claude and
confirmed by Or

