Return-Path: <linux-rdma+bounces-16374-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBqANlPugGleCAMAu9opvQ
	(envelope-from <linux-rdma+bounces-16374-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 19:34:59 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6EBD0382
	for <lists+linux-rdma@lfdr.de>; Mon, 02 Feb 2026 19:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E8A5D302C671
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 18:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E392EBB8C;
	Mon,  2 Feb 2026 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="S8f+jywS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8984E227599
	for <linux-rdma@vger.kernel.org>; Mon,  2 Feb 2026 18:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770057296; cv=none; b=M9oHC7dk6iB6xmWh2E3nx8gqe1Wr5JSSKjJnaLWPOFa3AGOaC5hT4IP9BcIJS00gpieHTcXDOITV5UvhJFdB38WE3FHF2ALKqdAIKVHq7LSQKAIcxqFcKYZrgExSnQVnownGTjnf0+RYAdtTGuXU40pIyx9j75/IfQM5fSBJmJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770057296; c=relaxed/simple;
	bh=l9ErNXT8ec8wSJsrq6SYKaRVJtqmbETUB2gTWnbSHd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ge00TWBcaVZS/MPnS/7LGrdq4RRd8IbfxrmqBrAIPwOWbCIiyaan+jJ9uYgrE/zRFzvb3xdvUJRxTpVjCBWC5tSk7Ej9a3OFjpNRrYvr3K1xLMPCuHsXJoT3Uj3qGsb9PmPZrlBtl4S8dHCVcd8VX/uoEWFIBx3YcAPS2FOkJYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=S8f+jywS; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8947ddce09fso38711616d6.3
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 10:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770057290; x=1770662090; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cp9VCP5djjagohRUmjr2kM6K3uacbBUgjh1Q16sYjUI=;
        b=S8f+jywS76tayLtSj42WKZFh0xQJQPo8ClPzHoEss3ATryjI1vI0FBblCHC0LCOCIM
         Gqaiu//Zuq0H8qcDunA3VSRGi8aQlYxKev/4Sj9nXgYD8YKCWl3d7O/OpXpDHW2EZItO
         ijPCYKrG6StOrR1e/Ep3CZzTGv1twKTUESlndRXYiEK06o9LIJL+pZ1sgdQNWtV0aqeb
         n4jX+BD7BSQPAieV7dqICZQMbQrZb7OluXfJOxi/q94LmwYVisU97Ue/dht19o/Ci0YB
         OcyjPgOWaFBqMAyV5JmHPK8yMY+6Xh8FqPwHpwpFuUBb/JLHubN5puVJM716+4253GCI
         vI1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770057290; x=1770662090;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cp9VCP5djjagohRUmjr2kM6K3uacbBUgjh1Q16sYjUI=;
        b=Qs1H5dXv6QDfj7fo+RAfcbF5WX1HQFwOJpiaksYbj8Z8TwzEGj13LtBGEG8oQpW/r5
         sscrArhmSBX4dtgfDx9EsnHShzGPMSHDDJWT2o0K+8PMTAAiy7Xbgb8dtNx89rmDDDhh
         h3fuHf/pJoIranp86+23lhTAk7mh5LVE/QEVr+nKKDM+IKRR5drxgeqgdnvLRJ7uCrLT
         4GIVkOlA+jYx4hG5ZKkpp0KLo1T2WSkeuKdyqGTljEFADKliOgewUeN2ZZc7hZ8EIKK1
         nzVD/1THRVM03EVIsV7cL5QXey6lRUDJ2JuRdbFaOVyd/VFA8tnyC9GXMNISzlac4HcJ
         A4ow==
X-Forwarded-Encrypted: i=1; AJvYcCUketRgCm+FacP6YjbScn4HJjVaTTVDgtTwak1ma2E1BbqSmbGxtdveLw7SZF1qzzW3K6e3zkqzpCkh@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6YmVcVbe+L0LnUGMdZRo1CJUPPVUklH62/qlfWCGRQPw09oWB
	ut1I0bt7yCNSnYDY3vAl44xWVVzcOjeYa8XkUgSRX6/5l6m0RM+SJolc86+w41msdX8=
X-Gm-Gg: AZuq6aIczfBh6mKBvk3Fr4cFNtjN6CI1Ue5UcPWbwKCTbwK5wInPZ0x/JS9FvS7nE0B
	7dgrfhV9eDzum47HVjmdsNJ0tw2LzXfiwgwPkD51TM+GutEkRWiyfFh6tTPPFQWGrBEkgcLPChT
	8slKJTa5m8E2A4XWXMhY/pObFEfom0+rEj/M5U7+wqpryJSfShb2oZRGv7t4FJV08XfoBuUYbyd
	YmiKh78+v9wh6qUZIwYEs9W9VYH4aWoxZRz2TV4ZmbtoPJHN4LdepO3Re+67YXsVTX+8ay9lURV
	kaPWzCdUi97aj/LMFSlUGwzB5A0nUQWKYmcQdLTr30CVmBSGfc1tX3QTHSA16CYeOd0TGtysUz1
	GVfA04ZsGXilORipjAEwR4o+4xdj4vMyZp87YR7KAi6q9P6Kb1D+OBSqX7XJ1wDp5vfVMWNIPUL
	9A3TnAfGUndVNl5Ptb2XieBqH/ExbITWDlfeOsw0pTNtVo5rxXegpfgadMKBFk87FJErU=
X-Received: by 2002:a05:6214:c89:b0:880:48bc:e08f with SMTP id 6a1803df08f44-894ea03b250mr186589746d6.40.1770057290149;
        Mon, 02 Feb 2026 10:34:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d376da66sm120159546d6.50.2026.02.02.10.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 10:34:49 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vmyl7-0000000GK2F-0LHy;
	Mon, 02 Feb 2026 14:34:49 -0400
Date: Mon, 2 Feb 2026 14:34:49 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: YunJe Shin <yjshin0438@gmail.com>
Cc: ioerts@kookmin.ac.kr, joonkyoj@yonsei.ac.kr, leon@kernel.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH] RDMA/umad: Reject negative data_len in ib_umad_write
Message-ID: <20260202183449.GL2328995@ziepe.ca>
References: <CAMX6_QHrodOD1KD6qtK2A=tHOocrpSWJh7VTSYR+fMiHRgsktQ@mail.gmail.com>
 <20260131140954.89165-1-ioerts@kookmin.ac.kr>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131140954.89165-1-ioerts@kookmin.ac.kr>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16374-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kookmin.ac.kr:email]
