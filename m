Return-Path: <linux-rdma+bounces-2512-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878268C79E2
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 17:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CA31C21AA2
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 15:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A524C14D435;
	Thu, 16 May 2024 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AirfPLjG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C892A14A097
	for <linux-rdma@vger.kernel.org>; Thu, 16 May 2024 15:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874926; cv=none; b=Yjrm8v73uNiUo1TcyTJfWNpEVO/lvvq3HOv1JMkQ5u46YPxJfGoenIv782Dx5hMx1x4z8tizU8aNcO68xX36TrgT/7rO+1DIVLQpqbxToyROYiq4KwNgTJzaKY1TNZEleas1cF6TZejzosnuiHLubPchuVCnMbKovabQ/rO/ONE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874926; c=relaxed/simple;
	bh=bN5Kn28HLMjczbCri7afXpE+t9C1YWMZylPs016WX+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kRcBIaDzZdPWQ1LJF+tVkdo0JnncEln/LFDMLQLekMelybkWWf1heqkNnHbz0sIkVU+RN0yNoe4fuIMkh2q23BQq4zQP22iTllqATX/XTFKas6QsNkZqpcTxqL7mwrh39kLenKX/5//hFBYM/i773QgUc16tNZFcjVyyeKEPiWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AirfPLjG; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: kotaranov@microsoft.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715874921;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTiPhCOHBposHocOxYu8IZTjUm8AN6e7SOj6SnZjLiM=;
	b=AirfPLjGTikRvOcb3G/s/INzAdWq5f6Or/XJKG1FAHGv4nBYEVhVxSancvomMDEkml89lv
	vjj5OD1hE3C4BHCRPUVoQtL40FsbB+Zj3iVw3YIcHrJoKj4tHSaNd3lPmZ8szz2Q7vk4d9
	vHqZro/Uxz7YHomjcca6R3sLZGAaeiY=
X-Envelope-To: junhan@balaenaquant.com
X-Envelope-To: linux-rdma@vger.kernel.org
Message-ID: <cc984fea-8533-48b1-bf8e-1c9baff2ff43@linux.dev>
Date: Thu, 16 May 2024 17:55:19 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: ENODEV in rdma_create_ep with loopback as address
To: Konstantin Taranov <kotaranov@microsoft.com>,
 Jun Han Ng <junhan@balaenaquant.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <CAJTiWe+M-gwPb-GvCvcNrhtrqj96NA34YTRLAQsLS0ffucK+Cg@mail.gmail.com>
 <GV1PR83MB0700C80470457BD70210F8C6B4ED2@GV1PR83MB0700.EURPRD83.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <GV1PR83MB0700C80470457BD70210F8C6B4ED2@GV1PR83MB0700.EURPRD83.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/5/16 16:48, Konstantin Taranov 写道:
>> When attempting to call rdma_create_ep in active mode with the loopback
>> address obtained by rdma_getaddrinfo, -1 is returned with ENODEV errno().
> 
> What do you call a "loopback address"?
> 
> Note, you cannot use 127.0.0.1 as there is no RDMA device behind this IP.
> You can run "ibv_devinfo -v" and use any IP listed in the GID table for a loopback experiment.

Exactly, 127.0.0.1 and 0.0.0.0 are used as private ip addresses in rdma 
cma. As such, it had better not to use the 2 ip addresses.

Zhu Yanjun

> 
> - Konstantin


