Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4D92C3FAD
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Nov 2020 13:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgKYMO7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Nov 2020 07:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgKYMO7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Nov 2020 07:14:59 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545B0C0613D4
        for <linux-rdma@vger.kernel.org>; Wed, 25 Nov 2020 04:14:59 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id k3so795374qvz.4
        for <linux-rdma@vger.kernel.org>; Wed, 25 Nov 2020 04:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CG7i2FL/JDKvGKli5PDTjo0AEWVIwdY2iKG2Q3RxuRM=;
        b=ETII1p/RdAj0VyiwyK44BH9uTwjmDBmPMLX0aSN4t9vfJOJwqoZYsTp/+mr9qqMsnl
         tefp1YHvaNliUHg6FO4mtMaNb7+rVR8tI9Fda1Ty86PlRtS+sbtO4/uRPErUr1ND3qNg
         M8EIYjEy9eGlA1V+YStLJTaPQPX12lp2qdpwqDoIw/uUU2I4Nw272p8Qo+1pP2PrNcyY
         29bSyIuF0G9VBCxqWK2CkYZbA3Zg4s0IO+rtZc13Ghs+SLYX/13FrEnYAcfUabvPIvob
         irXBXHKkue0EZdXhzrYiuljYiYhKOKIAnyfLF6JPwdO+keLIBwdu31+nJMfUcuh8WZ2e
         QSxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CG7i2FL/JDKvGKli5PDTjo0AEWVIwdY2iKG2Q3RxuRM=;
        b=DA2D5Fx+PGhWhMXvUY4x6zMXX4GPvhxYSgszlYf2w6jMONvm0i6lpWo0aEWE7jDE+8
         vaNX/oo2NOOia6UDwYU7qp9O6Fw4GzDj8nk1yUf+kQFzMS/LNlOMoCF4S6R1S6GqpCMR
         dYFOXI6YxsM6vPTN2FFHZvT3kMWJKvgm8TOZJnkS1dxsvN1qKXAfxrIW6/PsQfaF1SLe
         OBbotuyJNmTj+Vjim5VIwxYBB2MMNSl8k+LZQDx3s8M3TftAbeJMMoEVdMOWkaDRzpBn
         P6T9xMPmf48BJP+Cq7MidczxUiL9wekcOQ5SeHVuIMxU1nlWGC3WaT7wM/mV7hQN9PLS
         YUkw==
X-Gm-Message-State: AOAM532GTWOGVWvk17dNcQgmkBX32+xOsjgws6eUgAwqsGgtgBNfrwt2
        Of0zxMnB5W91LjwpHCnwnwFnVu6BxoMWYBpP
X-Google-Smtp-Source: ABdhPJz+V2B/4ZjPlvtT2/VsFQQCQw/uDjbCQHi3A4PQRm9rQgFxnWXXRw/gA+G5uIasYJaPtZeSRA==
X-Received: by 2002:a0c:fc52:: with SMTP id w18mr3279519qvp.48.1606306498378;
        Wed, 25 Nov 2020 04:14:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id w54sm2330367qtb.0.2020.11.25.04.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 04:14:57 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1khthI-001AJR-U2; Wed, 25 Nov 2020 08:14:56 -0400
Date:   Wed, 25 Nov 2020 08:14:56 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     "Xiong, Jianxin" <jianxin.xiong@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Doug Ledford <dledford@redhat.com>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [PATCH rdma-core 3/5] pyverbs: Add dma-buf based MR support
Message-ID: <20201125121456.GM5487@ziepe.ca>
References: <1606153984-104583-1-git-send-email-jianxin.xiong@intel.com>
 <1606153984-104583-4-git-send-email-jianxin.xiong@intel.com>
 <20201123180504.GA244516@ziepe.ca>
 <20201124151658.GT401619@phenom.ffwll.local>
 <MW3PR11MB45554AAEB1C370A78EB87816E5FB0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20201125105041.GX401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125105041.GX401619@phenom.ffwll.local>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 25, 2020 at 11:50:41AM +0100, Daniel Vetter wrote:

> Yeah imo makes sense. It's a bunch more code for you to make it work on
> i915 and amd, but it's not terrible. And avoids the dependencies, and also
> avoids the abuse of card* and dumb buffers. Plus not really more complex,
> you just need a table or something to match from the drm driver name to
> the driver-specific buffer create function. Everything else stays the
> same.

If it is going to get more complicated please write it in C then. We
haven't done it yet, but you can link a C function through cython to
the python test script

If you struggle here I can probably work out the build system bits,
but it should not be too terrible

Jason
