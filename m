Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA82623D3DB
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Aug 2020 00:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgHEWRs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Aug 2020 18:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgHEWRp (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Aug 2020 18:17:45 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919C0C061575
        for <linux-rdma@vger.kernel.org>; Wed,  5 Aug 2020 15:17:44 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id j10so14836608qvo.13
        for <linux-rdma@vger.kernel.org>; Wed, 05 Aug 2020 15:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5oNz1GhVkQIxVeblfP48Wl0/z0AAYp7Rr8N2IsBMpuY=;
        b=Yf7gnibbUowwM0ffd6q8N9iS4gwEzjC+iCvzjKfmZ048qUdXPbyWKoOwq/RJ5bcHCh
         s8sgvZVe44ebHbtGWSBDXkdkYnwvtiIQQ90VqvDwpsCTx6+K7537icVJXNFrueH91f6z
         ck/pT6FghEs0KktMFrwPuVtx8KcnmRS8qoIlqz72Oi6YQNrF1zDLFBZhZBSKlDAMRt9Z
         9f4R28yAU9nm//jvi7Pk29wHqUgMwIFI5UdG+vGcs/V8nHYGjEqCOVNBMKKx/dNadqfA
         rHBz/T3peYP4YQM+UP8RnFJIZcKzUAUPuPtulOeonlnpqGg8dNkUNW7kKADUJlRW+5rY
         ljfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5oNz1GhVkQIxVeblfP48Wl0/z0AAYp7Rr8N2IsBMpuY=;
        b=QwirZs8qXmYStnNmWCk/6eSkqf39s4g4ygaxN6qgFiU55LTwNIsMt9UUjIo/8dm/69
         ifHxDKpyTiB6LCWCZbHubUR1h0ACbrnBUTWVMuPEk+SPL4G4iMmdidiv6DVxawRICxI/
         zR3ei0xUPgnecIRgJHP69Vprq3H8KxYvp7M+vV5hWYFnOEx1yi1XiA3HsF50vbuE9Eo1
         b8M3Lc3HsZhLUf6r7HI35K2Xl1+tt5Az3yqrJKJXpnNGJCoB7ceB+1nxuFelgl/it3Y9
         iTIBkmPKrByXepIV2rkBiIbVp1D+s9IxJGJ6VOUI+8VDbngvDRMNSSPaL4PyX1sEE1rO
         VZKg==
X-Gm-Message-State: AOAM532mgKuFk9+Tmo6Wm9wzRPSKOswbnYAEoIjsWQf9eqLFsD5yK83E
        +esXBa+9mvdgVeJ+GihNnRpjSA==
X-Google-Smtp-Source: ABdhPJwJ8Achyr/Orkk7+3JU2DaMXqT3JkrCYHbMcteKbRzfGQafyRjmcJ1+Nz+f5b0WmD/oo4NM8A==
X-Received: by 2002:a0c:b52b:: with SMTP id d43mr6101521qve.158.1596665863872;
        Wed, 05 Aug 2020 15:17:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id u39sm3400919qtc.54.2020.08.05.15.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 15:17:43 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1k3RjC-003y6r-1j; Wed, 05 Aug 2020 19:17:42 -0300
Date:   Wed, 5 Aug 2020 19:17:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Christian Benvenuti <benve@cisco.com>
Subject: Re: [PATCH for-rc] RDMA/usnic: Fix reported max_pkeys attribute
Message-ID: <20200805221742.GS24045@ziepe.ca>
References: <20200805210051.800859-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805210051.800859-1-kamalheib1@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 06, 2020 at 12:00:51AM +0300, Kamal Heib wrote:
> Make sure to report the right max_pkeys attribute value to indicate the
> maximum number of partitions supported by the usnic device.

Why does usnic support pkeys? This needs more explanation

Jason
