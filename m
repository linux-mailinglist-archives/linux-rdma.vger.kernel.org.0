Return-Path: <linux-rdma+bounces-4310-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D44F494E0D9
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Aug 2024 12:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A812816C6
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Aug 2024 10:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB12238F83;
	Sun, 11 Aug 2024 10:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W5GJyHJq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E968B482DD
	for <linux-rdma@vger.kernel.org>; Sun, 11 Aug 2024 10:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723371899; cv=none; b=DiSABbpsSZYmzooNMkzm36iA12DJSWEdZ6Ey8KB11YvFtRkU8ShmRbIxJybuq2kXUsp68eI1ZxwFBfECE/sbY9GmBbWBvHpJsspLgIx0YK+OgOE1gUFjVma5uXlGEXssGm00CPFlwFbBd5Kx8OT5XEvTjxJJfigfNfW6WhOvCoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723371899; c=relaxed/simple;
	bh=ylSIxJZQmnA3l5sPWJq1gVuf83mOLw/7NuHyIi+LBYU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=hUMEVGMfl8eSSWX6qamDhsXoHLahvHW6aAqNtNu5s9PvXSICUDv0wC1vsS81HHUe8Xf8Y8B/S2WrXTnhgtbfAAJSD3ATLveigkZw5YRZ806agP6aqOFBzSwMc4ScUQzyuiNcigDutBe41HcfszQtX4rZReRO2ei7o99STEh9j1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W5GJyHJq; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <60557472-62b2-4323-b952-cf81e5560c16@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1723371895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hc+SO9yvYqxLbr+jOZbu3cqsJuIGSGpCQ0uk1+NIK7E=;
	b=W5GJyHJqlkt55kQW8Jx/oj1L/auz359xgrNJlaRbBQJQ9iJ6sNg/e4ahGX4lSWhYYevtPu
	ZPYqtVge+Qssrp2jK9syv8IbwvLihTd06d+ZpfEw55HIfSlt9BSyrd+UUytHvkNhgrd2rM
	CJZR1dbjK/+vNwh2mR19YWWtrRh4kDg=
Date: Sun, 11 Aug 2024 18:24:46 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next 4/4] RDMA/rxe: Set queue pair cur_qp_state when
 being queried
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: Leon Romanovsky <leon@kernel.org>
Cc: Liu Jian <liujian56@huawei.com>, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org, jgg@ziepe.ca,
 zyjzyj2000@gmail.com, wenjia@linux.ibm.com, jaka@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
References: <20240809083148.1989912-1-liujian56@huawei.com>
 <20240809083148.1989912-5-liujian56@huawei.com>
 <72029ea9-f550-470e-9e5d-42e95ca4592e@linux.dev>
 <20240811083133.GA5925@unreal>
 <bb0a5de8-f2d3-4276-ada4-f788f574b798@linux.dev>
In-Reply-To: <bb0a5de8-f2d3-4276-ada4-f788f574b798@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/8/11 18:22, Zhu Yanjun 写道:
>
>
> 在 2024/8/11 16:31, Leon Romanovsky 写道:
>> On Fri, Aug 09, 2024 at 07:06:34PM +0800, Zhu Yanjun wrote:
>>> 在 2024/8/9 16:31, Liu Jian 写道:
>>>> Same with commit e375b9c92985 ("RDMA/cxgb4: Set queue pair state when
>>>>    being queried"). The API for ib_query_qp requires the driver to set
>>>> cur_qp_state on return, add the missing set.
>>>>
>>> Add the following?
>>> Cc:stable@vger.kernel.org
>> There is no need to add stable tag for RXE driver. Distros are not
>> supporting this driver, which is used for development and not for
>> production.
>
> I do not mean that this driver is supported in Distros.
>
> I mean that QP cur_qp_state is not set when being queried in rxe. In 
> other rdma drivers, this is set.
>
> This should be a problem in RXE. So I suggest to add "CC: 
> stable@vger.kernel.org".
>
> As such, the stable branch will backport this commit to fix this 
> problem in RXE.
>

Sorry. My mistakes.

No need to add this "CC: stable@vger.kernel.org"

Zhu Yanjun


> Anyway, thanks a lot for your reporting and fixing this problem in RXE.
>
> Best Regards,
>
> Zhu Yanjun
>
>> Thanks
>>
>>>> Fixes: 8700e3e7c485 ("Soft RoCE driver")
>>>> Signed-off-by: Liu Jian<liujian56@huawei.com>
>>>> ---
>>>>    drivers/infiniband/sw/rxe/rxe_verbs.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
> -- 
> Best Regards,
> Yanjun.Zhu

-- 
Best Regards,
Yanjun.Zhu


