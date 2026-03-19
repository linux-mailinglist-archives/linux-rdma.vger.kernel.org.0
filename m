Return-Path: <linux-rdma+bounces-18406-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOxgABmJvGlk0AIAu9opvQ
	(envelope-from <linux-rdma+bounces-18406-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 00:39:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C262D43C0
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 00:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2CEC326B8E1
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 23:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB15410D08;
	Thu, 19 Mar 2026 23:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLw1gwv9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B25440756B;
	Thu, 19 Mar 2026 23:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773963072; cv=none; b=pdkPM/Ak2ERds36pSeBjnFcJ/Yjfrj5bnEc9D7pnWgRt1fGjrwtB5CRIe9TSxqkJI1oTCtH5s/xs4yC/QcD2i8nL8Sa3EGB1uxRfPaXdQqTC6ZcJ9XrnIvSWFtefQihiXnCuNODinqstXFVZGu2/+eymZ932Xrx+d29Txx7n7c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773963072; c=relaxed/simple;
	bh=rdU75h+RxugSStenO8TGm97kuv724uVI0/nLR8CJmR0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dz3xfMsGe8wDlLrdVtMJkO0YfAmlPiwyncr8jVPFPYLIfw24UgrT3nbtZ+82A3Y7l5NzNq4pCfOfWILHvnNhwMfdhS8fGTdaTY3ijb7oYTbKmCqIQwnZgbgloHDHdzk5Dar+VyVONV/lctBlj1MoAQnSq4Kip3dJkh+CwuAV2Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLw1gwv9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E51CC2BC9E;
	Thu, 19 Mar 2026 23:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773963072;
	bh=rdU75h+RxugSStenO8TGm97kuv724uVI0/nLR8CJmR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nLw1gwv9tBT290w5jk0KbmKXTtHS+wFK5PEuLPVIIeE5M5dBEG03kGQsoiL87QBpH
	 ot2ATfWWmGjXFe0NHztg+vofWw82idx6nD6xKKtqJzi1Xvn84+dPnoOWLd3zJPiABm
	 A5YYxSl1Ph7QBu11zsoDNeHOs2f0i83XWfLYBQxFdbBor8b0yj7DGD7Z5Sjo5szxul
	 blGBHBSyeM5GyC2VI/b8RoA4AIT3Eer4DPLX8MRKtgNeVS5AOJ5Y/l08W1Veko7ByH
	 j/kZjzEkdu8Wy+vw1hkk/1rzqYHTjzf5AwWZbWvJ1MFf9JJyenyylMCD9HEV5rquuo
	 yHos+ltsfNzNQ==
Date: Thu, 19 Mar 2026 16:31:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Byungchul Park
 <byungchul@sk.com>, linux-mm@kvack.org, akpm@linux-foundation.org,
 netdev@vger.kernel.org, Mina Almasry <almasrymina@google.com>, Toke Hoiland
 Jorgensen <toke@redhat.com>, linux-kernel@vger.kernel.org,
 kernel_team@skhynix.com, harry.yoo@oracle.com, ast@kernel.org,
 daniel@iogearbox.net, davem@davemloft.net, john.fastabend@gmail.com,
 sdf@fomichev.me, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 mbloch@nvidia.com, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, david@redhat.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, horms@kernel.org, jackmanb@google.com,
 hannes@cmpxchg.org, ziy@nvidia.com, ilias.apalodimas@linaro.org,
 willy@infradead.org, brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
 usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 asml.silence@gmail.com, bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
 sfr@canb.auug.org.au, dw@davidwei.uk, ap420073@gmail.com
Subject: Re: [PATCH v5] mm: introduce a new page type for page pool in page
 type
Message-ID: <20260319163109.58511b70@kernel.org>
In-Reply-To: <05c0db9b-c92f-4758-a356-e035a174b5dd@nvidia.com>
References: <20260316222901.GA59948@system.software.com>
	<20260316223113.20097-1-byungchul@sk.com>
	<ebd00055-d4aa-4612-8bf3-ef0a308512f8@kernel.org>
	<05c0db9b-c92f-4758-a356-e035a174b5dd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18406-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,sk.com,kvack.org,linux-foundation.org,vger.kernel.org,google.com,redhat.com,skhynix.com,oracle.com,iogearbox.net,davemloft.net,gmail.com,fomichev.me,nvidia.com,lunn.ch,suse.cz,suse.com,cmpxchg.org,linaro.org,infradead.org,linux.alibaba.com,canb.auug.org.au,davidwei.uk];
	RCPT_COUNT_TWELVE(0.00)[47];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89C262D43C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 12:06:51 +0100 Dragos Tatulea wrote:
> > Should we handle this more gracefully here? (release pp resources)
> >   
> Releasing of a leaked page_pool page could lead to many harder to track
> side-effects further down the line. Isn't it better to simply let the
> page in a leaked state?

+1 that'd also be my intuition.

