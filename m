Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007A3493982
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Jan 2022 12:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354136AbiASLbH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Jan 2022 06:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354064AbiASLbH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 19 Jan 2022 06:31:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D3CC061574
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jan 2022 03:31:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10317615E7
        for <linux-rdma@vger.kernel.org>; Wed, 19 Jan 2022 11:31:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A493EC340E7;
        Wed, 19 Jan 2022 11:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642591866;
        bh=kt2c//idVc1BmmuJ1ugidiiZYTuOfqOCmTL5VS7ZFXo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C5U8r3y280JWOi3+uiDWcHcaHh1Mybys0ClvD8iZ8SHKeNjDlVL0Mw0zAtTsKwSQq
         zHpteipSMdOHdTRhxb1PWcF9RutcZYoip/0aDgykgScjIxIdBZ6g0e7NAoEIFosBEs
         SKuFDNOdErT+BZYvx9WDC9nr+EiKqhmG8Ot/7LU9eHHmJF0BzqIViZO5IK3OfqvYNs
         nm4l63SXg4a9QsqZKjmGd9YFmfHbn9CDYN+HsTAzwS8k3oXtRhGicC8+QU+aHBLp8x
         Y655lYjuO/g/RxOMSAwebsj7rQhyjTdOv61nL8XGuWMfe0kQJTIC+UJhIyzeQaV6zL
         +ngcOpSqIXsMg==
Date:   Wed, 19 Jan 2022 13:31:01 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Bernard Metzler <BMT@zurich.ibm.com>
Cc:     Cheng Xu <chengyou@linux.alibaba.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "KaiShen@linux.alibaba.com" <KaiShen@linux.alibaba.com>,
        "tonylu@linux.alibaba.com" <tonylu@linux.alibaba.com>
Subject: Re: Re: [PATCH rdma-next v2 09/11] RDMA/erdma: Add the erdma module
Message-ID: <Yef2daIDIf9R3IYP@unreal>
References: <BYAPR15MB263126902D1FC48911A42BD999599@BYAPR15MB2631.namprd15.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR15MB263126902D1FC48911A42BD999599@BYAPR15MB2631.namprd15.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jan 19, 2022 at 10:15:43AM +0000, Bernard Metzler wrote:
> 
> 
> > -----Original Message-----
> > From: Cheng Xu <chengyou@linux.alibaba.com>
> > Sent: Wednesday, 19 January 2022 05:19
> > To: Bernard Metzler <BMT@zurich.ibm.com>; jgg@ziepe.ca;
> > dledford@redhat.com
> > Cc: leon@kernel.org; linux-rdma@vger.kernel.org;
> > KaiShen@linux.alibaba.com; tonylu@linux.alibaba.com
> > Subject: [EXTERNAL] Re: [PATCH rdma-next v2 09/11] RDMA/erdma: Add the
> > erdma module
> > 
> > 
> > 
> > On 1/18/22 8:53 PM, Bernard Metzler wrote:
> > 
> > <...>
> > 
> > >> +static int erdma_res_cb_init(struct erdma_dev *dev)
> > >> +{
> > >> +	int i;
> > >> +
> > >> +	for (i = 0; i < ERDMA_RES_CNT; i++) {
> > >> +		dev->res_cb[i].next_alloc_idx = 1;
> > >> +		spin_lock_init(&dev->res_cb[i].lock);
> > >> +		dev->res_cb[i].bitmap = kcalloc(BITS_TO_LONGS(dev-
> > >>> res_cb[i].max_cap),
> > >> +						sizeof(unsigned long), GFP_KERNEL);
> > >
> > > better stay with less than 80 chars per line
> > > throughout the patch series (I count currently 287 line wraps).
> > >
> > 
> > The kernel now allows 100 chars per line, and the checkpath.pl also
> > checks using the new rule now. I will try to change this to 80 chars,
> > but it actually makes some code not friendly for reading due to
> > indent.
> > 
> 
> Do we have a recommendation/agreement to stay with 80 chars per line
> for the RDMA subsystem? I'd like it, but I am not sure.

Yes, we continue to use old 80 chars limit.

Thanks

> 
> > <...>
> > 
> 
> Thanks,
> Bernard.
> 
