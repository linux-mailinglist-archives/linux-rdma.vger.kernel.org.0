Return-Path: <linux-rdma+bounces-9495-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 683CFA90B6E
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 20:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2B2B3B64A5
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 18:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F0E224227;
	Wed, 16 Apr 2025 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Qqo1+7bO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A4B2222B0;
	Wed, 16 Apr 2025 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744828751; cv=none; b=E4JaEXN0r3fsdfKqQjwrCNxD0sj0CPhRBuvVl4nqu6kUJo6+C86SOw8gziiODN/I4hb+VYZ7T1FBK2/I3nsAE99ET3tFl4KxdKfMY4BADOzVPrEJL00FDyoUnYNcR6vJYBRHQBtSNnZ9hDkVk1+QolxKWr4ONEo1yYnvQl3NMHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744828751; c=relaxed/simple;
	bh=g6p8wSF/Di9t0vl6klobyNO8oa8BX+pSLfq24fDqHcE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=RC3RkXWJUzflOXejGJP/G6xJBU+3Bw0dzjFhSwYkQhcELqkJjIb4pSwUyxB9IpGfeyFWGDV/eMo1dn3daOZGi834kLBt5rIzegJsKCOgZCitsUJzcvJItX/bxsGLszS8OxkGjmrT79G3yP0j5bLORMN4FuZBYNiotxgDTQomBuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Qqo1+7bO; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744828735; x=1745433535; i=markus.elfring@web.de;
	bh=g6p8wSF/Di9t0vl6klobyNO8oa8BX+pSLfq24fDqHcE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Qqo1+7bOhEUNCmPWfSJaiYKepVNs2GIP3Gi+3WHkEacsCIBn/wf5uWEO74OQrc9r
	 3BIFiZTG5c2v/ebtibMG6dGbhERYwhdXbUxx0+80V40RgbxKZhZnfy46a+uJjkzEH
	 riL3VW490/2G88P8aLksTaIi/XuTjdNxiFBSA4eKzBCq4TA7JG1lZWcifUaGzSKEm
	 uafnv00wCiyuzy65iFUBst7QdQG4fujjg0sUx8rNYc3wxfkn5fqOEg5/uO+JcObXh
	 2y9zVI1Ew8KCBLfH0xw6yWjUH+xZE+x7XRXCaogTgBxXwHasqvO5RdiUJZQpfAcvC
	 2VRIYrh/ndwbPQirFQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.13]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N4vNe-1t4Btj2Xcy-017Qj4; Wed, 16
 Apr 2025 20:38:55 +0200
Message-ID: <9ae2b1be-0bd7-42f6-b8e3-4786e22cb271@web.de>
Date: Wed, 16 Apr 2025 20:38:44 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Henry Martin <bsdhenrymartin@gmail.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Amir Tzin <amirtz@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Tariq Toukan <tariqt@nvidia.com>
References: <20250416092243.65573-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH v6 0/2] net/mlx5: Fix NULL dereference and memory leak in
 ttc_table creation
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250416092243.65573-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mSLhQutZM4kqZTgdGPHo7i+HhbSjqvmSPg7vsFks+Q/ivxn9jKc
 xEf8IatYt/MlmtUZoyy4OxUk2hFPsvzn0fBjQcg9f62/Dr/69z73Zh14kFhrnW0pyk11tGP
 Nv3Rte12nHWDViJ6U+vV55a1cGSRgE1giMop7LyWkoA+VYXL660jfHxd+yrh0dEfGoteS4q
 UtWQ7Gh2s6NLk/ketLuFg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lsMTTt34LZw=;ocFmzeWH/texmyqBHNCWwchc6vd
 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
 FOqlo52zIIhYY=

> This patch series addresses two issues in =E2=80=A6

It would have been helpful to extend patch version descriptions accordingl=
y.
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.15-rc2#n310

Regards,
Markus

