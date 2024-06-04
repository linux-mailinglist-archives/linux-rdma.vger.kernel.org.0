Return-Path: <linux-rdma+bounces-2862-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DFD8FBD40
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 22:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2D38B249BF
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 20:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D01614B945;
	Tue,  4 Jun 2024 20:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="YVS+hVa/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7431384B3
	for <linux-rdma@vger.kernel.org>; Tue,  4 Jun 2024 20:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717532770; cv=none; b=D3oCEBFWTvo7tjovg0Nplpe4n6MbqB7Hf4IMGLY4aNOeCHVqlNkQQtVP/nqNemBdDND4R33Sq6F1HRdFRjS//1tTQ9kxxQz8Kba/AOEHOr7cge8xbX6ylarB4M2O0hct0C3bGOtD5r8irRNnG3idXD8xXt18N3t8gj6/nwYY41o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717532770; c=relaxed/simple;
	bh=5PxDlbU0GhRmYI+4MYumcpB+xqHwOOKBHMFWxuMprgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LIoIBkSWu1BVZLBn1haO7TUakQPp407X0kaKLWTuqyLI41NAhHj0jdA7QzVG+Ao9/SRj5PmQccxt23rh4OYZ0/c4GraQgmXPrfhZ2ZZMYqz1i/77q3AQE2x4qgaAN2cVq+RjhdnYrCb1RKM8OpTnNJ4F4TwxHCb7ODN4U7O16Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=YVS+hVa/; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4Vv2DB0fsHz6CmM6M;
	Tue,  4 Jun 2024 20:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1717532759; x=1720124760; bh=kTkfzniMCoXVAFHqLMBTm8KN
	6oCn00mwPI+4QBGMB84=; b=YVS+hVa/2Oifl8kGI13B4eaCeuBwhLPmHGPvQzAV
	cxan6Bs3+kPu8vUc5uI0pXeawfIM9j6lWZ9WagNMjE+JPSq9FwmghWh5/bDjyHg9
	v1ynskiyKhDwFFtWUi0o3HT5UhVTfM1BvSCrFEHiu8DTpct4GZ/hLfOE6GqM3BtQ
	J9237StwnHvbV5HL1h41UWGc47ejVqFCM4SF8X+5/LofsMh9Jsr9f40Bxj9X9MHv
	kPmdu8YSKqEh103/4enjF3zLyPQPZzVVq6IgRmn2rGr6UdwhJz8FIkDKtqjA/ULM
	9CcQg8MMZU5JG3aMMXeFZ8uhnvyb9MreJ1ZgBqKUSPav7A==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id RCgRfCtnP_N8; Tue,  4 Jun 2024 20:25:59 +0000 (UTC)
Received: from [192.168.132.235] (unknown [65.117.37.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4Vv2D71zkRz6CmM6L;
	Tue,  4 Jun 2024 20:25:58 +0000 (UTC)
Message-ID: <1c62e2b1-14ea-4927-93c9-c9acd0965774@acm.org>
Date: Tue, 4 Jun 2024 14:25:58 -0600
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] KASAN slab-use-after-free at blktests srp/002 with
 siw driver
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Leon Romanovsky <leon@kernel.org>
References: <5prftateosuvgmosryes4lakptbxccwtx7yajoicjhudt7gyvp@w3f6nqdvurir>
 <6bcbe337-c2fe-46ee-8228-a3cff6852c28@linux.dev>
 <a21021bf-6866-466b-a924-2f465fbb2e64@acm.org>
 <20240604202217.GB791043@ziepe.ca>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240604202217.GB791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/4/24 14:22, Jason Gunthorpe wrote:
>>  From 879ca4e5f9ab8c4ce522b4edc144a3938a2f4afb Mon Sep 17 00:00:00 2001
>> From: Bart Van Assche <bvanassche@acm.org>
>> Date: Tue, 4 Jun 2024 12:49:44 -0700
>> Subject: [PATCH] RDMA/iwcm: Fix a use-after-free related to destroying CM IDs
>>
>> iw_conn_req_handler() associates a new struct rdma_id_private (conn_id) with
>> an existing struct iw_cm_id (cm_id) as follows:
>>
>>          conn_id->cm_id.iw = cm_id;
>>          cm_id->context = conn_id;
>>          cm_id->cm_handler = cma_iw_handler;
>>
>> rdma_destroy_id() frees both the cm_id and the struct rdma_id_private. Make
>> sure that cm_work_handler() does not trigger a use-after-free by delaing
>> freeing of the struct rdma_id_private until all pending work has finished.
> 
> I didn't try to look in detail but this certainly makes more sense to
> me as a possible solution to a UAF
> 
> Presumably destroy_cm_id() does something to prevent new work from
> being scheduled?
Yes, it removes the iWARP CM ID from all the data structures that are consulted
when an incoming CM packet arrives.

Thanks,

Bart.

