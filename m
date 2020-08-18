Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 723EA248BAB
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 18:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgHRQcB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 12:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgHRQb7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 18 Aug 2020 12:31:59 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B86C061389
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 09:31:59 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id d14so18797445qke.13
        for <linux-rdma@vger.kernel.org>; Tue, 18 Aug 2020 09:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iqqD1aX3l3qJtVraV1j0o4sg1WzN6wp14Pwu6BYFZNA=;
        b=b3DpGBa9kok8SFk6Sz4Vz8iVuacnIBI718s5NYK/nRE6djakgGiPUoiVliSNqbRwzJ
         Tu6ybtumKHYCAiZlVYmA0hpi1aqroLn/XFrfvp44pa6dv/WKsYWKL73dyHFXK72KjPtr
         FN+wrdHCegYTSKun1WODaNOikZqKkxw+oqWP9osWngSlXLsw+Mda1ntDBHnBPnru/WV4
         /PW6fMm3+nu1ILHhvtyP/fDPwwM82a2LMMHrT8k4nIiIbgAsHr9/0ldps1U0eJiftFlM
         QLkAfjAb5UpMJglcs8MC8O/mLNPZemhcCnFwVN+MpgJmhSqjfhX0BFr0yh7Hyvpfe8pp
         hAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iqqD1aX3l3qJtVraV1j0o4sg1WzN6wp14Pwu6BYFZNA=;
        b=VjAM9PjzjSYqRRSrU9mvQCiZ0pufjAwMr/cWTbtDl+Yt2dYln098dMbtk+p7YZafne
         GfgTtEdIu2VDbbwSaJK3OcO0CQ/fBo6DvCDNt0yo980DUsBe568mmj6GgF6p8BfuwtAu
         SQR0KjJ6LogPHOXmZSMrRa4p4DuKdC1jNvA2R2Sge6V2pJ7V6Ab5JFD2eB7E5NBc3yqk
         bvMV8g4sbrzZsj+RniPavq89mHUx3Or1i+NO7TDLryisO0nazY0GcgOZWxoDzm3JsYZ7
         uEgvsShAeVvpYrPPSt0NrmrkUCzCSzqeDafCvbmJ+NzJyX6Smbkj1hvP32lu+PCfkMoI
         vcYA==
X-Gm-Message-State: AOAM5312ssTuuqjPegrQEja6AF5krR3KShtm+NArsqoj+6wNqrDqXo2f
        PJ5P5HjCbq8LKIpBP0mqgIQBzg==
X-Google-Smtp-Source: ABdhPJyk299aVr1s5EHz+SeyEYg+QWpQpbBy20V64y9qHOyBnp2DOFTvmZiKhg2erf99XEKK7EPgBg==
X-Received: by 2002:a37:9c57:: with SMTP id f84mr17354092qke.34.1597768318550;
        Tue, 18 Aug 2020 09:31:58 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 71sm21683461qkk.125.2020.08.18.09.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 09:31:57 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1k84Wj-008Lek-8C; Tue, 18 Aug 2020 13:31:57 -0300
Date:   Tue, 18 Aug 2020 13:31:57 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kamal Heib <kamalheib1@gmail.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH v2 for-rc] RDMA/rxe: Fix panic when calling
 kmem_cache_create()
Message-ID: <20200818163157.GY24045@ziepe.ca>
References: <20200818142504.917186-1-kamalheib1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818142504.917186-1-kamalheib1@gmail.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Aug 18, 2020 at 05:25:04PM +0300, Kamal Heib wrote:
> To avoid the following kernel panic when calling kmem_cache_create()
> with a NULL pointer from pool_cache(), move the rxe_cache_init() to the
> context of device initialization.

I think you've hit on a bigger bug than just this oops.

rxe_net_add() should never be called before rxe_module_init(), that
surely subtly breaks all kinds of things.

Maybe it is time to remove these module parameters?

Jason
