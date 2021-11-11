Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A1844D5C9
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Nov 2021 12:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhKKLcU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Nov 2021 06:32:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:40896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229668AbhKKLcU (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 11 Nov 2021 06:32:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D32D61108;
        Thu, 11 Nov 2021 11:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636630171;
        bh=DYc4VhFN/8EJUpYw+oobmL2JuG2oFSWCAYBpQfPUDdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Va+3j7i/yeMWOl1aFNM+GBVOpVNcm2nI01omyxnOXLkso3flVtsOOOEkt0r0EiF2s
         +nMUSTVregr0GTkOfJX6uSa5h6YesRSDTKqlVAs2XVXAyt0T7Jz3kGEYJYihqu2zFV
         XOvJpqLO0DR+cvIQHyKTaVww2/MCvwh34o3yGrvWkT6sOyRpgIlvOYCBnwRnAhCMt9
         jYZuRSjuI/wYmxk7OmDeKhoI/0mYDI7Dya6nlrNog2Y66scvB9OG5VQc6Dom2UzRKl
         it5Kg0Sho5llSjEVpknIHNddzeYTlXTUQA/aFAZTX8wB025O0qzSowQ8HuN6kJxlME
         c7iOy9CfoK4Rw==
Date:   Thu, 11 Nov 2021 13:29:26 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jinpu Wang <jinpu.wang@ionos.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Haris Iqbal <haris.iqbal@ionos.com>
Subject: Re: Missing infiniband network interfaces after update to 5.14/5.15
Message-ID: <YYz+lmJ9C4P/2hbv@unreal>
References: <CAMGffEmC07MwNsTHQ19OwUonG4zgYsx0vj+R__9as3E5EduY8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEmC07MwNsTHQ19OwUonG4zgYsx0vj+R__9as3E5EduY8A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 11, 2021 at 08:48:08AM +0100, Jinpu Wang wrote:
> Hi Jason, hi Leon,
> 
> We are seeing exactly the same error reported here:
> https://bugzilla.redhat.com/show_bug.cgi?id=2014094
> 
> I suspect it's related to
> https://lore.kernel.org/all/cover.1623427137.git.leonro@nvidia.com/
> 
> Do you have any idea, what goes wrong?

I can't reproduce it with latest Fedora 34 RPM, which I downloaded from here
https://koji.fedoraproject.org/koji/buildinfo?buildID=1851842

and also with kernel-5.14.7-200.fc34.x86_64 version mentioned in the bug
report.

[leonro@c-235-8-1-005 ~]$ uname -a
Linux c-235-8-1-005 5.14.7-200.fc34.x86_64 #1 SMP Wed Sep 22 14:54:28 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
[leonro@c-235-8-1-005 ~]$ rdma dev
0: ibp8s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7950 sys_image_guid 1c34:da03:0007:7953
1: ibp9s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7a60 sys_image_guid 1c34:da03:0007:7a63

[leonro@c-235-8-1-005 ~]$ uname -a
Linux c-235-8-1-005 5.14.16-201.fc34.x86_64 #1 SMP Wed Nov 3 13:57:29 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
[leonro@c-235-8-1-005 ~]$ rdma dev
0: ibp8s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7950 sys_image_guid 1c34:da03:0007:7953
1: ibp9s0f0: node_type ca fw 2.42.5000 node_guid 1c34:da03:0007:7a60 sys_image_guid 1c34:da03:0007:7a63
[leonro@c-235-8-1-005 ~]$ lspci |grep nox
08:00.0 Network controller: Mellanox Technologies MT27520 Family [ConnectX-3 Pro]
09:00.0 Network controller: Mellanox Technologies MT27520 Family [ConnectX-3 Pro]

Thanks

> 
> Thanks!
> Jinpu Wang
