Return-Path: <linux-rdma+bounces-2892-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 750E28FCF65
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 15:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ECD41F23EA9
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2024 13:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B1D919754D;
	Wed,  5 Jun 2024 13:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="1zNAMiSu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D73197544
	for <linux-rdma@vger.kernel.org>; Wed,  5 Jun 2024 13:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717592837; cv=none; b=AJpAaTV4iG7WrjY9Meb7yfpXhSRHkd7Gvss5CPqfzeVatDjmr+tzrv1HPOur/EQkDTQJxZUufDOEHv+CR5/VInFvw+vL+HdER5tlo5iiKP3dDwRN5dXgTg8AnCdIGiuyzB4W5k6aCRoznCMM63M2q6OBpFOPpNZb2eT2LY0Bqqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717592837; c=relaxed/simple;
	bh=sjEhcBuaVXCuReqf+PmkUJSdnGUyLZGg+N1om5jK6Dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mzGkKMMO0oHpH3jLSoL3PfCClAPr3gZN3I/D41cJvz2EkDE8F+dJ/tH9cantiyLYawZuY82h1BFexfa8Tpiz6AtSoS8v7egQOlQphXoPlelc2qeuTqCKMq5b2O2rgriEj8GRTUcPStG4SZgCKQ5Q07AyucfoPxkuVmSIIJH0bqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=1zNAMiSu; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4VvSRQ6ND3z6CmSMs;
	Wed,  5 Jun 2024 13:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717592832; x=1720184833; bh=QsizQ8qJ9ZDAmp1WH0tjRGgU
	RJoHNngClaFfYKS7ewQ=; b=1zNAMiSuNuuuVHs25v+u7u8UBTGgyyvBrkOx6U2A
	M3hzl4l9iXOFu3BqzfNJ9r8TRvAaSgoyrhwJp89YA/KxPcR5EzLXcHdsAQ84w55J
	f3fLmJFqdyj2+77LX3ANVdreOv2R1xkamtne1RjUDv36ocTXLzz1pQMDJNzGsRD4
	ak2wcpx+LStAWuLhe02m1ZIqml4r8pADrB7zolaPT4oh0JUv+kEbkaKzIW7wQVqC
	EFUsfkHCvXK5c0QmKYjWMITHBV63fXdHGmz6Xh9vGaN0S4sscv+7UdZy3IIPMfTP
	qV0lZOY8VpZS5S4tF23aEmZj5PsOjeqC2XbCgYTWUr2lVQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id MYI-bzHK_RUJ; Wed,  5 Jun 2024 13:07:12 +0000 (UTC)
Received: from [192.168.132.235] (unknown [65.117.37.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4VvSRM3hwBz6Cnv3g;
	Wed,  5 Jun 2024 13:07:11 +0000 (UTC)
Message-ID: <84acd2b7-553f-4385-8c10-ce70ae70fe39@acm.org>
Date: Wed, 5 Jun 2024 07:07:08 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] KASAN slab-use-after-free at blktests srp/002 with
 siw driver
To: Zhu Yanjun <zyjzyj2000@gmail.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
References: <5prftateosuvgmosryes4lakptbxccwtx7yajoicjhudt7gyvp@w3f6nqdvurir>
 <6bcbe337-c2fe-46ee-8228-a3cff6852c28@linux.dev>
 <a21021bf-6866-466b-a924-2f465fbb2e64@acm.org>
 <2a8ba947-ccb4-4c33-bc60-7833291eb61f@linux.dev>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <2a8ba947-ccb4-4c33-bc60-7833291eb61f@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/5/24 04:42, Zhu Yanjun wrote:
> The type of iwcm_deref_id is int.
> 
> Not sure if we should make iwcm_deref_id and destroy_cm_id have the different type or not. We can make them use one of the 2 types: int and bool.

Since iwcm_deref_id() either returns 0 or 1, I will change its return type into bool.

> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Thanks!

Bart.


