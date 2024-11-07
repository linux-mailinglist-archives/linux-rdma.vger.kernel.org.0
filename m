Return-Path: <linux-rdma+bounces-5820-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC7E9BFC98
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 03:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2496A1F224DE
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 02:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B42374CB;
	Thu,  7 Nov 2024 02:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O1IZXCle"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEB06AA7;
	Thu,  7 Nov 2024 02:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730946971; cv=none; b=KWzT2cf7QwzwVG+vpwD0lU4xcbpCJg8KMlmhD0cfx2XBDMk1IG1Lep6roVqDoyVrpvNOZXF6oJDDYlkHbJ6xj5bgKoWcKm1ssSfa+LmdJrPVhn8B/+PWrtZeavNy/TnbxYXX4yqB9013WJQVc/0jeUCutAXPEaXB8Oj4Rnk28z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730946971; c=relaxed/simple;
	bh=UBme+orhLUevauWpsyoc1EM0CwPTJ74P0NEkliYWriw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BA4LycZ7BJOuPlqcdQIF6EljxZiXkVFxCf5JoNyx8NLxdGza7j+Ih9o3HFO6qqhkdtn1iJqKEX70Q4rV9Hbgg8h2Gb3aur+Fp5aYjQajlhhc4hp690q/9KaG/jxpRnjHxkDg2OMP/yG+CYyTPuWU6cYjLjLtzMxYYaAGFk1AihE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O1IZXCle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE60C4CEC6;
	Thu,  7 Nov 2024 02:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730946970;
	bh=UBme+orhLUevauWpsyoc1EM0CwPTJ74P0NEkliYWriw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O1IZXClefdkpwf8Md8xzzF/+fnNppyif1xvbl/7QoktK09DWU4jpK6jyP+i90SVPe
	 2OS7wOvoUacIlwwsD9OSyXseqhIkjH42swr3Bs+HlkmIHiX/BARe6gegNTGHJVNNFT
	 ABWllytXxlxLcv79/Pme/dRSOxFGgLLQ4afG7XELgxD7hMMLDHBegE9OLpSB8vjBVF
	 Zj+bpjjHC+UdKwNQyDhILjzMA57XAukQlEOncvvsL24F9JCU9MfZN4L9Ikh+FIJJQ0
	 Jw6mTwchst+Gedp5XfZXFC6QSpsRMiU6E554NmfWT3Nj4EFeZ9xNKxws3CGVtS1kZY
	 WExYQbImBvSEw==
Date: Wed, 6 Nov 2024 18:36:08 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Caleb Sander <csander@purestorage.com>
Cc: Parav Pandit <parav@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] mlx5/core: deduplicate
 {mlx5_,}eq_update_ci()
Message-ID: <ZywnmDQIxzgV3uJe@x130>
References: <20241101034647.51590-1-csander@purestorage.com>
 <20241101034647.51590-2-csander@purestorage.com>
 <CY8PR12MB71958512F168E2C172D0BE05DC502@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CADUfDZofFwy12oZYTmm3TE314RM79EGsxV6bKEBRMVFv8C3jNg@mail.gmail.com>
 <CY8PR12MB71953FD36C70ACACEBE3DBA1DC522@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CADUfDZqanDo+v_jap7pQire86QkfaDQE4HvhvVBb64YqKNgRHg@mail.gmail.com>
 <CY8PR12MB7195FDC4A280F4CD7EA219ABDC532@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CADUfDZon6QbURp7TqB6dvE4Ewb_To2EDyUTQ=spNCorXDy0DbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZon6QbURp7TqB6dvE4Ewb_To2EDyUTQ=spNCorXDy0DbQ@mail.gmail.com>

