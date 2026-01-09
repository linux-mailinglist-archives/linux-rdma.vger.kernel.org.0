Return-Path: <linux-rdma+bounces-15415-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 001CAD0C037
	for <lists+linux-rdma@lfdr.de>; Fri, 09 Jan 2026 20:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DDCC63007222
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jan 2026 19:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C742E03F1;
	Fri,  9 Jan 2026 19:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="UVSqblXx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51EB26E6F9
	for <linux-rdma@vger.kernel.org>; Fri,  9 Jan 2026 19:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767985741; cv=none; b=KGE0T8dCLjZnGmvUKS5j2sECkVUQEo6mwrrRu7RVASpwOwxjvr71R871n/39DotJVaBxcdLozt6UpFzsVVZ5KfPnRCcQZUs/xARiGbJOIxa+dLhPP0OMy7zNBqP9qdmWCKm0fWnfpBbJ3YB42UMhC5lNadNNOzPm8ZEtJhcNvfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767985741; c=relaxed/simple;
	bh=9dyPRmIRdah89JELXpFg2+CjCOgKLTot2HQGlVcM8Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIRcCrVSWOUnIOXncybijM3CQsFopon67Kuvqst/DfwTpAzO7AQsI2z5XSJakxB2hTDjugOra7Xeq4CTgATMqGrfH8fIW5XsSxRwC3DD8YJ0eXRBcbwtNUjEBVSbz017+mW1ZImZ52HqJFNadsv54vtM0f/vDEVREZ8kM4HDMiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=UVSqblXx; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4f34c5f2f98so48342371cf.1
        for <linux-rdma@vger.kernel.org>; Fri, 09 Jan 2026 11:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1767985739; x=1768590539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x6kcBFkRhTotIYeESiavxLdDn0ZiJYQi3FHWS9QjHfs=;
        b=UVSqblXxpsVmLeOUEPoLNx4J8OxQuJzGNwod8XUui+3nWk7OLhsgxYKIgbbCONyHJO
         C+ecJwKCi/qy/e97V2aDHK4crBeFIO2qOziMi1/Gx38braJwbzTd6Uo8X+j7hmUyMH2m
         36R+hyYmktyiNu6/rClSi4Dmpkp3AbhVexWN+PeUEmV65W36oAWUfbss9gRnvb2gFGY9
         mvK8854UdrUfCE7Ggdiq8DMfKQtIKsoRp+Ealq3hllGQN0AfCOVpimPkOYPM8izEIC1Y
         b6bgU61af60amTxiZx2hY8EaP5fAOtLDW/dZ8EwSyHJrsfEiAbtqfh3+xxX/GRACeEKi
         Ziew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767985739; x=1768590539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6kcBFkRhTotIYeESiavxLdDn0ZiJYQi3FHWS9QjHfs=;
        b=R1HhGPAsVG0cDWmCUFe/xV1tFslJKTEFGauJAiBocXLRoL6VSVKsIy3DQs6zktv7h6
         8SZaDFAkhvXDL+aJpVpMTrmUjpUyAUKiYIUAwzh3kAxphqaCeeFif62Fbu/fZydiEXsm
         zwDMgiCU24CXZ2UEddfEBg/O9PBRo2cT+8nKU8y4Gug80BKdut1sz7aWz+vheX+ZSzRn
         Tj0bLdFSwomlNm00iI6EwKWpUhq4TbE/goh/QP+MxS7NpjqfftD8O4WAovXu+dBiewpm
         SD6KFPTcDcVct7/m212Rd+0MT/cJkaWbd0lt5ezyyBBgVKWrH1F9Hs3w0TnAth53LuJ2
         OhZg==
X-Forwarded-Encrypted: i=1; AJvYcCVGQJCMRzeSr1ehXqNkJrKjxe9q/uhsHSG2VQKnGze3w2eIr3ntCTXoGt4RHWIMK0MaGo3cxe1xt/zs@vger.kernel.org
X-Gm-Message-State: AOJu0YzUyYs/BygeZeeuBiIzbIH2zIEENTAE5Sizyhy+MJSDBAw0t2nu
	+a6EefefmHSrG1y0sZo4vVC3POfD3L2QR7hq1quRLm37Dp2XyqR9IpGwPm5h54zRFsHYyucSix8
	a1Xg/
