Return-Path: <linux-rdma+bounces-836-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 061E184413B
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 15:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66292283838
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jan 2024 14:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A09380C09;
	Wed, 31 Jan 2024 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=arthur_mueller@gmx.net header.b="n5x9RF0x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B17F80BF5
	for <linux-rdma@vger.kernel.org>; Wed, 31 Jan 2024 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709689; cv=none; b=Ucp/pVPpuBzz82ySzWbPipwVRqzqERM0sjjp9JAlpWivXUpreyhkq1FJScK8Q5ujyvDA4Xbap6rZqJrH7gvIKza52LQwyawrwDUg40jqv1oeYZ9d5HslW4lKGWjMSuK85Rbi65OdS+FEmPzfmNAWlnDvnRrXuYbLe2/u39J1CRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709689; c=relaxed/simple;
	bh=S++ZbH8yiE0BrO955bBG9OkfS0d3oLGsXibS0MKn8Zg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gjAZIqT2+ujgdzZmDyinjyY8tnbDVzBy910qe5Z7IL+Gm3p91xiF5iX1chngRWfq/ggFD0I/mQgJ8pHfkNdLOKjuJiBTmQGs1iOR+VeTqr9GUEkZGOCajnJlsTqxHrsJjX9P842ZBhlK7tN+/d7l/m//O7inbzG2vR1Kpgv7h5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=arthur_mueller@gmx.net header.b=n5x9RF0x; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706709663; x=1707314463; i=arthur_mueller@gmx.net;
	bh=S++ZbH8yiE0BrO955bBG9OkfS0d3oLGsXibS0MKn8Zg=;
	h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:
	 References;
	b=n5x9RF0x6Vn/jwyCsorzZF7clROtgb9Ldq0mxwhNh43t4gn2RMNIN4l6SoeX/VC9
	 zt6TRrBHx1221vMRw6LwWQZOSEU1GhRNcN8/TNwcbYw+D8P1Z3QPh9Hwc7JGT828m
	 zWR/ODYm5GxuLK1JzMaxJlanbL1nyu7NSkjM4xB5jYt7QOwurE66Llwgatj97snOw
	 uhZXf5er86uLP8Y8irnQh1R0M1GpOKEu+wTqzxXgZRqq96ECqYBZ4YxYrKEgD1RaY
	 T4hmj8repkWGQV3dkSYld3OvFooZCENeEeNcE9ILBNN3Dwr2GkOH9hZOR468YkVM0
	 AcCpfp55U4XeyLfrVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.178.20] ([82.135.83.88]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3UZG-1rUcuq4A42-000bET; Wed, 31
 Jan 2024 15:01:03 +0100
Message-ID: <b3f62de1ba3298d4fb3b94d6abd6f1ed3413fe69.camel@gmx.net>
Subject: Re: Error when running fio against nvme-of rdma target (mlx5 driver)
From: Arthur Muller <arthur_mueller@gmx.net>
To: Christoph Hellwig <hch@infradead.org>
Cc: Martin Oliveira <Martin.Oliveira@eideticom.com>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Kelly Ursenbach
 <Kelly.Ursenbach@eideticom.com>,  "Lee, Jason" <jasonlee@lanl.gov>, Logan
 Gunthorpe <Logan.Gunthorpe@eideticom.com>
Date: Wed, 31 Jan 2024 15:01:01 +0100
In-Reply-To: <ZbpIqA9eZ5YYJOPO@infradead.org>
References: 
	<MW3PR19MB42505C41C2BA3F425A5CB606E42D9@MW3PR19MB4250.namprd19.prod.outlook.com>
	 <9a40e66eb8ffc48a2e3765cf77f49914d57c55e7.camel@gmx.net>
	 <ZbpIqA9eZ5YYJOPO@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:MVHxHVq9bxTOv2zhEMHLG8J4U8Zq5K+C3E5IHapX7xNLVkVLg6g
 puytftjCTZBWq2+b6UXbOHnVXTSMZs7tvSpi4fuUrK3PTj01mzDoupnpHAmFwEY9B7Hje5C
 OWyubE6WR3B2JuccOB7mIQGDKKD1TjSyNbfrxrm+HS2AX63sBl8GKNOPKx99MAFZ+r4FoGO
 xe/Czl1z6tyxK/6BPiJHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gUMNRFtlek0=;K9s9ZAZAdrszcVIC8kWe0/rwiVe
 ZFbD1hvpqJlwhhJqLiyrh+Xshv+x9vdKRYtzbygENz+jnfBDhp160gOO8GAxqlth3i6quodKu
 CaWwPufwlHDNNjzqlY6ATIzJkrKXm/uXMaMOKjPwU/Q1zpa9KlnIhyTDnFcqlkKAbjuJIjfYn
 yfEnqk5DCy7izwsnGkx7Lu6m5QTUzi/6Qrm/u9IjyXx7xuBCD1oAidQSztBcPj4By/B71SPi+
 uRydrPwTZen3cojFsEO+QutfRkMsNSA/ZgKL155oIQ5+QSkxvX7GkgNsfeLPF22R0srhNk3IG
 ENT46HdOHcWsvLi2fF57Y7yb0zP0eB134LXy3RHMVH/gVE3QS8DlMViJa1iGL8s8wraqOb+bR
 kvB0BqizQZj0wYvSWgFl05u1EmsIZr5jqxJb4EmCDIzziLrBIMTBlR3WwZeIBltFOBiWL0xp7
 cJONVsaWAZp366oDzDsqfVKVJWsbupXE1XtBQcT5JJ/2mbDrwmMH4zD1CBRbPclWhgD0Jx/1g
 3f23cnCO7XHGm4N+PCi0+0ld3oHf+m46bzeeiE/2mwsvy3DaIR4G5/P6xV+wTeN+HCooJPnkM
 +sUOekls5nC8XKJsn7UBF+QuiL56Mee2QzIzw+CsGikZzTn9MUEp+5E+AKlUQ8kHTNq+N1pZI
 SCiD1lQKBmJx9OWnKPH7/ZJhKwiUm9GgIKYMQFHGVCswHlv1IoJUirbZ8swrLsABlSIF6MX7K
 Pi5K9l+FmcQ4+RdhM9ylTuabWWQTtKherKiY9XTplzkQ9preZ8PjWYX9s5cgEFsnX6GjXdYrw
 Ex20Q95FqTWoqNI6uL9GxB8slQAQjp0eYSEotilxM5oec=

On Wed, 2024-01-31 at 05:18 -0800, Christoph Hellwig wrote:
> On Wed, Jan 31, 2024 at 06:34:00AM +0100, Arthur Muller wrote:
> > Dear all,
> >=20
> > We've encountered a similar issue. In our case, we are using the
> > Lustre
> > file system instead of NVMe-oF to connect our storage over the
> > network.
> > Our setup involves an AMD EPYC 7282 machine paired with Mellanox
> > MT28908 cards. Following the guidelines in the Nvidia
> > documentation:
> >=20
> > https://docs.nvidia.com/networking/display/mlnxenv584150lts/installing+=
mlnx_en#src-2477565014_InstallingMLNX_EN-InstallationModes
> >=20
> > we compiled the MLNX_EN 5.8 LTS driver using VMA. Additionally, we
> > experimented with the latest MLNX_EN 23.10 driver, encountering the
> > same issue.=20
>=20
> If you use the nvidia out of tree junk you are completely on your own
> and have no one to blame but yourself.=C2=A0 Any problems with that do no=
t
> belong on a Linux mailing list.
>=20


Dear Christoph,

thank you very much for your reply pointing me to the possible cause of
the problem. I am not blaming anybody. According to the history of this
thread I was assuming that there might be an unsolved IOMMU issue and
just provided some context, hoping I can help debugging it. There are
some IOMMU-related theads on Kernel's Bugzilla. Mentioned setup was the
most similar to our.

Kind regards,
Arthur M=C3=BCller

