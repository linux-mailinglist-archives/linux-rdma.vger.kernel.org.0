Return-Path: <linux-rdma+bounces-600-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB35082AB71
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jan 2024 10:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A6C01C22987
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Jan 2024 09:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6835111C94;
	Thu, 11 Jan 2024 09:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jD9Ganho"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1B511C85;
	Thu, 11 Jan 2024 09:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F5EC43394;
	Thu, 11 Jan 2024 09:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704967169;
	bh=1KGPvZ+Jg0PX+zqhJQSKMoD+l3+PBPpn18BXoSciB6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jD9Ganho3AgqZxZXa2ui0CQk0kCwFljYXGvdhWYhpyWhLLxjiKN5jO11LGEMhDQmv
	 ltSiSEoDchrykh8SbvtM3DWFiV6VjW20ML6HVpce+wBNEZhVcbNvpYmF2or32ccDyf
	 iO5TcEgTtHQtYOY6PSXD2HzAv9TOWPlXv449dMqRYoiBcMeq5C82Z7/LM/aN9SEdGI
	 F47obgCueOdlUkPCLZzLyR2a1sK0wQauokZmfBInPe00ttIm2rlqKisgY/VLQRiGko
	 1Q+0jyHycLWF+uLYCg7e+/9i9AsrrMVA0RArTDgP3h+TxCKBul4BkMhlhvqBqff/vP
	 kDkUGGZalwzAg==
Date: Thu, 11 Jan 2024 11:59:25 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Greg Sword <gregsword0@gmail.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Subject: Re: [PATCH for-next v4 2/2] RDMA/rxe: Remove rxe_info from
 rxe_set_mtu
Message-ID: <20240111095925.GB7488@unreal>
References: <20240109083253.3629967-1-lizhijian@fujitsu.com>
 <20240109083253.3629967-2-lizhijian@fujitsu.com>
 <CAEz=LcvphS6QECpHTFhrRoC=FcSbEU4j_XuqJF7ognjJu+uF6Q@mail.gmail.com>
 <dbbd1887-af93-4323-ac27-f937bafc5756@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbbd1887-af93-4323-ac27-f937bafc5756@fujitsu.com>

On Wed, Jan 10, 2024 at 01:22:12AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 09/01/2024 17:20, Greg Sword wrote:
> > On Tue, Jan 9, 2024 at 4:41 PM Li Zhijian <lizhijian@fujitsu.com> wrote:
> >>
> >> commit 9ac01f434a1e ("RDMA/rxe: Extend dbg log messages to err and info")
> >> newly added this info. But it did only show null device when
> >> the rdma_rxe is being loaded because dev_name(rxe->ib_dev->dev)
> >> has not yet been assigned at the moment:
> >>
> >> "(null): rxe_set_mtu: Set mtu to 1024"
> >>
> >> Remove it to silent this message, check the mtu from it backend link
> >> instead if needed.
> >>
> >> CC: Bob Pearson <rpearsonhpe@gmail.com>
> >> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> >> ---
> >> V4: Remove it rather than re-order rxe_set_mtu() and rxe_register_device()
> >> ---
> >>   drivers/infiniband/sw/rxe/rxe.c | 2 --
> >>   1 file changed, 2 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> >> index a086d588e159..ae466e72fc43 100644
> >> --- a/drivers/infiniband/sw/rxe/rxe.c
> >> +++ b/drivers/infiniband/sw/rxe/rxe.c
> >> @@ -160,8 +160,6 @@ void rxe_set_mtu(struct rxe_dev *rxe, unsigned int ndev_mtu)
> >>
> >>          port->attr.active_mtu = mtu;
> >>          port->mtu_cap = ib_mtu_enum_to_int(mtu);
> >> -
> >> -       rxe_info_dev(rxe, "Set mtu to %d\n", port->mtu_cap);
> > 
> > I'd like to keep this statement so I can tell if the mtu setup was
> > successful or not.
> 
> During the module loading, once it's loaded successfully, the mtu is set as well.
> 
> The another caller rxe_notify()->rxe_set_mtu() already had its own dbg message for this,
> people can enable the dbg if needed.
> 
> Anyway, I'm open to your point.

IMHO, this print can be safely removed.

Thanks

> 
> 
> Thanks
> Zhijian
> 
> 
> > 
> >>   }
> >>
> >>   /* called by ifc layer to create new rxe device.
> >> --
> >> 2.29.2
> >>
> >>

