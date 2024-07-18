Return-Path: <linux-rdma+bounces-3900-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 628019349EB
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jul 2024 10:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D10D283022
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Jul 2024 08:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669BE7BB15;
	Thu, 18 Jul 2024 08:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJ2Hitwb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F007E8;
	Thu, 18 Jul 2024 08:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721291475; cv=none; b=P0Q9u3j78vV5du0TAJ/jfuMj6fz8woZdCPOmv3jJAaY4CYr+1QtOWZFko+CsH14dUblkRHMMiZu2zH9UjXKHdhQV/eWHWfnMY7b98i/6b3TJ1TQWIGNHt4ohaw/Vfez5M2u1oM+giwvXlkRslVX7fpofzG7rpOxl3QQXXA12TuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721291475; c=relaxed/simple;
	bh=H1YZoQDnsvam5dfTdpbjbzx7HojhDFEDH9pV9wUJvkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BJVsL3P/NpnXsyDrqwn1aEa7xJ5IygJtAjrS8EmS7db+KtplGUewwGdG5Z9xvIHMpEtvF7jOBFl6Vst4WU+vhuodC1UquR0qyMw/Rqf8BLcDCXcF3I6Y28SnU6PvAJ0qXe6m8iLVDucH3OMWmCmFnOfDAT/dx0QKomVa0dmzpmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJ2Hitwb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C396CC116B1;
	Thu, 18 Jul 2024 08:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721291474;
	bh=H1YZoQDnsvam5dfTdpbjbzx7HojhDFEDH9pV9wUJvkI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJ2HitwbYZhpOs4V0RX5Yj9s3EoMqzr5hsoJqQhHHKRFQoKNzKqiXr2opz0qLHTXN
	 sWJ5dpWw+J91epGZMsfm5KmkuIzEeLnwfh7NrtWkt61KbjZnu+rYltXA8rtYTAl6Ie
	 WZHoXAKyQwM7+dgRY2+TK1wgo51EH+VwUnHbHKdIJy/ICrHxWSA92DN4ZDDlwNQm1A
	 UrnfxxddmFZj9EKFJh9drErCM/QeLeOT4wjOp74xsdxSFkpE7Amfwi1hWifrlKIZ8d
	 qk5GzYqnUeTY7BDfegZ1lwPGYh7zW/ov5wT2R8NTNWK1j2BeACyoBtlSF7RYAhrhTx
	 RYZpmOGzymDDg==
Date: Thu, 18 Jul 2024 11:31:09 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Omer Shpigelman <oshpigelman@habana.ai>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"ogabbay@kernel.org" <ogabbay@kernel.org>,
	Zvika Yehudai <zyehudai@habana.ai>
Subject: Re: [PATCH 11/15] RDMA/hbl: add habanalabs RDMA driver
Message-ID: <20240718083109.GN5630@unreal>
References: <20240619105219.GO4025@unreal>
 <a5554266-55b7-4e96-b226-b686b8a6af89@habana.ai>
 <20240712130856.GB14050@ziepe.ca>
 <2c767517-e24c-416b-9083-d3a220ffc14c@habana.ai>
 <20240716134013.GF14050@ziepe.ca>
 <ca6c3901-c0c5-4f35-934b-2b4c9f1a61dc@habana.ai>
 <20240717073607.GF5630@unreal>
 <2050e95c-4998-4b2e-88e7-5964429818b5@habana.ai>
 <20240717123337.GI5630@unreal>
 <19c5be58-f87f-4440-a50e-b55b927dce62@habana.ai>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19c5be58-f87f-4440-a50e-b55b927dce62@habana.ai>

On Thu, Jul 18, 2024 at 06:54:17AM +0000, Omer Shpigelman wrote:
> On 7/17/24 15:33, Leon Romanovsky wrote:
> > On Wed, Jul 17, 2024 at 10:51:03AM +0000, Omer Shpigelman wrote:
> >> On 7/17/24 10:36, Leon Romanovsky wrote:
> >>> On Wed, Jul 17, 2024 at 07:08:59AM +0000, Omer Shpigelman wrote:
> >>>> On 7/16/24 16:40, Jason Gunthorpe wrote:
> >>>>> On Sun, Jul 14, 2024 at 10:18:12AM +0000, Omer Shpigelman wrote:
> >>>>>> On 7/12/24 16:08, Jason Gunthorpe wrote:

<...>

> So what is the problem with how we implemented it?

Please do you homework and send new version of the patch series.

Thanks

