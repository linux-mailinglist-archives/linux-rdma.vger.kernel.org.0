Return-Path: <linux-rdma+bounces-9022-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA55A74A73
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Mar 2025 14:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B00F216D434
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Mar 2025 13:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15FD136351;
	Fri, 28 Mar 2025 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nq9YC6O8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22B13C0C
	for <linux-rdma@vger.kernel.org>; Fri, 28 Mar 2025 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743167717; cv=none; b=R0VFL1gEDMCEylaSji37Qfa+5t94FpP68/6V28ZCrOUlnETEy2ER6SB5CMGhtW2bNxV80v5RVKGoB9YXqMIGIvkm6XNSaz8+hS4bWfDXwX411g/CoDSz2/SivuOZG06ysM3dghaeub0csY62j/Nn4vNAWq9VdndPJifQjN/ZQf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743167717; c=relaxed/simple;
	bh=JYGnLp0TGOJvpDU9M+j2GDHjeyyPOC5kt2WX0B2jov8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HD0d3KsfjkPk8ioVbui/LitgyOCI0SotdB0t47w8ROAI6EJbRsZ4RV38d9TNk3VkyKBcNdsCP7DsvxXNi0vVvXTYqTE0/wVMsbXk3Yd3pvYKWJ8ly844TPijIwfXxDFvfJfxbgRyS7osC/3A5m2Pm63AtPoIvkMovPk/dEJk7ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nq9YC6O8; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7be49f6b331so221020685a.1
        for <linux-rdma@vger.kernel.org>; Fri, 28 Mar 2025 06:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1743167714; x=1743772514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bRj8ioRiebRI4JeEI/9NspVZnN/z9apivdHKZhtjWXI=;
        b=nq9YC6O8WtXcsgGUvgolYgTexVeFC9LLzBmKAViAzJzGhBbio24t53WxfQrq5UC5UK
         RFsYFoumautEq2UpKbeSerhCKJS/6znQWlx3d39UcNZrDJJbnUvDhoQR/UflmQFyXmae
         qcmivD8OHQU6FQ7uz7Qb2Tn4wefSXnE7G0+ue1qDxH03f1eIlTyK4fTW03u+NVo70GJr
         dc+pCHgjeSTaNBKTe3ApiVZvVqYgMOG9BIe3e0EAv/S34Rh9YLDGC/zeQasIHwezBo6m
         XHj2CLb1RJhSzUThmjX7vD/GgwG+7k5RHBUCee71KjQqmQbiloM+xsQED82yL/iLPSMJ
         +ZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743167714; x=1743772514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRj8ioRiebRI4JeEI/9NspVZnN/z9apivdHKZhtjWXI=;
        b=WYB8HoKBLR6AQw495DbTwv7rGeMZSDiYRcvcg7lGDu+fk2J4+yNxzL0JFymaX7iESR
         eIkSxgsJvHtPnlPACyshRPycpmmeUgVfTJxxEIXsGESjhGaseqp93z9L9canXJ6IbAPl
         h8U/vK66iHZ2fk9HIWtKCAhb1Ph0I4G9miKpX1FpYM5JeUwXOWZKobxvUFVFC9z3ptxv
         XN4DClXTNmEAKfmmUq+JsUFMPTufVfUn0q20xr3tqJdKfIxpiLyT1zqJpe/pEbAbyZGx
         yt15SSxCGFcEzT8l+VZTTEF3KlIc+M5TUQqcM0kms7LttW0opsCqmD7snIh1VwgsJQCN
         7/eg==
X-Forwarded-Encrypted: i=1; AJvYcCW7kyjv16lWJ1Jg2EHeLVx+1cfPQzTPY6P4iVwdTe8ZXjlvM2yVyL9jy2VsUqh3+QenFPUAWk71pO3E@vger.kernel.org
X-Gm-Message-State: AOJu0Yz73LYrt3zIQg5vo/D4SxoKvVEV7sGLJ0ylaeQJ70d0dg6so5Vk
	YCYv2V+JmzAt/JiRR8JNaSfBsUL8Dfx9hUK2ZRLvZq9iXzVl3hmsmNvddJV4u0E=
