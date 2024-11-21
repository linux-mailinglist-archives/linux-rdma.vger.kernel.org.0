Return-Path: <linux-rdma+bounces-6049-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BA79D49DB
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2024 10:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5039B216D0
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2024 09:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2631CB528;
	Thu, 21 Nov 2024 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bLQEQ28Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425E0158D79
	for <linux-rdma@vger.kernel.org>; Thu, 21 Nov 2024 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180963; cv=none; b=lKZ8lXX5ZFXXSxARmNj2338XE/cFVhEiyx2KLQIsac223jXey/J/jVQ7J2/So9SBIGxHfG1z/EAHI32LlXP6NG8qblwFCtmBsbnBp+/0MruiDPKNOWsW7dBacskmM4hPqXu1U3UZTHa2l+SDXE8YEN1LZRup74C6am0hITM64SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180963; c=relaxed/simple;
	bh=QUILc50Xdy1CTE1OVoUVFGHKtj2Tn318wiiJgHe1TsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4SfWpqdHSrKqc9kOeaan3UeNeZJGab0dzyN7bOO2gz+rC6XgbL+Z0nMBrstE8TCuhPZ2onBrTth/NdnaYCMLKXoC78J+lxXn7L9E7ERwrvp1+n0M0he7H0AE8R0cfjtY6G5Np8/OxDVq9D/UblqK+cP6BwfcRjVbsaF0BDUWW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bLQEQ28Q; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e91403950dso558985a91.3
        for <linux-rdma@vger.kernel.org>; Thu, 21 Nov 2024 01:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1732180959; x=1732785759; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=anCiwarguAnNIpfIhufEwHUzRdLPbg004JR1jBpxyR0=;
        b=bLQEQ28Q06VZ/8r8bYX+WVNeszJY7Si3pbcRpSRJuipA3qRFzkevl+L2SG85LTo0Rb
         qdPtp+Zhji020iOoypLoapggCGpTmYRcaPPScR1F7BPmdKe5YWqPCDywnqwIHhaSSq3R
         HlaFAMFMHoX79hxkd7+8vKK4Ky6DKWRvwd1I68X2qJjXq9PiawAqAoDGuQZyOTzUtvAR
         SIPz/Elr9+jls53Qslov72kqgbLkOXKkMn9p/ElX0hJwXUfZjjuktJpjJ8e2yNVPD/PL
         wNdThC2qYPU6A9Ez1DaSvplTZuNEsd09ZZH6eTk+Ilmfh9CULxbu30IOx2NKLHg7n0rl
         8zIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732180959; x=1732785759;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=anCiwarguAnNIpfIhufEwHUzRdLPbg004JR1jBpxyR0=;
        b=AVeY/JmcDxdgRLfPDH1jRG4XX+nckofLgOu4raC+QqQZq2N6ABTq0h4Nb9jzAmFMG2
         rvbGNqUxonvK33gcS3uBmtahDF0gUGeiU+e2es/dGQFDek5PdxoxQP1kkFdHBnToQjYY
         ZuwmIeWbedB2ea6OuV3+UCFRaVtdB2uMzm3kIUFgWPEqPQVJVLP0uUFW7/RiaAwtO8wS
         B3IIlfojR8d0oQ9VYfaEir0iWmqrz6VdjXLaRHtXhlq1R0tSFDpJES8BCd2lNoggl1r2
         JnNQdx2tPzTAaOwe7TKtPZl+x3PuLnJE1F8JZ+03vlx3evQslcOf5WNyDYoVBo3bzs+s
         CDtw==
X-Gm-Message-State: AOJu0YzjQdIq4TUwXR/4CJxc/rs+NMD5vl3UegLiq6iLgSPiYzMFumu1
	JmOzYjtZB0eHjaPvsVtrYCeD51HWHWZ3groegNd4wxHTp/rdqtPF/kaA1N8CYB4=
X-Gm-Gg: ASbGnctfbjlxssW+RcvLksiE6VU2n7FcEztiMMyUuvhdGGYGQKznGe7vSSIMH3Zyk18
	hOjzrVbg3W1ONucydRT98xjyJbFLxJT4b7r6PYczFggHXKPhe4XtqOrSR7zejUdQKJd8lj7sOE8
	p4S2vJY6dMDeqHWk+IMv1FNud7y+viHMY2BmU56munRfGik2QnA4zJJ314kvEyHuOff+pbtMCVf
	zk6WUPCEedh5jl36LFVZjTE2jL3XBeNCO7JbxNG99LXS9ECAbmTXnabWJfPwKRLS9w5Uw==
