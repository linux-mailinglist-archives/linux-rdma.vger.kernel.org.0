Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBCC77A5FB
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Aug 2023 12:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjHMKdJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 13 Aug 2023 06:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHMKdI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 13 Aug 2023 06:33:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0A9D7
        for <linux-rdma@vger.kernel.org>; Sun, 13 Aug 2023 03:33:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67BC061923
        for <linux-rdma@vger.kernel.org>; Sun, 13 Aug 2023 10:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44154C433C7;
        Sun, 13 Aug 2023 10:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691922789;
        bh=7JKex361aQglam53iWmFv6NaAQey+ZZg8L+aHspOMrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dEEg8HNaZYcK+NoUkGsLY/SEHeTRDnXE2YuGTMKHlOIGhy93IDrWci/sVOa4s2mRz
         WYVPUzdoTDQju0Bk5Lz79Q8EFLvwoDzuX6/Qf5vJbuWMjzcjYterFXQmMrLNlguM6y
         asXnPHS4Wvl3vs8ujjKlh6OPQ7E+o5xcK88pdWgVearUfnEJnKcQiOvH+TQuK05gnt
         iYGruscHHQpGZixi8V+/kQODNKTS5xXpU1mlLbCWFyvdfnGL1vRO2Hd+8R1UEnlCK+
         eq3nspp6i3TcaQEocE13tjYwwO4yYRwNDmH1mq0cyaUe8UK3i/0TxZyi1db/QN2fEF
         O0WWSI4hRJsdw==
Date:   Sun, 13 Aug 2023 13:33:05 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     "St Savage, Shane" <Shane@axiomdatascience.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: infiniband-diags can't be installed in Fedora CoreOS due to perl
 dependency
Message-ID: <20230813103305.GJ7707@unreal>
References: <MW5PR07MB93324BACD6F70B9679E996F9D211A@MW5PR07MB9332.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR07MB93324BACD6F70B9679E996F9D211A@MW5PR07MB9332.namprd07.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Aug 12, 2023 at 04:40:57PM +0000, St Savage, Shane wrote:
> Hi all,
> 
> Just wanted to report that infiniband-diags cannot currently be installed in Fedora CoreOS because the perl dependency is explicitly forbidden.
> 
> https://github.com/coreos/fedora-coreos-config/blob/testing-devel/manifests/fedora-coreos.yaml#L170
> 
> This is a bit unfortunate because it also prevents usage of all the non-perl utilities (ibstat, etc) included in infiniband-diags.
> 
> Would it make sense to split the perl utilities to a separate package infiniband-diags-perl so that the C and shell utilities in infiniband-diags can be installed without the perl dependency?

I suggest to remove perl dependency from rdma--core.spec and install
perl-dependant scripts only if perl is found on the system.

Thanks

> 
> Thank you,
> Shane St Savage
