Return-Path: <linux-rdma+bounces-18075-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qF3hJ756sml/MwAAu9opvQ
	(envelope-from <linux-rdma+bounces-18075-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 09:35:10 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E07226EFFA
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 09:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BDCE30675B2
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 08:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F483451BB;
	Thu, 12 Mar 2026 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="UdvZpJSv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1916934A767
	for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773304501; cv=none; b=ulXcplcI4rwhEoHepeBDdvgk/YuELU9r2yk6f2oXcuN81OSbPgI4VNnQxQP+s/p5DzIlZwCPb8kQyouiP41b+UDoyBP+qkI9o/XgThrf8gQThpcxCwj7H14es9k7OtbCpzt2/Lv86/96MlyhlpJz/4E7OEeRwzZHOGp0YEoMUek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773304501; c=relaxed/simple;
	bh=HEFbmcFEHfAGcaqdN8AWPZHaVSbwHCyRRxbL06fN1Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpZTBS+2zuc/+INBLI4F+FFXQ+FHHcBB0g+wsKH8SxYkCjTuiqtZcydiDQnIw939kVLdW75J7zbTM0UCkZ8tBCr9yn0aEWB8dNwsApejHRmzicBzUWMLJ2oEyQFECS/tWJm+nKjL6g7LjnGg6nTUOT8i6K/1yzmRrI8YsmDRAVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=UdvZpJSv; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439c4a93841so521023f8f.1
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 01:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1773304495; x=1773909295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G6aLENJtgw3KKH+EBlODshn2Ly+qSlwDf7sw9+i4eVY=;
        b=UdvZpJSv/Gz1k9WN42TpPqqvHZL+RQwr245QXejc0Vs0ixuWIfzEZr/IfR7DUW8lXw
         NsrV9oqjOasQaoz9bze1mZPvfPZSs20EFoDDUUDsew8j5K0zQm7LS1rreFG1N6G3+tLO
         RMZQnsvuoTkIrU19l6j8v16cYS1o/2qr0kKtw3q99/bTpMzYMCfSJQS0tCIxb66YOhC8
         T3WtwAvFjEZbr6QNs+p574v+OkM1ZQUC19HjymuyUeCOxzt2bgudC0MPygvJXWL8XQkv
         JOSP63AIksJiYbW8TMh4yetGVre3NXn02g+lxDfD32r7KywrCPeXECI87/hWUOISc04g
         I3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773304495; x=1773909295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G6aLENJtgw3KKH+EBlODshn2Ly+qSlwDf7sw9+i4eVY=;
        b=h4QL/3SHrsli6CJfV/aaFSItubMYlrSqszyF4/0mZavGF0YvbHoqIe5chBuz+lEsI3
         fASTTqAuBfyX5qdPQYyi60MafJCbvi/SSSCVxyiFi+bNrkQtsmtG95dNLFxdBGTzPEIw
         i8Kel6BDtrPmXJwqEAau21TWbtEB17+7frqFF/o/VzIJw68cd2CFsr7O1HYxqURpYmpH
         gv2h+ICZn/GM+fwb8TvT42tGFNOoWFp+/QvVYJy6l7UV+OCSfShAvXS46dWEkJxYur52
         e+LsazrRrEKtR2JoVzwmifeMxVGGphaRB3weSk+aNduLAzBt50B4/Lo3A1/LrDCOObfh
         S2yg==
X-Forwarded-Encrypted: i=1; AJvYcCXtrF45L+evMoMdZBDM8JhHYMUzdNp06eVKkkmMc0kDJNVOdwArPaSTJzyQ7jFnwmsRqgm9YV3B9NqR@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt+mbSRgPoyfgvx3CP1Cwdr1O7NmaRCY6Bm+4gEGW7AB3ShLUt
	stF7CPobrNO7mHYbCFHHz33YDEvCdZTNESeO722iARWv3aUxWO8ppa3H/YqEXb+asCQ=
X-Gm-Gg: ATEYQzwl48F1ek6KFUu41tMeYEEN0RR+qpJEobHjKLJQgRm7jl/sjQiT/JSyMnz0gGK
	VOvRLOONNxdGl6VPnne05IGaMBVunWFLnhs4Dc2cqkbYQ87DSauP8YBM+Q2dYZJZoS7/FGPzFRb
	iDUT/3+mMMw4NiyaVlxLDUD59/4t0xi8M2DPNltn/+KGy6BJ/ujSBREFwD7v/DP22s0dMQvK231
	Oig2f48F30d6mlveU41mNRzJjrBaivG9zhFpqfA4BxrA1m9rjbys2weGtIqW9HEgU9HwV58UwWG
	AdmhArYzWq7CjTA4TcnnKwBY2NienHBKAFh9KzuqFktEo6FxJJ+oNsfhuJ9lXPEbeAeQjscnYcb
	NiQc0qR2MlE1hI09Qd4pxHeDZuxrWbthl9oF8frJv9uQDR8Ri8NgCIB9OcwRcKQgQHV4eJauZRp
	ADieMsnPYKkMt9yOBh7mDRAtJiXxNnDNK22FLQY39WdA==
X-Received: by 2002:a5d:584a:0:b0:439:ad2d:99f1 with SMTP id ffacd0b85a97d-439f843cd0dmr10192185f8f.54.1773304494998;
        Thu, 12 Mar 2026 01:34:54 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1affe9sm6406633f8f.15.2026.03.12.01.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:34:54 -0700 (PDT)
Date: Thu, 12 Mar 2026 09:34:52 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Or Har-Toov <ohartoov@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Mark Bloch <mbloch@nvidia.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Gal Pressman <gal@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Shay Drory <shayd@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next V3 00/10] devlink: add per-port resource support
Message-ID: <go5wr5qa7wxe7i4kkcbmecomshpkesr26alq4qmlbpjr72hxgt@mpwq6eufylpn>
References: <jssifysprwuafkinc3dguspngxmplrngqxvotp76vhvu4e5lp6@e7mdrjqc5rme>
 <20260304101522.09da1f58@kernel.org>
 <np44uzfn6jea56uht4yq4te5clapgj7pk6ygyvkl22wxumwnvt@nrpvzjqzxenq>
 <20260305063729.7e40775d@kernel.org>
 <ni23r4jiwgc6zjjsubtl4ujjgxzwpxrylumofdwxgozfnieynm@zirlbneaz6p2>
 <20260306120301.0ebe1ab2@kernel.org>
 <74dcd7c5-8a2b-49a7-a23c-174d17a61955@nvidia.com>
 <20260309133341.7e08b35d@kernel.org>
 <5de5103e-e2e4-4b72-9c3c-22847728fbb8@nvidia.com>
 <20260311145126.7dcca532@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311145126.7dcca532@kernel.org>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18075-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,lwn.net,kernel.org,vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E07226EFFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Wed, Mar 11, 2026 at 10:51:26PM +0100, kuba@kernel.org wrote:
