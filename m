Return-Path: <linux-rdma+bounces-9268-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE03A812BD
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 18:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D00F53BB58C
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 16:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D66222F150;
	Tue,  8 Apr 2025 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="C62sdNgp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3EE1D5CF8;
	Tue,  8 Apr 2025 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744130543; cv=none; b=WjvYcd9U89clLFCo4V27XRqzr3yIU0drz+Dls97VL8X1pAI4WORki9WHv2gq+l8okKRTxG/VASSiky+N2a5hSVPoDDYVT3U8TTXimoXQYzzgz0JViyKh20/omnN/quajIl51N/Ata6ymfmo89Qelc/9L2UdwrbG/xSuoc4RiSm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744130543; c=relaxed/simple;
	bh=2tR4R6Zog3ptDDAwvSz1GwvisaVzeCyLWD0mkXpJMD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0RrcsS5iqDD9QFj9vK6Bnk8lN77poZHCSS8LA8oHMNvCIwJ94KV0pvebrVo/MzdDq2YiNMmCD5IJ9mcNP6xhxxDkmvas/snYywqGgfah9W4QmRAgZlXhO4dh2LK7n+duL4/naQD8ewmifqT8EFLoThikM6z+PZyXLLqsm24mDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=C62sdNgp; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1744130537; x=1744735337; i=markus.elfring@web.de;
	bh=JOSYESwDdJ/gNXLbHjaAyLm28+OAS1NkTeljyl6KNLQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=C62sdNgpJJ2N7t4J/UlvgAGUNE9pewnWurfTJcqJiSXQCilnMYzTI3RCaZFkCNgX
	 d6WtEAADTuIDZV4TDdg2G9z5lwooF+Nw709Z+eCqAimSiy79uzitYQK0UWfeEj6I1
	 we4l8e5Rb1rEU/6V34ua+iBK4Dv72eFUgt/Qd/8mKFOgsQCRbkL/z3jAA8VfIbB9A
	 a11xklZjBGK9p4BRrlOWKRIjXEz66lhq06vcacC84Qy/adRJs+L4rpunXweTJSi19
	 TBKUq9+UJf5qtF57XCmYuV+UILC2kqIq0HrLoAUo+gPFTM2X+/OgrjQ/ybXHli0k/
	 R2z3aZcUrIytUXHhgw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.41]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N943B-1sxSkY0He3-00x6O0; Tue, 08
 Apr 2025 18:42:17 +0200