X-Gm-Gg: ASbGncuc0aFxuXB+SH/NxPfaO4K6t2PKIF8VGv71Ov4nJiZxU/KbdZevIZZrEQXYtOz
	rTgxpzvSpJvFf0xj8JODV15FHmUwofzdzay+k+sJV6/rK2gvKT4K3G1GxF3UUqPybNr57jfsf6A
	rHvVXLfVCRGoszt7N/dU7EWy/TW/WmvYq0MU0PPcLGeEDOmCYH18EQmA9rv9nd+0loHNT7xUGv5
	1JbnKmhtY7WJG63eY+mPQJg/lETHuGkaAv3uyfUG0xFYJCGcZyrHTD+yH6G9TEtDYoj/8hqS3S3
	yIeIp8GbN36dBoRh0cbFl5oBUi3aYc6PPFkaNBhwVICfmCvApzHxaTgMC1jG/1lTWVK9D6vScG6
	tiqkex4qQGZajXUZCZhVRdAE=
X-Google-Smtp-Source: AGHT+IHiZVeroHAFbsoVkxOS1MajD2OVU1qJtDqYeoU+K++Vl/n9t5niY7i8b0f1RlqFrV3CylQWXA==
X-Received: by 2002:a05:620a:444c:b0:7c5:a29e:3477 with SMTP id af79cd13be357-7c5eda82c93mr1166935485a.53.1743167714348;
        Fri, 28 Mar 2025 06:15:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5f7764e55sm116187285a.89.2025.03.28.06.15.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 06:15:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ty9YH-000000005SN-1CtM;
	Fri, 28 Mar 2025 10:15:13 -0300
Date: Fri, 28 Mar 2025 10:15:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Arnd Bergmann <arnd@arndb.de>, Mark Bloch <mbloch@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	Moshe Shemesh <moshe@nvidia.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: hide unused code
Message-ID: <20250328131513.GB20836@ziepe.ca>
References: <20250328131022.452068-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328131022.452068-1-arnd@kernel.org>

On Fri, Mar 28, 2025 at 02:10:17PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> After a recent rework, a few 'static const' objects have become unused:
> 
> In file included from drivers/infiniband/hw/mlx5/fs.c:27:
> drivers/infiniband/hw/mlx5/fs.c:26:28: error: 'mlx5_ib_object_MLX5_IB_OBJECT_STEERING_ANCHOR' defined but not used [-Werror=unused-const-variable=]
> include/rdma/uverbs_named_ioctl.h:52:47: note: in expansion of macro 'UVERBS_OBJECT'
>    52 |         static const struct uverbs_object_def UVERBS_OBJECT(_object_id) = {    \
>       |                                               ^~~~~~~~~~~~~
> drivers/infiniband/hw/mlx5/fs.c:3457:1: note: in expansion of macro 'DECLARE_UVERBS_NAMED_OBJECT'
>  3457 | DECLARE_UVERBS_NAMED_OBJECT(
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> drivers/infiniband/hw/mlx5/fs.c:26:28: error: 'mlx5_ib_object_MLX5_IB_OBJECT_FLOW_MATCHER' defined but not used [-Werror=unused-const-variable=]
> include/rdma/uverbs_named_ioctl.h:52:47: note: in expansion of macro 'UVERBS_OBJECT'
>    52 |         static const struct uverbs_object_def UVERBS_OBJECT(_object_id) = {    \
>       |                                               ^~~~~~~~~~~~~
> drivers/infiniband/hw/mlx5/fs.c:3429:1: note: in expansion of macro 'DECLARE_UVERBS_NAMED_OBJECT'
>  3429 | DECLARE_UVERBS_NAMED_OBJECT(MLX5_IB_OBJECT_FLOW_MATCHER,
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> These come from a complex set of macros, and it would be possible to
> shut up the warnings here by adding __maybe_unused annotations inside
> of the macros, it seems cleaner in this case to have a large #ifdef block
> around all the unused parts of the file, in order to still be able to
> catch unused ones elsewhere.

IDK, I'm tempted to revert 36e0d433672f ("RDMA/mlx5: Compile fs.c
regardless of INFINIBAND_USER_ACCESS config")

I don't think that was so well thought out. The entire file was
designed to be USER_ACCESS only because it uses all this mechanism.

#ifdefing away half the file seems ugly.

Jason