>On Wed, 11 Mar 2026 20:24:08 +0200 Or Har-Toov wrote:
>> For the dump-it command:
>> devlink resource show
>> pci/0000:03:00.0:
>> <resource>
>> pci/0000:03:00.0/196608:
>> <port-resource>
>> pci/0000:03:00.0/196609:
>> <port-resource>
>> pci/0000:03:00.1:
>> <resource>
>> pci/0000:03:00.1/262144:
>> <port-resource>
>> 
>> devlink resource show scope port
>> pci/0000:03:00.0/196608:
>> <port-resource>
>> pci/0000:03:00.0/196609:
>> <port-resource>
>> pci/0000:03:00.1/262144:
>> <port-resource>
>> 
>> devlink resource show scope dev
>> pci/0000:03:00.0:
>> <resource>
>> pci/0000:03:00.1:
>> <resource>
>
>LGTM

I don't see the benefit of exposing the scope to the user to be honest.
I mean, dump would show all, dump with "dev" handle would be used as a
selector to dump only things related to "dev". What is the use case of
this "scope" granularity?


>
>> For the do-it command:
>> devlink resource show pci/0000:03:00.0
>> pci/0000:03:00.0:
>> <resource>
>> pci/0000:03:00.0/196608:
>> <port-resource>
>> pci/0000:03:00.0/196609:
>> <port-resource>
>> 
>> devlink resource show pci/0000:03:00.0 scope port
>> pci/0000:03:00.0/196608:
>> <port-resource>
>> pci/0000:03:00.0/196609:
>> <port-resource>
>> 
>> devlink resource show pci/0000:03:00.0  scope dev
>> pci/0000:03:00.0:
>> <resource>
>
>Do we have to touch doit? Maybe we should let doit be what it is now
>and consider it legacy going forward? doit which is in fact a filtered
>dump is a bit of a mistake in the first place, from Netlink's
>perspective.

I don't think we should. If user wants doit, he is going to specify the
object (dev/port). If user is interested only in things related to
single device, he should do dump with selector (dev).

Let's make this simple.

