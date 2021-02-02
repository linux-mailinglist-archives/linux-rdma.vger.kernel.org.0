Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C9C30CACB
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Feb 2021 20:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237895AbhBBTAQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Feb 2021 14:00:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239220AbhBBS60 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 2 Feb 2021 13:58:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABFF264F4B;
        Tue,  2 Feb 2021 18:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612292266;
        bh=xf2Q8is6hMbt5A7jpEuiz75K+Shu/poZ88rC7X4bPK0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TzTsGAt1nZDx4nu8UZdrnEZJZZit6PFPHxPwq7zkBuFPRH1D4i6o6nQXmTyutlYND
         yzvhsHTXBuwp/I7jov6hhRdpeAXGgEc7bfjXSu4Jyzoig12P+bDCk6vdTPm+I/GMM1
         qUT6BwVNgQRHSg6274Dx52W2B4akl1eooRyU35+5Ywziwy6CqQp2tlkYrC2ZVV8sAU
         3v8ci1zB8vioAgmBlkQ+ZEr0DMiuQtGZMIon+J/3FtbB6/FL2q0jvx6MOOgab07anu
         DTi2u5qPmptBSsWVudDJVdfVzkTJGwNIjd81LvCC2hamWeWcQc1nSPAu9i6WAQ9zFm
         FHWJSKRORfQgQ==
Date:   Tue, 2 Feb 2021 20:57:42 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Parav Pandit <parav@nvidia.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Mark Bloch <mbloch@nvidia.com>
Subject: Re: [PATCH rdma-next 07/10] IB/mlx5: Return appropriate error code
 instead of ENOMEM
Message-ID: <20210202185742.GF3264866@unreal>
References: <20210127150010.1876121-1-leon@kernel.org>
 <20210127150010.1876121-8-leon@kernel.org>
 <20210202152109.GA617190@nvidia.com>
 <BY5PR12MB43220FA2D87A12FEBA246227DCB59@BY5PR12MB4322.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR12MB43220FA2D87A12FEBA246227DCB59@BY5PR12MB4322.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 02, 2021 at 04:01:24PM +0000, Parav Pandit wrote:
>
>
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, February 2, 2021 8:51 PM
> > >
> > >  	xa_lock(&imr->implicit_children);
> > > -	/*
> > > -	 * Once the store to either xarray completes any error unwind has to
> > > -	 * use synchronize_srcu(). Avoid this with xa_reserve()
> > > -	 */
> >
> > It is not wrong to remove this comment, but why is it in this patch?
> >
> > Jason
>
> Hi Leon,
> Can you please check your tree, how this hunk got merged in this patch?
> In my internal gerrit submission, I do not have this hunk.
> May be somehow it got here as part of Yishai's ODP srcu patches?

This explains why I didn't find this hunk in Yishai's patch.
https://lore.kernel.org/linux-rdma/20210128064812.1921519-1-leon@kernel.org

Thanks.
