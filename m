Return-Path: <linux-rdma+bounces-3082-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C81DD905AE6
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2024 20:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 316B3B254DD
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2024 18:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F823F9E8;
	Wed, 12 Jun 2024 18:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="W2oyjgUA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68134EB5E
	for <linux-rdma@vger.kernel.org>; Wed, 12 Jun 2024 18:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718216993; cv=none; b=AXunuCp1GCLXFUaJdA5BPSajg1r2K5XVbPpfylY0KJPKPK9aurqjkAEj2BkclEA5+Ea9ndbHr7D99Kf+474GjadM73pd90wpXHhfENVTJTcFnHf6fxDiHFu5cRfR4k4/OwEqtQ7upbBnMlOM1DdQFumlHAEeGShbP+HF6T7WC8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718216993; c=relaxed/simple;
	bh=3NCdBXrEDGmrLo9BwYhbCubM6UczQrSXDHeQMMSUIX4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Xgd7MjQe5mkYgQnJwga8E24LYOuoVW7K6Nw6gLJTbKEMYc10QNnd0+37+Y6/KZnItZuI0askiVVoAJcNngBFmaWHkcGZJUWMrx+lf0Gekqi02bJ0sBnLNhQJ1gYJPNwnFUU3DOIzSgu+ELJNY3i6QtCq4ZxyY0kb7ufzu0bviNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=W2oyjgUA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:Content-Type
	:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=3NCdBXrEDGmrLo9BwYhbCubM6UczQrSXDHeQMMSUIX4=; b=W2oyjgUANkHSUeksYGtVSeW+qs
	lq2QhxcCOePh0bCA6Jva6Cmy6NrTV4NH9wMZB1s8uKAIZCGm5I/V1xV2dkJ9AlEj/Z2kiRGGBVquB
	YfhnWlbRjBq0jXf4IfLuhgIxsC9g4KEs0k/1csIrtn/fvu2U7zB2SvB8IoNLc0MYjlOwZVNGgXjoG
	rKLPSeehmLz444d8DpKgqQGDJtH7MFRg5UXhRXbaOJKWBt3efdRm/w4oU9NtMKqdRYpziDiiMYizC
	KbMGUt3LFLonaf1xh7yShqRzF++PliaKBft7GTQ8e5Y5dCUh/ezFTeftvPim0HKYtLQrlEtfTUKys
	eT9miO0A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	(Exim 4.94.2)
	(envelope-from <peb@debian.org>)
	id 1sHSjA-0082J9-CS; Wed, 12 Jun 2024 18:29:44 +0000
Date: Wed, 12 Jun 2024 20:29:26 +0200 (GMT+02:00)
From: =?UTF-8?Q?Pierre-Elliott_B=C3=A9cue?= <peb@debian.org>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: linux-rdma@vger.kernel.org
Message-ID: <a4281961-3b17-4cbd-9a6f-1d0ddcd26be8@debian.org>
In-Reply-To: <CA+sbYW1bONzFsrKAD+NLbBEuSDvqdZ+mPT1srwXrp67go6GRaQ@mail.gmail.com>
References: <87jziucdlj.fsf@daath.pimeys.fr> <87frticdf8.fsf@daath.pimeys.fr> <CA+sbYW1bONzFsrKAD+NLbBEuSDvqdZ+mPT1srwXrp67go6GRaQ@mail.gmail.com>
Subject: Re: What's the current status with bnxt_re-abi.h
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <a4281961-3b17-4cbd-9a6f-1d0ddcd26be8@debian.org>
X-Debian-User: peb

De : Selvin Xavier <selvin.xavier@broadcom.com>
=C3=80 : Pierre-Elliott B=C3=A9cue <peb@debian.org>
Cc : linux-rdma@vger.kernel.org
Date : 12 juin 2024 19:18:34
Objet : Re: What's the current status with bnxt_re-abi.h

> Hi,
> bnxt_re-abi.h in linux kernel and rdma-core uses abi version 1. We
> dont bump up the version in upstream and backward compatibility is
> maintained using the comp_mask field of the interface structures.
>=20
> If you are using the latest drivers maintained in the Broadcom site
> (which uses ABI version 6), you need to use the libbnxt_re hosted in
> the Broacom site itself. We maintain compatibility between the Out of
> tree driver and Out of tree library.
>=20
> Thanks,
> Selvin
>=20
> On Wed, Jun 12, 2024 at 10:21=E2=80=AFPM Pierre-Elliott B=C3=A9cue <peb@d=
ebian.org> wrote:
>>=20
>> Pierre-Elliott B=C3=A9cue <peb@debian.org> wrote on 12/06/2024 at 18:47:=
36+0200:
>>=20
>>> Hello,
>>>=20
>>> In bnxt_re-abi.h, the abi version mentioned is 1. It's used as it's in
>>> all libibverbs to determine the min AND max supported ABI.
>>>=20
>>> bnxt_re isn't currently mainlined in the kernel,
>>=20
>> Sorry, a word is missing: "Recent bnxt_re isn't currently mainlined"
>>=20
>>> and those eager to use
>>> the driver need to rely on the one provided by broadcom on their
>>> website.
>>>=20
>>> The thing is, they bumped their ABI version multiple times (current is
>>> 6). In the current context, one can't use the manually compiled bnxt_re
>>> driver with libibverbs as any call will error due to the bnxt_re abi
>>> version being outside of min/max supported abi version.
>>>=20
>>> What's the current situation regarding bnxt_re, should we consider
>>> libibverb support of bnxt_re as deprecated?
>>>=20
>>> Of course I could have missed something, sorry for that if that's the
>>> case.
>>>=20
>>> Bests,
Hey Selvin,

Thanks a lot for clarifying this.

I built libbnxt_re, but the thing is, I can't use the usual infiniband tool=
ing (ib_write_bw) et al without using libibverbs which is still the linux-r=
dma one.

Do you have an alternative to suggest that I should consider?

Also, would a RDMA+SRIOV-capable broadcom card with the latest firmware (22=
9 something) work fine with the drivers shipped in rdma-core.

If so maybe I should use what's provided by the kernel and rdma-core.

Bests,

--=20
Pierre-Elliott B=C3=A9cue