X-Rspamd-Queue-Id: 3B6EBD0382
X-Rspamd-Action: no action

On Sat, Jan 31, 2026 at 11:09:14PM +0900, YunJe Shin wrote:
> ib_umad_write computes data_len from user-controlled count and the
> MAD header sizes. With a mismatched user MAD header size and RMPP
> header length, data_len can become negative and reach ib_create_send_mad().
> This can make the padding calculation exceed the segment size and trigger
> an out-of-bounds memset in alloc_send_rmpp_list().
> 
> Add an explicit check to reject negative data_len before creating the
> send buffer.
> 
> KASAN splat:
> [  211.363464] BUG: KASAN: slab-out-of-bounds in ib_create_send_mad+0xa01/0x11b0
> [  211.364077] Write of size 220 at addr ffff88800c3fa1f8 by task spray_thread/102
> [  211.365867] ib_create_send_mad+0xa01/0x11b0
> [  211.365887] ib_umad_write+0x853/0x1c80
> 
> Fixes: 2be8e3ee8efd ("IB/umad: Add P_Key index support")
> Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>
> ---
>  drivers/infiniband/core/user_mad.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/infiniband/core/user_mad.c b/drivers/infiniband/core/user_mad.c
> index fd67fc9fe85a..db1643aab029 100644
> --- a/drivers/infiniband/core/user_mad.c
> +++ b/drivers/infiniband/core/user_mad.c
> @@ -588,7 +588,15 @@ static ssize_t ib_umad_write(struct file *filp, const char __user *buf,
>  	}
>  
>  	base_version = ((struct ib_mad_hdr *)&packet->mad.data)->base_version;
> +	if (count < hdr_size(file) + hdr_len) {
> +		ret = -EINVAL;
> +		goto err_ah;
> +	}
>  	data_len = count - hdr_size(file) - hdr_len;
> +	if (data_len < 0) {
> +		ret = -EINVAL;
> +		goto err_ah;
> +	}

data_len should also be a size_t to prevent truncation of count.

But I think I would prefer to replace both of these 'ifs' with a
simple check_sub_overflow() after making data_len unsigned.

Jason

