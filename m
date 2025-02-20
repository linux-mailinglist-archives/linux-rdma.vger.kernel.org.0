Return-Path: <linux-rdma+bounces-7885-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65619A3D3C8
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 09:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96DD3B0718
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2025 08:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41F31EC013;
	Thu, 20 Feb 2025 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhusA3n6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61FE1EBA1E;
	Thu, 20 Feb 2025 08:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041683; cv=none; b=VIAH0V/Ag9q/7+eoMtPwgrXLR4UH/1S9KKngpxkzVJtoICiWXU1iAKgFsmeiEhAIETnbM1PxxJxGPNZliHsHy/dXqUtAFWJFyOKzyGtCPBuSAbH0BovBL7WAFXhg8l5COI7sHdmK1GWaZrZ9EfWUvgGCybQu/DBFz3C3bDYlGHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041683; c=relaxed/simple;
	bh=dqQ0SKzivqhys/digMbmEeqWgEakp5WM9xDxA2nBruI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=rDIsZ4x9nyFXJiKFfDb7ziyFbVw8GrSkW6jORDP19ET4ksDzOfsXfGm5zoFrGS/tSsOlbsOtzUHYxvmirB8NOZhs7ST2Nrewv7ernKmi8MRZS/bpxSNoIoShAsYGTqGlnAHXSRtfwlDSfpAaA9W75j3l6mXn8gyCpcZCInUbbhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhusA3n6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02976C4CED1;
	Thu, 20 Feb 2025 08:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740041682;
	bh=dqQ0SKzivqhys/digMbmEeqWgEakp5WM9xDxA2nBruI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=AhusA3n6ogCPeJqwzTIc7zCEpBx9gtTPjhqFynV6rpziPNetpO3duWtTdc57/82Ef
	 TSE22uU8nonEekQNXvox2yHOCF8mZQhsV4c6VFJ5FYXmM/g8jI3zLTF/F2+oqsOnYt
	 RpD6joKq1boATFnQfokKRWrlephU5XQfJVx0ZaxZziOX+nEe5G4dTAPWjX2NCt8nfU
	 xn4XZhIdOVKE05XnjP71qzQ7tlUXl6+42VaR+sXc3G+E1wiCOEt4jJMMenc7dRMffG
	 Nj13tJzfMQpgVF4cpr675uj4brbSg+EZfM/Ca9+XTUBgcHqF1KgQKh+ue1VQN+5Bqk
	 Zsn4tbSNIA3iA==
Date: Thu, 20 Feb 2025 00:54:38 -0800
From: Kees Cook <kees@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
CC: Allison Henderson <allison.henderson@oracle.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-hardening@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next=5D_net/rds=3A_Replace_?=
 =?US-ASCII?Q?deprecated_strncpy=28=29_with_strscpy=5Fpad=28=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <08A0C3AE-A255-467F-A007-5584E8E44517@linux.dev>
References: <20250219224730.73093-2-thorsten.blum@linux.dev> <202502191855.C9B9A7AA@keescook> <08A0C3AE-A255-467F-A007-5584E8E44517@linux.dev>
Message-ID: <CCF15545-8AF8-40A8-917C-E44B6373D9AE@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On February 19, 2025 11:04:18 PM PST, Thorsten Blum <thorsten=2Eblum@linux=
=2Edev> wrote:
>On 20=2E Feb 2025, at 03:57, Kees Cook wrote:
>> On Wed, Feb 19, 2025 at 11:47:31PM +0100, Thorsten Blum wrote:
>>> strncpy() is deprecated for NUL-terminated destination buffers=2E Use
>>> strscpy_pad() instead and remove the manual NUL-termination=2E
>>=20
>> When doing these conversions, please describe two aspects of
>> conversions:
>>=20
>> - Why is it safe to be NUL terminated
>> - Why is it safe to be/not-be NUL-padded
>>=20
>> In this case, the latter needs examination=2E Looking at how ctr is use=
d,
>> it is memcpy()ed later, which means this string MUST be NUL padded or i=
t
>> will leak stack memory contents=2E
>>=20
>> So, please use strscpy_pad() here=2E :)
>
>I am using strscpy_pad() here already because of the NUL-padding=2E
>
>Did you just miss that?

Well that's embarrassing=2E Yes, I must need stronger glasses=2E *sigh* Ap=
ologies for the noise!

Reviewed-by: Kees Cook <kees@kernel=2Eorg>


--=20
Kees Cook

