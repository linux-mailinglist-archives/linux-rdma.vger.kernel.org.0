Return-Path: <linux-rdma+bounces-19848-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKYgD/u29WkbOQIAu9opvQ
	(envelope-from <linux-rdma+bounces-19848-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 10:34:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A054B173C
	for <lists+linux-rdma@lfdr.de>; Sat, 02 May 2026 10:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12FE33006817
	for <lists+linux-rdma@lfdr.de>; Sat,  2 May 2026 08:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83494309DAF;
	Sat,  2 May 2026 08:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="xCARrbXu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FDE13E02A;
	Sat,  2 May 2026 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777710837; cv=none; b=DgJ1vPQqxWm9zHMEnOW9iHhMhzUjX/G4/FZiSzE93L5sOMXOYrYoOyALpDE3PEexBfjwvelvKtJIgniEpQ6P17ympOxn9CDKHObb6BFp06yQREN7knmMcfGDUtqFbUv2zHAFRTxvQTTDVrRUDqAQ/uBhRvBKk6S+S91eZ7oQaQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777710837; c=relaxed/simple;
	bh=AEFWyi1bfUyMJXHWZ66+GWlU4hMQ/K6QVwapHNfEqn8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L5CeortwlYj9CM2rnQA43PhV8VXwK9GQxheu6jjQeDTQgKkLOKJ+eBHTr1Tpxl1E8vsxZL36Ykfk7F/2AoNHxcTlCZibHjZyRyqe9iDeFRv8jA1oDyjmBoWpfujiVWUhWYt6C8So9o664cma6cjbkUskMlUNJ6pl1o6PsKRggnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=xCARrbXu; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4g71Qf0fv6z9tyN;
	Sat,  2 May 2026 10:33:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1777710826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2iWztUwm+o27y5dNxbgLF4/YL24oMbdNtxNqbeQMfI=;
	b=xCARrbXuP9oXDZ7MWbmLF4UFkigjkeGeqqH0KcAKvvS2dFJ32ChqDLYi3wQVGGd075y9Tk
	LFao7tfAX31YHgcilTqyNF+ZQSOMDKSGGzzZi6ym2W/OU5kAgLsEBw/7uyYgLkWlZGABLd
	OoKW3Z0wwo4bVITtmUcCmK/sVD0QL6ulZ842RewCzPfzQNYxTHKPyd4AvDvYRZlk0HCuNN
	54FfXr85SfuxlLkOGQ2ZZwcWbKhod265X+4d5nWGbsIvmhMB0eQz+yUOR8PlBYFWFsdMJ4
	+rPgzerhlbCN9ANeBLo/GWEUEduokIZdqVWJd/BedSH+eLngA5ugNCUI51drqQ==
Message-ID: <4007d59da564d357261b4ffa9c1daffcf09b5868.camel@mailbox.org>
Subject: Re: [PATCH 07/11] vfio: selftests: Allow drivers to specify
 required region size
From: Manuel Ebner <manuelebner@mailbox.org>
To: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>, 
 David Matlack <dmatlack@google.com>, kvm@vger.kernel.org, Leon Romanovsky
 <leon@kernel.org>,  linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,  Shuah Khan
 <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
Cc: patches@lists.linux.dev
Date: Sat, 02 May 2026 10:33:39 +0200
In-Reply-To: <7-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
References: <7-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-META: z4gfwoiygq3ad9gdyib4am31dmz9b8hw
X-MBO-RS-ID: 59239b2a35230070757
X-Rspamd-Queue-Id: 33A054B173C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19848-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manuelebner@mailbox.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:dkim,mailbox.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nvidia.com:email]

Hi,
On Thu, 2026-04-30 at 21:08 -0300, Jason Gunthorpe wrote:
> Add a region_size field to struct vfio_pci_driver_ops so drivers can
> declare how much DMA-mapped region they need. The mlx5 driver will
> need ~18MB for firmware pages. Existing drivers leave region_size as
> 0 and get the current default of SZ_2M.
>=20
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
> =C2=A0.../selftests/vfio/lib/include/libvfio/vfio_pci_driver.h=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3 +++
> =C2=A0tools/testing/selftests/vfio/vfio_pci_driver_test.c=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 3 ++-
> =C2=A02 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git
> a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
> b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
> index e5ada209b1d102..fa172635632453 100644
> --- a/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
> +++ b/tools/testing/selftests/vfio/lib/include/libvfio/vfio_pci_driver.h
> @@ -9,6 +9,9 @@ struct vfio_pci_device;
> =C2=A0struct vfio_pci_driver_ops {
> =C2=A0	const char *name;
> =C2=A0
> +	/* Minimum driver region size, 0 =3D default SZ_2M */
> +	u64 region_size;

i guess i do not understand this comment, but that's no surprise
because i'm new to the kernel.=20
would one of my suggestions be better?

+	/* Minimum driver region size =3D=3D 0 -> default =3D SZ_2M */

or

+	/* Minimum driver region size, default SZ_2M =3D 0 */

> [...]

Manuel

