Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E052DFD29
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Oct 2019 07:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbfJVFou (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Oct 2019 01:44:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:57888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbfJVFou (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Oct 2019 01:44:50 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94C3921783;
        Tue, 22 Oct 2019 05:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571723089;
        bh=cNMvuD6+jkiPapZK4nlY/UnpYJs1xw095zZlvZl21NE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hc+a2vBQMXVXVHE4lFjHMXZWEG99ZP7gpFySipjaqwb5ttcH2PZIKdVmDSChidIA6
         luOY8voITCrGfjbT+bYKNLfYFhr4bMDvRA2aTEtmvmHgnbABG4uzPaQDSWm6Uzo+MY
         NwgsQMGEYk66IX0X5KdKXrIZJkmKc00IvLGNNnJ8=
Date:   Tue, 22 Oct 2019 08:44:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     oulijun <oulijun@huawei.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [RFC PATCH V2 for-next] RDMA/hns: Add UD support for hip08
Message-ID: <20191022054445.GF4853@unreal>
References: <1571474772-2212-1-git-send-email-oulijun@huawei.com>
 <20191021141312.GD25178@ziepe.ca>
 <9eea1f7b-fef1-080a-2f54-64b914822c94@huawei.com>
 <ad4a492cfd16ab37186d7fdead215ba52f5c3da5.camel@redhat.com>
 <4ab0f98e4569a9700d94173c7f3d93e00bd9635b.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <4ab0f98e4569a9700d94173c7f3d93e00bd9635b.camel@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 21, 2019 at 12:45:56PM -0400, Doug Ledford wrote:
> On Mon, 2019-10-21 at 10:58 -0400, Doug Ledford wrote:
> > On Mon, 2019-10-21 at 22:20 +0800, oulijun wrote:
> > > =E5=9C=A8 2019/10/21 22:13, Jason Gunthorpe =E5=86=99=E9=81=93:
> > > > On Sat, Oct 19, 2019 at 04:46:12PM +0800, Lijun Ou wrote:
> > > > > index bd78ff9..722cc5f 100644
> > > > > +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
> > > > > @@ -377,6 +377,10 @@ static int hns_roce_set_user_sq_size(struct
> > > > > hns_roce_dev *hr_dev,
> > > > >  		hr_qp->sge.sge_cnt =3D roundup_pow_of_two(hr_qp-
> > > > > > sq.wqe_cnt *
> > > > >  							(hr_qp-
> > > > > > sq.max_gs - 2));
> > > > >
> > > > > +	if (hr_qp->ibqp.qp_type =3D=3D IB_QPT_UD)
> > > > > +		hr_qp->sge.sge_cnt =3D roundup_pow_of_two(hr_qp-
> > > > > > sq.wqe_cnt *
> > > > > +						       hr_qp-
> > > > > > sq.max_gs);
> > > > > +
> > > > >  	if ((hr_qp->sq.max_gs > 2) && (hr_dev->pci_dev->revision
> > > > > =3D=3D
> > > > > 0x20)) {
> > > > >  		if (hr_qp->sge.sge_cnt > hr_dev-
> > > > > >caps.max_extend_sg) {
> > > > >  			dev_err(hr_dev->dev,
> > > > > @@ -1022,6 +1026,9 @@ struct ib_qp *hns_roce_create_qp(struct
> > > > > ib_pd *pd,
> > > > >  	int ret;
> > > > >
> > > > >  	switch (init_attr->qp_type) {
> > > > > +	case IB_QPT_UD:
> > > > > +		if (!capable(CAP_NET_RAW))
> > > > > +			return -EPERM;
> > > > This needs a big comment explaining why this HW requires it.
> > > >
> > > > Jason
> > > >
> > > Add the detail comments for HW limit?
> >
> > I can add those comments while taking the pactch.  Plus we need to add
> > a
> > fallthrough annotation at the same place.  I'll fix it up and unfreeze
> > the hns queue.
> >
>
> Does this meet people's approval?

It is much more detailed than I would imagine, Thanks.

>
>         switch (init_attr->qp_type) {
>         case IB_QPT_UD:
>                 /*
>                  * DO NOT REMOVE!
>                  * The HNS RoCE hardware has a security vulnerability.
>                  * Normally, UD packet routing is achieved using nothing
>                  * but the ib_ah struct, which contains the src gid in the
>                  * sgid_attr element.  Th src gid is sufficient for the
>                  * hardware to know if any vlan tag is needed, as well as
>                  * any priority tag.  In the case of HNS RoCE, the vlan
>                  * tag is passed to the hardware along with the src gid.
>                  * This allows a situation where a malicious user could
>                  * intentionally send packets with a gid that belongs to
>                  * vlan A, but direct the packets to go out to vlan B
>                  * instead.
>                  * Because the ability to send out packets with arbitrary
>                  * headers is reserved for CAP_NET_RAW, and because UD
>                  * queue pairs can be tricked into doing that, make all
>                  * UD queue pairs on this hardware require CAP_NET_RAW.
>                  */
>                 if (!capable(CAP_NET_RAW))
>                         return -EPERM;
>                 /* fallthrough */
>         case IB_QPT_RC: {
>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD


