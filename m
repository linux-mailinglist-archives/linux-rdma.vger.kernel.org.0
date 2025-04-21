Return-Path: <linux-rdma+bounces-9630-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9534A94E6D
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 11:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A9DC16EB06
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Apr 2025 09:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F7321420C;
	Mon, 21 Apr 2025 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="SxHP2NZ0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33196CA5E;
	Mon, 21 Apr 2025 09:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745226649; cv=none; b=K47cBBSEnZnKCvyiuufYgr73h1ELzoPGsf4wjPETapj9fxqJEHpN1Baiew/IoK5qHZTzZQxDww8HCq3RS/M9158ejW/gxf5j/24sXxgGUunHcP9nZH8Pk3GBcGQUKM4311oLurywdBU75IQJ+1XXezKJbnThLnG+RNmqPJI+61Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745226649; c=relaxed/simple;
	bh=kHdJISTOknZRXyvwHcOZ1+E+dOr0gE3qeLIKQ5XfQTY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=C4ruh6x1wCP0MHXhkykBXACsoznEA0BfubW+ZOybqwj0mRRTYQDtX5VNapvpoCVD5h0Jlzz/y+mu8LgykwNIiHjLO04FZhodF6+VPC1gucCgOb5aafKoWbfDkuCYQeFnKOkEAuTRm2YzL4s16jgh/pKrdXFK5+vpnCoERBuHKzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=SxHP2NZ0; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1745226622; x=1745831422; i=markus.elfring@web.de;
	bh=kHdJISTOknZRXyvwHcOZ1+E+dOr0gE3qeLIKQ5XfQTY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SxHP2NZ0Qvrw2apTNNETWQi36hpPI6DwnjO0ssYZ751ASDkyDB5Y+NmQvkrX7VWY
	 Tol7jUQQMpOmEmdTe12bihpvvRab8B/UAnMEsRmlaqcVZPYdpP+ao6hGUFUd6+4A8
	 Uk7tz4zBCrBdGPbejSkQl+Fu/iNdhRyWevh4zIwAFK7/Z2GLCdmdUHwaJ/cgWSAob
	 PeQteIzeorDREQFmmnPI35CPJA7/YSw3/vDtMPDdVo4mA72qUIPvNVpbehBCFupZ8
	 I5aX3txjOKjIMriFBjLoOd4Z2meID5cSUKeLJxBQNgfV0VWnpdVuaqZDn4zMxVYDw
	 d0bBeejjfUSgJSB1pA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.16]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M3V26-1u6Ew80W26-00E3nF; Mon, 21
 Apr 2025 11:10:22 +0200
Message-ID: <ea9260c1-eca4-4b9a-88de-64c27f226a27@web.de>
Date: Mon, 21 Apr 2025 11:10:10 +0200
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
 Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
References: <20250418023814.71789-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH v7 0/2] net/mlx5: Fix NULL dereference and memory leak in
 ttc_table creation
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250418023814.71789-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aabuASyem9RhQYBPfwP7u98LFIGEfB2c/f5zmmKC6hcqQczLfa/
 FXmuFPSf8711+CGjp2vCqjmP+RwYvnQxLYFdskB0jqeX4QuyH5tOxnn2Yn7k9h0H6FZaWyO
 AZ68Sn6CLUVYs/O4bnIsKdQv9uGoCwN5t9sYIe088cfCMSMB41SqSCH7Sc+zMvMDBYDMEVa
 m7hX2M4F4wdEgUhzxM7Mg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZfssjIIz9/Q=;yPKt2LsJVTtDcR7iA1sAQoassrA
 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
 kMaI=

> This patch series addresses two issues in =E2=80=A6

Did you overlook the addition of patch version descriptions once more?
https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+pre=
viously+submitted+patch%22
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/process/submitting-patches.rst?h=3Dv6.15-rc3#n310

Regards,
Markus

