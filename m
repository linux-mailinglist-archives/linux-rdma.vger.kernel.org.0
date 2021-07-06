Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA3F3BD635
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jul 2021 14:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbhGFMcB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jul 2021 08:32:01 -0400
Received: from verein.lst.de ([213.95.11.211]:33252 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236451AbhGFMYD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 6 Jul 2021 08:24:03 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9F9BF68C7B; Tue,  6 Jul 2021 14:21:11 +0200 (CEST)
Date:   Tue, 6 Jul 2021 14:21:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Oded Gabbay <ogabbay@kernel.org>, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, sumit.semwal@linaro.org,
        christian.koenig@amd.com, galpress@amazon.com, sleybo@amazon.com,
        dri-devel@lists.freedesktop.org, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        dledford@redhat.com, airlied@gmail.com, alexander.deucher@amd.com,
        leonro@nvidia.com, hch@lst.de, amd-gfx@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v4 0/2] Add p2p via dmabuf to habanalabs
Message-ID: <20210706122110.GA18273@lst.de>
References: <20210705130314.11519-1-ogabbay@kernel.org> <YOQXBWpo3whVjOyh@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOQXBWpo3whVjOyh@phenom.ffwll.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 06, 2021 at 10:40:37AM +0200, Daniel Vetter wrote:
> > Greg, I hope this will be good enough for you to merge this code.
> 
> So we're officially going to use dri-devel for technical details review
> and then Greg for merging so we don't have to deal with other merge
> criteria dri-devel folks have?
> 
> I don't expect anything less by now, but it does make the original claim
> that drivers/misc will not step all over accelerators folks a complete
> farce under the totally-not-a-gpu banner.
> 
> This essentially means that for any other accelerator stack that doesn't
> fit the dri-devel merge criteria, even if it's acting like a gpu and uses
> other gpu driver stuff, you can just send it to Greg and it's good to go.
> 
> There's quite a lot of these floating around actually (and many do have
> semi-open runtimes, like habanalabs have now too, just not open enough to
> be actually useful). It's going to be absolutely lovely having to explain
> to these companies in background chats why habanalabs gets away with their
> stack and they don't.

FYI, I fully agree with Daniel here.  Habanlabs needs to open up their
runtime if they want to push any additional feature in the kernel.
The current situation is not sustainable.
