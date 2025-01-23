Return-Path: <linux-rdma+bounces-7215-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAECDA1A9EC
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jan 2025 20:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9778E3A2B11
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Jan 2025 19:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC4518D63C;
	Thu, 23 Jan 2025 19:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bVcZ0wWf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351EF14A4FB
	for <linux-rdma@vger.kernel.org>; Thu, 23 Jan 2025 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737659009; cv=none; b=UuW+BkR2JTWDnGZtbkgP9OhomqeXI9tEeA7EKlj0PF+kXIOfXdBXShEs5/KGQXas2it4+FQeLADSCKQB9puwWDbUuWuCvOvDSVA5lXoH1zOT1UWTho5S2C19sXneICHfIDVWHibLDdEV7zvnx56CXN0QtztxJHO2Pq3ABLTz5aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737659009; c=relaxed/simple;
	bh=9xvr8n6UrzZbP3DepcR70iZSfVrRAMkFoC7Jinr6gLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NecxG6MT4b5Fdn/6AKR73be0Ff6ik6OatnDsOBKZZ+YJhNH7DTm5Fs1PsDAzrGN5GmH/hGBbeADabRZn6tWuf0Ishsu5U7/YnRNRxB4SBFzwFGrcHRfmcicZXm+cIr+roE5Se23x8ALg4KJ6ZJZFcUkEh6qCMU3hAde1RRG5SbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bVcZ0wWf; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b6e9db19c8so115879385a.3
        for <linux-rdma@vger.kernel.org>; Thu, 23 Jan 2025 11:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1737659007; x=1738263807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D+xv3aQ28zuD+yx3iUQYH9XPq3JQRzFl6Pk/+H7aPjI=;
        b=bVcZ0wWfdsmzDHy05u7p57fYbxRhT30wdeIpSEcuzU6lNoeVng+7tP31wHFEYvd+dO
         qAIvsMqHC42CCC9zsT2ahNAnthO8UfwmrgjHAyxhP0LCbjc07gUQ6TGNbbUx0+N+2SO5
         Z6c3akWDLYNt0VQvEcF4p+yCxXem4sJ2LqrPq2TeovZrU008OAIR0aE54XSNdPtvkwvQ
         +dsqDvBc+M0W6LsRAh3OedAki2SxTFdGyA/EkrW5QY9S3A3wR7RmT7ACjyrBysvwMLCR
         YtUVtVzutCPwrDsiveud5efdvCJTqpv3zx5mC0H1xDsDaw5LTp7vZAfcofoojupGVJXF
         OcXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737659007; x=1738263807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+xv3aQ28zuD+yx3iUQYH9XPq3JQRzFl6Pk/+H7aPjI=;
        b=pU3xufQKBlEOI9qqa5zel0lnA5HS/1z2KwIEJRJ7S0aO5uU2Lbfh76BO3OEFVyYr3L
         zRBbmCDLd8uQv0+ydkTjDD+LKeDev76i0IKMgdKt/Z5w1saVctYW/aPFQ8Y62pEF48Fb
         mpSiolCoiiY2aFlBd8h1VOvmXbMuZ9lPNAh8jgmy77R8gGzaOaOx2s/1iZFVzcXDNI8C
         do4xVspQ/Xj0X8lMvvy6Aus71vZBWCo7f1j8qjM0mqy16D9bOcQ4R6MCcupUS8L4N7t3
         gFmNco9xSkMfen1tTqK65HE9fAoM1oC/HznJht6TerPITBvccBtF3+GA19YIpDUwAg45
         foxg==
X-Forwarded-Encrypted: i=1; AJvYcCUK36lw5q9KbtOpe1k8WNnWPIgpAEZQpGbHMNBg2CeXoHnx2odKDi4TNX2j5bO1v/3qgh8nQfofBPtP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Rr/g/oaYfUy3KzqTES7CQYRQjBzPxlmbxOM0pjrH88+vtdg8
	vjEYSFZ9uNY05ACMceM1yZfJJ8y31nGhLIEKOGCb9LPkkQWRVnaOSBXARdlJwno=
X-Gm-Gg: ASbGncs46cEeYV7gdJ2IhPh8FlWDs1KUlK2c/z+sM5N5PUHgNBWP1dLw1/LpHuFImyd
	GH+xm0Qlsan7JFRlqW6cMyOYnuyKw7HTUy8YG8i7nDrsoOj6+/zHNrByhrCNLl6fHVyuuotO0FY
	Bf/25/Fl5EjS5cWGk+SNlk74hJp1EIdvZiNNTJCZFedW6QQex0WvpXuuO4d7HiQmfAtsUUyY/rC
	mCw/bcqVmQpgfcmyu83O5R3MGCQq0YV/zznBHkiQVhl0zSVyc7kb+3Ib6mhRsW/INwz1UvLxp1y
	/MZw6k3IgdVIZWGUzss81h/jb/+51nk0C7TCCt3vNjUvcdr8Iqf3SA==
X-Google-Smtp-Source: AGHT+IFTRghqqIXFOqUm271sNPa/tDjd1nY5Cax8bJJRYW66zoKgdnjNpNKayefg6gHqaABR0AtkPA==
X-Received: by 2002:a05:620a:370d:b0:7b6:fdb9:1be6 with SMTP id af79cd13be357-7be63249e21mr3577306585a.29.1737659006971;
        Thu, 23 Jan 2025 11:03:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9aeedbadsm13482185a.71.2025.01.23.11.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 11:03:26 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tb2U9-00000004Quy-1OCe;
	Thu, 23 Jan 2025 15:03:25 -0400
Date: Thu, 23 Jan 2025 15:03:25 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Long Li <longli@microsoft.com>
Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	Dexuan Cui <decui@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	"leon@kernel.org" <leon@kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH rdma-next 09/13] RDMA/mana_ib: UD/GSI work requests
Message-ID: <20250123190325.GX674319@ziepe.ca>
References: <1737394039-28772-1-git-send-email-kotaranov@linux.microsoft.com>
 <1737394039-28772-10-git-send-email-kotaranov@linux.microsoft.com>
 <SA6PR21MB4231D21C388D916D759B2833CEE02@SA6PR21MB4231.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA6PR21MB4231D21C388D916D759B2833CEE02@SA6PR21MB4231.namprd21.prod.outlook.com>

On Thu, Jan 23, 2025 at 06:20:34PM +0000, Long Li wrote:

> > +	shadow_wqe = shadow_queue_producer_entry(&qp->shadow_rq);
> > +	memset(shadow_wqe, 0, sizeof(*shadow_wqe));
> 
> I would avoid using memset since this is on data path.

The compiler often does an amazing job with constant size small length
memsets.

Jason

