Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3198739F69
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Jun 2023 13:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjFVL2s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Jun 2023 07:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjFVL2r (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 22 Jun 2023 07:28:47 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446B919A9;
        Thu, 22 Jun 2023 04:28:46 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id AA9415C00C9;
        Thu, 22 Jun 2023 07:28:45 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Thu, 22 Jun 2023 07:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1687433325; x=1687519725; bh=VQ
        b5HqyYhYn4AL2jVh9Pn6Gc88Ux8RWGJJ1CyS/IapY=; b=Tek+suiEQ9ZBzcqjUm
        V8S7vH6WVaK8nf1rxA85R+4BmTGkbJU89n1NZW1ME2PpMZ0ZnPWdxv4wbczIT3nr
        R5d0bwFVuwTf6OS2xiFtkKOxE4qviWmotownu5eUAOzxWxqcK9ncZJX6mFM+Abxz
        cVGxHwSCqi55K9ws7OKmSYulj7SS+dk50+dEwhc7xVjr0PESRswQkXWeI6pHVpHn
        ZNhTqbOP4LRStM6cqcSMK1mat134Owpkb3XIVCyHvB/XYb9kiRdiBif926S3suE7
        iEwggYNce6x4gb9lG3Wc4C41LXyYc6YtwzAeLtRwmzE2tP7KEbRBD6BXZwfMgwm2
        jUzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687433325; x=1687519725; bh=VQb5HqyYhYn4A
        L2jVh9Pn6Gc88Ux8RWGJJ1CyS/IapY=; b=C6NqYb+TRTAdq+Db9zHXNiABHSPNl
        lF/pTUmF3pGyRps7r1kuQ3KDtHx5yQUveHXICn4fCtMt2rB1nwNsRQPT0r+LFzKo
        tGSiMyjw05OJ7Pr/ZF/ObaeC3qyMjrWJRRl9JRD36LxwotK84nUC5D2hzMYVla5i
        fF9XHcBB+oEYs09JIZbXOtlj9rQVT4YWgg/PlpgVf3lvTii9PtEGZFJ65IyBVKlS
        633fEOqrAd2yJYAa2JhWVhIHgdFVJfsTLkeZ4vFdumKvqoSgRcyCjdt7F4ZrY9qa
        hqkTFTCZwmIVTMihLqN0t/4STe9alt65EAciC4cIjc9T/fhq2nAY09A3Q==
X-ME-Sender: <xms:bTCUZA5-hOQumNAavy2nD90BOy6rlYTuTwuhEnFtJqH3O1hz8NnEEA>
    <xme:bTCUZB5ciPb-9OijI-RNTuvl9SXHLOd9dLPF-oAChPM2bLHzA-0rqYJUZZuOBxHRL
    lDc_4PjFzULqmxBCLc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeguddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:bTCUZPeE2mEvXn_m0OT0lbYiIrYgBYM4uPw0jdUuw77eqhIH3fOgnA>
    <xmx:bTCUZFLzFwi41CXBmgosGA0-zqVUiO2eS_Sy_oRjIGI3wdSLOLyLuA>
    <xmx:bTCUZEIKqp5iEy4aCjLZ2vzex9irEhtS7e4q8_Bkq3eXFXdEUXSSmw>
    <xmx:bTCUZGhVMthvzUNrrvsmzNJn6UT_t4q1kf6UtkiIa6vhorY50ex-_A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6BE07B60086; Thu, 22 Jun 2023 07:28:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <a7b27541-0ebb-4f2d-bd06-270a4d404613@app.fastmail.com>
In-Reply-To: <ZJQvJZxZkYfqGAJu@mail.gmail.com>
References: <20230622101525.3321642-1-arnd@kernel.org>
 <ZJQvJZxZkYfqGAJu@mail.gmail.com>
Date:   Thu, 22 Jun 2023 13:28:25 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Maxim Mikityanskiy" <maxtram95@gmail.com>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Saeed Mahameed" <saeedm@nvidia.com>,
        "Leon Romanovsky" <leon@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Tom Rix" <trix@redhat.com>, "Tariq Toukan" <tariqt@nvidia.com>,
        "Adham Faris" <afaris@nvidia.com>, Netdev <netdev@vger.kernel.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] mlx5: avoid integer overflow warning for large page size
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 22, 2023, at 13:23, Maxim Mikityanskiy wrote:
> On Thu, 22 Jun 2023 at 12:15:02 +0200, Arnd Bergmann wrote:
>
> I recall you already sent a fix to silence this warning before:
>
> https://lore.kernel.org/netdev/20211015152056.2434853-1-arnd@kernel.org/
>
> I prefer that old one, as it's more future-proof to cast to size_t here
> in place (chunk_size won't be bigger than size_t for sure). With your
> new patch, if chunk_size is ever changed from u16 to u32, it's likely
> that this place will be unnoticed, and a bug will be introduced.
>
>>  		mlx5_core_err(mdev, "XSK chunk size %u out of bounds [%u, %lu]\n", xsk->chunk_size,
>>  			      MLX5E_MIN_XSK_CHUNK_SIZE, PAGE_SIZE);

Indeed, I don't know why I no longer had the old patch in my randconfig
tree, I completely forgot about that. The old patch is also ok.

   Arnd
