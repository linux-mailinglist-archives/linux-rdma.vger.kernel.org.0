Return-Path: <linux-rdma+bounces-17033-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAARLT0YmGki/wIAu9opvQ
	(envelope-from <linux-rdma+bounces-17033-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 09:15:57 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 138EB165904
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 09:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CF48305F656
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Feb 2026 08:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1B0335564;
	Fri, 20 Feb 2026 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Te+iyE/u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920552BD030
	for <linux-rdma@vger.kernel.org>; Fri, 20 Feb 2026 08:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771575116; cv=none; b=N5kIYY8KnMsTjAzZ0A5faTqX9CgTEV9BOoAhKYHUxUydqApMyKv2/0xz7RjmjcobAX0S+SoMAMMWd78tl/ZT9kro85uPCQOw4b28Ji/u5z5/4HaZ4pDdzA3YWGtZWSyHqy37naXYj2EH6VoD9NBFDqcU0UT3daHFbOel3BawY1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771575116; c=relaxed/simple;
	bh=jgaGYASEVfiCuUYYl60T8xbwHVNkJiMc0PU7s/vWcFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6TRi8BNk7nq4V/dGc5+Ljjj70NYqh+1Pb/eI7kZUlE2d2AYUb4ITTtdDxdJPBG/vBZy/xMyfn6VBWGn329mkisx6SCNi9nOQwuUB4cnvVmCF/jM53pZ/KyvC2gYioqz9oSNdjS7yzeYikZLfYaKia/0bJ1CiV/7P/wl6jn24LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Te+iyE/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA38C2BCB7
	for <linux-rdma@vger.kernel.org>; Fri, 20 Feb 2026 08:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771575116;
	bh=jgaGYASEVfiCuUYYl60T8xbwHVNkJiMc0PU7s/vWcFM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Te+iyE/urmCl/e+03hgWCaO3XIAO6koYwrzp/z84jlwUODs8AeN2bzeavLV/RlvD7
	 kFZV1lVQHfSOFFhzZUtJPSlTh2KhsqWQq/V1RbJAKiqMUaXcdyVpMhZlrzqYUqv4jq
	 SAA7tq0Lzip4AoUgqpQgmKyTVhrxPARnNo4295lUWZVHsqh015tHmx7LEc2qIOnhuD
	 6qcFXbE5nDYUYRctsF3ub/27TUO1znLPGdtJzv90x5Ya+LHJQ3udhpLe33Q96+T+Hb
	 1nPX9FkfPjbz67CSbKHCszQSydwFyB/6dBhQe8T5UqRV+cmvC0G8p8apG7iUeLAduT
	 IyqhJd+/Ab2cA==
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50335b926c2so16035641cf.2
        for <linux-rdma@vger.kernel.org>; Fri, 20 Feb 2026 00:11:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWIzihhbW5MUmG4iGZFy6swK3Zxfh7bkoqVGa8wDoW6uPHRK7CQbjyxRscTn6bJmTXFGxavdQgRbMJh@vger.kernel.org
X-Gm-Message-State: AOJu0YyYfXpEyy1j3j34VNE+Q9ouOytFtQ5QzKgeaOBBNszNYko3OCWr
	6DZJOF8wPnT48Bt0D+7dWXlXlS/GQKfbxRPITAIoyaJUGXOEVewUWNHslGMcurjeKdVYPQ3m2BR
	vM8fxfocvt6Px8fq6pO2On4iGv2rcM2U=
X-Received: by 2002:ac8:5a91:0:b0:506:a320:e45b with SMTP id
 d75a77b69052e-506e9227fbbmr97652531cf.39.1771575115125; Fri, 20 Feb 2026
 00:11:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219130050.2390226-1-bjorn@kernel.org> <415c4922-cc8d-4e35-bbac-3a532f44d238@lunn.ch>
In-Reply-To: <415c4922-cc8d-4e35-bbac-3a532f44d238@lunn.ch>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Fri, 20 Feb 2026 09:11:44 +0100
X-Gmail-Original-Message-ID: <CAJ+HfNgdd3zKzzjzTJz6-7ZHhac9qzMDszAgf188eTH0LhACKg@mail.gmail.com>
X-Gm-Features: AaiRm51PAs_ZobjAC5WWZyAVp2spZjNgvPxfjHW2MWQJpRXwyyLfVk1uw2bAQ7c
Message-ID: <CAJ+HfNgdd3zKzzjzTJz6-7ZHhac9qzMDszAgf188eTH0LhACKg@mail.gmail.com>
Subject: Re: [RFC net-next 0/4] ethtool: CMIS module diagnostic loopback support
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,lunn.ch,bootlin.com,broadcom.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-17033-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 138EB165904
X-Rspamd-Action: no action

Andrew!

Thanks for the swift response!

On Thu, 19 Feb 2026 at 16:51, Andrew Lunn <andrew@lunn.ch> wrote:

> Great to see you looked around at the problem space.
>
> > [2] https://lore.kernel.org/netdev/20240911212713.2178943-1-maxime.chev=
allier@bootlin.com/
>
> Quoting myself from this thread:
>
> > We might want to take a step back and think about loopback some more.
> >
> > Loopback can be done at a number of points in the device(s). Some
> > Marvell PHYs can do loopback in the PHY PCS layer. Some devices also
> > support loopback in the PHY SERDES layer. I've not seen it for Marvell
> > devices, but maybe some PHYs allow loopback much closer to the line?
> > And i expect some MAC PCS allow loopback.
> >
> > So when talking about loopback, we might also want to include the
> > concept of where the loopback occurs, and maybe it needs to be a NIC
> > wide concept, not a PHY concept?
>
> I still think this is true. We want a generic kAPI for loopback, not a
> PHY loopback kAPI, and a MAC loopback kAPI, a PCS loopback kAPI, and
> an SFP loopback kAPI, and a CAN bus transceiver loopback kAPI,
> assuming CAN bus supports loopback?
>
> So i think we need one ethtool API for loopback. We probably want an
> API call to enumerate what loopbacks are supported for a netdev. The
> MAC will fill in bits indicating what it can do. If the MAC has a PCS,
> it will ask the PCS what it can do. If there is a PHY, it will ask the
> PHY to fill in the bits indicating what it can do, if there is an SFP,
> it will ask it what it can do, and if there is a CAN bus transceiver,
> it will fill in its bits. And we probably want two values for each
> loopback location, is it looping the media side, or the MAC side?
>
> So the return value lists all the different loopbacks associated to a
> netdev.
>
> And then we need a set operation, to enable/disable a specific
> loopback, and a get operation to return the status of all the
> different loopbacks of a netdev. The MAC will again need to call into
> the PCS, the PHY, the SFP to implement these.
>
> I'm not saying you need to implement all these, you just need to make
> what you do implement generic, and plumb it through the network stack
> so that others can later easily add PHY, PCS, and MAC loopback
> support. And from your background research, you know others are
> interested in this, so you might be able get some help with parts you
> are not particularly interested in.

All good points here; Thanks for the elaborative feedback. I like the
idea of a generic loopback API. Back to the drawing board!


Bj=C3=B6rn

