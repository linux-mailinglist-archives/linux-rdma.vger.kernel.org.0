Return-Path: <linux-rdma+bounces-8704-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97348A613A9
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 15:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1C2883ECB
	for <lists+linux-rdma@lfdr.de>; Fri, 14 Mar 2025 14:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F0B1FDE0E;
	Fri, 14 Mar 2025 14:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/1YYG7t"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E487485;
	Fri, 14 Mar 2025 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741962691; cv=none; b=kHGgwS7lMGeFAicqHwe3bDY+910cpsJxIoul/n7gmXjdgEnwLGXyXW9C55eCOCM9UTbED2e7LLfYP9OLsZPez34YkUvMl3NqpyJupKtiYfTkDc4GbS8SJNFceiOodTpBSb+zgV/AtxSeIO63l+7zUkOGU4eR6hDGS8oIfRFpjdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741962691; c=relaxed/simple;
	bh=ym1t0HhYzi+uNqAzKhYR0HUnH6j3cdUQ68UUxTYpXMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZLIFJr+ARf95vblVH5Dp5ZA1aPtq8ECeQPinwoDaxvur/uj9KTOCqNzMIFgMxYzBrr40Us6kWaiCyQ48U3qAvVBJNbv+bpyWIGwA8iBUoWl/Ppldn0eRhrThIKtKXWEkeLCp5sFYjF7V9Nk6wtiJT/Rj4ChRjWSESPxaG4QlH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/1YYG7t; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2239c066347so46041535ad.2;
        Fri, 14 Mar 2025 07:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741962689; x=1742567489; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SrjknHmgf65ssRMbGjRwe0QuLHCWzzid6s0x5foLqw0=;
        b=b/1YYG7ty/XdFz55MEBqKZkNdlazVxy7yy7MgzCoH7yx0F2cnga019fGVRQj3NKzm4
         5GyuppzjGChhp90qkrahUnZn+3t9H2SJsfJuysGzigMuNlsp3LJEHkYDjRnixslenJbe
         ZkhuDSSnlXJd62whT59a81QmC0qCpcz6r0urgxBIbCqLokxiLpnJNoXrUGnUHfXYxZ9I
         VvkDTCe0mPK843EK3Gs0C12FIEpUqhX9TqvlSkUtO26VOERH4h03BfCI7PTayBC8cQni
         kYFwvgLFA+4xTCZovxYKihZBfiJacU6J43S8bDco1udTgzwPwiz+0J3Rvv3lqH5OhWbo
         588g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741962689; x=1742567489;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrjknHmgf65ssRMbGjRwe0QuLHCWzzid6s0x5foLqw0=;
        b=HowxtV/M31Vf4gEhcphxnJJYj7Cdl6uc2fJsXGAuCYxfKBKB4knGQ4ftjMxtLDtDHa
         gapMZPx1pFvfpqHe2nrBPkcW2Lu3Vlv2SPvd8Qnc+a4p+l2w4IPAjo9QxMLdxgkd2BZN
         gSjGFVUYbUHzTgAMStN39xKZuKC+4ZyVkVYqf4NBgU/YTbcerPPITAzpLG2tm+oxo55+
         BQBAr+q+9vsmDdQdOy3m8Aavf60EbLD0qim6y/CpaFrOK0cNMv2AbynZZ1UYezyYhgXT
         PaPU+hXvY9NOK34PZVa7nxhw3lesAhgPvzBA7Pc91OpoLXUML4e73hsmTQLFkiR8sc23
         606Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1lXmsK6z9pZSXxldB6K2Z75zk2Bv5lXjI+AFj753Cz6s5XEanPRRPMx7UldG4m2SZEOx0zmnkjmE=@vger.kernel.org, AJvYcCWEePq8ru+Ki6qzHTwtNhxSPd9hNDp8fn/WqZ+lOXlVSn5VhQ/GLtkwBdC8SuTjaTbOWLZqgjesYQXycA==@vger.kernel.org, AJvYcCWOGx/z1DmwvXdelVP6I9BOZ6HT/8bBtZDAJfN2uI3/MyG0/x0RH0DFUvnhJhETRQuWJnotQ3dr@vger.kernel.org, AJvYcCWkkoCNAuCh1z2vJv6IedTYb2X/iqwYoitzwKsJFJy6w8BBz2DUoQQybTr8SzPsDV1Z85aoeROqoo8K6dph@vger.kernel.org
