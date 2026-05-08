Return-Path: <linux-rdma+bounces-20266-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNs0N6hV/mlTpQAAu9opvQ
	(envelope-from <linux-rdma+bounces-20266-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 23:29:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4C34FBE84
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 23:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A722630166FF
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 21:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB4B423A83;
	Fri,  8 May 2026 21:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dB1NAApR"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2BE376464
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778275744; cv=none; b=Hz6xmQb4tz5aGk7wk1W+iXJ03KU3mDzlKyW2JLcvRsjt9ZpAQS+Tw2RwgY/CwPj2YmwmLOCfWl8E0UQJ5nXmKR/9QPaqlrUinr9OYM9GKtrLI48kJ82IvojbfmtlTanADrnNmKgiwJf5q1VTz0nKrh3FAHTwSlQ4VTy72iTm85s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778275744; c=relaxed/simple;
	bh=lm4ZsFpNUgwpK3YnX3D6FcdAELUM2A+q69wdbtD9hng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnoz7nn0qb8CVU+1uygdchmYls0p2BRa3Z0HQy9aYNNQAquTAU5sGFhV+0PAMyfFzF+1oP7vO24DriO3vuFbA0p+3+8kKd5C10PVsS1YSn0g6KHW7m97JqPh598Bswc7729yS2kv7kDsrnEp3H0oIAlLSqHwW7eXhFknNvgFPnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dB1NAApR; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8ee9ec26edaso272841385a.2
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 14:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778275742; x=1778880542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/LAF18jiWTLJl8Jwx6HS2JQdllgi/a4OQyHfJwaQg84=;
        b=dB1NAApRVCzA/GJ3Zsj63KroNB3QF16jAEzm+2Y5Z4Jd6dJRojdXOImqLa5jsJ03kR
         oM/vSwYadVwGRFXbPLOt3JG+qV+ygFOV00YT6B5e4Fu20iTuJdcv+qvm9D7yn4TZQDzo
         3lsUguU7SvDpNkkDK6cKzT4c2pYtv9rVlqvRF6OZqJP7pbuNfdoMwpAq4czB6xxAHT8H
         917O/5/cvnid69CWTYlJ3+TNduUJxqIpCx1HHiigYYR7S3fEbAcwboEx8qCQ6cT0KwYY
         6k8wF0lJVBkEO+2gBk7UV/0ivXlmvaqhu3wlQhVuzHjXvPqeqhbkQN89BOg7fu3pW1kN
         bUhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778275742; x=1778880542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LAF18jiWTLJl8Jwx6HS2JQdllgi/a4OQyHfJwaQg84=;
        b=C0FVpA3Gq/IqwJYgpprvzdL04Kr6tDhwCT/+fsd1giycFxa9s2ZE7agRx4TdkkL54/
         s+O84WoYk/JxkKQrw6mEr2iNE7BJysuuSi/m729F3USbtuveyvwLZ2Vod60a3iYtE4D0
         8KG03oAVegnXEJ69QrIVaC1skzcn2C/+sWxNTUTZw/MDN4xPq+0PfYilFwre58f7WRqa
         SM1PCtgcqjAYFV2fuodjgdjSehMc6QDkQIdinPuKqOEtKx1MqRjiUrToWbboB6tBZGZv
         79QvW57gFdt6J0+dXRXy24/Hd6FhaE23hFTzTHxZjQLeQ4UhEaATZWXLxDQmvaZUv7Cs
         zkoA==
X-Forwarded-Encrypted: i=1; AFNElJ9+cNSPALzeoEYUBG4KwcG2T/FEceps+lBZRRnfs6g+yxjckXMn2aNBK4yRchmiMRdEMTZKeQa1rRlx@vger.kernel.org
X-Gm-Message-State: AOJu0YwndxUaOiWuTWjLq5jBwTZP5BhLJEB1Z5OLD0OfGW69agiCxWoo
	yJgxh7vUapzGUoToV9Ew0oriVIleSpag6hpgZO18Qpq899PhzoiLLx5k
X-Gm-Gg: AeBDietUG6y/sU3mcye2guMiIia7gGq3qvwAZQQbhkopKP/tplYWLKglXMHELxLr0R0
	bO+5Yu4qodAxGRlk1B9SZMoogP7QkMhU/78MDo2DGkBe2JTOVmaXKZnteM6d7UWXAtdO135OmR0
	hBAlqrpym7ilhbbwZw9i2IaUp66RPk7LpRuxVtVm0N6PK0u/SJv6NDFgYAzMiPCwUSkwwkvPTDS
	zhUwfEcIyBDk6EIUtPcl2g2hK+urON8vpV8dHwOHW/T+Ifn52eXjOsz86k8dvwMgcUapx69ogK0
	yPZxbGFFMu65+EsghMwhoz0p3VlfLlRZXvbfAXYinZTLpkP8X3JCW9UvZ2JzZ0km6/QajuCg5i+
	dIh2MacAn7DuBQdWquWSoweC9BL+umo7SDFC+zZ8geklkALE3Py9PwQCV+SOUTjQaKKL0lzF5sp
	x3JObUkd5MjvUz8JFgxRug6BHaFw0OOD3xg5a4Yuk+8Vna3VU1E9bwzTwmfPSmjyCuJHA=
X-Received: by 2002:a05:620a:40d0:b0:8dd:b4fc:d561 with SMTP id af79cd13be357-904d438db5dmr2198955585a.10.1778275741832;
        Fri, 08 May 2026 14:29:01 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f800:1::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2cd057acsm2596938185a.47.2026.05.08.14.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 14:29:01 -0700 (PDT)
Date: Fri, 8 May 2026 14:28:55 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Joshua Washington <joshwash@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com,
	Daniel Borkmann <daniel@iogearbox.net>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, dw@davidwei.uk, sdf.kernel@gmail.com,
	mohsin.bashr@gmail.com, willemb@google.com, jiang.kun2@zte.com.cn,
	xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 3/8] net: devmem: support TX over
 NETMEM_TX_NO_DMA devices
