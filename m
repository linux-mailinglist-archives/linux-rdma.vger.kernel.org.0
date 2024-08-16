Return-Path: <linux-rdma+bounces-4395-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0834C954F92
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2024 19:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72FE2838BE
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Aug 2024 17:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EF81C0DEB;
	Fri, 16 Aug 2024 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="rqGD9KG+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7856F1BC9E6;
	Fri, 16 Aug 2024 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723828190; cv=none; b=Tj4UZt5SPSSjMUUPPh6p7g5YoC5kPuAc0p8Is0vHhFxRTFHKfGEGrn0bv5GnocTU7akaSwltn4yAatkA38UdSAO74xPqoXMuEXiOKfjyOsY8KJnBEh6LdrmsRYHd+N+M+hpJ+R4+cD57CgDrGUU8abOxe/cCG3Dq4h8GzBAYAKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723828190; c=relaxed/simple;
	bh=legrBcAUJ6IAEhouTaDw2RbtQ1kqKIxUfWoT3OthaB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBaIx3l2T7JomZ3N1+yISoUdxKdx0NkgQFO2TI1CLcIH/9i4uKAk6Xu9/AlWJbqEAi4M6PW+P2JAqTcDTVKbNmBkBGBnNluG8FkQLONaYOrIbfAZbzE2TjVERUcwWQvzydsRAVsBR40Hl1Mfs6XPGGHjxU5tuc3fzbmnAHMM/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=rqGD9KG+; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4WlpQ507h5zlgMVQ;
	Fri, 16 Aug 2024 17:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1723828186; x=1726420187; bh=0XzJixgFItCLT8ZDX1bXcvhA
	HiYynCV72Ws2/7eb/tg=; b=rqGD9KG+0m9zcBA5oIhV/ovdQ9Gg09wd6Gab6pYu
	G/56XA1pedliWtPfIojN9fmwUFhh2lbDovA/WA8YH+e1O1+FsXinFIK2L5hDJ+Oo
	wHKv6kprzs2vfcfBmav7U1pfB7KEccmDyI6+JFZyn7UboyrpnbjpOqRuF1h5JqqT
	h3E5AheDNl/R/SNpRPoqtJNgq4ShiwRf5qvmyKfXuaJxlO57K39uGK2PZwA6/LF4
	mJ4P6ieJI0BFqziX9A7Ef2eEXmyG/07Z1nmCM9Z7Mo8atMUbJ2HsYKyLmpNQKFzZ
	C91FkKQCR8ikFPiy4Lbgf55djH8TuDkcNLyyPljfUQazhw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id ExOtsoSp0icf; Fri, 16 Aug 2024 17:09:46 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4WlpQ16RhMzlgT1H;
	Fri, 16 Aug 2024 17:09:45 +0000 (UTC)
Message-ID: <d698161b-f9f4-490b-98a5-b51d739d4136@acm.org>
Date: Fri, 16 Aug 2024 10:09:44 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [linus:master] [RDMA/iwcm] aee2424246:
 WARNING:at_kernel/workqueue.c:#check_flush_dependency
To: Zhu Yanjun <yanjun.zhu@linux.dev>,
 kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 Leon Romanovsky <leon@kernel.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-rdma@vger.kernel.org
References: <202408151633.fc01893c-oliver.sang@intel.com>
 <c64a2f6e-ea18-4e8d-b808-0f1732c6d004@linux.dev>
 <4254277c-2037-44bc-9756-c32b41c01bdf@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <4254277c-2037-44bc-9756-c32b41c01bdf@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 8/15/24 10:27 PM, Zhu Yanjun wrote:
> diff --git a/drivers/infiniband/core/iwcm.c=20
> b/drivers/infiniband/core/iwcm.c
> index 1a6339f3a63f..7e3a55349e10 100644
> --- a/drivers/infiniband/core/iwcm.c
> +++ b/drivers/infiniband/core/iwcm.c
> @@ -1182,7 +1182,7 @@ static int __init iw_cm_init(void)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return ret;
>=20
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iwcm_wq =3D alloc_ordered_workque=
ue("iw_cm_wq", 0);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 iwcm_wq =3D alloc_ordered_workque=
ue("iw_cm_wq", WQ_MEM_RECLAIM);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!iwcm_wq)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 goto err_alloc;

This change looks good go me. Do you plan to post this as a proper patch?

Thanks,

Bart.


