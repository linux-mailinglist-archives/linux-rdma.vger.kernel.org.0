Return-Path: <linux-rdma+bounces-8268-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D36FFA4CB87
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 20:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB69F188A1E9
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 19:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB7622D7AA;
	Mon,  3 Mar 2025 19:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLTA0aWp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CF7214A66;
	Mon,  3 Mar 2025 19:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741028668; cv=none; b=TYJMVkLyoQklhCe/gOq3AE+2oT13NKH7CRhqscZpcak8Z+kHB7LrHCBRZMpk19d0SkIfvmF4kgBHbjmcyht1aGu6M6kKqfZX2X1MZ59pjb7PCZiZgNHHD6CJqIcPaeI2+2WcjKaLb2QF3oXH/IC/uJ7cgaf4laFcAEsaAXMfE6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741028668; c=relaxed/simple;
	bh=8LWjj1yF/l6+Nko2dcGTFSkEZL9I6BsHVDOlJmSVy6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPGrqLP7NTHqX883HwfmHA5PBrSYwbDMmPwq0CNF/xHT12pXVwkRP30vm2gS+QsDbM7Pz57eZ5pxxa4mfc4oJUHjUwbi689NX7DHwdMGKPjjKiu2MWv/vqg/pMVWf36Mh3DUHiz1z8Wv5MKXRyTb/Ug1sl0sz0nKmuwjnahGnbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLTA0aWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31EB9C4CED6;
	Mon,  3 Mar 2025 19:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741028667;
	bh=8LWjj1yF/l6+Nko2dcGTFSkEZL9I6BsHVDOlJmSVy6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gLTA0aWp1PJmysQcPGb5IH62IBT2mqNCpy9v7Q6+ovo7Om05FhNhhV5tOiCWgcNO0
	 xnXU26aMFijSyIycRCyObC4e+iygvPKnKOilWuErIxU3FkgBdGwonbgm0axassVAD4
	 RIKFLYITJzwZK2Wbh+PMGVLjj4iEQfU9w7GYpsJlwZGQ4E/5Ad9nSGlPJj1FgiB2Ci
	 XqGROHu/cjf+8jQlWKOTS3Bu2e4+gcTD6YgIB5gAfgy90PapQrXMf19IJYxHiYiit/
	 SiBGymKYizRwkxEaFz55Shw0tcwg5Qdr57PDjmzmfDZs0DcYISb9gcES1esOYH6Zyo
	 XSjrTaopHlWbw==
Date: Mon, 3 Mar 2025 21:04:24 +0200
From: Leon Romanovsky <leon@kernel.org>
To: cgzones@googlemail.com
Cc: Serge Hallyn <serge@hallyn.com>, Jan Kara <jack@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, cocci@inria.fr,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 11/11] infiniband: reorder capability check last
Message-ID: <20250303190424.GB1955273@unreal>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de>
 <20250302160657.127253-10-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250302160657.127253-10-cgoettsche@seltendoof.de>

On Sun, Mar 02, 2025 at 05:06:47PM +0100, Christian G=F6ttsche wrote:
> From: Christian G=F6ttsche <cgzones@googlemail.com>
>=20
> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>   1. A denial message is generated, even in case the operation was an
>      unprivileged one and thus the syscall succeeded, creating noise.
>   2. To avoid the noise from 1. the policy writer adds a rule to ignore
>      those denial messages, hiding future syscalls, where the task
>      performs an actual privileged operation, leading to hidden limited
>      functionality of that task.
>   3. To avoid the noise from 1. the policy writer adds a rule to permit
>      the task the requested capability, while it does not need it,
>      violating the principle of least privilege.
>=20
> Signed-off-by: Christian G=F6ttsche <cgzones@googlemail.com>
> Reviewed-by: Serge Hallyn <serge@hallyn.com>
> ---
>  drivers/infiniband/hw/mlx5/devx.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Thanks, applied.
https://web.git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=
=3Dwip/leon-for-next&id=3D3745242ad1e1c07d5990b33764529eb13565db44

