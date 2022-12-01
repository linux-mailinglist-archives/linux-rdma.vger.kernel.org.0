Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD2963EC72
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Dec 2022 10:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiLAJ27 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Dec 2022 04:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiLAJ2m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 1 Dec 2022 04:28:42 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF564E6AA;
        Thu,  1 Dec 2022 01:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=bjlickyhTxl1d4xNXaIojFEZJXJX16jZsh7QD+vtX3U=;
        t=1669886917; x=1671096517; b=H70JLGWe23zI+csp8meWrufCUQcW9fOV41R/rgU67xvw1J/
        jTSIPuiCeR80Z8R87AabqGMZkpe9nTAzkZmNiyjMK2naf5BWH3zabnZQvCfF+dusBeKMfpda+mGKZ
        55dAlJTbaVlpYSqyGIKQNQWTChItTwV9dlfDpsqhhch1fPyi+T5BZSfqVkaJjLAOD+B3ZcyQHPsN4
        D6b66PR5NgWhXluluF4/qI2cqLPZOFYgpBA7n2S5FNJjnaTs4VWKoF3rfok8b8LAAMK78ub2jKGMI
        ynYx6pMadLixySw/KYYR41H85YV3LpPK5ZRJ4BlHmsMg8gJvj6QN4NDy//3mMg6w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1p0fre-00E0NW-3D;
        Thu, 01 Dec 2022 10:28:19 +0100
Message-ID: <9fdd6581efb75511f3259ca663cd1afaee4ae4ac.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2 v2] IB/qib: don't use qib_wc_x86_64 for UML
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Leon Romanovsky <leon@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org
Date:   Thu, 01 Dec 2022 10:28:18 +0100
In-Reply-To: <Y4hyPPzyQiI3i9jh@unreal>
References: <20221130200945.24459-1-rdunlap@infradead.org>
         <Y4hyPPzyQiI3i9jh@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, 2022-12-01 at 11:22 +0200, Leon Romanovsky wrote:
>=20
> > +++ b/drivers/infiniband/hw/qib/Kconfig
> > @@ -3,6 +3,7 @@ config INFINIBAND_QIB
> >  	tristate "Intel PCIe HCA support"
> >  	depends on 64BIT && INFINIBAND_RDMAVT
> >  	depends on PCI
> > +	depends on !UML
>=20
> I would advocate to add this line to whole drivers/infiniband.
> None of RDMA code makes sense for UML.
>=20

You could argue that one might want to eventually use kunit for some
bits and pieces in there, so it'd make sense to be able to build the
parts that _can_ be built, but I have no idea :)

johannes
