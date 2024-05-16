Return-Path: <linux-rdma+bounces-2505-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B9D8C74D7
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 12:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F0A1C20BE5
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2024 10:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBE514533F;
	Thu, 16 May 2024 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zg+J7Va2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66789143866
	for <linux-rdma@vger.kernel.org>; Thu, 16 May 2024 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715856874; cv=none; b=XEYoW7U8FWmzMiUYKnlvpJvmMXeIHt86TYHvINLNcmxt1Le2oKRKNPxvYW2e0gax2ThS6NsHGHNQJfXYDwuchEZkYTs1MfezXQN+CNATmG4vko4gu6VE5P6YpIgnA6sxN9HGE7ayPYIAcTbHj4PqxLxWVcsl3Qz6cgqjgfJj/Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715856874; c=relaxed/simple;
	bh=KB7aQa0qPLpm/ipJghgAyXGc5vPajqhLx8AYm2h8xVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SbLBtlfec0yMqqoLxkH7zEcvdOzNdhpjsM94vOfSIEwTtfzJwJZ9h0hQGJHbCpsH1yy+Cc6zEO5vDbgk+Tn42Iklb9NfIR0i19cnU0HmjWKwccdIfKiOA3XtiJmtV46KMZVX3j/pDQwtkhsacpMBXQ/sTpMCT/fj4Fo4mTkVTPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zg+J7Va2; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: mrgolin@amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715856870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OhFx0oe4UpQvXuexQMyN+dtK1sbXdGKKqtWMOERWqJk=;
	b=Zg+J7Va2OfJJEJTc3W+swo53qgj+DvxH7mqDxzEiRJX2NcfyLtPxaN85q9QI1dQaOjELIc
	IayPe56FZRGvEenFN21YCEFBVcZpwA0WdiHxQy8OwcqhU0A9/o7z/Loy3Rf5BjUTV9uJxP
	5tcpyzmSxCzJRgHxN7XynEYfkyKYczA=
X-Envelope-To: jgg@nvidia.com
X-Envelope-To: leon@kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: sleybo@amazon.com
X-Envelope-To: matua@amazon.com
X-Envelope-To: firasj@amazon.com
X-Envelope-To: yehuday@amazon.com
Message-ID: <5f2f0165-c148-4bba-8af9-ded7665ba373@linux.dev>
Date: Thu, 16 May 2024 13:54:26 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next] RDMA/efa: Properly handle unexpected AQ
 completions
To: Michael Margolin <mrgolin@amazon.com>, jgg@nvidia.com, leon@kernel.org,
 linux-rdma@vger.kernel.org
Cc: sleybo@amazon.com, matua@amazon.com, Firas Jahjah <firasj@amazon.com>,
 Yehuda Yitschak <yehuday@amazon.com>
References: <20240513064630.6247-1-mrgolin@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gal Pressman <gal.pressman@linux.dev>
Content-Language: en-US
In-Reply-To: <20240513064630.6247-1-mrgolin@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/05/2024 9:46, Michael Margolin wrote:
> Do not try to handle admin command completion if it has an unexpected
> command id and print a relevant error message.
> 
> Reviewed-by: Firas Jahjah <firasj@amazon.com>
> Reviewed-by: Yehuda Yitschak <yehuday@amazon.com>
> Signed-off-by: Michael Margolin <mrgolin@amazon.com>
> ---
>  static void efa_com_handle_admin_completion(struct efa_com_admin_queue *aq)
>  {
>  	struct efa_admin_acq_entry *cqe;
>  	u16 queue_size_mask;
> -	u16 comp_num = 0;
> +	u16 comp_cmds = 0;
>  	u8 phase;
> +	int err;
>  	u16 ci;
>  
>  	queue_size_mask = aq->depth - 1;
> @@ -453,10 +456,12 @@ static void efa_com_handle_admin_completion(struct efa_com_admin_queue *aq)
>  		 * phase bit was validated
>  		 */
>  		dma_rmb();
> -		efa_com_handle_single_admin_completion(aq, cqe);
> +		err = efa_com_handle_single_admin_completion(aq, cqe);
> +		if (!err)
> +			comp_cmds++;

I would count the unexpected completions as well.
Regardless, I would definitely add a counter to track these (hopefully)
rare cases.

Whatever you decide:
Reviewed-by: Gal Pressman <gal.pressman@linux.dev>

