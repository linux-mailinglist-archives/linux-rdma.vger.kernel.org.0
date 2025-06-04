Return-Path: <linux-rdma+bounces-10977-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F143ACDBE7
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 12:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01B983A4B21
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jun 2025 10:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B7826156B;
	Wed,  4 Jun 2025 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O0na44ib"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0615227574;
	Wed,  4 Jun 2025 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749032629; cv=none; b=uJHY/dxI/Y5+MqRk77eoljuk5o4bGj458kPz9xeDb3EN88l9ZlLzoZHhf5Ozv4su/q/fK63W7WATekz2F220blDu9WltgDX8ej2TuC/28HJfY6hXofKa4DQ+JTds6SruvQ+7Dx8UoUT30qmV/BhRakKo9Q1iZduzlhmWgSa2a8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749032629; c=relaxed/simple;
	bh=QxNSTDXCGJOmWNBGEOkx78UPdyo2nZYaQ3Fb7w+/lws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rergP1k9pjbquP9MYUxsReO7Ei8p3vxfVkh18k3XKrbngwfMIfHBdLTCqoDWUp0y9iVOH53EVAEUW8Nr2abukrWxvkwAhRcgCdlqxSJlz9p9RZl0x10zbn4ezlILxsPJ5agbHw4V1Wt1gse/hW45EIN1yk4ru46fEl5i18s8mNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O0na44ib; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 63D0B1140142;
	Wed,  4 Jun 2025 06:23:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 04 Jun 2025 06:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749032625; x=
	1749119025; bh=HjeA796RFt94HBnou7FcFNxCyD0fs7Jyu9j4FkElU7c=; b=O
	0na44ibaSzxf1NrXoE2V5ZGwpoAM7NQVFLd/s/7v32+tw0yKDB2gDPLHUP+4lphu
	cMt8WX9k1AZLKcqM/R00DW9zB2KCvA4w6R1IRHDFhXX2/vwoatl+QF89vhbBtLF/
	VTYbt5EtNhssgJE/1O2RSySzeZnnfP7f6K/m617vGbgWE8tSnT5omQsWykUIUe1/
	Qqw0x39uRTB13imdwOtJfaHgUATAnOJ8nIuWSdxO5eeMv67sPK0nvTr5dDInNze7
	a5TAc9w/WDx4cKgoZ7INAl5tqbIozQm8C0UkmQYOXCgU9R43oocnDPlpb8cnejg8
	Duh1qmERoqUB+2v0hPvvg==
X-ME-Sender: <xms:sB5AaMpPOmEDLgVz71jxwql8VU--mtfOyHp7m6lb7vdSvP0FyCJcKQ>
    <xme:sB5AaCqRscuHMXPJKbYyA33ZUtoXbBI0YoZO5YRUfd2lNA0bCHFlqT4Vnsvnq3eBj
    HCzRSSfHOLllLw>
X-ME-Received: <xmr:sB5AaBPjHnkZ0PwzYvhE1mr8YMdHRF3SELzYVdOWERwibwJShz1o3Sk_8QiD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpeekgefggefhuedvgeettdegvdeuvdfhudejvddv
    jeetledvuedtheehleelhffhudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphht
    thhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephigthhgvmhhlrgesnh
    hvihguihgrrdgtohhmpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehtrghrihhqthesnhhvihguihgrrdgtohhmpdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehprggsvghnihesrhgvughhrght
    rdgtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtph
    htthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtohepshgr
    vggvughmsehnvhhiughirgdrtghomhdprhgtphhtthhopehlvghonheskhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:sB5AaD4tkWY5BOzrYbi1ML5dWNcPznC6zqdJDm3zn5mn7SkTiR465g>
    <xmx:sB5AaL674c-b4D_wCz4iFJqcQ_Tepap7vKdelTs7RmRWLsO0pmibug>
    <xmx:sB5AaDhA2KkOjJQ09X8BqyPk6jTNQ1Lf2EIvcUw8Om4XnaqwUbsVEA>
    <xmx:sB5AaF45A9G_7DoLTpVr1Yzeefc-tAO4GqfsfDwL3wuBkd5ViBSZ2g>
    <xmx:sR5AaOc4iUAA06aGfHmDHjUf64jxLYEBlVGp5yQh150WFicpvMZ9Z1-i>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 06:23:43 -0400 (EDT)
Date: Wed, 4 Jun 2025 13:23:41 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Yael Chemla <ychemla@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net/mlx5e: Log error messages when extack
 is not present
Message-ID: <aEAerYw-5p8S4bHq@shredder>
References: <1748173652-1377161-1-git-send-email-tariqt@nvidia.com>
 <1748173652-1377161-3-git-send-email-tariqt@nvidia.com>
 <20250527174955.594f3617@kernel.org>
 <2c0f4a69-dd90-4822-9981-faa90f7a58a6@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c0f4a69-dd90-4822-9981-faa90f7a58a6@nvidia.com>

On Wed, Jun 04, 2025 at 12:01:05AM +0300, Yael Chemla wrote:
> Ethtool APIs: While Netlink support was introduced around versions
> 5.6–5.8, many LTS distributions (e.g., Ubuntu 20.04, CentOS 7) still
> ship with older userspace ethtool utilities that rely on ioctl for
> certain operations. In these ioctl-based paths, the extack pointer
> passed down to the driver may legitimately be NULL.

[...]

> If a narrower scope is preferred, I can revise the patch to include only
> the ethtool-related changes, which were the primary motivation behind
> this work.

FWIW, there is a netlink extack tracepoint that is always triggered from
NL_SET_ERR_MSG(). Example:

ethtool$ ./configure --disable-netlink &> /dev/null
ethtool$ make -j14 &> /dev/null
# echo "10 1" > /sys/bus/netdevsim/new_device
# echo 1 > /sys/kernel/tracing/events/netlink/netlink_extack/enable
# cat /sys/kernel/tracing/trace_pipe &
[1] 390
# ./ethtool --set-ring eni10np1 rx 1
         ethtool-413     [008] .....    80.588053: netlink_extack: msg=netdevsim: testing123

Used this dummy patch:

diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 4d191a3293c7..38022e8e1f37 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -85,6 +85,7 @@ static int nsim_set_ringparam(struct net_device *dev,
 {
 	struct netdevsim *ns = netdev_priv(dev);
 
+	NL_SET_ERR_MSG_MOD(extack, "testing123");
 	ns->ethtool.ring.rx_pending = ring->rx_pending;
 	ns->ethtool.ring.rx_jumbo_pending = ring->rx_jumbo_pending;
 	ns->ethtool.ring.rx_mini_pending = ring->rx_mini_pending;

