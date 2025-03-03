Return-Path: <linux-rdma+bounces-8264-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95246A4CAF4
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 19:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A98FD7A52BE
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 18:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A5222D4C8;
	Mon,  3 Mar 2025 18:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="m1iAWyyw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAA422C355
	for <linux-rdma@vger.kernel.org>; Mon,  3 Mar 2025 18:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741026393; cv=none; b=XCAiEPRyGXjq42/9n0LV5A2tPCRJuzQ5JyFxB0r1+XGMlSNc7tBfO88DsIEmGWYiNg/usZ7FCA1UEthPFyabEcXJWscl22Z/YUbJyaox/TU7lld7unbcwTSQC7ybn5/sdPDR0mv5gdDW+bre0JD4ZZhniES4Wq8wceG7a2oOOlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741026393; c=relaxed/simple;
	bh=ZC4tlA2vNihT6P1/LNSQISGA8y015oz0KZ6dDXi8Fq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Plj27c4RfFTee3uNh0Na+LSGblf+xn85sHFNUV5UMofLt++uN/Tx/ZAQgyx1QMrmDCgdxx9B840Bxo9Cd1naZ/weFRympTVrXnCX1AgDzyoOiZTNsikf10IxkH4pYo8Piel5Ume5yBmdyQUB+z+yRNLHlNsh++cAVcpD1LRtyWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=m1iAWyyw; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e89ccbbaa9so32808506d6.2
        for <linux-rdma@vger.kernel.org>; Mon, 03 Mar 2025 10:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1741026390; x=1741631190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8P3c1f/2WglsHSb31TjBEda9T69Y4xomID9q8JyMtZo=;
        b=m1iAWyywqh1ACPnznrwC8TJkn35hCU6w7kmoXeyb51Zt3KA9OErvy1EcT6NqVXmHMM
         wFlauBgxG5KSL+WjQS3ajUPl+ht29pDKD5le0ylfh+9PhWP34cMDs1XexJUlZ1ofZKvH
         f8iWroKfzQ1eIrb7XiH7m3aLkn9TQ6mpy5zW22qY+J2pHaTgRXjUurhGwdmsYQIXth9p
         RoTZjflB0npOZQ1JUqFMgUcSkIXN+R6fWP/B/p9laTJymoFzcsosCzoShUhsxcpo3qr8
         KXNFA2tvX9IL8AhqxUfIeY0PuMJje1pOVKyr2byKgQmzsojLAiKXbV01Wnsl0bL+mcV4
         3yUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741026390; x=1741631190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8P3c1f/2WglsHSb31TjBEda9T69Y4xomID9q8JyMtZo=;
        b=g523Q+tA3hmGuEONFBGJU+luBON2L04atPecHc2GaHCVrnO+FbPPxXqf+5OYcuPRrD
         iW7W3y014wl6qVIx6I5wKjqVYOnoXJCU66CeV0+vkrLyw0UwqCU51M1+ax/19I98T9Xn
         MusVAxoGJYvze+TIRrvYuh66Lf3a14xHEk8hIkgN0sXDynaWEPVWGlFD9a5uNpxmyGZw
         vELniV62ONd7ZBnVHM1+LiMNr/VlmBpIWZEYv3BAPwYPttycfg2GFqZEJfUhcLqaiW6o
         n6m2i3gA8zE5OxfzgeuL2h2UTdMwz6eKW3pAR6CvdE95q9n6+TBRHsRFNDS9VYv0qqk4
         NfbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWthbCZ6Ans1YGNLAXZPvvgyvDNM74LZZPT83tmLnSyLXeCO7SlqvwOCnzfRIZc23/gIepdcwYSWYot@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjgqk566C0yPuQXkW6pgMpAgiIia9BfAShqaxtgKp1tWDQr6gq
	m6xwaYTcIFhqD2PuGnxLqDy3A4s2A5fIhViSQnqFQIMp7U6HQ7fOp4f+xqLDjjg=
X-Gm-Gg: ASbGnctlm9U3lw9C/vg20xKWHmadVjznLuhXbj05kKO/56gphLD4hCfcXPpFZoDgG0K
	gIBJyXxFsmMlf4yrka9FLJyn+ZS0ij6c1GsX8Owai6A0HtCSNTfp4zdkkDEh+sKqOFHK2FIQgei
	4jHbosJp1opJMz4wMIaGKTmBHKoqs8JsdPeHtHBdFz3r5JJ/W10VNNuKefvb3vpXuL18hpJ0sEF
	rsl1ZdQmLcBnm57vLvEQ0vvWrFZa0iabCMXe2JwTWvUlO8NQ6A5EG//WKdZGU/ih8eAdwNSdfTg
	vStzd3oR5JBF9ZNlQZ9JNCBMI3U3sGUj0/genKnBefB62p3/9iofv0yUICMA8uOaLun6+Ulfplb
	mSl1ayIEBURQfP64RuA==
X-Google-Smtp-Source: AGHT+IE66gglyyQ2xKgSQXIbdA8WBFQ6IzfR/o102BpGE3gMonp/Wrali1UCV/qGdLX6c68bqdZobQ==
X-Received: by 2002:a05:6214:4113:b0:6e6:9c39:ae51 with SMTP id 6a1803df08f44-6e8a0d85f8dmr193980056d6.33.1741026390548;
        Mon, 03 Mar 2025 10:26:30 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8c91fbf79sm16019446d6.33.2025.03.03.10.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 10:26:30 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tpAUn-00000000qHb-2ItX;
	Mon, 03 Mar 2025 14:26:29 -0400
Date: Mon, 3 Mar 2025 14:26:29 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: bryan-bt.tan@broadcom.com, vishnu.dasa@broadcom.com, leon@kernel.org,
	bcm-kernel-feedback-list@broadcom.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: Unwired pvrdma_modify_device ?
Message-ID: <20250303182629.GV5011@ziepe.ca>
References: <Z8TWF6coBUF3l_jk@gallifrey>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8TWF6coBUF3l_jk@gallifrey>

On Sun, Mar 02, 2025 at 10:05:11PM +0000, Dr. David Alan Gilbert wrote:
> Hi,
>   I noticed that pvrdma_modify_device() in
>    drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.c
> isn't called anywhere; shouldn't it be wired up in pvrdma_dev_ops ?
> 
> (I've not got VMWare anywhere to try it on, and don't know the innards
> of RDMA drivers; so can't really test it).

Seems probably right

But at this point I'd just delete it unless pvrdma maintainers say
otherwise in the next week

Jason