Message-ID: <af5Vlwb5RctHym8D@devvm29614.prn0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
 <20260507-tcp-dm-netkit-v3-3-52821445867c@meta.com>
 <20260508134717.4ef87ab6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508134717.4ef87ab6@kernel.org>
X-Rspamd-Queue-Id: 8A4C34FBE84
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20266-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,broadcom.com,nvidia.com,fb.com,meta.com,iogearbox.net,blackwall.org,davidwei.uk,gmail.com,zte.com.cn,vger.kernel.org,fomichev.me];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[40];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm29614.prn0.facebook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 01:47:17PM -0700, Jakub Kicinski wrote:
> On Thu, 07 May 2026 19:27:48 -0700 Bobby Eshleman wrote:
> > +	/* Virtual device (e.g. netkit) the user called bind-tx on. Must be
> > +	 * NETMEM_TX_NO_DMA.
> > +	 */
> > +	struct net_device *vdev;
> 
> AI keeps complaining that we don't hold a reference to this dev which 
> I think is fine, we're just comparing pointers. Could we maybe make this
> a void pointer and mention in the comment that we treat it as "best
> effort cookie" (better phrasing welcome).
> 
> Or we should wipe these vdev pointers when vdevs disappear, not sure
> how hard that'd be (or whether it's worth the extra state).

My guess is this would probably be the simplest way?

diff --git a/net/core/devmem.c b/net/core/devmem.c
index 644c286b778f..e28fae14c687 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -533,3 +533,38 @@ static const struct memory_provider_ops dmabuf_devmem_ops = {
 	.nl_fill		= mp_dmabuf_devmem_nl_fill,
 	.uninstall		= mp_dmabuf_devmem_uninstall,
 };
+
+static int net_devmem_netdev_event(struct notifier_block *nb,
+				   unsigned long event, void *ptr)
+{
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct net_devmem_dmabuf_binding *binding;
+	unsigned long id;
+
+	if (event != NETDEV_UNREGISTER)
+		return NOTIFY_DONE;
+
+	xa_for_each(&net_devmem_dmabuf_bindings, id, binding) {
+		if (!net_devmem_dmabuf_binding_get(binding))
+			continue;
+		mutex_lock(&binding->lock);
+		if (READ_ONCE(binding->vdev) == dev) {
+			ASSERT_EXCLUSIVE_WRITER(binding->vdev);
+			WRITE_ONCE(binding->vdev, NULL);
+		}
+		mutex_unlock(&binding->lock);
+		net_devmem_dmabuf_binding_put(binding);
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block net_devmem_netdev_nb = {
+	.notifier_call = net_devmem_netdev_event,
+};
+
+static int __init net_devmem_init(void)
+{
+	return register_netdevice_notifier(&net_devmem_netdev_nb);
+}
+subsys_initcall(net_devmem_init);


I'm open to either approach. The void* + comment is good too, IMHO.  For
the notifier, I'd probably want to add a test too ensure sendmsg() kicks
back after the device is removed.

Best,
Bobby

