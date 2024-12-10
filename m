Return-Path: <linux-rdma+bounces-6390-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A20F9EB415
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 15:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD4A162B55
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2024 14:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112211B3924;
	Tue, 10 Dec 2024 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Pm8K3wNB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EE91A01D4
	for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2024 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842591; cv=none; b=PLXCc3xDbLXzAiMMLLe2T5dLEivO/RNLi2n1Efhoii9h/4U+TLVuI/SV83BLp9jMTMhPaPgZzgfnGo6LoCd83CfHzH/wie/uDiU/BrcpIc8yy59nnRlije9R6w2ZNaK5/fzEMhIJisO3v+56yr4/3KJx7UcJonjndXx+8qxTHy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842591; c=relaxed/simple;
	bh=im4r83/3MFTa7dU7WjsfCIHgV3XDNMNtyYTcEIAa3z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a3vUK7zT9NP4+a9+qGKg6c0sI0B0dNtC99oloRxxIAwVK6jrcKs+OkjRXsXZVYJ51t0n6po4O6QJRj/Fv2f50SjEZOoOSCnEfqtGONFMN9NsmmIuSuP54pwo007pfPxvSpHlYaNviseczU9L5fNf7ldJ40lCfBdQ94IZkLkJI9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Pm8K3wNB; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d89a727a19so58453006d6.0
        for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2024 06:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1733842588; x=1734447388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vgMZyCVjX5UlsD7+dFf6mQ2S1Ak5PnTha55MEVmA3OM=;
        b=Pm8K3wNBSj1m7GHbbI4soC60iHHFwwoxdiH62co67hwkh4aaH4/lmB+Oag3Ux8WN04
         gttW0Bu5qGe2wi8ZVcJlS2uxOkbyDnGFrhlIq8bsFu9hsB1iblkelcoOOy3Dqe8d2PQn
         5vEMIWHd5HWqKPkNnL8QbzccxRzwM4E67Nw+jnZXWg3NyH7eSzey+inBooGC178ZMloJ
         6AWtNaF2QAwbiWAVeB3ofcaDIGoFZn0ifb0oDfE95TR8EWeL6LLgxY5nEPWAtVdbhW+F
         qDcY9WRmEipe9S5yfF4jzFDDa4+lVrRBGQyodQLyXzCaouD2rQfhrlKhSmkylPpHQI8n
         FELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733842588; x=1734447388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgMZyCVjX5UlsD7+dFf6mQ2S1Ak5PnTha55MEVmA3OM=;
        b=ZYRPbbcywMofurpiMgSD7mjwu1HECWHgenU9sosZ/WceXwgXdlJOCM6UHk+uy5EzHR
         U54idzz/JzVOMbixFnYvNdo2bUqZBRKqS8rNjmXX5BVWOnHX2eGZAvXPyTPzjzbVyKVx
         Tv4OCYNFkuYPjAWgOBMnm8bPqd9d7mP0rUe45jq7IW6gOVTzUJ2m1aq47U9vJEPbGnlp
         GsjBHRLLhiQ5rffTg4cO7Oa2uG0nulP2ovdLpBUiOHH+Nsze1GSdLS4lorVomzMAVfAE
         +a9aICiYUARXbAlWSveTUzaLLdFak37kwF7TcNINiyoAUJSF2Yxb9WBdu2kJozxvw6Kr
         bJYg==
X-Gm-Message-State: AOJu0YxSWV8OOGzd6UWtQZVIHYwKj4x4H86uujUlFWe3d9dywdeawpdG
	VpMaYjWVcAJa0rChmbJlENgfG6vFcg2HK2D5OOLeDlc4e8xOlYpyBPQufDUWC7o=
X-Gm-Gg: ASbGncvLCwNi2m0skcclKxWmDQgfiMsJ9+FTQ3o32D77HdYETvdeJ5HlZJG6knYEHHL
	ld18dMVHvRISLFUB3magrWbzzl/C/jKxqINQVsLiJrNGnIZ+eG6StPVuFWKkxV+dvGL8qcHGf0w
	Z4fzFZLlZOVUrfO+7e47rOPSVHoQtpDmkNszOMJPcKdkdbBZT2uPqI3G1EC5RS1Mr4dq+vt0s2d
	v9L0Wv3HLfiLo0+BxkPMbzxh/x4tOws+9ai5fzi5YcdL9/fXqi7Svt0G1NTEi4FzrejrHXeiU5X
	r3gvYZdFVOuzTh+KASezArq49dA=
X-Google-Smtp-Source: AGHT+IFfM8EwNH3V/eEsdSGmByzZEtkSueHYuu1In0U8rV2p/p6b9CdRa4FvcdwQ1MsV2//64ZXC7g==
X-Received: by 2002:ad4:5304:0:b0:6d8:a258:68bc with SMTP id 6a1803df08f44-6d9212d61c8mr48969336d6.11.1733842588496;
        Tue, 10 Dec 2024 06:56:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da9fe9e1sm60627086d6.82.2024.12.10.06.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:56:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tL1f1-0000000A2jg-1ul6;
	Tue, 10 Dec 2024 10:56:27 -0400
Date: Tue, 10 Dec 2024 10:56:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bernard Metzler <bmt@zurich.ibm.com>
Cc: linux-rdma@vger.kernel.org, leon@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, zyjzyj2000@gmail.com,
	syzbot+4b87489410b4efd181bf@syzkaller.appspotmail.com
Subject: Re: [PATCH] RDMA/siw: Remove direct link to net_device
Message-ID: <20241210145627.GH1888283@ziepe.ca>
References: <20241210130351.406603-1-bmt@zurich.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210130351.406603-1-bmt@zurich.ibm.com>

On Tue, Dec 10, 2024 at 02:03:51PM +0100, Bernard Metzler wrote:
> diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
> index 86d4d6a2170e..c8f75527b513 100644
> --- a/drivers/infiniband/sw/siw/siw.h
> +++ b/drivers/infiniband/sw/siw/siw.h
> @@ -69,16 +69,19 @@ struct siw_pd {
>  
>  struct siw_device {
>  	struct ib_device base_dev;
> -	struct net_device *netdev;
>  	struct siw_dev_cap attrs;
>  
>  	u32 vendor_part_id;
> +	struct {
> +		int ifindex;

ifindex is only stable so long as you are holding a reference on the
netdev..
> --- a/drivers/infiniband/sw/siw/siw_main.c
> +++ b/drivers/infiniband/sw/siw/siw_main.c
> @@ -287,7 +287,6 @@ static struct siw_device *siw_device_create(struct net_device *netdev)
>  		return NULL;
>  
>  	base_dev = &sdev->base_dev;
> -	sdev->netdev = netdev;

Like here needed to grab a reference before storing the pointer in the
sdev struct.

Jason

