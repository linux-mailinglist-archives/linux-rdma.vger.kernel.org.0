Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6AA99895
	for <lists+linux-rdma@lfdr.de>; Thu, 22 Aug 2019 17:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389645AbfHVPwc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 22 Aug 2019 11:52:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727953AbfHVPwb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 22 Aug 2019 11:52:31 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A315233FD;
        Thu, 22 Aug 2019 15:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566489151;
        bh=FAkEVyVlRZ+M8xV5Ac/4Po8neKFiHNlFFnhb2yZRY4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PqlYITxZEeKpqHWcReA+6o93A5tMwVJ5CH8FCHoHxW5TDe/XMHIbJ+LRMBJ/oVNNS
         9gfYmwAAJhzr3HxwFPwLVJAAR9SO8Lg+rayzncglKCjoTUWJ5SWCRcPIv3ihMOIf1b
         mRQPpgZr2fbmg5NjqVjgUefaFTKQCYO5w9/Tw0zg=
Date:   Thu, 22 Aug 2019 18:52:28 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Krishnamraju Eraparaju <krishna2@chelsio.com>
Cc:     Marcin Mielniczuk <marcin@golem.network>,
        linux-rdma@vger.kernel.org
Subject: Re: Setting up siw devices
Message-ID: <20190822155228.GH29433@mtr-leonro.mtl.com>
References: <421f6635-e69c-623d-746a-df541c27f428@golem.network>
 <20190822154323.GA19899@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190822154323.GA19899@chelsio.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 22, 2019 at 09:13:25PM +0530, Krishnamraju Eraparaju wrote:
> On Thursday, August 08/22/19, 2019 at 17:08:49 +0200, Marcin Mielniczuk wrote:
> > Hi,
> >
> > I'm trying to test the recently merged siw module.
> > I'm running kernel 5.3-rc5 (taken from the Ubuntu mainline-kernel
> > repository [1]) on Ubuntu 18.04 (bionic).
> > I also manually installed rdma-core 25.0 from tarball, using the
> > included Debian packaging. I installed all the packages but ibacm.
> >
> > After booting the new kernel I manually loaded the kernel module by
> >
> >      modprobe siw
> >      modprobe rdma_ucm
> >
> > Then ibv_devinfo shows: "No IB devices found".
> > dmesg only shows:
> >      [   29.856751] SoftiWARP attached
> >
> > According to this tutorial, [2] it should be enough to just load the siw
> > module. (unlike RXE, where one needs to use rxe_cfg to set up the
> > interface)
> > Is this a bug in siw or just a configuration issue on my side?
>
> Have you done "rdma link"?
>
> rdma link add <NAME> type siw netdev <NETDEV>
>
> http://man7.org/linux/man-pages/man8/rdma-link.8.html

BTW, the same goes for RXE and rxe_cfg is discouraged.

Thanks

>
> >
> > Thanks,
> > Marcin
> >
> > [1] https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.3-rc5/
> > [2] https://budevg.github.io/posts/tutorials/2017/04/29/rdma-101-1.html
> >
>
>
>
