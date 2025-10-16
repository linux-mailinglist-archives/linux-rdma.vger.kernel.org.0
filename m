Return-Path: <linux-rdma+bounces-13905-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE4ABE4F7C
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 20:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D3C84E6466
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Oct 2025 18:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7858B3346B9;
	Thu, 16 Oct 2025 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iC3bRjvN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950632153D8
	for <linux-rdma@vger.kernel.org>; Thu, 16 Oct 2025 18:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760637673; cv=none; b=UbTyDGRf5NJO4RIgTvo9+NoxFCmnItNG13SkF2aoo056/5xOSjMox+53z/xBzy8/2DAzs/8/N9vGRe3pO42uzqj7xFEgA/Koj6Kb1kfw8UNxyzAZVWZIFRo/c8xRxlVSsc+Y6w55H6Hv8QbXkDdoRHVyZzyG3tnIN0Z2s/LT1hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760637673; c=relaxed/simple;
	bh=UEZSqC8DG+AeJI1N/uJ8S8bsTsBgDQAckEkKFSw6cKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGTVTMNRdFY55fhhU5HbjO232pWYY0HCFABxm3oIUCgOCP2A+aAyk9agIdjte3FsQ/js67XV4Fg9isRGra52n2nYvn8V6wr3bjEwI9OVSuyHKTzozFQIX60TTKmHAWXTQXH4ClwBPauVDZcAR/tn1f+zhlRVpo+iefHg9rWmZ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iC3bRjvN; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-791c287c10dso922256b3a.1
        for <linux-rdma@vger.kernel.org>; Thu, 16 Oct 2025 11:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1760637671; x=1761242471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UEZSqC8DG+AeJI1N/uJ8S8bsTsBgDQAckEkKFSw6cKI=;
        b=iC3bRjvNIw5qwAVYBgZ08fEjEz17PEa3TTYPZrjQ8/K3f4iwECCE7lorl+2dDp7GGi
         lGBzjpy1TLzKFCTZLL1BF3AHsENRiK0LU3tetyXOfzQrDzIcwlN65bZ7/PePj9mjUZ/4
         B69D79oEMTtitzl0DeJgvcOWcPRhhqTNOkobPOTvDqLOEhF0EoqZxrWrYxlHa7FQWmZ/
         OZ1c6gWsUuGmseiQswL5VugeObDD4ILLM3ft6gDSazn4oNK/Xm47O2LncpzxSee5dnEc
         4knjapRngF8fxaa+UV+/C+V/SJ2AdrT6ccHSD/DbnEGmIvgJI8VNzjWnNygWYMqDW1qJ
         1K3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760637671; x=1761242471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEZSqC8DG+AeJI1N/uJ8S8bsTsBgDQAckEkKFSw6cKI=;
        b=W6smxqpv48oZ+Qhf6c/8ilEYmayINjSKFnyf/qYsNQ6EIzcJhj7MmWI2lZ62nRtRIK
         UFzGPEqprvYxXcpKFABk/pyL61vR7eHDATfD8AbFrAAj/8BA7aVRmihr2V663MojEV6Y
         me4n6FoMMFxZG2BOh1vLiAljfnI0f+gstN+ne+Q+qnbvUdIuFYgEXZtV+ScNSo9eLbxg
         90IeixsKDerzZMaWDncWEYuh1M9kA90jNP+jMJyz82Xsh22V/eR9ycdd7QeRqKnsN9HF
         ZMz/R1rWDYF3X376tB8l66hlhuaSFSL/4zNtJrYYb248zx35Cd+ndNw8pRpA+/ZlnJ8Y
         m9OQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdHhAvZiL8KV6TFx65WO37oH9OVYNJtYC8OaNG4gm7y1B1+yLcgp6xXGIrU8+l79/vHekKy1cBlNNk@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ6toWNxLDHejZ2tyfM7IXBh7LKEihDhLzrFBaSNpTEBa6hPPA
	+IyQ4YT0J/jLZr3jkv/0Z5QTkqRaB0Yps/Ao+3nLz++UfY1WMqNz9hRcdywum4aie6ELiTgxPgt
	JRPes
