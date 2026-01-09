Return-Path: <linux-rdma+bounces-15412-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA926D0BF58
	for <lists+linux-rdma@lfdr.de>; Fri, 09 Jan 2026 19:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5071A30245C1
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 18:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631042D1911;
	Fri,  9 Jan 2026 18:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PUcBjLD3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B592C23182D
	for <linux-rdma@vger.kernel.org>; Fri,  9 Jan 2026 18:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767984641; cv=none; b=akKDwd+4jLWZ9BPn7vUOx2ZN10SuBaWlW8Pcy5AfgTts4O180hJyyHEz40cbSwQ/h40xyZ+XDc9T6FmSUT8mEevYNJByzMFpIzPrBncb3y7OOyaFJwb97blIrxY2r8C5RE2S2283oG3zSbcCucKRcbW2eBwHK8jYrMvXWhDoN1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767984641; c=relaxed/simple;
	bh=ZDfTtCHMipajDRqOVfpRdUSQkuId9avB2+8sYn/fKXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RD+pSQc7SCXMUtUE1TkyNwk/uEZTqhvMfMdPVDHw3qhnHLHeSCiQ4OyKetub4GxsutWnnkiFDF1l84pAJ54yoqG4/2ePaaaOWanqIhEOxuSQl0Y/5zlX/moVA0NcrRpL2vmgvWMwu/QFdc+jsLD2NRA58DkzcJA6PW5ztIneFYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PUcBjLD3; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8c0f13e4424so441855485a.1
        for <linux-rdma@vger.kernel.org>; Fri, 09 Jan 2026 10:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767984639; x=1768589439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=994aysxLOcWPLd3SMpqCxReGe0e8U8IOOOwG1n0x0TM=;
        b=PUcBjLD3A9yJMMlKqNr3fxBms+BlN9Dyf1Ov95uqdHapg64qStNTTbhpmGtlprsTlW
         E7Ggg7Q82Y0sX3Zy31mlH51+2tTpkLi2igSKZkQOiCSyDnS3hAxyfc2Fct8ilds+lMN8
         tYwq9ZsNgsrVNTQLyj2G8G0dzDlsLrfVIjqwD+XdP0aeia7Cm6Xspg3OZQNaasCpPFSv
         SkrxQtflS5UJdW7uyXY0sh73yFYi9lC61B6Qnp8qxIdzRwOxGXkJO2CSVEaFWLRsJNsP
         dJtOWK0I6w5zetnT22UaynaHrI7auOeg/aCBJDd0PRcmDjNo9+tNsCg75SyEtgj5gGRb
         CtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767984639; x=1768589439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=994aysxLOcWPLd3SMpqCxReGe0e8U8IOOOwG1n0x0TM=;
        b=cxHeyOjJc4LC5UAPCLVh9lw5qDHPVrzOWuQi7mt0CaSFAUhly6VMSuAocd8n0JrDzv
         g9tkGxYXoteMycwkLvfZQFRrW/222FwzIZH93mmhIcMj2NuJL9SMwhFqD/nCPZ9XipMY
         F3K3kx81bbJsaCf9v0Cju5vqJCewroh3Y3veVObHQYxJKlc8/zTnInz5J3uEyZAv9edL
         sHFzywTHv5ThqqSCB1DuMo/Ze/Rr6pCqOULFMMkospCd2zlkBmwVlDR61j4CGfNPgoYK
         4gDhlUAVS8amAjESwDmsIQ7qm8y8r9bHkCteg6MaUxmy6TVQ0kn9XnnwIzUD6+e/IFdj
         9ieQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUgF4MY+QNdjBkgv1YpzBAXNI2Rq9lGVPEot0dK4v4CmK6QY7V5MP74giNHMGH9JLkcdj+PuAwVnL+@vger.kernel.org
