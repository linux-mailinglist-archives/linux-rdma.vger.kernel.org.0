Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C7054DB3A
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jun 2022 09:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiFPHIN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jun 2022 03:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiFPHIK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jun 2022 03:08:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4655B19002
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jun 2022 00:08:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8AD5FB8216D
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jun 2022 07:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F3EC34114;
        Thu, 16 Jun 2022 07:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655363287;
        bh=ZccexE78LG+M6b/8Pi4xdgMTTzv31B8v3rU22TzTpAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MuBW48zH2JvvT4eCO59s5D3WZFN/w3iLXVZL+atUqmrUj4T5PfhDp6O/kvUZQwoLy
         GPfAmDLL62vsVSqE6unJUEMqd1OJ0TkWbahOCRCpvM6HRiWlpbiGqkp2+FT/S1s2OK
         AUTi6389e8rAMhaYOU4Z37EcuvIT2SKjX6DkGkDd9LQ3u2AOeHSZFXiVDZGaXv/qyQ
         yTt7qldSMw2F68BrkBaQ6VPfDDj/5g+bkI5mh7Z96JOSGWuiZ8fFvPQP+5V8QxwteQ
         wLr0qlpNOiX6UEbO87Q+pEkBSuinlOQcrrC1lfqYmuAiFoDL44HzqXe9Ffyh5z1eu0
         EGLwvZaGfQN3A==
Date:   Thu, 16 Jun 2022 10:08:02 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gerd Rausch <gerd.rausch@oracle.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/addr: Refresh neighbour entries upon
 "rdma_resolve_addr"
Message-ID: <YqrW0s7FII1FoBwb@unreal>
References: <eb4e348ec730900a47caeeb08fe4aff903337675.camel@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb4e348ec730900a47caeeb08fe4aff903337675.camel@oracle.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 06, 2022 at 12:38:36PM -0700, Gerd Rausch wrote:
> Unlike with IPv[46], where "ip_finish_output2" triggers
> a refresh of STALE neighbour entries via "neigh_output",
> "rdma_resolve_addr" never triggers an update.
> 
> If a wrong STALE entry ever enters the cache, it'll remain
> wrong forever (unless refreshed via TCP/IP, or otherwise).
> 
> Let the cache inconsistency resolve itself by triggering
> an update from "rdma_resolve_addr".
> 
> Signed-off-by: Gerd Rausch <gerd.rausch@oracle.com>
> ---
>  drivers/infiniband/core/addr.c | 40 ++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)

Gerd,

Do you plan to resubmit the patch?
There is a complain from kbuild robot.

Thanks
