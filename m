Return-Path: <linux-rdma+bounces-7769-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5304A35C40
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2025 12:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B2793AA3C6
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Feb 2025 11:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9194261364;
	Fri, 14 Feb 2025 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XV5FHuQd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A8325EFAA;
	Fri, 14 Feb 2025 11:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739531683; cv=none; b=jvKU0Ij39k/dBJYgOF5YR3rxMRd/KPxQjjVJiZj7WsfmFiXbNLhphr+kMIlIep7ouA7bMbvCPGvW3VdQG0p116Mx2djbhBPt4AQlqNhKhcAWzNAPmC2Lrhnp5z8sgRMobD9tYbPd44vqABud8ZNA0MWlR9E5Nr0QJ49ar+IAEz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739531683; c=relaxed/simple;
	bh=h0lJOOGwOy62qvljHZCMnbxB3nLk6xpE2zTPjM/UO1w=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=KbXpoxYsPlxfE46qNnQk5SGb+HvTzWVWWCcd5WvR37VTo5iYsT89WJjN+4kmNRj6tf6miGb/IXMeN2OKihXl4RXzXPrwLK1HauzRe+fBeKYpr7seig0ywe4+Y6Te4nlD61duKGRyaPbXIqbcc2hDBIq19P0G5Ox8JsXiF75RCbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XV5FHuQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3517CC4CEDF;
	Fri, 14 Feb 2025 11:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739531683;
	bh=h0lJOOGwOy62qvljHZCMnbxB3nLk6xpE2zTPjM/UO1w=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=XV5FHuQdQ0B7nQMrIe7Y79M/gwUi4zAyhVEyt4XTYBRf+mfTcjthp2jCGQjOK+FCt
	 IgK5QA5t+LxBB9BkoS7rd3/f6AwEZ0/IVkQSBSmPa7eiBHzYG6XwfHnZjKt0kxIECs
	 Qp1Vk6ytWLPFJgMGpGTn03MAWkG7Fv83peA6LXfNFucekrFae2uze/6aOKgSzUKgEL
	 6yt6IPH1CXlnVrrFvSZTQr4ohk5NaeDswAw8YMc02eS7BfWAZRoNanj0w3xCCk3mbR
	 VocRiWuGw4zxkXYBvvj+/6wdsNPVg+fYu5hIbp9Y4UZm9gd794Z/5zX67RI960twB1
	 BTx7pHY6au31w==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 171CB1200043;
	Fri, 14 Feb 2025 06:14:41 -0500 (EST)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-10.internal (MEProxy); Fri, 14 Feb 2025 06:14:41 -0500
X-ME-Sender: <xms:oCWvZ55JMyEB0-iKQan1E9T3MM_3JPKNsLvNG5kY504jtsGeaiUYNg>
    <xme:oCWvZ25omGA3WGMsS319f9OFrsCIETmuYk1Fscn0L4nBtM6nxd5zdUmWTCfa2E3b2
    4UKxhxjTMvr6e6-D18>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegleehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredt
    tdenucfhrhhomhepfdfnvghonhcutfhomhgrnhhovhhskhihfdcuoehlvghonheskhgvrh
    hnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeejvefflefgledvgfevvdetleehhfdv
    ffehgeffkeevleeiveefjeetieelueeuvdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehlvghonhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidquddvfedtheefleekgedqvdejjeeljeejvdekqdhlvghonheppehkvghrnh
    gvlhdrohhrgheslhgvohhnrdhnuhdpnhgspghrtghpthhtohepvdeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrhihushhhrdhsrgifrghlsegthhgvlhhsihhordgtoh
    hmpdhrtghpthhtohepsghhrghrrghtsegthhgvlhhsihhordgtohhmpdhrtghpthhtohep
    lhhouhhishdrphgvvghnshestghorhhighhinhgvrdgtohhmpdhrtghpthhtohepohhssh
    dqughrihhvvghrshestghorhhighhinhgvrdgtohhmpdhrtghpthhtohephhgvrhgsvghr
    thesghhonhguohhrrdgrphgrnhgrrdhorhhgrdgruhdprhgtphhtthhopegvughumhgrii
    gvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghnthhhohhnhidrlhdrnhhguhih
    vghnsehinhhtvghlrdgtohhmpdhrtghpthhtohepphhriigvmhihshhlrgifrdhkihhtsh
    iivghlsehinhhtvghlrdgtohhmpdhrtghpthhtohepjhhvsehjvhhoshgsuhhrghhhrdhn
    vght
X-ME-Proxy: <xmx:oCWvZwejf68vGpUuT6T7bTrCY5Ugkt3VDZeu_KYFa2RZHm6qvbbxrQ>
    <xmx:oSWvZyIgKAdrOLr1Z8BNvhcMTp1ABJldb16i1iHxLswvvRbOqOnHsQ>
    <xmx:oSWvZ9L-j3DB9bHYdkC0urq4nHzTOvPab5ahAM9w5DM1QZPwfYvc5A>
    <xmx:oSWvZ7zHvtJ8SfOYb8GbeCTLnkK9XIfnHMzeRa5-cPcyqDFWOBfr8Q>
    <xmx:oSWvZ5KEm76cXOh3dQwdghf4O5W92GjuCBf-3NT_mJr-ZJPPG59_1GGY>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DF44F1C20066; Fri, 14 Feb 2025 06:14:40 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Feb 2025 13:14:21 +0200
