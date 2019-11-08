Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 495A7F4EBF
	for <lists+linux-rdma@lfdr.de>; Fri,  8 Nov 2019 15:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfKHOxE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 8 Nov 2019 09:53:04 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:39226 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbfKHOxE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 8 Nov 2019 09:53:04 -0500
Received: by mail-qv1-f67.google.com with SMTP id v16so2287175qvq.6
        for <linux-rdma@vger.kernel.org>; Fri, 08 Nov 2019 06:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KbZhp4AkDu7Xm430isAdIZqP2fKWimvIRojP4EOaH94=;
        b=CnUhcgt/uCiHhFzG5fQwx/7yL/1CG4oXAa5rt7QVxsRyYE9BvjQnSrmpCegteZ6wG6
         UdbIqy2G3VBCdlFsOHxs/+U1RPE3dzDODchlcknxyMkLszr7SBFzpBBLTiddH4Tg08Ht
         mzvu2U3GfPtm+8nhuisFAzAvLGGBD26Rr2qKwRtahR5/cWZ9Dw2546KcysI5+LmkFl4f
         uw4TZt8ZwEN4pTKLcXSMHSPwzQXJJ83lX+Vu0OBNgSn6qsoG5vEKP04ONdCWloYbp4p+
         mbwxr54K0neA//wodYLjyKVnqB2cadeD0Xva/t+JRc+rAwGI6mVj5ESfMeaSIg5DxLSM
         vL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KbZhp4AkDu7Xm430isAdIZqP2fKWimvIRojP4EOaH94=;
        b=fOLHY2tLgGH4aXuxNS3SLPh1P7kDSQ3G3Xs0dyj/TooGmHA9DH/SvBB1zwQXpG/cyb
         aqHX91Caegohs6H1tlwNyDQELvsv4hfYpBb376tqQlg9x+mtboRqavs+ytovT5kmbDus
         WZZqkGH7/7tsZYWP6Yh4+HPrAKGuflbMIVPVlnvQ14BlAxY8XZT8KrR5oHcpTiJmnaH0
         6NFliDvTLjX2xUDyBndyLzout9Q2dFazPLJgsvLWGPBzfMfon6LSXxuUnXagzT1s4Jcb
         vEYX5REERleGrBeYIK+Gec10R5ueKrF+3OHB7zNQ4nDUZolCPHvPVD2PmHBHfriQKYdk
         e4TQ==
X-Gm-Message-State: APjAAAW/bseJsLyATKt1PiDGSCjbSuZ0B9I7Bgb3oWRqrp2gjqCSsVgQ
        IsFv2gMmL3oB8Nh8ZHqKDcrxNg==
X-Google-Smtp-Source: APXvYqxZ049SfJ3c2UO0ME4Y6QYpdzEBI6gXk0X7dNRcV8X3z8aw7kr92ScWfx2YoejxONb2FvDR8w==
X-Received: by 2002:a05:6214:11f2:: with SMTP id e18mr10122108qvu.86.1573224783191;
        Fri, 08 Nov 2019 06:53:03 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id o3sm3732759qta.3.2019.11.08.06.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Nov 2019 06:53:02 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iT5dF-0003YQ-V5; Fri, 08 Nov 2019 10:53:01 -0400
Date:   Fri, 8 Nov 2019 10:53:01 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Petr Cvek <petrcvekcz@gmail.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 09/15] xen/gntdev: use mmu_range_notifier_insert
Message-ID: <20191108145301.GD10956@ziepe.ca>
References: <20191028201032.6352-1-jgg@ziepe.ca>
 <20191028201032.6352-10-jgg@ziepe.ca>
 <3938b588-c6c5-3bd1-8ea9-47e4d5b2045c@oracle.com>
 <20191105023108.GN22766@mellanox.com>
 <a62e58f6-d98b-1feb-d0ca-fb8210f3e831@oracle.com>
 <20191107203629.GF6730@ziepe.ca>
 <4a68acc6-3ce7-e26b-2c98-774867288410@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a68acc6-3ce7-e26b-2c98-774867288410@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 07, 2019 at 05:54:52PM -0500, Boris Ostrovsky wrote:
> On 11/7/19 3:36 PM, Jason Gunthorpe wrote:
> > On Tue, Nov 05, 2019 at 10:16:46AM -0500, Boris Ostrovsky wrote:
> >
> >>> So, I suppose it can be relaxed to a null test and a WARN_ON that it
> >>> hasn't changed?
> >> You mean
> >>
> >> if (use_ptemod) {
> >>         WARN_ON(map->vma != vma);
> >>         ...
> >>
> >>
> >> Yes, that sounds good.
> > I amended my copy of the patch with the above, has this rework shown
> > signs of working?
> 
> Yes, it works fine.
> 
> But please don't forget notifier ops initialization.
> 
> With those two changes,
> 
> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Thanks, I got both things. I'll forward this toward linux-next and
repost a v3 

Jason
