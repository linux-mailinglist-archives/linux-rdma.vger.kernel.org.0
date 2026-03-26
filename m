Return-Path: <linux-rdma+bounces-18698-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HgZA3H3xGmk5QQAu9opvQ
	(envelope-from <linux-rdma+bounces-18698-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 10:08:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B0E331F27
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 10:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C0A5930874CD
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Mar 2026 08:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7415283FEA;
	Thu, 26 Mar 2026 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7YTlPpM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AF92DECC2
	for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2026 08:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774515323; cv=none; b=dQY23tvQtV9MBIrFWYRuwAzzQwxNiMQlfNU08eX0Pjr3SuIZfcJuLnnfjzIXP7BTclgCoYGwfyz54CYraNHklhyHjuTb3t8lKapcy06sy6/IwGUJo6g0GEvAmofV5Qd9d5cOCBNUzSZ4fHR+0rhQJE7MbrqPjrYy4BT+d7KFfyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774515323; c=relaxed/simple;
	bh=WI3UlnZsJMZEs8+G2pLceqS01VbAn/Itdv+PDIf3JcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NyFzOqH7lkdAF9+CsFJhHNJSNe3/gFcCkCBI4TQEVh1E7u9jo5AkMSJFzjzFQMbCjldTH7OKzxndlFlPRig3Y1Ck9hEE6YytOGYc7tW91ihmGUkbaRs7vS/qrNcLOsxvvz0OC/+G4Gn2w3UKjWPLpMm3p7aCli8J1JHscp1+suE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7YTlPpM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C69FC2BCB3
	for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2026 08:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774515323;
	bh=WI3UlnZsJMZEs8+G2pLceqS01VbAn/Itdv+PDIf3JcU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u7YTlPpMjTN7iL/AduRAAUQud+dshPKlqbtZ7hEFm6+60iV6+pJy+iixUd1bEChbs
	 LnlkxCJY6bOG5jKN30uakTBo+SbRuf2iIJgwHhPZSFvbRzxbgPDXJTrc8G1fWnzGL3
	 dkUtAq00d+DGPUAMS7xVvHcnlCQqm8hNMEXXmJUm+OaJRBICGJONnxkz/Rb9XMbOTf
	 kEJBaje8ELBcDeIbc2sWmp5/txXyYUXYqY5em006Qo9oblL4yGLp2hFAZkiof8fOvp
	 gspUZHPn/ivI9PDW5cs7NhXqAL5EzN0Z3sfY6g6k+JuLqaOrWE7AjaCqD52mkm34n3
	 kmIS+MHsd9Kcw==
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cd7284782dso48494885a.1
        for <linux-rdma@vger.kernel.org>; Thu, 26 Mar 2026 01:55:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXkL1ipV8sjJnGCz0UomntrVWxyjIvdC+0CcmZrw1+qmWJ4JharcgWt+zyZeojlEy1D1Apy50On3awI@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv6GZ9fWzb5QdHWcrGSDGYoe4BMIjQWBaspMWN5OSOOHe1cniM
	oZNMvxHhEWN086k/9gN4Z9PgDTO9reouEFDyMkBOom4PT4bVagLMk/6R7GFwExMOK+uF11BHean
	NOcbYYzKVoIOdlDGzdGDGz37Obv/vHiE=
X-Received: by 2002:ac8:6906:0:b0:509:882:9e7a with SMTP id
 d75a77b69052e-50b80f2ba1fmr92779011cf.70.1774515322055; Thu, 26 Mar 2026
 01:55:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325145022.2607545-1-bjorn@kernel.org> <20260325145022.2607545-4-bjorn@kernel.org>
 <2859dddf-a7b7-46f8-b97d-45d8be242cde@bootlin.com>
In-Reply-To: <2859dddf-a7b7-46f8-b97d-45d8be242cde@bootlin.com>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Thu, 26 Mar 2026 09:55:11 +0100
X-Gmail-Original-Message-ID: <CAJ+HfNiFrr4o1jp+9S7qwf0uLJSu1w0xuRp=vMTKy0h8k2jUcQ@mail.gmail.com>
X-Gm-Features: AaiRm505r-8a43ZSTjoXwKs-G2S_sqNSyxyDaKUyDM3o9vh8L82fgoGyTVvP7VE
Message-ID: <CAJ+HfNiFrr4o1jp+9S7qwf0uLJSu1w0xuRp=vMTKy0h8k2jUcQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 03/12] ethtool: Add loopback netlink UAPI definitions
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Naveen Mamindlapalli <naveenm@marvell.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Danielle Ratson <danieller@nvidia.com>, Hariprasad Kelam <hkelam@marvell.com>, 
	Ido Schimmel <idosch@nvidia.com>, Kory Maincent <kory.maincent@bootlin.com>, 
	Leon Romanovsky <leon@kernel.org>, Michael Chan <michael.chan@broadcom.com>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Willem de Bruijn <willemb@google.com>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,kernel.org,marvell.com,redhat.com,nvidia.com,bootlin.com,broadcom.com,pengutronix.de,armlinux.org.uk];
	TAGGED_FROM(0.00)[bounces-18698-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 50B0E331F27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Maxime!

On Thu, 26 Mar 2026 at 09:10, Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> Hi Bj=C3=B6rn,
>
> On 25/03/2026 15:50, Bj=C3=B6rn T=C3=B6pel wrote:
> > Add the netlink YAML spec and auto-generated UAPI header for a unified
> > loopback interface covering MAC, PHY, and pluggable module components.
> >
> > Each loopback point is described by a nested entry attribute
>
> Is the nest actually needed ? if everything is under the nest, you might
> as well just drop it and return all the attributes directly ?

Hmm, you're right! This is a leftover pre the dumpit change. GET/SET
never needs nesting. I'll fix that for the next round!

Thanks!
Bj=C3=B6rn

