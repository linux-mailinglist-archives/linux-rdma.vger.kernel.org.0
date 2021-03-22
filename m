Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C038C343A91
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Mar 2021 08:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhCVH3R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Mar 2021 03:29:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:35922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229822AbhCVH2z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Mar 2021 03:28:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E758161927;
        Mon, 22 Mar 2021 07:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616398134;
        bh=d+qyYs+0g3vIcJZ+/OhsjA3yJl/G5ZOVY+jZn5oeLUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vCoKfV9ytd1dOEVNSjuV5vuDTGXNczvWOv0zC/cWDnaB7ohINZ2f7jcxlNk0Du4xo
         lS2W63Z/CyQ/HaAdBTBSgrx/cHLiPdpis4+24LP4WXPWTeAfut2DIAplywGcjvwPIO
         tcVs6+lUFZDuSUABY2ABERlFnLHBdAzl0Geq7R7lxwejObR2k8i++JRowruBRwh4rw
         ruk+oYoe2L6niK5WKq20trfEb2FG6hlaxGvgxqMCDvE6Kh+1ZAERGUMcoIXPsxrvon
         WjrgY2XAd2hqOelT9KoODux5trFEX1F7SqPPCtkBJSHJ0OcPzN3CwiTS0NHR2112Iv
         2xA/FnNEA7Jzg==
Date:   Mon, 22 Mar 2021 09:28:50 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     liweihang <liweihang@huawei.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH for-next] RDMA/core: Check invalid QP state for
 ib_modify_qp_is_ok()
Message-ID: <YFhHMlnzdcAMp3qs@unreal>
References: <1616144545-18159-1-git-send-email-liweihang@huawei.com>
 <YFXBprYFmFgHu9Z8@unreal>
 <53ff6a59a9a74443bca58bcaee6292bb@huawei.com>
 <YFgveGZ+fnDKPB81@unreal>
 <d1cbb0213aba493695162ee07d0d0338@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1cbb0213aba493695162ee07d0d0338@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Mar 22, 2021 at 07:11:47AM +0000, liweihang wrote:
> On 2021/3/22 13:47, Leon Romanovsky wrote:
> > On Mon, Mar 22, 2021 at 03:29:09AM +0000, liweihang wrote:
> >> On 2021/3/20 17:34, Leon Romanovsky wrote:
> >>> On Fri, Mar 19, 2021 at 05:02:25PM +0800, Weihang Li wrote:
> >>>> From: Xi Wang <wangxi11@huawei.com>
> >>>>
> >>>> Out-of-bounds may occur in 'qp_state_table' when the caller passing wrong
> >>>> QP state value.
> >>> How is it possible? Do you have call stack to support it?
> >>>
> >>> Thanks
> >>>
> >> ib_modify_qp_is_ok() is exported, I think any kernel modules can pass in
> >> invalid QP state. Should we check it in such case?
> > No, it is caller responsibility to supply valid input.
> > In general case, for the kernel code, it can be seen as anti-pattern
> > if in-kernel API performs input sanity check.
> > 
> > You can add WARN_ON() if you want to catch programmers errors earlier.
> > However, I'm skeptical if it is really needed here. 
> > 
> > Thanks
> > 
> 
> Hi Leon,
> 
> By the way, we made this change because we noticed that ib_event_msg() and
> ib_wc_status_msg() that tries to access an array performs input check in the
> same file. Is there anything different between these kernel APIs? Or there is
> some other reasons?

The main difference between them is the execution flow.
 * ib_modify_qp_is_ok() is called from the drivers, after verbs layer
   sanitized everything already and at this stage we are pretty safe.
 * ib_event_msg()/ib_wc_status_ms() are used by ULPs and maybe they can
   send invalid event. I personally don't know if it is possible or not.

Thanks

> 
> Thanks,
> Weihang
> 
