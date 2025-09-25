Return-Path: <linux-rdma+bounces-13639-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED8EB9E5B6
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 11:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99194C5DB2
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Sep 2025 09:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABC02EA723;
	Thu, 25 Sep 2025 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LiWh1y5A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24B42EA172
	for <linux-rdma@vger.kernel.org>; Thu, 25 Sep 2025 09:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792467; cv=none; b=DkVE3XoAr+WvP4K27WbSs9mt5eiIBOOpK/vCFCwxED8Kb77Omj4K6teJXY8VLJH5KI+mZTr8IqdRH5hIrfuUwlDJAdtaf5PmAsuKSuXbXHoRj4POzTX3aty5BiGWwhBC/QgZRPd3LkpF1MPK97IxbJclC9X/LGPnzj40a8K9DuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792467; c=relaxed/simple;
	bh=4Yv3Q5cOmyZVTHyUxtyXh72sHLtXQN/FSgzj4obRUDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SbhZwq4RgBtLQhQaBEeduDmocggvgVMxm4BcTj7YerkHVs3TtaGafuf3m5sKmfhDzWKwCicovaTbgVnvw4ALcSRVQOxePxCKiQj7kYo3Fe6Jf4fAo08nmc9l+l86Px1Wk3VcEeRSRsbG8ZR1+a8d15ix7CdIDZ4s0hrA35HsjVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LiWh1y5A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758792464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UWFAvZzxsmjhh9q6bJ5VMROTWJuLviIpjPx87FL9KGM=;
	b=LiWh1y5AQjIrq6VMvmPzz1fSS3d7tz+wenAFAyQK92IwTKZpEnA1b+HFdQl7UPLB44CJi1
	PSRwg4umwDQpaOfleLpf3zpwoRetDv9TlzBqKErFhmKjIUluKhlJXQRakexDCuqtbPVjDG
	NGefnpps08JtwLvYuXihaH6FH1OjFDI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-r_WEHdDPN8GeFiAVTLv-7w-1; Thu, 25 Sep 2025 05:27:42 -0400
X-MC-Unique: r_WEHdDPN8GeFiAVTLv-7w-1
X-Mimecast-MFC-AGG-ID: r_WEHdDPN8GeFiAVTLv-7w_1758792461
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f3787688b0so349991f8f.0
        for <linux-rdma@vger.kernel.org>; Thu, 25 Sep 2025 02:27:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758792460; x=1759397260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWFAvZzxsmjhh9q6bJ5VMROTWJuLviIpjPx87FL9KGM=;
        b=chyG7BLlazh5ciQrUFnxfCBc5FPJ9MzIgRX96vW2U7YX1nxHrm7QM5O9KeE58kDuIl
         CPxTrHRvTpULsSI0EW9aDOgfDIw+fw/LCbFcr9PE1D6akN44Omf644E79Y7A2ZbP9ulX
         XaFGgGbabI1EqY8Ig94kAAP+Zo6ngOtMwEThndZI7KR++RoTkDopE13NtTZXS6B1zkHQ
         CIrK/C6A7WY6jWb0+GsVyetCRSZTFXPUEGlDW+irV4COErjWaJJvBuli6jA7w/LeQ+lU
         F1gW5tDWWe+3KTwtZ7bz58sTd74jevlFtEeiTuKwrRowSrbVMTvj4Dz46Xef2clWkTyX
         EzOw==
X-Forwarded-Encrypted: i=1; AJvYcCWTf6sRcYBJ2nfZ7OAazCJeO4nSCXp/x4IMatq0WeHV5dkkicO0XepVdJfbu7yupeCc279s3UmZTCh3@vger.kernel.org
X-Gm-Message-State: AOJu0YyzueCl99W2wF12OQVC+ZNJ2VaYGfKO23T+IkhZKSEkPdvZ8hLG
	aTgRhs4KjsqxMdc3FrFljDciUCRufMhslOE1bMMiA2Ir1E9KnPqufl+cg/rZcPD1JJ5xOPs0Bgo
	HOGZYPIQMSMtFtHL58hfi0PK4xLV+xoE9Udz1U+rW5BVLUFvWWzKISBOKb/eZEQTkHWv3Q7E=
X-Gm-Gg: ASbGncufNp0Oi0K2rGTnOGX9twEl0rkM/2UG28dSGZrqeM0QiTpzu9WffxXbCJX1ySS
	VTZVU6BpSNWDCUrtinGfxO0ADYfwwF7AdmRaQgJ66IIug4NM6fCEd5psdYsrK9OhI0Nltefx8/W
	Xctp89HLU2RJYcmu/B3rXoh9hULG3J00UrDDQ8GLiDTyC9oocfULvDXoALt8vVSb5FjyDeAQtMR
	KnQPwwuP8374JsbNabyeXvRk5YZI9lPekKZZmZqKTdcJYzLstYnVlZKTbL9mbgA7XNsPDf/Fxzv
	O8gvF5OaemCs5CiRhd3ttOk3nzFr0fW5xVgydsbCjfp0bSlCvzsYeJcofw+MOJkcTroocTN4m1y
	N6/pqmqXuiXYF