X-Google-Smtp-Source: AGHT+IEEgyub4D8pczAfSXSyb/ES+28tnM7y4Fab6MwH/eRQtc4XQ4qLQSQ4lnr8f56exnSAmz12ZA==
X-Received: by 2002:a17:90b:4ad2:b0:2ea:5c01:c1a4 with SMTP id 98e67ed59e1d1-2eaca744872mr7191755a91.20.1732180959540;
        Thu, 21 Nov 2024 01:22:39 -0800 (PST)
Received: from [10.67.174.193] ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead0392f0asm2717995a91.43.2024.11.21.01.22.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 01:22:39 -0800 (PST)
Message-ID: <b044faad-1e3f-4c65-b2e6-fc418aebd22e@bytedance.com>
Date: Thu, 21 Nov 2024 17:22:36 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] RDMA/core: Fix IPv6 loopback dst MAC address lookup logic
To: jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241110123532.37831-1-yuezelong@bytedance.com>
From: Zelong Yue <yuezelong@bytedance.com>
In-Reply-To: <20241110123532.37831-1-yuezelong@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Gently ping. Do I need to provide more detailed information on how to 
reproduce the issue?

On 11/10/24 8:35 PM, yuezelong wrote:
> Imagine we have two RNICs on a single machine, named eth1 and eth2, with
>
> - IPv4 addresses: 192.168.1.2, 192.168.1.3
> - IPv6 addresses (scope global): fdbd::beef:2, fdbd::beef:3
> - MAC addresses: 11:11:11:11:11:02, 11:11:11:11:11:03,
>
> they all connnected to a gateway with MAC address 22:22:22:22:22:02.
>
> If we want to setup connections between these two RNICs, with RC QP, we
> would go through `rdma_resolve_ip` for looking up dst MAC addresses. The
> procedure it's the same as using command
>
> `ip route get dst_addr from src_addr oif src_dev`
>
> In IPv4 scenario, you would likely get
>
> ```
> $ ip route get 192.168.1.2 from 192.168.1.3 oif eth2
>
> 192.168.1.2 from 192.168.1.3 via 192.168.1.1 dev eth2 ...
> ```
>
> Looks reasonable as it would go through the gateway.
>
> But in IPv6 scenario, you would likely get
>
> ```
> $ ip route get fdbd::beef:2 from fdbd::beef:3 oif eth2
>
> local fdbd::beef:2 from fdbd::beed:3 dev lo table local proto kernel src fdbd::beef:2 metric 0 pref medium
> ```
>
> This would lead to the RDMA route lookup procedure filling the dst MAC
> address with src net device's MAC address (11:11:11:11:11:03),  but
> filling the dst IP address with dst net device's IPv6 address
> (fdbd::beef:2), src net device would drop this packet, and we would fail
> to setup the connection.
>
> To make setting up loopback connections like this possible, we need to
> send packets to the gateway and let the gateway send it back (actually,
> the IPv4 lookup result would lead to this, so there is no problem in IPv4
> scenario), so we need to adjust current lookup procedure, if we find out
> the src device and dst device is on the same machine (same namespace),
> we need to send the packets to the gateway instead of the src device
> itself.
>
> Signed-off-by: yuezelong <yuezelong@bytedance.com>
> ---
>   drivers/infiniband/core/addr.c | 95 +++++++++++++++++++++++++++++++++-
>   drivers/infiniband/core/cma.c  |  7 ++-
>   2 files changed, 99 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
> index c4cf26f1d149..d194e6b7f2b9 100644
> --- a/drivers/infiniband/core/addr.c
> +++ b/drivers/infiniband/core/addr.c
> @@ -545,6 +545,29 @@ static void rdma_addr_set_net_defaults(struct rdma_dev_addr *addr)
>   	addr->bound_dev_if = 0;
>   }
>   
> +static struct dst_entry *get_default_ipv6_route(struct in6_addr *src_addr, struct net_device *dev)
> +{
> +	struct flowi6 fl6;
> +	struct dst_entry *dst = NULL;
> +
> +	memset(&fl6, 0, sizeof(fl6));
> +	fl6.flowi6_iif = dev_net(dev)->loopback_dev->ifindex;
> +	fl6.flowi6_oif = dev->ifindex;
> +	fl6.saddr = *src_addr;
> +	fl6.daddr = in6addr_any;
> +
> +	dst = ipv6_stub->ipv6_dst_lookup_flow(dev_net(dev), NULL, &fl6, NULL);
> +	if (IS_ERR(dst))
> +		return NULL;
> +
> +	if (dst && dst->error) {
> +		dst_release(dst);
> +		return NULL;
> +	}
> +
> +	return dst;
> +}
> +
>   static int addr_resolve(struct sockaddr *src_in,
>   			const struct sockaddr *dst_in,
>   			struct rdma_dev_addr *addr,
> @@ -597,9 +620,77 @@ static int addr_resolve(struct sockaddr *src_in,
>   	 * Resolve neighbor destination address if requested and
>   	 * only if src addr translation didn't fail.
>   	 */
> -	if (!ret && resolve_neigh)
> -		ret = addr_resolve_neigh(dst, dst_in, addr, ndev_flags, seq);
> +	if (!ret && resolve_neigh) {
> +		if ((src_in->sa_family == AF_INET6) && (ndev_flags & IFF_LOOPBACK)) {
> +			rcu_read_lock();
> +			/*
> +			 * When src net device and dst net device is different device,
> +			 * traditional TCP/IP loopback won't work for RDMA. We need to find
> +			 * gateway for src net device and send packets to the gateway, then
> +			 * let the gateway send it back to the dst device. This is likely
> +			 * be problematic in IPv6 scenario, the route logic would likely fill
> +			 * the dst MAC address with src net device's MAC, but with dst IP
> +			 * belongs to the dst net device, leading to packet drop.
> +			 *
> +			 * Thus, we need to figure out gateway's MAC address in IPv6 loopback
> +			 * scenario.
> +			 */
> +			struct net_device *ndev = READ_ONCE(dst->dev);
> +			struct net_device *src_ndev = rdma_find_ndev_for_src_ip_rcu(dev_net(ndev),
> +										    src_in);
> +			struct net_device *dst_ndev = rdma_find_ndev_for_src_ip_rcu(dev_net(ndev),
> +										    dst_in);
> +
> +			if (IS_ERR(src_ndev) || IS_ERR(dst_ndev)) {
> +				ret = -ENODEV;
> +				rcu_read_unlock();
> +				goto exit;
> +			}
> +
> +			if (src_ndev != dst_ndev) {
> +				dst_release(dst);
> +				dst = get_default_ipv6_route((struct in6_addr *)src_in->sa_data,
> +							     src_ndev);
> +				ndev_flags = src_ndev->flags;
> +			} else {
> +				rcu_read_unlock();
> +				/*
> +				 * For real loopback (src and dst is the same device), we can
> +				 * just use the original code path.
> +				 */
> +				ret = addr_resolve_neigh(dst, dst_in, addr, ndev_flags, seq);
> +				goto exit;
> +			}
> +			rcu_read_unlock();
> +
> +			if (dst == NULL) {
> +				ret = -EINVAL;
> +				goto done;
> +			}
> +
> +			/*
> +			 * Though we fill `in6addr_any` as dst addr here, `xfrm_neigh_lookup`
> +			 * would still find nexthop for us, which provides gateway MAC address.
> +			 */
> +			struct sockaddr_in6 addr_in = {
> +				.sin6_family = AF_INET6,
> +				.sin6_addr = in6addr_any,
> +			};
> +			const void *daddr = (const void *)&addr_in.sin6_addr;
> +
> +			might_sleep();
> +
> +			/*
> +			 * Use `addr_resolve_neigh` here would go into `ib_nl_fetch_ha` branch,
> +			 * which would fail because of `rdma_nl_chk_listeners` returns error.
> +			 */
> +			ret = dst_fetch_ha(dst, addr, daddr);
> +		} else {
> +			ret = addr_resolve_neigh(dst, dst_in, addr, ndev_flags, seq);
> +		}
> +	}
>   
> +exit:
>   	if (src_in->sa_family == AF_INET)
>   		ip_rt_put(rt);
>   	else
> diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> index 64ace0b968f0..744f396568cd 100644
> --- a/drivers/infiniband/core/cma.c
> +++ b/drivers/infiniband/core/cma.c
> @@ -1612,7 +1612,12 @@ static bool validate_ipv6_net_dev(struct net_device *net_dev,
>   	if (!rt)
>   		return false;
>   
> -	ret = rt->rt6i_idev->dev == net_dev;
> +	if (rt->rt6i_flags & (RTF_LOCAL | RTF_NONEXTHOP)) {
> +		// TODO: how to validate netdev when the device is loopback?
> +		ret = true;
> +	} else {
> +		ret = rt->rt6i_idev->dev == net_dev;
> +	}
>   	ip6_rt_put(rt);
>   
>   	return ret;

