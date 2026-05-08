Return-Path: <linux-rdma+bounces-20222-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QL2GCN6m/Wl0ggAAu9opvQ
	(envelope-from <linux-rdma+bounces-20222-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 11:03:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7264C4F3FC7
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 11:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FECF301BF76
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 09:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1372037D12A;
	Fri,  8 May 2026 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7Qsovx+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EE6270EDF
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 09:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778230952; cv=none; b=KiNvRYIIUOzi5r9yRMsZwe4MJLDLeL15szMoiUXNWIv+/mo8CnCoaxXKHG1+X/88JQrSb7caFdnXXUNqxj4zSDsY8JQSpmB4Xp4vXhLUJjM6ShSRB8M7HCPSTQseEi8sGq5Ax0bt94RO7OW6F2KsDXe9l7XSIYjgT/xIKMlZbSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778230952; c=relaxed/simple;
	bh=WIPNyT+MJITZgScNy15NlVstSPVx6hRR32XdQhokLmY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gkcdmrtLcdd0Cc4SOXAqR5Z0l17WBvt8UOnFEzMS1YGUlM1VD7lc8xNUMLzsIwM7nsz7x++sJcWrMNBwAHwRNlaOhnDjL6vxB9EvrxLcNBPQZuXyrKhGYtVJ+V/QlI9kHNNw5YxJk665DMrRIqVh7a0w3RaXh2s48h113elZtio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7Qsovx+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso19829585e9.3
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 02:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778230949; x=1778835749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlYOG3XzQZlo22JT9TgpdXVisycjOjKnbVWOM2UqaHQ=;
        b=Q7Qsovx+vjB2CNZ4ZmA2+m+ZuI8vwuwxbbdeGJoUUWWBw9hvhSYU6URCEk/d1U4X9e
         Sm9Kx2yekUieIDnw9LLiiQ4U1aGJMhdyZuqDkCr9ZochQvNtTkuwm9pE1LXVGrCmr1TN
         GTPK5fvtZtazkSAzSH5XLMxeyKwaV1TIqcRfCMs2CK0MFJ8dmCbYMumqW2yp1gevmXev
         xOvSutn2JztZ5JFleB1yaGZH0t9ZcUtvhd55sAKsLjyAbxep7tZ2eDw6IWH6yCj4XlIl
         0Spu4x3Eh7OT14OrYzVL2gD5Dk8kKHbueUx1OzsfkNttganF5ZGtaEYPR1rLSm8MkilM
         rCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778230949; x=1778835749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HlYOG3XzQZlo22JT9TgpdXVisycjOjKnbVWOM2UqaHQ=;
        b=g+JCd6xFY+qhSTPQIaKzUDnJfe7M/cYhtCkRrRPhIJw2fRxZmjs2Snv4iqE7oHmFwa
         aTlzcw0c1nCQ7TGLkX1FwI0MYvoWICYiFcG14pLqBVEDfORR3yGnrvB9MDwUqMOtYW3U
         /cNl9FqTwM8tEKjK9y2c8H0plKwyyHHphAX8nyJ1FjqL5jz/i+dn/BkoutJjOiQrYZ32
         nFTlr6+KvZS7gbYVwWOG5SGH/xDwT6EBVd5Haw4I9wdimb7/HH1pwArXORe3QPdzuiky
         3iWaqOM6lpyQg4A+DBLpY7LadQLSNsayuXMMbF54eujGzKM5y4hx/lMgQWIbMgCjHbIc
         74AA==
X-Forwarded-Encrypted: i=1; AFNElJ/EYLE8RWdjsCeKmMhROfw04A+y8zdYeqTAdrR+dCF0wMusrIgzwvRm1v8dCApREbCtzbma+y5cYSys@vger.kernel.org
X-Gm-Message-State: AOJu0YzjWnlrhBv3m/qaFooZOJdhTbWWf8N53InZaD8dPbjDIwx8CxB5
	81ES7hCkCg1XAqnFvgxyHigWVThO9HbiO7NHkiRqjIzggBN0x/MXojqf
X-Gm-Gg: AeBDievQOvfGB4pxQWPvjqt6aj6q2FZS4JD0ZmapXRfPAwStC9ycezGQWO8lQ/cQMe8
	Cgnm5kmB+FcDppPEKjwEk42mvNqjhTvj5K4o1l9tdJ6ZhA7HwGZOixYXELWe2vxV+MX/jOET7zg
	ZHX+p4MQHBWgC8ZeV7VQMZgn4cNZ0FFFfb8Gv7Bi0t0q14bLqwyJqI1tRWLVNIySiTvcm6nkCF9
	5a1QFv3HgpGWh2vMuvT+v1DCWtMn5kx4c/Etr7Jlkr8ziIbXh+jVsOmKlmPR61fKtJQw6Se6fPA
	xLeVWGCfStR523OlyX6z6DYXC9gutR7VR+E0G9QTPhKF/+r2CeepQsuT+Ua1gS9tkd5ErvVOP9y
	eVb8A4BAKc9aQKDP3ytsWEdQfqOSHENiJBA2VSvKvrESUmaFsD/LcVfmpgR7ECqGqhe4SteLf2A
	7ThhlTc0UHHpE+JOgDlN9BgITGQbfYRmBQYZGi1/StGBX5yWt67E3i0OTCjqUOmJ8a
X-Received: by 2002:a05:600c:8011:b0:48a:80cb:1bb4 with SMTP id 5b1f17b1804b1-48e51f3b00emr178439985e9.22.1778230948591;
        Fri, 08 May 2026 02:02:28 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491bae13csm2842091f8f.29.2026.05.08.02.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 02:02:27 -0700 (PDT)
Date: Fri, 8 May 2026 10:02:26 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
 <oss-drivers@corigine.com>, <akiyano@amazon.com>, <andrew+netdev@lunn.ch>,
 <anthony.l.nguyen@intel.com>, <arkadiusz.kubalewski@intel.com>,
 <brett.creeley@amd.com>, <darinzon@amazon.com>, <davem@davemloft.net>,
 <donald.hunter@gmail.com>, <edumazet@google.com>, <horms@kernel.org>,
 <idosch@nvidia.com>, <ivecera@redhat.com>, <jiri@resnulli.us>,
 <kuba@kernel.org>, <leon@kernel.org>, <mbloch@nvidia.com>,
 <michael.chan@broadcom.com>, <pabeni@redhat.com>,
 <pavan.chebbi@broadcom.com>, <petrm@nvidia.com>,
 <Prathosh.Satish@microchip.com>, <przemyslaw.kitszel@intel.com>,
 <saeedm@nvidia.com>, <sgoutham@marvell.com>, <tariqt@nvidia.com>,
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH v12 net-next 2/9] net/mlx5e: trim stack use in PCIe
 congestion threshold helper
