Return-Path: <linux-rdma+bounces-7154-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B13D5A1812A
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 16:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97F6F16B0B9
	for <lists+linux-rdma@lfdr.de>; Tue, 21 Jan 2025 15:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130131F3FFF;
	Tue, 21 Jan 2025 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="GcjmxX5y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E8D1EE02F
	for <linux-rdma@vger.kernel.org>; Tue, 21 Jan 2025 15:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737473491; cv=none; b=UFfKHFazcJPIZIsFlYUcxT/J4nGeps0bco6XxpUp2miodUEVBtNathrmfb/ajheE4zKuhwNMpSPrPgoWfdHhWvUyfzd77PkiGZKqh7qDgpMbny/TMPgYXKBg5tjwVI120E2bU4FtU5NoKIuO4A/9l0JnZd5jXhmuixChng/4pY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737473491; c=relaxed/simple;
	bh=wHYFqK7LptvWr2bOTBZxdUSSPRb3ra/bFZMAnCiFkQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=av6tcsDXK8ysY1YBGqS9pQwyi3JEWyRjMblV93Al79RvRSekNyNcqhVkqkntAdvwOgGoPLvj4MxQb9yqmiHP9FR474Vi31l/xxJ5CW8fsFQRnv2qeT/ZAPoq+u6aISYg6+pryQ7FbZVKAF+1jk+oKw+A0Soi4SfUuGbW2v0VnfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=GcjmxX5y; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e1a41935c3so80204916d6.3
        for <linux-rdma@vger.kernel.org>; Tue, 21 Jan 2025 07:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1737473489; x=1738078289; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UPCv4qoKfIbPdswlQsZvRuLUgfvq5IiyKEcgbCel5fc=;
        b=GcjmxX5yAnFwIrC6unZ28x2HApOfsPYYK0dLXU1H5AW9WiEMPh9amByxr2RclUnKz2
         JFlN4GW6Ju/FQJ2oF6VJNI68Ri996U/yYJxGnRTK7REdDPgDpS3hJG1I/gzIBPztgP8Y
         wjjg7ipfn7trDd34rfHg1pJ7eBKyu0sQ6H1glV3TZ8hhJhy2qG2cNgN/6O6Q1qmwHmkQ
         B+xzJv7Na/jCoqKh6qwPk6o7NLZZBnZgZOGjYcWDboO62awAYX8ZA12M+glIj0d5Zrjd
         47t0K5UyJKk4HCGP5Zjvv4e29qlOE5Bhx8cL1vKPWtfSV73uVCz2IoI70tu/qy9+sryD
         T/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737473489; x=1738078289;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UPCv4qoKfIbPdswlQsZvRuLUgfvq5IiyKEcgbCel5fc=;
        b=BOS56wPmHxNYFpaHfWuFC7K1r8qo0ZEbL67HdR6ABn39Z0Bpj4WdQ5fMgj79S/r2J/
         sExj8MkKegJdC4AlnJt2EUksdBT7AVXH1ejxJxFTX58KOC4sdB9iBQlyoqYFUNYOWomd
         /TQfLzVgTo3OYHowGfvCmaaphxteXh/QFCD79+UW1zK/vm1EXDA4eHC3+PCJN5j4MGJi
         4yF6VrMHBQuXXEd26yOIeFbb4gcJ5mApfayl2mB5u+Nqyf7YJtnxpHpMmQmBQhdKOASL
         1zLscVoHxrDJNHm/linDWW4cpcGsdSdG1Nl5zuNnmm4L0PaAFXW8wW0R7ltuUYt52BrU
         k05w==
X-Forwarded-Encrypted: i=1; AJvYcCVDtHd0Gi49zojGyOD3EtvyGF7/g3yYcozCx539HBNN7O7TBiua0/JX20eIV9iy6T+rS19NHDwsbX0S@vger.kernel.org
X-Gm-Message-State: AOJu0YxzsajtbIz/thkRqm6Hk+NMTRSm5sYzsRexWN2zghyjjzIEbLfT
	JJlnYi6khaN+9y3T67dE0d3PwgDceY5UW4ByAT68Mp9Fkd336/srI37Hf1y/SPY=
X-Gm-Gg: ASbGncsYjOP1zDQSpW5CPgh5t1B3MoIgwVCzInVS/sNP2PbJ2MeM4vf45Gqoqt4XxNW
	H0LSc9NKpR0ypPJQttArepV5xNmqvzmk0x10n/N9xbrsFNAeWUCnn7ujYme9SObgh+p2a1D9YNz
	VNCHArAfVEUKliULBuOjVeYMC+eW0IvUewCdpnmk2HjEU0xhVP+ap2IFQI1lP9mP8Xfj0ml633C
	VOiVF0sKf7xpuP4kRLxZrj1eQjiEA2SogB6O03c+/K7s/Clg6myhKbFZNYpGLJS6R9DeC+o0pIq
	Gd9lCwiDJMizCcDNIYNu6erMUpcC0Twb4Tgy1WpwESU=
X-Google-Smtp-Source: AGHT+IFOgTKAFBKPvh5H/bk2itpBrqHiuu/AcNWRoG1B5sDLkfv57soIFmaJDTuSfJr9WM5H4mrkvg==
X-Received: by 2002:ad4:5c8f:0:b0:6d3:b636:eccc with SMTP id 6a1803df08f44-6e1b2187426mr288202196d6.21.1737473488804;
        Tue, 21 Jan 2025 07:31:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1b43df872sm45644686d6.39.2025.01.21.07.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2025 07:31:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1taGDv-00000003g7k-2HMV;
	Tue, 21 Jan 2025 11:31:27 -0400
Date: Tue, 21 Jan 2025 11:31:27 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Selvin Xavier <selvin.xavier@broadcom.com>,
	andrew.gospodarek@broadcom.com
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH for-next v2] RDMA/bnxt_re: Congestion control settings
 using debugfs hook
Message-ID: <20250121153127.GQ674319@ziepe.ca>
References: <1737301535-6599-1-git-send-email-selvin.xavier@broadcom.com>
 <20250120164000.GO674319@ziepe.ca>
 <CA+sbYW2oDbrodgYdzOgUiSv6v+8aBcACLbfrXM+0NZGmHquUFw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+sbYW2oDbrodgYdzOgUiSv6v+8aBcACLbfrXM+0NZGmHquUFw@mail.gmail.com>

On Tue, Jan 21, 2025 at 04:10:33PM +0530, Selvin Xavier wrote:
> On Mon, Jan 20, 2025 at 10:10 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Sun, Jan 19, 2025 at 07:45:35AM -0800, Selvin Xavier wrote:
> > > Implements routines to set and get different settings  of
> > > the congestion control. This will enable the users to modify
> > > the settings according to their network.
> >
> > Should something like this be in debugfs though?
> Since these are Broadcom specific parameters, i thought its better to
> be under debugfs. Also I took the reference of a similar
> implementation in mlx5.

debugfs is disabled in a lot of deployments, it is a big part of why
we are doing fwctl. If you know it works for you cases, debugfs is
pretty open ended..

> > bnxt_qplib_modify_cc() is just sending a firmware command, seems like
> > this should belong to fwctl?
> Agree. We can move to this model once fwctl is accepted. For now, it
> is important for us to support our customers with an immediate
> solution. Customers are asking for this support.

Well, fwctl can be accepted when you guys come through with an
implementation :)
 
> > Additionally there may be interest in some common way to control CC
> > for RDMA..
> 
> Do you think there are common parameters for multiple vendors here? I
> think enable/disable is an option.

I haven't seen much commonality here, every site seems to have their
own totally different stuff right now.

Jason

