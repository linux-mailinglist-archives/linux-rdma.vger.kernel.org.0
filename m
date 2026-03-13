Return-Path: <linux-rdma+bounces-18145-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CN3fEjg9tGmDjQAAu9opvQ
	(envelope-from <linux-rdma+bounces-18145-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 17:37:12 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D917828726A
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 17:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63141305C31B
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 16:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC9E3C7DED;
	Fri, 13 Mar 2026 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7TXBfDT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A637313E00;
	Fri, 13 Mar 2026 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773419814; cv=none; b=JxhmkMcX8N80bcHnL2XfyJ9oxGNK/+LDONu1/DuwySXn3gPqqnqz7U3fngmsKDj6jKmU5LZZ8Cikeih8hq6Rf5YgshBlV4YNmslRNV6snzM59wFroYcM72FvibA/ENeASw8Gu3RhmknvYCvWDfbO3G8Z6LRGo8dlHLNo5aocJ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773419814; c=relaxed/simple;
	bh=yxUcqh0AcpHROQQEEoQ7r7oTAaEg7FuJwAC+SAMDP3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gpcTNvkcNjkBY+VpT7UUKvI+rn5nYauTwn7xKk/CzjzIvuD1gIsIYPD1QZo1uBZO46+/W1F3EYHTu9VkqADX6Niv+98579sAk5dhUCuk6NqtLLWnuo8IMPXwL5fIjOCpRrDoIRbbTsmyFPKAHa6Qjc4lw8LfhroRT+DEaQrzSnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7TXBfDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E272C19421;
	Fri, 13 Mar 2026 16:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773419813;
	bh=yxUcqh0AcpHROQQEEoQ7r7oTAaEg7FuJwAC+SAMDP3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=V7TXBfDT+CWpXuMQM09aE4/F+wrh1K/CJsOpJgtGA3GokfzWsZ6ey1lMex3vO/GhS
	 6ol7Unp8+Nhqy5zTzKw4T3KEDN0+hOWQRgxSe0roTmXq2OJDSRRLrnxk4JTXN75a9Z
	 8XmobYHZnGWO+Ce/hcjgfI0ZLq9ouZFbW0WVuTHspOQp9Dv3f9xHypO9pj71+J4ppH
	 yXRpy1K5WfbHHgMxxJh8c3SYYLaFGVDfKzVornauyGzZiIAs8lJclxTOQEGp+SIhd4
	 3kXnt3O63pv9mVulOmuNRhOHWAhFPptQlhXnXLDF2H7HRuJh54KSQzmkmt+uu8BPO8
	 tcCtb20WFuZUw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, Eric
 Dumazet <edumazet@google.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Naveen Mamindlapalli
 <naveenm@marvell.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Danielle Ratson <danieller@nvidia.com>, Hariprasad
 Kelam <hkelam@marvell.com>, Ido Schimmel <idosch@nvidia.com>, Kory Maincent
 <kory.maincent@bootlin.com>, Leon Romanovsky <leon@kernel.org>, Michael
 Chan <michael.chan@broadcom.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Saeed
 Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan
 <tariqt@nvidia.com>, Willem de Bruijn <willemb@google.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next 01/11] ethtool: Add dump_one_dev callback for
 per-device sub-iteration
In-Reply-To: <20260311193221.3306811b@kernel.org>
References: <20260310104743.907818-1-bjorn@kernel.org>
 <20260310104743.907818-2-bjorn@kernel.org>
 <20260311193221.3306811b@kernel.org>
