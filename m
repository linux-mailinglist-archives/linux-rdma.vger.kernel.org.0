Return-Path: <linux-rdma+bounces-12974-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C414BB398F6
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Aug 2025 12:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 075651B272C7
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Aug 2025 10:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223BB3043A4;
	Thu, 28 Aug 2025 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ul1T3Pj4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2B6301477;
	Thu, 28 Aug 2025 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756375233; cv=none; b=efW0GOAsi0NyEdkDW2imYqmFNysaNd7ZLSE4rHtcMc2QtCJxDDdx4iZ93RBODGSJCGCmX672jF/c0TH2FL3AsNHqTkO7EntdDT7qaPJz2Q1RjQGSobPh7+QErQO7ctTCU7+ipWf5AUUWyvK83uFkED3OJdXDGjGXmr/2CtsTddA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756375233; c=relaxed/simple;
	bh=HA4dVBi8aqMDUcldqnQpGdSm3y7+poiy6y83kJRmjbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXiRd654twyeZBN9lFHR8gpBmHGxFHDCTuDwbzfeodeGEUXtD42MfL+T0yvs4ToZl+bNQ8QtLP2L89QhJwyT9u3dBagWQZpb0KNJo7ULNViYzlY3bZMkRjSuVjReBeVFbqfYpIgMNUFw5hezeEmNuOeHompp+aqfLYr8yQAdNhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ul1T3Pj4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3ceb9c3d98cso12124f8f.0;
        Thu, 28 Aug 2025 03:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756375230; x=1756980030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FEeRKz6nLfTB3/Se8Z43eEXG5xuvc5/iRyjLLOsJT74=;
        b=Ul1T3Pj4k+HT2K8Hqby5uxl15yN18/IPblW0TZR670xiaO1bhyjcTuQajHmSkpKwN4
         /eNHMi3RtWPh+xXShdTrnyYSQPh+mvZkPKzRpZo840AfnQ91rpighg92amW1EfAE8w++
         6D17+Y0FoqO2Y/bGHAvxLW9N+WUXE2CPUrjrM2XpY7PB0Ha72y3KHSLcMz4c8X6YvAgm
         CbJ26oLiWMQ65rw9S2mxOPr+DjovsNqi5d7jkx+8TpazQ+raxzLzUlYna7oH/mFBEhwW
         umsJMnfgg4Bd2s8w6ZNfPbupv5ZUqoRQs663f6hHYiGotjBy6IyvtcFSK73r9RZo3u9j
         yHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756375230; x=1756980030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FEeRKz6nLfTB3/Se8Z43eEXG5xuvc5/iRyjLLOsJT74=;
        b=RGdBaNqtvL2RXuA19Z7IoNLTq4rQdR8fNxAUrK5Uy/C0vU9bJWrhvEmpJroQ4zohzM
         VWq5Kq+4roRbNPQe4X4c9qcmZ80ef82AwpE48DufLuOAq5ElX56OvlJxkt/qeOVhajyd
         FYeWmpRM4cw68UpfeOcTZI5HYzQVUg2bCLqR8NVHivrg8m+ecW2rQlsr8j4+b88RjEYm
         F7zpEPaEZ5pHBClj6WXX35jr3Bp/monf393alXosYgrZGDu+0Mn728+NL2maiLZFS6Yv
         RkzYUV4yYyaAJO1owfzk75eqDJD5a2keDuBRV/WxpIRlJiu80BCl6AcUuLU1ljXHaw8G
         pWAg==
X-Forwarded-Encrypted: i=1; AJvYcCUkGSVXdCuI+336QbepipDgTDFyOM8SyEhBr1BHiRJ+zFV6UcKuSf6ScGjzq9fJ1VGT1Z6PYGXRXti5Rl8=@vger.kernel.org, AJvYcCUrRpaRcHjk+gkMfbD0W8+EbpsrFwGG0DZu+idFrVqBLnbm5zT3E76YPnSDSzL0+KHrExhz5I+XcJjoYg==@vger.kernel.org, AJvYcCXsnOOOuMjJI2q7mne/9WjBueX0yXHaXH/OdhQ8BJo00RUPEK2Bkp5jzgr6v3TkXR7HU0gvfLpb@vger.kernel.org
X-Gm-Message-State: AOJu0YwRUL52qFsD4A8t3C9kQ1QLc81Rf6/8x7DTncqpg+M4zrt16I90
	ToJnjYod8D6Z8XqSHdMVy6UoRCAdHAtac9Q3it+zif5rWXVSXoDYBIxq
X-Gm-Gg: ASbGncsWMDzmrNCabCYiVgZRNANFYV0gGG52sEzj7oj3J959QCbXbvfv6qb1NQwHe4Z
	SsjU3c1Hd1exzgiSc8dUZrVxLHjAws7c7ssDA9hA1tlR3fcIV149t/lFygsnkUz3BQXpEG6bNjb
	FL/2m3L2G6BurVHZYrAg3+/ZW8WPYYpzVzb4ziXnMbEU93qeJEp4jfkhJdBAbBYfCAdgEPtFdAx
	PUBnjY/5N+fkUJ0uERZuhY7xlnNACY0HyVQXAsXO3AChbbiWWNeQ2/zHQQkj7ODvWgYFoLybqvU
	XH99hGuvZupri3VwVXPX98E3eNLIzoCiCany3tOO5kA75L4Vq/co6xs+mSxK7ymeNSVVgAzEmAL
	/NlmMmUQ8Q9v8jBDH1M/HBxrzVQJIRM7fi8yxI+GsB0eH1Im46vBcTjcOIsgP6iNwItkdODds+e
	dOcr2aLT/zwGklfuk=
X-Google-Smtp-Source: AGHT+IGvDElhIshKN88Vw7r6kxnwKoQ3BhuXfCKhAXN9Dss/GFkoWkJ0InaIKnuWGBYhW3CBRA7MsA==
X-Received: by 2002:a05:6000:24c5:b0:3cd:3643:cb62 with SMTP id ffacd0b85a97d-3cd3643cf21mr3267637f8f.6.1756375230266;
        Thu, 28 Aug 2025 03:00:30 -0700 (PDT)
Received: from hoboy.vegasvil.org (91-133-84-221.stat.cablelink.at. [91.133.84.221])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b797dd1e7sm25100585e9.19.2025.08.28.03.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:00:29 -0700 (PDT)
Date: Thu, 28 Aug 2025 03:00:26 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>,
	Carolina Jubran <cjubran@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next V2 1/3] ptp: Add ioctl commands to expose raw
 cycle counter values
Message-ID: <aLAouocTPQJezuzq@hoboy.vegasvil.org>
References: <1755008228-88881-1-git-send-email-tariqt@nvidia.com>
 <1755008228-88881-2-git-send-email-tariqt@nvidia.com>
 <ca8b550b-a284-4afc-9a50-09e42b86c774@redhat.com>
 <1384ef6c-4c20-49fb-9a9f-1ee8b8ce012a@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1384ef6c-4c20-49fb-9a9f-1ee8b8ce012a@nvidia.com>

On Mon, Aug 25, 2025 at 08:52:52PM +0300, Mark Bloch wrote:
> 
> 
> On 19/08/2025 11:43, Paolo Abeni wrote:
> > can we have a formal ack here?
> 
> Gentle reminder.

I'm travelling ATM.  Please ping again next week.

Thanks,
Richard

