Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86B5C835C3
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Aug 2019 17:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733206AbfHFPwK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Aug 2019 11:52:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:44386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729638AbfHFPwK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Aug 2019 11:52:10 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D17E2070D;
        Tue,  6 Aug 2019 15:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565106730;
        bh=XozIRc+JH0x6sxLzqOLpMZs1+fx7Bia9dACr5voIfcA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mx+7rSS/9S5TIFJ0cz3kbhNGBczUSwmNPN/Ed/lUTwNfZtrgyAzYRMZvOceKuFl++
         9SGED7sJeIJvzPNjpvn09CXwz1okzx1kdJTFCCpCLJ3rfUqyFpAp4MPLtFImEfy8YC
         9S4Fq65sr7IKj7ykReTJmmKDNAyazn/0508izQPg=
Date:   Tue, 6 Aug 2019 18:52:06 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Haim Boozaglo <haimbo@mellanox.com>
Cc:     linux-rdma@vger.kernel.org,
        Vladimir Koushnir <vladimirk@mellanox.com>
Subject: Re: [PATCH 1/3] libibumad: Support arbitrary number of IB devices
Message-ID: <20190806155206.GZ4832@mtr-leonro.mtl.com>
References: <1565102334-20903-1-git-send-email-haimbo@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565102334-20903-1-git-send-email-haimbo@mellanox.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 06, 2019 at 02:38:52PM +0000, Haim Boozaglo wrote:
> From: Vladimir Koushnir <vladimirk@mellanox.com>
>
> Added new function returning a list of available InfiniBand device names.
> The returned list is not limited to 32 devices.
>
> Signed-off-by: Vladimir Koushnir <vladimirk@mellanox.com>
> Signed-off-by: Haim Boozaglo <haimbo@mellanox.com>
> ---
>  libibumad/CMakeLists.txt              |  2 +-
>  libibumad/libibumad.map               |  6 +++++
>  libibumad/man/umad_free_ca_namelist.3 | 28 ++++++++++++++++++++++++
>  libibumad/man/umad_get_ca_namelist.3  | 34 +++++++++++++++++++++++++++++
>  libibumad/umad.c                      | 41 +++++++++++++++++++++++++++++++++++
>  libibumad/umad.h                      |  2 ++
>  6 files changed, 112 insertions(+), 1 deletion(-)
>  create mode 100644 libibumad/man/umad_free_ca_namelist.3
>  create mode 100644 libibumad/man/umad_get_ca_namelist.3

1. Please use cover letter for patch series.
2. There is a need to update debian package too.
3. Need to use the same discovery mechanism as used in libibverbs - netlink based.
4. Does it work with hot-plug where device name can change?

Thanks
