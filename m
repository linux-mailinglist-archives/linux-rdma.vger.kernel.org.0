Return-Path: <linux-rdma+bounces-7523-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E58AA2C756
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 16:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F339316898B
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Feb 2025 15:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7333C1EB19D;
	Fri,  7 Feb 2025 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJ3AJh/R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B94E238D26;
	Fri,  7 Feb 2025 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942610; cv=none; b=QVHE7urms7TPM95VXYLdu/HMDSUDtukfqk8C+f0X5+EDQva3W7ENF/Ys5ZreCPo6BmvggvNo7dS8h9O753fxFjz2S1JZjrc4XZ7EnrIyxCzWwoyRcFYu4OZxpYipcRD3RttuUWwqLaGCP/XT/bteQBvA09sP5OimSN8nI+DhYbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942610; c=relaxed/simple;
	bh=LxQ2mulf9BJdZ7K5tJK5qIvEpE2V9AKvGiYrcXJBET8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qn6pGkiLJQyV01F89tC9884i48nZPXq4d0XvcgNxbJNsq+JgWNoq6FA71kykpqWO3r21OZh9P8arxWnCoGebX4yH2i8lNODM3dWBuIxlkxkRRAvl/boYsBjdvu+/o8r4mQD9qGvcK8KaNzVJk9EHcX7jHdRGTeDXumQ94hFFB7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJ3AJh/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46168C4CED1;
	Fri,  7 Feb 2025 15:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738942610;
	bh=LxQ2mulf9BJdZ7K5tJK5qIvEpE2V9AKvGiYrcXJBET8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LJ3AJh/RErRVubIqELDbplXs6MjQSsrbeBENqaSc++qlAQZhUswCuNvtHedCb8wTF
	 iBISZcX9+3LSv5SUO+J/6zMDlhkxr57POJY0naJZ6BukEccNUiHNXQRCEVbEI/jYvm
	 grW+hKdkRERvpVsNBs1+dqHLVuf+aTNEtUOR19WBRJa+pcSTaZu7R2nAXS7ysn9vP+
	 ChmDIJcemWfqEfIra6TOegCoo4M4iZqaeQxjY9/4nSa+KHSjcbBya1mgmNnDzEkUT7
	 +eV87kBKGZKsil4Ek9E4qFTL7O3NLdSKpRWnGYAyzVZ3OPOsxL7jwgheZwKexwMb4b
	 WZsh97TNaxOhA==
Date: Fri, 7 Feb 2025 07:36:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Aron Silverton
 <aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>,
 David Ahern <dsahern@kernel.org>, Andy Gospodarek <gospo@broadcom.com>,
 Christoph Hellwig <hch@infradead.org>, Itay Avraham <itayavr@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>, Leon
 Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, Saeed Mahameed
 <saeedm@nvidia.com>, "Nelson, Shannon" <shannon.nelson@amd.com>, Michael
 Chan <michael.chan@broadcom.com>
Subject: Re: [PATCH v4 10/10] bnxt: Create an auxiliary device for
 fwctl_bnxt
Message-ID: <20250207073648.1f0bad47@kernel.org>
In-Reply-To: <CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
References: <0-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
	<10-v4-0cf4ec3b8143+4995-fwctl_jgg@nvidia.com>
	<20250206164449.52b2dfef@kernel.org>
	<CACDg6nU_Dkte_GASNRpkvSSCihpg52FBqNr0KR3ud1YRvrRs3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Feb 2025 22:17:58 -0500 Andy Gospodarek wrote:
> On Thu, Feb 6, 2025 at 7:44=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> > On Thu,  6 Feb 2025 20:13:32 -0400 Jason Gunthorpe wrote: =20
> > > From: Andy Gospodarek <gospo@broadcom.com>
> > >
> > > Signed-off-by: Andy Gospodarek <gospo@broadcom.com>
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com> =20
> >
> > This is only needed for RDMA, why can't you make this part of bnxt_re ?=
 =20
>=20
> This is not just needed for RDMA, so having the aux device for fwctl
> as part of the base driver is preferred.

Please elaborate. As you well know I have experience using Broadcom
devices in large TCP/IP networks, without the need for proprietary
tooling.

Now, I understand that it may be expedient for Broadcom and nVidia
to skip the upstream process and ship "features" to customers using
DOCA and whatever you call your tooling. But let's be honest that=20
this is the motivation here. Unified support for proprietary tooling
across subsystems and product lines for a given vendor. This way
migrating from in-tree networking to proprietary IPU/DPU networking
is easier, while migrating to another vendor would require full tooling
replacement.

I have nothing against RDMA and CXL subsystems adding whatever APIs
they want. But I don't understand why you think it's okay to force=20
this on normal networking, which does not need it.

nVidia is already refusing to add basic minoring features to their
upstream driver, and keeps asking its customers to migrate to libdoca.
So the concern that merging this will negatively impact standard
tooling is no longer theoretical.

Anyway, rant over. Give us some technical details.

