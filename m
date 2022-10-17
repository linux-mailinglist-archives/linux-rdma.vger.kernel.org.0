Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EAE600C55
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Oct 2022 12:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiJQKXq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 Oct 2022 06:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiJQKXk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 17 Oct 2022 06:23:40 -0400
X-Greylist: delayed 584 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Oct 2022 03:23:33 PDT
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7142A5FDEA
        for <linux-rdma@vger.kernel.org>; Mon, 17 Oct 2022 03:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1666001626; bh=NY9rf6paNISn5kMidu1OhpVWhjAGFOWYGQqvZKS/94M=;
        h=Date:From:cc:Subject:In-Reply-To:References:From;
        b=IC9guSCnvizkb1Pf+TknmfljwWtuGDqHI8vPLA7yBPgFV50sEZm49c2PaetbsYzkD
         aOxvm0miLq8MGS/gzb08TbnlcdWMpnJe7mpgIuSjmzMMtXhgOpXXaKVtqyooBhlwjC
         6ELIyHsb7DX3vMw9DEJnWgeK6w9miPfx+mtjIvcgYSGqjaMYjvtAWqVblOp08Pvtfb
         6SdFuhd1oIn+oZH8pu3nEnhmcf5u2i6oViLo+aUtH82uDz0M1B3lkzE6n1AHmmlQcf
         HIsT77e7HIajTxnpR/1hTgLuO7uptnwmxvFBFcXsLB1gLveWuSPjQjmPJQdb/e0elm
         7ICZSOfVdnTDA==
Received: by gentwo.de (Postfix, from userid 1001)
        id A3DDDB002ED; Mon, 17 Oct 2022 12:13:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 9CC9AB00116;
        Mon, 17 Oct 2022 12:13:46 +0200 (CEST)
Date:   Mon, 17 Oct 2022 12:13:46 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
cc:     rug@usm.lmu.de, linux-rdma@vger.kernel.org
Subject: Re: Infiniband crash
In-Reply-To: <Y0m2z+d3T/fnRW/Z@ziepe.ca>
Message-ID: <303b612-34ba-7ca2-f49e-c2a7dae7c6b@gentwo.de>
References: <20221014181651.Horde.p1jZxomAX1Dlqme6qIvYwJa@www.usm.uni-muenchen.de> <Y0m2z+d3T/fnRW/Z@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_05,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MISSING_HEADERS,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, 14 Oct 2022, Jason Gunthorpe wrote:

> On Fri, Oct 14, 2022 at 06:16:51PM +0000, rug@usm.lmu.de wrote:
> > Hi to whom it may concern,
> >
> > We are getting on a 6.0.0 (and also on 5.10 up) the following Mellanox
> > infiniband problem (see below).
> > Can you please help (this is on a running ia64 cluster).
>
> The fastest/simplest way to get help on something so obscure would be
> to bisection search to the problematic commit
>
> You might be the only user left in the world of this combination :)

And CC the linux-ia64 mailing list? Gentoo on ia64.. Wow.


