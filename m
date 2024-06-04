Return-Path: <linux-rdma+bounces-2846-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B708B8FB8FB
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 18:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 552201F21E47
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jun 2024 16:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6325C13A25B;
	Tue,  4 Jun 2024 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkzPk0Mk"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15936BFC7;
	Tue,  4 Jun 2024 16:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518653; cv=none; b=aH2yF+pm6NQHKvDaTIfSVkAspeoyEv4SLbAxRRCQoZzHNUWDDLH5jsON8gm9DFQT/Vtpe1/kPVCfSrhCLC30g1y6cEMsjFGWjljDrMMO4Y/cu2i5qmAAVlxar31stJgMmW4N5wh6wlksArhnh9+TA0v7C3iZB69B8VuOYDv3Jxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518653; c=relaxed/simple;
	bh=g2nNoE/jBPYFHGgG9KjF1D6qbp8g+/CUpdddbyNM52A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t+NvyQYtq9oAWC9Wpi06AdX/Ektlz+0gTv4hZXRHBp/ouLU4fy4fIHPObSG0EcuqyZw8l5tIE/Cmc+H7Vu3ApjZncHXEl3iX2Ub8Hf76D2v8qjBap+JQmB2DlUwUTTf1TYJyGhMVGlIc5DCtI9HH0IL9xt1Gk3ICXney5kX0P0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkzPk0Mk; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-656d8b346d2so4155053a12.2;
        Tue, 04 Jun 2024 09:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717518651; x=1718123451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=83p7cdIpWkem+14akSHUhV9KHZt6lrNKJIFaFfNsCQ8=;
        b=fkzPk0MkIfdJBKQ/4xyl+35Sv0S+Ji/9NeTx5BqhMvMB4P8/duH22kbxxAkYmm4uWQ
         ik6h4XIOIjiihPvGiKMNr7slKsCLUR0cRbcU93zmgX5WJwmLlbyvx1kG5d3xgtH4uNq6
         QNC2dVTQdllpnxh80lLyoPb+mdDRz8ThXz9UsHX7M8Cp9zZ3zJsHBzozgmwLKwxPl7Ez
         /3HwVqpfM8Nfeu8HfqCe4OoXegTxfMJDbe6rcOQ84FAhXSuOMW/CCG9ImxHc6RwVyEyD
         WHzZ3Bxa7wtN8elDaHi2CmZdftldomox9RKi/6IW46JOjp5eILFw2Unu1lbRmXIcka/R
         pZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717518651; x=1718123451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=83p7cdIpWkem+14akSHUhV9KHZt6lrNKJIFaFfNsCQ8=;
        b=wnLh/iOwsRC80BoNK1D3nJTwHGgih8Cso6gV3ZQcndf5EClhjfkFsjrXETQKO6QVUh
         QmUm7MkWqn/toYK+XFdAFwE4j8KQ86tVWI/nbd+NR6RgjvIFgD6mANS3xRAbqJqp5dhx
         ZLOz4Y6JrttWmn+M7xA1DMrrsG2nihIWGgtXSbX1bw+Kip4HxzDqDJXfn0oQHUp/dVNR
         AYYA8ZdmdVWfAUBRPb7bytHycAwxJZ+YLraxRSHE1QWRddGsz5hP2GEbyjXORWSyIjMA
         tVjmV5l2XBA0RUedFabI7slpxr+hgYPHiIRvg8ZSexsWo2sxz3SYTwqj4i2NRSgcKWK6
         Irdw==
X-Forwarded-Encrypted: i=1; AJvYcCVpQRb6XUJTg0rLDcU1mBFZ3ef8SaFMrFH9wtsblnRlUkzcXLo3SFnAiy9VXuHUrlhTEruOHgtUvW2gQWfXwMP9BfIVW441ywKgP5E4IsncQ5BQE5ceji7KudSYpCc+hwnWQBGx5lXutw==
X-Gm-Message-State: AOJu0Yz3ivJHySsOLAz1TqqAWRgE6RWnsHbHfz6vei9Euo1SbdI/sY/+
	DD9toCRlqfOWhmQqidNLGsRI9aoDXgbZIgfFxuKlMvTwsCOyHdWF
X-Google-Smtp-Source: AGHT+IGbkr/+UVTzFi7G9OeRqFeDuNm4MstFausB0aD6oMWnYAXlTX9dceI60eLswRG8OkmRHFl7bA==
X-Received: by 2002:a05:6a20:7289:b0:1af:d51a:1ba9 with SMTP id adf61e73a8af0-1b2b6ecaff2mr204228637.3.1717518650902;
        Tue, 04 Jun 2024 09:30:50 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c37e984267sm7122382a12.42.2024.06.04.09.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 09:30:50 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 4 Jun 2024 06:30:49 -1000
From: Tejun Heo <tj@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Hillf Danton <hdanton@sina.com>, Peter Zijlstra <peterz@infradead.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH -rc] workqueue: Reimplement UAF fix to avoid lockdep
 worning
Message-ID: <Zl9BOaPDsQBc8hSL@slm.duckdns.org>
References: <4c4f1fb769a609a61010cb6d884ab2841ef716d3.1716885172.git.leon@kernel.org>
 <ZljyqODpCD0_5-YD@slm.duckdns.org>
 <20240531034851.GF3884@unreal>
 <Zl4jPImmEeRuYQjz@slm.duckdns.org>
 <20240604105456.1668-1-hdanton@sina.com>
 <20240604113834.GO3884@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604113834.GO3884@unreal>

Hello, Leon.

On Tue, Jun 04, 2024 at 02:38:34PM +0300, Leon Romanovsky wrote:
> Thanks, it is very rare situation where call to flush/drain queue
> (in our case kthread_flush_worker) in the middle of the allocation
> flow can be correct. I can't remember any such case.
>
> So even we don't fully understand the root cause, the reimplementation
> is still valid and improves existing code.

It's not valid. pwq release is async and while wq free in the error path
isn't. The flush is there so that we finish the async part before
synchronize error handling. The patch you posted will can lead to double
free after a pwq allocation failure. We can make the error path synchronous
but the pwq free path should be updated first so that it stays synchronous
in the error path. Note that it *needs* to be asynchronous in non-error
paths, so it's going to be a bit subtle one way or the other.

Thanks.

-- 
tejun

