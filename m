Return-Path: <linux-rdma+bounces-20626-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNqVHfIxBWonTQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20626-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 04:22:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E42253CFEE
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 04:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED0993040471
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 02:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E947B31F987;
	Thu, 14 May 2026 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpdT/4sY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DA81E8826;
	Thu, 14 May 2026 02:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778725296; cv=none; b=pTg4fCuRM4RtCq/U6ug3+g1JP7mDszvu7P0dvY0wggf4uqFxonm79Ph80dhxP/dV0uXbzKZerM/Q2+cUibGOWAPLodLdHe35osQxNYccxrym7WUzuFgRYS978jFTp4E9dbPAWc1SiwTl7w9NI4JgHH0Nue6Sf9+uJtdNKiW63xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778725296; c=relaxed/simple;
	bh=hx+tymloAIZP4K3mSk6uylZJeFOgFon7qjf1v0Tiguk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9xJ+cpT6lNE6qg2cQ95vSQ/Kn97zAwlyu0IYzhnW18WXGgGRI59VYzdyuu8wkDjPEgNibc5LkiJMQOTUTKR81CS7saYMCm3S7FuktL8AH5JuQT8ZzV6O58XNjS3VcDKlARoXUuqTEnHbNuA89fCJibeWqIAr57d0GKiWkwcz7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpdT/4sY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2099EC19425;
	Thu, 14 May 2026 02:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778725296;
	bh=hx+tymloAIZP4K3mSk6uylZJeFOgFon7qjf1v0Tiguk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LpdT/4sYf4W5sJwtPHPsmS1gYgte/QoafDoR9rthPNQ0qfGDxUaqDC7gqbDYlTsSs
	 HLDVybZtXf4HM59aE5+pAed+O4XjPavi/2XremwM/XukiFH1AiO2qNrWkcsrbfxpkq
	 aYkuo+JXRhS7seBZQBaMSlQc5U1Aghl2zhIlA4oOUCDwH/xryfZQbHi87d9KN6scLO
	 pYhtGYoeGqVKk45s9coTfeBIU4b5ptBjqAbUNniEiqmsZPPRolVNoYg25jrATRjvfE
	 ZxixagliJqw1Jvoaag2tqHPQzrQhq8A32g68Ws/Q0rm8QCyDtvnmsfutt8uJa7WVD1
	 66+88xEsUI/GA==
Date: Wed, 13 May 2026 19:21:33 -0700
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
Subject: Re: [PATCH net-next v4 6/8] selftests: drv-net: refactor devmem
 command builders into lib module
Message-ID: <20260513192133.60a82598@kernel.org>
In-Reply-To: <20260511-tcp-dm-netkit-v4-6-841b78b99d74@meta.com>
References: <20260511-tcp-dm-netkit-v4-0-841b78b99d74@meta.com>
	<20260511-tcp-dm-netkit-v4-6-841b78b99d74@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1E42253CFEE
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
	TAGGED_FROM(0.00)[bounces-20626-lists,linux-rdma=lfdr.de];
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

On Mon, 11 May 2026 18:18:00 -0700 Bobby Eshleman wrote:
>  tools/testing/selftests/drivers/net/hw/devmem.py   |  77 ++------
>  .../selftests/drivers/net/hw/lib/py/devmem.py      | 218 +++++++++++++++++++++

If the reuse is in the same dir I think you can create

tools/testing/selftests/drivers/net/hw/devmem_lib.py

and import:

from devmem_lib import bla

I _think_ that should "just work" ?

The lib/ is meant for things shared between targets.

Also I think you missed adding the new file to Makefiles ?
It needs to be under TEST_FILES for building tarballs

