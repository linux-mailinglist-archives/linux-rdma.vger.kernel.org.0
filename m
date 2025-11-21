Return-Path: <linux-rdma+bounces-14679-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C9D4C7BF2A
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Nov 2025 00:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB5BB35AF6A
	for <lists+linux-rdma@lfdr.de>; Fri, 21 Nov 2025 23:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9803F30DD0C;
	Fri, 21 Nov 2025 23:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Xg9d06II"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC482FD69B
	for <linux-rdma@vger.kernel.org>; Fri, 21 Nov 2025 23:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763768001; cv=none; b=E3/UHRW9tBwxkS0kTJvQv3m2bQ3kuE4DqPoET9v6+KzORbSiDECiphDNl/LlAU+7I3sDFx7E9HjcP6nmqv4xCrWqtuZIHcEDi+tUiC1zybveFlS4JkY0xE3ipvN6R6MLbAlRlA6o3K8nqyc8K7hVKuNwGts/WXB/FaTioDdBAWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763768001; c=relaxed/simple;
	bh=xAGh0ts2floZWwDEfV+Yu8A8RKbixRtGrEVLTVHWIJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZD2/rXGvlou2TMxiaeVHznXiSMbcWte4n0QZlvZl7rC7fUjsvH0mf3zBWdq524Xjlt8uk6jwTTvldx3dbLdqz4Vtqqulpx1m74SuklOA/am4xzftaDds1KKIdUSpC6/rdg/bQR4i0zHTjUvOGgx/Bh62UPuQs7QNyFu8my/1VtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Xg9d06II; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8b2da83f721so275157085a.1
        for <linux-rdma@vger.kernel.org>; Fri, 21 Nov 2025 15:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763767998; x=1764372798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AWnSaiuoF0IwlPRvAcihuHYW8Lf8onBYseAoqkGV8k4=;
        b=Xg9d06IICWBDMfLcfi1S/li4oL1nyDoRvG8ZU3G7Esn9f5BouQD9sSdtjEAtrC+GNu
         tlSxW/Y23mYDJSJ3+3xS32fhBeSl6O2Za2HexFDf7Kysrjl4n7CmxJus1h4AO+qk1F4A
         cM1GGdV5hshyZinIw3EzSi8TCl7Wb+yWSS6tzUmRT+6wTeN4ZCUYdVjroM2ZswSSI8KY
         RMXuBGfGDCyNRWPw5qEcTwochrhU6moxcZDqkrfsT66PlhfA7dqR7TxWRdxc/wM4gFnl
         vsKVn8Uki3eU1XcyFcnm/RtS8RsJWPGERpDde1OA+hb2tzWyFjQ1l8b2BdqaJAAxt0FH
         DNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763767998; x=1764372798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AWnSaiuoF0IwlPRvAcihuHYW8Lf8onBYseAoqkGV8k4=;
        b=SUUVqMw9EPD9I3pXFT3/STWwgzRd7nsNSzMMZ6gBncINJy3tc6t53XjD61eYpcDTNu
         bj7RyfT3VCr5SGspIbCiX3UU43q+DC+7B+rTgq7XTcMj9FyKBdhC4ZLusnvQYCHhF4OB
         3a+sjoUiXVBmv18ssyC4DgpYpK7cWlvMgjmUrpOn0cnUpVBE53ci57fegKyYP9yHj0Wx
         J8dHVdoVjOKTlU43pIVjzQRE7i5L2f8aBoC/TkCybFjjUvisTQb0iLOlkkQnLgc7z5Pj
         YmANKut0FUVVd8LZndDEFDLZBeMmHoFYCkQs5bp0XF+8sFHa7m4845Q69FgaueGT4NsN
         fb3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWnRVQ2YXaxd8BfzBH+sXHJasWaiWsir34oKgBzkWlqhy8b/f3335rtYEoeGWhhSZI6Eh6OoxxlnZmE@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtv8+0ofXYVUO1ACc6TYnciODcHOaFa2zwSRF3T4hnlgawngxk
	GY/FWvjmX9s7Qb7zIAg+HH5cGtVuVlwC4q6SS6xsLqXetIsMmxsJI4HC/3EbazCRj5BrCAE+R3M
	IPPlg
X-Gm-Gg: ASbGncvZoJt5F8nz1xJagRdqDUvHvpmCEnkxK6U3yp52YsjJOsLhLyLya0rDWcLBTp+
	+noiN4+hW6Cb2TnQzSsxXl5Kx6cLqwKJTHZem8d8+ojlaslrnL5ENp3B7EGPpAtpDp/bfdmInjK
	yDrAtELEow+0JgLwxwJPUQ8WAIZJtGCkEiFeI9nZuV4vfDJB4I24cSvvRqINBrAmOaVjwk6FwV7
	vkQ+ZdC7gOK/GE7yT4UVI3/OU5YOvkJMYJOl8hYl5we1wPIeY1jYcnKSBMVHjfOx7jEpp4k4VxQ
	fSpSKyzDcCGDNrWK2YytSJ9d8au1wiwXEn3oRwdncs1kW5r13J3qfs05C5kEdVfNGagTWdGbJQX
	xkg5H3hnrjcq3u/yxIWJoduBf5jr8Xhf+SORA0z7/Cv4UTxp6S+8336BjxDl7lHaXeZFklVtcLl
	vS81pyqZmGGcbdjf9cNIiGxfwCBTPSQBH8SkQ6quPVUx1iPcYIWs7opyIt
X-Google-Smtp-Source: AGHT+IFh1xlvtTM4Nxg0z5jvDoCGIE9FMR0vLdhGZvmPzgLgkxKDKLomuBekhC9Ke76ziU7Jt92P7Q==
X-Received: by 2002:a05:620a:25cf:b0:8a3:2850:5771 with SMTP id af79cd13be357-8b33bde9a5fmr676014785a.34.1763767997991;
        Fri, 21 Nov 2025 15:33:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b3295db543sm454734785a.38.2025.11.21.15.33.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 15:33:17 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vMacu-00000001bcR-49X1;
	Fri, 21 Nov 2025 19:33:16 -0400
Date: Fri, 21 Nov 2025 19:33:16 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	"huangjunxian6@hisilicon.com" <huangjunxian6@hisilicon.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [????] Re: [????] Re: [PATCH][v2] RDMA/core: Prevent soft lockup
 during large user memory region cleanup
Message-ID: <20251121233316.GI233636@ziepe.ca>
References: <20251113095317.2628-1-lirongqing@baidu.com>
 <20251117174738.GE17968@ziepe.ca>
 <02011baf337649f6997166f223417417@baidu.com>
 <20251119190602.GN17968@ziepe.ca>
 <4482842b3e774a7d996130b0651d1923@baidu.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4482842b3e774a7d996130b0651d1923@baidu.com>

On Thu, Nov 20, 2025 at 03:28:18AM +0000, Li,Rongqing wrote:

> Thanks, I understand
> 
> To minimize performance impact on releasing memory regions, call cond_resched() per 4k loop, how about the below 

This seems like a reasonable idea, though I would just use % for
better clarity. The compiler knows how to convert that to bitmasking

Jason

