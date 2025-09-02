Return-Path: <linux-rdma+bounces-13032-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D67A0B3F6A4
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 09:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB35A1A82673
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 07:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB2F2E7166;
	Tue,  2 Sep 2025 07:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XyALqZ9M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6CA27E07E;
	Tue,  2 Sep 2025 07:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756798004; cv=none; b=m1U4z1IzL3xYiVSAEvWP2edK6DL5AaI08Adt0/Ejk9BpYhMD4M4D9fS6tY2LPWTSIAFRArgfreYZ4Zkd0AinHsY4dRuQIVtc1XFzQbljC53XZYk2YtIzD/4wphzD/q/9cg9QV8VnG2I6DEkwxVmEYfiGsff1nPeEd7Dm/JFIaLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756798004; c=relaxed/simple;
	bh=7jHm6j33a2ViG9Q+G5wx5wkVkZAAuyV8jZR74yhX5ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cp5zQluYjvUHEn6P0VZM5Ap5adNLS/4IWvubIxvFPydFVaGSdb6gYs5dbtPQLbK5/UP5bwUr43hLCly66zyMXrI6FluhEJcuE/0KubmfcUt7UB4UKdDEYy0aiYbL5koz1n/ZciYWeeQQXe8XHorKPNLYwHHUZGemnQK8KARuaYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XyALqZ9M; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756797993; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=vKvlNitfpyMxHm4rPf6dKP8hVqbhYaMwj3B9Uj/9Xmc=;
	b=XyALqZ9MqipZKfhOZUN7oP/SkuszHGensU/rutKSnkMcLjN+CjNx/9fLzGeB58+vftxRv222SpJhq3NTBy0Dt3lo0rD76NIcMlOy/dmzXOIjnrcK2vwlZAicwUDk2Xq56ntlrOav5fDDHQnmc3LARpft2oYnPwrBVrERTNnuN1M=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0Wn6wIYS_1756797992 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Sep 2025 15:26:32 +0800
Date: Tue, 2 Sep 2025 15:26:32 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Mahanta Jambigi <mjambigi@linux.ibm.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alibuda@linux.alibaba.com, sidraya@linux.ibm.com,
	wenjia@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH net] net/smc: Remove validation of reserved bits in CLC
 Decline message
Message-ID: <aLacKAOIo63U9sLl@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250829102626.3271637-1-mjambigi@linux.ibm.com>
 <aLHAAy-S_1_Ud7l-@linux.alibaba.com>
 <57c2976e-8b6c-4cee-803f-ca5b0636f30b@linux.ibm.com>
 <aLZtraICmwOQAtsO@linux.alibaba.com>
 <8a795b8c-5613-4952-a5fc-59cead205e59@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a795b8c-5613-4952-a5fc-59cead205e59@linux.ibm.com>

On 2025-09-02 11:35:34, Mahanta Jambigi wrote:
>
>On 02/09/25 9:38 am, Dust Li wrote:
>>>>
>>>> Did I miss something ?
>>>
>>> If you refer to struct *smc_clc_msg_hdr* in smc_clc.h file, typev1 member
>>> represents bits 4 & 5 at offset 7. If we compare it with the CLC Decline
>>> message header, it represents one of the reserved(5-7 bits) at offset 7. You
>>> can refer to below link for reserved bits.
>>>
>>> https://datatracker.ietf.org/doc/html/rfc7609#page-105
>> 
>> Oh, I see, thanks! The patch looks good to me.
>> 
>> 
>> BTW, I checked the rfc7609 and SMCv2.1 spec:
>> https://www.ibm.com/support/pages/system/files/inline-files/IBM%20Shared%20Memory%20Communications%20Version%202.1_0.pdf
>> 
>> I think the name type1/type2 in smc_clc_msg_hdr is confusing, as it doesn't sync
>> with the spec for decline message.
>
>I agree with you. We can address them in future. Since they are part of
>reserved bits, we can ignore parsing them for now. May I add your R-b
>for this patch?

Yes. Once the issues in the commit log are addressed, you can add my
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Best regards,
Dust



