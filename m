Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7803B30E18F
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Feb 2021 18:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhBCR5j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Feb 2021 12:57:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbhBCR5h (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 3 Feb 2021 12:57:37 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F5FC061573
        for <linux-rdma@vger.kernel.org>; Wed,  3 Feb 2021 09:56:56 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id l14so403860qvp.2
        for <linux-rdma@vger.kernel.org>; Wed, 03 Feb 2021 09:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J1HhI30b58fysvdWOivIB7OV9/EQ+3BS+Aaq7uAwxG0=;
        b=GK9u8JloLApwPgelE9I8CpPnbDqHIvSCIuKhg1ahJkqsGTzXhtfdNpxVTGPvblNamD
         kIemMFRktQx3yacvQ+AVT1qS6V1OB0wHtRqOtTd00z54FjB9tUcJ4vz4ry2lPRw3oK5I
         PwJS9lOGVgDTzDAUcNfo3r1w4AKJBoBZJ2j+FlXl2OHxpTcH4yob7lTGlM5kuDUU2i6h
         ab2UqFMI7o+UrfLlkN2SZKNqk/4VdjxA1gPrZL+J4+PhZLQ0l36gudDmqmvDFqci1T5D
         jZY6GPL2kHrm2xx+OwPdZf8m/gBydfzD7yr1bqGuEDL/tg8MrkdTPstWceZMuzX1iNvY
         XHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J1HhI30b58fysvdWOivIB7OV9/EQ+3BS+Aaq7uAwxG0=;
        b=nwtfJiXe9sldzEw3Yn51WK2ivIPTqhpcr49G2UwU8K4rjKqEt0FFaQRlG5KP4W4IWP
         nw6nEK9DHaOOh2mcNr3YWmhatnrR6QPIZsbK6RWvmckMg4eiVma/JGPFvM7J4IfS7vZG
         m2axPzF/+LP0decYSty5WaDboFcXpvumvT7Ntt6+/41jbj6iRTDEFHzR1A3Z7c5s/m2j
         zkVle1IZMHuehald7aCCnuHVy1XvL8kShbyxYml2ytmyJcQ+K2pGTCzCXUx1iakEGfT2
         iIspcz3ZaCVCevzPevA5jsmQp4N75NMzOmOkbuNCFW+NoW8PdGP9Cjzdx99xtH8Nt3K8
         u8SA==
X-Gm-Message-State: AOAM5323v1Uby+Ak3oBDWxuVh/287ISIVnbUkarur8BSY0UMwc2R7/EO
        k+wUbxq33NTmR2AUEC4iiJiVKQ==
X-Google-Smtp-Source: ABdhPJwhXxgxv9QS34Ar2Iv4pzvwPjB5Gmthi3e4YRqnvrv7TC/fHJkwKXSMxuipr6Ho7ORS2TTicg==
X-Received: by 2002:a0c:8365:: with SMTP id j92mr3713290qva.19.1612375015844;
        Wed, 03 Feb 2021 09:56:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id b13sm1784301qtj.97.2021.02.03.09.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 09:56:55 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l7MOc-0034o2-K6; Wed, 03 Feb 2021 13:56:54 -0400
Date:   Wed, 3 Feb 2021 13:56:54 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     "Xiong, Jianxin" <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Gal Pressman <galpress@amazon.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Edward Srouji <edwards@nvidia.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>
Subject: Re: [PATCH rdma-core v7 4/6] pyverbs: Add dma-buf based MR support
Message-ID: <20210203175654.GR4718@ziepe.ca>
References: <1611604622-86968-5-git-send-email-jianxin.xiong@intel.com>
 <137f406b-d3e0-fdeb-18e7-194a2aed927c@amazon.com>
 <20210201061603.GC4593@unreal>
 <CAKMK7uE0kSC1si0E9D1Spkn9aW2jFJw_SH3hYC6sZL7mG6pzyg@mail.gmail.com>
 <20210201152922.GC4718@ziepe.ca>
 <MW3PR11MB455569DF7B795272687669BFE5B69@MW3PR11MB4555.namprd11.prod.outlook.com>
 <YBluvZn1orYl7L9/@phenom.ffwll.local>
 <20210203060320.GK3264866@unreal>
 <MW3PR11MB455563A3F337F789613A9940E5B49@MW3PR11MB4555.namprd11.prod.outlook.com>
 <CAKMK7uHAD5FbDPeT2cD03HjHhvmMMG__muXqo=rTjd=htSMhtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uHAD5FbDPeT2cD03HjHhvmMMG__muXqo=rTjd=htSMhtg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Feb 03, 2021 at 06:53:19PM +0100, Daniel Vetter wrote:
> > > rdma-core uses cmake build system and in our case cmake
> > > find_library() is preferable over pkgconfig.
> >
> > Only the headers are needed, and they could be installed via
> > either the libdrm-devel package or the kernel-headers package. The
> > cmake find_path() command is more suitable here.
> 
> Except if your distro is buggy (or doesn't support any gpu drivers at
> all) they will never be installed as part of kernel-headers.

pkgconfig is OK, we use it for libnl for similar reasons, I just don't
like it to see it used gratuitously as it can cause more problems than
it solves

Jason
