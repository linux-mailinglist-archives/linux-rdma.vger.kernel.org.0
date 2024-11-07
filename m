Return-Path: <linux-rdma+bounces-5823-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120229BFD84
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 06:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35FF81C21488
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Nov 2024 05:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D631918E028;
	Thu,  7 Nov 2024 05:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CT07RFNz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CA77F9;
	Thu,  7 Nov 2024 05:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730956472; cv=none; b=e5wf1Inza76b52VpAZYNcHPN1GS1lhpSu3xLC3F5/jHsxuxTPDWLP8WMgOzSk2pov5RcmTG18sqvRx3giuko0wfjSiARTopMWa/K+VSiba/3BWg3oLlUrH9L4vah1pH61y3wRlryNe8Fy/UlVYLQ+5q8ghp0Y65+1MSfq9VZggk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730956472; c=relaxed/simple;
	bh=Bb1I/94gIy+cLPJMM7luJfY3snCjh6yUmj5aFwNjpVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y607E77TXcjxR0ajhkgDRR2q0V0w5j0VSTxwr0L5++VpTVQdcAJyTigr6sV3pKYcJQtsb5+BwAC89VICDoSapGanvG/p6iUHYws5IrPlR7Bzg6IayDnmz9OgJOuyelHMWs7NmkWZ4mej1zRYmGA9k6gsMWlvpVeFZv8sodbTxg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CT07RFNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68E2C4CECC;
	Thu,  7 Nov 2024 05:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730956472;
	bh=Bb1I/94gIy+cLPJMM7luJfY3snCjh6yUmj5aFwNjpVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CT07RFNzC6tEzjE7B90LlHE3CPpi8kKoAlM2ubndyaVT5GYlkYRQtsRF3GZH4j71i
	 a9u8CvJ8nYvhVJ1tPjLnXoX1dMJZ8HUO1LJ8dIfkxECTy4uOMHX3V6du8C+44jmbN/
	 maR4u6XSQzDH5W3sSSlt/xyGor9btV8ssM4cLfOV2xP1E7Ho84ERJvF34r653Hj/Ws
	 A8FgYqzUAUDIBkin0lYsMdnIKJ5gPqmcdmRhLOFITy+k2GwNdah/7ctSnyOtGULw94
	 UsAgLY4qLw2Brlt+gcuQHxZMHKl7n3N7r81HsddBnbLrRfLsnqdtXCee1n6ioTFU0O
	 GzZF1U7vMeIWQ==
Date: Wed, 6 Nov 2024 21:14:27 -0800
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
Message-ID: <ZyxMsx8o7NtTAWPp@x130>
References: <20241101034647.51590-1-csander@purestorage.com>
 <20241101034647.51590-2-csander@purestorage.com>
 <CY8PR12MB71958512F168E2C172D0BE05DC502@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CADUfDZofFwy12oZYTmm3TE314RM79EGsxV6bKEBRMVFv8C3jNg@mail.gmail.com>
 <CY8PR12MB71953FD36C70ACACEBE3DBA1DC522@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CADUfDZqanDo+v_jap7pQire86QkfaDQE4HvhvVBb64YqKNgRHg@mail.gmail.com>
 <CY8PR12MB7195FDC4A280F4CD7EA219ABDC532@CY8PR12MB7195.namprd12.prod.outlook.com>
 <CADUfDZon6QbURp7TqB6dvE4Ewb_To2EDyUTQ=spNCorXDy0DbQ@mail.gmail.com>
 <ZywnmDQIxzgV3uJe@x130>
 <CADUfDZq0E-GJZxFD4gR7qqpHqcQ2d4cy-Duz7SYMpOZTRvOcKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADUfDZq0E-GJZxFD4gR7qqpHqcQ2d4cy-Duz7SYMpOZTRvOcKA@mail.gmail.com>

