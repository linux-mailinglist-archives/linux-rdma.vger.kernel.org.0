Return-Path: <linux-rdma+bounces-21985-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WQFfLOImJ2q2sgIAu9opvQ
	(envelope-from <linux-rdma+bounces-21985-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 22:32:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8FE65A756
	for <lists+linux-rdma@lfdr.de>; Mon, 08 Jun 2026 22:32:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=H+RR+km9;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21985-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21985-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7C29C302AF0E
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jun 2026 20:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B197C3988E1;
	Mon,  8 Jun 2026 20:30:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE1E38E8D4;
	Mon,  8 Jun 2026 20:30:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950632; cv=none; b=qAUf6ntDygVV1PP6aIYD8VEOqwm6jbq7dADTPIBuC+UStkjuxsdYvy1cK+0lwcEehjNaOYOQlt/PMOUagPmr9SZQXwVdgJFM3NCqPSCDkrSnCzFoj+Qu3MhdP/muPoCfEN4cP2WNzrfw400x1b3AkX4SEXT3H/5/2h54MXssOCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950632; c=relaxed/simple;
	bh=ro13X8bYyZN635AsD1TAc0Se21/nyspGsLYa8UAWjSw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3ER+b8z8I9camCrZ2uD6imXHw06An2RhxJV0O4Y6bmBQ0lxh600XEg3P2VtL8MOIXwedK+0VyhqDhnQvTYbfDLD2OOwk4bbpDUwpqDy+Yv4bL8pQDeFRovrYO3/e1i7ocDYhujEBcv8FUFEHIZEeM2hf+ls/KMCjlcqORiiq48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+RR+km9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9B41F00893;
	Mon,  8 Jun 2026 20:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780950631;
	bh=BDDI0zZ85tZ3dra1dzCyCbAmBdm/ZjszTpTSBf91ICk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=H+RR+km9F27/4FtD/nDVbbsskwOtzC3R+aaRnoK93RfDjLtT0P1d0+Vvj/oIZ7Ytx
	 4Yq94jO7XGV2gcXKD4cl/8tcnEF6f6HuMrgHtevN41QbQ7T63wcm38+7Py0yNWpktj
	 pwX/PwCeEYUO0L7oUu97Yj73OKH7CpIbY7bd2bZrICfzfNrv4sy5GkCNiAZFhvpOZ9
	 Ntu5+0aRb6a5VoJeI0XntIfSNP4diIMlz8UD36rhBprJUcmtc+sRbx2QtCVVGBSqIF
	 fDE+FDl7eU3HTyBklFfw4cORoaHSVqt0QlCHpb8kMh6teJ8vIJUaUDGNgNtQYb2mvZ
	 eYFxS98Gok2BA==
Date: Mon, 8 Jun 2026 13:30:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Simon Horman <horms@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Saeed Mahameed
 <saeedm@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, "Matthieu Baerts
 (NGI0)" <matttbe@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Carolina Jubran <cjubran@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>,
 Moshe Shemesh <moshe@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>,
 Daniel Zahka <daniel.zahka@gmail.com>, Shahar Shitrit
 <shshitrit@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Jacob Keller
 <jacob.e.keller@intel.com>, Parav Pandit <parav@nvidia.com>, Adithya
 Jayachandran <ajayachandra@nvidia.com>, "Shay Drori" <shayd@nvidia.com>,
 Kees Cook <kees@kernel.org>, Daniel Jurgens <danielj@nvidia.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net-next V5 00/12] devlink: add per-port resource
 support
Message-ID: <20260608133029.3e1ef109@kernel.org>
In-Reply-To: <20260407194107.148063-1-tariqt@nvidia.com>
References: <20260407194107.148063-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21985-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:tariqt@nvidia.com,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:horms@kernel.org,m:donald.hunter@gmail.com,m:jiri@resnulli.us,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:saeedm@nvidia.com,m:leon@kernel.org,m:mbloch@nvidia.com,m:shuah@kernel.org,m:matttbe@kernel.org,m:chuck.lever@oracle.com,m:cjubran@nvidia.com,m:ohartoov@nvidia.com,m:moshe@nvidia.com,m:dtatulea@nvidia.com,m:daniel.zahka@gmail.com,m:shshitrit@nvidia.com,m:cratiu@nvidia.com,m:jacob.e.keller@intel.com,m:parav@nvidia.com,m:ajayachandra@nvidia.com,m:shayd@nvidia.com,m:kees@kernel.org,m:danielj@nvidia.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:gal@nvidia.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,m:danielzahka@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_CC(0.00)[google.com,redhat.com,lunn.ch,davemloft.net,kernel.org,gmail.com,resnulli.us,lwn.net,linuxfoundation.org,nvidia.com,oracle.com,intel.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1D8FE65A756

On Tue, 7 Apr 2026 22:40:55 +0300 Tariq Toukan wrote:
> Userspace patches for iproute2:
> https://github.com/ohartoov/iproute2/tree/port_resources

Hi! As far as I can tell these iproute2 patches have not even been
posted? Please try to get them upstream ASAP, we have to manually 
carry them in the CI right now.

