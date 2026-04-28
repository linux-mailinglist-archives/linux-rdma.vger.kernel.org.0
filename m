Return-Path: <linux-rdma+bounces-19616-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aL3uCcD572nbMwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19616-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 02:05:20 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C6A47C0BB
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 02:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E475300B583
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 00:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D99D40DFA6;
	Tue, 28 Apr 2026 00:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzQdbLBh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8FC1DA23;
	Tue, 28 Apr 2026 00:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777334715; cv=none; b=Cb/u2TnRPvA//2bTVPFjc8fh9Cmm7PiRUgDWSs9la3VOKWXkm28LTvCUjNce56luUrKVSQXoNxo+LfK6i9Z/e+Hr7cfcTOC4rtMtUiglECijj4b6GVMDNmVlgMaJIDFtaSeMEyYwwCO+udkyvEP7yFLoiJ9fF7TJzwuLuNZkTuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777334715; c=relaxed/simple;
	bh=+VPANvDgMOiP/9CCoh3IqXDmdQ2vvDPBVm15uDgS4u4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DoZHBlWIJnceoSoiTlHb4sS+69RrlX01/DUlXc45B3SzvP28dTSuipOOkaYKgUn4GqQi6iL92Re0aWmjnh0DZ0U34z4DoOXyeVSHC25weaZpf3IcaISMYlL9jfkNH0mRhpGbjBq/wtUBWLwfVhEmyFPkGUHI0XdTKpSp+vkGhqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzQdbLBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FB5C2BCB6;
	Tue, 28 Apr 2026 00:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777334715;
	bh=+VPANvDgMOiP/9CCoh3IqXDmdQ2vvDPBVm15uDgS4u4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bzQdbLBhZugdQU0bBWDb/Ztbb1C9bvWDPS7DD8xo99p4y9aUSEtlMUGxf6EVVFEDw
	 9EWxyepAzAbXqFXhPXFlPHr0zCjnj2i5QYttWpIWTLQqr5TpoU7p2uwsHxd7eB/qif
	 eIIbGMZDleADQbbCh0z15qaKj7HCvLgi5WXpn+vajEADXZiAMhKQ39tmQaFuGTCGi2
	 7AJ3uyubquEerYSwDa9QyDmCMPiFc41F+7gvAQBr+jmiu9JxIYC6IKeW9qNUmGAZ1d
	 xjUrDsnXcA7Xibl4hlDambhnAlJrCnxvQdf3VyfGoM15tIyNwdgvpD4hXljxwKfvH4
	 dY85Kx1xYgecQ==
Date: Mon, 27 Apr 2026 17:05:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Boris Pismenny
 <borisp@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Daniel Zahka
 <daniel.zahka@gmail.com>, Cosmin Ratiu <cratiu@nvidia.com>, Raed Salem
 <raeds@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, Kees Cook <kees@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net V2 1/2] net/mlx5e: psp: Fix invalid access on PSP
 dev registration fail
Message-ID: <20260427170513.05bb02b7@kernel.org>
In-Reply-To: <willemdebruijn.kernel.2f90e0de4485b@gmail.com>
References: <20260426083819.208937-1-tariqt@nvidia.com>
	<20260426083819.208937-2-tariqt@nvidia.com>
	<willemdebruijn.kernel.2f90e0de4485b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 13C6A47C0BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19616-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nvidia.com,google.com,redhat.com,lunn.ch,davemloft.net,kernel.org,gmail.com,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Sun, 26 Apr 2026 09:17:08 -0400 Willem de Bruijn wrote:
> > priv->psp->psp is initialized with the PSP device as returned by
> > psp_dev_create(). This could also return an error, in which case a
> > future psp_dev_unregister() will result in unpleasantness.
> > 
> > Avoid that by using a local variable and only saving the PSP device when
> > registration succeeds.
> > Also apply some light refactoring of the functions managing the PSP
> > device in order to make them more readable/safe.  
> 
> This is generally discouraged as it obfuscates the fix.

+1, I should have said this during the v1 convo, I thought it's obvious
:\

