Return-Path: <linux-rdma+bounces-2293-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4178BCCBA
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 13:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277461C21A4F
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 11:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F553142E82;
	Mon,  6 May 2024 11:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gn1grDxa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2DC14262C
	for <linux-rdma@vger.kernel.org>; Mon,  6 May 2024 11:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714994403; cv=none; b=jsdt2E7sM72fqAIVyU5b4JZv+bHabqmehkPTyuS3uRr27Kyd9Lgk6eO5+Rq1KpPo4xNZ/7Jq3IIgOoYSoQv52PR4p+qJoGS3UDVHLEA2DBvNT7jw9777cn8FpgZfZ1HbsuoihhZn1qC+VWMiD2C6dJ9RbnfAQeQ90qXfm8JptjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714994403; c=relaxed/simple;
	bh=+FydX9jk6NiJgH9BLsVmNjMoFgPOuLPLWk4QvK65kKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4dZzajlfqXQixqJYIqn9uC0wInUPGohw3WFfqSn8afaJ2MSzF4jtHOqnqkVVdPPr+2RwXtEd1YHgHwOv85d1a9A4+eleVvR+pawpFjke8NAJJWPfzsuxOHTmfQA/UK67WCtg/PaxTmY3ahUcz2bUpAmsoCpMQ0afVCZ+rrFgS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gn1grDxa; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <50a20417-596e-4183-93c6-63fdef526a18@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714994398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=suRHus1G88t8qaBEhwNgbC/d5jKeSl4l04k2fudgj+k=;
	b=Gn1grDxaKB2M2rzUBACl/npNXnF96tsD6A/z7cPNx7TCHEmPXP8Cs0JJOKCdDdGNuSMGg4
	Exah7NRsMWXd6CiSi8imhsv7KIQZVD6Px9TuS05LyfnF/3d1I3Xk5ZGKDcwOqGctb1jbO3
	82D+B+gvDiX2XnsggYs7XMqxZaB3NK4=
Date: Mon, 6 May 2024 14:19:53 +0300
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next] RDMA/efa: Support QP with unsolicited write w/
 imm. receive
To: Michael Margolin <mrgolin@amazon.com>, jgg@nvidia.com, leon@kernel.org,
 linux-rdma@vger.kernel.org
Cc: sleybo@amazon.com, matua@amazon.com,
 Daniel Kranzdorf <dkkranzd@amazon.com>, Firas Jahjah <firasj@amazon.com>
References: <20240506104859.9225-1-mrgolin@amazon.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Gal Pressman <gal.pressman@linux.dev>
Content-Language: en-US
In-Reply-To: <20240506104859.9225-1-mrgolin@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Michael,

On 06/05/2024 13:48, Michael Margolin wrote:
> @@ -663,7 +666,9 @@ struct efa_admin_feature_device_attr_desc {
>  	 *    polling is supported
>  	 * 3 : rdma_write - If set, RDMA Write is supported
>  	 *    on TX queues
> -	 * 31:4 : reserved - MBZ
> +	 * 4 : unsolicited_write_recv - If set, unsolicited
> +	 *    write with imm. receive is supported
> +	 * 32:5 : reserved - MBZ

Nit: 31:5.

>  	 */
>  	u32 device_caps;
>  
>  struct efa_ibv_create_qp {
>  	__u32 comp_mask;
>  	__u32 rq_ring_size; /* bytes */
>  	__u32 sq_ring_size; /* bytes */
>  	__u32 driver_qp_type;
> +	__u16 flags;
> +	__u8 reserved_90[6];

Don't you need to verify this reserved is cleared somewhere?

>  };

