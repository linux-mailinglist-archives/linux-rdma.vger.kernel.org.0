Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F448402D00
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Sep 2021 18:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343868AbhIGQks (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Sep 2021 12:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344636AbhIGQks (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Sep 2021 12:40:48 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A42C06175F
        for <linux-rdma@vger.kernel.org>; Tue,  7 Sep 2021 09:39:41 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id t190so10713671qke.7
        for <linux-rdma@vger.kernel.org>; Tue, 07 Sep 2021 09:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Djz5zde4ZWLSB0MvoNSPMD6zrTvYVCBqkhzCW0Ca8nk=;
        b=pEBWvAWd7lmjI4uhcSNUfM80rxKkgKNg0evFo4BRC/NkiMXyDxkEU1SGpfB75ST4+S
         10RIEKGQPhneFHBbmKPaPVasgKT5jzcbgQUaxCdDPPnGy+SrRnYgP7nfimZ5PhYlABm/
         diVZM4CVfQf7xnJk3IQFawVQCq081jHLLrfpMJ5knf7J4VTfwq2BqZxRa+s5qwenKPUC
         N6vNelTU+8srZ5R08zjxHiMUu26PYeX2/I5j5Fk+QTP9ErSxVV7n8ervMbL1stpL6e/t
         o9CdIrzqT63R/QQGLteyGfT8Gb2dpBIOKskbKoMgFnd2sjNyutcw+TwUKVE9ycxbcUHe
         VcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Djz5zde4ZWLSB0MvoNSPMD6zrTvYVCBqkhzCW0Ca8nk=;
        b=XtfmJX1y3kZGAvagGiaJuyMEzJ6ib5ZT14CWN7GMlE1oPx2q+2veTE7umT8/82txvz
         2ci5MUYZ0SDexnyZ/Eo3KQ4IB6lVCa1TlrfS2EiwcLx1tlAyM0T173wi5bftZChJITGM
         hJaMSl4knrlUuZPAorwH7l7Mbg7amJH+t79j2f4I4ZjqZlncx2Vky4Ug0lHcY5HvJtMp
         oRbSFXQT4YL8NQ8enQHWe5ooPlM0R+YrNmr8PeRgry2CJOugHWVxTCX+xrDny3YAQsIn
         qjaUnxdjIw8sBB1vz0FJOENGxcKDssuCOGq8agd+InvK3hXVhIr5Eca4z6HQTQUFtQvL
         fgIw==
X-Gm-Message-State: AOAM532Omicr/QQdv+Qu1sJsqGBwW3b4pwTJEmkTXrjmvj+JLGBPvUyB
        yR+Eejy/DOuQhqnCIgHOE7SgIw==
X-Google-Smtp-Source: ABdhPJwG/fpAvEoJxNW24RQnUDuVLoTXB+5DZ0QWY6GefhQD6z1qVJT8+4jf95lFr3+1Kkw0w1ahqg==
X-Received: by 2002:a05:620a:444b:: with SMTP id w11mr16666947qkp.479.1631032780766;
        Tue, 07 Sep 2021 09:39:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id j6sm7534501qtp.97.2021.09.07.09.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 09:39:40 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mNe8J-00CtD5-HB; Tue, 07 Sep 2021 13:39:39 -0300
Date:   Tue, 7 Sep 2021 13:39:39 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: blktest/rxe almost working
Message-ID: <20210907163939.GW1200268@ziepe.ca>
References: <c7557529-d07d-3e35-0f03-2bbe867af4a1@gmail.com>
 <20210902233853.GB2505917@nvidia.com>
 <1610313b-e5d0-a687-a409-d1275baf7f95@gmail.com>
 <711c089d-ce66-63e8-4d80-0bd19f22607c@acm.org>
 <20210904223056.GC2505917@nvidia.com>
 <fcf6f57e-972b-f88e-84bf-d1618fd3e23e@gmail.com>
 <20210907120156.GV1200268@ziepe.ca>
 <9e6783d0-554c-17de-c72f-fae766099480@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e6783d0-554c-17de-c72f-fae766099480@gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 07, 2021 at 11:35:17AM -0500, Bob Pearson wrote:

> Interesting. But if that is the case the bigger problem is the ib_map_mr_sg() call which updates the
> mapping. rxe definitely does look at the mr->rkey value but we could fix that. It also looks at the
> mapping which is updated by ib_map_mr_sg(). My impression is that HW also uses this mapping or does
> HW also copy all the FMRs into SRAM?

Yes, real HW has a copy of the DMA list. The sg in the mr struct is
for CPU use only.

It is not OK to use the CPU SG list inside the MR for DMA by HW, it
has to be synchronized with the WR.

> There seems to be an assumption that users will be looking at CQE.

Yes, the kernel has to be driven by CQE, not only for data transfer
but the DMA unmap of the SGL cannot be until after the invalidation
CQE is observed.

Ie the CPU should have two DMA lists active during the invalidation
cycle.

Jason
