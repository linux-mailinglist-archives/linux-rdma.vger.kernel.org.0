Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A16240DD72
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Sep 2021 17:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236391AbhIPPDW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Sep 2021 11:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbhIPPDW (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Sep 2021 11:03:22 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7F9C061764
        for <linux-rdma@vger.kernel.org>; Thu, 16 Sep 2021 08:02:01 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id t4so4087247plo.0
        for <linux-rdma@vger.kernel.org>; Thu, 16 Sep 2021 08:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M5gCAPaE/nHrIFIMvVnMeDjexAdTXhnPwO4CaUldM2U=;
        b=AXPEzyMsoeKkXnIeuO3aKLdV380ynzj0wjkkBcMKa64PWMTFGgcd4SAuB4RindvZef
         gWMqJKMhSivUCnLc/SliE8Cgmk5gga5ZBQX7XyhbhJXgXhlbqZH2f6jjOfjP9SFsxrrH
         GBlVMUuAKUUmtMvc9MUtcYb2zvS6lHpK3TFwMXgc0N9bqlcYEGqVwmHdmC7N+CBCpTUw
         GxPK4P4Ex0CLNokyvtPtjSZ/iddeXO1QfMTfdKOSEtIVu4VXBHP2VlKZNbAVpxu093a2
         MnkGfiezqroQGVmGQEBRokgaFHmw+hcjbnMvbMtPi2ZtjzZYC99Vrj0aaYm5Dp7w/zyj
         Lyxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M5gCAPaE/nHrIFIMvVnMeDjexAdTXhnPwO4CaUldM2U=;
        b=3k+By3NFUhPEutqNW/vH20o/yBQLx89Aa6W48c7x5v5OzQizVaarUvcSy0UwUeAUdx
         MG6pV2NA2sFXprCXblEqITiVsx8Hk51SUk/M/Q44SJ1Ok0N5NGCDLp38G1xfqVgEIIsB
         Xjk7bN1o49F4c5G/nRLXmd76M1NKhSRGArSSA09dSF3uQ8jv3cqH0PfvkA58mAVDcLTN
         5Dq8HyVofD/3xkWC30pTqBTR1FtNf1KlCac5ORlQm0URW1b/ZWvKFOWPBpREIwe8IEEO
         t/5bvUmvJ83cnNqiqjJ9vjN6D7CcOnW6v7+JubhdTmBm/0jb9UCb0qtlHatoRC2ZqcQN
         pC5g==
X-Gm-Message-State: AOAM532wt8/IiGxXHEQR6RFQXbdiiq8dM4YrJMCoXPpFEl7Fuy1f2g9+
        AR1sTx0WSbw08YjHm7p8iJSjgQ==
X-Google-Smtp-Source: ABdhPJzuO8ZoSlxjBw3iUE+pOwMT7sUg3TGSN+4o07O+LFuejXU6WahFODS1gxWoLYIMPP/5Byevrg==
X-Received: by 2002:a17:902:6848:b0:13a:4ffd:202e with SMTP id f8-20020a170902684800b0013a4ffd202emr5105920pln.79.1631804521218;
        Thu, 16 Sep 2021 08:02:01 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id p4sm3286640pjb.11.2021.09.16.08.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 08:02:00 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mQsti-001mPG-QU; Thu, 16 Sep 2021 12:01:58 -0300
Date:   Thu, 16 Sep 2021 12:01:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wenpeng Liang <liangwenpeng@huawei.com>,
        Weihang Li <liweihang@huawei.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: Build regressions/improvements in v5.15-rc1
Message-ID: <20210916150158.GM3544071@ziepe.ca>
References: <20210913070906.1941147-1-geert@linux-m68k.org>
 <CAMuHMdWHDOC2WedHfgYh2nwijEsqnb3+LXgHwST29TaLugiTdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWHDOC2WedHfgYh2nwijEsqnb3+LXgHwST29TaLugiTdA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 13, 2021 at 09:20:44AM +0200, Geert Uytterhoeven wrote:
> On Mon, Sep 13, 2021 at 9:10 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v5.15-rc1[1] compared to v5.14[2].
> >
> > Summarized:
> >   - build errors: +62/-12
> 
> >   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_1859' declared with attribute error: FIELD_PREP: value too large for the field:  => 322:38
> >   + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_1866' declared with attribute error: FIELD_PREP: value too large for the field:  => 322:38
> 
> Actual error in drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> 
> arm64-gcc5.4/arm64-allmodconfig
> arm64-gcc8/arm64-allmodconfig

This happens with v5.14 too, so it isn't a new error..

I've got a patch

Jason
