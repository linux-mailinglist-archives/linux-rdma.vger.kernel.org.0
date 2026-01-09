Return-Path: <linux-rdma+bounces-15411-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24986D0BDD5
	for <lists+linux-rdma@lfdr.de>; Fri, 09 Jan 2026 19:37:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59F55301D592
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 18:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FBC274B28;
	Fri,  9 Jan 2026 18:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="no7Ij9oM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9112737FC
	for <linux-rdma@vger.kernel.org>; Fri,  9 Jan 2026 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767983832; cv=none; b=t37kdwJs1SDLtLmyQ2D1JDXGEtF4AwxOpEVmlMKKZEJ7xbc4dV0jHBgEJEcs2fRDSziRkXdERDpXqqHZQi1fer/ajg1jQcbT53lWCE0kmXcTUbbaBkhx/YVG2Obz/fHocGIRUYLxF5id+iv+fxQu9leZJZODXasKZxoR3kPUeu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767983832; c=relaxed/simple;
	bh=cVhWPD05pNLk00XWZO+K6fUuVB1Q7hcOGmG3FRbxETg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPhg+kpxOcG1RcqkUBQcNEtPqw8vnm1j7uib6J6Dmv5JXdlaN5aVwKW5dGgNvTOhCkEmLP0qjZ08tccJC4tdixi4jhR+wnWyUVEA+PPNcLamDPVZ/2/57cT7QdEBF6ehzOzQmcVRO2TfcXv6+64yBdVlSP9HyvyxQkQ5lZBKkDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=no7Ij9oM; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4f34c5f2f98so48010431cf.1
        for <linux-rdma@vger.kernel.org>; Fri, 09 Jan 2026 10:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767983830; x=1768588630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yzTqFe26noRhTMI3/AraU7Mf2H6W/8RNyHUCkvyfl78=;
        b=no7Ij9oMhaaVl3mGbBnnCfbfkypfaTYjEsWLPCJxZ7MnCY+j3iAbzTT7ZLxfDFfq/W
         FnTOZRgR5U2ZZ6slItMgXIZ2lhTpxNJAKmG8RjqBugcNYAkS17hw8fM2xu3RaSDLU4GC
         8fAKON+CJ+ggGKcXdXYrbQqq8e+2vFq5zLhVt5gUG0sD9cAQJfU/P9pNxCbtde4jTeMA
         YH2xLEScHSBGKYUTb9+aQtJcAQfkOHk5qNbZIdj1eB5ehxeLszVRNNyC7TsTYFNIQ6x2
         UgO5IOxDUfayASqxF6bbKQF5PRuvANlDr3pm2lzOJNUM77AnUx6Lc6VTIzoU9NXiZj+H
         2VFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767983830; x=1768588630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzTqFe26noRhTMI3/AraU7Mf2H6W/8RNyHUCkvyfl78=;
        b=WlVlengnwgs9kueqNWWK9BJP+pNVybNrpmB+2VH87ZiI+xw+WHvJ9qQoMbtmfR+0dR
         1hcrohKAFIK6g3OY59vpjQvXnltUKD94ek+rRqrdI1r4qOVDVYyWa4i3rV7ALmGgqteH
         /VaBf+Kxafpq5fBoKnJiksO/ESa4Z0MOFltStKY+w9eJg8A2ARMJxNcgYtHEA3sVltuu
         MuwaVM+FM0RY3fPr+vsvWdgMNESkvz5gStSzCdGEMBg1Wa+nFvSiNag7RuOwbu8uY/B3
         xsOSkr9BOLq/Q8nbGHlFiHpQFmDmZDBxn80/zYqGPKZqwKgozQ6zkf2OoX35S+ewNdXj
         cWyg==
X-Forwarded-Encrypted: i=1; AJvYcCXe+/gufIiXC/Qr24pmRFnM1T13Yx+8uw2YtVMPqcCx0XhY3qT3A851gfjcKzNC7o1PRbDZthN5JKH/@vger.kernel.org
X-Gm-Message-State: AOJu0YwIqZH3Z+MhKFr7yivDR+9gLde0wNx9W7HzhEGtg7Wx69wzH6cD
	PyK0q8hyvSJR8Cu8ZkL2urg0tlzRBrEh42crwwziXl936ybNQHI6pBkoVH0ZLvzV0LY=
X-Gm-Gg: AY/fxX7leEtBG7LlDUNlwLuxqESrtThBTmjOaz4pfTNBKZ3n+4RJBZWDgrNt9f/nGhw
	Iko+UpLnxhu3tlLLGE+INbxal6L772D4nL6oQ0UXdtAarkDdxyzn0JzSP+Yr/OFBYR1/PJthw25
	t1j216+mkZTICiWLH11te0MB/OXtJYpawIKK6tU4enOpucCnJp2JlpAxvoMTJ99tdFSQcC8cyEK
	d56BPOqeElNcxLFUTkE6NUtvg2OOMRUqFcfKaKk3Qo0bdpsYXeXvukTOHt97ZtUve6mvNlpP4HZ
	dgxWNsSmg33dMb3WW8pW4oBicBHKgLDQ1a2gu2HCWimN1FB/Yfig1ynazj/XtU34dZmRCGdIVGv
	705Ef4MSQ7fgcBOHBirg2K8jjqSTPmmptuv3JFyEzn8nOY/DyogiejqyPRijOq3PrLRyK5vOkbg
	n6kgZ9MzMm/X/y2G/qybWu0Qb1nySqck9dbCOQDKPJU+wrF1/PI1NQwTOA/hmcZwYFvE0=
X-Google-Smtp-Source: AGHT+IG8yn9xOUbjQefiaERgKk8U5mBvB4VRJBSl6sy7cxYGQWHhqsnwHPR5ujINfv5rqmbdEIuQjg==
X-Received: by 2002:a05:622a:8617:b0:4ff:c639:4432 with SMTP id d75a77b69052e-4ffc6394517mr62794091cf.13.1767983830264;
        Fri, 09 Jan 2026 10:37:10 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffc17c288csm35696631cf.29.2026.01.09.10.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 10:37:09 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1veHMD-000000037Mg-183W;
	Fri, 09 Jan 2026 14:37:09 -0400
Date: Fri, 9 Jan 2026 14:37:09 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v6 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
Message-ID: <20260109183709.GK545276@ziepe.ca>
References: <20251224042602.56255-1-sriharsha.basavapatna@broadcom.com>
 <20251224042602.56255-5-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224042602.56255-5-sriharsha.basavapatna@broadcom.com>

On Wed, Dec 24, 2025 at 09:56:02AM +0530, Sriharsha Basavapatna wrote:
> @@ -101,10 +101,14 @@ struct bnxt_re_pd_resp {
>  struct bnxt_re_cq_req {
>  	__aligned_u64 cq_va;
>  	__aligned_u64 cq_handle;
> +	__aligned_u64 comp_mask;
> +	__u32 ncqe;
> +	__u32 dmabuf_fd;
>  };

> +	__u32 pd_id;
> +	__u32 dpi;
> +	__u32 sq_dmabuf_fd;
> +	__u32 sq_len;   /* total len including MSN area */
> +	__u32 sq_wqe_sz;
> +	__u32 sq_psn_sz;
> +	__u32 sq_npsn;
> +	__u32 rq_dmabuf_fd;

All these fds are supposed to be __s32

Jason