Message-ID: <38e5d527-ec32-4d0b-b416-3527ce326776@web.de>
Date: Tue, 8 Apr 2025 18:42:14 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: net/mlx5: Fix null-ptr-deref in mlx5_create_inner_ttc_table()
To: Henry Martin <bsdhenrymartin@gmail.com>, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Amir Tzin <amirtz@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Aya Levin <ayal@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Simon Horman <horms@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>
References: <81d6c67d-4324-41ad-8d8d-dee239e1b24c@redhat.com>
 <5ddf49e1-eea3-4a20-b6f2-fc365b821dea@web.de>
 <7aa5ceb8-6cf7-4f60-90bf-5a8ace49ecc6@nvidia.com>
 <CAEnQdOpKmQSH+CZFgqpfXBDpcntgjusw3-GEGrnLmgmUG9Fhmw@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAEnQdOpKmQSH+CZFgqpfXBDpcntgjusw3-GEGrnLmgmUG9Fhmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:HSSncBcMLsoAWsaQql2DGI1LnqteuvJmxxPwuApl20a5CeTAUC7
 J1UAfQ3z1YnOFgXh0XOeldlEsXWTQGwO86B5tvI51gditiXBZiBifEVzNX8SCwzI8hWTxvH
 8eTS1H4iLV/kMPk883xXsCnDt+an6UuL/nRLovUNGG1Nkv6SAypNwB+IqL8KEfl04Lw7g6K
 Zt2cs330HM0+nisZVxwjQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V86D8DBElcE=;P2OylUa9qwgS5VOrbYWAkXv+8GQ
 SsUpwV5kHqlZ8gZ8UTqnGRKRPCpqVvS9RC9y0fJT4pmTBS5OHErbqZydPzebM7Fo5nEmhAJQw
 yCS4WAZG+INui6Ouw1qLIIZ2o86GchmMzMrX3AKplNKU70c59sY8GXck+arv0JiawErRhGxr2
 aR+ImLOSgGA8hTKY0JaPHB2jWWhVJeXC0taDtxIneBYs/aGwXVcFo+HK8VIpimiabDguviMB8
 u5G+XYmh1M5uNjINMy6nZFQRsQTntbLiESYdzW9jyCR66hGd4Ondel91tdlQLK2VjrpuGNA6T
 MUMudedUSt8T4o6U2EyeynXAH6v8Xlpf5AC8JLVdT/rQzywaonzfmvmskIAiHo2RULdSZ3d9b
 duXcNO8Sp8J1Q4RpVt3GCNiPtG7pfRqBN8qqSnFDs/wtTF0x56aSxn0OBOI+WcChRjuDR+Tux
 gu/rMWMxQPoWk7CJPqKSkr2/fnQjYuu6bmCuJE9hGnW55N1T2nhAFOk49z1FXWqZDPpT6v4hV
 5Gtfd9/Vhw2fN9Ofrrro4tB8gl2i77HozFw2rURpiVhm1xRGQZZSHI9SaC9ts2LgSeq9TVXQC
 lvSFyKqpAsmFRx1e5iKjpqIth5nJzBGYlzatZUoL97xGERjVfx4RC1FU+WFf1ayHbvIFSIUpi
 ZcYCimkPio5/qgi+OlFlGGAgm2okPlYjWVTBenDAa3hlZd3MhIg6xKcFzDjwrEkDyvtXhOG4L
 dBjRZDgvyFE2UKVbHZTxChvHuwKZxTtg/rWxgAJwvvq3ZUPYtuflpceRHCgWn2FxyfdC88KvI
 sZyxBeZUpSX8+gmhWNR/tIaqVgjeDXUagDza0GLKejXF5mTnwYAJ0tKhuSdcaUEZ+E9yF/uk6
 oikOlMfBHiICLJjvIvVaDCY4UHRMZr5vxii2OWrw/wM7juFn1gupbmNFoHVmzHgGzNbejBx3H
 ip96GIK4Qjozo6agfpT7S1ge2XmEQp7vk7eBWYzdR2Qimdt7JTR1+6QCUToW1gm77XOrlXYaM
 K3xYw+PRBEr/GYm0UgoCPMw5VrPRfDAY7CsqzN+Ivx1+6WunRTFPPTfjx40M+61e8hUKcRMs4
 14VGKbmTs1gvaCKp7PfRikA/dF5kDnEwPh9UVJEK9BGT22/kZU9zAghXStgs82RJfeHH/62vl
 UZH26Z18m7L7zfUrm8PF1c085TGLaNQFrBdKMq1LOCetbLTiBLicBNP82DYNvX9U0hN1tqJMw
 4JENm9RUGT7xcJWyctJlVsc7RA6EaBEtnZqCrljipuEafkAU2SGPYKUFSpW8ZneCBgdPaexGY
 OK9xwyXBpkjNctzQ17ubfCe7bLcT4IwZ/61PwQL4CncWcIU37g+dG+Z2se9fUREvYoVIJ50RW
 tSDDudY+X/j/bNyHFy7sK5RaZH6V6DM2UvhQ2VfHMOZR+Xlq7fn8o0qUkHfp5z00978S00SYG
 LVSCvh9BYB9JoN9UNSPgm0PgXGJN1RI7eXNBJQ0KitkZpumxh

> Thank you for the review. This check will be kept, and I'll follow Paolo's
> suggestion about adding a blank line before the return statements in the v2.

                                       after?

Regards,
Markus

