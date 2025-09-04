Return-Path: <linux-rdma+bounces-13084-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 359FAB43CCA
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 15:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D005854F8
	for <lists+linux-rdma@lfdr.de>; Thu,  4 Sep 2025 13:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A90A301032;
	Thu,  4 Sep 2025 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kc1cN+MP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5828C3002D8;
	Thu,  4 Sep 2025 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991677; cv=none; b=cxgJqdXlndqtUXNRQMajqcjDv3i3U0C1vB3tzy5icHkE6NT5wwkQoyAlCnNHVDzHGh6Dwtg0YQ1rHO2BMLnpeAzyjlfOuU5qN7ho3sw2dJvQ0QDTQ0+ZGAgWky/ZnA6XMSII+6fugdKnHwiOGs/wE49vfI26cl+MdaL9QXaqjM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991677; c=relaxed/simple;
	bh=dEe3oGeQMtPB8wuvNB8FBuJzRWiGuoUdh066kutEK9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktnGx/XCzJdpC84dj+k0FSjGUtV4mCniktwaZli2ge0e0+BKk8mAHdhItPW27ecdtkNcgBgadv6UCoinSmDoPKV5RMlZojuAMTpUKfbC7yJiM/9Bmt5mFibzXagll/6DDeleXfx6eqliJYkXIba6QARwwVNv9FRg37qKR8XV8H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kc1cN+MP; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-71d60528734so9010627b3.2;
        Thu, 04 Sep 2025 06:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756991675; x=1757596475; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1hNBrk05MCGZgtGPl87X/mVFXWaCSlKuwxFY/ixXTs=;
        b=Kc1cN+MPsECYuBqqiz+XkzHcsAfajjM0Gc5nD9ypN/IESj1J9GuLpROzl7izJdWkVx
         4o2tRHEeGR6eEBYJKCHzFNatU0dWdfGwPr9xBuTOQFDLH2SXu9EXN0TWRwvb+2S1Oc+X
         UFEJJQaoT7DWyAuFDFMq7+tcwfk5mzjJlNl0CvwPsUvxns21bhQSGzTOS6HealAylnsH
         cJnU7syFgIQ4TyjfCg23bOGGmQby5UZSVk/n6PXu6foU2aw2l9VxOaNa4kaHTH+9nsuJ
         lPEQdgBHmMnxxpsnhgPu04KXumfDQugLZjVXPz9PkcRneRhm4qhWbBURZxqp3SddI4am
         6wGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756991675; x=1757596475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1hNBrk05MCGZgtGPl87X/mVFXWaCSlKuwxFY/ixXTs=;
        b=jfstJqUXMryJtxU0KPGWm80jXMxDD+5Bu+85fF7ADOkpO6dole0M+1qOkryGMUpU0W
         KnMoe0ObuyJECz8k6zZX/Bhbkz4yqhVo/R/eDxmZoBAyNcEIFJWyJo2WDnzCeC7R/r2i
         gBFbP7R+DSD4D0592/itmG+aNt6S6GU2byVlzoVu8y4tFtX6v67/mPoZ09xw05YKfuTY
         vVumrC/TrB2Z66gjs5ehRhf8IeBel7YiLUJaC/HLbfjm0LLixycFLd8rsMfFkhD3Q8qm
         FfsOnhYO4CaEsz+xvF6/XRB80huj8VfVZ4yyKlJhc5wcwR6nChWc+WUzesKzwn6ziKtJ
         v4Yg==
X-Forwarded-Encrypted: i=1; AJvYcCU3SwIXV1/WWCRQORTcd3NCkjdqPzEArMRuRzYNSWpgDrkDBe/M+79CmC0TOA4s0QlwvlYAn6kP4SjfRnM=@vger.kernel.org, AJvYcCVLOl8CjGWV6DGnrW5aNTmDH4yI4XHDtpNTP6uqsWEfo87wKxGPJeuA8yIvOQ+Gqb182uQVtxFbGtdRwQ==@vger.kernel.org, AJvYcCVlxK038NgnVR/IONfTRO0gW/11gzJIcPEsf3SdpRpKOuliffGu66KgYDrpxKzxr3wdB5CY/snb@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ+VsMFP5cIvR0X4HPPxXEMg1cuUSIVnExQedYepjvtZQmn9Y/
	KjiqBGp7bFBszahRBGAP+xU+aQNRlHQuia61NqjSOdZpLB5Znugfv+pE6BLHYr3x
X-Gm-Gg: ASbGncvUFUnlDN74QSfnb4f3DhVMOvUAkFVAPpeHVThBkLVqoCOTIWQ+caqLNY/3wK3
	nc6bUAxMdGlPpLMChw46UbutO9rJSs24N5z8EFKC+BPNjaJCQrjeFas0f7QAovmkQJJNU5tUC/h
	wnacQAtirNT6yXLMyxweKnC30NEwozkonXNh4krlrqdZcz0GljaTwREKKYsTAeTaavE1CaV8qdm
	eMwUBsmHjtsR6xz/8HGWMsVwtaMQ1O1ph+Vjvxpz0dZHflk5xX+Lk8Jn9TyealnQBQCaAnY4Sig
	yVh9uaRm8ULRMsPyMMg2/Pecf+qGDCwfCpKgJ0HQuKukW6NM+Cp+fRrjy1pG1u4jbU/Ob0eVOcw
	ViAFW0rVIjh7dB+WEmBYoscnaq+PUvCmmi/9L+HcmjQ==
X-Google-Smtp-Source: AGHT+IFNskK3EFi2xtyUCVxgOnvSd1XZWTDJnBX3UGI8lrc9DMhpnA8IpUMHa4JoiklpSdQDgNd34g==
X-Received: by 2002:a05:690c:4513:b0:721:6a43:c960 with SMTP id 00721157ae682-722763cfc0amr199134677b3.21.1756991675072;
        Thu, 04 Sep 2025 06:14:35 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a82d6ad1sm21418977b3.5.2025.09.04.06.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 06:14:34 -0700 (PDT)
Date: Thu, 4 Sep 2025 06:14:31 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next V2 1/3] ptp: Add ioctl commands to expose raw
 cycle counter values
Message-ID: <aLmQt838Yt-Vu_bL@hoboy.vegasvil.org>
References: <1755008228-88881-1-git-send-email-tariqt@nvidia.com>
 <1755008228-88881-2-git-send-email-tariqt@nvidia.com>
 <ca8b550b-a284-4afc-9a50-09e42b86c774@redhat.com>
 <1384ef6c-4c20-49fb-9a9f-1ee8b8ce012a@nvidia.com>
 <aLAouocTPQJezuzq@hoboy.vegasvil.org>
 <3f44187b-ce41-47e8-b8b1-1b0435beb779@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f44187b-ce41-47e8-b8b1-1b0435beb779@nvidia.com>

On Thu, Sep 04, 2025 at 03:09:23PM +0300, Carolina Jubran wrote:
> 
> On 28/08/2025 13:00, Richard Cochran wrote:
> > On Mon, Aug 25, 2025 at 08:52:52PM +0300, Mark Bloch wrote:
> > > 
> > > On 19/08/2025 11:43, Paolo Abeni wrote:
> > > > can we have a formal ack here?

Looks good to me.

Thanks,
Richard

