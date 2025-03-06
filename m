Return-Path: <linux-rdma+bounces-8426-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC8CA54A70
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 13:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2DE168DC0
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Mar 2025 12:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6022B20AF9C;
	Thu,  6 Mar 2025 12:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wc1iVtD1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090E020B205;
	Thu,  6 Mar 2025 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741263130; cv=none; b=H7i2T6fhF0RGggAY4U1ov2/NEpk+H8vhRev//a/vU5ZtnK8YCi/xrUhxKBg61XqS/CEITARQpLuIKoY2BoNSJrAw8n/GQGYgPkvgA18skXZNbqu/l3x9vROi8Kos78+s9kHawt1KlkbEbPtE0wujUTSJH/ra+WUSjR/hCVwsCCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741263130; c=relaxed/simple;
	bh=hasl9comeLm9EzxCXmoZgYUYl8ez8CcNANE4//+OiVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=giGnOj12QBwNjqLVMmDQw2awW5AEOW2aLxpyh/Zw6wWfIZUUDOYvtLJmxEkRszJ2foiWhL/kJ2V2JTCxWbiCH/bPsny9RUDwLCWDpMx9UXJcxjD8hz1LlaxK+n6JJrtTQdF1skq+3uqk5zeHbJqgvP2079xzx6+ET1/dOEEuf8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wc1iVtD1; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741263122; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Da5GvoMYHK+n2EpSfkWr3DP2DBfqQWCYmifpDQl2QNg=;
	b=wc1iVtD1Qo3ILIuytPcEdjn5eROLIApU5KkCSaqmAl6RWUEKqGb7hOczAM1uLM5+LTkiniU2drGLIAI1tAjxLSQSyqd8lnuHF8XvYis3oVfAvT4ABU3GN2STDoSI0M534aROmdYf9kaEsOT0e+9k4sNgKo3j/4xm52Om1IO6cRE=
Received: from 30.221.97.194(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WQomNor_1741262800 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Mar 2025 20:06:40 +0800
Message-ID: <edd17fe8-5a27-4ae3-cec6-b2ecd01b1b76@linux.alibaba.com>
Date: Thu, 6 Mar 2025 20:06:40 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] RDMA/erdma: Prevent use-after-free in
 erdma_accept_newconn()
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>, Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Kai Shen <kaishen@linux.alibaba.com>,
 Yang Li <yang.lee@linux.alibaba.com>, cocci@inria.fr,
 LKML <linux-kernel@vger.kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <f0f96f74-21d1-f5bf-1086-1c3ce0ea18f5@web.de>
 <167179d0-e1ea-39a8-4143-949ad57294c2@linux.alibaba.com>
 <20a1a47c-8906-44e8-92e6-9b3e698b1491@web.de>
 <20250306084754.GR1955273@unreal>
From: Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20250306084754.GR1955273@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/6/25 4:47 PM, Leon Romanovsky wrote:
> On Wed, Mar 05, 2025 at 03:20:41PM +0100, Markus Elfring wrote:
>> From: Markus Elfring <elfring@users.sourceforge.net>
>> Date: Wed, 5 Mar 2025 15:07:51 +0100
>>
>> The implementation of the function “erdma_accept_newconn” contained
>> still the statement “new_cep->sock = NULL” after
>> the function call “erdma_cep_put(new_cep)”.
>> Thus delete an inappropriate reset action.
>>
>> Reported-by: Cheng Xu <chengyou@linux.alibaba.com>
> 
> Cheng, please resubmit this patch, I'm experiencing the same issues as
> Christophe has here https://lore.kernel.org/all/20a1a47c-8906-44e8-92e6-9b3e698b1491@web.de
> and it looks like Markus continues do not listen to the feedback.
> 

Hi Leon,

Sure, I just resubmitted the patch, please review and apply.

Thanks,
Cheng Xu

> Thanks

