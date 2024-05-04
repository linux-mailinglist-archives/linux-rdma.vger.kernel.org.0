Return-Path: <linux-rdma+bounces-2255-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FD28BB8D2
	for <lists+linux-rdma@lfdr.de>; Sat,  4 May 2024 02:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD591F2365D
	for <lists+linux-rdma@lfdr.de>; Sat,  4 May 2024 00:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1FF139B;
	Sat,  4 May 2024 00:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Erl6ibWp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA418A34;
	Sat,  4 May 2024 00:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714782870; cv=none; b=bGqo3DvYmQEh2KOvAX/NbFl86LPx8OSAHqrenozwvdi19Q0s9tciY6zVJwD5LIvIjLw7Uwo6Jj/k3RXeuZXJzXflAM+99csJcENsNu8pzDCyWmHKpyXBC0mHG3UZRnOen1hQh6FwRTDVnURZ/hahHdxGzp1kye097SunObcOhWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714782870; c=relaxed/simple;
	bh=ytSpzR7FtjeDpuJHulZAVt5ZkXDD+l+3IoK21E5XNlg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kmanyvEPU6XO535i8577LygzO2WtT2pqEj10C86HRX2QLN2il58JBW/z6LzgLcBut8rzRup72eUxGMS4D3dVg6sZ60ueOgV9tFz3cWMWnaEO9kYL+U7XxpM8JL8JppmldLRsrAOCl2XEh81NEFKjGtESMSNKogdcvk8KfE8ucEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Erl6ibWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04939C116B1;
	Sat,  4 May 2024 00:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714782870;
	bh=ytSpzR7FtjeDpuJHulZAVt5ZkXDD+l+3IoK21E5XNlg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Erl6ibWpCIPw1YsmxSw5hY6v0Z+3xvLlYV9yUSQdNH1TeFu847HPm/WoCUVmqltox
	 2N+om4AkIF63pnC7JmkfarrIl0A94n4gWv39NHMD3Gy03JdTOG6d5OM5QHANBft2d1
	 /jPcQbA6Rq3M1KZpuGiGbR3UPOZ93ZQJzymLLfpsTvN4WjmpIaHdM2f5dRr9UBnuw+
	 pKTK7TA1s+JXNVafYHLj2qBgOiTe/z9MrO71IBS0FERoAQPqW7t+bvST9CvrgfU4Ps
	 omtIlwxziMGtCEEkdmMRsuCS/9HXZT/htTz/FRKNnAom6TbFJt0nCrwVgR0J+ZnB1i
	 qlS0OQebZCpKg==
Date: Fri, 3 May 2024 17:34:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, tariqt@nvidia.com, saeedm@nvidia.com,
 gal@nvidia.com, nalramli@fastly.com, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Leon Romanovsky
 <leon@kernel.org>, "open list:MELLANOX MLX5 core VPI driver"
 <linux-rdma@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 0/1] mlx5: Add netdev-genl queue stats
Message-ID: <20240503173429.10402325@kernel.org>
In-Reply-To: <ZjV5BG8JFGRBoKaz@LQ3V64L9R2>
References: <20240503022549.49852-1-jdamato@fastly.com>
	<c3f4f1a4-303d-4d57-ae83-ed52e5a08f69@linux.dev>
	<ZjUwT_1SA9tF952c@LQ3V64L9R2>
	<20240503145808.4872fbb2@kernel.org>
	<ZjV5BG8JFGRBoKaz@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 May 2024 16:53:40 -0700 Joe Damato wrote:
> > diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
> > index c7ac4539eafc..f5d9f3ad5b66 100644
> > --- a/include/net/netdev_queues.h
> > +++ b/include/net/netdev_queues.h
> > @@ -59,6 +59,8 @@ struct netdev_queue_stats_tx {
> >   * statistics will not generally add up to the total number of events for
> >   * the device. The @get_base_stats callback allows filling in the delta
> >   * between events for currently live queues and overall device history.
> > + * @get_base_stats can also be used to report any miscellaneous packets
> > + * transferred outside of the main set of queues used by the networking stack.
> >   * When the statistics for the entire device are queried, first @get_base_stats
> >   * is issued to collect the delta, and then a series of per-queue callbacks.
> >   * Only statistics which are set in @get_base_stats will be reported
> > 
> > 
> > SG?  
> 
> I think that sounds good and makes sense, yea. By that definition, then I
> should leave the PTP stats as shown above. If you agree, I'll add that
> to the v2.

Yup, agreed.

> I feel like I should probably wait before sending a v2 with PTP included in
> get_base_stats to see if the Mellanox folks have any hints about why rtnl
> != queue stats on mlx5?
> 
> What do you think?

Very odd, the code doesn't appear to be doing any magic :S Did you try
to print what the delta in values is? Does bringing the interface up and
down affect the size of it?

