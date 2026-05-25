Return-Path: <linux-rdma+bounces-21223-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFBXFuvxE2puHwcAu9opvQ
	(envelope-from <linux-rdma+bounces-21223-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 08:53:31 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8865C6C9F
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 08:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 263673005AEE
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2026 06:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289ED3AB29A;
	Mon, 25 May 2026 06:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNkZhg8O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0513ABDA4
	for <linux-rdma@vger.kernel.org>; Mon, 25 May 2026 06:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691998; cv=none; b=NNBcjdZ0gKkJ4//dhsi84NY1XnkzYJ2SV1iISRSQyJG3Na8Pi04boMbRxxVVz8ZCiEQ9xZEkOgEGJWduxFGykumxw5gJ3evSrmn6qnHCON6bStqt7FMnAQsq1pNg8CFzdQFdAlwnpZ+Ffcgpcj7490nz/4FkKckgGM/hCwyDns8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691998; c=relaxed/simple;
	bh=V8xm6fELyw3VeLTnlrhOJghx6hhreON0dhImoYjkJGU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArNNTCKcd7rz5CByV65slCHeqZn0yQkN20nYHBHVU4lKg9NWgIDYMJobMitVWavYua4gARYGn27NTYJR/sESn4GOZWhxkE2shDS1TvMPm+cdmmHS8MjJOljGTzDrVMwLfiU8yzXpNLFb5k5FMcqicOly93dCG2bLPjU+FLMOYww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNkZhg8O; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49048e043e5so17611825e9.1
        for <linux-rdma@vger.kernel.org>; Sun, 24 May 2026 23:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779691981; x=1780296781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VAW0DL94MU37t4ITev7bKzkIOLZe9l1jgzV6gYy/lm8=;
        b=aNkZhg8O9hZgeo7/8RUETBxgteBCLocgORW/+YL15QXnHJGS8SS6ua3Aai0UbkPVJ/
         SdE/SSD736VyfO8bh5WTr0u89fIgYoz0g9cymrdcu+BAqRe31F7MbhL446Skhfaa35yD
         Xrw7sFfMkAM/5jFviYxb4M0vd1gb5epjXV9WQCGIEW8k0VBjYQgvMXLLitZji3YV8ZRZ
         aagRQ03wHYhTsmsI9wTwES8pYenMOCddgHsbUkJDwn+/L+iVK8018Hipx00B+cFQIZwW
         59vsr9mRGqrd1f/UKFQumWzNBfzVpXtpSCiqdmr+CrkNfD6BRKGMv9DFKRg6sUUXUHVI
         I96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779691981; x=1780296781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAW0DL94MU37t4ITev7bKzkIOLZe9l1jgzV6gYy/lm8=;
        b=TA6qTs2PAQpBdele2eKtr21DdHLrPTH1F8OUxGdbIiJLl5xjrmUWZcg1x7QJvtLgJJ
         uxBfZO0ubjHFQrs7zH4k9gB47vG7hywS6LZihVNwkKXLEWjClvuP5XXsgOlC5lVD+JDz
         eGALw5jhL3zE3vGdLF0dtUZQh3MIqbjzNzrqG90B+umLbJtwka3J95gblB7yQCW9Kxxa
         EbbyGS54BchI8XBkOiqK3czprs+LoHgDI21578mBrflmKNfLzqaDX4q1i+6XTzrZtX9Z
         8aF5/mYMbvzg6VXXMAM4ZqrKEJDVmw4C1EeQ4hALxaTwytdG+8+dbm9VJQ4gNl/YN9l5
         BxrQ==
X-Gm-Message-State: AOJu0YxfNvHSEUznIxVjETM5iT+nEcu8z6uEACjfUR84UFpfz9Oel5qN
	6YCZhiDcVYmI6U5bJbbC9HTZ3knt9IyYQyZdnGSUe7fy5IntZAYL2tzz
X-Gm-Gg: Acq92OHmE0dcruxF80YQ50hQSz2UvBJ6hVsbyYoBlu6sSgGIxzw4PL3yWKT2JX3Gp+R
	pB9FyILvx6v1VfR6q5NNansFb6s0LC6EV9cYRRueflR4c9J3k5XlOUOQoct3OfZO1ZFW/ih8vTF
	SW3ZSTGciWHsyjuTIIdNCLPa7E9QAil7Erkwbb6EtlxWuMBlGLlzdT7JmshQJnWCa5LBJQ64OTO
	BQvOsbEfcMtTBxotTucWc35vb+ftHI5TMt0N/jfVAwJqjt2OD7KGFjeB2xt4R4Qr6EYFvSvWXN/
	PaOp4iwuDwaYY57VdMAK7bPaGaoemKykrhYOAxvPsbTL7TVqKDokOVbZzip08g1z4gGzg5zwZ38
	Ng7iJKJ555mg2gPP65Ktl5DjeI/2doYJe95AgtSVlnaTkkIhhZg1dyPHMQFzuPmBpDBbekibVsG
	imxpZA6eEhbmc/Wxm8GKhJAdM=
X-Received: by 2002:a05:600c:8207:b0:490:688b:ece5 with SMTP id 5b1f17b1804b1-490688bedbamr19248755e9.30.1779691981114;
        Sun, 24 May 2026 23:53:01 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490452765f5sm234317195e9.5.2026.05.24.23.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 23:53:00 -0700 (PDT)
Date: Mon, 25 May 2026 09:52:57 +0300
From: Dan Carpenter <error27@gmail.com>
To: Yishai Hadas <yishaih@nvidia.com>
Cc: linux-rdma@vger.kernel.org
Subject: Re: [bug report] RDMA/core: Introduce a DMAH object and its
 alloc/free APIs
Message-ID: <ahPxybgr-27yeRNY@stanley.mountain>
References: <ag68qoAW3P04J7pT@stanley.mountain>
 <e2a4adb3-4f09-4e23-bddd-e18e158342b9@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2a4adb3-4f09-4e23-bddd-e18e158342b9@nvidia.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21223-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[error27@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[stanley.mountain:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DE8865C6C9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 24, 2026 at 10:22:55AM +0300, Yishai Hadas wrote:
> On 21/05/2026 11:04, Dan Carpenter wrote:
> > Hello Yishai Hadas,
> > 
> > Commit d83edab562a4 ("RDMA/core: Introduce a DMAH object and its
> > alloc/free APIs") from Jul 17, 2025 (linux-next), leads to the
> > following Smatch static checker warning:
> > 
> > 	drivers/infiniband/core/uverbs_std_types_dmah.c:50 ib_uverbs_handler_UVERBS_METHOD_DMAH_ALLOC()
> > 	error: passing untrusted data 'dmah->cpu_id' to 'cpumask_test_cpu()'
> > 
> > drivers/infiniband/core/uverbs_std_types_dmah.c
> >      40         dmah = rdma_zalloc_drv_obj(ib_dev, ib_dmah);
> >      41         if (!dmah)
> >      42                 return -ENOMEM;
> >      43
> >      44         if (uverbs_attr_is_valid(attrs, UVERBS_ATTR_ALLOC_DMAH_CPU_ID)) {
> >      45                 ret = uverbs_copy_from(&dmah->cpu_id, attrs,
> >                                                ^^^^^^^^^^^^^
> > cpu_id is untrusted data.
> > 
> >      46                                        UVERBS_ATTR_ALLOC_DMAH_CPU_ID);
> >      47                 if (ret)
> >      48                         goto err;
> >      49
> > --> 50                 if (!cpumask_test_cpu(dmah->cpu_id, current->cpus_ptr)) {
> >                                               ^^^^^^^^^^^^
> > You can't pass untrusted data to cpumask_test_cpu() or it results in
> > possibly a WARN_ON() (most people have reboot on WARN enabled) and
> > and out of bounds access.
> 
> Thanks Dan for your report.
> 
> It seems that the below [1] chunk should solve the issue.
> 
> Would you like please to send a fixup patch having it ?
> 

If you could take care of it that would be great, thanks.  I'm
trying to scale my process to compete with Sashiko.  :P

regards,
dan carpenter


