Return-Path: <linux-rdma+bounces-7776-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09394A37063
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Feb 2025 20:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C910516CEA5
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Feb 2025 19:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B403D1F4172;
	Sat, 15 Feb 2025 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOqyZZj/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A861A9B58;
	Sat, 15 Feb 2025 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739647780; cv=none; b=Q8gX2zyuYP//F017zYnC2Z9sBK2zPL47/IUgJQHgenr/hRL7ZM2zEX7gBqPjORHSzjusTRpEWbNIgswkdeyEq2OKNgiw+hxpy31ADsFFwAvPVloFBzkAW4+7mKdeiZqksEwBdj0xRzPLMITrV6coowUSvrtnLfoCxtbji8fmHrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739647780; c=relaxed/simple;
	bh=ehjLwgwM1t69iI6E6+1h4fWJ2pSx2/m/NQW5hQlky4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZTzXEOuhie0ynRr2zkPIWAZmstlOad3oyLOJg7brU4cTAmIEUthWrN7it5eqnA4vfeD5+i+vLzZg+niNew3oAn7I/ehkW6uBEqwfNTnz9j0yfKbBClezQUlWmKpcFyLqnB5Xa37jyVlossJ04UcPQ+hkks2EY+7brLdipjsCXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SOqyZZj/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C0CFC4CEDF;
	Sat, 15 Feb 2025 19:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739647780;
	bh=ehjLwgwM1t69iI6E6+1h4fWJ2pSx2/m/NQW5hQlky4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SOqyZZj/6kaTgkoyRaSBLMkEf8t/HOsFy5n/BwQu/S8iSLlwwxv6GIW6enPOFSspd
	 tjulUo7ckzOFqTrhC2L6V8oTuOPa7/d2QraO3FXiIuUcXroVIO7m19mY3QTti2d1r1
	 Per0q5mHQyJ+o8VM+kuHJcgxZTnbjRrBDSii4fyxBR6QY963nCQN33VpGaXWaX4unX
	 5wZXByBs1xS6PpXwMg740spgBWodKwE2fZ6/jWFxDFw+t4SCx5UCYpqfLwDGt6vLQl
	 AXR5lN1Ry5NAW2bRNiBUmMfTRYa50AOOsw8xWD2SaxTCF7MpbVVwTx6h+CILnXSO7e
	 lAIvsFK8A3taA==
Date: Sat, 15 Feb 2025 19:29:35 +0000
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shahar Shitrit <shshitrit@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next 4/4] net/mlx5: Add sensor name to temperature
 event message
Message-ID: <20250215192935.GU1615191@kernel.org>
References: <20250213094641.226501-1-tariqt@nvidia.com>
 <20250213094641.226501-5-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213094641.226501-5-tariqt@nvidia.com>

On Thu, Feb 13, 2025 at 11:46:41AM +0200, Tariq Toukan wrote:
> From: Shahar Shitrit <shshitrit@nvidia.com>
> 
> Previously, a temperature event message included a bitmap indicating
> which sensors detect high temperatures.
> 
> To enhance clarity, we modify the message format to explicitly list
> the names of the overheating sensors, alongside the sensors bitmap.
> If HWMON is not configured, the event message remains unchanged.
> 
> Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
> Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>

...

> +#if IS_ENABLED(CONFIG_HWMON)
> +static void print_sensor_names_in_bit_set(struct mlx5_core_dev *dev, struct mlx5_hwmon *hwmon,
> +					  u64 bit_set, int bit_set_offset)
> +{
> +	unsigned long *bit_set_ptr = (unsigned long *)&bit_set;
> +	int num_bits = sizeof(bit_set) * BITS_PER_BYTE;
> +	int i;
> +
> +	for_each_set_bit(i, bit_set_ptr, num_bits) {
> +		const char *sensor_name = hwmon_get_sensor_name(hwmon, i + bit_set_offset);
> +
> +		mlx5_core_warn(dev, "Sensor name[%d]: %s\n", i + bit_set_offset, sensor_name);
> +	}
> +}

nit:

If you have to respin for some other reason, please consider limiting lines
to 80 columns wide or less here and elsewhere in this patch where it
doesn't reduce readability (subjective I know).

e.g.:

static void print_sensor_names_in_bit_set(struct mlx5_core_dev *dev,
                                          struct mlx5_hwmon *hwmon,
                                          u64 bit_set, int bit_set_offset)
{
        unsigned long *bit_set_ptr = (unsigned long *)&bit_set;
        int num_bits = sizeof(bit_set) * BITS_PER_BYTE;
        int i;

        for_each_set_bit(i, bit_set_ptr, num_bits) {
                const char *sensor_name;

                sensor_name = hwmon_get_sensor_name(hwmon, i + bit_set_offset);

                mlx5_core_warn(dev, "Sensor name[%d]: %s\n",
                               i + bit_set_offset, sensor_name);
        }
}

...

