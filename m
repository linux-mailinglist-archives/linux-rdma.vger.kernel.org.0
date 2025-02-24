Return-Path: <linux-rdma+bounces-8046-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96517A4302B
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2025 23:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D34C3A8836
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Feb 2025 22:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7221F1312;
	Mon, 24 Feb 2025 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJEj6Wri"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39002571B2;
	Mon, 24 Feb 2025 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740436486; cv=none; b=sGmikj96rb+MIGcJLao4ELZM+uYpg9F3+GsEE0K2qVUgPNKAo9+bH5ltDF/04xBSo5G3H8GsF0MPtYX6xKpTXKIE3gbUf2WEdse5Z0eeKmnrQV/lsTTLTsrFKuLjP94aWcMFbyho5j+/0unIZy2m67oQfrzSSIDLOgjrMpsbqbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740436486; c=relaxed/simple;
	bh=9UzjkUJJ6ahaV2ilmu37ZIHZwB37SMdQMRt71KBRxAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4AVCs5oEVGmaAv830IfYLXLUAzFqwAGmYin9udtlErqi76voFnthtVARSHH2YaC36kgZ+ipx17vSY9xuERTGvDmUqi43U8r3ZYjCWd7SDpWRxP4aKEOr3q7Y0J7BmkYtDjZJxJs40ncx4dmlg51Hy/Bxvn0yWDCygTmrv4QVGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJEj6Wri; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314AFC4CED6;
	Mon, 24 Feb 2025 22:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740436482;
	bh=9UzjkUJJ6ahaV2ilmu37ZIHZwB37SMdQMRt71KBRxAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PJEj6WriSN4ss2MJnIpX3EY9nDWMtyz/RwrgaVsRroWKzVDeI1+dh44RMz71W4gGo
	 xpCWIzTSBYWjQMDKlXXYPghNfOrvPCumO9fvvUsBGcjXehHuL27WmfoarX+l+whg4v
	 52nmqzreQaStCmHSBaUTudNJv3nsY9LDNh+EzLoUrk8NdlEaXB4l7Ui/oTdgmw451R
	 9XK7Jv1Kj/zG0PCoXVwU60OCXw9c/xJe3dB01b4PYl936zNjkhhnfw5uzF2lncKoQi
	 cwYgllTcbWPZnIm6IeQpkYQCVWdzVm6W074ctUrXrQ/y+DoLFoM9sxOoHRKRTb8GGw
	 sHqh0Cf3d4MoQ==
Date: Mon, 24 Feb 2025 14:34:40 -0800
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	Andy Gospodarek <gospo@broadcom.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	"Nelson, Shannon" <shannon.nelson@amd.com>,
	Michael Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for fwctl_bnxt
Message-ID: <Z7z0ADkimCkhr7Xz@x130>
References: <CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
 <20250207073648.1f0bad47@kernel.org>
 <Z6ZsOMLq7tt3ijX_@x130>
 <20250207135111.6e4e10b9@kernel.org>
 <20250208011647.GH3660748@nvidia.com>
 <20250210170423.62a2f746@kernel.org>
 <a74484b3-9f69-45ef-a040-a46fbc2607d6@kernel.org>
 <20250218200520.GI4183890@nvidia.com>
 <532d2530-5c12-43b7-973f-ce43dbc36e67@kernel.org>
 <20250218153110.0c10e72c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250218153110.0c10e72c@kernel.org>

On 18 Feb 15:31, Jakub Kicinski wrote:
>On Tue, 18 Feb 2025 14:42:48 -0700 David Ahern wrote:
>> On 2/18/25 1:05 PM, Jason Gunthorpe wrote:
>> > On Tue, Feb 11, 2025 at 09:24:35AM -0700, David Ahern wrote:
>> >
>> >> "Any resources in use by the netdev stack can only be created and
>> >> modified by established netdev tools."
>> >
>> > That is already a restriction described in the doc, not just netdev,
>> > but any kernel driver running with any kernel owned resource. You
>> > can't reach in and change kernel owned objects.
>>
>> ok, then Jakub's concerns should be met.
>
>I appreciate the doc, but no, it's not enough. The fwctl interface must
>not be exposed if RDMA is disabled or driver not loaded.
>

Jason's proposal was completely different, he asked that if only netdev is
present then we can explicitly block fwctl. Tying fwctl to RDMA makes no
sense for most of the drivers that will be using it, so I don't support
such suggestion not even blocking fwctl for netdev only systems, if one
can load RDMA and still can control the device, then Jakub's concerns are
not met, so what's the point?

The whole Idea of blocking fwctl in specific configurations has no
technical merit, if someone doesn't want fwctl in their system, then let's
implement a devlink knob like we have for all ulps.
  


