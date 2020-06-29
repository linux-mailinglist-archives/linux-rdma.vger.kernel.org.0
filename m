Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD88520D3B1
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jun 2020 21:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgF2TBZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 29 Jun 2020 15:01:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28387 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730423AbgF2TBU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 29 Jun 2020 15:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593457279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=frlV3FpehkDfQxZJhzQnUi3YdNW/3VQsQgy4e2Df+FM=;
        b=QjEut8AW+lbRs+/B7iyZ1m5NJKnqyGoElsJ3MSTJWeJdqBIlN3kW3SWmIN5NUoR/i4eJdR
        vj9+FX4qP3JeqL0rTjesNR0b/fRQxaAdgsueqhpqjKSGPXTZ5LX5f12khqfAjZvTNxbdxt
        7TPRxvqYM/nibW1qYg7aHXLmPPdP5Bg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-T-0vjONzN6ODB59o5IoSEw-1; Mon, 29 Jun 2020 06:58:40 -0400
X-MC-Unique: T-0vjONzN6ODB59o5IoSEw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54CC218585DF;
        Mon, 29 Jun 2020 10:58:39 +0000 (UTC)
Received: from localhost (unknown [10.66.128.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BEF0F10013DB;
        Mon, 29 Jun 2020 10:58:38 +0000 (UTC)
Date:   Mon, 29 Jun 2020 18:58:36 +0800
From:   Honggang LI <honli@redhat.com>
To:     Alaa Hleihel <alaa@mellanox.com>
Cc:     jgg@mellanox.com, linux-rdma@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Edward Srouji <edwards@mellanox.com>
Subject: Re: [PATCH rdma-core] redhat: Fix the condition for pyverbs
 enablement on Fedora 32 and up
Message-ID: <20200629105836.GA1060821@dhcp-128-72.nay.redhat.com>
References: <20200628145003.13705-1-alaa@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628145003.13705-1-alaa@mellanox.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jun 28, 2020 at 05:50:03PM +0300, Alaa Hleihel wrote:
> The cited commit enabled pyverbs build by default for Fedora 32 and up.
> However, it broke enalbing pyverbs build when passing '--with pyverbs' flag.
> 
> Fix the condition so that now the behavior for Fedora 32 and up will be:
>  * Default: pyverbs enabled.

Confirmed this patch works for me. Thanks!

Acked-by: Honggang Li <honli@redhat.com>

>  * --with pyverbs: pyverbs enabled.
>  * --without pyverbs: pyverbs disabled.
> 
> Fixes: 07b304b75186 ("redhat: Build pyverbs for Fedora greater than release 31")
> Signed-off-by: Alaa Hleihel <alaa@mellanox.com>
> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> Tested-by: Edward Srouji <edwards@mellanox.com>
> CC: Honggang Li <honli@redhat.com>
> ---
>  redhat/rdma-core.spec | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/redhat/rdma-core.spec b/redhat/rdma-core.spec
> index 7ff33b3ca8b8..76549e5cb61f 100644
> --- a/redhat/rdma-core.spec
> +++ b/redhat/rdma-core.spec
> @@ -28,7 +28,7 @@ BuildRequires: valgrind-devel
>  BuildRequires: systemd
>  BuildRequires: systemd-devel
>  %if 0%{?fedora} >= 32
> -%define with_pyverbs %{?_with_pyverbs: 0} %{?!_with_pyverbs: 1}
> +%define with_pyverbs %{?_with_pyverbs: 1} %{?!_with_pyverbs: %{?!_without_pyverbs: 1} %{?_without_pyverbs: 0}}
>  %else
>  %define with_pyverbs %{?_with_pyverbs: 1} %{?!_with_pyverbs: 0}
>  %endif
> -- 
> 2.26.2
> 

