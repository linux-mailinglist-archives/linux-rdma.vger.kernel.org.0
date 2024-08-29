Return-Path: <linux-rdma+bounces-4649-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9418B9653B5
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Aug 2024 01:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FFE21F22F6C
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Aug 2024 23:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13AC18EFEC;
	Thu, 29 Aug 2024 23:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="YFRPe8F1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5AE18991C
	for <linux-rdma@vger.kernel.org>; Thu, 29 Aug 2024 23:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724975944; cv=none; b=jMp9qomYh11xYyS5EtGb29xECOyC6qjtXLr0U0d+YiaKIt1dvWDawkkDb4hgMA8Rlw0rtFLUWhGj9e0yyiGbZdquUOdRYOFb1nGTMNJA+okHRP4g/ZmLapfdYS8EUCNPkKL45+2AH2Mlxz5ZMDAQYHqlfQ4fmOxJ2YyKGArvPl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724975944; c=relaxed/simple;
	bh=XclOCsfb32kYv2Q1QdH56wPRiRVAkbIsdjvLha2JOAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+48cNYT1RP+9MjXlPs+c6Ulq0/AZewXexthwONKlDUcQ7aFczV3jkX1eb544O9oowG59xKGMCXR8DJ+26pUk/6d/JGOtsIqTSWWtgqN1QNLWSdyQb7h1c6oHMma/C6Fjpf0C1bcdsqqNIMaTeUY+gYnHaxk2xG2OPoeSzYr4Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=YFRPe8F1; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-27051f63018so799342fac.3
        for <linux-rdma@vger.kernel.org>; Thu, 29 Aug 2024 16:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1724975942; x=1725580742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7sVDarT+YBpMc0tM/iiIBCg69BPAnD6PYDjpxTLZstk=;
        b=YFRPe8F1KsvTjvh5IG7zty+92AJD4bNv1tg6j7KbSE1lyYq8e7qJG5ah0IBc2aPZ86
         JG27bRa0JaBkbDCDPCcbsm2Y/Rubzd7FnwIT98GSMf/nU5cmee63/toTlMYbIeTefsgc
         tsD1STlt1EyqbH4NW0kc7sTYSyvBvrt2QQWOP5htIi0OUCTmtN1p6mDX2IaY6Z69flpz
         SEEKSqbYWcYC4B1BTMiYJtahPagkD/yiI5mGiQRVP+qxY0DeJs2m+caKtvged07OtnTT
         bDDhIa32wvRW+MDlJRjPrxe5j5GPxtd9L1Z4goPB+Jpb9/XknqJHQmGI9Loy2WjthvRr
         3mPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724975942; x=1725580742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7sVDarT+YBpMc0tM/iiIBCg69BPAnD6PYDjpxTLZstk=;
        b=V/Q4rqEWNI+HfnSOyxJQ3xbua6FRa26JDzE6UjHINYNblEhOtMRf5HsqGUu1QAFlPu
         /x0vIsNhZ5VF49mZkckEYfvz0cyrlZA8JuqSTj35uwiMoMTHGO/Gv+9bR2vy+MFtJQ65
         riW8IITK9sDMhrQQkltanDQ+V7swzVveHxTOt8/t5VWbKudqhu6mOatIAMvwe1FB9Snk
         5NeirQkYhAcMZzdMhDEvi96uuZns2aiFZlnbaEELImRb+1vlHoW8QidbmnhA0rqOReQL
         cVXITK3lLirm21F6mU0uEFspDnHt5nXM23DbOX6YANP5C7b+9vB/Bqj2Tbwv6wxhdlVn
         AXuw==
X-Forwarded-Encrypted: i=1; AJvYcCXrcm3qCQVQSK+DkPTOVUcQyhIhqeO1m8d+iIBeasuPCtnQxM6lh+lQ2uPheo8ckmRag6ftJRKRy3Eo@vger.kernel.org
X-Gm-Message-State: AOJu0YxQCk85+MEP0IarEiFYZzwpMeMKu79cTSMHnQ14mgxiTr+c+UrO
	mUImtDxOKgWZo4guothInWXkzepth2KaCFg/8YcGplU4dauaDoo7qI3NuwN7Ucc=
X-Google-Smtp-Source: AGHT+IHW1kv2lb98eFYM9ktQm2FMitO5LGgZvZ7Jpad1iX5A9OthzVlVte4R3M6av2jwRquUk5XaPg==
X-Received: by 2002:a05:6870:d209:b0:260:eb3a:1b2 with SMTP id 586e51a60fabf-27790076f0bmr5086253fac.7.1724975942034;
        Thu, 29 Aug 2024 16:59:02 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-715e55a5b93sm1688579b3a.76.2024.08.29.16.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 16:59:01 -0700 (PDT)
Date: Thu, 29 Aug 2024 16:58:59 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tariq Toukan <tariqt@nvidia.com>
Cc: yzhong@purestorage.com, Shay Drori <shayd@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/1] net/mlx5: Added cond_resched() to crdump
 collection
Message-ID: <ZtELQ3MjZeFqguxE@apollo.purestorage.com>
References: <20240829213856.77619-1-mkhalfella@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829213856.77619-1-mkhalfella@purestorage.com>

On 2024-08-29 15:38:55 -0600, Mohamed Khalfella wrote:
> Changes in v2:
> - Removed cond_resched() in mlx5_vsc_wait_on_flag(). The idea is that
>   usleep_range() should be enough.
> - Updated cond_resched() in mlx5_vsc_gw_read_block_fast every 128
>   iterations.
> 
> v1: https://lore.kernel.org/all/20240819214259.38259-1-mkhalfella@purestorage.com/
> 
> Mohamed Khalfella (1):
>   net/mlx5: Added cond_resched() to crdump collection
> 
>  drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> -- 
> 2.45.2
> 

Some how I missed to add reviewers were on v1 of this patch.

