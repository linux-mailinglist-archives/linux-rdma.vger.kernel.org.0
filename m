Return-Path: <linux-rdma+bounces-14245-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D476EC31B1C
	for <lists+linux-rdma@lfdr.de>; Tue, 04 Nov 2025 16:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7186D3AA5CC
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Nov 2025 14:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA25333736;
	Tue,  4 Nov 2025 14:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="szIn24wp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E493328F2;
	Tue,  4 Nov 2025 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268171; cv=none; b=VqUbG54ZHNMT+CWn8TlUShhiSJyGUJyvvi2LE2A2lcCrr7KpxGV86hgaywASewQCw9skFmv1unAtBV7Ihk0G9HaPC81K1rANXp7a/BMFQ0+RwrOdzMP0bAjzqC4GFeujw5y4mjU9rJU9x2MsDG7A+jws5FhWPJnPqC3loWRsyaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268171; c=relaxed/simple;
	bh=lFHqmfqjInR++fuy7MylpWpAhCLAZ7fTkTfLDwYTIRI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=GW1okTsGkEM4zaV/Yzrhbd2zt0iuw5pomJy5UVtJl7iBlsKzmOghdbugiGCF3I1jl6Epd5Q0h0J/gZfh8DTW29gIyUeE4NmBLqnYa56HEsLgG340wQq2Cfk3wr1sEGUzMqLH/Zyhm3GAh/yAIfsaYiMbV1tTlCMRUZaI1a2bDyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=szIn24wp; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1762268156; x=1762872956; i=markus.elfring@web.de;
	bh=lFHqmfqjInR++fuy7MylpWpAhCLAZ7fTkTfLDwYTIRI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=szIn24wpQsAers95vQ+PYSOkPw+E9Fb0kT8L81SqYp2nqxlpQ8Rl6r6xuVr9bx5o
	 Lp1aJDToRzNAX7GNolfcQSfbB43MoXaANc/LzxyIyGg8q4bZLXBRzT9YswbkLyvJI
	 CxnCa2nbe+lT3sgjJQUPeKDE+tR3WEyH7pGS0it6o5YMPB3c7vlLHZlhBJHxUnlkW
	 Q8JaediQ7LB3cl2qLg4iYjf6ekxBYZ99ujwbHT1N8KSHIfCLr6d60oUNcyF3MOsWj
	 cgM/s7u6SqIGw0XbHZ6eslI2Qx1DpWzsjpC6duBIdkZiNjzuXM9UCdDC5f3Zl142d
	 qf4bRMaPL/BSysSLuA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.227]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgzaR-1vtCUr0oqz-00nwdZ; Tue, 04
 Nov 2025 15:55:56 +0100
Message-ID: <073e1aed-11d4-4410-b40c-1d4684f3c192@web.de>
Date: Tue, 4 Nov 2025 15:55:37 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: make24@iscas.ac.cn, linux-rdma@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Danil Kipnis <danil.kipnis@cloud.ionos.com>,
 Haris Iqbal <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
References: <20251104021900.11896-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] RDMA/rtrs: server: Fix error handling in
 get_or_create_srv
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251104021900.11896-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c1ZwohL0bP/VTTUzKNy7Uvy7AP9yv6cwF3amJ/OrcqNxUudfRfn
 Hv+TGUJq4Z99ZcdZ2zGNvpXz2ouD93vvyRUdrzI6AISP8rLqwdW/3NQH1PCFkb4iBY1pua7
 hM1PFWAK+pU/Z+6a5KmyiyQ7IB9NZZ+WqpP0iko0amsOn9jYQct8LUo6qVv052LgovFhmbk
 1VDc1wSUtiI/kJx5QKzLg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ON9LiD21JUo=;GGcCWjEdgQgf7oPP04e+h6BNUgE
 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
 mjNZ0eJj7R7mIQdb8R+zrBjSP8=

> get_or_create_srv() fails to call put_device() after
> device_initialize() when memory allocation fails. =E2=80=A6

Why do you propose then to replace a kfree(srv) call by put_device(&srv->d=
ev)?


Would an other word wrapping be a bit nicer for such a change description?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.18-rc4#n658

Regards,
Markus

