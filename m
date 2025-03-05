Return-Path: <linux-rdma+bounces-8367-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05260A5032D
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 16:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1717164894
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Mar 2025 15:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4D824FC0A;
	Wed,  5 Mar 2025 15:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BZMDGDG2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A12C24CEE2
	for <linux-rdma@vger.kernel.org>; Wed,  5 Mar 2025 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741187308; cv=none; b=nhrEcAO1ZHuFoXiyAAV5cfw4JW2YE3RW+rHF5Sr96ihQBy35J7/zEfnhX16vUpUEWRu850QF0RvoxN8KqRe+GbIBGe1Ds7LfRjLWlpE3Da4OhevoKA+Tt8EF2NIUcy/61rkelG3EmbG1iYG8GC/H2eYArMexqWouaL1XmS1iBb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741187308; c=relaxed/simple;
	bh=qkk7BM6Tlh3hTIoRZk5iaAXN3AkN+GK8WjOtyMbuJ1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVHmBidpb/l5VXu8YyZMC+/PdyUsIftcDcXmGA5wi49pR7owmp8zOVeDm8gwDeSpMLQpP4my6S5gPr6MQrFDzDhlGQf6d0oyJQl5Zkpa5UwMJr/yFK5v98lkPBwYKjU6kh4hREst8Dq1/peoekDKm4UVt7XnhZW+SXuyxxATn7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BZMDGDG2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so45519795e9.3
        for <linux-rdma@vger.kernel.org>; Wed, 05 Mar 2025 07:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1741187304; x=1741792104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gdvXoLdUnuAJXkhm7GFBvnQ72ne3nL0Mv6leNbRadPA=;
        b=BZMDGDG22SgwNokwc78rztg4mN2Gh+yS6eUqWzvqIaqpoa6AqlcPIzgjELrehP8jjt
         A8u8ywQpCjN57FvixqII1W1/jEEb0+44mesGKtcB/vND5ENgyqFJrE3iHUU/P3ySXi2i
         o60pqFMOuUQufOGsdJHNvP0lVBbdDhjmMhWqWLxahBodefdv1YKmAuNQEV3fAbHf5UeE
         DyEOzenLPXMamb8yxhL8XS1UrK35TX1HwN038vkKN+9ZoTTWE0hTFhlgf65iymEDsqsR
         fJGbOFAEfIJ4TiKy39tKqE1XYgcWJI7XnVSeprfNo/AorFjYmMzYRxhRVgQkS/+9PG7r
         /dwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741187304; x=1741792104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdvXoLdUnuAJXkhm7GFBvnQ72ne3nL0Mv6leNbRadPA=;
        b=XU73BwJ1Xr58DzvTkuFIfheU7a1TvRBggsF2fRnOhEyEfxLZGdHvj2+yxO7IdoO89i
         kfydTNpprLLdcxXfcM3DxAgzQChWGQyiVRhdY2YzpAoxfw8FaGWSQYlJ1+kqIhNnJC0v
         B58ip1Ud6BzhpucWWyH4QhjjdTbnDiqhF6oBqbt3NjucWArjtlEhukVVjrvj4G+jwHaR
         09ToTIN5A1PRx5OZguP/wQbF4vc3rLIVM175UQ1QU7N5UFQxX1ffvPVlVgT/5YhGgDWk
         hLWyrtZKE8IjbZPk7Da7nohiEm+Y/obU2wQr/MecxbRw3uS5DDVJAe1/DkgOV/mZ+jVl
         VcvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkTLW3UvFq7dvQ3K5FPSEgFnUTuJiq/QtdYGJV1/Z6rH8hTsxQx4YIAd3Lsm/qw3Ecyh6ZUbwU05m9@vger.kernel.org
X-Gm-Message-State: AOJu0YwhbXwfIJeX6oo8Dm6Mr28511Ma7hGu3XUG93tCZkQztE1+gXRq
	H20DQUrjP671eM7QSZZBRoMgzAgpWjFZOxdZEZ/jFhOojFJXxL+GXi68RkZ4k/w=
X-Gm-Gg: ASbGncuHl29fZ56pz5mAkL0FmAMbarDphovYJZmW0akCaV1X7IEFoIFx4qFLMzMaXub
	cJCKWZ/sJIoAZlG0FL6NnjMGbGNtOJ50ZzGCBpW6GhV9jBaROHP9FuYnbyIhXIhmkeA43VFDO7j
	tVV2Z0rtmWuFvdhFDepTmbN2x9vIKAliNR8DXXLrW3lCJBBbIKOdL62/yFUpt3lbKeM9G8unTlv
	p6InYV0YGAhxOrWqcWh2r74oFdf3yKX4uCM7O5eQbXcEkfzIzFUtBbYc4UpC4WPQqKE6G79uHs8
	K+bg2if+cUfxEgHeIioHmQVXG3g+/FUgfAYIZGmgpHVoQ8/xsfaaQaMbemzSj3Xk34DSAo9L
X-Google-Smtp-Source: AGHT+IHHqngOXkEUDbnzih53IIYvud+CjZpBukJjI4zseJsAAFNb4EbCmZckikl17w1FCYOPaN0FHw==
X-Received: by 2002:a05:600c:4750:b0:43b:c390:b77f with SMTP id 5b1f17b1804b1-43bd29d557amr21862305e9.26.1741187303674;
        Wed, 05 Mar 2025 07:08:23 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4292eeasm19788315e9.16.2025.03.05.07.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:08:23 -0800 (PST)
Date: Wed, 5 Mar 2025 16:08:19 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, 
	Aron Silverton <aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>, 
	David Ahern <dsahern@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
 <20250303175358.4e9e0f78@kernel.org>
 <20250304140036.GK133783@nvidia.com>
 <20250304164203.38418211@kernel.org>
 <20250305133254.GV133783@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305133254.GV133783@nvidia.com>

Wed, Mar 05, 2025 at 02:32:54PM +0100, jgg@nvidia.com wrote:
>On Tue, Mar 04, 2025 at 04:42:03PM -0800, Jakub Kicinski wrote:
>> On Tue, 4 Mar 2025 10:00:36 -0400 Jason Gunthorpe wrote:
>> > I never agreed to that formulation. I suggested that perhaps runtime
>> > configurations where netdev is the only driver using the HW could be
>> > disabled (ie a netdev exclusion, not a rdma inclusion).
>> 
>> I thought you were arguing that me opposing the addition was
>> "maintainer overreach". As in me telling other parts of the kernel
>> what is and isn't allowed. Do I not get a say what gets merged under
>> drivers/net/ now?
>
>The PCI core drivers are a shared resource jointly maintained by all
>the subsytems that use them. They are maintained by their respective
>maintainers. Saeed/etc in this case.
>
>It would be inappropriate for your preferences to supersede Saeed's
>when he is a maintainer of the mlx5_core driver and fwctl. Please try
>and get Saeed on board with your plan.
>
>If the placement under drivers/net makes this confusing then we can
>certainly change the directory names.

According to how mlx5 driver is structured, and the rest of the advanced
drivers in the same area are becoming as well, it would make sense to me
to have mlx5 core in separate core directory, maintained directly by driver
maintainer:
drivers/core/mlx5/
then each of the protocol auxiliary device lands in appropriate
subsystem directory.
It's not always simple to find clear cut though. Like for example
devlink and representors code related to eswitch orchestration.

The benefit would be that lots of core-related non-netdev patch-trafic
would go directly, which would ease the netdev maintainership burden and
would make things more flexible. This per-driver-serialization for
patchset processing bottleneck would become much more bareable.

