Return-Path: <linux-rdma+bounces-14618-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CECEBC6D893
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 09:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 661F32BE07
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Nov 2025 08:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C5F328603;
	Wed, 19 Nov 2025 08:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=novencio.pl header.i=@novencio.pl header.b="Up9Ffg7H"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.novencio.pl (mail.novencio.pl [162.19.155.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126F13161B9
	for <linux-rdma@vger.kernel.org>; Wed, 19 Nov 2025 08:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.19.155.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763542608; cv=none; b=ZlESH5r1j0UvaA2kXW8yd6slkcrEqo5x0IbR5j48dziSUdsTqLUnVHh1KnCkhwey0Kj2jjyrUnpS9SZv027vZilj4+vbP3V0z90ZETXgfvDSaG0pHtOHsgUrx0CDrH2TRR994UqlCVVAGYGQ4Xt0yzbwMF7wj3mE8NwWKsJLKuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763542608; c=relaxed/simple;
	bh=fIh67CnJs35z4uTVN1yEzBZIG1sWJSjOc8Phu/rB5ug=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=KUXFhH0fZuovNWWLJyKSiMikCvxCfNzOGjTF/ld38DyAOZZEJNZdK/SM2VWkUlSeRQho5pQq3kvfnVB1numgLEVbUJTq6hN+JOgXgGI2Kh4C5VE892zo9DhMNezI7gfm1pcb4F1GSEcuj0CcyyYfKyCwfmTwpHGjzcPj1uDMevU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=novencio.pl; spf=pass smtp.mailfrom=novencio.pl; dkim=pass (2048-bit key) header.d=novencio.pl header.i=@novencio.pl header.b=Up9Ffg7H; arc=none smtp.client-ip=162.19.155.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=novencio.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=novencio.pl
Received: by mail.novencio.pl (Postfix, from userid 1002)
	id 4AAD52352D; Wed, 19 Nov 2025 08:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=novencio.pl; s=mail;
	t=1763542605; bh=fIh67CnJs35z4uTVN1yEzBZIG1sWJSjOc8Phu/rB5ug=;
	h=Date:From:To:Subject:From;
	b=Up9Ffg7Hb1IwpKtvmRSBydAHo77Qn/guEsVtHH3RtUeFWscKPpME+igt9qeEt4Z/U
	 exGj5pSS8iXpLb3+skM6aPStEor5iRyiqgN7AYUqQhksCugxT/z8VtLJ/UWWICYSjG
	 PN5uFIhb/VXWNhhAjK1oQL56hslmNqjvMogQBJZpURIpbeqVqejLk/Ny2rwH/cebm/
	 R/ioDz73WlOmG5IxVtKxy3ZM3X62AfH6W3/qXLyNA04AG4ESidMwcvCVHyBAGPO9f0
	 pDBFOMLngnTM+CufuLheMTUX5xrxABj6mPiy1rIez4G1D9xmi0AhkohBRby3Z3THcI
	 Qw60iPfAadIwA==
Received: by mail.novencio.pl for <linux-rdma@vger.kernel.org>; Wed, 19 Nov 2025 08:55:55 GMT
Message-ID: <20251119074742-0.1.5y.z3kc.0.72ubg373go@novencio.pl>
Date: Wed, 19 Nov 2025 08:55:55 GMT
From: "Marek Poradecki" <marek.poradecki@novencio.pl>
To: <linux-rdma@vger.kernel.org>
Subject: =?UTF-8?Q?Wiadomo=C5=9B=C4=87_z_ksi=C4=99gowo=C5=9Bci?=
X-Mailer: mail.novencio.pl
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

pomagamy przedsi=C4=99biorcom wprowadzi=C4=87 model wymiany walut, kt=C3=B3=
ry minimalizuje wahania koszt=C3=B3w przy rozliczeniach mi=C4=99dzynarodo=
wych.

Kiedyv mo=C5=BCemy um=C3=B3wi=C4=87 si=C4=99 na 15-minutow=C4=85 rozmow=C4=
=99, aby zaprezentowa=C4=87, jak taki model m=C3=B3g=C5=82by dzia=C5=82a=C4=
=87 w Pa=C5=84stwa firmie - z gwarancj=C4=85 indywidualnych kurs=C3=B3w i=
 pe=C5=82nym uproszczeniem p=C5=82atno=C5=9Bci? Prosz=C4=99 o propozycj=C4=
=99 dogodnego terminu.


Pozdrawiam
Marek Poradecki

