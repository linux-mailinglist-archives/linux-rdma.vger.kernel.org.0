Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9C4469589
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 13:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243002AbhLFMVa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 07:21:30 -0500
Received: from gentwo.de ([161.97.139.209]:56704 "EHLO gentwo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243000AbhLFMVa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 Dec 2021 07:21:30 -0500
Received: by gentwo.de (Postfix, from userid 1001)
        id 25F6DB0043D; Mon,  6 Dec 2021 13:18:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 2179DB00355;
        Mon,  6 Dec 2021 13:18:00 +0100 (CET)
Date:   Mon, 6 Dec 2021 13:18:00 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.org>
X-X-Sender: cl@gentwo.de
To:     Leon Romanovsky <leon@kernel.org>
cc:     jgg@nvidia.com, linux-rdma@vger.kernel.org
Subject: Re: rdma-core: Add support for multicast loopback prevention to
 mckey
In-Reply-To: <Ya27hlT3SwCdBKZB@unreal>
Message-ID: <alpine.DEB.2.22.394.2112061317260.175585@gentwo.de>
References: <alpine.DEB.2.22.394.2112021404100.58561@gentwo.de> <Yay9+MyBBpE4A7he@unreal> <alpine.DEB.2.22.394.2112060811510.163032@gentwo.de> <Ya27hlT3SwCdBKZB@unreal>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1637624194-1638793080=:175585"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1637624194-1638793080=:175585
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 6 Dec 2021, Leon Romanovsky wrote:

> On Mon, Dec 06, 2021 at 08:13:17AM +0100, Christoph Lameter wrote:
> > On Sun, 5 Dec 2021, Leon Romanovsky wrote:
> >
> > > How can I apply your patch? Can you send it as a PR to rdma-core github?
> >
> > Well git-am would apply a patch like that but I can also send a PR
> > request.
>
> I wrote my previous email after I tried :).
>
> ➜  rdma-core git:(master) ✗ git am 20211202_cl_rdma_core_add_support_for_multicast_loopback_prevention_to_mckey.mbx
> Applying: rdma-core: Add support for multicast loopback prevention to mckey
> error: corrupt patch at line 74
> Patch failed at 0001 rdma-core: Add support for multicast loopback prevention to mckey
> ...

Worked fine here. Trying to get the PR done. See pull request #1100
--8323329-1637624194-1638793080=:175585--