X-Gm-Gg: ASbGncsvkg4/810Qf6giVtnjm3sL1VASh9LYFMhLEQ7oCmF38Ho5E8fWbi2TbOYdOgL
	oZt3P2XVAIMHqMHdwvS7rkxQZ2VG8jBVkC7N+YFzivmYZI4eHZ/mzV8jP5/khkFpRd0QMTQ4DHv
	MtQaTUdAGTKsQsREEh8e6/26CdiBpX31ur34Ft0/kNyTJyMt5NCRmrK451wngNJvDisPLBj7v8i
	l34NmWpJyoBd1xj+IdGNSpiAZTC5QCZiuo5jexDzvs8p3ThxMbh4TucssMw7fhf7bKGgpaQuQ7+
	u+RyoMTbIBK4wav1vc6DuUnnSmSZgDxG/0qxmAokBxpsRv7MVd2Ze61ME/T8FSNaJOfJTnbwVv3
	PfxdkNXgiyhJx1AOguBSfo8hAjhFZ+PZZzPUz5Pz99HuyiIrs74WXJcyO4zmS
X-Google-Smtp-Source: AGHT+IEyG6ZYu1U6Nn8RDvsAS7EbrXFkX0+ilZLMRwbsGIkqOYw1gFQPq6bGSrG6RDqNrcU0ZyKvdA==
X-Received: by 2002:aa7:9066:0:b0:781:155c:f9c9 with SMTP id d2e1a72fcca58-7a220accef5mr837410b3a.20.1760637670510;
        Thu, 16 Oct 2025 11:01:10 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e275csm22976026b3a.61.2025.10.16.11.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 11:01:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v9SHk-00000000xL7-1iof;
	Thu, 16 Oct 2025 15:01:08 -0300
Date: Thu, 16 Oct 2025 15:01:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Haakon Bugge <haakon.bugge@oracle.com>
Cc: Sean Hefty <shefty@nvidia.com>, Jacob Moroni <jmoroni@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Manjunath Patil <manjunath.b.patil@oracle.com>,
	OFED mailing list <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-next] RDMA/cm: Rate limit destroy CM ID timeout error
 message
Message-ID: <20251016180108.GO3938986@ziepe.ca>
References: <CAHYDg1Rd=meRaF=AJAXJ+5_hDaJckaZs7DJUtXAY_D2z_a6wsw@mail.gmail.com>
 <D2E28412-CC9F-497E-BF81-2DB4A8BC1C5E@oracle.com>
 <ABD64250-0CA0-4F4F-94D3-9AA4497E3518@oracle.com>
 <07DE3BC6-827E-4311-B68B-695074000CA3@oracle.com>
 <20251015164928.GJ3938986@ziepe.ca>
 <CH8PR12MB97419E98111F553FCC117E36BDE8A@CH8PR12MB9741.namprd12.prod.outlook.com>
 <20251015184516.GK3938986@ziepe.ca>
 <49A8CE60-DC8E-43F7-9620-D4D5F8EB2A08@oracle.com>
 <20251016161229.GM3938986@ziepe.ca>
 <6244F8C9-2067-4A8A-8DCD-02A4A2D117F6@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6244F8C9-2067-4A8A-8DCD-02A4A2D117F6@oracle.com>

On Thu, Oct 16, 2025 at 04:43:16PM +0000, Haakon Bugge wrote:

> Well, I started off this thread thinking a cm_deref_id() was missing
> somewhere, but now I am more inclined to think as you do, this is an
> unrecoverable situation, and I should work with NVIDIA to fix it.

If the VF is just stuck and not progressing QPs for whatever reason
then yes absolutely.

At best all we can do is detect stuck QPs and try to recover them as I
described.

How hard/costly would it be to have a tx timer watchdog on the mad
layer send q?

At the very least we could log a stuck MAD QP..

Jason

