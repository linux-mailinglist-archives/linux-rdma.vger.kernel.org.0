Return-Path: <linux-rdma+bounces-13643-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88333B9EE43
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 13:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A766C19C7364
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 11:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BC32F7AA5;
	Thu, 25 Sep 2025 11:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="IPyRk8/J"
X-Original-To: linux-rdma@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B023120CCCA;
	Thu, 25 Sep 2025 11:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758799299; cv=none; b=G1b+fOt9TODECh6xarAO6KmjPWLumdaDd3h/SPmvg7wI5L9pJQINGno6HuXNMio23QCG8rdgZqQ8gMEst+anlGK3As0qhS/bBYYKfy1WFTzSQdJsammDpZNyEls7ytOHeYGAe4EhrdXC1fI2CamkQYFCR4wSHyiSUY2uSz4cFdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758799299; c=relaxed/simple;
	bh=mTM2GrOWeD3F8GLCbqe4PJoUAnPGY934dGBynBWKNOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A24MTTKl0+BYulESGMTfgWKhw/j04tp8+TKYuyA+RxWdsc5k1AkX4teerWiMSn1qN9DcwDf7qmtL/C1F9E/yEJyc3swxgqdB9vW7Nq13CAhqpOAyo+aviuVKvTtqzyci5mWMP4993Osh0v9QvS16QdKst3nr4fySO5AZYdrPFU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=IPyRk8/J; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=iHPtz3ycelQ6n18OHQYvVxPNY66NuZcxk79Q3PUoVEg=; b=IPyRk8/Jf2cKSXtpKEMC6Shk+z
	iB20cNjrhOkx2jlDDItpvyGyoXjbcPdZUiFlMRmkfhTqgTuv4GvhErtG77pyV1tB76br4wo1vQUMZ
	hSVXLE2SlOW0qzCD3bGnIZnnFZjg0DKotZqKH7pZqqTYNjQsS084TeB4exAhxeOWZA3PbqJmPwEFl
	nCQzTj9OJDVDGXSNkmwIDKz1tXRQ1nURCi/A8g1t1jgjWoOfS41K0LCYpHVOt4PjscyAe3OzxtJve
	cKqmZsNxQx+NxkSMCocWIQtnEr59Q6N3imBDK7H6jpQi58MZr3iCL7duUOZxOn8EE5GxNt+6FfSOz
	dXrI4TjQmKrALCts7+0zSRgJYVH817YPrgqei0LEm9z8KEqt2tQrLpggfAwxEyXvGyJXLAg5CsUtS
	ek5k7FOdFCY5OGlQ+RpM+y4glKhsSjCoKoEhLbHPPa+p/XUqYCu0DpfFGN2C1osiCsQ+tOuANR+db
	lA+oUT4lMfxvR+AxB0FNXnMr;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1v1k2Q-005wG1-0I;
	Thu, 25 Sep 2025 11:21:26 +0000
Message-ID: <cf4e9b44-e373-4f1c-afcd-51f97da65145@samba.org>
Date: Thu, 25 Sep 2025 13:21:22 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Does ib_dereg_mr require an additional IB_WR_LOCAL_INV?
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
References: <656eacb1-a39f-4b59-99db-5522d102468a@samba.org>
 <20250924151002.GK2547959@ziepe.ca>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20250924151002.GK2547959@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 24.09.25 um 17:10 schrieb Jason Gunthorpe:
> On Tue, Sep 23, 2025 at 11:09:48PM +0200, Stefan Metzmacher wrote:
>> Hi,
>>
>> I'm trying to understand (and hopefully simplify) the code in fs/smb/client/smbdirect.c,
>> related to 'struct ib_mr' cleanup on disconnect.
>>
>> Assume we have the following sequence of calls:
>>
>> ...
>> ib_alloc_mr()
>> ib_dma_map_sg()
>> ib_map_mr_sg()
>> ib_post_send(IB_WR_REG_MR)
>>
>> On cleanup we currently us something like this:
>>
>> ib_drain_qp()
>> init_completion()
>> ib_post_send(IB_WR_LOCAL_INV)
>> wait_for_completion()...
>> ib_dereg_mr()
>> ib_drain_qp() // again
>> rdma_destroy_qp();
>> ib_destroy_cq(revc_cq)
>> ib_destroy_cq(send_cq)
>> ib_dealloc_pd()
>> rdma_destroy_id()
>>
>> Now I'm wondering if the following is really required:
>> init_completion()
>> ib_post_send(IB_WR_LOCAL_INV)
>> wait_for_completion()...
> 
> I would say IB_WR_LOCAL_INV is redundent with the ib_dereg_mr(). There
> is no need to invalidate something that will be de-registered in a few
> moments.

Thanks!


