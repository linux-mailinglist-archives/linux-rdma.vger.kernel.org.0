Return-Path: <linux-rdma+bounces-20078-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GbBNKVE+2lPYgMAu9opvQ
	(envelope-from <linux-rdma+bounces-20078-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 15:39:49 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3904DB176
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 15:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E8CF3009CE0
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 13:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3F7477E37;
	Wed,  6 May 2026 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U1dNim5o"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7176B441021
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 13:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074786; cv=pass; b=WPp51oVa2kxt6qB6pq+i1/URjeaPK2ZEV8rFzwhaDFbuk+cDLpgEADSFQ882PZK1Pfcc3gLsYr1xg23xG1HUNbbMLVnnnVFVBBuQBFXRhg6P1QYFy51lIcyDgxf+D5ruYSJoyIcDpppxdneO72PIiX6a4lAsKkDl3cLY2XhJVqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074786; c=relaxed/simple;
	bh=UkuvYDsmxDz9txFM8gyMWzHbcPwDZX5ZsCBd55W2fyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9B+kQdCc3LRFDWz0gwNEAwh6k9dQcMJAkev2R/UNN6Jad/vuBUUlY3CT3KL3f5D8DNP2euKfZA5oP8tp0iK6ddTbQ1Epv3AtymBhe57OqHxmIfweTzBjZN0wupiCEm5TTAVmDf8ZspUl+gRAwnlEp3rsNDRuyXgxV3dkwbcE28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U1dNim5o; arc=pass smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-479dd56d016so4610680b6e.3
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 06:39:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778074784; cv=none;
        d=google.com; s=arc-20240605;
        b=fdtUDRlpRGxC4ape3Z++5qLpbZCz1hNa2xTfQ8Dna/mayzrghvuyrl/VSlR2lsmIdW
         PAipte//GF3rq+r8jFxDYajOTCqmiJ3Y3iadpmvJn6DbajtiLFPUJfaEtPOFz5XHOnXp
         rxfLxJahy//VvQfw/YZNmgln9FbCT97QpvmvGQWYBxQa3hZpu0JFkl7lebcBznhp59xQ
         NY0ghWOcTeI6502IYJgQ5odpGNR0KpvJ4akR0n0FE9/YJAxjPBFoz0nCUAItKU7TZKIx
         NvgY3oFjCuS0VvOzO3h+Q9ADOP1V+4bLWAN4BfwlI7ApJqs/tauyy4xEnzqySBWegx6V
         Spqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=UkuvYDsmxDz9txFM8gyMWzHbcPwDZX5ZsCBd55W2fyw=;
        fh=O13cep/M3b/Q4gzoMSEXL0MPlvM722Wo5E1w+Gs3XNc=;
        b=NYBz/b83Bs3XD1QKhpxd3lNNX2q3QtcHsh4pVKNCiUMsx+RoF9LZtSpIoN9UXOxoqE
         MYuSDkBMOZ/Hx9npu33IWPDLkK66Fp3qAE07yrwCKplZGP/IrHF4FjlB3H68CB+T7Kia
         RxmIZCRCrijgqia0ecMCtAasUdei+oYQ07NfjZCUQ2pWcv56YAgaUHZhkwL41jdb6YBN
         yl9ntnXoQTb8DLEao5ggEhc8mFTf2cIV3KVUoXxcYFQJvI+60dz9SGlzCDvAF8kmq7OX
         OkoNtL+M+OLbWwN6jGBTVkCFYRHTyTKS9WjAMlmIsJ5OP6nuVR57YsDfZIcKEbZaBPZX
         9trA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778074784; x=1778679584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UkuvYDsmxDz9txFM8gyMWzHbcPwDZX5ZsCBd55W2fyw=;
        b=U1dNim5oZpFQsWhin5YZzVHsywyJLbQKynFiiXSQfMF1C2jRoBMIky5jLaMQip0eGH
         MomT/kbYp7R5PVJH2QrIJxrA1Hgp9agOl6byF2WSeE6ZGt8lG5u/Hi8sOkxlMdpcwYiI
         41M1gUiVMhF2cPUo5r0IKMjC6XZftyoylNshdeER1xrXthFejJgsxN87etK5uSG5j+2q
         o3JPEfjzS44MtRGPikAKXJYBP0D3nSG9DET2m0z2jt14ifDdY4lHbkqJPhytW6ZuMVoj
         s/I1waunYFcwckaE6PUehod3PFbmK0t1IlZXwLOwP9OEatb6YEmU7YWw2IPQhpBAZzpW
         M5tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778074784; x=1778679584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkuvYDsmxDz9txFM8gyMWzHbcPwDZX5ZsCBd55W2fyw=;
        b=kvZKgAjfKny6I7ANKrpu5z1Cb6uqaWKkhfrqLDPyItVcV0msSEoG0T61obikCAXwEG
         QY1n+Kj7ib7aDFkBz30SKjWZpuWHEOpcTfIu9aMVr5H0lO0ncsGzSj4arHXjsxstQ8y3
         5RBcYVCqPYjaXuyzPEd8ABejpfVMsMKSNe4oX4bSxnT8fJwLWt58CNcEcEIj6uz9i+d/
         OOImbrL+Wfbll9nDTMFNLx0KYM1oZjezZjaORaZYBTsayj6BG1jvl3f4WjlDJMmDzHVE
         tnq7rig/OPRh+MVv002R5dgR9fo6ZdTfYZtt3ErCCXdvarXZ56LiX4CsUXZ4B/xsxkhm
         +iRw==
X-Forwarded-Encrypted: i=1; AFNElJ+KZDgz7LII72uMDkbzQwKvECWabyKtJPYzN1oXCG++b+Zawk04vOmp6ziDPXNrI7f9Udl2+t0H6zSz@vger.kernel.org
X-Gm-Message-State: AOJu0YxhH4I9Q68AvL6q/VzUTN8wk/Kci+NaSlb0j+QRg8qwwPzDBomk
	E1oUVHsa4olbB4XIhDk6hsMteYjMWF7MjZTv8w5+SOUysR88aOH6yNWzl7lyvQwKsZJFd3xH4f7
	Ga07nkvXUs5clQZwVdhYHRKLbWZm2myqE2pwkf9+5nylLqdL6rOUQqfil7MM=
X-Gm-Gg: AeBDiesPOZsx5ohukhoFCs1VzIkMPlceyEFfHlj6ViZriaQ2M9gj4cM3xOWKkSl8A/r
	dxnwkN+AshSJD2mTfJYBDwo1g4w0Hblp7HJC9r326TfLtWRJgeQzuZBUHtsliQ5/sYTOrwTCkTc
	aRZTAiNwcRn5XbQaWQh9OebQwvQ0fAbTpP9kYErvAVqM4N0g4EmDQBgMxEruwbI13wdFOkvKksJ
	o3zR/kEr/4x6qmXenA+cPx8QihX8hhEid+zntCry2g2pMEgmhDx7cZ3i0nHlXtlthCBDYNhuOi6
	J42P8GbDNro1TJqWx0rg+UeW3P2zLoNBTLWyniQeNi33761rZ1Bac9v4jHIgsD5kF7KgZtE1
X-Received: by 2002:a05:6808:3a17:b0:479:f776:f2ef with SMTP id
 5614622812f47-480421e59demr1896899b6e.17.1778074783947; Wed, 06 May 2026
 06:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505061149.2361536-1-jiri@resnulli.us> <20260505061149.2361536-3-jiri@resnulli.us>
 <CAHYDg1SSkV42nfjakR1W=zu8-E7svsswxoTesXuLvpF6c5WvqA@mail.gmail.com>
 <afoUqiDgZmhE4Kog@ziepe.ca> <afsIsW7vKgJtdNA2@FV6GYCPJ69> <afsOtEeppBzxOGUB@ziepe.ca>
 <afsdvIvEdX85iCXE@FV6GYCPJ69>
In-Reply-To: <afsdvIvEdX85iCXE@FV6GYCPJ69>
From: Jacob Moroni <jmoroni@google.com>
Date: Wed, 6 May 2026 09:39:32 -0400
X-Gm-Features: AVHnY4L7DJcetDqqNTPo9ezownSUpx21Ss29E22MBQhA6ePJwx8nVcT3dVkqLnQ
Message-ID: <CAHYDg1Tbrekfnd7RyHm07ctAP9DLtUHqQ5EsYMYJr=bjjHSMPg@mail.gmail.com>
Subject: Re: [PATCH rdma-next 2/2] RDMA/umem: block plain userspace memory
 registration under CoCo bounce
To: Jiri Pirko <jiri@resnulli.us>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org, leon@kernel.org, 
	edwards@nvidia.com, kees@kernel.org, parav@nvidia.com, mbloch@nvidia.com, 
	yishaih@nvidia.com, lirongqing@baidu.com, huangjunxian6@hisilicon.com, 
	liuy22@mails.tsinghua.edu.cn
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 2D3904DB176
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20078-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

> transparent dmabuf-backed-VA pinning

Thanks! I took a look at your WIP code. It seems like it would really simplify
things for irdma. Looking forward to it.

Is there a WIP you can share for any rdma-core changes? For example, I
am wondering if there will be some generic allocation helper for drivers to
allocate umems for internal use (for QP rings, etc.). This helper would
detect if it's running in a CVM and use the cc_shared heap or something.

I'm mainly just curious how you see it being used on the userspace side.

>>> Another idea was to just allocate them in the kernel using the DMA
>>> allocator and map them into userspace but it would be a larger change.

>>This isn't the pattern we are using in rdma..

> Yeah, plus I'm missing the motivation, what that would help us to
> achieve?

This would have been a driver hack and doesn't make sense compared to
your current plan, but the idea would have been to use the DMA allocator in
the kernel to allocate the QP rings. This would give us a public buffer, which
could then be mapped into the process with dma_mmap_coherent which
sets the pages to decrypted. I imagine this scheme would be needed for
NICs that require physically contiguous ring buffers (if any exist, not sure).

Thanks,
Jake

