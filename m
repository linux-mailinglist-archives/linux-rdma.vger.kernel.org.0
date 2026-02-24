Return-Path: <linux-rdma+bounces-17130-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKRFMzDznWk2SwQAu9opvQ
	(envelope-from <linux-rdma+bounces-17130-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 19:51:28 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 285ED18B932
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 19:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 78B7A30500D1
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 18:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ED72D94B4;
	Tue, 24 Feb 2026 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jkgKJrDN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253D62D8390
	for <linux-rdma@vger.kernel.org>; Tue, 24 Feb 2026 18:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959070; cv=none; b=naET7eBeamcLS6kaCrpDdYJSV17NSfH+3qefCLk2R/O2UpXk5wngMbo8Fw0i/h4pelsO7AMlqzeVFo2ptnUGquxUwMduMZvTcdf95jQDBsj0cJhLN3PFdEulYmajNqe3SkQjLgqYC5XmWWFAQr+4f508VINqZKdfGozlFdWvkrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959070; c=relaxed/simple;
	bh=N4R7PlpF+qvcKT8kPjQ0j7aKggaMAVaoMoQITX6NQEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EhBIPcrE4pOrzEJowaLbvF89B3o+zu9obbtBndhdUbG3/OzbJfdUALZFr9FH5EPVufHS5vdb9ZETAyeaybHMVOL9LF/anIiAcXNkyWd3osHUkHgN3N7YbZNYwLymOMIQNbrLjfVtWIMh6FLUXXNrcN5Oi2op4uhOEXwQWkt0rf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jkgKJrDN; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8c7199e7f79so777643585a.0
        for <linux-rdma@vger.kernel.org>; Tue, 24 Feb 2026 10:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1771959068; x=1772563868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oYSMz+pRTJ6JtUNzvYiYiaV1icMz9L+z595VjX3LHSE=;
        b=jkgKJrDNkw/SrASpydg8Tox8asPMuVCovHJI0pMBNv2m9EeeVk6JT1ff52KGIx2ViS
         NYHMEcxwdDkNvq77Dx4Mn5dv4Q3QUUxhVCPe9FxWuNtUnU4eXxLlH8V8FggUVHxX5BQn
         cNLIrSSzCAlXjppzfYzhb8nxTgnaacI6EDyclzyQnb/Xap7BaBox3IYCP1DXIz1d39ZW
         SAuBBWz1HzHq9NHm05DJxeRBGp+qu27OPmrj5vMMsNt2boUXzPldZxDpKhzlCxM6jiW4
         oPBnwYkCA7V4wEQxAg+e1nRTuHxYiWtaYK6N4P4iw7TYCBFHveedp5Mt6/zKQYWL9b6/
         dTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959068; x=1772563868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYSMz+pRTJ6JtUNzvYiYiaV1icMz9L+z595VjX3LHSE=;
        b=ARfxReqgEcV+qPx3dtqq+VXYUvJoCydpuXN+830vUrBRRdaLeFXVqq58BcLxpNrnHq
         eQgcjNIfiuX6/j59CAnpuafKQNVinByDPnX7Ce2mgrN4KqnEcn8Sx1F3Geciafdp5MlA
         NOZeoaU8sJFTMGC+g0IAGnEcSKqGQV9XHmCoP3l4JDKKZ6UE2ftZCd3td8ru9212aIdz
         NCtIjKb4OiG5JYfoYl4PRZegq7S3fOx7rtjtTm0+gKBdgaru32W/eQ9X7H4iHFhbVLp9
         4iiIRNoKuErro4ETX37sS6z7MLJLsSnvZ4PxZkz4BNM761LOL6vbbXXGQYBXIRW4fsRJ
         orCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXj/A9778/ylhXmZVMXNOJ6VU7zZRTSbhEVj8lObMqE3dNgRT5P3EakploP0ZOI2S8yjA1hxuBeL5gP@vger.kernel.org
X-Gm-Message-State: AOJu0YwvInhDfBtEEckSkply9KCZho40nAfVbYOxjsyd+hwCBOY8LFEd
	PX5DG/yRQfWrpJHTd0jBTShIyPgSoqendCS4IAuI9wbU6l8B80X3UfK1aaY6OD6uy5M=
X-Gm-Gg: AZuq6aJ0CQnRwIvLrttstGPp3T8RQrzTkKDjcJMqdFiVnOwMt7kYScb15k0S2QlLCUi
	XhvZP/bPfi3vyJz9vZa1QqalIn3TG8fhXGYCpFbYDYYxx+GkWBLqbAXXly4Lrigf5BaTan62PZV
	eNDRvcBX/i2ydYZhj+tzYjjwAYI8KYS/NgD7PCumC9pfzi4pHG0FLMu1NC7SPmWrKUpJLqWWgXc
	Ch5MNtrcEfhcAo2QTUFlR+1M1OTaWgCmU4GbNM5B0ROeUI5uewH+45wTooWBDuzgT5YvghAuplm
	EMdPTkf6CAggVPm5pTzVJTo8eJVxU/taU9C5ye1aJ5VSk6m9Jd7dK2T9d4N/Zz7lMJFdFFcuLEn
	ZiGPvQvKhGVqJjKNVunXmVnFFAJKTeXangyeLHrOOvYKvmE4cTtj5tYyJAtVkdHhEEPTGG2fZHe
	0=
X-Received: by 2002:a05:620a:199c:b0:8c6:e1ff:8cfa with SMTP id af79cd13be357-8cb8ca761d4mr1605433785a.60.1771959067924;
        Tue, 24 Feb 2026 10:51:07 -0800 (PST)
Received: from ziepe.ca ([173.231.112.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e62ffdbsm110682236d6.43.2026.02.24.10.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 10:51:07 -0800 (PST)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1vuxUw-00096z-QH;
	Tue, 24 Feb 2026 14:51:06 -0400
Date: Tue, 24 Feb 2026 14:51:06 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Moroni <jmoroni@google.com>
Cc: tatyana.e.nikolova@intel.com, krzysztof.czurylo@intel.com,
	leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC 2/2] RDMA/irdma: Add pinned revocable dmabuf support
Message-ID: <aZ3zGrWl19jrlL+w@ziepe.ca>
References: <20260223195333.438492-1-jmoroni@google.com>
 <20260223195333.438492-2-jmoroni@google.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223195333.438492-2-jmoroni@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17130-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim]
X-Rspamd-Queue-Id: 285ED18B932
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 07:53:33PM +0000, Jacob Moroni wrote:

> +static void irdma_umem_dmabuf_revoke(void *priv)
> +{
> +	struct irdma_mr *iwmr = priv;
> +	int err;
> +
> +	iwmr->revoked = true;
> +
> +	if (!iwmr->is_hwreg)
> +		return;
> +
> +	/* Invalidate the key in hardware. This does not actually release the
> +	 * key for potential reuse - that only occurs when the region is fully
> +	 * deregistered.
> +	 */
> +	err = irdma_hwdereg_mr(&iwmr->ibmr);
> +	if (err) {
> +		struct irdma_device *iwdev = to_iwdev(iwmr->ibmr.device);
> +
> +		ibdev_err(&iwdev->ibdev, "dmabuf mr invalidate failed %d", err);
> +		if (!iwdev->rf->reset) {
> +			iwdev->rf->reset = true;
> +			iwdev->rf->gen_ops.request_reset(iwdev->rf);
> +		}
> +	}
> +}
> +
>  static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
>  					      u64 len, u64 virt,
>  					      int fd, int access,
> @@ -3607,31 +3627,45 @@ static struct ib_mr *irdma_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
>  	if (len > iwdev->rf->sc_dev.hw_attrs.max_mr_size)
>  		return ERR_PTR(-EINVAL);
>  
> -	umem_dmabuf = ib_umem_dmabuf_get_pinned(pd->device, start, len, fd, access);
> +	iwmr = kzalloc_obj(*iwmr);
> +	if (!iwmr)
> +		return ERR_PTR(-ENOMEM);
> +
> +	umem_dmabuf =
> +		ib_umem_dmabuf_get_pinned_revocable(pd->device, start, len, fd,
> +						    access,
> +						    irdma_umem_dmabuf_revoke,
> +						    iwmr);
>  	if (IS_ERR(umem_dmabuf)) {
>  		ibdev_dbg(&iwdev->ibdev, "Failed to get dmabuf umem[%pe]\n",
>  			  umem_dmabuf);
> +		kfree(iwmr);
>  		return ERR_CAST(umem_dmabuf);
>  	}
>  
> -	iwmr = irdma_alloc_iwmr(&umem_dmabuf->umem, pd, virt, IRDMA_MEMREG_TYPE_MEM);
> -	if (IS_ERR(iwmr)) {
> -		err = PTR_ERR(iwmr);
> +	err = irdma_init_iwmr(iwmr, &umem_dmabuf->umem, pd, virt,
> +			      IRDMA_MEMREG_TYPE_MEM);

Is it OK to call irdma_hwdereg_mr() before this? Seems really sketchy

I think if revoke is being used you have to use a protocol where the
dmabuf reservation lock is left held for the caller to complete setup
so you don't have revoke races.

I guess this is some ib_umem_dmabuf_get_pinned_revocable_and_lock()
pattern

Maybe it can be some two step process:

 ib_umem_dmabuf_get_pinned_locked()

 [..]
 ib_umem_dmabuf_set_pinned_revocable()

 dma_buf__resv_unlock()


?

Then you don't need to restructure all the iwmr allocation (which
should be a seperated patch too)

Jason

