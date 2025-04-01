Return-Path: <linux-rdma+bounces-9083-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92242A77C63
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 15:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE1F13A91D8
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Apr 2025 13:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3A7204696;
	Tue,  1 Apr 2025 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PI0SWEBJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F614D8D1
	for <linux-rdma@vger.kernel.org>; Tue,  1 Apr 2025 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514897; cv=none; b=EVBi26XGeQPJmRuZdPzoVOeYISJG+tERQS2BOmJDh0EsLX9WBoy2MHC7XFSiisqbMQb/O/ZrnXQ1wBT4H2z48vWHd7iKV+zHG9vLi65DHCmfVPyr5jUukdekD28RtQZrn+FbvCvsnXOx/uwB+KD9Dwcf6xIBX3PS7AMujFpFwZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514897; c=relaxed/simple;
	bh=b7DokJ7XVk/j8R8Vd23w/Heij2kXjXxZI4RCHC3HCzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsOSoNuRJYf7EwGZldkxXpE2kG01ibdu4sf5kwvYPWslDijUR2XwxmvDARgAZWV1NVIGmg8p+rVZo8negnj5/su6klsZ77Jnph76erOA3EaDyhrijkKe49/et6i7FYnBP/pwVKOu+fqfEbzVs85yNeJTQTco9xlEEzbH/mG0tJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PI0SWEBJ; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e17d3e92d9so43310726d6.1
        for <linux-rdma@vger.kernel.org>; Tue, 01 Apr 2025 06:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1743514894; x=1744119694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b7DokJ7XVk/j8R8Vd23w/Heij2kXjXxZI4RCHC3HCzM=;
        b=PI0SWEBJo/qEdpye4751KiR879Pek5Yp3ruLLRrHne5rsNDzaZzSaKomACuVpY8vDD
         BHWinpRi0c/JO7F+F7LzmWObUGliOAxLfD989tWYG4gPuNb5w8wSkunV9iMy4rHTSe/O
         v4U9MNBOysPF8NoiiwiWk/BWAnz9Qyd5tJPYSXsBvmkEZEklLjdZkHBf9yUaAs7m7PQ8
         en8OhU7RvmTFrYYXvwEORjGps85uaEu98fTDHDeWkuVHnefkOW55RiTbvC/p3Ag6TM4U
         X1snSxZ/j+sLaL38WYDxirzGi1PsyZ0rS7Rp1e6+n7evp394etsnMUU/Ta3eHxbI93QY
         EesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743514894; x=1744119694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7DokJ7XVk/j8R8Vd23w/Heij2kXjXxZI4RCHC3HCzM=;
        b=jWoKPlLAqF11p6dedQH8dYAaT7jT2W+zo67ssFpOIdceI3F4q+ng2D6oPLBmmYe8i4
         3c9dFp0phd9mjJ0/ViUo2pcUtXjAnkufkUBv0jjUsXUa0VOZm97G3wLwAgsMMRR0WOT6
         gsDBMWfkf7dXw7dW46liSyEfp3Ij+zZdgLwvu8Pp7pEgKTqSFWIf+nZ060tTHHCMRtjX
         ETIsO3IpiksB8reaioXKT0M6pUDkPl4lMdx7sFkEN6DRyU6euTCrtTP0GPd2obSoNzLT
         3TevflAO434qYrYwWIPjiITf1lSF7KRYsIEMEq2rjyZOYw43ZiQN2bPvujwtvsxgn8WX
         WzYw==
X-Forwarded-Encrypted: i=1; AJvYcCXDYSKbSamzLrXxpzNKKKLtcQbbcPN8gaQVYXivOOsz7T+z5uYEV4pKazkLOxUWnQXwQBU3iHIQdDlV@vger.kernel.org
X-Gm-Message-State: AOJu0YztabpKON3KCRAlCj8rKiNJef6FG47H870UQ9wD3E3o56OZveYg
	UJA3SsvVILszWdr8dxvEzvwcozFUp+WNk6rCiyogTW5t76meJP7Vok0N+cxYVg8=
X-Gm-Gg: ASbGnctx4An0Enrl5rIhTbOChi6kCJp7r6WqDZm4dmbSHq9bF2ERdwDFzA524Az0S1X
	L2qhLaHgsigtxnvRO8hohRNoGBCeJDDb+LmGw8xUFE112GuXJw1ctQZS4Qo6jJK/hkX2PLCjMpX
	XogPQ91CuEy75WBMO3OWAyco39U1I34BNZTt4lAyfTkaZiTUd+XNVCeRqWAX22zVZWeXF7+La1m
	JoAulpzmc+J82lU+oA1Ry4BZ9HPFS+c7ZNbzKnqOgqIlqapZXUHbg2m+4uM9qcpoaai2J0g1SlH
	dq3PL28p4Z49oux4hZf/aEQxyKlpeNaYMSGDRN8gfhG4m2bEcQOfkviJCg9YKwkf25BSUzJgBg4
	O4QVuAlLt+gHZmQTl0IrVoIM=
X-Google-Smtp-Source: AGHT+IEacbMHkOm9xYeGO73jBnk31ISf7JNXKfhy+DIhsFExOdd5H34dWs6gX0/0UMQut8otUAx5Mg==
X-Received: by 2002:ad4:5c62:0:b0:6d8:b3a7:75a5 with SMTP id 6a1803df08f44-6eef5f14834mr46223706d6.42.1743514894053;
        Tue, 01 Apr 2025 06:41:34 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6eec9627d88sm62019026d6.8.2025.04.01.06.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:41:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tzbrx-00000001KsT-0FLY;
	Tue, 01 Apr 2025 10:41:33 -0300
Date: Tue, 1 Apr 2025 10:41:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, abeni@redhat.com, horms@kernel.org,
	michael.chan@broadcom.com
Subject: Re: [PATCH rdma-next 0/9] RDMA/bnxt_re: Driver Debug Enhancements
Message-ID: <20250401134133.GD186258@ziepe.ca>
References: <1740076496-14227-1-git-send-email-selvin.xavier@broadcom.com>
 <20250223133456.GA53094@unreal>
 <CA+sbYW3VdewdCrU+PtvAksXXyi=zgGm6Yk=BHNNfbp1DDjRKcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+sbYW3VdewdCrU+PtvAksXXyi=zgGm6Yk=BHNNfbp1DDjRKcQ@mail.gmail.com>

On Mon, Feb 24, 2025 at 02:30:04PM +0530, Selvin Xavier wrote:
> > I'm aware that you are not keeping objects itself, but their shadow
> > copy. So if you want, your FW can store these failed objects and you
> > will retrieve them through existing netdev side (ethtool -w ...).

> FW doesn't have enough memory to backup this info. It needs to
> be backed up in the host memory and FW has to write it to host memory
> when an error happens. This is possible in some newer FW versions.
> But itt is not just the HW context that we are caching here. We need to backup
> some host side driver/lib info also to correlate with the HW context.
> We have been debugging issues like this using our Out of box driver
> and we find it useful to get the context
> of failure. Some of the internal tools can decode this information and
> we want to
> have the same behavior between inbox and Out of Box driver.

Can you run some kind of daemon in userspace to collect this
information in real time, maybe using fwctl or something instead of
having the driver capture it?

Jason

