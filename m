Return-Path: <linux-rdma+bounces-6762-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9075A9FE30F
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2024 07:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50C7E161E1C
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2024 06:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CBA19DF40;
	Mon, 30 Dec 2024 06:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aWNYqrYu"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A428D335BA
	for <linux-rdma@vger.kernel.org>; Mon, 30 Dec 2024 06:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735541562; cv=none; b=HWxu6kJx5SjoR3J4mB51XRTZGi23gwipf0/Fxdzf4+TrQAbJQs2PnAPZsZxdXGzVu9jPTEWpIjSe/e0ugQEAU1sE+cyGYQrQtMsgbW9sIzo6WY9gnYVNI+kW7CtvjqYmr8p7DVdBLxsTYISMQmcqtpz70+9wSnmw5PTe2GH1+2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735541562; c=relaxed/simple;
	bh=F9z6kuJPP6u8VVSZDWz0bqIPmSUV66jJqemR5/XkBBc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=buFp0ePtZ69FwJ1PGDWte1v8ncNus+DnwRltd3PhYS71doXrzDI0Dd2/9L8EdG6osklOpkOYyx/OdF/Vwmn6yHxjpcdZZDiVqAOmUdVSGNowvTRzO0pu+MjFyaWGGoj2AE4jPJvtiPaT90izBnbVmjRO8KL70UyFFbTZyU355q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aWNYqrYu; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ea1177d0-d556-424d-b3dd-596621d165db@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1735541557;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BANh7+UnpnZkPoHk1ytwydAWAmW6OKhUbXylGlPgkz0=;
	b=aWNYqrYuxF8VwktE7Kbl6kXaK3NQdbjV3h42ReimnXPA7p+m/PzCej/hlG1Khc8BMk4Yha
	leSMsIcdf47WlHJ9IwKLSIWN9BQeQyE7XcyGmc7HrongbeuXXH0rH7ZRUZpjTQ9MZ8/U5E
	UamvlrWdOhnKIVU5lDHVapr82IvRrRw=
Date: Mon, 30 Dec 2024 08:52:30 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next] RDMA/efa: Reset device on probe failure
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gal Pressman <gal.pressman@linux.dev>
To: Michael Margolin <mrgolin@amazon.com>, jgg@nvidia.com, leon@kernel.org,
 linux-rdma@vger.kernel.org
Cc: sleybo@amazon.com, matua@amazon.com, Firas Jahjah <firasj@amazon.com>,
 Yonatan Nachum <ynachum@amazon.com>
References: <20241225131548.15155-1-mrgolin@amazon.com>
 <5de4f98d-6253-426e-95f5-808a4fb595fc@linux.dev>
Content-Language: en-US
In-Reply-To: <5de4f98d-6253-426e-95f5-808a4fb595fc@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 30/12/2024 8:46, Gal Pressman wrote:
> On 25/12/2024 15:15, Michael Margolin wrote:
>> Make sure the device is being reset on driver exit whatever the reason
>> is, to keep the device aligned and allow it to close shared resources
>> (e.g. admin queue).
>>
>> Reviewed-by: Firas Jahjah <firasj@amazon.com>
>> Reviewed-by: Yonatan Nachum <ynachum@amazon.com>
>> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
>> ---
>> @@ -685,7 +685,7 @@ static void efa_remove(struct pci_dev *pdev)
>>  	struct efa_dev *dev = pci_get_drvdata(pdev);
>>  
>>  	efa_ib_device_remove(dev);
> 
> This already calls efa_com_dev_reset(), you now perform double reset in
> the normal remove flow.

Sorry, I obviously missed the part that removed it from
efa_ib_device_remove().

Reviewed-by: Gal Pressman <gal.pressman@linux.dev>

> 
>> -	efa_remove_device(pdev);
>> +	efa_remove_device(pdev, false);
>>  }


