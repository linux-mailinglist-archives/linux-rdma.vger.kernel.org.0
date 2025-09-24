Return-Path: <linux-rdma+bounces-13627-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C578B9A7BF
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 17:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 626427B06B0
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 15:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72041C8630;
	Wed, 24 Sep 2025 15:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CO1LEN93"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D096630B516
	for <linux-rdma@vger.kernel.org>; Wed, 24 Sep 2025 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726608; cv=none; b=AlZK55Fk1ivz1pTryX3UaAxUQXE14PZO3PaR8rzgcN2APzsQ06ex1sMV+Oy1YDN5UwAC6zUnHpbuJGnuiyIODpU5yd5IQr7vNc5tXLZdfcwM37qGCPUzzuMOv2ckqMAi1ld0hlfFNbqwfRzl+13EgOuDzeDjn5ozqvPGaz9RbNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726608; c=relaxed/simple;
	bh=o9l+UpM6TnvuIgqAlQQqwM5+vFrRpxqhLUwLqQT6bUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p3vm7Fu0r2bODMhWT0+zRLyZd612y08giA7Ull2/MO5BlH3wyRi4nIr1emLuybTuqH/ujQj6WlHG3C/6FFTG2EHug3Vj6htrjKVCYH9w4zg6jMD1C2lHx/eO21gXK+T0vudfzgHB4mcKmpQW1ZsonAK1cTZijnhFOoJ/u7+qTh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CO1LEN93; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2698d47e776so51352855ad.1
        for <linux-rdma@vger.kernel.org>; Wed, 24 Sep 2025 08:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1758726606; x=1759331406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YKov2x3Z1C460EYUujFQHxRe53csDS7SRInDm9gIRVY=;
        b=CO1LEN93+8XO70USrOEjH8LXzlaNqj6qfjHxvOzb1e29n9TjgOBgFHlZDAHdLiD+LO
         JKQ88PLbtcu3Sc2j20AFihSUH17rbqNApNBmaK5pIAQAGCtoSNrsicxf2T/NUIJHfQdn
         /cNmM3anfJGPYlBj+PezRPcQrQqar389jsidbUeq+EsRsWPTZPGLyrmRkWP9EnPWL9IW
         IaqzDRsNLVEOCcU/IoyaoxccToeNiafSCEpu81SJAHKCHSRO52ntdwebhSl/RnvVL9RN
         Mo+xC05YxKK9p/MA4RSUOklvFzdB5P8fj/H56T2JK1TU/Sf98a6u/LMmajeh2G3YHGrb
         8ueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726606; x=1759331406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKov2x3Z1C460EYUujFQHxRe53csDS7SRInDm9gIRVY=;
        b=TpchwfUckHf/4RYFrSAP9fJe/J2tJ+Ag4arcLeGAQ7ix+sBM3fCFf2ZR5MvmBZdEKA
         4swm+AO7QKtc2L7Dlqda+dj/NF8W/s/5wT9bOaWrvG//XInWZUHlPdLiz2oHQk9/ttMD
         nT0s8lGkFSmuhnxSneMwVD9MxP+FFBhuFN/p8UUcZl1JUPbJSN35cWxN+41S//7oVURp
         ko4jNUc6wg6+Eo+ySq/rnG2cy07Ea5I7oeaoNtaSfTnu5mHW314u0/J7yErMvlSxsneO
         58rr3gSlvhtjpNoIjFDWesCVI4+Z/R5GYZQWQal5RsQ8KYoK3YJFUly4EdNFQZbumMdx
         gWyg==
X-Gm-Message-State: AOJu0Yzxrm0h6gMsgmS5r7qwQFxh4D8r2+Ce+JdxObyv55NQxBqcvOQl
	TYbilzgXBg26rGss4awI9BqnheLx6mQZ7OObUV3GrIxIgG5DIv6gxbpZw+ZjYNk3LMU=
X-Gm-Gg: ASbGncvGGaMKSNZV9kJm4pRvBXcksk5D6QeEkKGo14nCpiAQ5EG6LiWVZoScA4/GWcB
	o4cWT/2XCEBzvKERxfstwzlUlLwHN2rTyDd/Mdx8p0rnz1kyOV8Ug+IA0qPbypE6UocKlUCxnfk
	AuWB/v9jhNLifPuvBIDOuY2qPvWqmk7Usb1AriFSCCyZdsNBVgXes+AY/mv1NnSYpCvNnjoPa5l
	QBMqiN6C2yB2Un2w+f/V6dU+P6ZAq3UGu+h9ZdLbs/AsokpNN1oQXrfUVhC7+FjzjHUyR2kuqvu
	pEjDgGXuemJejlGmgoObgCetzgI77nyOH0kiD6TxIQtgYOd94EMQSy/qYeQ+D97KGbUBUxOb
X-Google-Smtp-Source: AGHT+IEgx+qHnsS6Q7aqCIQPwDj5ptlLouPvJ1KZj1zhC86yYDGO9mFDajeOyDgyihQlbs/qjdFEtQ==
X-Received: by 2002:a17:902:c102:b0:269:b65a:cbb2 with SMTP id d9443c01a7336-27ed4a46418mr446155ad.47.1758726605948;
        Wed, 24 Sep 2025 08:10:05 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26cbd206904sm153909175ad.0.2025.09.24.08.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 08:10:04 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v1R86-0000000BEYn-3u9r;
	Wed, 24 Sep 2025 12:10:02 -0300
Date: Wed, 24 Sep 2025 12:10:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Stefan Metzmacher <metze@samba.org>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>
Subject: Re: Does ib_dereg_mr require an additional IB_WR_LOCAL_INV?
Message-ID: <20250924151002.GK2547959@ziepe.ca>
References: <656eacb1-a39f-4b59-99db-5522d102468a@samba.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <656eacb1-a39f-4b59-99db-5522d102468a@samba.org>

On Tue, Sep 23, 2025 at 11:09:48PM +0200, Stefan Metzmacher wrote:
> Hi,
> 
> I'm trying to understand (and hopefully simplify) the code in fs/smb/client/smbdirect.c,
> related to 'struct ib_mr' cleanup on disconnect.
> 
> Assume we have the following sequence of calls:
> 
> ...
> ib_alloc_mr()
> ib_dma_map_sg()
> ib_map_mr_sg()
> ib_post_send(IB_WR_REG_MR)
> 
> On cleanup we currently us something like this:
> 
> ib_drain_qp()
> init_completion()
> ib_post_send(IB_WR_LOCAL_INV)
> wait_for_completion()...
> ib_dereg_mr()
> ib_drain_qp() // again
> rdma_destroy_qp();
> ib_destroy_cq(revc_cq)
> ib_destroy_cq(send_cq)
> ib_dealloc_pd()
> rdma_destroy_id()
> 
> Now I'm wondering if the following is really required:
> init_completion()
> ib_post_send(IB_WR_LOCAL_INV)
> wait_for_completion()...

I would say IB_WR_LOCAL_INV is redundent with the ib_dereg_mr(). There
is no need to invalidate something that will be de-registered in a few
moments.

Jason

