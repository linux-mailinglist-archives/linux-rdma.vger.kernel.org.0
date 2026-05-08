Return-Path: <linux-rdma+bounces-20264-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OF1BBldL/mllowAAu9opvQ
	(envelope-from <linux-rdma+bounces-20264-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 22:45:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6814FB99B
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 22:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 735623037420
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 20:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189F841B377;
	Fri,  8 May 2026 20:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uFmBEaYT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C981A3101A7;
	Fri,  8 May 2026 20:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778273057; cv=none; b=IGemLGJ9coEUg9Cktq4KEzj21Fhpqi+yTs01D93HJb0Ov1GidqpAw7xtUXpzoD4dsWvgYXhIEm8EN/C+2wtyRmbv6lxKStKu0d7ckXelpF7Jk4MxAKvmO+39c/5ZMlCuIZtscqxKNq8r5hvi9V51lUy2dNoMNifJ5JSpFANnB0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778273057; c=relaxed/simple;
	bh=Hwl5TVdR6YBfYZdvpr32S5jgEwKk59J2yeMAGvE6Jvs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DOqP5tz4qhpkb7irmZlVcoxYShhX8ySfQ5+jiyEdZElt3EoWTvTLDxU4J9MPqfXEvwptiWsuUA2XxlGaCg/mRr0pTY8NE38/076OGF9oLhQrWwjjxexTS/5tycdK4H/r8aqodOgSVBMdjLtEfW75zZdCoGQBYjAMfQ8nbiwwRsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uFmBEaYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB3A0C2BCB0;
	Fri,  8 May 2026 20:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778273057;
	bh=Hwl5TVdR6YBfYZdvpr32S5jgEwKk59J2yeMAGvE6Jvs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uFmBEaYTpUJgR93Cy6mf+t2YLhXlM5nsKoml7W6bTeDUs/ld+5uCvkrOWtC+JjwXT
	 vRPruZZ3MftzpA0brOqITPUoMeXv/D1D2FX51rSn7pb6Y1vAd/UfhuIDPN4B6m7q72
	 U//gZLDcA3cH+21/WGSSmVvVKNWJkhTTcsIlXZ8ZrCo+g4icaRQschaXkwxapN+yih
	 ZfZRPNJReJDSAdIMByCRKunrJqT8dE4YHvQejSU8E1J2uajufTA7wloyJ9CE09WK8m
	 Ag/Hi/M9AyTZJpX8jBSA/w5LfOc4tWstx9AhOc7aTs3EmTp33iBsJv7Cg7I7SGN+bL
	 sS6/57fhNbn4g==
Date: Fri, 8 May 2026 13:44:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Bobby Eshleman <bobbyeshleman@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, Yanteng Si
 <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, Michael Chan
 <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>,
 Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy
 <hramamurthy@google.com>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
 <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
 kernel-team@meta.com, Daniel Borkmann <daniel@iogearbox.net>, Nikolay
 Aleksandrov <razor@blackwall.org>, Shuah Khan <shuah@kernel.org>,
 dw@davidwei.uk, mohsin.bashr@gmail.com, willemb@google.com,
 jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, Stanislav Fomichev
 <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, Bobby Eshleman
 <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 3/8] net: devmem: support TX over
 NETMEM_TX_NO_DMA devices
Message-ID: <20260508134414.206391c0@kernel.org>
In-Reply-To: <af3593dYeiEeMzC2@devvm7509.cco0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
	<20260507-tcp-dm-netkit-v3-3-52821445867c@meta.com>
	<af3593dYeiEeMzC2@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 6F6814FB99B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20264-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[40];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,broadcom.com,nvidia.com,fb.com,meta.com,iogearbox.net,blackwall.org,davidwei.uk,zte.com.cn,vger.kernel.org,fomichev.me];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, 8 May 2026 08:01:17 -0700 Stanislav Fomichev wrote:
> Since this is a good case, maybe fold it into skb_frags_readable check above?
> 
> 	if (likely(skb_frags_readable() || netmem_tx == NETMEM_TX_NO_DMA))

FWIW I had the same feeling on v2, so probably worth fixing.