Message-ID: <20260508100226.49294dc3@pumpkin>
In-Reply-To: <20260508034912.4082520-3-rkannoth@marvell.com>
References: <20260508034912.4082520-1-rkannoth@marvell.com>
	<20260508034912.4082520-3-rkannoth@marvell.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7264C4F3FC7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20222-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,corigine.com,amazon.com,lunn.ch,intel.com,amd.com,davemloft.net,gmail.com,google.com,kernel.org,nvidia.com,redhat.com,resnulli.us,broadcom.com,microchip.com,marvell.com,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,marvell.com:email]
X-Rspamd-Action: no action

On Fri, 8 May 2026 09:19:05 +0530
Ratheesh Kannoth <rkannoth@marvell.com> wrote:

> union devlink_param_value grew when U64 array parameters were added.
> Keeping a four-element array of that union in
> mlx5e_pcie_cong_get_thresh_config() inflated the stack frame past the
> -Wframe-larger-than limit.
> 
> Read each driverinit value into a single reused union, then store the
> four u16 thresholds in struct mlx5e_pcie_cong_thresh field order via a
> temporary u16 pointer to config.
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  .../mellanox/mlx5/core/en/pcie_cong_event.c   | 34 +++++++++++--------
>  1 file changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
> index 2eb666a46f39..88e76be3a73d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/pcie_cong_event.c
> @@ -252,28 +252,32 @@ static int
>  mlx5e_pcie_cong_get_thresh_config(struct mlx5_core_dev *dev,
>  				  struct mlx5e_pcie_cong_thresh *config)
>  {
> +	enum {
> +		INBOUND_HIGH,
> +		INBOUND_LOW,
> +		OUTBOUND_HIGH,
> +		OUTBOUND_LOW,
> +	};
> +
>  	u32 ids[4] = {

Someone will suggest that should be 'static const'.
It may make the code smaller.

> -		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_LOW,
> -		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_HIGH,
> -		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_LOW,
> -		MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_HIGH,
> +		[INBOUND_LOW] = MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_LOW,
> +		[INBOUND_HIGH] = MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_HIGH,
> +		[OUTBOUND_LOW] = MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_LOW,
> +		[OUTBOUND_HIGH] = MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_HIGH,
>  	};
> -	struct devlink *devlink = priv_to_devlink(dev);
> -	union devlink_param_value val[4];
>  
> -	for (int i = 0; i < 4; i++) {
> -		u32 id = ids[i];
> -		int err;
> +	struct devlink *devlink = priv_to_devlink(dev);
> +	union devlink_param_value val;
> +	u16 *dst = (u16 *)config;

You can't do that - far too fragile.
Maybe &config->inbound_low - but even that assumes the values are in order.
A safer way would be using a temporary 'u16 val16[4]'.
(Or even overwrite ids[] with the result.)

But the code might even be smaller if you just unroll the loop:
	err = devl_param_driverinit_value_get(devlink, MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_LOW, &val);
	if (err)
		return err;
	config->inbound_low = val.vu16;
	err = devl_param_driverinit_value_get(devlink, MLX5_DEVLINK_PARAM_ID_PCIE_CONG_IN_HIGH, &val);
	if (err)
		return err;
	config->inbound_high = val.vu16;
	err = devl_param_driverinit_value_get(devlink, MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_LOW, &val);
	if (err)
		return err;
	config->outbound_low = val.vu16;
	err = devl_param_driverinit_value_get(devlink, MLX5_DEVLINK_PARAM_ID_PCIE_CONG_OUT_HIGH, &val);
	if (err)
		return err;
	config->outbound_high = val.vu16;

-- David


> +	int err;
>  
> -		err = devl_param_driverinit_value_get(devlink, id, &val[i]);
> +	for (int i = 0; i < ARRAY_SIZE(ids); i++) {
> +		err = devl_param_driverinit_value_get(devlink, ids[i], &val);
>  		if (err)
>  			return err;
> -	}
>  
> -	config->inbound_low = val[0].vu16;
> -	config->inbound_high = val[1].vu16;
> -	config->outbound_low = val[2].vu16;
> -	config->outbound_high = val[3].vu16;
> +		dst[i] = val.vu16;
> +	}
>  
>  	return 0;
>  }


