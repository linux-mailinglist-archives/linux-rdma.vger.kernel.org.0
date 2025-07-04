Return-Path: <linux-rdma+bounces-11893-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B05AF8516
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jul 2025 03:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92387188B6EB
	for <lists+linux-rdma@lfdr.de>; Fri,  4 Jul 2025 01:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A8472612;
	Fri,  4 Jul 2025 01:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ej/82xMS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B5D1EEE6
	for <linux-rdma@vger.kernel.org>; Fri,  4 Jul 2025 01:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751591654; cv=none; b=eIU4oTbIbcpwRfAosgsT5im/IZpvpzfXHCa8qgRqgJASeT6A7yg/FrDoEPmfkz6xUFhYro0yX0WzehoGyv7laYdA2z+0T6NG9afZRmWrFPRk1t7BkGdCem61zXA3r81nBNTsDGKDI9K4DOdfhaJ25anU87Pqrc3to+ztn/I0zEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751591654; c=relaxed/simple;
	bh=jH6eJFbNVeETdPYyq9LqfhPOffnsQjuthwwX05O6bzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCBhgdswjDlsxeP2i6SCvgZBdZ15q0jFA0KmWPGQXzn18L/k7rVL/TVjMhK8R7YSC3RSitMIFThB9XSU1Mui0HQ3OfBhlxsn5Bx3Naq6rycLj+r8piVx/9vOZ9U4DxhPQdMF1/hrfk+1VbH16+PsfkaGyfqBTRe/JipXPCpfkBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ej/82xMS; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b8cda822-f863-4cb2-a46d-c60eaa6ac005@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751591649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5W5iDDu/rz4QKMt6hTmS2yYrP5pYBE9G/mUIfXV60Aw=;
	b=ej/82xMSOzJznl9u58k3QrTKCV0sT+lgb5eqjY8a9SrGXscn1CCFqqbiTldlxoEH85Dkvn
	Cchk8yMoLlItPteQdjtTYIKiiULbnspqxwjHAh3FCbajFq8vrDCZhPshGpdoqFwWra/uzm
	EnPW2zRO1HaI0DPWgjZ1sgqtjF3L9ng=
Date: Thu, 3 Jul 2025 18:14:05 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/8] RDMA/siw: remove unused loopback_enabled = true
To: Stefan Metzmacher <metze@samba.org>, linux-rdma@vger.kernel.org
Cc: Bernard Metzler <bmt@zurich.ibm.com>
References: <cover.1751561826.git.metze@samba.org>
 <d0f0ddbf86e2570f51d32ccacb612336a820f855.1751561826.git.metze@samba.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <d0f0ddbf86e2570f51d32ccacb612336a820f855.1751561826.git.metze@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/3/25 10:26 AM, Stefan Metzmacher wrote:
> Devices are created explicitly by the administrator using
> 'rdma link add siw_lo type siw netdev lo'.

In the file drivers/infiniband/core/addr.c:

496 static int rdma_set_src_addr_rcu(struct rdma_dev_addr *dev_addr,
497                                  unsigned int *ndev_flags,
498                                  const struct sockaddr *dst_in,
499                                  const struct dst_entry *dst)
500 {
501         struct net_device *ndev = READ_ONCE(dst->dev);
502
503         *ndev_flags = ndev->flags;
504         /* A physical device must be the RDMA device to use */
505         if (ndev->flags & IFF_LOOPBACK) {
506                 /*
507                  * RDMA (IB/RoCE, iWarp) doesn't run on lo interface or
508                  * loopback IP address. So if route is resolved to 
loopback
509                  * interface, translate that to a real ndev based on non
510                  * loopback IP address.
511                  */
512                 ndev = rdma_find_ndev_for_src_ip_rcu(dev_net(ndev), 
dst_in);
513                 if (IS_ERR(ndev))
514                         return -ENODEV;
515         }
516
517         return copy_src_l2_addr(dev_addr, dst_in, dst, ndev);
518 }

I am not sure whether the above comments are correct or not because you 
are creating a siw device on lo netdev.

Yanjun.Zhu

> 
> Cc: Bernard Metzler <bmt@zurich.ibm.com>
> Cc: linux-rdma@vger.kernel.org
> Signed-off-by: Stefan Metzmacher <metze@samba.org>
> ---
>   drivers/infiniband/sw/siw/siw.h      | 1 -
>   drivers/infiniband/sw/siw/siw_main.c | 5 +----
>   2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
> index 3e04357ab197..3bdc17eedbe7 100644
> --- a/drivers/infiniband/sw/siw/siw.h
> +++ b/drivers/infiniband/sw/siw/siw.h
> @@ -490,7 +490,6 @@ struct siw_user_mmap_entry {
>   /* Global siw parameters. Currently set in siw_main.c */
>   extern const bool zcopy_tx;
>   extern const bool try_gso;
> -extern const bool loopback_enabled;
>   extern const bool mpa_crc_required;
>   extern const bool mpa_crc_strict;
>   extern const bool siw_tcp_nagle;
> diff --git a/drivers/infiniband/sw/siw/siw_main.c b/drivers/infiniband/sw/siw/siw_main.c
> index 4e1d29832ac8..ba238b0b43a3 100644
> --- a/drivers/infiniband/sw/siw/siw_main.c
> +++ b/drivers/infiniband/sw/siw/siw_main.c
> @@ -38,8 +38,6 @@ const bool zcopy_tx = true;
>    */
>   const bool try_gso;
>   
> -/* Attach siw also with loopback devices */
> -const bool loopback_enabled = true;
>   
>   /* We try to negotiate CRC on, if true */
>   const bool mpa_crc_required;
> @@ -94,8 +92,7 @@ static int siw_dev_qualified(struct net_device *netdev)
>   	 * <linux/if_arp.h> for type identifiers.
>   	 */
>   	if (netdev->type == ARPHRD_ETHER || netdev->type == ARPHRD_IEEE802 ||
> -	    netdev->type == ARPHRD_NONE ||
> -	    (netdev->type == ARPHRD_LOOPBACK && loopback_enabled))
> +	    netdev->type == ARPHRD_NONE || netdev->type == ARPHRD_LOOPBACK)
>   		return 1;
>   
>   	return 0;


