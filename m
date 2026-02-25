Return-Path: <linux-rdma+bounces-17145-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Pz3N4G1nmnwWwQAu9opvQ
	(envelope-from <linux-rdma+bounces-17145-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 09:40:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A89A194553
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 09:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 216763046AA0
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Feb 2026 08:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020AA322527;
	Wed, 25 Feb 2026 08:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogk+o/ld"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B859931D39F
	for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 08:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772008789; cv=none; b=U3UcbV2ryAjKymImyWtNdF1HeJQ+k5w06gpqJpB8iMXSRvOhrnZ3F8+W5J452ofIxLRqRZXy1wgHWNlk4G5p2yBrHH0y65tzbqheIlltsP5fjUtZRp8gDgqDpMA9GbfN9oGdVSaMjUcSXktYLDpEcKtz3ZO+MGbhNpaBh9kg0yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772008789; c=relaxed/simple;
	bh=vrrGMQbnf+2dV5ooRzVZAiTh2foYW0vfXITn+KLiFpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YFIuOBRWl+YIfZrqeX5YQu5S9qkaUCY/FqsMr1NtsOVjKC6FMp7b+mbDH8jy26tNWBHW3hSB97Dt9HmWKLEM8QqX1dXFvgWMbd4+ksslMA1J77QsfwuN7IsYB+O1wowq236Hj3KmDH0BGWC08a2po/d8s0P0+yvXjo0STqFLgQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogk+o/ld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C63BC2BCB4
	for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 08:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772008789;
	bh=vrrGMQbnf+2dV5ooRzVZAiTh2foYW0vfXITn+KLiFpQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ogk+o/ldfBSD07CxYi/F/NdUj2Fmrzyeo3Uws5jBoIxtNQNHh/BN8HVkuXJuaHuTk
	 U2WcGnGje+YDzU4aTNRdP6bVkvp5lM8D8+4Mn660PqtwTKIzXLfcXNe8q0Xp1dnGWV
	 a35oQSJL2xVQT2ozAJSNPupeaQfkmW0vF48eWx61uIESyv6Od9jV3I/0jMBjuv3kYO
	 85khEEumpT3lxXanHxgycJ9gQg0mC/zehqbAsMjyynefKtQkPOREOAEdzAPdR/OgTf
	 oA826fdJdn8a2tGBjZbiHey7jSpghsdDtsHlA+fPuJxiZ85OE0ZL2Q3n+iI15MZph3
	 K2VkOA9edlpHg==
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-896f9397ecdso69558266d6.3
        for <linux-rdma@vger.kernel.org>; Wed, 25 Feb 2026 00:39:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXAjyTPza+b7b1WqfrYoro0iJuCdTl/GVLNaR/Pe1pIVd1EOY7POnby5t/Ya/b0bSM6lqmLc2eVNxU@vger.kernel.org
X-Gm-Message-State: AOJu0YwsFcWnkNrbI16heuFPoIo/C978nDJiPQ6q38SoYaphBQGfISVh
	Y8VYhu60rKMYfmG/qRDa57FOdxaU+HBALQoCaD74cCk2JT8UrX4swqLXmT79Gp+LnssX7rzMvVA
	ZKoK4yaJjZ/bNfw51a6+bTQdNkgIoOjg=
X-Received: by 2002:a05:6214:1c07:b0:892:e3c3:94df with SMTP id
 6a1803df08f44-89979c90897mr223035516d6.28.1772008788473; Wed, 25 Feb 2026
 00:39:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219130050.2390226-1-bjorn@kernel.org> <415c4922-cc8d-4e35-bbac-3a532f44d238@lunn.ch>
 <20260219160519.323041bf@kernel.org> <3b0949fa-0b05-4bce-86c0-2a7a058865a5@lunn.ch>
 <20260220131254.03874c4c@kernel.org> <CAJ+HfNgXqpqDYsmAa-mpHnO82aDgC7XbyVw3TmXk-ySFmGA-JQ@mail.gmail.com>
 <20260223150401.7993b11a@kernel.org> <CAJ+HfNjmRjr6VtRijmN9=4zPwxstw9B8D-_XVn3hwJzNHka1Jw@mail.gmail.com>
 <363527d6-1f29-4399-83a7-978785d1e11f@lunn.ch>
In-Reply-To: <363527d6-1f29-4399-83a7-978785d1e11f@lunn.ch>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Wed, 25 Feb 2026 09:39:37 +0100
X-Gmail-Original-Message-ID: <CAJ+HfNhwM82H-sgbz0+WJGRjXJc8Ww0aCnp_YTNi-CB4aBMi=w@mail.gmail.com>
X-Gm-Features: AaiRm51b-iSHJIXJpU9YtqTJihADuqI8G1EWn5PObRj6T7uFZlGZRIWVqhfgDe0
Message-ID: <CAJ+HfNhwM82H-sgbz0+WJGRjXJc8Ww0aCnp_YTNi-CB4aBMi=w@mail.gmail.com>
Subject: Re: [RFC net-next 0/4] ethtool: CMIS module diagnostic loopback support
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jakub Kicinski <kuba@kernel.org>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Michael Chan <michael.chan@broadcom.com>, Hariprasad Kelam <hkelam@marvell.com>, 
	Ido Schimmel <idosch@nvidia.com>, Danielle Ratson <danieller@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.01 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,bootlin.com,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch,broadcom.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-17145-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:email]
X-Rspamd-Queue-Id: 4A89A194553
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 at 05:05, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > # ethtool --show-loopback eth0
> > Loopback endpoints for eth0:
> >   id  owner  depth  direction          name       enabled
> >    0  mac       1   host->loop->host   mac        off
> >    1  phy       2   host->loop->host   phy-pcs    on
> >    2  module    3   line->loop->line   cmis-far   off
> >
> > # Enable endpoint 2
> > ethtool --set-loopback eth0 id 2 on
>
> We have to be careful about what is ABI here. Initially you plan to
> implement module, so you will have:
>
> # ethtool --show-loopback eth0
> Loopback endpoints for eth0:
>   id  owner  depth  direction          name       enabled
>    0  module    1   line->loop->line   cmis-far   off
>
> ethtool --set-loopback eth0 id 0 on
>
> And then somebody implements loopback at the mac:
>
> # ethtool --show-loopback eth0
> Loopback endpoints for eth0:
>   id  owner  depth  direction          name       enabled
>    0  mac       1   host->loop->host   mac        off
>    1  module    2   line->loop->line   cmis-far   off
>
> You script doing
>
> ethtool --set-loopback eth0 id 0 on
>
> Suddenly does something else.

Indeed!

> Is this an ABI break? How do we make this reliable so implementing
> more loopbacks at different levels does not change how you use
> --set-loopback?

Isn't this somewhat similar to what we have with ifindex/phy_index,
but potentially unstable when modules are swapped/changed?

Instead of ids, use string name and/or topology indices (e.g.
phy_index)? All three -- owner, phy_index, name tuple?


Bj=C3=B6rn

