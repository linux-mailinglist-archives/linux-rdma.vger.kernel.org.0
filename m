Return-Path: <linux-rdma+bounces-2761-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2398D7793
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Jun 2024 21:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A6331F21C45
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Jun 2024 19:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF77B6F06A;
	Sun,  2 Jun 2024 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="AX5Z4WNR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69799219E4
	for <linux-rdma@vger.kernel.org>; Sun,  2 Jun 2024 19:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717356242; cv=none; b=V7XUmftQ4O2zV9v1q2HkhCGbCjwZTj0TiBYuD3bglFIKO+IDZxIn2IJyD5tdjyongOnSePajhzaFz1TNp4ENGD32ehhXX6An+GzOjOJ3ctSFZwQTmZioMI+xQhgdXf3zqTu7S22YM7eIF6n0g2RGmoAWHhYQrfmwE9GwoaeoPoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717356242; c=relaxed/simple;
	bh=qFKsyOePVq/VZ3JIFbqe8V02kL7/ITBZkREWuaoRyFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dcp5zVIxbEZej7VlZ8s77VSy3evjzMys6X75yMl9V0t71xVmY+RF+DUbh3SwPv/WdsCcqUew1rkvq1q4A3oEzjYW7+DrZXF3LQHmKkGqB7r+NhBwjKmpxNiKzof/Jmi8z53GfQoKsGeK5RC9A4eZ1SiYC9GvHT39KK7BCjyjtKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=AX5Z4WNR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70260814b2dso559580b3a.1
        for <linux-rdma@vger.kernel.org>; Sun, 02 Jun 2024 12:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1717356241; x=1717961041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Y3tCKTuoMYJ9KLxmz/0pp/IbE4WV30YqEEAEWzotb0=;
        b=AX5Z4WNREqCMtfSZ+OlZ2HJZ7BaehtBof2ksCvqO8Xqr/BF5SFfZJaSyY1Is+O9+z/
         b+VFAUiB+FCV8egPkl7M3Ek6A+9K360cdwpK5OKufI+j27+084GgqUzPya4+yTgioGjc
         cFDz9KBJ2dbSpV+NnVYQt59bFuvIQxpYJee8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717356241; x=1717961041;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Y3tCKTuoMYJ9KLxmz/0pp/IbE4WV30YqEEAEWzotb0=;
        b=qC3WgvH517FzYOlemNkZTsr2fNHUgfqaSc1vfm4RJEgUMwwENTBDyVnZCtha5OnH5s
         URrVLIeOWFjG+wrQ33efOe68ZXRYoFZCSrSCp/QSjPaTlLmjSI07DkLoUK05I0xw5vTr
         SZ4UbFeaiVHKWYAWdys0zvfFxwBKcfYudHjBpnPQGtcpoeXC8bhumL/ttRdrdvtNdRBg
         18NwEm2pfbcfTaKaA0cf1TITu1pASHxClylYhfgYdZkI5CrdkviWINij8pQ6vlEF0cKj
         kSQv7oezxiFFql2mdVb2H8qM569udkVUq2Ju5AwK1XY62+jL8+T5zPzQ5qmNoWUn3JAN
         giKA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ5j/DRvHygrqjuk1Z9kgvQmoBUnHF4xLxLXcnKFe3xFyYbFxcTqn87WwyKJegsFoEs+xYzoSKXgBC/5FL7CqZbmsFvGkM7ChX3w==
X-Gm-Message-State: AOJu0YwyGjQp39Cx0NhVrC9QNWDiGOfKW1O6nXBgNIN8x86hANfwM+es
	pvmluDIQSP/MMExsocCNgpocENE9r1G3RlwiFGaVQapPZguR/47ZmmvpSmDNkBM=
X-Google-Smtp-Source: AGHT+IFevz76P75NXcHiN0JDZMUF8qUTk0bC63DtirDuVzzRVRN0ulqFXsAABGtrz12hZTsYn+74Cw==
X-Received: by 2002:a05:6a00:1ca1:b0:702:6658:252b with SMTP id d2e1a72fcca58-702665826f5mr2800463b3a.13.1717356240660;
        Sun, 02 Jun 2024 12:24:00 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7024e30820fsm3468032b3a.196.2024.06.02.12.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 12:24:00 -0700 (PDT)
Date: Sun, 2 Jun 2024 12:23:57 -0700
From: Joe Damato <jdamato@fastly.com>
To: Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	nalramli@fastly.com, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [RFC net-next v3 1/2] net/mlx5e: Add helpers to calculate txq
 and ch idx
Message-ID: <ZlzGzcwn5JRG9kx2@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, nalramli@fastly.com,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>
References: <20240529031628.324117-1-jdamato@fastly.com>
 <20240529031628.324117-2-jdamato@fastly.com>
 <20240601113557.GE491852@kernel.org>
 <20240601113913.GA696607@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240601113913.GA696607@kernel.org>

On Sat, Jun 01, 2024 at 12:39:13PM +0100, Simon Horman wrote:
> On Sat, Jun 01, 2024 at 12:35:57PM +0100, Simon Horman wrote:
> > On Wed, May 29, 2024 at 03:16:26AM +0000, Joe Damato wrote:
> > > Add two helpers to:
> > > 
> > > 1. Compute the txq_ix given a channel and a tc offset (tc_to_txq_ix).
> > > 2. Compute the channel index and tc offset given a txq_ix
> > >    (txq_ix_to_chtc_ix).
> > > 
> > > The first helper, tc_to_txq_ix, is used in place of the mathematical
> > > expressionin mlx5e_open_sqs when txq_ix values are computed.
> > > 
> > > The second helper, txq_ix_to_chtc_ix, will be used in a following patch.
> > 
> > Hi Joe,
> > 
> > I think it would be best to add txq_ix_to_chtc_ix as part of patch that
> > uses it, because the current arrangement will cause allmodconfigs with
> > clang-18 and W=1 to fail due to txq_ix_to_chtc_ix being unused.
> > 
> > ...
> 
> Sorry, one more thing.
> 
> Please don't use inline in .c files unless there is a demonstrable
> reason - f.e. performance - to do so. Rather, let the compiler figure
> out when to inline functions.

Sure, I'll make sure in the next revision to include the second
helper in the second patch instead and avoid using "inline" in both
cases.

