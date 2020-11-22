Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86E212BC89A
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Nov 2020 20:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgKVTWd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Nov 2020 14:22:33 -0500
Received: from gentwo.org ([3.19.106.255]:37442 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbgKVTWb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 22 Nov 2020 14:22:31 -0500
Received: by gentwo.org (Postfix, from userid 1002)
        id 3F1583F084; Sun, 22 Nov 2020 19:22:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 3C70D3E9FA;
        Sun, 22 Nov 2020 19:22:30 +0000 (UTC)
Date:   Sun, 22 Nov 2020 19:22:30 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     =?ISO-8859-15?Q?H=E5kon_Bugge?= <haakon.bugge@oracle.com>
cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Mark Haywood <mark.haywood@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>
Subject: Re: Is there a working cache for path record and lids etc for
 librdmacm?
In-Reply-To: <801AE4A1-7AE8-4756-8F32-5F3BFD189E2B@oracle.com>
Message-ID: <alpine.DEB.2.22.394.2011221919240.265127@www.lameter.com>
References: <alpine.DEB.2.22.394.2011170253150.206345@www.lameter.com> <20201117193329.GH244516@ziepe.ca> <alpine.DEB.2.22.394.2011201805000.248138@www.lameter.com> <6F632AE0-7921-4C5F-8455-F8E9390BD071@oracle.com> <alpine.DEB.2.22.394.2011221246230.261606@www.lameter.com>
 <801AE4A1-7AE8-4756-8F32-5F3BFD189E2B@oracle.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="531401748-2007141671-1606072950=:265127"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--531401748-2007141671-1606072950=:265127
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Sun, 22 Nov 2020, Håkon Bugge wrote:

> > The app that we have runs in user space. Can it use the cache? Is the
> > cache only in Mellanox OFED? I heard that it was removed.
>
> An app in user space can use the ibacm cache. If you use the default
> configuration that comes with rdma-core, both address and route
> resolution will be from librdmacm directly to ibacm, i.e., no kernel
> involved. The ibacm options are by default installed in
> /etc/rdma/ibacm_opts.cfg

I have been using that.

> If you set acme_plus_kernel_only to one in said config file, you app will resolve the address using the kernel neighbour cache and the route resolution will go into the kernel and then "bounce" back  to user space and ibacm through NetLink.

Have not seen that in the RHEL7.8 version of ibacm.

> > This is an an option while building ibacm?
>
> Nop, runtime config option as depicted above.

Must be a newer version then.

> The default provided by rdma-core should work, possible requiring the option above.

The one in RHEL7 will never resolve anything through the subnet manger.
Evey request results here in a leftover kernel thread hanging around.

Which version of ibacm do you run?

--531401748-2007141671-1606072950=:265127--
