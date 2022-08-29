Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132A95A44D4
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Aug 2022 10:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbiH2IRL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Aug 2022 04:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiH2IRK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Aug 2022 04:17:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC9A53D30
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 01:17:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 288C6B80D66
        for <linux-rdma@vger.kernel.org>; Mon, 29 Aug 2022 08:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70123C433D7;
        Mon, 29 Aug 2022 08:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661761027;
        bh=MMDYjFxHdp/Tw/I8otwLVIG1qjdqp8t2Ly2tXVBVELA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qfd4cmjNz+BO44bwI28HTLWLbcVwofKHLTLtr9ONygfXgzSVyjzxZmqCNCi87rX/N
         6VGxzkIlx6bCaOILWCoMkpgdNC67IPzUIFMh2ZTgorw2KvrAV8TtzHVuqKnfeLOl2S
         U7WQYZnQUSEMFVQdxcTLT5ct/HoVXdKs2OBr989lHK7QFJenZT14Wht3k4xockFjAA
         /ONDpIUiIsSD0pLa1LSB0ULzdpzBVb4q7YqT+Bkt413lJWg1Cpf0laQv97wUM8ipl4
         empN7oIsugA6BlXD2PiLKKIof8jRGfrTuGMmT1sFJMCOPE14wdlJg1iOUtwfn4daVL
         QikheDcPhl7xg==
Date:   Mon, 29 Aug 2022 11:17:02 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Michael Guralnik <michaelgur@nvidia.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/cma: Fix arguments order in net device
 validation
Message-ID: <Ywx1/uZZUXrtgxOI@unreal>
References: <1c1ec2277a131d277ebcceec987fd338d35b775f.1661251872.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c1ec2277a131d277ebcceec987fd338d35b775f.1661251872.git.leonro@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 23, 2022 at 01:51:50PM +0300, Leon Romanovsky wrote:
> From: Michael Guralnik <michaelgur@nvidia.com>
> 
> Fix the order of source and destination addresses when resolving the
> route between server and client to validate use of correct net device.
> 
> The reverse order we had so far didn't actually validate the net device
> as the server would try to resolve the route to itself, thus always
> getting the server's net device.
> 
> The issue was discovered when running cm applications on a single host
> between 2 interfaces with same subnet and source based routing rules.
> When resolving the reverse route the source based route rules were
> ignored.
> 
> Fixes: f887f2ac87c2 ("IB/cma: Validate routing of incoming requests")
> Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/cma.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Thanks, applied.
