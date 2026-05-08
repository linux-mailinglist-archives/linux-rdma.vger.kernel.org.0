Return-Path: <linux-rdma+bounces-20275-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIqxA2Jj/mmoqAAAu9opvQ
	(envelope-from <linux-rdma+bounces-20275-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 09 May 2026 00:27:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A54804FC59C
	for <lists+linux-rdma@lfdr.de>; Sat, 09 May 2026 00:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10E2A303E4F0
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 22:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02523921F6;
	Fri,  8 May 2026 22:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arMMLK1g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B1B32E743;
	Fri,  8 May 2026 22:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778279231; cv=none; b=S8NlkJUlosb6NsLo5QV08qdW/MjNyxJkxzWj5G1B50ixPtGWTmjR0prnVIxmaH/XWnVyBpYNSM6VAKxvblNQu/xxrmC+41YOlX2G1lZqh5ZIKa8F+m8d3/orJlYODVkFkTFF4i1RvKgXgyJMPLK2uWqLvPobulE2oaz6v/QqFdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778279231; c=relaxed/simple;
	bh=2aQvwbopJkerVMd5vnTCl8R5gei4pfbsadE3BwBNQh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7oK+iSiqeQ1WhNVfwmNERdsm+CdOGGfOhF9ZxEM0UAUyzNeyvY2Bzqm5+YJ8uGJwcpTmps27lrWBtDawG9nNR8/BBjW7nj4+FhUWU1PTvzosAr399NJP1H7lskV+YgIFXmLe7FqYoP9jZyPQmk1FDMe6Ute63FDxwRa+KaSwy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arMMLK1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C57DC2BCB0;
	Fri,  8 May 2026 22:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778279231;
	bh=2aQvwbopJkerVMd5vnTCl8R5gei4pfbsadE3BwBNQh0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=arMMLK1gfFFzLGdlBUX4gJ2OkPlSCte255mTL8fvjuX/um9qlIpbFgi+bXVKbQgO7
	 jscCSO3yOHEvcHYDWdUWQMy2hLCUU7DVSf/MRl6+sC7KMeICay2j2AGqySKRAyLLB+
	 rTHg5b20pnh5jkxZsS/VdF2ZDz7T0qmkLkHE4Vdrpf+M0EjM8JQ8m8ZGZtCiyVp8Zm
	 zoA8hPwDeI7rhBjUo6HeahXxDk+aOghqIm+/S4SCit9PGUqhxhg4x87x4WobGvOfvr
	 VtznzSOcBOE13k9vhNbf38xjgOhE4O3gmtse6VMUWqwFDUhlwP+CFl1l+PaQIc4zKe
	 53Z2FNkE4xIUQ==
Date: Fri, 8 May 2026 15:27:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Alex Shi
 <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu
 <dzm91@hust.edu.cn>, Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi
 <pavan.chebbi@broadcom.com>, Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
 <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Alexander Duyck
 <alexanderduyck@fb.com>, kernel-team@meta.com, Daniel Borkmann
 <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, Shuah
 Khan <shuah@kernel.org>, dw@davidwei.uk, sdf.kernel@gmail.com,
 mohsin.bashr@gmail.com, willemb@google.com, jiang.kun2@zte.com.cn,
 xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Stanislav Fomichev <sdf@fomichev.me>, Mina
 Almasry <almasrymina@google.com>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 3/8] net: devmem: support TX over
 NETMEM_TX_NO_DMA devices
Message-ID: <20260508152708.011a9687@kernel.org>
In-Reply-To: <af5Vlwb5RctHym8D@devvm29614.prn0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
	<20260507-tcp-dm-netkit-v3-3-52821445867c@meta.com>
	<20260508134717.4ef87ab6@kernel.org>
	<af5Vlwb5RctHym8D@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A54804FC59C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20275-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[40];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,broadcom.com,nvidia.com,fb.com,meta.com,iogearbox.net,blackwall.org,davidwei.uk,gmail.com,zte.com.cn,vger.kernel.org,fomichev.me];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, 8 May 2026 14:28:55 -0700 Bobby Eshleman wrote:
> My guess is this would probably be the simplest way?

IDK. Notifiers are so inelegant. Don't we have the same problem with
the main ->dev on Tx binding?

