Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491EB493F9C
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 19:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356630AbiASSEi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jan 2022 13:04:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34182 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356639AbiASSEh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jan 2022 13:04:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A93FAB81996
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jan 2022 18:04:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5630C004E1;
        Wed, 19 Jan 2022 18:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642615475;
        bh=pGOJhlvoYLpFa6JEwws7OPfShSAlejH8eRQwICB8lB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XbJJ9bwygQGr5KVGzqKWDjJYq3mB1Qv7jBSWpPGrFY1GsFrXbW4JKzWZffUTNTlr4
         KM7HH1GLSqcA0NPsnhPp90mlGw3DKzASvbNp+9qNIM01CB5A0Ty4PVcODOrbji5SsH
         8z+qA+cXDKxzemoL0q3yO3vj7UiIUX3zPPDSBJnhgaZGc1cOgrro66vo+gwkouPG1L
         2tu/vSVJduH0gQvhKqKT3+x1Ff1CP9OQGQLOhNxm5hbQbrhitAmTwvzvcxSvcBGPc8
         CNHMFAP/teWD8x/T/yD2nIVk5fKU86wdxroB3OI5bBlmUjsjDzk4bfMQNThd5vDmxv
         trehARsn38o5Q==
Date:   Wed, 19 Jan 2022 20:04:30 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Christian Blume <chr.blume@gmail.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: SoftRoCE and OpenSM
Message-ID: <YehSriRd1xjHTF2O@unreal>
References: <CAGP7Hd4atpB0J-PP-AC6peiUaD=Y75Fdue9Ab7AS8nkQPwdXvQ@mail.gmail.com>
 <YefRGdQHkjnzOxuh@unreal>
 <A78C931D-4286-45EC-9F82-818FA7967127@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A78C931D-4286-45EC-9F82-818FA7967127@redhat.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 19, 2022 at 12:28:30PM -0500, Doug Ledford wrote:
> On Jan 19, 2022, at 3:51 AM, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > On Wed, Jan 19, 2022 at 01:41:30PM +1300, Christian Blume wrote:
> >> Hello!
> >> 
> >> Is it at all possible for a SoftRoCE node to talk to OpenSM? Can I set
> >> up OpenSM in such a way that it automatically discovers all SoftRoCE
> >> nodes on my subnet? Thanks for your help.
> > 
> > AFAICT, RXE lacks MAD support which is needed for OpenSM.
> 
> 
> All Ethernet based RDMA technologies lack MAD support required for OpenSM.  OpenSM is a uniquely InfiniBand only thing.

Ahh, sorry, completely forgot about that.

> 
> > Thanks
> > 
> >> 
> >> Cheers,
> >> Christian
> > 
> 