X-Gm-Message-State: AOJu0YzZvKzKMz22n/6+xZOgG7hEMeEQd7bQiovKfkQpXEQmv4UWSTie
	Sd3tziSKK2J1HXxF7kL+AAKuJV58GIl3PqmOUWp9ChJhJMs0yaY=
X-Gm-Gg: ASbGncvH960lHcRsPHxVxGrJ2pUuhXmnfmg7Phrk8VQI3tYTptYZOEtYVDYTrtdAHC+
	agBj6RYcje9n2rC4qIIHGR7Rcl5Oxy7XXuM/kph3wzvysBKAJANqZ5yj+voVGIJmqGsBKlZwcgW
	bUP4bUvQNr2mUrsLM8ZGuNbRGHkKpqa8W/PNLIeziIid2jxEofGRlsh63OJhiPInSsu2HUmdPum
	AllTbo0w3NPqz63yZ+5M8qI0bdiCiSB0umWnpiUwaqL+cDg50s+qaU1um7wm7lArXp5evf4/Ke2
	H54fE4ixRf5TjIb0KtdM0zoTbHFmNxWLDzpzRmGKeWlP
X-Google-Smtp-Source: AGHT+IFJDqwdI6R+aufvCxuFg6s86CheuRTM4g3HmlZAvyFwPx9dHRbgZdyuUHEYvNKRcVKJeJG2/w==
X-Received: by 2002:a17:903:2388:b0:21f:4c8b:c514 with SMTP id d9443c01a7336-225e0b14e9fmr36237525ad.45.1741962689271;
        Fri, 14 Mar 2025 07:31:29 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-225c68884b6sm29234745ad.3.2025.03.14.07.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 07:31:28 -0700 (PDT)
Date: Fri, 14 Mar 2025 07:31:28 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Gal Pressman <gal@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yael Chemla <ychemla@nvidia.com>
Subject: Re: [PATCH net-next 4/4] net/mlx5e: Expose port reset cycle recovery
 counter via ethtool
Message-ID: <Z9Q9wBuDYHvEc4zY@mini-arch>
References: <1741893886-188294-1-git-send-email-tariqt@nvidia.com>
 <1741893886-188294-5-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1741893886-188294-5-git-send-email-tariqt@nvidia.com>

On 03/13, Tariq Toukan wrote:
> From: Yael Chemla <ychemla@nvidia.com>
> 
> Display recovery event of PPCNT recovery counters group. Counts (per
> link) the number of total successful recovery events of any recovery
> types during port reset cycle.
> 
> Signed-off-by: Yael Chemla <ychemla@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../ethernet/mellanox/mlx5/counters.rst       |  5 +++
>  .../ethernet/mellanox/mlx5/core/en_stats.c    | 44 ++++++++++++++++---
>  .../ethernet/mellanox/mlx5/core/en_stats.h    |  4 ++
>  3 files changed, 48 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
> index 99d95be4d159..f9a1cf370b5a 100644
> --- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
> +++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
> @@ -1082,6 +1082,11 @@ like flow control, FEC and more.
>         need to replace the cable/transceiver.
>       - Error
>  
> +  * - `total_success_recovery_phy`
> +     - The number of total successful recovery events of any type during
> +       ports reset cycle.
> +     - Error
> +

html build complains with the following:
Sphinx parallel build error:
docutils.utils.SystemMessagePropagation: <system_message level="3" line="896" source="/home/doc-build/testing/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst" type="ERROR"><paragraph>Error parsing content block for the "flat-table" directive: exactly one bullet list expected.</paragraph><literal_block xml:space="preserve">.. flat-table:: Physical Port Counter Table

https://netdev-3.bots.linux.dev/doc-build/results/32382/stderr

The indent is wrong?

* - xx
  - xx
  - xx

Vs yours:

* - xx
   - xx
   - xx

---
pw-bot: cr