X-Received: by 2002:a05:6000:2306:b0:3ec:dd19:5ab with SMTP id ffacd0b85a97d-40e4dabf4bcmr2260618f8f.61.1758792460432;
        Thu, 25 Sep 2025 02:27:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4KO3m6UVzFQeKSl0okBGg5bJ0PBmfh3JJWmV5i+8yo09g9ZgqQZzl0ahuXJF36hdJNUY9+g==
X-Received: by 2002:a05:6000:2306:b0:3ec:dd19:5ab with SMTP id ffacd0b85a97d-40e4dabf4bcmr2260602f8f.61.1758792459988;
        Thu, 25 Sep 2025 02:27:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab61eecsm69224455e9.20.2025.09.25.02.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 02:27:39 -0700 (PDT)
Message-ID: <7cc2df09-0230-40cb-ad4f-656b0d1d785b@redhat.com>
Date: Thu, 25 Sep 2025 11:27:38 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net/smc: make wr buffer count
 configurable
To: Halil Pasic <pasic@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, "D. Wythe" <alibuda@linux.alibaba.com>,
 Dust Li <dust.li@linux.alibaba.com>, Sidraya Jayagond
 <sidraya@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-s390@vger.kernel.org
References: <20250921214440.325325-1-pasic@linux.ibm.com>
 <20250921214440.325325-2-pasic@linux.ibm.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250921214440.325325-2-pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/21/25 11:44 PM, Halil Pasic wrote:
> diff --git a/Documentation/networking/smc-sysctl.rst b/Documentation/networking/smc-sysctl.rst
> index a874d007f2db..c94d750c7c84 100644
> --- a/Documentation/networking/smc-sysctl.rst
> +++ b/Documentation/networking/smc-sysctl.rst
> @@ -71,3 +71,39 @@ smcr_max_conns_per_lgr - INTEGER
>  	acceptable value ranges from 16 to 255. Only for SMC-R v2.1 and later.
>  
>  	Default: 255
> +
> +smcr_max_send_wr - INTEGER
> +	So called work request buffers are SMCR link (and RDMA queue pair) level
> +	resources necessary for performing RDMA operations. Since up to 255
> +	connections can share a link group and thus also a link and the number
> +	of the work request buffers is decided when the link is allocated,
> +	depending on the workload it can a bottleneck in a sense that threads

missing 'be' or 'become'           here^^

> +	have to wait for work request buffers to become available. Before the
> +	introduction of this control the maximal number of work request buffers
> +	available on the send path used to be hard coded to 16. With this control
> +	it becomes configurable. The acceptable range is between 2 and 2048.
> +
> +	Please be aware that all the buffers need to be allocated as a physically
> +	continuous array in which each element is a single buffer and has the size
> +	of SMC_WR_BUF_SIZE (48) bytes. If the allocation fails we give up much
> +	like before having this control.
> +
> +	Default: 16
> +
> +smcr_max_recv_wr - INTEGER
> +	So called work request buffers are SMCR link (and RDMA queue pair) level
> +	resources necessary for performing RDMA operations. Since up to 255
> +	connections can share a link group and thus also a link and the number
> +	of the work request buffers is decided when the link is allocated,
> +	depending on the workload it can a bottleneck in a sense that threads

same                               here^^

[...]
> @@ -683,6 +678,8 @@ int smc_ib_create_queue_pair(struct smc_link *lnk)
>  	};
>  	int rc;
>  
> +	qp_attr.cap.max_send_wr = 3 * lnk->lgr->max_send_wr;
> +	qp_attr.cap.max_recv_wr = lnk->lgr->max_recv_wr;

Possibly:

	cap = max(3 * lnk->lgr->max_send_wr, lnk->lgr->max_recv_wr);
	qp_attr.cap.max_send_wr = cap;
	qp_attr.cap.max_recv_wr = cap

to avoid assumption on `max_send_wr`, `max_recv_wr` relative values.

[...]
> diff --git a/net/smc/smc_sysctl.h b/net/smc/smc_sysctl.h
> index eb2465ae1e15..8538915af7af 100644
> --- a/net/smc/smc_sysctl.h
> +++ b/net/smc/smc_sysctl.h
> @@ -25,6 +25,8 @@ static inline int smc_sysctl_net_init(struct net *net)
>  	net->smc.sysctl_autocorking_size = SMC_AUTOCORKING_DEFAULT_SIZE;
>  	net->smc.sysctl_max_links_per_lgr = SMC_LINKS_PER_LGR_MAX_PREFER;
>  	net->smc.sysctl_max_conns_per_lgr = SMC_CONN_PER_LGR_PREFER;
> +	net->smc.sysctl_smcr_max_send_wr = SMCR_MAX_SEND_WR_DEF;
> +	net->smc.sysctl_smcr_max_recv_wr = SMCR_MAX_RECV_WR_DEF;
>  	return 0;
>  }
>  
> diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
> index b04a21b8c511..f5b2772414fd 100644
> --- a/net/smc/smc_wr.c
> +++ b/net/smc/smc_wr.c
> @@ -34,6 +34,7 @@
>  #define SMC_WR_MAX_POLL_CQE 10	/* max. # of compl. queue elements in 1 poll */
>  
>  #define SMC_WR_RX_HASH_BITS 4
> +

Please avoid unrelated whitespace only changes.

Thanks,

Paolo


