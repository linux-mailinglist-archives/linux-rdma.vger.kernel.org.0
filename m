Return-Path: <linux-rdma+bounces-17953-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOhlAtAwsWm0rwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17953-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 10:07:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9B625FFE5
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 10:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B54343349E62
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 08:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3AF3B8D6B;
	Wed, 11 Mar 2026 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OObq+m82"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9013C1413;
	Wed, 11 Mar 2026 08:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219072; cv=none; b=rbynguh+fQt7RIz36IswJSLfQJ2okVFw8LRE0/TifGjgRuiG4/CgBB7OPEg+Dq9r/qJC/DTFVM03InQ8OhPXdKffNTSvaukf6bRA+3DqlMMDgfd6eSU8XB+rbj5GeTjtHygB3Bmi+x0Vy2bQZopSXLKOlGD2r5CBY/W6dGnRxN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219072; c=relaxed/simple;
	bh=ujQYia5FdRANnU+KepLceBZ5fhN0Wq/XsH31U6B/u4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXykzmsiseQ50mn7s8ste5J23+ValUJAGd9wAW72El3JXVy8wJpf9seh85EFzaG/oSqVB5oN6Hh5sb7Z4chk2sVodAtIEwSFZsdSZRqImX4QGuJyBL3Rjotk5n28StUadGj7j5GnvuwVQEMtQzrd634XV7AhsBdm9M2rAjlq88k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OObq+m82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7B0C2BC86;
	Wed, 11 Mar 2026 08:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773219072;
	bh=ujQYia5FdRANnU+KepLceBZ5fhN0Wq/XsH31U6B/u4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OObq+m82kHXZRJfS9isssazokdiI8Gq0xgBftf6XIg97RuEaG6/NNk+6CD0+hgFkK
	 M0ndZNLAap+4mBmYOpZ6Z6b1Z0/04dr8Eojz2OLGFLpYPI0hfxxUzB/2GErvuKPJDg
	 0up2EWpXIkEjrrshM51BpnW26cMnBkuatKRoSV9F884eEtJgjFXZ0tbq1CJcQ057v8
	 a6zMS9rdHk8lYUcyrYfXxJnb5V4zn+lV8wSvWRQI/VwSgEYEhAsOoPbSsCHGsdsE7l
	 dfBNbJYN8OCfzFPm3aAa8O/pd/4tunP9F5vJ96CVILK5XAIeVPicl4n3FoKzRa729u
	 wJAnVNJLLuSaw==
Date: Wed, 11 Mar 2026 10:51:08 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Cc: jgg@ziepe.ca, zyjzyj2000@gmail.com, shuah@kernel.org,
	linux-rdma@vger.kernel.org, linux-kselftest@vger.kernel.org,
	dsahern@kernel.org
Subject: Re: [PATCH v5 4/4] RDMA/rxe: Add testcase for net namespace rxe
Message-ID: <20260311085108.GV12611@unreal>
References: <20260310020519.101415-1-yanjun.zhu@linux.dev>
 <20260310020519.101415-5-yanjun.zhu@linux.dev>
 <20260310185308.GJ12611@unreal>
 <93c8c159-90f0-41f7-81d7-0f10fa7cf373@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93c8c159-90f0-41f7-81d7-0f10fa7cf373@linux.dev>
X-Rspamd-Queue-Id: 5B9B625FFE5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ziepe.ca,gmail.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17953-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 02:01:03PM -0700, Yanjun.Zhu wrote:
> 
> On 3/10/26 11:53 AM, Leon Romanovsky wrote:
> > On Tue, Mar 10, 2026 at 03:05:18AM +0100, Zhu Yanjun wrote:
> > > Add 4 testcases for rxe with net namespace.
> > > 
> > > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > ---
> > >   MAINTAINERS                                   |  1 +
> > >   tools/testing/selftests/Makefile              |  1 +
> > >   tools/testing/selftests/rdma/Makefile         |  7 ++
> > >   tools/testing/selftests/rdma/config           |  3 +
> > >   tools/testing/selftests/rdma/rxe_ipv6.sh      | 63 ++++++++++++++
> > >   .../selftests/rdma/rxe_rping_between_netns.sh | 85 +++++++++++++++++++
> > >   .../selftests/rdma/rxe_socket_with_netns.sh   | 76 +++++++++++++++++
> > >   .../rdma/rxe_test_NETDEV_UNREGISTER.sh        | 63 ++++++++++++++
> > >   8 files changed, 299 insertions(+)
> > >   create mode 100644 tools/testing/selftests/rdma/Makefile
> > >   create mode 100644 tools/testing/selftests/rdma/config
> > >   create mode 100755 tools/testing/selftests/rdma/rxe_ipv6.sh
> > >   create mode 100755 tools/testing/selftests/rdma/rxe_rping_between_netns.sh
> > >   create mode 100755 tools/testing/selftests/rdma/rxe_socket_with_netns.sh
> > >   create mode 100755 tools/testing/selftests/rdma/rxe_test_NETDEV_UNREGISTER.sh
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 77fdfcb55f06..bd33edf79150 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -24492,6 +24492,7 @@ L:	linux-rdma@vger.kernel.org
> > >   S:	Supported
> > >   F:	drivers/infiniband/sw/rxe/
> > >   F:	include/uapi/rdma/rdma_user_rxe.h
> > > +F:	tools/testing/selftests/rdma/
> > This is wrong place in MAINTAINERS file.
> > You need to add that line to "INFINIBAND SUBSYSTEM" and under RXE to add
> > tools/testing/selftests/rdma/rxe* entry.
> 
> Hi, Leon
> 
> "
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> 
> index 77fdfcb55f06..3c6bc0e05fc0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24492,6 +24492,7 @@ L:      linux-rdma@vger.kernel.org
>  S:     Supported
>  F:     drivers/infiniband/sw/rxe/
>  F:     include/uapi/rdma/rdma_user_rxe.h
> +F:     tools/testing/selftests/rdma/rxe*
> 
> "
> 
> Is it OK?

It is not sufficient. We also need to be CCed on changes to
tools/testing/selftests/rdma/Makefile. For that reason, you should place
tools/testing/selftests/rdma/ under the "INFINIBAND SUBSYSTEM" as well.

Thanks

> 
> Zhu Yanjun
> 
> > 
> > Thanks
> 

