Return-Path: <linux-rdma+bounces-2302-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E22E8BD40C
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 19:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB7C1C218FB
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2024 17:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D890815749B;
	Mon,  6 May 2024 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="muR5nv/4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E430156962
	for <linux-rdma@vger.kernel.org>; Mon,  6 May 2024 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017626; cv=none; b=PIPWOpiYnd3z3J6NiS4m6MQJEE83zvZU7yu2qzlJTWRLPEkD16TZ95/V7g2stDrvEhqqwV22PD7dC+aBfcMrMPsMlUQAPNWlTJIjEKdke4FEtPwTDuZ7GZIfSZQEQnxJ/bv0TU+SqJ05zwqA62An0fDYaZyLsbctaaqS4VTt8YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017626; c=relaxed/simple;
	bh=GRUPH04XR3MxZCU1XoneaOSRwunQxoxY0PD9agsirAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwxtNWNOtz+5Ah6IRbDsA4qTpWasHP0d79fYBRAL7nbv+GfSE79ncAPycVHyblVvHrTjgUk4YGojZTB7JfW6uhfZr24zIX/TqW3mhp8V03MUk9vVuC7Ja8mIXe2/o92Zl/KG0euEe00turcBHC9baSBrNbw7laJMwzzh+w9AM4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=muR5nv/4; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-23f9d07829bso610347fac.3
        for <linux-rdma@vger.kernel.org>; Mon, 06 May 2024 10:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715017624; x=1715622424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tbjnaPu0Ni4N2AUpQBWzp3K4xaksRyuDMkv3R5SI53s=;
        b=muR5nv/4hfklKVVqQlHuyugIicCREY9hc65hugKgmwYDbikj5L+kEZ8wkE94mMQYb4
         B9mV0/SXupnrm/Vcn+fHcEZmQvwKsvhd+OGCg627lP0+DfSWthQt9Zw+G5dQqUAruCzI
         SMXA/CoMG5eMIPCc5AXVabGMS+bLr7wl7IDMAdZousm6x+Ctyybhwin+Aym/VqnUpcCc
         0qW6NHqvw0aGSOfsOADMgLyBuxmwrQfGM71UJYESDuFqx9W+lQbgolZloUEwJVG6c8N0
         FLqMfu6DJub5+flE+DcF5cGjRJpiiYpfnorey1Uw6AfEnM/llhuZO3tUi0aIJZWEWm7g
         Rn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715017624; x=1715622424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbjnaPu0Ni4N2AUpQBWzp3K4xaksRyuDMkv3R5SI53s=;
        b=Y9OdLsJIwS8zcSBTVEIt98wnXBvolAHN/DvjfwWEP2aNF3KNWPw3POsgR2aEE20dx+
         S1vwsA3zsC6cITI4JYLgBJsoLCVdurFOZxW15RT9TX0sqCr34jJIjhA5N5hSWBrRTXzw
         CYSt0XjqR2YnoCsUTXa63oO6NrdO2rfzbc0FFgf8oZkbnTU+7fEWt+6Jmi++jjmdrQZw
         C/ssT4TDy/TfZzk7S8cClSXx9Ww+NO6GnCVaqA48MKBSRFRRPhT+qYA856XFkz1+fPW8
         uQOb+BD31/aoSLG33S748mw2oJpFuCbUH4UQbml4J2Wdv25ct03lMhL/CUP+23LY0p7D
         HPiw==
X-Forwarded-Encrypted: i=1; AJvYcCXWGmV50uEZYAsxp41O952GMcqPh0naFxbMFW865x2thEJUcXnJXykBH+fqBBSgY6EiRI9AHV4eGqSkitrPpycCAw6bfe2toK5aJQ==
X-Gm-Message-State: AOJu0YwTYlzKA770jRuCVB/A7To2xzlpvNBcy71NzGpD8RK/rjo2APon
	3mHoIaZRv+VuGS/br9t5zvW8Awcj84KKKH34lj+Rj1YkQLKD5hilfn+jsPVPM+0=
X-Google-Smtp-Source: AGHT+IGne4Vj22p8iU5NvaofInsxOb5/LzKeXxYgohrO3x36LEutcUq1n9ZjTPogHvmqo9WCL7qwHQ==
X-Received: by 2002:a05:6871:5213:b0:23c:6619:5970 with SMTP id ht19-20020a056871521300b0023c66195970mr13442863oac.7.1715017624229;
        Mon, 06 May 2024 10:47:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id kz5-20020a056871408500b00234bc052521sm1980413oab.10.2024.05.06.10.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 10:47:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s42QX-003Uxl-9P;
	Mon, 06 May 2024 14:47:01 -0300
Date: Mon, 6 May 2024 14:47:01 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com
Subject: Re: [PATCH for-next 2/2] RDMA/bnxt_re: Expose the MSN table
 capability for user library
Message-ID: <20240506174701.GG901876@ziepe.ca>
References: <1714795819-12543-1-git-send-email-selvin.xavier@broadcom.com>
 <1714795819-12543-3-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1714795819-12543-3-git-send-email-selvin.xavier@broadcom.com>

On Fri, May 03, 2024 at 09:10:19PM -0700, Selvin Xavier wrote:
> Expose the MSN table capability to the user space. Rename
> the current macro as the driver/library is allocating the
> table based on the MSN capability reported by FW.
> 
> Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 3 +++
>  include/uapi/rdma/bnxt_re-abi.h          | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> index ce9c5ba..d261b09 100644
> --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> @@ -4201,6 +4201,9 @@ int bnxt_re_alloc_ucontext(struct ib_ucontext *ctx, struct ib_udata *udata)
>  	if (rdev->pacing.dbr_pacing)
>  		resp.comp_mask |= BNXT_RE_UCNTX_CMASK_DBR_PACING_ENABLED;
>  
> +	if (_is_host_msn_table(rdev->qplib_res.dattr->dev_cap_flags2))
> +		resp.comp_mask |= BNXT_RE_UCNTX_CMASK_MSN_TABLE_ENABLED;
> +
>  	if (udata->inlen >= sizeof(ureq)) {
>  		rc = ib_copy_from_udata(&ureq, udata, min(udata->inlen, sizeof(ureq)));
>  		if (rc)
> diff --git a/include/uapi/rdma/bnxt_re-abi.h b/include/uapi/rdma/bnxt_re-abi.h
> index c0c34ac..e61104f 100644
> --- a/include/uapi/rdma/bnxt_re-abi.h
> +++ b/include/uapi/rdma/bnxt_re-abi.h
> @@ -55,7 +55,7 @@ enum {
>  	BNXT_RE_UCNTX_CMASK_WC_DPI_ENABLED = 0x04ULL,
>  	BNXT_RE_UCNTX_CMASK_DBR_PACING_ENABLED = 0x08ULL,
>  	BNXT_RE_UCNTX_CMASK_POW2_DISABLED = 0x10ULL,
> -	BNXT_RE_COMP_MASK_UCNTX_HW_RETX_ENABLED = 0x40,
> +	BNXT_RE_UCNTX_CMASK_MSN_TABLE_ENABLED = 0x40,

Wah? How can you rename this bit in the uapi?

Looks really strange, userspace is even using this constant.

Please explain in detail what is going on here in the commit message. :\

Jason

