Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0A74220F
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 12:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437977AbfFLKMm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 06:12:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:60876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437611AbfFLKMm (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Jun 2019 06:12:42 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E7CC2080A;
        Wed, 12 Jun 2019 10:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560334361;
        bh=irMS+lgDpJJNSDT1/6QON3/hnkbR69PoagsHSfhPN04=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KNorcfdyK10E7uVC/6SccYVzTbvVS4A9erB40sjs9XwwYGZ9IHuX9fEWu5pn6cusj
         zRyv7vrAAqHtnK38DzehU3qrGbP9U0/4IEKLw2fJ/gGjNcypAIbebq9b3tF9GACXcZ
         +EKEcwJWVHOpfZhkb2YNukTXQn9NJEjopMGxhnJw=
Date:   Wed, 12 Jun 2019 13:12:38 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Chris Elrod <elrodc@gmail.com>
Cc:     linux-rdma@vger.kernel.org
Subject: Re: Failed to enable unit: Unit file rdma.service does not exist
Message-ID: <20190612101238.GN6369@mtr-leonro.mtl.com>
References: <CA+pTmbCAd47NbJ0=QxwUHZRtyqdx61sFv6P8nyRPtxi-mk_A4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+pTmbCAd47NbJ0=QxwUHZRtyqdx61sFv6P8nyRPtxi-mk_A4Q@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 12, 2019 at 01:23:12AM -0500, Chris Elrod wrote:
> - Linux distribution and version
> Clear Linux (29870)
>
> - Linux Kernel and version
> 5.1.8
>
> - InfiniBand hardware and firmware version
> Hardware version: MCX354A-FCBT (FDR)
> Firmware version: 2.42.5000
>
> Problem:
> $ systemctl enable rdma
> Failed to enable unit: Unit file rdma.service does not exist.
>
> More background:
> I have 3 computers and 3 cards. Each card has 2 ports, so I'd like to
> directly link each computer and use infiniband with (Open)MPI.
>
> Clear Linux's package manager provides rdma and rdma-core, but doesn't
> provide rdma.service. I do not see a /usr/libexec/rdma-init-kernel,
> either.
> (Same story with other packages, like opensm).
> I made a comment on the Clear Linux community forum, and was told:
>
> """Upstream does not provide these files, and this is explained by the
> age of the project and the amount of development activity.
>
> This is one of those problems that should have been solved upstream.
> If we add unit files, they’re most likely not going to be correct
> since it’s unlikely that anyone on our team uses RDMA/opensm.
>
> YTEH - You’re The Expert Here. It would really help if you could
> investigate what the proper content of the unit files are, submit them
> upstream and Cc the clearlinux github issue tracker. Then we can make
> progress instead of blindly adding some untested and copied unit file
> from another distro."""
>
> https://community.clearlinux.org/t/unit-file-opensm-service-does-not-exist-provide-opensm-service-files/762/4
>
> I see for example that you provide support for Debian, Red Hat, and Suse.
>
> What is your policy towards other distributions (that aren't built on
> top of those three) / what are your recommendations?

Send patches and PR for rdma-core that adds your distribution and
upstream rdma-core will support it as long as you will take care
of ensuring that such new distribution picks this upstream variant.

>
> I am far from an expert, but I'd be happy to help if there's something I can do.

You will need to update our buildlib/cbuild too to support your distribution.
It will ensure that any new changes to rdma-core are checked against
this distro.

Thanks
