Return-Path: <linux-rdma+bounces-8726-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22447A63482
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Mar 2025 08:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 199CB1891096
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Mar 2025 07:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CD218BC3B;
	Sun, 16 Mar 2025 07:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fwpvwc6u"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2391F170A26;
	Sun, 16 Mar 2025 07:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742110473; cv=none; b=qOcQk9yAjlx62hmHSnwO+pQqKLtjesoOJASKhkKF2mGxNPw/1d/MH32bUYelSCC71GW5pvM3Tl9JPDxUk3v2m5sVwQ4Fl3mXC0xlTMdfxmjKqV66Z4wZ8HAR1fV23Zhm/9/h/FsfC7yjg2ufGttTqNbkkAmbsOHINq1W+oJ7DLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742110473; c=relaxed/simple;
	bh=Z9wPWp6+P2sAIkQ+dPlfUdBxy9fqCl3k28djjN/AVTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=re6lylAIUK8NA9ex6ZFMGOkQWRGKqi95sfaRV7xCUfRBQ8BIjgU35mgFv2St7BZsm1gDt+Ar02Svo5ZNXh7G4o+feGskbsPe7M9x1vc00CsJEDftY7tQMMhwR9z2IbZPbn2bKf3HIDv/4zW3nhBbvFOpGPJ/VoOWmoMo2uTNfEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fwpvwc6u; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-224341bbc1dso62612685ad.3;
        Sun, 16 Mar 2025 00:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742110470; x=1742715270; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E+gozQzsknkpf8jQFSMMeHCraSNuUy0stS4Y3VFb4FQ=;
        b=Fwpvwc6u6Q15wd+7BnAkIgMmRpcBRFcn9wFic22sNMEMBWefqO9SSsU6/PccUIlnAr
         VpmY5DsIXjM8N6mM5v7jvncDCpQXbHIOF9zt4duTXEqoVf56xk7n9oA0nEsBQIrmPCzR
         6jFkCI6iJuYBse0oulMN7aS6yDnz/m6bx1S9Xg7ArtEMd6JsDHYal2zzT4bhEorBxfaq
         sbIa8y9KBjYg/edX+zKlKIe67EPu7eE6V7EdJETgR7BVUCBqpAjjr4p3jCz3PTMniLg1
         hpg2aWUrTsXckjEm+E2U7ZtXjkVh1cnWRTJFHf4zEffZLjkUS5dw55d8F2Ut3JXNeYb/
         eQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742110470; x=1742715270;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E+gozQzsknkpf8jQFSMMeHCraSNuUy0stS4Y3VFb4FQ=;
        b=DcOtB3FT8Wx9uC7IO57z41lZllLRO7x/hhNRJqcnyPW3w/ISOMmen4uBryl5NKpv3a
         RlMz1Xji5yK2d1KCH9iyxvl0utmnc5SZUxZ8XiMQBSTwaAI0NyCwHwQHoRPIOpPC9zqs
         KwSUv00gbl6BWFJpBNX4I+PimOGfxGLG1e1RSGMqnyo2Owursb25EIZL3la9zA+yadm5
         sHld7gZgtUrn14SJVh4Kkczb5ibiubGIPOlbgvUiCf4mBn0eKZ+i6SJafWp+PG31U6x+
         jrBx6an96ETHe/9ThtyFcAjfWb8dTR0iCIVnNjlx/mx/fc+4thaM+PIhmLHw3LHOql4S
         ts4A==
X-Forwarded-Encrypted: i=1; AJvYcCUUHxRbIgThVFILKYnnWT7aU1ckGGIgGwYxXg4UEwoEw3l0DErPxfC1q9fPhPnQmvfin18h6HKIF5Wcog==@vger.kernel.org, AJvYcCUo0M6eS9L/Y8zJ1lWQGsPGtzE1+ZDw2RtT/C0zum870LEpwbONvHLNHUCgM6WNhGTLOF6+o1iL@vger.kernel.org, AJvYcCUvbyKizCLZd0J7wWnF+J5mKvcGKL1HC8uHDDwwHOwDAv8AiyTm6ibaNvqxr1rnAGgdCZ+CkSZ8kzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLKXb+L3s4ppz8nFOemWoBpW0TZVdSFa5som6BZna6IJPBsseW
	EedqMUbuy57akCH2fiYwjtR5nbKpt2BJdujzSjY/Do1SuZwp+XU=
