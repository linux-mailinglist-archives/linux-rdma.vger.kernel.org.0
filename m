Return-Path: <linux-rdma+bounces-10627-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B92AC26E9
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 17:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3FB3B9C8A
	for <lists+linux-rdma@lfdr.de>; Fri, 23 May 2025 15:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919C4296D0D;
	Fri, 23 May 2025 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlOb9Iul"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CAB295D90;
	Fri, 23 May 2025 15:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748015773; cv=none; b=JyCOxXZiQ+iJgoS7MuSEfJNbBMI3x2vySeiibZrJOs36BGOTIVPNB0YL1dYJPfmpBwcX6JScSvi5k3rki6dqzutFCOF6uI4wnn904RNatWJ06i3UlvuxoPQSSBVNV2e2PbFdBe/WAQOspcePJ2ewkmPZwIvjGeN+tKZmGaJyW/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748015773; c=relaxed/simple;
	bh=5pvf5x5XtxRnVgFiXZHZfx9oEp+sGC7M/RUbMH6h09E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qx/1n1KjShrGm48sG38qjJCVRbOh7BaensiMN7AdqtvxYh0F/ohMfxH3ypoOzsIVz96CqpzkN+j1N3JUuvE1vKlWij7O1n8xro94zPRv0SROk8nWgOyZ/eRObbiieeVN0WUlFhaXA1z2SzqtYupE2VO8sYxDIdrx4Ya993d98PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlOb9Iul; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22e331215dbso8184705ad.1;
        Fri, 23 May 2025 08:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748015771; x=1748620571; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MLT+uQX19F9bBoqE2pQEDskDLYwN2bAt709I0pDdcEE=;
        b=nlOb9IulH0pEDufTz2ilSyh0DmZvul+d/3dkmR4Gg6iFpk/SyMV+OawnURqzfOIZxI
         l56Nyd38Gjt0givtyvn8bZcSFo4NNyhBMr7pQatVFXsQQCCskLS7xZGclF2ui/C3Lrfh
         jYZ3dSXNeJVWFgOYS/MtWntqwQmVjBHEFGmdaxzUrRTguXq0nJqm30GzoF9mFYIezP+c
         mh4yY09DElHfpDaNLKZ6t+DpHSCx1DXGpKTBUSFL/j7dvzVPJ76M89sYcdyyrPNOIXHp
         4RxwiMgMWiawktZo9ecj2ISiIsVVDKuyHyvGUmEHjz6Kjo1AXuynDE0G3Y/xaOI9CcOT
         tIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748015771; x=1748620571;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MLT+uQX19F9bBoqE2pQEDskDLYwN2bAt709I0pDdcEE=;
        b=HcEIpOokg7CQ63MrC5r1eD6VQx3KMGrgkgv9pyg1HdVMgBBOAjDJEFOnuJ4w2GQthV
         Wo6ZyYBCgr4wG7eCNBKEhpUkVtw8IaXhY+0FN6osp9z/b/rDvR1Io97fYnGveF7n58Xd
         TAH3Q5m7RJMdQnj03il1AIoJSw6GeOgVc68HDMt1Oz4Q8hHaqBfR80fpKHysD8S8bDLs
         fTRlYoTiIFP+6p5u4g3fcxOvVV1ZvdjWy211gK6x4F6RpSNf12WF/WeM+z9XM5yVKUf9
         L5LkDIAv9za/TMoNVf/KaRanyHdF+npWE4g7xbRN34mBp7/80p9yiDYbu8wLEShH3bu9
         BEjA==
X-Forwarded-Encrypted: i=1; AJvYcCUNI9uUWYdvukKvccoH/nYaq7L/n0iG4jIxUlF5DPaBBxIl3RFEL8wLXiVv+H1kCFTI+fvvqnBuik1I@vger.kernel.org, AJvYcCVI7rd6qLYZ2mr/INaaUMvPgOgKN4SgLc+2DdHw35KB+JyQnjD/gzQeyY4uiVuNivQXfJ8fQSaPCU/9iCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjKZ2qYliZiyXzLG9YAdJML/ZJPP0JBjfYQ64mDfNZeJI8xZqd
	84PCDNSQMMYgkkOApky6A98ryUbz1YjRaU5zmlb+Pq+iSDjQtR0opk16
X-Gm-Gg: ASbGncs5ysttpNllfQWP9EsaJO8LARzfNOAtAG/egpjTV6rU358u4/Tb/TZ/f5D2/Cd
	t25yjKa2L5DkAorFqPzZfjQaEYYCQ9AVRrcIRHqeJ3VOuGoQDZMvee8x0gaz7UCi+kLReDBt7FX
	V1JjanjxQANFJPfHuuIU+x9kJ1ZoCPXHYPtY8c1qn1LuLqviwglXmoF9DHdjahAtY267WaSlWE9
	RB8hoHPZG5nPOMuiNp3zeuTE0PX2JSOdBvMuNdam0hlMPu9UI9ESs9MBbUPOEiyK9F30yY2ibUJ
	O1oxXfV4TlzLpSb/VTAxn14cICfKK9yLm1OhPOOrwbz6M6fNM93nYbTzqeQszp81ZrLsOHcMOLM
	qURv1jog5hRQQNwqci3po6q+ut5lFfP1Iv55MPw==
X-Google-Smtp-Source: AGHT+IGOIwQ2AggBrcacbPHuVkzZ+QW52xm2WCIsatD5itr/WraRhmPamkDAaKXDlrLbG/8nZCahNw==
X-Received: by 2002:a17:902:e74d:b0:231:e413:986c with SMTP id d9443c01a7336-233f06786c3mr49389025ad.11.1748015771210;
        Fri, 23 May 2025 08:56:11 -0700 (PDT)
Received: from [192.168.11.2] (FL1-119-244-79-106.tky.mesh.ad.jp. [119.244.79.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4eba4bcsm125491825ad.182.2025.05.23.08.56.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 08:56:10 -0700 (PDT)
Message-ID: <56b45ad5-b3ae-40f2-bf3f-d0718e3d26c7@gmail.com>
Date: Sat, 24 May 2025 00:56:07 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/hmm: Allow hmm_dma_map_alloc() to tolerate NULL device
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-rdma@vger.kernel.org, linux-mm@kvack.org, leon@kernel.org,
 jgg@ziepe.ca, akpm@linux-foundation.org, jglisse@redhat.com,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, zyjzyj2000@gmail.com
References: <20250523143537.10362-1-dskmtsd@gmail.com>
 <aDCKsK2-zRkqge64@infradead.org>
 <63702a66-4cc6-4562-89f4-857fe3f044e8@gmail.com>
 <aDCXcbKwTdG3w5ZW@infradead.org>
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <aDCXcbKwTdG3w5ZW@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2025/05/24 0:42, Christoph Hellwig wrote:
> Thank you very much, but I know rxe very well.  And given your apparent
> knowledge of the rdma subsystem you should also know pretty well that
> it does not otherwise call into the dma mapping core for virtual devices
> because calling into the dma mapping code is not valid for the virtual
> devices.
> 
> Please fix the rdma core to not call into the hmm dma mapping helpers
> for the ib_uses_virt_dma() case.
> 

Thank you for the clarification and guidance.

I'll look into updating the RDMA core to avoid calling hmm_dma_map_alloc() when ib_uses_virt_dma() is true. That should help keep the layering and responsibilities properly separated.

Thanks again,
Daisuke

