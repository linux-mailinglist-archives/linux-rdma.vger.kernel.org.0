Return-Path: <linux-rdma+bounces-9496-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1A7A90BEA
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 21:06:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95118460705
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 19:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72065224250;
	Wed, 16 Apr 2025 19:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="PQMcoNLA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC07224228;
	Wed, 16 Apr 2025 19:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744830375; cv=none; b=a5FHXW0HVKcTp4q+Q4vgbzqIXzNYC5MkBs9MtbnfSl2hVwhzuuxEU5/7lSD/+SZ0Uq1ciJsehGmEyeUGwuH/owYVDFVEB1pH9CD9oJiuET9B9h7YUrLO+PQ24YXheCQM1dq5BtRUjEKKUsA4LKa29m9y/Y7SAnWZ4/PYlMrIa3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744830375; c=relaxed/simple;
	bh=kdyTtW+aDnediSAQNm+CqqexrHdwy9hwbT0UGQq/mBQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=VQe4Rt0tQD7c+lfc+75T8PkgI1xXH6GdRC2GUV2kubLPr+6Gk4SQyDQfdZX5zXk2FaWmqN10NaKtbCcPfjNlbwN63PJGtybtVwqV2G/jn+Qn9qFzReS0CTTjV7DdKemOjYOey5dWZUp9DGMFEolYEfeo2jBjw59aczteXNe5JRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=PQMcoNLA; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744830370; x=1745435170; i=markus.elfring@web.de;
	bh=kdyTtW+aDnediSAQNm+CqqexrHdwy9hwbT0UGQq/mBQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PQMcoNLAxdTVA00C4fwqCidKmIr8MugzOw0b5wTXVnug2NdhdMFKnTKz6PSXVB7r
	 WcjuY0rcWDt7jk2FbMQQUnUDXUo2/V6uBDCxmvL5FLIixJZ43dgqfA/bMAvsNDVNp
	 SXjWEUUkZd89IZoSTGcYicOkMpugSofc4pfv56FC2fShDshVAD391CImCC/c7WPFK
	 JQaT4kiTzrh5kKId1zKwvoVXx0817mdZUbwudnAa9tfAzOGhZjUnJXI+Rfrhe4MAt
	 8B4UpIRJoahw6Np+AI3G30QCWENSfEMe4tLs+EtFn/8RBxy4n6q/643qMglKDJsnt
	 /yc9W7r54vNI6bhORA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.13]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MXXRF-1tW4ST36ER-00SZPE; Wed, 16
 Apr 2025 21:00:10 +0200
Message-ID: <de1ffbc9-4d19-485c-80b5-17f0d95d5566@web.de>
Date: Wed, 16 Apr 2025 21:00:08 +0200
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
References: <20250416092243.65573-2-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH v6 1/2] net/mlx5: Fix null-ptr-deref in
 mlx5_create_{inner_,}ttc_table()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250416092243.65573-2-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:wPZRXwmcdlPUfxs+0KJv9X2KX89wwV56Cg2xrU/aVP92VnuT6De
 s4hszYE02qPt6J3YWrs4HZVJl7AB7D7EPgFOXx3XZRTHahhg1swrb+/X5GXX8kpeDz1J4Xn
 YWJ4SE3RoeLakcFCW2aeSBXbnl8qe1zzBQa5oyt78Kt3qRDJCJEO0n7n3bEJvdBpkyxtlVe
 /qOvLMDETRFrM+ExQLdGg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ent964mkJ6o=;AviZf0MUA+qYq4ZCu4xIOBQSGLx
 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

> Add NULL check for mlx5_get_flow_namespace() returns in
> mlx5_create_inner_ttc_table() and mlx5_create_ttc_table() to prevent
> NULL pointer dereference.

* Can an other summary phrase variant become more desirable accordingly?

* Please avoid duplicate source code.


Regards,
Markus

