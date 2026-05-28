Return-Path: <linux-rdma+bounces-21429-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAgxOjY/GGqYhwgAu9opvQ
	(envelope-from <linux-rdma+bounces-21429-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 15:12:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2164E5F2847
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 15:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4192A303C40B
	for <lists+linux-rdma@lfdr.de>; Thu, 28 May 2026 13:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E223F076C;
	Thu, 28 May 2026 13:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="REzMQW8Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A224D3ED5AC
	for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 13:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779973603; cv=none; b=emc+dlnXtcr5OpQmSwT5TIPZvEvKdx71s+HOaC57CF4aD0s2vVIGPxJU+RTluJvuj+SPO3TQRKA3sV94aYsxeIE0eiaHJYUvwf25cHw9wsWM3tE0QEXPkXwfDIcWozob1SnQLyS7mKPKDFOJgHdxj985M99sEWQ9XkoC6OehUD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779973603; c=relaxed/simple;
	bh=EVMAHBzmwVNzuN8NRvrR3HL+Ky0voNFzcnIJSc7zPcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+eFw5h9fX1005ppNP2s2QHJFZQ7K4wv6jGCSrHjs/tOwvPQeIIatn62F+MWoODuTK7ZimT/8zJuDptKiFe9QVsS2OE6wtR9QKmTH24DBnJtxzR/jG3AXfUQH+50RxhXj3fTdQ1dbOatp/CkknHAwJgkTZEkBPA2VMNoM3DO2cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=REzMQW8Q; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-49041fb8c23so51287675e9.0
        for <linux-rdma@vger.kernel.org>; Thu, 28 May 2026 06:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1779973597; x=1780578397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YUVgLtNUZhANR9YPIRAn7XxJdXMU2tQfmP3o5fGQI5g=;
        b=REzMQW8Q2l05dM/frG1L8z7RVWXHiyCpiaTrRXFzRa+DSOo38ufIKbYK9LKXwocqhv
         EqMhh9Z2uS/DLzZbtGUuiuLzrsrH+dSj1cipLa3WJ0oo+sLC2mUsYxTdzK00x7KOqtdA
         wWqMVDlQhbmKQBYi6WvQ7mg5XkRShpGLziNyBCcpYqs5+d0bQ56nXw8+8lctqrVlVvXm
         q6FtloCZsqhrbuj3zUevI60AQFfDAMJJCUxZ75PwGCkkJj8DmLcZIrRVaycvoKblVzPx
         EoXbnLrn7PMsx7rjQRSP9duU4BZGAaz60pRK3PWZUIiy9lYfz8/S3eu09HF5sFn56VFf
         FNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779973597; x=1780578397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUVgLtNUZhANR9YPIRAn7XxJdXMU2tQfmP3o5fGQI5g=;
        b=Qm0SnxZGw//fzU7doSBk58A8/9rWoLtB3dvZs8iqy+qx1JPGyThMf7sI+hk+b291/y
         T/uF2afeIzQkETNI6DgbEswnuhko9VZRBppBCArElMEwzPV5b/ZOSC8aOF6WIcOwrAXc
         ZAF0bhhy9Cg9mj4Q9NyHMdX5bUcvDzZNnKVDHCA5Hzc4vJcJNo/Wt+gSQ9AvVXpoGSQk
         l9JC3VfudTrK+tNtJ29eyHijem4tW9ttfgSpzIGO1DfDEs8AESkMl1aMjcCCIjj9cP4V
         6WykB/Dt8npvseZrTDyzL+TdGhpm+xA4+qALty/SSKUn1Nrcry9+3yPNYT/vUw/ddMdW
         dmEA==
X-Gm-Message-State: AOJu0YyB46iFaNCd8Go5TKTTBJ0lnDS0A7nX3AkVMMhkxvYOCwtCfgO2
	bXOVE1AhP1r1rspqrIGqxm2fJypQr+D066eIdkxXhanyR1jY0zxQBQQg0C6AVYOSKLs=
X-Gm-Gg: Acq92OHIOsR4NkLtexwO09APgdiS58fif1p9DTgf7FTgUZUl1l4AkSSBvbbfCty6MGe
	X2yXXTey/C9qq+oxaRBT5+SJNLq2o1qi/cqvx0Ji+ZYZyMJhJekLyM3kfCRJZxMhYguwB8O9JTh
	SJ8BrzT+hrm/K6y8FutPv2v9QfpDjPhp9OU7T3Kn2bQkmgetgkgNZh03483gsB+5Hqf6fg+h2QR
	DauAVe990bsIKQy3SVqfAfZCfNxPUzngmtAju0yEXUCzQw4fcNvfjgwgz3DcqbF5QUo61sJlD4G
	YNtKQrtTg25UFDNQtXEQZsLlHQ8ap0nazT/RWgYwy7DLNAK43LnwzANkQ6Kl20oBdHSZWplL/8K
	MTxuZsb6VFZ3O4eQPQl3H/mdJ3LkIhD5hxsAae0ncT9Bc6J81JYQJiy65MrAqFhqSrwudf8DBYJ
	MgTnKZfRd+XYTYk/RGf7T+AKsksZhrpTQGDq2JzvoZ2Q==
X-Received: by 2002:a05:600c:350e:b0:490:95b4:1cd0 with SMTP id 5b1f17b1804b1-49095b41d49mr17768025e9.15.1779973596291;
        Thu, 28 May 2026 06:06:36 -0700 (PDT)
Received: from localhost ([208.127.45.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908f0a0dc1sm15663735e9.29.2026.05.28.06.06.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 06:06:35 -0700 (PDT)
Date: Thu, 28 May 2026 15:06:29 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org, mrgolin@amazon.com, 
	gal.pressman@linux.dev, sleybo@amazon.com, parav@nvidia.com, mbloch@nvidia.com, 
	yanjun.zhu@linux.dev, marco.crivellari@suse.com, roman.gushchin@linux.dev, 
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, ohartoov@nvidia.com, 
	michaelgur@nvidia.com, shayd@nvidia.com, edwards@nvidia.com, 
	sriharsha.basavapatna@broadcom.com, andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, 
	jmoroni@google.com
Subject: Re: [PATCH rdma-next v8 00/15] RDMA: Introduce generic buffer
 descriptor infrastructure for umem
Message-ID: <ahg9u5GmSxZ3167x@FV6GYCPJ69>
References: <20260527170948.2017439-1-jiri@resnulli.us>
 <20260528005828.GG3528738@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528005828.GG3528738@ziepe.ca>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21429-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,ziepe.ca:email]
X-Rspamd-Queue-Id: 2164E5F2847
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thu, May 28, 2026 at 02:58:28AM +0200, jgg@ziepe.ca wrote:
>On Wed, May 27, 2026 at 07:09:33PM +0200, Jiri Pirko wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> This patchset introduces a generic buffer descriptor infrastructure
>> for passing memory buffers (dma-buf or user VA) to uverbs commands,
>> and wires it up for CQ and QP creation in the uverbs core, efa, mlx5,
>> bnxt_re and mlx4 drivers.
>> 
>> Instead of adding ad-hoc per-buffer UAPI attributes for each new buffer
>> type, each command declares dedicated UVERBS_ATTR_UMEM attributes that
>> carry one buffer descriptor each. Each descriptor specifies a buffer
>> type, covering both VA and dma-buf. A consumption check ensures
>> userspace and driver agree on which attributes are used.
>> 
>> The patchset:
>> 1-2,4. Plumbing: rename ib_umem_get() to ib_umem_get_va() and re-route
>>    it through ib_umem_get_attr_or_va(); no behaviour change.
>> 3. Introduces the core buffer descriptor infrastructure and UAPI.
>> 5. Factors out CQ buffer umem processing into a helper.
>> 6. Adds the CQ buffer UMEM attribute and driver wrappers.
>> 7-10. Converts efa, mlx5, bnxt_re and mlx4 to use the new CQ helpers,
>>    with drivers taking umem ownership.
>> 11. Removes the legacy umem field from struct ib_cq, now that all
>>    drivers use the new helpers.
>> 12. Adds optional whole-QP, RQ and SQ UMEM attributes to QP creation.
>> 13. Converts mlx5 QP creation to use the new attributes.
>> 14-15. Adds mlx5 driver-namespace UMEM attributes for CQ and QP
>>    doorbell records.
>> 
>> ---
>> Based on top of: jgg-for-next 9733e9f580fdda2e8c1cd349caddd93f026ab6f5
>> 
>> See individual patches for changelog.
>> 
>> v7: https://lore.kernel.org/all/20260526144152.1422310-1-jiri@resnulli.us/
>> v6: https://lore.kernel.org/all/20260520101129.899464-1-jiri@resnulli.us/
>> v5: https://lore.kernel.org/all/20260517063006.2200680-1-jiri@resnulli.us/
>> v4: https://lore.kernel.org/all/20260507125231.2950751-1-jiri@resnulli.us/
>> v3: https://lore.kernel.org/all/20260504135731.2345383-1-jiri@resnulli.us/
>> v2: https://lore.kernel.org/all/20260411144915.114571-1-jiri@resnulli.us/
>> v1: https://lore.kernel.org/all/20260203085003.71184-1-jiri@resnulli.us/
>> 
>> Note this re-works the original patchset trying to handle this:
>> https://lore.kernel.org/all/20260203085003.71184-1-jiri@resnulli.us/
>> The code is so much different I'm sending this is a new patchset.
>> 
>> Jiri Pirko (15):
>>   RDMA/umem: Rename ib_umem_get() to ib_umem_get_va()
>>   RDMA/umem: Split ib_umem_get_va() into a thin wrapper around
>>     __ib_umem_get_va()
>>   RDMA/core: Introduce generic buffer descriptor infrastructure for umem
>>   RDMA/umem: Route ib_umem_get_va() through ib_umem_get_attr_or_va()
>>   RDMA/uverbs: Push out CQ buffer umem processing into a helper
>>   RDMA/uverbs: Add CQ buffer UMEM attribute and driver helpers
>>   RDMA/efa: Use ib_umem_get_cq_buf() for user CQ buffer
>>   RDMA/mlx5: Use ib_umem_get_cq_buf_or_va() for user CQ buffer
>>   RDMA/bnxt_re: Use ib_umem_get_cq_buf_or_va() for user CQ buffer
>>   RDMA/mlx4: Use ib_umem_get_cq_buf() for user CQ buffer
>>   RDMA/uverbs: Remove legacy umem field from struct ib_cq
>>   RDMA/uverbs: Use UMEM attributes for QP creation
>>   RDMA/mlx5: Use UMEM attributes for QP buffers in create_qp
>>   RDMA/mlx5: Use UMEM attribute for CQ doorbell record
>>   RDMA/mlx5: Use UMEM attribute for QP doorbell record
>
>I think other than the remarks in v7 I sent after this was posted, and
>the few things in v8 this is fine

Okay. Will fix and send v9. Ugh.


>
>Jason

