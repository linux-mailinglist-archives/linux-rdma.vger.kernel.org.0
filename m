Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71CD71572C0
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Feb 2020 11:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgBJKVZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Feb 2020 05:21:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:40260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbgBJKVZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Feb 2020 05:21:25 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B75C2082F;
        Mon, 10 Feb 2020 10:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581330084;
        bh=wa9nBa4P49n2wiYl67q1uEbcw0bMSUoAEssaIQ6+IIg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xc5GNQjqDTDxMMp1Rnm03QbvDpfvCl5hoOVIxyzElK2ji2iOHENlQ7iWKrvDjQNCO
         V1K93z6oWs7k8hdrhP0NaFgxnwBGx0fHfjaRFp2jfrxO596L3vA0n4/7Rwnznpz6xX
         iSSMNIyMtUssCVrshRO7v5ZKFL1Ziqv8XyXPpNRs=
Date:   Mon, 10 Feb 2020 12:21:20 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
Subject: Re: [PATCH for-next] RDMA/hns: Optimize eqe buffer allocation flow
Message-ID: <20200210102120.GC495280@unreal>
References: <20200126145835.11368-1-liweihang@huawei.com>
 <20200127055205.GH3870@unreal>
 <10b7a08c-e069-0751-8bde-e5d19521c0b2@huawei.com>
 <20200210092508.GB495280@unreal>
 <512fa0f9-2bef-b3d8-fb3d-144984ee468c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <512fa0f9-2bef-b3d8-fb3d-144984ee468c@huawei.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 10, 2020 at 05:48:05PM +0800, Weihang Li wrote:
>
>
> On 2020/2/10 17:25, Leon Romanovsky wrote:
> >>>> -		if (!eq->bt_l0)
> >>>> -			return -ENOMEM;
> >>>> -
> >>>> -		eq->cur_eqe_ba = eq->l0_dma;
> >>>> -		eq->nxt_eqe_ba = 0;
> >>>> +	/* alloc a tmp list for storing eq buf address */
> >>>> +	ret = hns_roce_alloc_buf_list(&region, &buf_list, 1);
> >>>> +	if (ret) {
> >>>> +		dev_err(hr_dev->dev, "alloc eq buf_list error\n");
> >>> The same comment like we gave for bnxt driver, no dev_* prints inside
> >>> driver, use ibdev_*.
> >>>
> >>> Thanks
> >>>
> >> Hi Leon,
> >>
> >> map_eq_buf() is called before ib_register_device(), so we can't use
> >> ibdev_* here.
> > As long as map_eq_buf() is called after ib_alloc_device(), you will be fine.
> >
> > Thanks
>
> Hi Leon,
>
> eq is used to queue hardware event, it should be ready before hardware is initialized.
> So we can't call map_eq_buf() after ib_alloc_device().

How can it be that your newly added function has hns_roce_dev in the
signature and you didn't call to ib_alloc_device()?

 +static int map_eq_buf(struct hns_roce_dev *hr_dev, struct hns_roce_eq *eq,
 +                u32 page_shift)

Thanks

>
> Thanks
> Weihang
>
> >
> >> Thanks for your reminder, another patch that replace other dev_* in
> >> hns driver with ibdev_* is on preparing.
> >>
> >> Weihang
> >>
> >>> .
> >>>
> > .
> >
>