On 06 Nov 20:45, Caleb Sander wrote:
>On Wed, Nov 6, 2024 at 6:36 PM Saeed Mahameed <saeed@kernel.org> wrote:
>>
>> On 06 Nov 15:44, Caleb Sander wrote:
>> >On Tue, Nov 5, 2024 at 9:44 PM Parav Pandit <parav@nvidia.com> wrote:
>> >>
>> >>
>> >> > From: Caleb Sander <csander@purestorage.com>
>> >> > Sent: Tuesday, November 5, 2024 9:36 PM
>> >> >
>> >> > On Mon, Nov 4, 2024 at 9:22 PM Parav Pandit <parav@nvidia.com> wrote:
>> >> > >
>> >> > >
>> >> > >
>> >> > > > From: Caleb Sander <csander@purestorage.com>
>> >> > > > Sent: Monday, November 4, 2024 3:49 AM
>> >> > > >
>> >> > > > On Sat, Nov 2, 2024 at 8:55 PM Parav Pandit <parav@nvidia.com> wrote:
>> >> > > > >
>> >> > > > >
>> >> > > > >
>> >> > > > > > From: Caleb Sander Mateos <csander@purestorage.com>
>> >> > > > > > Sent: Friday, November 1, 2024 9:17 AM
>> >> > > > > >
>> >> > > > > > The logic of eq_update_ci() is duplicated in mlx5_eq_update_ci().
>> >> > > > > > The only additional work done by mlx5_eq_update_ci() is to
>> >> > > > > > increment
>> >> > > > > > eq->cons_index. Call eq_update_ci() from mlx5_eq_update_ci() to
>> >> > > > > > eq->avoid
>> >> > > > > > the duplication.
>> >> > > > > >
>> >> > > > > > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
>> >> > > > > > ---
>> >> > > > > >  drivers/net/ethernet/mellanox/mlx5/core/eq.c | 9 +--------
>> >> > > > > >  1 file changed, 1 insertion(+), 8 deletions(-)
>> >> > > > > >
>> >> > > > > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
>> >> > > > > > b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
>> >> > > > > > index 859dcf09b770..078029c81935 100644
>> >> > > > > > --- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
>> >> > > > > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
>> >> > > > > > @@ -802,19 +802,12 @@ struct mlx5_eqe *mlx5_eq_get_eqe(struct
>> >> > > > > > mlx5_eq *eq, u32 cc)  }  EXPORT_SYMBOL(mlx5_eq_get_eqe);
>> >> > > > > >
>> >> > > > > >  void mlx5_eq_update_ci(struct mlx5_eq *eq, u32 cc, bool arm)  {
>> >> > > > > > -     __be32 __iomem *addr = eq->doorbell + (arm ? 0 : 2);
>> >> > > > > > -     u32 val;
>> >> > > > > > -
>> >> > > > > >       eq->cons_index += cc;
>> >> > > > > > -     val = (eq->cons_index & 0xffffff) | (eq->eqn << 24);
>> >> > > > > > -
>> >> > > > > > -     __raw_writel((__force u32)cpu_to_be32(val), addr);
>> >> > > > > > -     /* We still want ordering, just not swabbing, so add a barrier */
>> >> > > > > > -     wmb();
>> >> > > > > > +     eq_update_ci(eq, arm);
>> >> > > > > Long ago I had similar rework patches to get rid of
>> >> > > > > __raw_writel(), which I never got chance to push,
>> >> > > > >
>> >> > > > > Eq_update_ci() is using full memory barrier.
>> >> > > > > While mlx5_eq_update_ci() is using only write memory barrier.
>> >> > > > >
>> >> > > > > So it is not 100% deduplication by this patch.
>> >> > > > > Please have a pre-patch improving eq_update_ci() to use wmb().
>> >> > > > > Followed by this patch.
>> >> > > >
>> >> > > > Right, patch 1/2 in this series is changing eq_update_ci() to use
>> >> > > > writel() instead of __raw_writel() and avoid the memory barrier:
>> >> > > > https://lore.kernel.org/lkml/20241101034647.51590-1-
>> >> > > > csander@purestorage.com/
>> >> > > This patch has two bugs.
>> >> > > 1. writel() writes the MMIO space in LE order. EQ updates are in BE order.
>> >> > > So this will break on ppc64 BE.
>> >> >
>> >> > Okay, so this should be writel(cpu_to_le32(val), addr)?
>> >> >
>> >> That would break the x86 side because device should receive in BE format regardless of cpu endianness.
>> >> Above code will write in the LE format.
>> >>
>> >> So an API foo_writel() need which does
>> >> a. write memory barrier
>> >> b. write to MMIO space but without endineness conversion.
>> >
>> >Got it, thanks. writel(bswap_32(val, addr)) should work, then? I
>> >suppose it may introduce a second bswap on BE architectures, but
>> >that's probably worth it to avoid the memory barrier.
>> >
>>
>> The existing mb() needs to be changed to wmb(), this will provide a more
>> efficient fence on most architectures.
>>
>> I don't understand why you are still discussing the use of writel(), yes
>> it will work but you are introducing two unconditional swaps per doorbell
>> write.
>
>Well, no memory fence is cheaper still than a wmb(). But it's your
>driver, so if you prefer to use wmb() rather than switch to writel(),
>that's fine. I'll update the patch series.

yest wmb() please.

>As for the bytes swaps in writel(bswap_32(val), addr), it would still
>be 1 on LE architectures, but 2 instead of 0 on BE architectures.
>Certainly a bit inefficient, but probably less overhead than the
>memory barrier currently adds on strongly-ordered architectures.
>

yes we all agree:

mb << writel() < _raw_writel() + wmb () 


>>
>> Just replace the existing mb with wmb() in eq_update_ci()
>>
>> And if you have time to write one extra patch, please reuse eq_update_ci()
>> inside mlx5_eq_update_ci().
>>
>> mlx5_eq_update_ci(eq, cc, arm) {
>>         eq->cons_index += cc;
>>         eq_update_ci(eq, arm);
>> }
>>
>> So we won't have two different implementations of EQ doorbell ringing
>> anymore.
>
>Isn't this what my patch 2 (at the start of this reply chain) already
>does? If you are suggesting something else, please clarify.
>

Sorry i missed it, 

Yes this is perfect, thanks for the patches.
Let's do the wmb() and call it a day :) ..


