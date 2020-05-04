Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7511C4372
	for <lists+linux-rdma@lfdr.de>; Mon,  4 May 2020 19:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgEDR6c (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 4 May 2020 13:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728158AbgEDR6b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 4 May 2020 13:58:31 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CB3C061A0E
        for <linux-rdma@vger.kernel.org>; Mon,  4 May 2020 10:58:31 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f83so385438qke.13
        for <linux-rdma@vger.kernel.org>; Mon, 04 May 2020 10:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OhbVTRQXHLFzXdbqHkCpC6THdk45/MkgYuz+1PSsfmk=;
        b=A/H1w4fX39bueXGGuuuuo+wvC+4PmdXBKa6JmcoGOT+sUPDxo+awhhvP+2G1dyBoTN
         eoj7kcp2GvbH/KSx5lRchq3xuyaCaxfl0Cz94xebqB39Z5hGmJygd3o7JzqENMqKN8FE
         L7t07qAfwTvPAyvfCeGcGx3zcFedGhTqGLnWdpcrzbB/5z1xlIihLXUkwJILCvf3rr4/
         PklXiFcepSQXegOTZcq5mRegMhvuuRdyylC0pv2PmeiwKbazd6GmdUj0KjEQ6gxEcAEj
         Ux8gCid6r+53CmuJwZihrwT8R6a1Aa/buube8leMw80FJtFX0tMC4wFTXkkCZzJt6V+x
         BbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OhbVTRQXHLFzXdbqHkCpC6THdk45/MkgYuz+1PSsfmk=;
        b=e9apjKwMzrCnUEzfEuQCKhVQsOkz3z1tC0YwUot/kJ2kEBUbvuVF1OSa90nubd6zvW
         H9kZkaIahtmAJoKY+dP3n/9YIFzYlt8NJCGo2PHNinzPMzzP0ONM/++SCFnqnWIdVzst
         DVHHEnxawDZQvmAONlZRjNag5DxpH1Nk77cQR5RZwi+kLDl1scsAOYgVut2cO/uideFG
         buzzBGf7GGzSxPJrbCJ34EIgBwXbFfvBmBU3Pz3A/xkaK/CkS3wEW7jmvnix+vNqnUq9
         xMFHNfE6v2t61EhEhMipecKrVcEfPjhehS5SN28gS+vVXcxq1IeT2hx2/w4ztM/UEip6
         FMOA==
X-Gm-Message-State: AGi0PubMaa1fEOpj5xjz16s/t8tmNM3dyREm9U+qjzlmJ5NXCHlaEyZU
        W04N3VNNB2DdkxEkZY2rbg+B8g==
X-Google-Smtp-Source: APiQypIT1eV+PImhw5mzjEWJlpyEWCXXPwIQiDxLIAPLXML+2isWI6FaSzJ7OqUHZsANBOtl/P1ifQ==
X-Received: by 2002:a37:ac9:: with SMTP id 192mr402199qkk.249.1588615110323;
        Mon, 04 May 2020 10:58:30 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d23sm10417280qkj.26.2020.05.04.10.58.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 May 2020 10:58:29 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jVfML-0005Pe-9W; Mon, 04 May 2020 14:58:29 -0300
Date:   Mon, 4 May 2020 14:58:29 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] IB/core: Fix potential NULL pointer dereference
 in pkey cache
Message-ID: <20200504175829.GA20458@ziepe.ca>
References: <20200426075811.129814-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426075811.129814-1-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Apr 26, 2020 at 10:58:11AM +0300, Leon Romanovsky wrote:
> From: Jack Morgenstein <jackm@dev.mellanox.co.il>
> 
> The IB core pkey cache is populated by procedure ib_cache_update().
> Initially, the pkey cache pointer is NULL. ib_cache_update allocates
> a buffer and populates it with the device's pkeys, via repeated calls
> to procedure ib_query_pkey().
> 
> If there is a failure in populating the pkey buffer via ib_query_pkey(),
> ib_cache_update does not replace the old pkey buffer cache with the
> updated one -- it leaves the old cache as is.

The bug described here is that ib_cache_setup_one() ignores the return
codes from ib_cache_update()

Device registration should fail if the cache could not be loaded, just
fix ib_cache_setup_one()

Jason
