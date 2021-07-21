Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AE43D1364
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jul 2021 18:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhGUPaO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Jul 2021 11:30:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:54676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231401AbhGUPaO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Jul 2021 11:30:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E7676100C;
        Wed, 21 Jul 2021 16:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626883850;
        bh=ATbjR5e/Nku6Q63BGC31Ok9sISkS6hGpkLuuBaaVK0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dol824DpEIFytbAdGqq/PDZ6qvwrlmYA0/I30RpnGDx5eI1H5r7mz2Uluikvk6H2b
         94y/V0u2mQAFGKQ6f8OxAlL7CDOfKQs/DfLYglF814izLaj2QLlHqxB3qeE/eKzEl6
         fpglALaLsBsDYft2N5h9wHE2RAdXUrDlisT8dtsA=
Date:   Wed, 21 Jul 2021 18:10:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org, jgg@ziepe.ca,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        daniel.vetter@ffwll.ch, galpress@amazon.com, sleybo@amazon.com,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, dledford@redhat.com,
        airlied@gmail.com, alexander.deucher@amd.com, leonro@nvidia.com,
        hch@lst.de, amd-gfx@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v5 0/2] Add p2p via dmabuf to habanalabs
Message-ID: <YPhHCIoHzMnbIfeF@kroah.com>
References: <20210711140601.7472-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210711140601.7472-1-ogabbay@kernel.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Jul 11, 2021 at 05:05:59PM +0300, Oded Gabbay wrote:
> Hi,
> This is v5 of this patch-set following again a long email thread.
> 
> It contains fixes to the implementation according to the review that Jason
> did on v4. Jason, I appreciate your feedback. If you can take another look
> to see I didn't miss anything that would be great.
> 
> The details of the fixes are in the changelog in the commit message of
> the second patch.
> 
> There was one issue with your proposal to set the orig_nents to 0. I did
> that, but I also had to restore it to nents before calling sg_free_table
> because that function uses orig_nents to iterate.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
