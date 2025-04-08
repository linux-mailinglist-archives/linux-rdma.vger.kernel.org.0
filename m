Return-Path: <linux-rdma+bounces-9273-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5BEA815F5
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 21:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A631BA4335
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 19:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8792459CE;
	Tue,  8 Apr 2025 19:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sy9Hjebu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2866245017;
	Tue,  8 Apr 2025 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744141243; cv=none; b=OpVUi5A2s8qYQVeL23JzM0l5M0kukSdn+3YzXhRPedfNAdQ/q/ZanlG8nLpLH9zK65ftWJH7mSelkQWki3m+8v0JxWyTfi3eXqQdUYhr4CorWwRLIwRexzjP7y/UJ2n8XzJTsZpYUJtzKtT1E5tQG9gCwMu0OBx9fdcWMdBF9qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744141243; c=relaxed/simple;
	bh=bGZk48l7Fum8Jf5aCucmbCvAzx9GCibM0c2fKAF+XQ4=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=FerF8jlgiUlusnQKBozAW2/yaacL2iRXJrqSEtY2DEgfxVzhLbKwBeBzpd4BxfxPtLe32T3SLfdkGDEJmkbkK244YLuK2wbkJxoXwcl/0JyOi0EaNEGfhGwUlUrc234SJPEyOUGBL4DQT9g/CfhBCY6wkib2S9H9a4UmbJvAsek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sy9Hjebu; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744141224; x=1744746024; i=markus.elfring@web.de;
	bh=fzurtuNXWGHUwPRwx8cIR9L0eo858r1VtrVlYB34TH4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=sy9HjebuvTvHQAUTrklAGIIMarPy0Rn+3jYwBWD5zoxCYmEmoQIi7ht4j07+8JXO
	 BZgHQsMjKYoBSVb8Ew+qkquVbtn9Nm0DHOQJFMGTWJ5vKbA0baeY9a+X77dP2deAS
	 3Ndiv4F2GmywYwcMFTKiLPONZXdJUB5YKRPEHC6NHocL1EQrCO3/U32WCFzAwKnda
	 fr/1W7Uv816kKxOl7SkVwKhUr/tYKFKgNgx3R0tnpLNxZnuosqx5VRGe3474hyAAF
	 vVhxey/Cdf3N6Ot+9gYRoUhTHPpJRVojDSUYtppKqnNBZfhSiNTqaNw87+hGyQWJe
	 m45P3w5+YbHXaHwohw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.41]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MhFlo-1tPJ9p3kaw-00nMpX; Tue, 08
 Apr 2025 21:40:23 +0200
Message-ID: <c9a2b94a-9330-4329-b808-4e59065d7cfa@web.de>
Date: Tue, 8 Apr 2025 21:40:22 +0200
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
 Andrew Lunn <andrew+netdev@lunn.ch>, Aya Levin <ayal@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>
