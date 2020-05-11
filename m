Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFF31CE090
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 18:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbgEKQfC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 12:35:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729862AbgEKQfB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 12:35:01 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5FB42075E;
        Mon, 11 May 2020 16:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589214901;
        bh=byt2twgzng4boYLUhEs6WQsGcHFp7CU7B+I9bZtS4o4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CnkDaGYkZcbtKa3tW6iZ0juX2WfuQSq96FxdoG1rcHLttcIRRTt8MaNg0tiDj/hQk
         r1dvQn/N9tUBuzmzmjiMCfSajpGBZqpkjV3HtKkqDGgQUoxO5IGJNZBOQdr9qNUo3C
         IgvJCdWkEB6+g4ziw4qsBZUjELRMufkYCAzY5Cns=
Date:   Mon, 11 May 2020 19:34:56 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>,
        linux-rdma@vger.kernel.org,
        Alexander Matushevsky <matua@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        Guy Tzalik <gtzalik@amazon.com>
Subject: Re: [PATCH for-next 2/2] RDMA/efa: Report host information to the
 device
Message-ID: <20200511163456.GC356445@unreal>
References: <20200510115918.46246-1-galpress@amazon.com>
 <20200510115918.46246-3-galpress@amazon.com>
 <20200510122949.GB199306@unreal>
 <5612e79f-76e5-7f87-8321-5114d414015e@amazon.com>
 <20200510151622.GD199306@unreal>
 <2f15e2fb-22d2-2d8e-50f0-9fa7964f7104@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f15e2fb-22d2-2d8e-50f0-9fa7964f7104@amazon.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 11, 2020 at 03:47:57PM +0300, Gal Pressman wrote:
> On 10/05/2020 18:16, Leon Romanovsky wrote:
> > On Sun, May 10, 2020 at 04:05:45PM +0300, Gal Pressman wrote:
> >> On 10/05/2020 15:29, Leon Romanovsky wrote:
> >>> On Sun, May 10, 2020 at 02:59:18PM +0300, Gal Pressman wrote:
> >>>> diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> >>>> index 96b104ab5415..efdeebc9ea9b 100644
> >>>> --- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> >>>> +++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
> >>>> @@ -37,7 +37,7 @@ enum efa_admin_aq_feature_id {
> >>>>  	EFA_ADMIN_NETWORK_ATTR                      = 3,
> >>>>  	EFA_ADMIN_QUEUE_ATTR                        = 4,
> >>>>  	EFA_ADMIN_HW_HINTS                          = 5,
> >>>> -	EFA_ADMIN_FEATURES_OPCODE_NUM               = 8,
> >>>> +	EFA_ADMIN_HOST_INFO                         = 6,
> >>>>  };
> >>>>
> >>>>  /* QP transport type */
> >>>> @@ -799,6 +799,55 @@ struct efa_admin_mmio_req_read_less_resp {
> >>>>  	u32 reg_val;
> >>>>  };
> >>>>
> >>>> +enum efa_admin_os_type {
> >>>> +	EFA_ADMIN_OS_LINUX                          = 0,
> >>>> +	EFA_ADMIN_OS_WINDOWS                        = 1,
> >>>
> >>> Not used.
> >>
> >> That's the device interface..
> >
> > It doesn't matter, we don't add code/defines that are not in use.
>
> First of all, that's not true, look at mlx5 device spec for example.
> It's 10k lines long and has many unused values..

Patch that removes that crap is more than welcomed.

>
> I don't think we should go as far as commits like 1759d322f4ba ("net/mlx5: Add
> hardware definitions for sub functions") which adds new commands interface
> without implementing it (nor does any following patch), but exposing the related
> bits directly in the scope of the feature that's being introduced is different.

It is not on my watch and feel free to NAK any patch that tries to do the same.

>
> The driver version fields that you don't like are going to stay there as they're
> the device ABI, and IMHO "hiding" them as reserved has zero upsides and won't
> change the fact that they're unused.

Our views are different.

Thanks
