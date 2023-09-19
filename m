Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FE17A6551
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Sep 2023 15:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbjISNgk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Sep 2023 09:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjISNgk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Sep 2023 09:36:40 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E43FF9;
        Tue, 19 Sep 2023 06:36:34 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0A3D15C00A5;
        Tue, 19 Sep 2023 09:36:34 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Tue, 19 Sep 2023 09:36:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1695130594; x=1695216994; bh=G3Kkrzt0AGrrY/tjL0EyntUuI
        Bb8mCCGj+mtTnmx+Q8=; b=UnODe/CFFm/fKyGaSWbPPfJGyccMgh1Fl4ql7J8B2
        9jTTCbW7SBL9mmZVXktU9NHHOKE59vNmIt0/3PhYLyfB2ct9PpB2TtdW2GrTNk0N
        p54KxQZhj60LKixvUfYSDQa4v3EbvN8Xt+LCAGQGVQ26IZGNwzMCGuce3Gghezi+
        NDemRIJWikj5y3YJh93ZKtlx/6vlOGJnSRujwbi6RlScOarSzktohPxAwVVayDgE
        wc1G63LzMMrc7gbgXgfjjE3fjf+QuIdkFrVuooWiII9CtYxJ0KGYCqtctLBBxlXB
        a0MaGet4EcXXzcNEDj0hlAAITshodNu2ZUQSCM82e95IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1695130594; x=1695216994; bh=G3Kkrzt0AGrrY/tjL0EyntUuIBb8mCCGj+m
        tTnmx+Q8=; b=Ki98uDeNfz0jsUIT+QrBfvj6hR3UdAj0JGP0Kk0m3is6XGITVnc
        DitfO8Z+GtWWohKTB22DWPAWKANFWZvwpnHoOdj68y6C4Z7ADQwwOPv0cl9n2b+x
        ySjituYs4vc8wTr6657lSCf6nuZlPaevwRT+ZlC5EloYB2OJvQKrFkiBrlsDjKms
        R/4JDdefME8w8YDPy5+wnxG2+Fya9/liDAL5qCMMKpXum+43+FmCAvT5DhfpQlfI
        HT3jt59lJiwFge+hvLDqbVFgQ4bt7cNR/bPeevGW7CpYG9z9TksRHzzWy5ZpkhSc
        +qvxWapAs7q7hQNor2DKBFbtWnh42FwH2mg==
X-ME-Sender: <xms:4KMJZbW9LbqWPcHkGh_DlPuxCBkGLtv3JnsYlVzXjKzSIeeti7RIhg>
    <xme:4KMJZTmAvH4L7z_nGaP5KdfIvqOZiks__CHr-LlmDmPx7zd2plYewMvSEyaWyUHFk
    jKbOhCbS2QMQUW6WgU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekuddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfu
    vhgvnhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtf
    frrghtthgvrhhnpeevhedthffgffelhedujefgueduudeutdefleevvdetudelhfeihfdv
    ffelteeuudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:4KMJZXYmYuvL3nH0_SgD_kNdsC7XHLClfVBAmruidR-V60B6y3P-MQ>
    <xmx:4KMJZWXQA3WzRBb5zCu-QYvcA4iZm-q-O5n5rA4kxuHe43SgaGHuSg>
    <xmx:4KMJZVk9Oi99N4mk7qm3lIUI4afyU90X7PI_XuVzNp7f82_pACbMKw>
    <xmx:4qMJZdNsFBGmk6guzMsje_BoEdpEh-d6HrZzup8N865hs4SPZgsPDA>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 0378AA60077; Tue, 19 Sep 2023 09:36:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-761-gece9e40c48-fm-20230913.001-gece9e40c
MIME-Version: 1.0
Message-Id: <aabaa49f-8988-42c0-bf8e-2266005e2155@app.fastmail.com>
In-Reply-To: <20230918131103.24119-7-ilpo.jarvinen@linux.intel.com>
References: <20230918131103.24119-1-ilpo.jarvinen@linux.intel.com>
 <20230918131103.24119-7-ilpo.jarvinen@linux.intel.com>
Date:   Tue, 19 Sep 2023 15:36:10 +0200
From:   "Sven Peter" <sven@svenpeter.dev>
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-pci@vger.kernel.org, "Bjorn Helgaas" <helgaas@kernel.org>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Rob Herring" <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        "Lukas Wunner" <lukas@wunner.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Heiner Kallweit" <hkallweit1@gmail.com>,
        "Emmanuel Grumbach" <emmanuel.grumbach@intel.com>,
        linux-kernel@vger.kernel.org, "Hector Martin" <marcan@marcan.st>,
        "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Marcel Holtmann" <marcel@holtmann.org>,
        "Johan Hedberg" <johan.hedberg@gmail.com>,
        "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org
Cc:     ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, intel-wired-lan@lists.osuosl.org,
        linux-mediatek@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 06/13] Bluetooth: hci_bcm4377: Convert aspm disable to quirk
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

On Mon, Sep 18, 2023, at 15:10, Ilpo J=C3=A4rvinen wrote:
> pci_disable_link_state() was made reliable regardless of ASPM CONFIG
> and OS being disallowed to change ASPM states to allow drivers to rely
> on pci_disable_link_state() working.
>
> Remove driver working around unreliable pci_disable_link_state() from
> hci_bcm4377 driver and add a PCI quirk to disable ASPM.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---

Acked-by: Sven Peter <sven@svenpeter.dev>


Thanks,

Sven
