Return-Path: <linux-rdma+bounces-9173-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F06D2A7D806
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 10:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C8116EC9B
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 08:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064DD227EBB;
	Mon,  7 Apr 2025 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qmXG5bxb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F73225388;
	Mon,  7 Apr 2025 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014867; cv=none; b=KkKZRbAY4hRa0dplPO1IFvnvy2aT8XmeJS5mc4xz76oEQmG2hhCgMqdFG/B+dKie1ITjGPuXisMQ+OoqKcygFheGv5bbGnUWm86Kej4cNjnilVuku5lzDbKzdbqZye+qrdRuAMTM42/d1DN4IpY+QKOQwH0Iv0G9LSG5o1pKurI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014867; c=relaxed/simple;
	bh=Vhw4ZA9Ps2+xZXL2K1IJGg3PZdoZzGEMNfgJtyFl5LU=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=MxAcq8xoOlsrUHxHrCEG0wGrKjJVuhC8FBw3rYAWjaynl/6QYgonnE1lhlFb1CXURyUtrzyJ2WUKyxIi2R3VlpuMvTIaoGvWRWYJwMO7yqt0KwtLw2eqFXJtoKwaiiUxDbO/cH5UJmXISZ1maJ6t9Un3Tr24LRKD8TFb31HDL40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=qmXG5bxb; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744014852; x=1744619652; i=markus.elfring@web.de;
	bh=Dg+LGVaxeCMjrxNASaMRgp1m7d5it9SLyoZVjKU62jc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=qmXG5bxbKO7ypkQJt1m69ZkaibGHfDtDrfBsZkbKAPVRch/M25tf+hcOY37/XaNe
	 wa+eNmegJZKqeZLKiPvnKHrYgqSdAtwN8VmXxhZN0N2BQovO9ZwY4pgI5W9cz0+US
	 2uH7V57MvngGrwpQnc3jMZ1nH3F+8p4cTHieJ4J94OAmQQfK+DhXmA7jS5RJlI+5F
	 gUq2KU4UV9iKr2YZrvkd3uXpfPRpu9pNr5b+MctVKVA4pVKbXIrKdMuy85ZUsbzPz
	 3xN1kfghklWH174ii4wMRaciboFrCornfBqJgkN7FLKk6GZ/8bTCtH7f+U8fpoiz8
	 Fi/tKheFUy4FxauFdA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.4]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MQ8ao-1tfnMp3iBE-00V9MC; Mon, 07
 Apr 2025 10:34:11 +0200
Message-ID: <0d6e4dcc-2646-4694-9961-70049a71e7c1@web.de>
Date: Mon, 7 Apr 2025 10:34:08 +0200
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
References: <20250405100017.77498-1-bsdhenrymartin@gmail.com>
Subject: Re: [PATCH] net/mlx5: Fix null-ptr-deref in
 mlx5_create_inner_ttc_table()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250405100017.77498-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:vgSH9jAK64S+GlMEqzoxCCM8UxsPHwh7N4T7u/tAoAQtYmLNIpy
 f2ifI6mm5og7E5nuypepEbcvk70nFvzNeyjFVpOftRzBdoTyobTtYPdjAKzZ1eotnTHh/K7
 xkQOBcLWVci1r/x+FtgJvGuM2nzCJsoe6Al+Ug8u8GYgN4hQc0hz8IhuJyqwNCokEM+uvZj
 8XAeDOEeZr9FLwhxY9deA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JwUTb7aw1zw=;ebFimREAd4AzF8Qlft3eYkX4n87
 S7IEpwvP0PkAm/7psp69QlWYonf1n5Bilzqxc7IP6TGSHeOZBJHJDnhrZhTbRISlvQIbyaYB7
 S8nqTEb6azesLdGbOY6jmfZeKCt69CYkTl+hGakREm3V33Kg5BcPF8MVwS7k60wngzIJhZOg9
 yO6jJe8/QN7IzVxVzLpD/vxX+4rhIcpriF2tIxHStVZe/Sc1w7vs5pxgzVJQgJrDjMKtWhbkY
 UHUS4zLDBb91dtVSv0zdC779kjwiHs8AIcZYG+DbxuKB6XYCGl88SfytL6hSo2Iv953mWrask
 5M7tz7no7JvAkOQD2JlGftiYVQpBUSYCHViNuVbJeY1yEDkmwmDj7fe7YYDNOkUiW4X1WBO9K
 S5+bHShmblrAxm74Op8g6He+8WtZYWQdm4khyfJ/hJ8vFkTuiAAKmCYGxqfxMJ8cqdF429BlX
 NR6n/bfCULwrj2Y4EgS1KgZ87hdkqwkI37gdtTOfsds4Pp6d0BtP69NPpcLCDd64yUtOedl31
 NkvvsDuBWWDfjXJTgISXao08G98IzwwvlyihA3eV/rLETCiaixjFwUVM9o5aEYEyM3neDgrBF
 DClNdoYkkh7kJ8AAqfGE7KxhO2ggIo7uaukB5e75bX7zmT+Ul4HsKdnQ89hNIGX7kXmuvZZTj
 EEoKp9rtjbcneyk1JdtJxc8qEqPUwvqUMXJTcxo6Z0Z6Q/y+OUCDdkxkLzF0oVjvCvFv4yQIf
 FIUlUniRMxT66h1wyeX3AGABU6JSVoVllX+V/V4j2wy3M9+E4ALhFM9ZdG6/9rp8uR3H7VP/d
 kwgFWi99iv0Sp/WH2wm/MYTAU4O7BRnNOYWdNug3GcGr0vYd1YQ6iko9e3HZAD7iKNrXl4FGY
 5MBaany6Wl8UdQ7lB22b22rd4xJCaoS6nlQ13AqLhbYuR1wXBrbVX7qnKHX4XSbgVoVADRhsL
 M3+8g/8KZE24CP/J1VamdpkzlRugpoJb3H8aX7yQMk0OsRcnjdl4Y17yqBkDYwav/DfW5kXgy
 fl3FJAHYzdvcCXXeA7Xmi7PJX+hgL5zp4B5RIQhch9PuYLWNfk26n1EvaSlPnciFJ1QXh2KaZ
 aBG9sO9QAFPIxpYBWgm1GLakGy0UAnPGiJ9qcQ6KlQb0iQfOhbR5AY4aqgUW4OT52SjGAZpKB
 pnZi1k4hnJIkP3ojy7Fqe97nPuCbcz9tAZHKtDlRfYVQx379F5pZwUhgWO5eXYMcpH8CitXzH
 7fhT9V5X1A8Q+Ry2O3PkwPsKxUTF131U24rpv27jonTfnX2ZapHteUMzo1wVSnQ4MMWo5qdkl
 V5pXH0n0zUbYfVD4y52JjVIO4qj+WzZGyfii4EC5vxmc5YFzYRcDSfaC5QZeqPH+otvpRqP5d
 w91xsC1tnpF16mmWJGGfhtfDneEMvWz81DT1JC/eemBLV9v5LN8kWJtp53l4oM0hJetbzIq/k
 ndz/PIiTe785u/qD1u9NvQxLS8TMRIOtmHcZKWPKN0qWNnng23g3RG3eVBIhGDO9D1YEAiQ==

> Add NULL check for mlx5_get_flow_namespace() returns in
> mlx5_create_inner_ttc_table() to prevent NULL pointer dereference.

* You would like to adjust the error handling in some function implementations
  from a common subdirectory.
  How do you think about to offer such changes in a corresponding patch series?

* Can any other summary phrase variant become more desirable accordingly?

* Would any blank lines become also desirable after added statements?


Regards,
Markus

