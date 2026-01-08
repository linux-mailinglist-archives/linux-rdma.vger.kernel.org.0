Return-Path: <linux-rdma+bounces-15363-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5A6D01CA6
	for <lists+linux-rdma@lfdr.de>; Thu, 08 Jan 2026 10:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C641E300D433
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Jan 2026 09:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593EA392B92;
	Thu,  8 Jan 2026 09:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bizzio.pl header.i=@bizzio.pl header.b="o9cp4Xr2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail.bizzio.pl (mail.bizzio.pl [149.202.41.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98284395DBD
	for <linux-rdma@vger.kernel.org>; Thu,  8 Jan 2026 09:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.202.41.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767862863; cv=none; b=W2tXcttB70fQrZvNvszvRmfygDA5ezoHf61BFHgGOALdbG8OPKZ3lPCIr6IvEtOgDl2FBnZ2JayQSka2AeJewXv5cHV5v4bnM8uPlBsWQK8BYkGRB4lTgJuXJBXjnsKLucHQTx/zyvVfOgF2pYH3Y33Fvu+iDsH6H5N/70Vz+Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767862863; c=relaxed/simple;
	bh=emtNukB0ycq9ym2nAqltSyV6PRs1Wc7VUTOuKpVmMAw=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=eNNx3ONoDQg1c6Nr5A0z76fBWVXxqFpussVpKXC8lxC2xIWkiEUIgQ85D82qw8YdPDSKNYchYzjn+mt2pJdDYGC6lnZKwbbU3B+xVgZSST4Ko89MsNdDkO7I49iAwYspor3PIocZ6PIkBDg1srJ66W4v8nAb9ked0u1svnnvvHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bizzio.pl; spf=pass smtp.mailfrom=bizzio.pl; dkim=pass (2048-bit key) header.d=bizzio.pl header.i=@bizzio.pl header.b=o9cp4Xr2; arc=none smtp.client-ip=149.202.41.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bizzio.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bizzio.pl
Received: by mail.bizzio.pl (Postfix, from userid 1002)
	id 2177D24DDE; Thu,  8 Jan 2026 08:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bizzio.pl; s=mail;
	t=1767862691; bh=emtNukB0ycq9ym2nAqltSyV6PRs1Wc7VUTOuKpVmMAw=;
	h=Date:From:To:Subject:From;
	b=o9cp4Xr2anB3w42PoZL2sqE6106wQFhXdXiYhxnKQS9lHZaJEF2f4eyzqlQfvM1gF
	 xzqGV378NRQEPke2W9bSpIligRQCUZMP9YzER+P0F7LA1Mkg8DpJnD7LqQ6W9vfBCj
	 AHBMM3mhry0yQcNeOHlMY2gh9EbYZG3P60PufGHW/hkK8qbAE7gKRcWlPXumBR6cxd
	 LDCdjni6MLLlMNhLfv7JacdS7YWCyN3jWKwweaRjeuaBEsjL2XcT92FQ0+fnzaBdxw
	 sNRp0Xn5HVkpkUyPrVxecnPtpUNMGjBKXCLJPVmVi3q847AI8i/pFHucXDNWXnVAWX
	 4Xrp9LPmg04Yg==
Received: by mail.bizzio.pl for <linux-rdma@vger.kernel.org>; Thu,  8 Jan 2026 08:55:57 GMT
Message-ID: <20260108074500-0.1.4w.1hn4r.0.wg7jn29hue@bizzio.pl>
Date: Thu,  8 Jan 2026 08:55:57 GMT
From: "Justyna Prokop" <justyna.prokop@bizzio.pl>
To: <linux-rdma@vger.kernel.org>
Subject: =?UTF-8?Q?Ulga_na_sk=C5=82adki_ZUS?=
X-Mailer: mail.bizzio.pl
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,=20

chcia=C5=82abym wskaza=C4=87 Pa=C5=84stwu mo=C5=BCliwo=C5=9B=C4=87 zarz=C4=
=85dzania benefitami w =C5=82atwy spos=C3=B3b, poprzez nasze intuicyjne n=
arz=C4=99dzie, jakim jest karta lunchowa.=20

Nasze karty oferuj=C4=85 wygod=C4=99, oszcz=C4=99dno=C5=9Bci i zdrowe wyb=
ory =C5=BCywieniowe. Dofinansowanie posi=C5=82k=C3=B3w jest korzystne dla=
 obu stron. Karty lunch to dla pracodawcy realne oszcz=C4=99dno=C5=9Bci w=
 postaci zwolnienia z ZUS do 450 z=C5=82 miesi=C4=99cznie na pracownika.=20

Kart=C4=99 mo=C5=BCna do=C5=82adowa=C4=87 dowoln=C4=85 kwot=C4=85, a niew=
ykorzystane =C5=9Brodki nie przepadaj=C4=85, lecz przechodz=C4=85 na kole=
jny miesi=C4=85c.=20

Mog=C4=99 przedstawi=C4=87 ofert=C4=99, kt=C3=B3ra pozwoli zoptymalizowa=C4=
=87 koszty i zapewni=C4=87 pracownikom po=C5=BC=C4=85dany benefit?


Pozdrawiam serdecznie
Justyna Prokop