X-Gm-Gg: AY/fxX5Mfv3RKb9GndAw04JMlxkr8JCbe98n/Dn2DIJbgsCjk6gGKo5Il2PUo22kyQs
	Xg1bx/mR2UqgELsh1d51cI5Ow8J80nPKM1KxLmKQp5KrGJ3s8Dh4wKCEb2lGFmr+NAVqilU+Pxf
	iRrE3jWSDZV+VZpbrzQ5cV7kn37b/w2RAB3NwW4ZeMn2ifVBZ+5V077bsuE2DIXLFwnhyx8ZPVQ
	+dXq1XENx8IPgATY0jeWLvtTQPY9erBLb8sEv1ZliW0VqCGvWtl5fz0Cgw3hYJOT+9EZJe4+h3Y
	GwM2Q3L7v7ij6QzzbDmqWhfVvvnk4l6t/B1ZsnG9qLAKAn+DqA7CvvbwBiv0YBCC4if7x/mGQn2
	UYPJJmU3NtPgSMQR+xKkntknE5yO6kdWVel2MnnxQojIuce64xUJk6MTww+KL6F8cbhrZE3sUbt
	o+EdEMdPf7TB+krLdmA0G4JrBlo/AaHyjU3lngsWfJ2rp7kXVDEf5EWI72ESRy7wkjdUs=
X-Google-Smtp-Source: AGHT+IFI8NMgxbkFStHKPENizvXhVI+W9630oiHhfSF9FDj5BxJVA2fVbcg8K5Olse+lfYKep8bvvg==
X-Received: by 2002:ac8:5f48:0:b0:4ee:13d0:d02b with SMTP id d75a77b69052e-4ffb49e62f6mr148207481cf.50.1767985738648;
        Fri, 09 Jan 2026 11:08:58 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770e2833sm77752966d6.18.2026.01.09.11.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 11:08:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1veHqz-000000037l9-2r82;
	Fri, 09 Jan 2026 15:08:57 -0400
Date: Fri, 9 Jan 2026 15:08:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v6 4/4] RDMA/bnxt_re: Direct Verbs: Support CQ
 and QP verbs
Message-ID: <20260109190857.GO545276@ziepe.ca>
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
> +static struct ib_umem *bnxt_re_dv_umem_get(struct bnxt_re_dev *rdev,
> +					   struct ib_ucontext *ib_uctx,
> +					   int dmabuf_fd,
> +					   u64 addr, u64 size,
> +					   struct bnxt_qplib_sg_info *sg)
> +{
> +	int access = IB_ACCESS_LOCAL_WRITE;
> +	struct ib_umem *umem;
> +	int umem_pgs, rc;
> +
> +	if (dmabuf_fd) {
> +		struct ib_umem_dmabuf *umem_dmabuf;
> +
> +		umem_dmabuf = ib_umem_dmabuf_get_pinned(&rdev->ibdev, addr, size,
> +							dmabuf_fd, access);
> +		if (IS_ERR(umem_dmabuf)) {
> +			rc = PTR_ERR(umem_dmabuf);
> +			goto umem_err;
> +		}
> +		umem = &umem_dmabuf->umem;
> +	} else {
> +		umem = ib_umem_get(&rdev->ibdev, addr, size, access);
> +		if (IS_ERR(umem)) {
> +			rc = PTR_ERR(umem);
> +			goto umem_err;
> +		}
> +	}
> +
> +	umem_pgs = ib_umem_num_dma_blocks(umem, PAGE_SIZE);

I should never see PAGE_SIZE passed to dma_blocks, and you can't call
dma_blocks without previously calling ib_umem_find_best_pgsz() to
validate that the umem is compatible.

I assume you want to use SZ_4K here, as any sizing of the umem should
be derived from absolute hardware capability, never PAGE_SIZE.

Jason

