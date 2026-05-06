Return-Path: <linux-rdma+bounces-20062-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNgeMcMO+2mrVwMAu9opvQ
	(envelope-from <linux-rdma+bounces-20062-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 11:49:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B134D8EBA
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 11:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 59A823024A8B
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 09:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548F53EBF33;
	Wed,  6 May 2026 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MErqLDso"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA952F3621
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 09:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060985; cv=none; b=YmUNThX71snUXgay7Ja9v4hEP8eHRT9eH7Tyze330NAoVOLLa5Oi/5NNBYnaZQyAQeioXLfClxOzmNFsHqXYjTmnEPYSUnE+t/cvqzYKTcO01dfgGURegwX5tn7+2fKzwTipB7ztf+ll8dFGeGp4pZrSZBCh48CNyTqbm5uL0I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060985; c=relaxed/simple;
	bh=3J/IYDtx28vSJ4QqQveH8g/uo9l7rKqBLsCUyGgPzIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGliTDYag2ELx7aamXBIPDUe61mndltqczqgPaofai63j5qfoX08IVnzmkO1gRZ9mpEZs8SopBEd4vw24ofMWhb/wR/TCl56ORieoqVAuJ8RW/vzo4Q8F7G97yKFhaNjkX1ScrynU8//IBZuvuCNv8Ffm1R5iArgGeN5ZMubaxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MErqLDso; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-44a786a9a35so3417352f8f.3
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 02:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778060982; x=1778665782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bnZS0xBSFdibsiuZVu6/d+lDIw/+4F1v4OqADXgc9+g=;
        b=MErqLDsoBAp5P9wqD11yao80yUNzzzc5MXKorbIXIt4OtT34lOVlA/C61j6CyBVq53
         oRRQrQhgTLRbamsZseTUufwh4vwsmV5tja37cfoIG0WMokp0T5BFoPnvg3kDIYjJD/3p
         nNplJ9WQR956APdRy4WvB+ycQWzT20cFOiNL5JcSU5f5j5J60BuakdKHrMeuVXx3wRiV
         3nDpOlZqNKoEBIg3vz2tupQvhQjyKu2VdgQHTekDyv8EQmkMaYy9MtQmusqnEvZr20OD
         OKU6tLg8K7tegWfp+9suKOyzwxTHMKgEckk0SqrIZ4g4Y+BwweUDVYs07SVBPEVQ09i/
         D0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778060982; x=1778665782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnZS0xBSFdibsiuZVu6/d+lDIw/+4F1v4OqADXgc9+g=;
        b=e+AnHLws9lxTh2rTeYWJ84VM0OrrEwUYCpUlSls6xTmoFD+KwDYAkknz1Mcgbzd22t
         judVpnareQM4mBtk+ZP1H/RIiX/dnhA9PEiitRCw1QOnwTRNByGBphbQfXM5Lhv9GZO5
         TtBlturbDoBZL2up0ghv/RcGlrUjyqu6GRQw63/6syv/YRWSZi1Y9xhAB88J5qZ0u6LG
         LpqpD+a78Gr2icEamaU0nPCkN5TDlNap8cGwIPhwJSbbk7ia9PIgEU6WrThAcj2h7dHG
         HQqk/ADYUMTMjdnEcK0ipAIL2+SQIwWxDjvKUJnSQRpdM2aLN5XdZrTd3PvvRH0ieiN9
         63Gg==
X-Forwarded-Encrypted: i=1; AFNElJ9nm35rdn689ssnsE6SRhMWXXfZ0WOtbIHrnKqJyQ6+1dBoE2JIk+q3OOvzRHRsZNPUnmaGyxhMig2B@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr405D/oFMMoqbx/G7wSQPa8/Sj5M75DEq+FFsVM0UWZD/iYr7
	2a5jTGssVPW4R0ItAALIP6QkXPaprQSu2gVz6b4rbgT84PGDpJ5bkDuk48h6ua406vY=
X-Gm-Gg: AeBDievVTSHMxZvzpY3JfjgyI0CeCVKC03I38Dq7NvQDvDc1lrdU215rLbRsFbSKr6S
	ugLA9axn8+5pLPqxDzDYqUMUUKDBHt+fbPFk9o59etXawDKPKxT6XWm9rtJ1F9z17/c6bFstqvg
	kMtYbjaJj4B7iu+mrR8o9r0nfoKmfT/If4DjBa0LKYS3uVvnAKn26FcJt21CvnxQKEksdBk1rBd
	ybSyUr8shZGmlsV8od40lFCVQWwXuBGUwO9C4JMBBwrwUjVM2043hqewRJKRQ3XF3miN0emtQh2
	pUo3YNyK9uZl8GLO+/mkas5cez3VnYwvCl7RN9nUYxWOrFoUZ1dAYd2w73Ffds0N2yq1QvYoZ57
	Niy97gl4qOPaiYBRkdsS0WQSrCkB1VZsQg1rOp/A3rMXPLI+OdGHTDEhJ9i7D48B4i30gJKs6dW
	SsXfFUreA=
X-Received: by 2002:a05:6000:3110:b0:44a:8880:ffd2 with SMTP id ffacd0b85a97d-4515b056b8fmr4429135f8f.4.1778060981421;
        Wed, 06 May 2026 02:49:41 -0700 (PDT)
Received: from ziepe.ca ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45054b02802sm11280976f8f.17.2026.05.06.02.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 02:49:40 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1wKYsu-0001ez-3r;
	Wed, 06 May 2026 06:49:40 -0300
Date: Wed, 6 May 2026 06:49:40 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jacob Moroni <jmoroni@google.com>, linux-rdma@vger.kernel.org,
	leon@kernel.org, edwards@nvidia.com, kees@kernel.org,
	parav@nvidia.com, mbloch@nvidia.com, yishaih@nvidia.com,
	lirongqing@baidu.com, huangjunxian6@hisilicon.com,
	liuy22@mails.tsinghua.edu.cn
Subject: Re: [PATCH rdma-next 2/2] RDMA/umem: block plain userspace memory
 registration under CoCo bounce
Message-ID: <afsOtEeppBzxOGUB@ziepe.ca>
References: <20260505061149.2361536-1-jiri@resnulli.us>
 <20260505061149.2361536-3-jiri@resnulli.us>
 <CAHYDg1SSkV42nfjakR1W=zu8-E7svsswxoTesXuLvpF6c5WvqA@mail.gmail.com>
 <afoUqiDgZmhE4Kog@ziepe.ca>
 <afsIsW7vKgJtdNA2@FV6GYCPJ69>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afsIsW7vKgJtdNA2@FV6GYCPJ69>
X-Rspamd-Queue-Id: 65B134D8EBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20062-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ziepe.ca:email,ziepe.ca:dkim,ziepe.ca:mid]

On Wed, May 06, 2026 at 11:25:13AM +0200, Jiri Pirko wrote:
> Tue, May 05, 2026 at 06:02:50PM +0200, jgg@ziepe.ca wrote:
> >On Tue, May 05, 2026 at 09:20:01AM -0400, Jacob Moroni wrote:
> >> Hi,
> >> 
> >> Out of curiosity, it seems like we set DMA_ATTR_REQUIRE_COHERENT, so
> >> would that have caused these registrations to fail anyway since it would
> >> be trying to use swiotlb if running in a CVM?
> >
> >It is supposed to, at least that is the intention. I think that
> >new attribute overtook Jiri's patch here?
> 
> Hmm, don't we want rather -EOPNOTSUPP instead of very wide -EIO in this
> case? I think that might be better for the user.

Yeah, I would prefer that also, it is a good enough reason for this
patch.

Jason

