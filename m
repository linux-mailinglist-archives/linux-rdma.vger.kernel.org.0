Return-Path: <linux-rdma+bounces-6962-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA31A0994F
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2025 19:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5291B16249C
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2025 18:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F592139CB;
	Fri, 10 Jan 2025 18:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G76WGXdE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654E4212D93;
	Fri, 10 Jan 2025 18:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736533617; cv=none; b=m2hBP/g0EAU0nR/YtZmO3/8TGOVyNKdwAlKiWBfjoYi+KjEPUqeF0B9Anh9txBYeyroVqMYWAQxSyJ85EqfKbCFu3T4VJWqXp5PVATTqWQsl1qVrZ5G6J+ScTJI98W0T08ddRCgVr/eK830NeuLp3qkxXdRuNhLJ/cki0w0px3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736533617; c=relaxed/simple;
	bh=P+PoKVBnCT88eYuSEcYbcKJaMCqbhOgQc9Gcovam0UI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AVBQukbhNJIT/i+H3ZEEvMuKzYl3zHRtpYKFvKu1PH6BMxeWv+kkALBa41+FaGdeu8F3NW0Akcx4b23bti8KsUeQwpdw0MUCZ61dBT+Gh7giVoNV5XGTSNqX1oODU8FOCzSQfMcekiLw27bZxzekGQ+WaniiTptgQQB2I2EJiQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G76WGXdE; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21670dce0a7so49136185ad.1;
        Fri, 10 Jan 2025 10:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736533615; x=1737138415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hNUXV4bI3wEa2jBwi8Bmc1kYBmISkdsHPWTt1ozrnz4=;
        b=G76WGXdEsR+LCs9zY3ZbBzq8YQzJxOMlovo4nHF7zI3PPHVEw2AvArXCI/42LmYwCg
         f08hh9ZqeAaE0H6qRzDIzJMwBPaqn9beVM+obBVNQPKCuBnxfWoMnRjiwIqEhIdOzwBI
         tc6icEddBgYb5OdXHa8I/atAeod9QZxND+ZKdlTAM8q4BPSgAOfP7XPIx24QTvLStVzr
         O9IYQGQ6uBMyhXYyqilulAkon9zMUyCy6pBtv3mE5heZZSc5CjWSS9GwZDSSqa/i4aUq
         /xCww3+FvAIs+XJr8eOKvdCOvtN8vsRZo4i2gI6kINVF1bLiHi1LPssIfasOiNQ/YxZh
         GCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736533615; x=1737138415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hNUXV4bI3wEa2jBwi8Bmc1kYBmISkdsHPWTt1ozrnz4=;
        b=B1npwT/PdqFjhCI9FzbNlBV02W50gAqtAuC2LsZ4GSs4V03/kcHX/b3h4mNAEjQJ/I
         b5acoXRnh2G/WcgReasqIeIaOw2jHelU643U+I8YPCNDPgPSu9qO17Bd4n27g29IkNOy
         3TXzhgb8ycRpEdAFR+vHb8JSsES7iV5gnMUribTxIODl8Z4JUSK3qjsO+yB+RsPX6eLX
         t4kdhzHNRE5sxHltyHc3dUQpFbhkuO4a/Rsfc90cUvPnTqUcdxvC4/FBLz4AQAxLxyHV
         SpKxe0zhtoXv3mrjPqZ6LMl2gW04FET3ayHWMGTTBzAxhMymLyavqvSa5Kkl7JxPDSXb
         CUGg==
X-Forwarded-Encrypted: i=1; AJvYcCVX0lhYv8DbQSfco+KqHmwmLMcPdACBw7UnskjG3VS+lEXGGR1BaGPafVTJ0EG+muydyKB1XyTM@vger.kernel.org, AJvYcCWpKtX4hIfrVh/GEfJ0OqpUFWxW0SJmWZAMx/LzZ84sGRAlsOQ8fiFF/cD6J+UGXYacnT6HAQe+hGj/og==@vger.kernel.org, AJvYcCXRcT6UCxoJNvsNrBPfM3M3ySoebKVipelML553+nomTsZuoDOK60sBMCVLayi1GHYmi+Y3+CKiAVhTQC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8obamE1DzuPBGU/kO9N5gHC0xctZgTY95JFQgC49D3NrntR5x
	GJRmihWcKTQ984l1OFsUfGc3tlo2Le8V9rmOj8ChgJxCRZMcrgo=
