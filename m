Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 685CE77BFAF
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Aug 2023 20:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjHNSVM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Aug 2023 14:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjHNSUp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 14 Aug 2023 14:20:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF42B0
        for <linux-rdma@vger.kernel.org>; Mon, 14 Aug 2023 11:20:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCDFF6190C
        for <linux-rdma@vger.kernel.org>; Mon, 14 Aug 2023 18:20:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B654EC433C8;
        Mon, 14 Aug 2023 18:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692037243;
        bh=66QSRvo4/Fs+bdPoHQGpjVvA6BCVK2CtdL5WMJ06eB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iT3K6n4q9gytNroyu2h2VpiczIsoNGH6UJOTDr2j3l3lWqS81PWypeOKUBtXXZXf3
         7PzknPTAiDc1MbbJWjnYBFTvWvJWNt+TUZKVPJ+8c6Vwu4tGycKznAXcfBvabNUc8O
         5QdrUNcELLMX3VpdfzndUeLNyvoReuyuN4V+vbDOXFCObC322FKt22YhF7oVtHeArE
         k1FayLRGsz0+/hojdrmcLjFBOFRFU4CLzcjWiRCt5g187AHosDTl3B5JSQGQq9efh0
         0URz/HP70mv17BRU9qznG6TPTbLaNW2FN5OLYNBVHG2De74q7bDLEl1dlNfqR8gF5q
         QQgFftqS2YsJQ==
Date:   Mon, 14 Aug 2023 21:20:38 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     "St Savage, Shane" <Shane@axiomdatascience.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: infiniband-diags can't be installed in Fedora CoreOS due to perl
 dependency
Message-ID: <20230814182038.GA22185@unreal>
References: <MW5PR07MB93324BACD6F70B9679E996F9D211A@MW5PR07MB9332.namprd07.prod.outlook.com>
 <20230813103305.GJ7707@unreal>
 <ZNpJCGSi7Ei1IN0A@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNpJCGSi7Ei1IN0A@ziepe.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 14, 2023 at 12:32:24PM -0300, Jason Gunthorpe wrote:
> On Sun, Aug 13, 2023 at 01:33:05PM +0300, Leon Romanovsky wrote:
> > On Sat, Aug 12, 2023 at 04:40:57PM +0000, St Savage, Shane wrote:
> > > Hi all,
> > > 
> > > Just wanted to report that infiniband-diags cannot currently be installed in Fedora CoreOS because the perl dependency is explicitly forbidden.
> > > 
> > > https://github.com/coreos/fedora-coreos-config/blob/testing-devel/manifests/fedora-coreos.yaml#L170
> > > 
> > > This is a bit unfortunate because it also prevents usage of all the non-perl utilities (ibstat, etc) included in infiniband-diags.
> > > 
> > > Would it make sense to split the perl utilities to a separate package infiniband-diags-perl so that the C and shell utilities in infiniband-diags can be installed without the perl dependency?
> > 
> > I suggest to remove perl dependency from rdma--core.spec and install
> > perl-dependant scripts only if perl is found on the system.
> 
> That is not how packaging is supposed to work
> 
> Everything should be installed always

Isn't how we use some packages in pyverbs?

Thanks

> 
> This is really a Fedora question, we just follow what they
> decide. Most likely the right answer is to put this kind of stuff in a
> container and not run on the minimal coreos image.
> 
> Jason
