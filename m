Return-Path: <linux-rdma+bounces-20899-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OcqE0v3CmpZ+QQAu9opvQ
	(envelope-from <linux-rdma+bounces-20899-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 13:26:03 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED85856B847
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 13:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4876C3004917
	for <lists+linux-rdma@lfdr.de>; Mon, 18 May 2026 11:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F633C4579;
	Mon, 18 May 2026 11:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnXg0ZsB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E9A33064D;
	Mon, 18 May 2026 11:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779103560; cv=none; b=Qn30qmXCHowFm41DqnLbi/upRNQ31yDVWZbGrWydN98jeAssmBLtJ+nUMR0wOknXN1iImPQb0u08KndMWy4CkTpQE6+tQttC7TPSaQjixOWVx87A2WKYxMK3Y19prHedqF1BK0A+EAAdv7W2NvRTZBbQ5ElU9CiXA3guXPemrxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779103560; c=relaxed/simple;
	bh=cFP/kYw93ya9e3AWP5GfzSZZ8+DWCZ2p9hl+XArWY+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKRdQFHqD9r9ghfrT6oJ+wS/NfR1Er9HSvTDdXCgvmKv67ogpz7ZGUuHx/qDXArOCQvX0QigX1CT54sJXWtWiptcbDqeKg90VWZbZnkWL3sKz+eyiO3SDJYY5Loxgqo+857bb87nx5S4+2/kjLDpZEsHy3/RKu1M86lm5vJtRrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnXg0ZsB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B5FC2BCB7;
	Mon, 18 May 2026 11:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779103560;
	bh=cFP/kYw93ya9e3AWP5GfzSZZ8+DWCZ2p9hl+XArWY+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hnXg0ZsBK4diSywcApYRQAZZl56fALlM9v3t62EbqQMXUsnHCwyDaU99VD9/h2UR9
	 a3suD/nVzon9rSdE/4gR86869hot88D+mv2KM2DJJbkqu472Onw0Y3jQGX6yz4Gzp6
	 AEZqVZKQVqhij7rcfdsZQl21L8/wJDDGdzrpMne90HWueSouP3X70Po6GrTBv0zW8o
	 m/dFiWm0ksjpetvH5yKtVtPaZu891klFSkLyzK784cK57bGzizFy9me/RLnKwmieF0
	 iez9ackyaax63qWGT/nYNvFCZEazGIABdmBZ1yzPgNXlj83Aj2prr9EzDsQYMhZMgK
	 9Mpeq2In4Z1oQ==
Date: Mon, 18 May 2026 14:25:55 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Will Mortensen <will@extrahop.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, netdev <netdev@vger.kernel.org>,
	Shahar Shitrit <shshitrit@nvidia.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-rdma <linux-rdma@vger.kernel.org>,
	Jeremy Royal <jeremyr@extrahop.com>
Subject: Re: [PATCH net v3] net/mlx5: don't printk garbage when transceiver
 overheats
Message-ID: <20260518112555.GM33515@unreal>
References: <20260515-b4-mlx5-sensor-fix-v3-1-f537ce191d6c@extrahop.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515-b4-mlx5-sensor-fix-v3-1-f537ce191d6c@extrahop.com>
X-Rspamd-Queue-Id: ED85856B847
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20899-lists,linux-rdma=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 11:10:36PM -0700, Will Mortensen wrote:
> When the mlx5 driver processes a temperature warning event, in events.c
> and hwmon.c, temp_warn() calls print_sensor_names_in_bit_set(), which
> calls hwmon_get_sensor_name() to get the NUL-terminated name of the
> relevant sensor, and then prints it to dmesg. In particular,
> print_sensor_names_in_bit_set() passes the bit index ("sensor index")
> within the 128-bit vector in the warning event to
> hwmon_get_sensor_name(). But hwmon_get_sensor_name() was expecting the
> index of the hwmon channel, and the driver registers hwmon channels for
> at most only two sensors: the ASIC sensor (sensor index 0) and the
> module sensor (sensor index 64 or 65 on a 2-port NIC). So when the
> warning event concerned a module, hwmon_get_sensor_name() took the 64th
> or 65th element of the likely 2-element temp_channel_desc array and thus
> returned a pointer to some other kernel memory past the end of it, which
> was printed to dmesg up to the first NUL byte.
> 
> A further difficulty is that, at least in testing on our CX-8 C8240 with
> firmware 40.47.1088, the warning event can have bits set for other
> modules, e.g. if this PCI physical function is associated with
> port/module 0, we might expect bit 64 to be set, but bit 65 (for port/
> module 1) can also be set unexpectedly.
> 
> Fix this by clarifying that the argument to hwmon_get_sensor_name() is
> the raw sensor index, and correctly converting it to the hwmon channel
> index. Return NULL if the sensor index doesn't correspond to a hwmon
> channel (e.g. because it's for the other function/port's module).
> 
> Fixes: 46fd50cfcc12 ("net/mlx5: Add sensor name to temperature event message")
> Reviewed-by: Jeremy Royal <jeremyr@extrahop.com>
> Signed-off-by: Will Mortensen <will@extrahop.com>
> ---
> Changes in v3:
> - Fix ordering of Signed-off-by
> - Add target tree name
> - Add CCs
> - Tweak commit message
> - Link to v2: https://lore.kernel.org/r/20260512-b4-mlx5-sensor-fix-v2-1-531fee4fd7fd@extrahop.com
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/events.c |  2 ++
>  drivers/net/ethernet/mellanox/mlx5/core/hwmon.c  | 15 ++++++++++++++-
>  drivers/net/ethernet/mellanox/mlx5/core/hwmon.h  |  2 +-
>  3 files changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/events.c b/drivers/net/ethernet/mellanox/mlx5/core/events.c
> index 4d7f35b96876..9372551c7f90 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/events.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/events.c
> @@ -165,6 +165,8 @@ static void print_sensor_names_in_bit_set(struct mlx5_core_dev *dev, struct mlx5
>  	for_each_set_bit(i, bit_set_ptr, num_bits) {
>  		const char *sensor_name = hwmon_get_sensor_name(hwmon, i + bit_set_offset);
>  
> +		if (!sensor_name)
> +			continue;
>  		mlx5_core_warn(dev, "Sensor name[%d]: %s\n", i + bit_set_offset, sensor_name);
>  	}
>  }
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c
> index afcdebac9c4f..747ff30362f1 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/hwmon.c
> @@ -417,7 +417,20 @@ void mlx5_hwmon_dev_unregister(struct mlx5_core_dev *mdev)
>  	mdev->hwmon = NULL;
>  }
>  
> -const char *hwmon_get_sensor_name(struct mlx5_hwmon *hwmon, int channel)
> +const char *hwmon_get_sensor_name(struct mlx5_hwmon *hwmon, int sensor_idx)
>  {
> +	int channel;
> +
> +	if (sensor_idx >= 64) {
> +		if (hwmon->module_scount == 0)
> +			return NULL;
> +		channel = hwmon->asic_platform_scount;
> +		if (sensor_idx != hwmon->temp_channel_desc[channel].sensor_index)
> +			return NULL;
> +	} else {
> +		if (sensor_idx >= hwmon->asic_platform_scount)
> +			return NULL;
> +		channel = sensor_idx;
> +	}
>  	return hwmon->temp_channel_desc[channel].sensor_name;

Honestly, this approach feels overly complex and fragile for something as
simple as printing to dmesg. In my opinion, you should drop
print_sensor_names_in_bit_set().

Thanks

