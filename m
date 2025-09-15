Return-Path: <linux-rdma+bounces-13380-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8808BB58221
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 18:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD564C06AF
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 16:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45F329BDBA;
	Mon, 15 Sep 2025 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kYdiNsCR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C868828C5D5
	for <linux-rdma@vger.kernel.org>; Mon, 15 Sep 2025 16:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953806; cv=none; b=iQWkJsPLKfEdxHGwkz9ztcMXxOtOMpU0J11quwGKqzkLnhSutQtNpOH+jPOyuu0fqD+S8/4zXFin9dfaOuKlbcYv4k879lajuDZwV4Kd+0qYmKclKgRKaT7M3fsJswDVSfu6TPd2mjXyfI+xWaGXoy6kdn+YjUEN7PUiovsZ8S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953806; c=relaxed/simple;
	bh=vUGjtDlWHqc7aYh89cQ36SLdWbgpmL9Jq5i3Isp4Wl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtPt1zFCsmnwPbgcYX1YFFqO5DqYfy1Aq85sSsrGuieR4WmljI0lLw4J5BWd6mEfNopIzdNw20qYrA9T6XBQIsL8yFX71LCI1rfBcq0FIqq1Jz9dYALNXOWUJdRj1Gmb0JLIGh07PvwBEtpqKn1fgd1WuHJpaxmbBtS0lqbHfcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kYdiNsCR; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-7748879b06aso18995196d6.3
        for <linux-rdma@vger.kernel.org>; Mon, 15 Sep 2025 09:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1757953804; x=1758558604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n1VOOirKbSUY53Upw24PRoYLUiz7i9vMoYI+GCjhpHs=;
        b=kYdiNsCR/WAaLi+ucyGBMO55xkRQWg+vfVDdKi9hfZfS/41uCtHVCzTonDFSnlxXNM
         /XqLbwEMiK6pczgd/oXzDVnYiFpkc8omOLk/XRkehg8eb6YXXLWLS/MPAkU4ve60Jvwk
         vBcLd+gkAgK2EVCkwqTgsg75nYWmOMpi5YCN3hrx7gGSPbybl81pMhE09zz9dwKWlHMn
         ZigJdJ2mm7kFSjU6Xr5O6VzkfIf4iYBQiV+2GqqHTJHHG2XAsLalVE6k24k08y81LmUa
         nZrnWSnyC7kX9RogGqCgfKaQdssCKAywhsZ5LpksgWuTmlKO4ULi/0W+jHSSiKo6UBjS
         1T+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757953804; x=1758558604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n1VOOirKbSUY53Upw24PRoYLUiz7i9vMoYI+GCjhpHs=;
        b=pnc/UdFHUe8ybTMKdAjUQ2QxZw5pZjnpaUlmclO0IMAZjxl5lUepIvdrw4kicIuwkA
         UhkmyXZ6EjYMzEYKH30RDfRs3i5i8M0T4hA/Jf3SSkICF/ZAJ5BQIyUAXOdB1dm8KMM5
         eh8iHs3LqPmJaTU19QkogkhSVsLJ/zVWYg0UNuoiTpAR1LdG1Hna5PR6jcg0Uxo7THAo
         pak9AC2gD2eC23EI5hgGD/l/IV/I7ZTRkp2DVg+x8MNg9xRNaTN24rxPF+Xx4VE/L7Uw
         uGo42eAS/a2hEJY6xP4Jqb1kWuJOV0NbHLG/byk2Y+ljv8PgUjd+ajNvA2hBjz5bdxDt
         921g==
X-Forwarded-Encrypted: i=1; AJvYcCUoCAkqV75/mcGSijodac+O88LBA7A8dCZZLps2HNspYk6EMjm83STaMvv5ppFn4B4V2EOXdNNw/lVB@vger.kernel.org
X-Gm-Message-State: AOJu0YzUKAAJ4AdrNpw/9ErNCwxgU3PYR4IuXtZd/yt8vUQ16G3JC+sA
	aJRNmPNyjIZTbvITySENlw1Poyns4eXCUDiWTEENSjeuyQirN/n9BwvybdQ+CpUqwrk=
X-Gm-Gg: ASbGncupAqEN/ZVH0ax0OuJBo33GFtEeUIPB2+u37TDQpEwzh2Lhe8j5VpUw+GEwt27
	jXuoZuk8zviGBKSlOcDYBAxEKmao6BPr8ImB3/l3y0JyrMtk7EHxWYj9sYb9enfOmH2s0PdvOp6
	PsnaAHTsnKKvVu7yDlTdnpDNQvVAft3fcRiyXzVdnK+OpvPSqQbLToBTrkMQox3qwm7xKCLapiq
	VZNPh5BfMP7ALpHXMzYRp4QWo8JNKBI4skyGNB/vxlD9Uk48+XSgXFpdyjQ6lxRW9vcST/SJXoK
	AtPeVYAAGhDa6CmnnfdkT5IXx5r7M+OWRI9Q2dDXw+7+w3TdEspmnlP1QHXD20Gi5D/OpxIXM67
	eABH/wz8=
X-Google-Smtp-Source: AGHT+IFpYayzIAQ2DLYNp4GTlaAjiT/s2zeuAVfqLIyN4DNy83AQcUYuU8GaWSr9Jp9eLTdSRXR9Bw==
X-Received: by 2002:a05:6214:27c9:b0:78c:9dd7:d97e with SMTP id 6a1803df08f44-78c9e242532mr5385896d6.51.1757953803412;
        Mon, 15 Sep 2025 09:30:03 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-781f4401f3bsm24381986d6.65.2025.09.15.09.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:30:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uyC5a-00000004TDO-10U1;
	Mon, 15 Sep 2025 13:30:02 -0300
Date: Mon, 15 Sep 2025 13:30:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Parav Pandit <parav@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Edward Srouji <edwards@nvidia.com>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH 2/4] RDMA/core: Resolve MAC of next-hop device without
 ARP support
Message-ID: <20250915163002.GJ882933@ziepe.ca>
References: <20250907160833.56589-1-edwards@nvidia.com>
 <20250907160833.56589-3-edwards@nvidia.com>
 <20250910083229.GK341237@unreal>
 <CY8PR12MB71954BE7258390B4B7965E8FDC0EA@CY8PR12MB7195.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR12MB71954BE7258390B4B7965E8FDC0EA@CY8PR12MB7195.namprd12.prod.outlook.com>

On Wed, Sep 10, 2025 at 10:55:36AM +0000, Parav Pandit wrote:
> > > This leads to incorrect behavior and may result in packet transmission
> > failures.
> > >
> > > Fix this by deferring MAC resolution to the IP stack via neighbour
> > > lookup, allowing proper resolution or error reporting as appropriate.
> > 
> > What is the difference here? For IPv4, neighbour lookup is ARP, no?
> It is but it is not the only way. A device may not do ARP by itself but it relies on the rest of the stack like vrf or ip vlan mode to resolve.
> A user may also set manual entry without explicit ARP.

I think it was just a mistake to use NOARP this way in RDMA, I looked
in the git history and there was no justification. That or it was
right in the 2.x days and netdev moved on to the current schem.

I expect to just call the neighbor functions and if they can't work
for some reason they should fail?

Jason

