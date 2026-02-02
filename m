Return-Path: <linux-rdma+bounces-16378-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKTyK4w4gWmUEwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16378-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 00:51:40 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 103D4D2C1D
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 00:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66C033015C8B
	for <lists+linux-rdma@lfdr.de>; Mon,  2 Feb 2026 23:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E561A3612C2;
	Mon,  2 Feb 2026 23:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bCoS1jhy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7F435EDA4
	for <linux-rdma@vger.kernel.org>; Mon,  2 Feb 2026 23:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770076296; cv=none; b=UUNPV0/C1VII6sBMYuAVbB+faQU0BmvJv2WslhVdXTjZYL+moJqhdywH2p9fCP6y5yuOWBYaKaClkkZ5/QSvNP4etUI8yThcpXaLXQIk2dge/WnimJe/P2MOD6Jn8kmy3WQWUy/Ab6R9Hola3fNXU7JWLCgcsDWvhtD+BI8ashw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770076296; c=relaxed/simple;
	bh=0JwNUHhT79XTW9Eu71kBuS3JJfhlBckQdcf16mD5HqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IB/L7X3SfJBTcCmKMdU0BH3H5UR6mxGslrlUXu3cY2gYplHI8kShLonjVrcNhQM4+hLiiLKpmAwutIaiTbU9QRmaQsc1MrmH2tTUi3K5TmnM0AU8poASaUxR+XbCwPMu3cAZ9hGeC8M1udKGtNOaus1OD9af9OydCsTmshkScIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bCoS1jhy; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8c52c67f64cso468776685a.0
        for <linux-rdma@vger.kernel.org>; Mon, 02 Feb 2026 15:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770076294; x=1770681094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vzkPI8XiUWLlwCkLQgheyCicjNQiQAeick/95kRmWS4=;
        b=bCoS1jhyCldUgJB0u8X98Xglr8uUqYS8cM6W/U9ebx7shxKiWX0RiIj7NdHX44PsPj
         G+2zTYCTXLjgqU4yf7mu4bP2ry4VYHc5OWuEmbyD+CDP43hqmxbH3lyPlR24Do5J/xRP
         xhq9MsXvAJPd4GpdpaVtBzc90J0fLcVO1LkTS6HC0HkgcfNIuaXB/7ExEMIoyrAUGaIb
         /jsCjlhacqsOW+z+9xjCtxz4Rzx0zwwQUTTEIpNG7WRini8P8KpXTnPc/jRqtQW3a/HJ
         Ayna3InrBuSY2lyA6ZsEbWmOZloKfYtAzUIC9JurK+S1C4Iin06ancK218AiQ+OpERy6
         pAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770076294; x=1770681094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vzkPI8XiUWLlwCkLQgheyCicjNQiQAeick/95kRmWS4=;
        b=f/OFWK8d0eEew9jNgUnj6AC40JJyiWzr34OwU5A15a1tBAnzgWRjWSSGruQt6tUYcB
         cKxumncaoZkdO8nWs8umqHDhivsd7rhZE1p24qNXGLT5XpdMQwmawtO7kCvrMgzIhhjM
         FDCtjl8igYne4J54DpzGfnY8USLR8TGFmqs/kxYTtwcNTqRrKmwALFeanQeDTyzslwYw
         K+4dXknDzoEIrVLQcFZS+bcTzYoqjdpHlGKeKCfFZ0a7s2Lv548mvbKtleX49uJ353OQ
         gLy+YTTDPXVxeVpwnmIJxRKzYcYcU+kxtXoMOH2r+Ec6ZqFooQodYi5Pk+syQ6n9OMVd
         v7xw==
X-Forwarded-Encrypted: i=1; AJvYcCW+sHwv/cKZ87EgIw8Sz/2nJjSsM/Ixgn1oqYGzuXuRXYPu5ha8bL8A94q/1FQayj3EGEe1+MN1G/tI@vger.kernel.org
X-Gm-Message-State: AOJu0YwUQPaYI7nkHeiNWzHUZpC2V+ecYZ5T3LrZLCDVLYBfFV3YT9xd
	L1TUNUCCqbiqtzQwQFPLNZ9h6uv2fjg7CEqZTonMNssyJK/yJWFO+DPjkvOWlYaH+7Q=
