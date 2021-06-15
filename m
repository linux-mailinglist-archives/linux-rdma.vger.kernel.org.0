Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B886E3A7643
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jun 2021 07:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhFOFKs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Jun 2021 01:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229659AbhFOFKr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 15 Jun 2021 01:10:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 795236124B;
        Tue, 15 Jun 2021 05:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623733723;
        bh=5kFE330+23kMptN9HbNNWQMTPI9CdBPnkIgY+SruPBo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ge3dORCzCE1Dr1+BfbVTPnYwkHlQFN2bAhPJQ3dH4Bbk76TB+BuoUA7wRpThsL+Ea
         G8zRZQhyrLKUaxNuuAQyGoUnsAC3aT9SpKX/TXjfHHk2rVErA40ESA2V9PTCTUxoZi
         oWrui0xJYq4EkeoGmAFeyAQu0YDFID3eb+K4ro0T+dFlT+qxH/fKGLYqM42r2yVAn4
         yJyF1oRXJUKbM+r3E8U9Yux+mLaOZgfjUc0Bzo7zWjiX+dBXhbbwuFUX43D3PfFWqe
         HIf+u7x043QzN732HjnjjenJma+R6GjYrOPmrnrjBvTd2aD5FwnyusGynr/i7UUvp6
         /uszxz8R/nR1w==
Date:   Tue, 15 Jun 2021 08:08:39 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Anand Khoje <anand.a.khoje@oracle.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: Re: [PATCH v3 3/3] IB/core: Obtain subnet_prefix from cache in IB
 devices.
Message-ID: <YMg111mLzwqu8P0o@unreal>
References: <20210609055534.855-1-anand.a.khoje@oracle.com>
 <20210609055534.855-4-anand.a.khoje@oracle.com>
 <YMB9gxlKbDvdynUE@unreal>
 <MWHPR1001MB2096CA7F29DCF86DE921903EC5369@MWHPR1001MB2096.namprd10.prod.outlook.com>
 <YMCakSCQLqUbcQ1H@unreal>
 <30CD8612-2030-44C1-A879-9A1EC668FC9C@oracle.com>
 <YMcEbBrDyDgmYEPu@unreal>
 <CAEBEBEC-795E-4626-A842-2BD156EBB9FE@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEBEBEC-795E-4626-A842-2BD156EBB9FE@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 14, 2021 at 04:29:09PM +0000, Haakon Bugge wrote:
> 
> 
> > On 14 Jun 2021, at 09:25, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > On Mon, Jun 14, 2021 at 03:32:39AM +0000, Haakon Bugge wrote:
> >> 
> >> 
> >>> On 9 Jun 2021, at 12:40, Leon Romanovsky <leon@kernel.org> wrote:
> >>> 
> >>> On Wed, Jun 09, 2021 at 09:26:03AM +0000, Anand Khoje wrote:
> >>>> Hi Leon,
> >>> 
> >>> Please don't do top-posting.
> >>> 
> >>> 
> >>>> 
> >>>> The set_bit()/clear_bit() and enum ib_port_data_flags  has been added as a device that can be used for future enhancements. 
> >>>> Also, usage of set_bit()/clear_bit() ensures the operations on this bit is atomic.
> >>> 
> >>> The bitfield variables are better suit this use case.
> >>> Let's don't overcomplicate code without the reason.
> >> 
> >> The problem is always that people tend to build on what's in there. For example, look at the bitfields in rdma_id_private, tos_set,  timeout_set, and min_rnr_timer_set.
> >> 
> >> What do you think will happen when, let's say, rdma_set_service_type() and rdma_set_ack_timeout() are called in close proximity in time? There is no locking, and the RMW will fail intermittently.
> > 
> > We are talking about device initialization flow that shouldn't be
> > performed in parallel to another initialization of same device, so the
> > comparison to rdma-cm is not valid here.
> 
> I can agree to that. And it is probably not worthwhile to fix the bit-fields in rdma_id_private?

Before this article [1], I would say no, we don't need to fix.
Now, I'm not sure about that.

"He also notes that even though the design flaws are difficult to exploit
 on their own, they can be combined with the other flaws found to make for
 a much more serious problem."

and 

"In other words, people did notice this vulnerability and a defense was standardized,
 but in practice the defense was never adopted. This is a good example that security
 defenses must be adopted before attacks become practical."

Thanks

[1] https://lwn.net/Articles/856044/ - Holes in WiFi

> 
> 
> Thxs, Håkon
> 
