Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 336C321234E
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2020 14:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgGBM1i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jul 2020 08:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgGBM1i (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 2 Jul 2020 08:27:38 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5F5C08C5C1
        for <linux-rdma@vger.kernel.org>; Thu,  2 Jul 2020 05:27:38 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id r12so16803339ilh.4
        for <linux-rdma@vger.kernel.org>; Thu, 02 Jul 2020 05:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KbXF3rVnE9Y+VvMzTuHkqkyR4wyjUs/wKLmuVOcm6+0=;
        b=gP3cBBNSsS80JZ9P5WC6YNQZ7v0N/xYCN2O+TyWeFsxablR8ZFXbLP4q37u6ltcfHR
         CUSk25nlb5msSP3XQUmNiPsyAR2mBpSFEso6szQhgfM2ptS3Ia1K+6kTRTOBl1RDtrjF
         d1Q/DOyk4kNSzS5hMLx9n6xKDPB+nE12lAGqg/wOyVDjn9ceKJ48fDXA2rjCloEONxvS
         2nRThEbBdg2vDGJjjZjk0WDQ+PTBGVJJKcGDDYx/jtSsjVdSY5ERqe/lDink9KKM0QOc
         /lckCOfIP7rbu9cSQdZW3jq5yygjJ07SeWmdoDo5CD5OGpc7+V+J+ppvEmcFYKv4DfBM
         mg2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KbXF3rVnE9Y+VvMzTuHkqkyR4wyjUs/wKLmuVOcm6+0=;
        b=YJ1SARX/SwxaVGc/AfeT8YDVep2ec9P/eG1DMw54ruprcg6XmMy+6w5kDFtCbKjRKj
         qIU6SUbr8BEYbtQllgHJQZ8/lP74qWyLco56YwjUDEgNYDhyvp3GXsedws0lxKsY+6jB
         v7QKrNDF0SlUlVC4LoqIn6H8WA1HWe1XN4nptA8BLkxK6lcJm+ZijUOIjBEOEGkAOD89
         9uAxF/lgMnOTHfrZ0R7g7q9oc/qG6vHpdPV/C9H3N+tI4VPNCukkXo/Pc1yJAlqvVKIw
         VP+vbUXXMw/uuAaMcMSKY0VhNx1pErpcF8D6vBcC9x8FAk19ixBM3o/h53x4hIyBwRjV
         xgKw==
X-Gm-Message-State: AOAM5322/gJWlXcc0TszWq5qkcXMEmOSmY32eGqE0OhbQkF/nwoASJOB
        eOzIp47ime6bknMwFobCkXKPdA==
X-Google-Smtp-Source: ABdhPJy97My/0BHrvS8CjsBg5Hl5wpr2Xfxh8eavaInlBkgzXSCZgRpkLqT4lq3H4wuhX4XIGaiFuA==
X-Received: by 2002:a92:bb55:: with SMTP id w82mr12721102ili.146.1593692857820;
        Thu, 02 Jul 2020 05:27:37 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id d77sm5062859ill.67.2020.07.02.05.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 05:27:37 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jqyJU-002qqy-B3; Thu, 02 Jul 2020 09:27:36 -0300
Date:   Thu, 2 Jul 2020 09:27:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Xiong, Jianxin" <jianxin.xiong@intel.com>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Leon Romanovsky <leon@kernel.org>,
        "Vetter, Daniel" <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [RFC PATCH v2 0/3] RDMA: add dma-buf support
Message-ID: <20200702122736.GR25301@ziepe.ca>
References: <1593451903-30959-1-git-send-email-jianxin.xiong@intel.com>
 <20200629185152.GD25301@ziepe.ca>
 <MW3PR11MB4555A99038FA0CFC3ED80D3DE56F0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20200630173435.GK25301@ziepe.ca>
 <MW3PR11MB45553FA6D144BF1053571D98E56F0@MW3PR11MB4555.namprd11.prod.outlook.com>
 <20200630191700.GL25301@ziepe.ca>
 <MW3PR11MB4555223B6D3C6E4829795798E56F0@MW3PR11MB4555.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW3PR11MB4555223B6D3C6E4829795798E56F0@MW3PR11MB4555.namprd11.prod.outlook.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 30, 2020 at 08:08:46PM +0000, Xiong, Jianxin wrote:
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Tuesday, June 30, 2020 12:17 PM
> > To: Xiong, Jianxin <jianxin.xiong@intel.com>
> > Cc: linux-rdma@vger.kernel.org; Doug Ledford <dledford@redhat.com>; Sumit Semwal <sumit.semwal@linaro.org>; Leon Romanovsky
> > <leon@kernel.org>; Vetter, Daniel <daniel.vetter@intel.com>; Christian Koenig <christian.koenig@amd.com>; dri-
> > devel@lists.freedesktop.org
> > Subject: Re: [RFC PATCH v2 0/3] RDMA: add dma-buf support
> > 
> > > >
> > > > On Tue, Jun 30, 2020 at 05:21:33PM +0000, Xiong, Jianxin wrote:
> > > > > > > Heterogeneous Memory Management (HMM) utilizes
> > > > > > > mmu_interval_notifier and ZONE_DEVICE to support shared
> > > > > > > virtual address space and page migration between system memory
> > > > > > > and device memory. HMM doesn't support pinning device memory
> > > > > > > because pages located on device must be able to migrate to
> > > > > > > system memory when accessed by CPU. Peer-to-peer access is
> > > > > > > possible if the peer can handle page fault. For RDMA, that means the NIC must support on-demand paging.
> > > > > >
> > > > > > peer-peer access is currently not possible with hmm_range_fault().
> > > > >
> > > > > Currently hmm_range_fault() always sets the cpu access flag and
> > > > > device private pages are migrated to the system RAM in the fault handler.
> > > > > However, it's possible to have a modified code flow to keep the
> > > > > device private page info for use with peer to peer access.
> > > >
> > > > Sort of, but only within the same device, RDMA or anything else generic can't reach inside a DEVICE_PRIVATE and extract anything
> > useful.
> > >
> > > But pfn is supposed to be all that is needed.
> > 
> > Needed for what? The PFN of the DEVICE_PRIVATE pages is useless for anything.
> 
> Hmm. I thought the pfn corresponds to the address in the BAR range. I could be
> wrong here. 

No, DEVICE_PRIVATE is a dummy pfn to empty address space.

Jason
