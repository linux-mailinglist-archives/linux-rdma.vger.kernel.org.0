Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B859182C99
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2020 10:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgCLJjw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Mar 2020 05:39:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:52664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLJjw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Mar 2020 05:39:52 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B8CA20785;
        Thu, 12 Mar 2020 09:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584005991;
        bh=G5Uinvx2tiWyuLs2vokqIVIeCKIVPwg8uACjxidt3NY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gpviTmoaCALYM7FpAjngJmbmfJIst7up+3gyZA0iW9oQJTok9c19JUiCZ+uPmhhZJ
         yiEpxv2OfVFeUn6JPKxDUyhqjo1nd23PuAIzgOl1yYxtNl08LJ+KTUDTC7PE011+Oy
         1bR8JxjuiMHPtJIA2UDSsAtZ62Id/ssMm/NSa2Dc=
Date:   Thu, 12 Mar 2020 11:39:48 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     liweihang <liweihang@huawei.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH v3 for-next] RDMA/hns: Check if depth of qp is 0 before
 configure
Message-ID: <20200312093948.GB31504@unreal>
References: <1583995244-51072-1-git-send-email-liweihang@huawei.com>
 <20200312090438.GB17383@unreal>
 <B82435381E3B2943AA4D2826ADEF0B3A0227BBCE@DGGEML522-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B82435381E3B2943AA4D2826ADEF0B3A0227BBCE@DGGEML522-MBX.china.huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Mar 12, 2020 at 09:27:39AM +0000, liweihang wrote:
> On 2020/3/12 17:04, Leon Romanovsky wrote:
> > On Thu, Mar 12, 2020 at 02:40:44PM +0800, Weihang Li wrote:
> >> From: Lang Cheng <chenglang@huawei.com>
> >>
> >> Depth of qp shouldn't be allowed to be set to zero, after ensuring that,
> >> subsequent process can be simplified. And when qp is changed from reset to
> >> reset, the capability of minimum qp depth was used to identify hardware of
> >> hip06, it should be changed into a more readable form.
> >>
> >> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> >> Signed-off-by: Weihang Li <liweihang@huawei.com>
> >> Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
> >
> > I didn't review, please don't add tags before they explicitly posted.
> > https://lore.kernel.org/linux-rdma/1583140937-2223-1-git-send-email-liweihang@huawei.com/
> >
> > Thanks
> >
>
> Sorry, I misunderstood what you mean about the Reviewed-by tag in
> previous discussions. Will remove it and send a new version.

You are supposed to add those tags if someone writes something like this:
Reviewed-by: ....

Thanks

>
> Thank you
> Weihang
