Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E9765DC4F
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Jan 2023 19:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234992AbjADSnD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Jan 2023 13:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbjADSnC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 4 Jan 2023 13:43:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483EF1C13F
        for <linux-rdma@vger.kernel.org>; Wed,  4 Jan 2023 10:43:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AEEAB8172B
        for <linux-rdma@vger.kernel.org>; Wed,  4 Jan 2023 18:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55537C433D2;
        Wed,  4 Jan 2023 18:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672857777;
        bh=gIvYeAGmZOEjKU/3vHXdIC2u+kuOyG0AyUMRyAXiU6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gbkhLEjPSNYZDyGhWcFCuInlnMTtiOZPJdgqUJIeWEfyY93pW9WH8w7+raSvMBOD0
         ypgaPGokaZa2aUiPv7cnC0yeCWBLv64tgLrExu8pNJg830/azTFK+UthFHBcZGmqhj
         KNJnVdPBHkc5mZc8UmtCGVG9xWlI7jcGxbGxoAtKAIyunF5pQYurUXW6h96dYa72oE
         sAjCFYggeRPuJ20tVHuscRH5VBND8fmRy5ckZ0yUwahr8nHTXhOC0tDvL27oWnhRVy
         T9+CNgp5R1ZqUk3UGHum1qhiiONryewciLPaLh45eSNWBuF/5lX11giH7OVcVvCfJi
         DQkb14wkNBTzQ==
Date:   Wed, 4 Jan 2023 20:42:53 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Mark Haywood <mark.haywood@oracle.com>, linux-rdma@vger.kernel.org
Subject: Re: buildlib/pandoc-prebuilt
Message-ID: <Y7XIrX1E78KyfWud@unreal>
References: <4c29b8d8-c4c8-a7ae-e1f9-ddce3b55d961@oracle.com>
 <Y7TF8EK/PXiwKRwU@ziepe.ca>
 <612e156e-d8c7-ee17-430d-9d6d85427a3f@oracle.com>
 <Y7W3dASpXM7/br4i@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y7W3dASpXM7/br4i@ziepe.ca>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 04, 2023 at 01:29:24PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 04, 2023 at 11:05:53AM -0500, Mark Haywood wrote:
> > 
> > 
> > On 1/3/23 7:18 PM, Jason Gunthorpe wrote:
> > > On Tue, Jan 03, 2023 at 06:04:21PM -0500, Mark Haywood wrote:
> > > > I just extracted https://github.com/linux-rdma/rdma-core/releases/download/v44.0/rdma-core-44.0.tar.gz
> > > > and noticed that buildlib/pandoc-prebuilt does not exist in v44.0. Is that
> > > > intentional?
> > > ?
> > > 
> > > It looks OK:
> > > 
> > > $ wget https://github.com/linux-rdma/rdma-core/releases/download/v44.0/rdma-core-44.0.tar.gz
> > > $ tar -tzf rdma-core-44.0.tar.gz  | grep -i /pandoc-prebuilt/
> > > rdma-core-44.0/buildlib/pandoc-prebuilt/
> > > rdma-core-44.0/buildlib/pandoc-prebuilt/caaca7667f40fff2095c23c0f40c925f1ff3edea
> > > rdma-core-44.0/buildlib/pandoc-prebuilt/e2cfc53feeefa2927ad8741ae5964165b27d6aee
> > > rdma-core-44.0/buildlib/pandoc-prebuilt/971674ea9c99ebc02210ea2412f59a09a2432784
> > > rdma-core-44.0/buildlib/pandoc-prebuilt/241312b7f23c00b7c2e6311643a22e00e6eedaac
> > > [..]
> > 
> > I can't explain it. The one I pulled yesterday doesn't have them:
> > 
> > $ tar -tzf rdma-core-44.0.tar.gz.orig  | grep -i /pandoc-prebuilt
> > rdma-core-44.0/buildlib/pandoc-prebuilt.py
> > 
> > The one today does:
> > 
> > $ tar -tzf rdma-core-44.0.tar.gz  | grep -i /pandoc-prebuilt | less
> > rdma-core-44.0/buildlib/pandoc-prebuilt.py
> > rdma-core-44.0/buildlib/pandoc-prebuilt/
> > rdma-core-44.0/buildlib/pandoc-prebuilt/caaca7667f40fff2095c23c0f40c925f1ff3edea
> > rdma-core-44.0/buildlib/pandoc-prebuilt/e2cfc53feeefa2927ad8741ae5964165b27d6aee
> > [..]
> > 
> > I am sure it was user error on may part, though I don't see how. Regardless,
> > it's fine now, thanks.
> 
> There is a second link:
> 
> https://github.com/linux-rdma/rdma-core/archive/refs/tags/v44.0.tar.gz
> 
> That does not include the pandoc, perhaps you downloaded it by
> mistake?
> 
> I don't think the releae tar file changed at least, it is generated by
> a script

Right, I didn't change and/or force push anything after initial release.

Thanks

> 
> Jason