Date: Fri, 13 Mar 2026 17:36:50 +0100
Message-ID: <87eclny9ct.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18145-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,lunn.ch,gmail.com,google.com,bootlin.com,marvell.com,redhat.com,kernel.org,nvidia.com,broadcom.com,pengutronix.de,armlinux.org.uk];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[all.your.base.are.belong.to.us:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D917828726A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 10 Mar 2026 11:47:31 +0100 Bj=C3=B6rn T=C3=B6pel wrote:
>> The per-PHY specific dump functions share a lot functionality of with
>> the default dumpit infrastructure, but does not share the actual code.
>> By introducing a new sub-iterator function, the two dumpit variants
>> can be folded into one set of functions.
>>=20
>> Add a new dump_one_dev callback in ethnl_request_ops. When
>> ops->dump_one_dev is set, ethnl_default_start() saves the target
>> device's ifindex for filtered dumps, and ethnl_default_dumpit()
>> delegates per-device iteration to the callback instead of calling
>> ethnl_default_dump_one() directly. No separate start/dumpit/done
>> functions are needed.
>>=20
>> For the existing per-PHY commands (PSE, PLCA, PHY, MSE), the shared
>> ethnl_perphy_dump_one_dev helper provides the xa_for_each_start loop
>> over the device's PHY topology.
>>=20
>> This prepares the ethtool infrastructure for other commands that need
>> similar per-device sub-iteration.
>
> Feels like this could be split into two patches for ease of review.

Hmm, OK! My take was the it was mostly moving stuff.

> Warning: net/ethtool/netlink.h:441 struct member 'dump_one_dev' not descr=
ibed in 'ethnl_request_ops'
> Warning: net/ethtool/netlink.h:441 struct member 'dump_one_dev' not descr=
ibed in 'ethnl_request_ops'

Thanks! (I've looked thru all the pw complaints, and fixed locally!)

>
>> @@ -616,17 +580,41 @@ static int ethnl_default_dumpit(struct sk_buff *sk=
b,
>>  				struct netlink_callback *cb)
>>  {
>>  	struct ethnl_dump_ctx *ctx =3D ethnl_dump_context(cb);
>> +	const struct genl_info *info =3D genl_info_dump(cb);
>>  	struct net *net =3D sock_net(skb->sk);
>>  	netdevice_tracker dev_tracker;
>>  	struct net_device *dev;
>>  	int ret =3D 0;
>>=20=20
>> +	if (ctx->ops->dump_one_dev && ctx->ifindex) {
>> +		dev =3D netdev_get_by_index(net, ctx->ifindex, &dev_tracker,
>> +					  GFP_KERNEL);
>> +		if (!dev)
>> +			return -ENODEV;
>> +
>> +		ctx->req_info->dev =3D dev;
>> +		ret =3D ctx->ops->dump_one_dev(skb, ctx, &ctx->pos_sub, info);
>> +
>> +		if (ret < 0 && ret !=3D -EOPNOTSUPP && likely(skb->len))
>> +			ret =3D skb->len;
>> +
>> +		netdev_put(dev, &dev_tracker);
>> +		return ret;
>> +	}
>> +
>>  	rcu_read_lock();
>>  	for_each_netdev_dump(net, dev, ctx->pos_ifindex) {
>>  		netdev_hold(dev, &dev_tracker, GFP_ATOMIC);
>>  		rcu_read_unlock();
>>=20=20
>> -		ret =3D ethnl_default_dump_one(skb, dev, ctx, genl_info_dump(cb));
>> +		if (ctx->ops->dump_one_dev) {
>> +			ctx->req_info->dev =3D dev;
>> +			ret =3D ctx->ops->dump_one_dev(skb, ctx, &ctx->pos_sub,
>> +						     info);
>> +			ctx->req_info->dev =3D NULL;
>> +		} else {
>> +			ret =3D ethnl_default_dump_one(skb, dev, ctx, info);
>> +		}
>>=20=20
>>  		rcu_read_lock();
>>  		netdev_put(dev, &dev_tracker);
>
> Not sure if it works here but another way to implementing single dump
> and a loop dump concisely is to init both ifindex and pos_ifindex when
> request is parsed and then add
>
> 	if (ctx->ifindex && ctx->ifindex !=3D ctx->pos_ifindex)
> 		break;
>
> at the start of the loop. That way the body of the loop doesn't have to
> be repeated in a separate if=20

Indeed! I think that would work, and that'd be cleaner!

Cheers!

