Return-Path: <linux-rdma+bounces-4762-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DD796CD72
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 05:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE97D1C247B1
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Sep 2024 03:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9596514EC71;
	Thu,  5 Sep 2024 03:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="DMQy8RxO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EB11442E8
	for <linux-rdma@vger.kernel.org>; Thu,  5 Sep 2024 03:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725507496; cv=none; b=iv+YHe8JjJE+0v5Kt4Gbk23hvxGzft/hWZOnzAamfMPQJNko8a/ILNQuv/QD6CwnF1pJ6ti4IrEoEVVv9AHpNySyXOUSFlEbCpQ+EOmV8xk9Mq2DcaxfGLAm3NBdyYWV+gs2ybqiw5dY/B+II9UKSYaRBfPBsdzGBAASFLrGeJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725507496; c=relaxed/simple;
	bh=mmiaJAbhrJN/bNqpFuO9uFl1R/zzhkIVpCzlW51fYOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UyAYcB/wZENX6zitEYmYYmX/fvwUfzCTfcvWwmr9FkvIEQlPVDRdXlRMKFn54s47rBeGlIsuIY6PuZtqaO/zFlQkVXYoVAH6Ys7WjpbRi/Lefn9e4InG66JtfirB+jGOpOAZLmRvv/EyjwoU+iDrOqKUBsgK5a2aAbDSYBGuOuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=DMQy8RxO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2053616fa36so3472825ad.0
        for <linux-rdma@vger.kernel.org>; Wed, 04 Sep 2024 20:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1725507493; x=1726112293; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=08wuXpe7nVswzOQ+7NVFPT0XGolvX7IJ38IQQv3iN0o=;
        b=DMQy8RxOFlOTY6aka1Zvsnn2KjBFC5XZ37ShZaqY0IRv2U1vp0edmkvA3iW6qRYi6o
         PIyGYKG6B4WMrPDidbGd/JHwj6boLj6OUBwnOY3uSsPLiU/TgI3g5l36w4Co9PPcXVoa
         FLjtvtjLHCGa283kgKsFP3ovA/DXCbOcZHzaCI2TbjfvW6oORBtts3PXmRNzmbFJloH/
         42wOmBNC0PdVowUqu62rPNrPT00uc8Ow8hSnysXpF570Uve/klrSBeTGceKN1pQWo9Oy
         H9vHq7FL01C1yU7KbdmKUkq5ydLMIfKTVF4dWJ2AaW/zNGJnTI3gM96WYmFKyHiFI/u8
         Dgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725507493; x=1726112293;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=08wuXpe7nVswzOQ+7NVFPT0XGolvX7IJ38IQQv3iN0o=;
        b=c7IzD4BXaIKC4P4DuuBxsGZqY4b8ZIIIaczLP8eoqZUH42UMkWJ/EY4/kYFJA2DgXc
         6LMsumAKkEz5p4mtvP+7qV+TgkphRN7DPKtU7CkuOuYnbuDHfWAsn/br5/VKaHwDVxR/
         Za1wjW23qKAVvniVoyWceObkKzRk2SDi4OH9Z0peLmWukYJHLEkLtYv+aPqnHK78Uo76
         TOR1Rc8LsqvXUSLou3ubLY8DHFBvufqLQAySv0w6dwXWLwnbkmllsBIWrsxsa7gFe6vZ
         iOEOTCHWyD/u2q6qNGKw0GHir06qQHe5D8sDglwFyf+5mQahCZWBo8NkrG0WcUI+cf7U
         NGtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXgNAzM/2U9BJLI9lrMnCZLOltledRvhEX8COHMAlym+x2mOyCRzzrYInx8aEXQ9dwKkgOJfnDRNC6@vger.kernel.org
X-Gm-Message-State: AOJu0YzHEHhXWUweGE9iLpSVVwHhYJCDfP54u5U/+8dZGjJyKnE4Sx7M
	goRND4RbwCyLRX2IwIRBnIv28ACiqyW8GG8v/nAg2kfAeFuEsBP8oZZvb5GKdr4=
X-Google-Smtp-Source: AGHT+IHH3Lqn5on1g4RFU57JfQl06v4zJ/wLxbY8TMC7VJqZlFOf/eV3r5+jBfeS2045uWs4FbawQg==
X-Received: by 2002:a17:902:ce82:b0:205:4e4a:72d9 with SMTP id d9443c01a7336-2054e4a795emr184195425ad.7.1725507493010;
        Wed, 04 Sep 2024 20:38:13 -0700 (PDT)
Received: from medusa.lab.kspace.sh (c-98-207-191-243.hsd1.ca.comcast.net. [98.207.191.243])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-206aea38539sm20130665ad.130.2024.09.04.20.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 20:38:12 -0700 (PDT)
Date: Wed, 4 Sep 2024 20:38:11 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Moshe Shemesh <moshe@nvidia.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, yzhong@purestorage.com,
	Shay Drori <shayd@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH v2 0/1] net/mlx5: Added cond_resched() to crdump
 collection
Message-ID: <ZtknozCovDvK7-bL@ceto>
References: <20240829213856.77619-1-mkhalfella@purestorage.com>
 <ZtELQ3MjZeFqguxE@apollo.purestorage.com>
 <43e7d936-f3c6-425a-b2ff-487c88905a0f@intel.com>
 <36b5d976-1fcb-45b9-97dd-19f048997588@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36b5d976-1fcb-45b9-97dd-19f048997588@nvidia.com>

On 2024-08-30 12:51:43 +0300, Moshe Shemesh wrote:
> 
> 
> On 8/30/2024 10:08 AM, Przemek Kitszel wrote:
> 
> > 
> > On 8/30/24 01:58, Mohamed Khalfella wrote:
> >> On 2024-08-29 15:38:55 -0600, Mohamed Khalfella wrote:
> >>> Changes in v2:
> >>> - Removed cond_resched() in mlx5_vsc_wait_on_flag(). The idea is that
> >>>    usleep_range() should be enough.
> >>> - Updated cond_resched() in mlx5_vsc_gw_read_block_fast every 128
> >>>    iterations.
> >>>
> >>> v1: 
> >>> https://lore.kernel.org/all/20240819214259.38259-1-mkhalfella@purestorage.com/
> >>>
> >>> Mohamed Khalfella (1):
> >>>    net/mlx5: Added cond_resched() to crdump collection
> >>>
> >>>   drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c | 4 ++++
> >>>   1 file changed, 4 insertions(+)
> >>>
> >>> -- 
> >>> 2.45.2
> >>>
> >>
> >> Some how I missed to add reviewers were on v1 of this patch.
> >>
> > 
> > You did it right, there is need to provide explicit tag, just engaging
> > in the discussion is not enough. v2 is fine, so:
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> And fixes tag should be:
> Fixes: 8b9d8baae1de ("net/mlx5: Add Crdump support")

Will add the tag in v3.

