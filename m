Return-Path: <linux-rdma+bounces-7452-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD08AA29217
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 15:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7471E3AC9FD
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Feb 2025 14:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059DC1FCD07;
	Wed,  5 Feb 2025 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DjXZ0oXK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1321FCCF6
	for <linux-rdma@vger.kernel.org>; Wed,  5 Feb 2025 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738766848; cv=none; b=RQByDXm7+qzcOKOiw8LzhJ21ywf9lqJJuq9dvGHCUjHZ1QwyOW58LcUmCoGf8RlW5NPMlPR9W6iNE+fRass/s4IUiF8PLq2VQ7eov19RuVJTFz1NOrpTabhBvApgeyQvIc8FFfr+Rn0yIwSvwj57O7hRq7/XQ89iTmEo4eBujSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738766848; c=relaxed/simple;
	bh=yKAf2LEjO48MRgmuO81k35k9WNF6aP4nhc6tXq4dIpM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0YIUhBq8Hb6aKb78SFE6YavX1NBp9zM019C8ZrLILKYvVVS0LHwCPyLL+j2FW1GUecsyFfd2La5g2WrFtRkXDJvhRh4qqaN8+rFZHaQ0IECfsdor4t4YCf+EufzILAGqH+qpG2fOAvcd9QPmOPDLrzh8kgTbKNWqjwud2e5tZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DjXZ0oXK; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6dcdf23b4edso58996186d6.0
        for <linux-rdma@vger.kernel.org>; Wed, 05 Feb 2025 06:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1738766845; x=1739371645; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tUEUr8gecDVFP7Sm4YrA14YQlWYB5B+qXE1hs8LMJ3s=;
        b=DjXZ0oXKt66WpT6qkt730tZEV6jmWG9wO4bOz/i3A365RFzQyQ7Cwbi/Vxsid0SO/k
         geWAV64XJBw+UfO6+FNhw3zuy6TbcTe85AAHR5fzOUHO2aF/7bzo9RGRylXpAipFhbvm
         LFN3Wy0nABqn8cx3yobi3/WeyZGb71qiIDuVUdHI2xCsSzFqA2nfmHJJ5es5PZepPUFH
         NW9Op1T5n/Q4AhvzaMGgZmcTXttEkZvx8xOZ6vXuHWN26vhOnD6uJrWoAe8OAVD3yQKk
         8ItgWCTTk3pXYshwMOnZFp0KjIEb6NKsVtzlwYva7UxVqHOsM+vdasmnHSmtD7uj/Rv+
         LAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738766845; x=1739371645;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tUEUr8gecDVFP7Sm4YrA14YQlWYB5B+qXE1hs8LMJ3s=;
        b=acqrZbMWXWMyHprjMvrFFygpWV5pj3Bm0HcCbrIRqP2RosEffZLG22xkDxhoQ1vUiJ
         AUwzvKMawyna6P0AqXElgpP/AGkFmK79h0HPDdXYO0J6/Jfs8X4KjYPVQIep54ComNSh
         BWrw8ABzv9T56qy4MiXShmhnZk8V6jgPEaPmPuPtUOuaZvw77zR4J6IrTUl2u8+HEZbY
         xsZhERX2ghS8v4paDLkBcN5KH+zK6EwLRnsLXUpWohMa2l8xzugtSiuRkqPkgHfEQEOP
         s0GTmLVijCH3UCpORLJgyFPsuS77JgBRtCoj1Y/kdkj5vK6663VORnNM8pUubtgpQcF2
         AXzg==
X-Forwarded-Encrypted: i=1; AJvYcCWQOUBevnKK2rn5Rz9hEszrgKQdNP9amqIFDweMylwheooI9p7gqecoIS78lZ2Dlg9OJbdEP0KIJ2Nh@vger.kernel.org
X-Gm-Message-State: AOJu0YzxYK8Mqr2CwDYcIigOEc3M2FgFx2VuG+mrRCVtS3ctELBEMlx/
	snxj5YIOcwzbrUq+2ZvMJgdG3xsqDO//NownDXFzulY+4xbYb7VLVUPbkLuOSec=
X-Gm-Gg: ASbGncsOGZpfYcUR0jFAord3acjPpAwNyEHxlCQmLtPpZe5ZzZ6/QqpSLh51DRoKzMI
	1cM86OPXWVPGNmGXzT+jyrNVYbtDLXpIIbyAf90lkxfKzv43x+IPWwVVDptBbW+9L+6Y/1OfX7i
	9G1gNHnIFAgt946JPUmI50kiE/8veE91BkIiMqonvJyi9HV5wXDjjcI5zqbRzWLp2YVqFvn72xm
	gPEn5Ixp2nk8nTmNyPtiSqlkMuGYEPwuCHQGrIEJutcutdsZQ0ucsFcpiUNv0cpfOCp9F+8kWqR
	jGTqfTjbzHB38UJgIibkTk5uYvk6I+VcO6CU4c9wNweupoLKR4jOf1+G3+dGEzwV
X-Google-Smtp-Source: AGHT+IH9adJKZb8VI7yS+pGEFb3mRwZBNgzJHnypljFdK1vgjAQ7F2M/rJmJBWrSr4CKLVHwVvh6CQ==
X-Received: by 2002:a05:6214:1d26:b0:6e1:afcf:8710 with SMTP id 6a1803df08f44-6e42fb2325cmr49157886d6.8.1738766845324;
        Wed, 05 Feb 2025 06:47:25 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e2547f0e5asm74516406d6.7.2025.02.05.06.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 06:47:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tfggW-0000000ClYe-1787;
	Wed, 05 Feb 2025 10:47:24 -0400
Date: Wed, 5 Feb 2025 10:47:24 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	linux-rdma@vger.kernel.org, andrew.gospodarek@broadcom.com
Subject: Re: [PATCH rdma-rc 2/4] RDMA/bnxt_re: Add sanity checks on rdev
 validity
Message-ID: <20250205144724.GN2296753@ziepe.ca>
References: <1738657285-23968-1-git-send-email-selvin.xavier@broadcom.com>
 <1738657285-23968-3-git-send-email-selvin.xavier@broadcom.com>
 <20250204114400.GK74886@unreal>
 <CAH-L+nPzuSdKN=WQccTP2crfMp8hSLqq-uTXqw_Ck=sHtWbyEQ@mail.gmail.com>
 <20250205071747.GM74886@unreal>
 <CAH-L+nM6+-v6dvgzA6UDhgbhjysr55BJ859N5aWWXNEm4k+EDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH-L+nM6+-v6dvgzA6UDhgbhjysr55BJ859N5aWWXNEm4k+EDw@mail.gmail.com>

On Wed, Feb 05, 2025 at 01:54:14PM +0530, Kalesh Anakkur Purayil wrote:
> > Shouldn't devlink reload completely release all auxiliary drivers?
> > Why are you keeping BNXT RDMA driver during reload?
> 
> That is the current design. BNXT core Ethernet driver will not destroy
> the auxiliary device for RDMA, but just calls the suspend callback. As
> a result, RDMA driver will remains loaded and remains registered with
> the Ethernet driver instance.

What is the difference between your suspend and reloading the driver??

Do you keep the ib device registered during suspend and all uverbs
contexts open? How does that work???

Jason