X-Gm-Gg: ASbGncuAn98mTRoIzeTEkQljXDD/0WUZ1G6MxeDZryznXvDeaJWTvuRdWfalsW371cW
	chv56JytnH9Ry8kD0AQqma2aJctzczD4eNcKVIR+gORyVAjW7RLLycfBBUeeV98oOoGfRbDgW0P
	K2oWL702CBntl4mu0tWErNmI6n+RIRoX4LKpephYgEk+/z7zVaF5Yt6E01qaq5BTwyn1GgsCcY5
	zEv2NralOcfTW48grTVht57fMkJr03cgGZThovpLwspZNi58xeDqHHz2/1+N2UkV6Vv6Qup6JaS
	UswRf8CoJt1Y0k49ymf4MosnAt6C67TjACmwWnyT8zSF
X-Google-Smtp-Source: AGHT+IE5vLbTjYBfblWOIuX+QWW+b07Y4rCAaXiimUw+vC72ThBiuU6sW4iz0gpXG5qpZIbbGmW3Kg==
X-Received: by 2002:a17:902:e88a:b0:224:c46:d167 with SMTP id d9443c01a7336-225e0a4fca6mr103698895ad.16.1742110470149;
        Sun, 16 Mar 2025 00:34:30 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c6bd4df4sm53754055ad.240.2025.03.16.00.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 00:34:29 -0700 (PDT)
Date: Sun, 16 Mar 2025 00:34:28 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: David Ahern <dsahern@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Saeed Mahameed <saeed@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Jakub Kicinski <kuba@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Dave Jiang <dave.jiang@intel.com>,
	Christoph Hellwig <hch@infradead.org>,
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Leonid Bloch <lbloch@nvidia.com>, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <Z9Z_BC4GBTiFsONJ@mini-arch>
References: <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
 <bcafcf60-47a8-4faf-bea3-19cf0cbc4e08@kernel.org>
 <20250305182853.GO1955273@unreal>
 <Z8i2_9G86z14KbpB@x130>
 <20250305232154.GB354511@nvidia.com>
 <6af1429e-c36a-459c-9b35-6a9f55c3b2ac@kernel.org>
 <20250311135921.GF7027@unreal>
 <4c55e1ae-8cc1-463e-b81f-2bbae4ae4eed@kernel.org>
 <Z9FjJAgdmWcepxkg@mini-arch>
 <553dff52-f61a-4f16-af4c-72d2d2c6bc3d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <553dff52-f61a-4f16-af4c-72d2d2c6bc3d@kernel.org>

On 03/14, David Ahern wrote:
> On 3/12/25 11:34 AM, Stanislav Fomichev wrote:
> >> More specifically, I do not see netdev APIs ever recognizing RDMA
> >> concepts like domains and memory regions. For us, everything is relative
> >> to a domain and a region - e.g., whether a queue is created for a netdev
> >> device or an IB QP both use the same common internal APIs.  I would
> >> prefer not to use fwctl for something so basic.
> > 
> > What specifically do you mean here by 'memory regions'? Ne
> 
> netdev queues and flows are a subset of RDMA operations, so I mean MRs
> as in:
> 
> IBV_REG_MR(3)  Libibverbs Programmer's Manual
> 
> 
> NAME
>        ibv_reg_mr, ibv_reg_mr_iova, ibv_reg_dmabuf_mr, ibv_dereg_mr -
> register or deregister a memory region (MR)
> 
> SYNOPSIS
>        #include <infiniband/verbs.h>
> 
>        struct ibv_mr *ibv_reg_mr(struct ibv_pd *pd, void *addr,
>                                  size_t length, int access);
> 
>        struct ibv_mr *ibv_reg_mr_iova(struct ibv_pd *pd, void *addr,
>                                       size_t length, uint64_t hca_va,
>                                       int access);
> 
>        struct ibv_mr *ibv_reg_dmabuf_mr(struct ibv_pd *pd, uint64_t offset,
>                                         size_t length, uint64_t iova,
>                                         int fd, int access);
> 
>        int ibv_dereg_mr(struct ibv_mr *mr);
> 
> DESCRIPTION
>        ibv_reg_mr() registers a memory region (MR) associated with the
> protection domain pd.  The MR's starting address is addr and its size is
> length.  The argument access describes the desired mem‐
>        ory protection attributes; it is either 0 or the bitwise OR of
> one or more of the following flags:
> 
> ...

Sure, and netdev has:

    -
      name: bind-rx
      doc: Bind dmabuf to netdev
      attribute-set: dmabuf
      flags: [ admin-perm ]
      do:
        request:
          attributes:
            - ifindex
            - fd
            - queues
        reply:
          attributes:
            - id

Which accepts dmabuf fd. Looks very similar to ibv_reg_dmabuf_mr to me.
And I think we can safely ignore ibv_reg_mr_iova which needs things
like proprietary nvidia-peermem to function.

My point is: I don't think netdev is as opposed to memory regions as
you think it is. As long as you come up with sensible new UAPI and
as long as everything is in the open, it's up for discussion.

