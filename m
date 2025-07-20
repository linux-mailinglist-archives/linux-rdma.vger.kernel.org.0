Return-Path: <linux-rdma+bounces-12328-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE08B0B5CA
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jul 2025 14:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E35DA7A71B0
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Jul 2025 12:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57EB20103A;
	Sun, 20 Jul 2025 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="cYGpw+Mj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D72419007D;
	Sun, 20 Jul 2025 12:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753013731; cv=none; b=QtOwmN83j4atq6NNpR3NoM9Q6ut87zGhbRz2UAa4BNG/+v58t/HhgyMcBm0wZ8lz6VMKbCdZasL1GNzFuLO+m23TcjghI2juhWSB0svuWcxwPb+/XFnZjW7BNtH3Ck+DqGNfO+ikOEUhITXRW6wBOM50iCtzIE/bFE3deWce3h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753013731; c=relaxed/simple;
	bh=x2iZBtIvWYNXyrQ9Bm7K4a65qF79I+OMoMaad/OwQzg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=XzHJ9RhWbJZ7X+qjPZRBs5BL1xu7vhaKnCDJlvt1BzjHH6ZzGvBHRncojX/UsPme7nVeKNw7uPl/PBl7qFyULR2F+dIqFZFRyJ9aNn/PG+2Z54gh7b2Mwp3IKl8yzXQpJ6fq/odShuHaJwmaCqXG5tV8OHT1W4GSkOUpoG002tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=cYGpw+Mj; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753013709; x=1753618509; i=markus.elfring@web.de;
	bh=4WVBF0l/axi+Lbmya1dhCg8yeNQ7jPqJOrdKJ4drUkA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=cYGpw+MjbuCrD5NWa368zJMixKGdtScRH3UM013YUN96wgaEc6yK/zjsb3DzhAwB
	 FuyBFLDwXdjMSKPRT6nIyvtmpVIPjgfDlHWi3yoMujMrSHfbteatw+aRjDCiNAAha
	 daaF+vz7rhq1HSfNz61xT2sp2rknzkLoznK7+eAqHr2NeBxfsj/Bi7T3UkazDLV1D
	 ybnmefqew8nwNlZ8lYLSBg7v4TIr8RVE/huDeGCrZty6tx94b7NY20YS3doQT7ojv
	 agIW8YsMIQTAkOFiOwVvAsGFAxB6sd8N8b9s0Y2TreAzRAO6NsBRHSRPy0ntb1FDL
	 bLSRU2S4vS3BVhgFHQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.216]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdfCH-1vCnd73bCT-00pQdE; Sun, 20
 Jul 2025 14:15:08 +0200
Message-ID: <73bede3e-c00e-4a55-9095-b9a3dc8765a6@web.de>
Date: Sun, 20 Jul 2025 14:15:05 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chiara Meiohas <cmeiohas@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Vlad Dumitrescu <vdumitrescu@nvidia.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Moshe Shemesh <moshe@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Saeed Mahameed <saeed@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>
References: <1752753970-261832-2-git-send-email-tariqt@nvidia.com>
Subject: Re: [PATCH net 1/2] net/mlx5: Fix memory leak in cmd_exec()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <1752753970-261832-2-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7m+Q03+HMt5kNyOVFrgXKK3x2oUrZQS/hcSzyIuTkYj+J22Y3dD
 r/cmpVM+NQENwoegO7aRDqRQoPzwckivAzPwYQsjT4DX2c2AKHQOBV2HUIKSwUJnbk+abWo
 UcV/lw47i6CyPOY5H6jzSquQH9mFUUrhmjc+TwSrXcJWKAa65P7U2h7r4NYoBUw9M+t1s3E
 e48m7+0d7Z028aoxcggzQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8F5/SDBC7Lw=;ztSNi9asc4sMpzE2IVThzK8Mu8n
 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
 Nem1IAgjyvucoiM28

=E2=80=A6
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> @@ -1947,8 +1947,8 @@ static int cmd_exec(struct mlx5_core_dev *dev, voi=
d *in, int in_size, void *out,
> =20
>  	err =3D mlx5_cmd_invoke(dev, inb, outb, out, out_size, callback, conte=
xt,
>  			      pages_queue, token, force_polling);
> -	if (callback)
> -		return err;
> +	if (callback && !err)

Can an other order become more appropriate for the items of this condition=
 check?


> +		return 0;
> =20
>  	if (err > 0) /* Failed in FW, command didn't execute */
>  		err =3D deliv_status_to_err(err);


Regards,
Markus

