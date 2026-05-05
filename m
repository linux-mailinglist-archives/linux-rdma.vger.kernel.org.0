Return-Path: <linux-rdma+bounces-20028-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFSZHqgV+mntJAMAu9opvQ
	(envelope-from <linux-rdma+bounces-20028-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 18:07:04 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3A94D0E07
	for <lists+linux-rdma@lfdr.de>; Tue, 05 May 2026 18:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0491E302B93A
	for <lists+linux-rdma@lfdr.de>; Tue,  5 May 2026 16:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E052B48B398;
	Tue,  5 May 2026 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TXITp4kL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F6548B38B
	for <linux-rdma@vger.kernel.org>; Tue,  5 May 2026 16:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777997149; cv=pass; b=YWfkmvpdfFjaAZDHPLMkxXULqA7tVqGH78NGzSI2ZArNouQd6WH6nZMSRAS9eqNfE0ct1oVBlb0SMEq0bRxrYcNySMWLPGaqmwSGc6Q4HlzuD+PcVo5pSHa6Akmzey77VKooYaxVmw8t39hjgp630KFjmyYmN8EKlWWkiCAjE8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777997149; c=relaxed/simple;
	bh=J6ANT64o73Oy/MqjWeiTVaKBLJandxdhBxQ3kDb+K3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EI6Z5ntDCQOThUI9fRMfxPRTCGgsMCojJsBrAtHI0ZOQnwl7MV10bDYoqhTxyrL/ykyETzmO1WXxhuHSlniiBtnOFGCHdzqDUY+2BbxE362bKxD9cHvh+mYL+bSl+H1M3Fu8ZMm5iqibau9MZWlWrIul3FuEUFSGJM16JREh0GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TXITp4kL; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-130c653cce4so1537431c88.1
        for <linux-rdma@vger.kernel.org>; Tue, 05 May 2026 09:05:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777997147; cv=none;
        d=google.com; s=arc-20240605;
        b=ZcDnsCidP5H9aO7JfUDAe0rqcZQcQE+OOlEg6gLy3v2Nw3OvOHeqKgGo+6EVVOZwUN
         w9ppbOQNFA1S6+6U97mCN4Tx0I8WrA+Hqs30iw65wc36JgNSoaGTs24pNuiNOMsXWs7A
         /Ycwy0LyPTQRNYQ8wxJ3H03eHgHF6i+5TNzy5Rs0tZhsa8qsnGjGDVQSikYaplNHiC4U
         zRKs2C49FhTwybzkAY23k+fs2ZgVc6/BgST/Utg9wwjwhBcMUfwOMFCndjIa9juoXE/c
         spfRVT/o6htOzba2kGdus8lQTSr/S+F1bbbl/QMSqR050/+3Enpfy8lsnrIWQtQ8HXG5
         2vtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jr+WQFKJTcHJZ0sRMLiTHOm1qsMvrLUcWME2L+LwpFY=;
        fh=NqvDLfMCMnJ2xL4gDhyHQ8ZZqDLrnz4YseLVnnsRQ5g=;
        b=ibI6HmMt4Q+JuEX5b0KfPa0T0FOuVtQj+grJMpT7PVAFTc3DYkC84ZkL38YI15EtHO
         EmnBo1JJsY6w+p9tKu7JGMklki8TpPUnMdCrVxAiqmfWVtARTridE12OOHx5R/oEiFPV
         StC6VKencwsA2vgzN6kHr+Fz25RpFXj5AwFF1DYsxWmLUPPPzhmsF/+Px7SjZz0IE1RJ
         zXtTHufy75YXHZgh2leHxEjPVgGQn+4ZDbLDZrSglrzWZK3MgagrgXbo1/4BwKYjVyI5
         SC9xGLHZp6azl+LSMUJLNaZk6qox93dEB2wbxDUUOeIbO1Jq+OyyR9RCjyIsxNd3hnOX
         ozXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777997147; x=1778601947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jr+WQFKJTcHJZ0sRMLiTHOm1qsMvrLUcWME2L+LwpFY=;
        b=TXITp4kLzGaLEQ2tD87iXCniwLYk0Hoh67wTjG6eywIBT8W8M9bYjQuTxUtBqXjcnz
         Z2A0YG2LTUTtYeaxAqFcvAPxJN18EGASAFFdhU+HBfELiWbMX1c5fXYpKnv8xPnHDDqU
         0a1zZoY8i4YZu58ZThlZJuMMvfXkFC5jFwPBRaNr0E3VFzQ0y8nuZum+qTbtSVodOz7s
         EUWJQGc2aZttD9MmCEKR5WUmXgNW88yJdHSQHO2Q0kd1jZKzfvrL4LHqBhEEgRkG75zC
         bZ4edVIte6ee4zBIDibknoORQmZ2R2BIy2irgABosj6PQEOXV3cxTH9mAqFLzuxmET+i
         8TMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777997147; x=1778601947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jr+WQFKJTcHJZ0sRMLiTHOm1qsMvrLUcWME2L+LwpFY=;
        b=KDgUvYDBl7NidoJb2H0VzmbsvKahVi2B5eqAM+PyKWQH36Zrox+ZSSWg/FD4+0lfy0
         gZVfrLB+q9X1aK86m4GemR+k+BaS2YJ5PAIfpcMj+PhYAnii0xMe7x5C+sYhcqTW+58w
         nxx88sUF5aCZ39fLTP5eDZPQJUAQbYXSRU32Btq2vv/+3BzAdS/ZSBk1B+julC0XwzVh
         I0RquM3BmuSoa1fx3Jjn0qPVULBw5Ngm4u/B9EBJo+3GU5Dp/GMClKiMPjjzaDpWiJ/l
         OPCe0+6wvdJsuhtqyD87xdVShGwWRksHr+3JtUn4vvZTVBCBXuRoKNbwUHtk2V6BPPKj
         tY9Q==
X-Forwarded-Encrypted: i=1; AFNElJ80IK3DqmfFKocUxBC/SsEVPXn+Y9kogYhnoaKrLjFzGE2CGyh8ucM6chQxknc/59N51A+zAS9y0Wk3@vger.kernel.org
X-Gm-Message-State: AOJu0YyVWBTT+A04vhXiy+/oHqS7K4b0wI9Kk2xzOv4yV+QLKBNoWndV
	x7xgQ8RpDi7lDk2pJeO0l78K6zsZTcnGnjZ4PVWmOCcUdRTmOkCjfm1yiI0/+1zbld+PVL2J15T
	kWHpXHVcFqa1r/nsb4tW9mr9QB1iVzR5dFJnkRFur
X-Gm-Gg: AeBDiet30/JNTxrh1pQddh3JjI7duMTmT8KCTb46X42nQQRhyVzEd+P7S8NA7wIYvKa
	ageWK0FwTzQDU4mdh57iVcgpxazXJHHZ6M6L/3LWIiB9gU27tLAj3G2v5q9EL9ub5lMxSEauXMo
	/T8ognAb/CCjQ7zWCTfdbmgTswjrW0Ol+LEI9eW74u7fwaiSpGZwjBq16+sQpSXIwPPT1gtaCf+
	ctKrMbzkiWajoZPOq72YrpiAU2zPXm2c3GhwZxFPVkV0qheEi5PO8Wp4k+4hHpfQa5/CvQ3p30J
	S8qBnZlfmoagimT5zupKbTCitI5Sy6MGoJhspg0F
X-Received: by 2002:a05:7022:6628:b0:12d:b214:7dbc with SMTP id
 a92af1059eb24-12dfd7da15bmr7713863c88.7.1777997146733; Tue, 05 May 2026
 09:05:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com> <7-v1-dc5fa250ca1d+3213-mlx5st_jgg@nvidia.com>
 <afkH3pMJKkIbElhI@google.com> <afoSQWreOWDIfVxZ@nvidia.com>
In-Reply-To: <afoSQWreOWDIfVxZ@nvidia.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 5 May 2026 09:05:19 -0700
X-Gm-Features: AVHnY4I9kiI4Q1jkqtdnHvyGsFiT-Xosh4J8OR2OjxYfYINDrozPSiggYWTK0ps
Message-ID: <CALzav=c2r5cBSpgnG6-Njc3sGrrtt-weFXo1pRUL862SdK7w=A@mail.gmail.com>
Subject: Re: [PATCH 07/11] vfio: selftests: Allow drivers to specify required
 region size
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org, 
	Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5A3A94D0E07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20028-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmatlack@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, May 5, 2026 at 8:52=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wro=
te:
>
> On Mon, May 04, 2026 at 08:55:58PM +0000, David Matlack wrote:
> > On 2026-04-30 09:08 PM, Jason Gunthorpe wrote:
> > > Add a region_size field to struct vfio_pci_driver_ops so drivers can
> > > declare how much DMA-mapped region they need. The mlx5 driver will
> > > need ~18MB for firmware pages. Existing drivers leave region_size as
> > > 0 and get the current default of SZ_2M.
> >
> > I would like to get rid of the magic SZ_2M to make it easier for other
> > tests to use the driver framework. Can you make this commit update all
> > the drivers to set region_size? They can all use the same approach:
> >
> >   struct vfio_pci_driver_ops foo_driver =3D {
> >           ...
> >           .region_size =3D roundup_pow_of_two(sizeof(struct foo)),
> >           ...
> >   };
>
> Sure, lets put the roundup in the core code?

Sounds good.

