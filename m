Return-Path: <linux-rdma+bounces-3212-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BD990B411
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 17:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 889C1B38CF7
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Jun 2024 15:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E90153810;
	Mon, 17 Jun 2024 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nuplD/4v"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E54614F13D
	for <linux-rdma@vger.kernel.org>; Mon, 17 Jun 2024 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634279; cv=none; b=U9TDPbcvqeIDVwiwnATQoMLVickM9shvVTUFSeBIr0COHca0o/nTbXfA+y5bIgx1mgm1GD/IBBgo2IjwmPTrm6ZPvf537twZD8Xl0O6wDuN3bAteglzPuBwcfsEcRC/U2dDPbC8KpNtsiOfD5uM40/VX28axUO2EnUD2wVLo9gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634279; c=relaxed/simple;
	bh=LA3Im2Ykn31l+Y3VFVXq9sQnK+qHfCnvBvYNSeGUED4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/JOdXK5Y2br/sQ09HAMu/Ew7C9oWyjBGE6SvZ2wMKgPdQy5/XfjG4Ko5qw49+cCeGAHSR8STuVCXS97QLcjkZWA3B/EYYte2KrDns+JRZ8URg5Kl99b14NT7DUN4+plfioXmN8Sy9Gm5fYa4MeTM1226JFMUEnKY+DNUk+0Hd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nuplD/4v; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b065d12dc6so23490706d6.0
        for <linux-rdma@vger.kernel.org>; Mon, 17 Jun 2024 07:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1718634277; x=1719239077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LWYcrrgGgJVkVkEzV+uKwxvFuw/0IQaRf2tlU6tnp7Q=;
        b=nuplD/4vFO+x2DcxEKETcpBZxmL9xrWd77PHeK1W7fqMemECckOFqAIHF7RUyVaF8a
         oZH+pxjOpy5/pdCeL+v0IcmpJMpUylZCYVX7RyiZhQSqeTGiH6zz/B3qaI7IIvAqKD34
         78zWtwXNU4+7aey5MeQhWlxVIW3JF4yLPV6zqNzJ1mN/rxPhMZWZjoC2oaj0pUgn40sj
         9VJk9wxOcv9+9OSa+/MhmzgzgVT0GihgybAOrAbEQQ1Ff7mhv1Rvpskw2OBSwrLqdnFC
         6i5ze6RtBh3Dx6kpKgG6hWtVOML2Gz+LDtiYPaA/x+ZVLP493IOyeC6EmGwmgqwdSnmh
         4fCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718634277; x=1719239077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWYcrrgGgJVkVkEzV+uKwxvFuw/0IQaRf2tlU6tnp7Q=;
        b=q7pP6SoUG7P6PTRwEYpknfm7jBUjtNCSRYMX1eYfcg2lLyQTDKZ5yL1Lzfai5ixong
         CfSN0jO5SKEHSlEZyGOmH14YRrDpxweQXAsZiZJpeJ82amimc0SwjV/ho5/LnnZz3ua9
         vXMRQ9u3AiERe2p68Yl65u5lPZlsxj1sCMd9OmVkt3X2f5kvRqQvYgFva4jWgsUB3NjL
         GTSFA/JrukJsYo4A3EoSShsVrOv01vdgpDOzrTvWaNaLcpYBiM1cu79TtmsT51fg+li4
         gjcuyMmiukrEEy+C4wmChzmWqatZRPDu4eOH8aRg9G/0xx1jvUws7vkbwPIWkXaUfmiJ
         HJnA==
X-Forwarded-Encrypted: i=1; AJvYcCUZRwOlRRet+y/ndfHqnfM93SRye+bOcDQK7Lbj2ljPVFJ9sWbcBr5cr7Rft3pi1cUIp4l78OD+FQFISgFbOMWg5xTMn28vDMjkng==
X-Gm-Message-State: AOJu0Ywx9BgPmPn2BhubH1wT4bERi/lWhq+Gl5Tgg5pTi9IaJ+7oC7IZ
	B6OL1OPTc175EiYLgi+HilObPA3l/Beygu5DGSL5plrh3SePSdEZOHVoKJMWomk=
X-Google-Smtp-Source: AGHT+IGfwbJ60ZqrA114aMN45gK9s3vc2EDlXOzq6R5c002K1UZGeCA+L/WH+cwaawoW6d029bShcw==
X-Received: by 2002:a0c:e846:0:b0:6b0:806e:4015 with SMTP id 6a1803df08f44-6b2afc9e207mr99899936d6.25.1718634277045;
        Mon, 17 Jun 2024 07:24:37 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2d58f622dsm15818006d6.49.2024.06.17.07.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:24:36 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sJDHf-008g9j-Rv;
	Mon, 17 Jun 2024 11:24:35 -0300
Date: Mon, 17 Jun 2024 11:24:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jianbo Liu <jianbol@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH rdma-next 2/3] IB/mlx5: Create UMR QP just before first
 reg_mr occurs
Message-ID: <20240617142435.GC791043@ziepe.ca>
References: <cover.1717409369.git.leon@kernel.org>
 <55d3c4f8a542fd974d8a4c5816eccfb318a59b38.1717409369.git.leon@kernel.org>
 <20240607173003.GN19897@nvidia.com>
 <20240613180600.GG4966@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613180600.GG4966@unreal>

On Thu, Jun 13, 2024 at 09:06:00PM +0300, Leon Romanovsky wrote:
> On Fri, Jun 07, 2024 at 02:30:03PM -0300, Jason Gunthorpe wrote:
> > On Mon, Jun 03, 2024 at 01:26:38PM +0300, Leon Romanovsky wrote:
> > > From: Jianbo Liu <jianbol@nvidia.com>
> > > 
> > > UMR QP is not used in some cases, so move QP and its CQ creations from
> > > driver load flow to the time first reg_mr occurs, that is when MR
> > > interfaces are first called.
> > 
> > We use UMR for kernel MRs too, don't we?
> 
> Strange, I know that I answered to this email, but I don't see it in the ML.
> 
> As far as I checked, we are not. Did I miss something?

Maybe not, but maybe we should be using UMR there..

Jason

