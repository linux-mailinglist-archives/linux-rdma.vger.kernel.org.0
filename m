Return-Path: <linux-rdma+bounces-22137-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i0/gFVcEK2pN1QMAu9opvQ
	(envelope-from <linux-rdma+bounces-22137-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 20:54:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A33674987
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 20:54:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LZhqOn5I;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22137-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22137-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B21EE3101F5C
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jun 2026 18:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123244DBD69;
	Thu, 11 Jun 2026 18:54:03 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753B442B732;
	Thu, 11 Jun 2026 18:53:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781204042; cv=none; b=Wu8VbGq9LUhTheeofMlY1dikGHf8wqphSsamBLMS9acd+CYk43mSerI8TU7IpNwX/pvbgyY1i1RbiTYEoHtj4T/fSpo3HnZccUrQ0X5DXCn6irtEvyHNZbSDAAeOyilSnLUntY9uCmtWTQSaM2ZpKfsyM8SOuJq9NVp3QTdtUso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781204042; c=relaxed/simple;
	bh=lyoYDo723ITo2kQarUaC98MkKgPUszT7d+2KOjiMLk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qF9scqKBGEVKdCaj1DU+otjZoe/dRm25p4ozLadu8w7lyHkYY50p6CvE31Om6aJMH+8RPT29LwmbhWNWSaxFRTIqmyrF5yMGKnoXKFVp4+bP09HEb2+fANE54/0TGePkiWjpIKd9Qm8gCguwR+JGG0Ct5mTa+nMlM9oFJBzvt/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZhqOn5I; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 646691F000E9;
	Thu, 11 Jun 2026 18:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781204038;
	bh=hjj5mBR6SBQTds2P7Qn6eN4rJ9W11rwc7SbsUviVMX4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LZhqOn5Ilvsw6JsbgErLBhERiOd6NBo2fFvjxs/lQnIfx4ncu625nN6xMP+xMZc+K
	 RKHlgAKXV/ErOS7HxpVDLqKIIIyrqe8Mjx6Ogv3oPcRgjNwTiuN1mIYaEB3H3I5sa9
	 IUr5fHpJsBfF9CHjZ0RlJriNRhcVQII1mPn6c/BiYgPnp0Rzo4L7gnkmcfxARQoj/2
	 eUqzxPR1hVbSL6nvvkplFE8cGcdCdBBF7chO6wGly87yCnRHboQFtqAlXLyPty/MoC
	 RquT3NYRc4i2MYXfmJJlAiTEE6m5g1eboiVeeYYfycSdjELZO2dIlktQqWAKUCpkPi
	 KtrCxM1gU9+tA==
Message-ID: <943b4932-17f4-4a52-af92-b9485a0e8c7a@kernel.org>
Date: Thu, 11 Jun 2026 12:53:56 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next 7/7] devlink: add scope filter to resource
 show
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
 <20260609053953.487152-8-tariqt@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260609053953.487152-8-tariqt@nvidia.com>
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
	TAGGED_FROM(0.00)[bounces-22137-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1A33674987

On 6/8/26 11:39 PM, Tariq Toukan wrote:
> @@ -9010,13 +9029,29 @@ static int cmd_resource_show(struct dl *dl)
>  	uint16_t flags = NLM_F_REQUEST | NLM_F_ACK;
>  	struct nlmsghdr *nlh;
>  	struct resource_ctx resource_ctx = {};
> +	struct dl_opts *opts = &dl->opts;
>  	int err;
>  
> -	err = dl_argv_parse_with_selector(dl, &flags, DEVLINK_CMD_RESOURCE_DUMP,
> -					  DL_OPT_HANDLE | DL_OPT_HANDLEP,
> -					  0, 0, 0);
> -	if (err)
> -		return err;
> +	if (dl_argv_match(dl, "scope")) {
> +		const char *scopestr;
> +
> +		dl_arg_inc(dl);
> +		err = dl_argv_str(dl, &scopestr);
> +		if (err)
> +			return err;
> +		err = resource_scope_get(scopestr, &opts->resource_scope_mask);
> +		if (err)
> +			return err;
> +		opts->present |= DL_OPT_RESOURCE_SCOPE;

Comment from Claude that seems legit:

Issue found: In cmd_resource_show, the scope path sets opts->present |=
DL_OPT_RESOURCE_SCOPE without first clearing opts->present. In batch
mode, dl->opts is shared across commands, and the non-scope path
correctly resets opts->present via dl_argv_parse(). But the scope path
bypasses dl_argv_parse(), so stale bits (e.g. DL_OPT_HANDLE from a
previous dev show) remain. When dl_opts_put() runs, it writes the stale
DEVLINK_ATTR_BUS_NAME/DEV_NAME attributes into the dump request,
silently filtering to a single device instead of all devices. Fix: use =
instead of |=

Are you ok with the suggested resolution?