References: <20250408154058.106668-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH v2 1/2] net/mlx5: Fix null-ptr-deref in
 mlx5_create_inner_ttc_table()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250408154058.106668-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Rbzve1EASf9H+KgUZ1by8DnH80A2vn9325JgM4dUkO8qM+GD/4C
 j9XEujIe9vpX/0OY+p+avNS9ZqMNkW4DIKpeJGDUjcx0Pk5i2/EYoAEWk+BfjXwBo1hU3a0
 dVvl3MGwd0AcvVGTcHpWQtbejLMlk2hQxt+DeqWGZR9YIbFcmUk24kb39LcnyQTTNnvKNQ9
 m7DvTgb9WkPu0PMmL6VPA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:D9kHfzn3EYc=;CUY2qSZgf4PONHEQTKgzkRKugBR
 PjmGVGzOOZqLlZE/YCRAde0M4OfnecpFlPlEHBbcUn9OQNKSQxhTMCitgFTJQkcKY/Vy3faLF
 9cfAHHgZ//+dF9j+iPUkVatIoRl0G2F68wlTRzEt7yp6CNG0abx8loA/jyjf7ZfX5vJTK+TWC
 YKDhgqUc8DMFN9jw9/2mTBXexOFGaCs8zyaBDozALSNR8ItNqNFxuWUq/QIotH/6h6XzYfw4i
 K4pJlcnQdQ8PC5W3J1rzx5eT0cZvWQbksF9SpomfThfRu/hskY6R7GFZ/jlunX0VRozBkbhMe
 f/tkXSYLOt0WVfHqbQlfwe7fJLoW+5UNchmb6VaMlnJhx4AnUf4wDyYFDcy533y72zzyVKKiX
 XuF4B4LZmBrQPu/Z0BhAOz4x55CqsOPiAS8JwyI1NkapM9FS0q2rJ/qdC2VvV/Rw1jcxjXPbv
 90zm9quHJ6bhzdfY1S2TbbThQW1++2VxS438UKpK9u2ee/Jvu8fA6TPbAAx+ona80nn4vHvfw
 KfA6lVXrxILw05hVyVZBFxf98CqCxxZOSdrd2e0/smnaQRqOs6NhdQLelrhAZ60+3Zo3oU09f
 wPWxuXhTBc5pDCOXduuxVkB5R1zy53F8VjtmhDaGXo3yAsBcqcfpNv2PUmOZbBWuVSIfrbqcS
 m/jbqYAcG8488Rz2CFSfyf/SiNCizL9Y4uJZ0K8IK9DLAFUMQ1SdyRIGWhBkrpA3dtRhPRp58
 YII8uPLBEXqvrdFh6ZTWuHUMus89QFIadbp9OnkX6Ac8GELaVmvqtec8x6JccFSUpb65yez30
 jS91TdUqSvmeNvKj2gqWcVgMw+lOwSkashg/xR0FjD139Wm675DL6akOXTadUWOhsjFK/RuX2
 73kPTNAeysQqQZYXMvJ+ENpa1XU3WoH6uOD0iBjrAdMQFYAyZR4sXlEY68zSZC+CFYMCvyQg0
 Rxge/I1fiN3dYJOS62eLbGvb0hA466etsRXcq8LjqAXoa4Rxewis5DoPkkEW1FZrnssIFdKML
 FkQv/ha/WLMQENGaM7IsbsRCnJV+5qzDWPypYNOMR0upL0tAbejE7aKWUmSdSXiW6+HBVGVz+
 mxAgq60T6LXAWVVevYVtnBnyPvN74fi4sCp9u3uPAanHFVCu1dnDy8jPVWGpKpPp+8o1VgHSi
 7uGxNJvpNSSRXIi9jxMaP7NwLdw1U3+Yaf2yUFS0Y3psHLcWz6sWBBvU1Q3s5f+RkeevoDQ4H
 up1Yd+uj0R08Di6eu2ihrKktNd1k8OGHOX2t6GndRqeL1MN/u12uanelkHfX3INNbA57vKeMh
 KWVxECvmIjWu1g45wCac9WbFaPUFLTsva7+x3ojA89C7kX0/30PsrSbyAVcuieDAE6fxfLMT1
 y6xTgiq/VuWZ1KJRpERdN6cmimqon8E0eiKgc7GSFc9kKO2dSxUWxWyLyYsruW1WU0tnWj9yN
 TQ1KC8FnGJMT4bnXWAEcOZqoBaQ4hkDV8vhOXhnceIHWjA+eE

> Add NULL check for mlx5_get_flow_namespace() returns in
> mlx5_create_inner_ttc_table() to prevent NULL pointer dereference.

* Did you propose to adjust the error handling for three function
  implementations from a common subdirectory initially?

* Can any other summary phrase variants become more desirable accordingly?

* Would a cover letter usually be helpful for patch series?


Regards,
Markus

