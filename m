Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9EB1BD769
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2020 10:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgD2Ihr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Apr 2020 04:37:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbgD2Ihr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 29 Apr 2020 04:37:47 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9635620731;
        Wed, 29 Apr 2020 08:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588149466;
        bh=gQATlOm3IBUtB029tWp/wY8w5JgJe69V++ew8TJI3B0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sq4k+a16SKzNJhEXtlSGKkK9Lef5a7FjNzqtj8D6+LQsw1KasIDfGkhhTvYCybwl/
         aUGYp7R/QqYAyMDKPoL+UdXk3h9+vAQD7hotUuLPvyvtLlF+vKkPKJzIzwxNSNrXKh
         28lU33JrJn7IYskhRWdhn0tOoHiAx++1icamKpHY=
Date:   Wed, 29 Apr 2020 11:37:42 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     liweihang <liweihang@huawei.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "selvin.xavier@broadcom.com" <selvin.xavier@broadcom.com>,
        "devesh.sharma@broadcom.com" <devesh.sharma@broadcom.com>,
        "somnath.kotur@broadcom.com" <somnath.kotur@broadcom.com>,
        "sriharsha.basavapatna@broadcom.com" 
        <sriharsha.basavapatna@broadcom.com>,
        "bharat@chelsio.com" <bharat@chelsio.com>,
        "galpress@amazon.com" <galpress@amazon.com>,
        "sleybo@amazon.com" <sleybo@amazon.com>,
        "faisal.latif@intel.com" <faisal.latif@intel.com>,
        "shiraz.saleem@intel.com" <shiraz.saleem@intel.com>,
        "yishaih@mellanox.com" <yishaih@mellanox.com>,
        "mkalderon@marvell.com" <mkalderon@marvell.com>,
        "aelior@marvell.com" <aelior@marvell.com>,
        "benve@cisco.com" <benve@cisco.com>,
        "neescoba@cisco.com" <neescoba@cisco.com>,
        "pkaustub@cisco.com" <pkaustub@cisco.com>,
        "aditr@vmware.com" <aditr@vmware.com>,
        "pv-drivers@vmware.com" <pv-drivers@vmware.com>,
        "monis@mellanox.com" <monis@mellanox.com>,
        "kamalheib1@gmail.com" <kamalheib1@gmail.com>,
        "parav@mellanox.com" <parav@mellanox.com>,
        "markz@mellanox.com" <markz@mellanox.com>,
        "rd.dunlab@gmail.com" <rd.dunlab@gmail.com>,
        "dennis.dalessandro@intel.com" <dennis.dalessandro@intel.com>
Subject: Re: [PATCH for-next] RDMA/core: Assign the name of device when
 allocating ib_device
Message-ID: <20200429083742.GA469920@unreal>
References: <1587893517-11824-1-git-send-email-liweihang@huawei.com>
 <20200427114734.GC134660@unreal>
 <20200427115201.GN26002@ziepe.ca>
 <20200427120337.GD134660@unreal>
 <B82435381E3B2943AA4D2826ADEF0B3A0232A133@DGGEML522-MBX.china.huawei.com>
 <20200428111907.GI134660@unreal>
 <B82435381E3B2943AA4D2826ADEF0B3A0232A3E3@DGGEML522-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B82435381E3B2943AA4D2826ADEF0B3A0232A3E3@DGGEML522-MBX.china.huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 28, 2020 at 12:39:49PM +0000, liweihang wrote:
> On 2020/4/28 19:19, Leon Romanovsky wrote:
> > On Tue, Apr 28, 2020 at 08:00:29AM +0000, liweihang wrote:
> >> On 2020/4/27 20:03, Leon Romanovsky wrote:
> >>>>>>  /**
> >>>>>>   * _ib_alloc_device - allocate an IB device struct
> >>>>>>   * @size:size of structure to allocate
> >>>>>> + * @name: unique string device name. This may include a '%' which will
> >>>>> It looks like all drivers are setting "%" in their name and "name" can
> >>>>> be changed to be "prefix".
> >>>> Does hfi? I thought the name was forced there for some port swapped
> >>>> reason?
> >>> This patch doesn't touch HFI, nothing prohibits from us to make this
> >>> conversion work for all drivers except HFI and for the HFI add some
> >>> different callback. There is no need to make API harder just because
> >>> one driver needs it.
> >>>
> >>> Thanks
> >>>
> >>>> Jason
> >>
> >> Hi Jason and Leon,
> >>
> >> I missed some codes related to assign_name() in this series including
> >> hfi/qib as Shiraz pointed. And I found a "name" without a "%" in following
> >> funtions in core/nldev.c, and ibdev_name will be used for rxe/siw later.
> >>
> >> 	static int nldev_newlink(struct sk_buff *skb, struct nlmsghdr *nlh,
> >> 				  struct netlink_ext_ack *extack)
> >> 	{
> >> 		...
> >>
> >> 		nla_strlcpy(ibdev_name, tb[RDMA_NLDEV_ATTR_DEV_NAME],
> >> 			    sizeof(ibdev_name));
> >> 		if (strchr(ibdev_name, '%') || strlen(ibdev_name) == 0)
> >> 			return -EINVAL;
> >>
> >> 		...
> >> 	}
> >>
> >> I'm not familiar with these codes, but I think the judgment in assign_name()
> >> is for the situaion like above.
> >>
> >> 	if (strchr(name, '%'))
> >> 		ret = alloc_name(device, name);
> >> 	else
> >> 		ret = dev_set_name(&device->dev, name);
> >>
> >> So is it a better idea to keep using "name" instead of "prefix"?
> >
> > nldev_newlink() doesn't call to ib_alloc_device() and alloc_name(). The
> > check pointed by you is for the user input.
> >
>
> Hi Leon,
>
> nldev_newlink() will call "ops->newlink(ibdev_name, ndev)", and it point to
> siw_newlink() in siw_main.c. And then it will call ib_alloc_device() and
> ib_register_device().
>
> According to the code I pointed before, it seems that nldev_newlink()
> expects users to input a name without '%', and then passes this name
> to assign_name(). I think siw/rxe have to call ib_alloc_device() with
> a name without '%', so we can't treat it as a prefix and add "_%d" to
> it like for other drivers.

The opposite is actually true.

The reason why newlink checks for % is due to the expectation in
alloc_name() to have a name with % for numbered devices, which is
nice, but the better API will be to provide "prefix" and a flag
if to append an index or not.

Thanks

>
> >>
> >> Thanks
> >> Weihang
> >
>
