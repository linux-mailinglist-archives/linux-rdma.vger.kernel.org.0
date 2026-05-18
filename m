Return-Path: <linux-rdma+bounces-20912-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yL3OAEIxC2oZEgUAu9opvQ
	(envelope-from <linux-rdma+bounces-20912-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 17:33:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AFD570086
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 17:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16DBB3046504
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 15:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DED937E2F7;
	Mon, 18 May 2026 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="SZJL2Qrw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B89137EFFD
	for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118072; cv=none; b=B9ohfdWFD8JtJwKIWQq/jKwB9XBVTY7FiS1IxdXXiWRn8KtNgJUl+dUFGHb1CTSqNMHwsfdowFlNd6aMxEhE+yHa4nVtyLSgjtFs1jHLftkbFdoHkMAHUSYdhbLK8uTsCHkU90LlDiH7rbDBrSs7adLapzk2yeTpdbGp31ciJNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118072; c=relaxed/simple;
	bh=YzZiZvWgihco+n7g2MLQYBBVCjH+6tLhbUm7+CnNsAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhqIaHdEVsHV/YQwGFJ3IzgcNqM8zBLuqRp7Gsn5XYTstvmtdELLWeR7NovhzLMTQ/eS/xhAWd4v6iT0QGssR3z4ENlJrglH+MEDCJiBSExiRWNByuEeVxXHm1t6yihCFNkITDeYOU74dMuO+bT7J0zWoy14b0AlbQoImGiMM10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=SZJL2Qrw; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so2087018f8f.2
        for <linux-rdma@vger.kernel.org>; Mon, 18 May 2026 08:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779118065; x=1779722865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iwi0S40Msnl4m6DzSeTZ6ftvMS4fxMcOkpbHCcupllI=;
        b=SZJL2Qrw/rIbw8yxGgrDe9Xm1h74EUHGGinIJbp61nWltp2ZFbz/J3SMFyBT6P//J7
         XKFyYxbIZ8dWptN6PQjNmnE+xi7L+odxGVowfSLYoDoyEOCsf4GS9jxPjfl2sffqFgZT
         TaasKcAylcvhsVXwa4f0Smc2JhaXtE9f0Wd05IiBYE18ln4+m5SrLc9RHiIm6mtfj0qP
         drFifdYibi0Ao6z0HNka/d1GZf3XKxBozICbI80Kw/H0lHq1UF2Yd7WL9LZPqdLsSlxd
         MilJFLlV4v5ut9NWpPGP4Lti/JL3pWFKw11eqp3frVnhN5uTFklGSQINnueU+wG2zhvD
         uG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779118065; x=1779722865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iwi0S40Msnl4m6DzSeTZ6ftvMS4fxMcOkpbHCcupllI=;
        b=V1s3zvMoo+IzArR9aPhW5X67Kf/NVP9SQf0iqYPkeNVmcrhnqLCFx235WXdW0jy1Rj
         QyfQmEUOnysTTVXUQ+CN4JafEe+TGVTwY8GDSkTtgFYj2FkzIzxCnPdADCyN9NBqX9jo
         zf3AwUKnb8QSolQGknEkqbtd6e0FJBog3cjKTzWAAiR0eOsd0N/nvEXDlyh+tK8IaUb/
         +tRufzYlwa6SH/MBRZixlvpeRO0Oy2QERCIfgLg2yQGJo2qOxFEYKV5SHaSICfhQtAQI
         OC0NViaW2+e3pvCQVxvWv+lr1g8SgAbykiTbS4yndaLf5eI7rqknp5UTGJTLG7RoTKHe
         Z7Zg==
X-Gm-Message-State: AOJu0Yz8sgcjF7qamVvYDlCB6IjC5TLea+FJuPCeo3iVJRWO9DkguNLF
	b7UfSNmxwTkIkxkLeeYy1BlTahEJhuKNC4dICiJMNgi6tqDLM25OF1D+jiSbkD40YVg=
X-Gm-Gg: Acq92OEgcxXdbHdrh8bv8QLf3mDCd0Ej4goE2/2miPtSGuHMBa+SKaVcwHEgoWAICXu
	jHJQr45Xo3Jd5venRf3eqd4H6+Tk6JQb4kiNRBMR4yCP12+xDL20Zg2ZpQzA2GfyvJIvOx9+aRW
	CH+SY3h369TCcNnkecu0kiSVmbpSoOx+pO88GBbo0X9/TAoiGXqfRVAD8ps/Ym/QhEjhlmNT61C
	BFJIpHGsGCO84eAE2eT3tP6BtD/VC1Q35DRnMTqBTaaf+tQArtpcWwyS2vmLN5rXfpzlaaDXCD4
	l1I5ps4w9DL/JFsTZLj2NtUiihfuUdLYtT1oeng+RaJdGl8FBZmmIddVv51PIErkf6yAJK9X2Ow
	wSAWQ5XQLhwbs5BGDBbJZ5GiF21kIrrmZN/hr7LYe5EbFPX8zStHdoJQnIJzlu/HH8fMKvl6eu6
	psH/22QmAmEa8P2/cmzW696tA4JhOh9vhwoZk=
X-Received: by 2002:a5d:52cb:0:b0:45e:655d:6f7 with SMTP id ffacd0b85a97d-45e655d0715mr14412831f8f.24.1779118064693;
        Mon, 18 May 2026 08:27:44 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a17ec2sm35275039f8f.24.2026.05.18.08.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:27:44 -0700 (PDT)
Date: Mon, 18 May 2026 17:27:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jacob Moroni <jmoroni@google.com>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, leon@kernel.org, 
	mrgolin@amazon.com, gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, 
	mbloch@nvidia.com, yanjun.zhu@linux.dev, marco.crivellari@suse.com, 
	roman.gushchin@linux.dev, phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com
Subject: Re: [PATCH rdma-next v5 03/15] RDMA/core: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <agsv3fAVpqFdX52y@FV6GYCPJ69>
References: <20260517063006.2200680-1-jiri@resnulli.us>
 <20260517063006.2200680-4-jiri@resnulli.us>
 <CAHYDg1RXDuB91xDUW9cURq3hWfYeWabrBNKfXEZm6aHVbQi+9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHYDg1RXDuB91xDUW9cURq3hWfYeWabrBNKfXEZm6aHVbQi+9g@mail.gmail.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20912-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,resnulli-us.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 22AFD570086
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mon, May 18, 2026 at 03:04:06PM +0200, jmoroni@google.com wrote:
>Hi,
>
>> +struct ib_umem *ib_umem_get_desc(struct ib_device *device,
>> +                                const struct ib_uverbs_buffer_desc *desc,
>> +                                int access)
>> +{
>> +       struct ib_umem_dmabuf *umem_dmabuf;
>> +
>> +       if (desc->reserved[0] || desc->reserved[1])
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       switch (desc->type) {
>> +       case IB_UVERBS_BUFFER_TYPE_DMABUF:
>> +               umem_dmabuf = ib_umem_dmabuf_get_pinned(device, desc->addr,
>> +                                                       desc->length, desc->fd,
>> +                                                       access);
>
>This all looks good to me. Just thinking out loud...
>
>Is there a longer term plan to handle revocable dmabufs on this path and
>get rid of the separate ib_umem_dmabuf_get methods?

Out of scope now.

