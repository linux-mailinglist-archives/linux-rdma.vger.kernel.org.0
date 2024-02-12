Return-Path: <linux-rdma+bounces-1005-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4198518BC
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Feb 2024 17:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D8428177F
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Feb 2024 16:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD763D0B6;
	Mon, 12 Feb 2024 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NTtswX6g"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F103A1C4
	for <linux-rdma@vger.kernel.org>; Mon, 12 Feb 2024 16:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707754362; cv=none; b=rz8pQ0lzrSzT3MRai++Ex/MsEbt9Q78Il/qhh0gI7WRavpYR7ynFehgfpxV2iquh4uuMwAFzBJJzqxQdax/fHENEFFQax3C7k3aHL8eFwaSTwKC+jMV8SxQJ6LeR5jCEJ7WU306SeUaYXdTzLEMZnJtI8yS4BkzV5w1Q5lNlLVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707754362; c=relaxed/simple;
	bh=hjpfnavnSyUNRxKxjGeJPa+p0ZtJoYNGtJgPcPDtYNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EvsqrZSNtojO8xHekEHUo7ZDIMYjCLFO8x0EUxdk784q9ddEnidLvxYGfZwve66DZD8f1MC8BK05qOdu60hOjmt/82ayev56lWadGPcvXdqjoIMl9WMQfR76nw5CX8jGxIMoVhRQqBL1IecuGmZsu5uAd3FUE5QaFOC+7trysgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NTtswX6g; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3c02b993a5aso1722747b6e.1
        for <linux-rdma@vger.kernel.org>; Mon, 12 Feb 2024 08:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707754359; x=1708359159; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l89c1zdEClk9OzxFzVxI8SxYroKTpciFHiIYh7jXU9w=;
        b=NTtswX6gLDdwuRa+03pKWJV6o991eKFarIGvQRJzK8dxZ8fzAUARl+Dzw1x0kdAB2k
         SQTaijMUuFhj24F9MOv03hfv7azCxcOOlDHFKBNa4rDqvtVX0p0ewA/rx4e+obgsnxBU
         a3ULDDfm+5YSPtw6BIDJxQ/xGjSa2K4xk6bu3zA/U3jQpMq8gz4OT4Sd/gxyzA4FtWdw
         EMg83FzpJH29HwuWPmqqI5V6TlVNxnkLMt9nsMZWH5T0UCmv3Kqba5iNU0ElFr2WSnK+
         u2sdjc2gZhUSH6sPLefbpR4jq5WMFDmVTs3lWG2WwS7EjKrrl8STl1QSuXjwKN+2gALB
         xCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707754359; x=1708359159;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l89c1zdEClk9OzxFzVxI8SxYroKTpciFHiIYh7jXU9w=;
        b=TxckNr7apUp5s/jIy3pXog8pU9zvgIjj+tZNh43hm3FwW6282VHcHEhf8/ZuL14Pc4
         Lvcc2dF4mpwLbyAQqltGgoUS1oleLTEaC4sa8H8NHTTRE2N1nvPweyZF4uHMTBRyXpF1
         Z/C4loqEnZXRF5PzhhO+rGa+gWHmetyQZHx015ZImPA8xk59f2t+bYchQok9IMDgnLNj
         FtjIRIbuY0z9tDGNKg4mXBbcdUL3rmTZqUdFY15omxucy7tue5iuKIj/Mdl3hQ9Fami/
         sDpqMouMf3IHwHcuZZWaTFeEcrVFSw8YmSSVn5wnlJueIM1HiPeVCzO4dScWzqJoZvfp
         CEyg==
X-Gm-Message-State: AOJu0YycHheXwtrDYEK8qDtnRXfMu83RZkicW5w/gF3EdqzwqARZYb7Y
	svmddxItkkv4K0Fc0PPS0gPbnl3B6ybC6ibhqPypvN6kVtiAqRz9S5Jt6I0eoIk=
X-Google-Smtp-Source: AGHT+IF57eEOnINfW3KU5hYwfAhCdQ0AsN2DgPLmd8pty1mdduoHCqJn179e7MOt/vFeheAsxTGZNQ==
X-Received: by 2002:a05:6808:11cd:b0:3c0:a25:bb4e with SMTP id p13-20020a05680811cd00b003c00a25bb4emr8710566oiv.35.1707754359439;
        Mon, 12 Feb 2024 08:12:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX3+yo2FW8j57g3Z/LynP/cK/oMWLVlRxtnwHh5L52w2YgNa9PANyCgGx9omWLEbDFku1AJOYRy+c3XvSN5KK1NLtQyFt/atoAApgA3Es1ZM596tQ8dmYfKN3ug76+vjqSkZkph7OeS5ZJ+/0KtO8zUyrP4IlT0RNhfouM2E+xNX+U/bx+Itt9l2Vms9y33ARY7ZPyFFTgQaXbmydCk
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id by8-20020a056808340800b003c035a3b3c3sm103312oib.54.2024.02.12.08.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 08:12:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rZYv8-00HT8V-8U;
	Mon, 12 Feb 2024 12:12:38 -0400
Date: Mon, 12 Feb 2024 12:12:38 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kevan Rehm <kevanrehm@gmail.com>
Cc: Mark Zhang <markzhang@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>, kevan.rehm@hpe.com,
	chien.tin.tung@intel.com
Subject: Re: Segfault in mlx5 driver on infiniband after application fork
Message-ID: <20240212161238.GF765010@ziepe.ca>
References: <3CAF66C4-32E1-4258-9656-D886843D7771@gmail.com>
 <20240212133303.GA765010@ziepe.ca>
 <8BB93F6F-14EC-4B43-B1F0-5FE185A64073@gmail.com>
 <20240212144013.GD765010@ziepe.ca>
 <53992378-7BB2-4E8C-BD3F-8A2B1FC837BD@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53992378-7BB2-4E8C-BD3F-8A2B1FC837BD@gmail.com>

On Mon, Feb 12, 2024 at 11:04:36AM -0500, Kevan Rehm wrote:

> Those routines call ibv_dontfork_range on the page after it’s been
> allocated via posix_memalign().  _add_page() then adds the new page
> to the mlx5_context field dbr_available_pages.

Oh, if this is your trouble then upgrade your kernel. This part is
fixed on kernels that have working fork support.

Jason