On 06 Nov 15:44, Caleb Sander wrote:
>On Tue, Nov 5, 2024 at 9:44 PM Parav Pandit <parav@nvidia.com> wrote:
>>
>>
>> > From: Caleb Sander <csander@purestorage.com>
>> > Sent: Tuesday, November 5, 2024 9:36 PM
>> >
>> > On Mon, Nov 4, 2024 at 9:22 PM Parav Pandit <parav@nvidia.com> wrote:
>> > >
>> > >
>> > >
>> > > > From: Caleb Sander <csander@purestorage.com>
>> > > > Sent: Monday, November 4, 2024 3:49 AM
>> > > >
>> > > > On Sat, Nov 2, 2024 at 8:55 PM Parav Pandit <parav@nvidia.com> wrote:
>> > > > >
>> > > > >
>> > > > >
>> > > > > > From: Caleb Sander Mateos <csander@purestorage.com>
>> > > > > > Sent: Friday, November 1, 2024 9:17 AM
>> > > > > >
>> > > > > > The logic of eq_update_ci() is duplicated in mlx5_eq_update_ci().
>> > > > > > The only additional work done by mlx5_eq_update_ci() is to
>> > > > > > increment
>> > > > > > eq->cons_index. Call eq_update_ci() from mlx5_eq_update_ci() to
>> > > > > > eq->avoid
>> > > > > > the duplication.
>> > > > > >
>> > > > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>> > > > > > ---
>> > > > > >  drivers/net/ethernet/mellanox/mlx5/core/eq.c | 9 +--------
>> > > > > >  1 file changed, 1 insertion(+), 8 deletions(-)
>> > > > > >
>> > > > > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
>> > > > > > b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
>> > > > > > index 859dcf09b770..078029c81935 100644
>> > > > > > --- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
>> > > > > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
>> > > > > > @@ -802,19 +802,12 @@ struct mlx5_eqe *mlx5_eq_get_eqe(struct
>> > > > > > mlx5_eq *eq, u32 cc)  }  EXPORT_SYMBOL(mlx5_eq_get_eqe);
>> > > > > >
>> > > > > >  void mlx5_eq_update_ci(struct mlx5_eq *eq, u32 cc, bool arm)  {
>> > > > > > -     __be32 __iomem *addr = eq->doorbell + (arm ? 0 : 2);
>> > > > > > -     u32 val;
>> > > > > > -
>> > > > > >       eq->cons_index += cc;
>> > > > > > -     val = (eq->cons_index & 0xffffff) | (eq->eqn << 24);
>> > > > > > -
>> > > > > > -     __raw_writel((__force u32)cpu_to_be32(val), addr);
>> > > > > > -     /* We still want ordering, just not swabbing, so add a barrier */
>> > > > > > -     wmb();
>> > > > > > +     eq_update_ci(eq, arm);
>> > > > > Long ago I had similar rework patches to get rid of
>> > > > > __raw_writel(), which I never got chance to push,
>> > > > >
>> > > > > Eq_update_ci() is using full memory barrier.
>> > > > > While mlx5_eq_update_ci() is using only write memory barrier.
>> > > > >
>> > > > > So it is not 100% deduplication by this patch.
>> > > > > Please have a pre-patch improving eq_update_ci() to use wmb().
>> > > > > Followed by this patch.
>> > > >
>> > > > Right, patch 1/2 in this series is changing eq_update_ci() to use
>> > > > writel() instead of __raw_writel() and avoid the memory barrier:
>> > > > https://lore.kernel.org/lkml/20241101034647.51590-1-
>> > > > csander@purestorage.com/
>> > > This patch has two bugs.
>> > > 1. writel() writes the MMIO space in LE order. EQ updates are in BE order.
>> > > So this will break on ppc64 BE.
>> >
>> > Okay, so this should be writel(cpu_to_le32(val), addr)?
>> >
>> That would break the x86 side because device should receive in BE format regardless of cpu endianness.
>> Above code will write in the LE format.
>>
>> So an API foo_writel() need which does
>> a. write memory barrier
>> b. write to MMIO space but without endineness conversion.
>
>Got it, thanks. writel(bswap_32(val, addr)) should work, then? I
>suppose it may introduce a second bswap on BE architectures, but
>that's probably worth it to avoid the memory barrier.
>

The existing mb() needs to be changed to wmb(), this will provide a more
efficient fence on most architectures.

I don't understand why you are still discussing the use of writel(), yes
it will work but you are introducing two unconditional swaps per doorbell
write.

Just replace the existing mb with wmb() in eq_update_ci()

And if you have time to write one extra patch, please reuse eq_update_ci() 
inside mlx5_eq_update_ci(). 

mlx5_eq_update_ci(eq, cc, arm) {
        eq->cons_index += cc;
        eq_update_ci(eq, arm);
}

So we won't have two different implementations of EQ doorbell ringing
anymore.

Thanks,
Saeed.


