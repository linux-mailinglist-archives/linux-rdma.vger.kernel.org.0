Return-Path: <linux-rdma+bounces-15859-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFL4AIk9cWnKfQAAu9opvQ
	(envelope-from <linux-rdma+bounces-15859-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 21:56:41 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9145DAE2
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 21:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD77D8003EC
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 19:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33DA3A901E;
	Wed, 21 Jan 2026 19:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lambdal.com header.i=@lambdal.com header.b="TK+bY/+j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDD8366DCF
	for <linux-rdma@vger.kernel.org>; Wed, 21 Jan 2026 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769022060; cv=none; b=TKkHF9LITYiSXatZsr9TaK9j5pDFRKBujsp1YhoImGJu4Qaeegkxd+NDhrOzahryX9XiIrIJWuxtEHTRU4Mg55ROksrElfb+PQ89llNyo5mMRihFzakmmcZs/QRKhIQq1k3yF1PZWMCLdEEB0vN1wDXyiwuKvHUf+lHhO7z9TEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769022060; c=relaxed/simple;
	bh=iqKQYEWdnX6t2fLwKe8EThg6k6d0NJ3Lvv63shzH1dU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=A6+Bh9V21B5Br4pwmsEHo0yf6IAPyNFxHFFJ0uDLEXdtm3U3wohm70xBxrdfIcL/s5YbIMboS0evMP6P9P8Acy/B5BNlsLVGHpFH9Z7NWQ5iFfgEB1TPQEhsP5x73xDZKCTrqsVYaHM719z/lYbaTLxITVEWsFiLdcvNIuvVp8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lambdal.com; spf=pass smtp.mailfrom=lambdal.com; dkim=pass (1024-bit key) header.d=lambdal.com header.i=@lambdal.com header.b=TK+bY/+j; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=lambdal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lambdal.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2b71347ac0aso401048eec.0
        for <linux-rdma@vger.kernel.org>; Wed, 21 Jan 2026 11:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lambdal.com; s=google; t=1769022039; x=1769626839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0J0zYT/RVCu09y2gRSIELAZBaGEq/Rzvh5SHR+iNB1A=;
        b=TK+bY/+jp/NTVsAFpDTPDUj8zkNn9bgaf5RT82KkX6w4Xw4q1mG6kl4hpsXOppflTY
         blVlCLcwwSeIyR7A3u+yGx30aC5JfeVOH0w8VjTCwVloohEQI9qJDkm3QjTODhlBTDn7
         K3bns6pi2Bn82DLZtsBf+gLv2Lm+OIclcamto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769022039; x=1769626839;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0J0zYT/RVCu09y2gRSIELAZBaGEq/Rzvh5SHR+iNB1A=;
        b=hCPgBw5e8KMwnSepkkEYwUfei4huO6RABLR0il9E7fpaKjaPn7McoZG2q3rS4gn74+
         D7ZP7Rqxtprfn1kNgZgrvlN9JUxnFikQsL5ZknapWtmP7z1iCA+KpwA9jzsQOj2mC1Wl
         V4ElbqdN1fc1GS2MdezB3zKZzAMIzz2JaQHqRcxr4DczriflIA+hJ3QuMR/RagLGvDiH
         Fks6YRa2jsAXZRge+sSYPUksXDT3XKzYyw6yoMy1Q5moiQPwNeUdiQFkwHqvkgZ8mRJj
         QSPzWRY++xiSO9PSWDgWVo8mH2gnSJD9kyHElN+hhKsumt4ZtRK88KklAz2e/T7Rl0sO
         qOhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb5XgpHc/0xcHE8nGY7btjcTFHalBbQWgxTvEHV7ym8qGUDMCEgawGT6IU3X+3WtERO5lM6/bcaPNr@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx3vgXQ+mWc3PP03qGQzatj8Iwl3d4+7y1Aho7YoV+3tpqbl/8
	RJ6i4xZzqHeQFE5Zv5BKE/AoJ6nw4rY2IGYa0v0lK3t6Aoz2WmDCOVQV4CXMWzh2cEo=
X-Gm-Gg: AZuq6aKzJ6FJvE9qsH/UZ0ywrlWIlfMU5p/Y4T98eu13v6pfBJDXZuTbPZ5CrwRvBzJ
	QMr6zdTgKTdU/Gxw2kHqdLOV3j813tiWuRr47CCtkPumPDzx9/KxiC739mEmHMvFKksPg3mD8YH
	AAnaVHfAsn1l4hjPm2wmH9i0mX0RKnI42qPymxpUim0iFyRwzppcdvAp4t1HLOhG3uWK9XDblUg
	YHg3+OGkVIUA71AsLU8uL0mHvUkErAkt5VxNbP66hO5srhtpitW7Lp9EpJH3JPvX/z6zs7ofOBw
	1We2NitUXWeJeLXlHgnnPkZ8RZIq7Sp6C//mwSMTjrUtk9rLdQGhrB0NeNL2gUDf/Ba8Qa3it96
	tu7uiBQt8kA6hGzpHpgNuWaugC7GECY4JDhE2+jvuq3QfUSNI2MU7I92KgBlsO4yk6uN71OIxwp
	2t+YNm/5Xb+vqrJACfNvltj5utnYzHfsgoFHAzdd/P6bsk4HWJW4VWbBEPNlDccRcOQ/+Ng7fQS
	FW4mI9L/mc=
X-Received: by 2002:a05:7300:fb8a:b0:2ae:5a2e:de70 with SMTP id 5a478bee46e88-2b72475a8f2mr186408eec.8.1769022035594;
        Wed, 21 Jan 2026 11:00:35 -0800 (PST)
Received: from [10.100.9.95] (LAMBDA-INC.bar2.SanFrancisco1.Level3.net. [4.15.73.186])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm22102201eec.9.2026.01.21.11.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 11:00:35 -0800 (PST)
Message-ID: <a3bd35b1-b99e-4936-afca-b9fb6d03de0f@lambdal.com>
Date: Wed, 21 Jan 2026 11:00:33 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/irdma: Use kvzalloc for paged memory DMA address
 array
From: Carlos Bilbao <carlos.bilbao@lambdal.com>
To: jgg@ziepe.ca, leon@kernel.org, akpm@linux-foundation.org
Cc: bilbao@vt.edu, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 carlos.bilbao@kernel.org
References: <70f5170f-70eb-4244-9049-a994ec503ac6@lambdal.com>
Content-Language: en-US
In-Reply-To: <70f5170f-70eb-4244-9049-a994ec503ac6@lambdal.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[lambdal.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[lambdal.com,quarantine];
	DKIM_TRACE(0.00)[lambdal.com:+];
	TAGGED_FROM(0.00)[bounces-15859-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.bilbao@lambdal.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,lambdal.com:mid,lambdal.com:dkim]
X-Rspamd-Queue-Id: 8B9145DAE2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Looks like Mustafa is no longer at Intel [1]. Does anyone know how
to reach them, or Shiraz? Their email addresses appear to be
bouncing as well.

Maybe you do, Andrew? 

[1] https://www.phoronix.com/news/Intel-More-Orphans-Maintainers

On 1/21/26 10:54 AM, Carlos Bilbao wrote:
> Allocate array chunk->dmainfo.dmaaddrs using kvzalloc() to allow the
> allocation to fall back to vmalloc when contiguous memory is unavailable
> (instead of failing and logging page allocation warnings).
>
> Signed-off-by: Carlos Bilbao (Lambda) <carlos.bilbao@kernel.org>
> ---
>  drivers/infiniband/hw/irdma/utils.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/hw/irdma/utils.c
> b/drivers/infiniband/hw/irdma/utils.c
> index 0422787592d8..59ef9856fd25 100644
> --- a/drivers/infiniband/hw/irdma/utils.c
> +++ b/drivers/infiniband/hw/irdma/utils.c
> @@ -2257,7 +2257,7 @@ void irdma_pble_free_paged_mem(struct irdma_chunk
> *chunk)
>                                  chunk->pg_cnt);
>
>  done:
> -       kfree(chunk->dmainfo.dmaaddrs);
> +       kvfree(chunk->dmainfo.dmaaddrs);
>         chunk->dmainfo.dmaaddrs = NULL;
>         vfree(chunk->vaddr);
>         chunk->vaddr = NULL;
> @@ -2274,7 +2274,7 @@ int irdma_pble_get_paged_mem(struct irdma_chunk
> *chunk, u32 pg_cnt)
>         u32 size;
>         void *va;
>
> -       chunk->dmainfo.dmaaddrs = kzalloc(pg_cnt << 3, GFP_KERNEL);
> +       chunk->dmainfo.dmaaddrs = kvzalloc(pg_cnt << 3, GFP_KERNEL);
>         if (!chunk->dmainfo.dmaaddrs)
>                 return -ENOMEM;
>
> @@ -2295,7 +2295,7 @@ int irdma_pble_get_paged_mem(struct irdma_chunk
> *chunk, u32 pg_cnt)
>
>         return 0;
>  err:
> -       kfree(chunk->dmainfo.dmaaddrs);
> +       kvfree(chunk->dmainfo.dmaaddrs);
>         chunk->dmainfo.dmaaddrs = NULL;
>
>         return -ENOMEM;
> -- 2.50.1 (Apple Git-155)
>
>