X-Gm-Gg: AZuq6aLC3g7LxHPHQjxN4ITvj9LFvyvlo0wQh3CE0vkml/lbR/PN5kBcQcsfyFPrFrk
	fqUg+uQmOyNl4O+qnnui53zjKaDIssNzMxe8WQSQ0GuPMRsHsuH0OPN12VVX3GR0VgwY6hWvFbr
	UbW1GoT5Y17iitVX5qkbyFJjUFxxKPdPvu2cOT8hFzgtXeRmjNbyYFp0mu6mwarvwV7Vx6rn0A4
	/PqOLhXL6ipRXnlJH8GqdbdXzvMDlvnApWFPqcUYVrwS3jWuHelpuDTBdeGCSMmOAYXLAWdc/gu
	rWRT0NwiuzLwnzkLdtFQGdxxBiODa2MvRHynlWV7gK0ep3NLkTZOUUlLKIB9BaY/S+YIwlGz3sV
	61OQ1NmMPxYEXncUE9PkKZQXOKmb/Xf7TnCLAavJXxY6LShsOeBRWCa2icxuFZ7umLy+RdnIE58
	CH/d5SAW0Qsu/J0CdsIy9+LKRVMaON2zmuvGbCfu2M9TNqNSNywvTh4zqB0Jn2Hbi/1Is=
X-Received: by 2002:a05:620a:8506:b0:8c9:f9fa:de21 with SMTP id af79cd13be357-8c9f9fae06dmr1161918385a.63.1770076294171;
        Mon, 02 Feb 2026 15:51:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d375f3casm124417886d6.47.2026.02.02.15.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 15:51:33 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vn3hd-0000000GO4s-0bZj;
	Mon, 02 Feb 2026 19:51:33 -0400
Date: Mon, 2 Feb 2026 19:51:33 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Jiri Pirko <jiri@resnulli.us>, linux-rdma@vger.kernel.org,
	leon@kernel.org, msanalla@nvidia.com, maorg@nvidia.com,
	parav@nvidia.com, mbloch@nvidia.com, markzhang@nvidia.com,
	marco.crivellari@suse.com, roman.gushchin@linux.dev,
	"Yanjun.Zhu" <yanjun.zhu@linux.dev>
Subject: Re: [PATCH] RDMA/core: Fix stale RoCE GIDs during netdev events at
 registration
Message-ID: <20260202235133.GP2328995@ziepe.ca>
References: <9975b59a-58e2-4766-9e4e-c927a1d7a3d0@I-love.SAKURA.ne.jp>
 <f3402d0f-40a1-4792-a8e2-be65c71a176b@linux.dev>
 <af4866d0-2e50-477c-b823-1c4a8a86f7e5@I-love.SAKURA.ne.jp>
 <0952d053-0de4-469c-88b4-509e6d29296c@I-love.SAKURA.ne.jp>
 <u7t7kha66tqngzyoryly6pltiur4wtz6gm3nui3zeb32dmtctp@54rr6gcsqtap>
 <1dc21045-4030-4d37-9ae6-3dd2c42b8e88@I-love.SAKURA.ne.jp>
 <inp2nyil62tkkvahvjvwvgp63ld5cffgowqhwlbssabhd2gaka@52lfxbmxvbzi>
 <8bdfe8a3-1cdb-43e3-b68e-428f6c5133d5@I-love.SAKURA.ne.jp>
 <j5tnfwmkfqtmmtpkbcdxriu7wlgxydazuvkk4nkfv27nddlq4r@xx4amuxv6y7y>
 <d6aee73d-91cb-4eb3-ad11-6244e973932b@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6aee73d-91cb-4eb3-ad11-6244e973932b@I-love.SAKURA.ne.jp>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16378-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 103D4D2C1D
X-Rspamd-Action: no action

On Mon, Feb 02, 2026 at 11:20:22PM +0900, Tetsuo Handa wrote:

> > - Event handlers correctly update stale GIDs even when racing with rescan
> 
> I couldn't confirm that this is always true. What happens if rdma_roce_rescan_device()
> is preempted between make_default_gid() and __ib_cache_gid_add(), and NETDEV_CHANGEADDR
> event runs meanwhile? It sounds to me that stale gid is possible because gid value is
> calculated before holding the GID table mutex...
> 
> rdma_roce_rescan_device() {
>   ib_enum_roce_netdev() {
>     enum_all_gids_of_dev_cb() {
>       add_default_gids() {
>         ib_cache_gid_set_default_gid() {
>           make_default_gid(ndev, &gid); // GIDs populated with OLD MAC
>                                                                 ip link set eth4 addr NEW_MAC
>                                                                 NETDEV_CHANGEADDR queued

I thought this was impossible because enum_all_gids_of_dev_cb() holds
the rtnl_lock()?

Jason