X-Gm-Message-State: AOJu0YxobsEsVdOXpbnGBdAgQ10s6G1ZZEJ7sLIA9VwpU7hs5RySI7gz
	z2iDF15QZlqk1Kmts1iYNZ2FO+pU1JrYRUdSygnCr6UJ2Db51punKMzJjWkkiIcNxDs=
X-Gm-Gg: AY/fxX64PrbMokcm6S5JiU7y1uv7H2a4VegeT4UO9GjMhFSAKoRZjdSXI1e9IW44Vli
	2Xo9OAVGgJtfUiA+HgGVo29Nixzdol2dy/coYNIbJrnygjzsRLHlHd1qx57J/++9uMNV1+5D3dp
	sgKEHany0lkPZ2feaCW4Ho6ne9mFLiY8u3rMd7Ki6j0MCYETO99DSgw24csYqhCRQ+LoN1ByumA
	B+3cCojuFp+TaOv4uriDZr4+90iKLPSwt2TunMJeuAo8a2kpNeDkCTq8QAPHgZPmx2d8bDICCrP
	PMG2/kBSgLuIZ/t+U12hIIIWCECzW7n9374gemWUlnzH3Ydbbq++1jAISzHQWixu9lEvqaEShV2
	pZCoZ74Qg5FCI56qhuy5CId60p3Esx1GngehW27TdSumAg8ERgIviJvBCtmoBfiReeNhmVHdKt5
	8Pb4SjdFksEZ7AqqslH5TeGcUFvq81KkVptjlvabCMSxKugbWH7bbe5lq589Cd1mu590A=
X-Google-Smtp-Source: AGHT+IFqVqEalYX6/JxmGMfFt5Q8z1APe+CdaB0uilHM8p6dUYjiODeHf+SdnqEtVX7YsgSR1I9k3Q==
X-Received: by 2002:a05:620a:461f:b0:8b3:c8ee:7240 with SMTP id af79cd13be357-8c3893690efmr1570125985a.5.1767984638622;
        Fri, 09 Jan 2026 10:50:38 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51d06fsm857278085a.32.2026.01.09.10.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 10:50:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1veHZF-000000037Wv-2rTZ;
	Fri, 09 Jan 2026 14:50:37 -0400
Date: Fri, 9 Jan 2026 14:50:37 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v6 3/4] RDMA/bnxt_re: Direct Verbs: Support DBR
 verbs
Message-ID: <20260109185037.GL545276@ziepe.ca>
References: <20251224042602.56255-1-sriharsha.basavapatna@broadcom.com>
 <20251224042602.56255-4-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224042602.56255-4-sriharsha.basavapatna@broadcom.com>

On Wed, Dec 24, 2025 at 09:56:01AM +0530, Sriharsha Basavapatna wrote:
> +	ret = uverbs_copy_to_struct_or_zero(attrs, BNXT_RE_DV_ALLOC_DBR_ATTR,
> +					    &dbr, sizeof(dbr));
> +	if (ret)
> +		goto free_entry;
> +
> +	ret = uverbs_copy_to(attrs, BNXT_RE_DV_ALLOC_DBR_OFFSET,
> +			     &mmap_offset, sizeof(mmap_offset));
              ^^^^^^^^^^^^


> +DECLARE_UVERBS_NAMED_METHOD(BNXT_RE_METHOD_DBR_ALLOC,
> +			    UVERBS_ATTR_IDR(BNXT_RE_DV_ALLOC_DBR_HANDLE,
> +					    BNXT_RE_OBJECT_DBR,
> +					    UVERBS_ACCESS_NEW,
> +					    UA_MANDATORY),
> +			    UVERBS_ATTR_PTR_OUT(BNXT_RE_DV_ALLOC_DBR_ATTR,
> +						UVERBS_ATTR_STRUCT(struct bnxt_re_dv_db_region,
> +								   umdbr),
> +								   UA_MANDATORY),
> +			    UVERBS_ATTR_PTR_IN(BNXT_RE_DV_ALLOC_DBR_OFFSET,
                                         ^^^^^^^

ptr_in shuld not be used with copy_to

Jason

