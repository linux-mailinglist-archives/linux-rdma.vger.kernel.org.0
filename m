Return-Path: <linux-rdma+bounces-565-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC83F8278AD
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 20:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3761C21996
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Jan 2024 19:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401FA4654D;
	Mon,  8 Jan 2024 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p22Nqa9y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FF85380C
	for <linux-rdma@vger.kernel.org>; Mon,  8 Jan 2024 19:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31BB6C433C8;
	Mon,  8 Jan 2024 19:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704742854;
	bh=GhxE1WtDxZkyl6AMk7xTdjaqGlFz+nswJmyroXe8l6U=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=p22Nqa9ynx3xb+sixWeV1Oc6zW4QNm2UiZ5sfurhZLgpGekSGrGpSBBzjKJZimrQF
	 FaG70sjoGhQqjBctsqBOQpF0x53ZbjRnLRYRSx5TRF8TqWkhcePHRuauJ3gd/ahEuf
	 FROkhStqo1/eK7uo1sDv0wJcLc5FYZuthUrit18lsi1tQv3M9tYlGPMyESzqKe1f8I
	 DFCWsDZToHwgXtwdvY+7+FimLegPXvv76ap54YUwa8K5j9LE0KEBEr0Qx5vZ1SMEYL
	 l1ZkvRPunc5oksJCd5OdgU/STAlsmpvv8XLukrszRY8NkMkRHbJaTV+j6wYgL9fQw8
	 YtQ6MkBL89Gqg==
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailauth.nyi.internal (Postfix) with ESMTP id 1594D27C005A;
	Mon,  8 Jan 2024 14:40:53 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute4.internal (MEProxy); Mon, 08 Jan 2024 14:40:53 -0500
X-ME-Sender: <xms:xE-cZWGGMfrf8q6pUyWFFKHQhKMTTdiHdwrmyrX6LeLUuvmOM3IMcQ>
    <xme:xE-cZXV5M01C4rq0aCfxjSPcQVSOkDGso-rWzcXKuGClaOTyGtDU_nIGBo17jHsgc
    9oTNiPXtG6mYAj_ppo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdehjedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfn
    vghonhcutfhomhgrnhhovhhskhihfdcuoehlvghonheskhgvrhhnvghlrdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeegjeevleeijefhffejgedvhfeufedvtddvvddvhfelteejteel
    geeifedvgfevgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehlvghonhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvfedt
    heefleekgedqvdejjeeljeejvdekqdhlvghonheppehkvghrnhgvlhdrohhrgheslhgvoh
    hnrdhnuh
X-ME-Proxy: <xmx:xE-cZQItRoOu1E2a0GXlYVZ4Z0MrPqkmsKkBgiVSGZFOaBbYbmPiZA>
    <xmx:xE-cZQFiDHDu9TDwEsoXhKDDOGl4SjGWgLZJrXgrk8fq4I4pt1JO7w>
    <xmx:xE-cZcVkgkifxyh5sqnmwQRF2M2GNjXLRjFMdDMZ2wW8Xhbzi6ao8w>
    <xmx:xU-cZWcDzyO7YY3w6M_ouZqKnI6fpHOnqqDB0GobeajcCLD82iRcTg>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C9C181703E08; Mon,  8 Jan 2024 14:40:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <86765443-4292-44b4-824e-d2ea5ebebc18@app.fastmail.com>
In-Reply-To: <20240108180636.GM50406@nvidia.com>
References: <20240104095155.10676-1-mrgolin@amazon.com>
 <20240107100256.GA12803@unreal> <20240108130554.GF50406@nvidia.com>
 <20240108180140.GB12803@unreal> <20240108180636.GM50406@nvidia.com>
Date: Mon, 08 Jan 2024 21:40:32 +0200
From: "Leon Romanovsky" <leon@kernel.org>
To: "Jason Gunthorpe" <jgg@nvidia.com>
Cc: "Margolin, Michael" <mrgolin@amazon.com>, linux-rdma@vger.kernel.org,
 sleybo@amazon.com, matua@amazon.com, gal.pressman@linux.dev,
 "Anas Mousa" <anasmous@amazon.com>, "Firas Jahjah" <firasj@amazon.com>
Subject: Re: [PATCH for-next v4] RDMA/efa: Add EFA query MR support
Content-Type: text/plain



On Mon, Jan 8, 2024, at 20:06, Jason Gunthorpe wrote:
> On Mon, Jan 08, 2024 at 08:01:40PM +0200, Leon Romanovsky wrote:
>> > I was saying in the rdma-core PR that this field shouldn't even
>> > exist..
>> 
>> Something like that?
>
> Yeah, like that. However it is difficult to get the out valid uattr
> back in the rdma-core side.
>
> This is best if the ID's can have well defined not-valid values such
> as 0 or -1.

Michael tried something like that in previous versions by defining 0xffff as not valid.

I didn't like it because there's no promise from PCI core that it is invalid value.



>
> Jason