From: "Leon Romanovsky" <leon@kernel.org>
To: "Steffen Klassert" <steffen.klassert@secunet.com>
Cc: "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "Ayush Sawal" <ayush.sawal@chelsio.com>,
 "Bharat Bhushan" <bbhushan2@marvell.com>,
 "Eric Dumazet" <edumazet@google.com>, "Geetha sowjanya" <gakula@marvell.com>,
 hariprasad <hkelam@marvell.com>, "Herbert Xu" <herbert@gondor.apana.org.au>,
 intel-wired-lan@lists.osuosl.org, "Jakub Kicinski" <kuba@kernel.org>,
 "Jay Vosburgh" <jv@jvosburgh.net>, "Jonathan Corbet" <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
 "Louis Peens" <louis.peens@corigine.com>, netdev@vger.kernel.org,
 oss-drivers@corigine.com, "Paolo Abeni" <pabeni@redhat.com>,
 "Potnuri Bharat Teja" <bharat@chelsio.com>,
 "Przemek Kitszel" <przemyslaw.kitszel@intel.com>,
 "Saeed Mahameed" <saeedm@nvidia.com>,
 "Subbaraya Sundeep" <sbhatta@marvell.com>,
 "Sunil Goutham" <sgoutham@marvell.com>, "Tariq Toukan" <tariqt@nvidia.com>,
 "Tony Nguyen" <anthony.l.nguyen@intel.com>, "Ilia Lin" <ilia.lin@kernel.org>
Message-Id: <a2157143-4adc-4551-b910-d9d99e192487@app.fastmail.com>
In-Reply-To: <Z68M/4jka5FwrvLV@gauss3.secunet.de>
References: <cover.1738778580.git.leon@kernel.org>
 <dcadf7c144207017104657f85d512889a2d1a09e.1738778580.git.leon@kernel.org>
 <Z6yMgPSfPzgGHTkD@gauss3.secunet.de> <20250212183020.GJ17863@unreal>
 <Z68M/4jka5FwrvLV@gauss3.secunet.de>
Subject: Re: [PATCH ipsec-next 2/5] xfrm: simplify SA initialization routine
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Feb 14, 2025, at 11:29, Steffen Klassert wrote:
> On Wed, Feb 12, 2025 at 08:30:20PM +0200, Leon Romanovsky wrote:
>> On Wed, Feb 12, 2025 at 12:56:48PM +0100, Steffen Klassert wrote:
>> > On Wed, Feb 05, 2025 at 08:20:21PM +0200, Leon Romanovsky wrote:
>> > > From: Leon Romanovsky <leonro@nvidia.com>
>> > > 
>> > > SA replay mode is initialized differently for user-space and
>> > > kernel-space users, but the call to xfrm_init_replay() existed in
>> > > common path with boolean protection. That caused to situation where
>> > > we have two different function orders.
>> > > 
>> > > So let's rewrite the SA initialization flow to have same order for
>> > > both in-kernel and user-space callers.
>> > > 
>> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>> > > ---
>> > >  include/net/xfrm.h    |  3 +--
>> > >  net/xfrm/xfrm_state.c | 22 ++++++++++------------
>> > >  net/xfrm/xfrm_user.c  |  2 +-
>> > >  3 files changed, 12 insertions(+), 15 deletions(-)
>> > > 
>> > > diff --git a/include/net/xfrm.h b/include/net/xfrm.h
>> > > index 28355a5be5b9..58f8f7661ec4 100644
>> > > --- a/include/net/xfrm.h
>> > > +++ b/include/net/xfrm.h
>> > > @@ -1770,8 +1770,7 @@ void xfrm_spd_getinfo(struct net *net, struct xfrmk_spdinfo *si);
>> > >  u32 xfrm_replay_seqhi(struct xfrm_state *x, __be32 net_seq);
>> > >  int xfrm_init_replay(struct xfrm_state *x, struct netlink_ext_ack *extack);
>> > >  u32 xfrm_state_mtu(struct xfrm_state *x, int mtu);
>> > > -int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
>> > > -		      struct netlink_ext_ack *extack);
>> > > +int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack);
>> > >  int xfrm_init_state(struct xfrm_state *x);
>> > >  int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type);
>> > >  int xfrm_input_resume(struct sk_buff *skb, int nexthdr);
>> > > diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
>> > > index 568fe8df7741..42799b0946a3 100644
>> > > --- a/net/xfrm/xfrm_state.c
>> > > +++ b/net/xfrm/xfrm_state.c
>> > > @@ -3120,8 +3120,7 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
>> > >  }
>> > >  EXPORT_SYMBOL_GPL(xfrm_state_mtu);
>> > >  
>> > > -int __xfrm_init_state(struct xfrm_state *x, bool init_replay,
>> > > -		      struct netlink_ext_ack *extack)
>> > > +int __xfrm_init_state(struct xfrm_state *x, struct netlink_ext_ack *extack)
>> > 
>> > The whole point of having __xfrm_init_state was to
>> > sepatate codepaths that need init_replay and those
>> > who don't need it. That was a bandaid for something,
>> > unfortunately I don't remenber for what.
>> > 
>> > If we don't need that anymore, maybe we can merge
>> > __xfrm_init_state into xfrm_init_state, as it was
>> > before.
>> 
>> Main difference between __xfrm_init_state and xfrm_init_state is that
>> latter is called without extack, which doesn't exist in kernel path.
>
> That split happened ~ 15 years ago, we did not have extack back than.
> But I'm also ok with keeping it if extack is a reason for it.
>
> Do you plan to respin, or should I take the patchset as is?

The best way will be if you can take this series as is.

>
> Thanks!