X-Gm-Gg: ASbGncu0aCGplulptfSIyXTX54szh4x3UPocHlsME7/2x4K7Hqx85jGgyTOSExAvs4+
	GAuF6KeON7dY5dUFCbnW+WC0zE6Rvpjl6u7C/Sq+Wo9arI10VvOzWJgaPD+U7QP2sHP/6wij4lz
	3MDAUn+o2pRjw0U6CK2QAr7D6RgLPZrfUxc4kwQgoQfutm/dUpH5pHTByxeAU4OgoVbVjecgFnR
	DmzSBcah38TMIQ6mBBYvGFbXhwxuiCQ9owoWGnZL7pfQ1MoA4uYbcIl
X-Google-Smtp-Source: AGHT+IH6riR7C/bTklcBkHQtOXrP5srNDvIpI4+QgXxnW3beJpW5qvbBGQxD5LyRvn4PQ3w7NFe5BQ==
X-Received: by 2002:a05:6a00:b90:b0:729:597:4fa9 with SMTP id d2e1a72fcca58-72d22032690mr16095602b3a.22.1736533615366;
        Fri, 10 Jan 2025 10:26:55 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4056da5fsm1835945b3a.70.2025.01.10.10.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 10:26:54 -0800 (PST)
Date: Fri, 10 Jan 2025 10:26:54 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Joe Damato <jdamato@fastly.com>, Alex Lazar <alazar@nvidia.com>,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>,
	"almasrymina@google.com" <almasrymina@google.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>,
	"bjorn@rivosinc.com" <bjorn@rivosinc.com>,
	Dan Jurgens <danielj@nvidia.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"hawk@kernel.org" <hawk@kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"johannes.berg@intel.com" <johannes.berg@intel.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"leitao@debian.org" <leitao@debian.org>,
	"leon@kernel.org" <leon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>,
	"michael.chan@broadcom.com" <michael.chan@broadcom.com>,
	"mkarsten@uwaterloo.ca" <mkarsten@uwaterloo.ca>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"skhawaja@google.com" <skhawaja@google.com>,
	"sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	Gal Pressman <gal@nvidia.com>, Nimrod Oren <noren@nvidia.com>,
	Dror Tennenbaum <drort@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [net-next v6 0/9] Add support for per-NAPI config via netlink
Message-ID: <Z4FmbseFBQT_g1R9@mini-arch>
References: <DM8PR12MB5447837576EA58F490D6D4BFAD052@DM8PR12MB5447.namprd12.prod.outlook.com>
 <Z2MBqrc2FM2rizqP@LQ3V64L9R2>
 <Z2WsJtaBpBqJFXeO@LQ3V64L9R2>
 <550af81b-6d62-4fc3-9df3-2d74989f4ca0@nvidia.com>
 <Z3Kuu44L0ZcnavQF@LQ3V64L9R2>
 <Z4FkAZkNnySdjdRb@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z4FkAZkNnySdjdRb@LQ3V64L9R2>

On 01/10, Joe Damato wrote:
> On Mon, Dec 30, 2024 at 09:31:23AM -0500, Joe Damato wrote:
> > On Mon, Dec 23, 2024 at 08:17:08AM +0000, Alex Lazar wrote:
> > > 
> 
> [...]
> 
> > > 
> > > Hi Joe,
> > > 
> > > Thanks for the quick response.
> > > Comments inline, If you need more details or further clarification, 
> > > please let me know.
> > 
> > As mentioned above and in my previous emails: please provide lot
> > more detail and make it as easy as possible for me to reproduce this
> > issue with the simplest reproducer possible and a much more detailed
> > explanation.
> > 
> > Please note: I will be out of the office until Jan 9 so my responses
> > will be limited until then.
> 
> Just to follow up on this for anyone who missed the other thread,
> Stanislav proposed a patch which _might_ fix the issue being hit
> here.
> 
> Please see [1], try that patch, and report back if that patch fixes
> the issue.
> 
> Thanks.
> 
> [1]: https://lore.kernel.org/netdev/20250109003436.2829560-1-sdf@fomichev.me/

Note that it might help only if xsk is using busy-polling. Not sure
that's the case, it's relatively obscure feature :-)

