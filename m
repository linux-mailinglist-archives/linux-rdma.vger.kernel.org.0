Return-Path: <linux-rdma+bounces-20252-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIY9MqH8/WkdlgAAu9opvQ
	(envelope-from <linux-rdma+bounces-20252-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 17:09:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E7C4F8592
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 17:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BAC9F30ABB1F
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 15:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEB8C33F58C;
	Fri,  8 May 2026 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M1DV9bSP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0D93FE368
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 15:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252616; cv=none; b=BSv9Yqaznf3v9ehNzMg7QV3zyJnRsw4luVoRdnZQAlhTsPUSo0V7FmPyxwr5NEc+oZhA4HEcb8zptbrkSqYk6EkZR5fp7DLi1B92UrwUtDD69OEnECYvBZwy9hCyJtKJNbweZI9K1lgMI67B5DZZ2M7OLLXEV7tlXvJc+nVFUyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252616; c=relaxed/simple;
	bh=t0Nlu+VexUsTkUu/gem9W65q4/pks24oKx+COgMx/io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osnsF8qO/BvJeM/fND7FPGb2jbOFImZ28Gd59VQ38uFs/R46lJDZtQWd2eOc3+dORodX/Ha8AoS2uZheAnk8ty3KXdoFID8KC2IFLGDc7S3MWY94LotWMbcb+wuUr0/KDeI9YZ/sZKODGZ9s1RyM21rgkUTKlySnJOQHmQTrkHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M1DV9bSP; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2bab82d75fdso12159635ad.2
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778252613; x=1778857413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v4XSckC+6HeNNAT2ObXLyFDVqOgPjF3vQM49fr0+IcA=;
        b=M1DV9bSPdIpo1HCzS+chpKLRw9yZEaLHH4hWt/8vF7kwxIMdWiQ56TFDetp2fD3dHK
         R0u+n+5f4iBWZtmqUudWXsg0H8PaVHkUHak4NyF4Yl/tD9W5Q83ulCRhidXVrpgwF1zy
         OxnEv1kIXlzfCWOaLDPy/oadOs/Vnb/U/6AFDW6eOaaZEx/e9U2TiiVYVT0MOCDY7TlL
         C5LkiulOrgIE+dbWiLgv+jXSyxNRbrdi7pje/7CMtnoub8nb+Fa/L6vaaBQZ9ozgoVvQ
         9Ia6bUMPwXknOYTSdI9JX8ETBTps+Uue9bS/EYFde3ymahVl65AjQ81p4ufqD8Cn23Aq
         FXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778252613; x=1778857413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v4XSckC+6HeNNAT2ObXLyFDVqOgPjF3vQM49fr0+IcA=;
        b=HAus+i6cnBx8kvO2QQjGhEmBRsJV/XpUNUEdb6u4QB0Db9+xTQyogXTj5essNeGUBT
         vxE5z3AS8QbkClAd0zwLlA5qs18RgkZZKwyV881ZXNtjMRNIUSfwvEu+HpEdBQ4mH/w6
         NEWByKnMR7XZ6TyEYwv+wYJ5STVopa7TG3ZI/jvjRpDbISGssmxCw63wwKv8jgvpYiGc
         LsCSM6y+PZooVaE5UN15hFrCndr4bC2OmuRt4SDjKzJOt4hncAJqmpe5pqQ+ZxZtdhCe
         hbaDDQICGlFrYilPnx99yZEjviIt3YCxlYrOHO0Iw4xiZ/ayWHRsLqOKHdYg+vCv2vPk
         HVQw==
X-Forwarded-Encrypted: i=1; AFNElJ9njTNtJI8XY7lSKnlM1j0a/7Do3U15rArgEEAow8JdRoNBOX2iqy82BioYZkOp9nC0A9n73LzZWCic@vger.kernel.org
X-Gm-Message-State: AOJu0YwpZtwb6K/hAAHXZCRMb7orMWo71dqYJiEAgJcRaKNhaaTbSsFN
	gkRarLDFzQGsd5SiAe5y6GktEJFPBhACdJWz9ZGS6My73/k1ZdXPMxLV
X-Gm-Gg: Acq92OFopW+JxNvQaVTWxjH4Bc5NJ0hciapJDQ3FGHv3kjCS/ApDLo53UPkXOCXvPQX
	IvrTTM0JxmYo8GYbtJdOJA8Zck8+jwavuXyXfoTcPHZ70lcgYJUz4Q83RSR4ckukPLUWG25Nor4
	VuCk7A5CLxdPIKhYGWUcONwofVj8FpKrIWXmTVEhEc8ez0zfGNDZ6umlN02G4UL1wBvKkTAQrMs
	wb9CmVLLrogr9SWatbdUYJHmIMJZyqqPgjHmjEP68Iw31hQd6aK6u7CqMSiTbp5U+wHxKNvB8hl
	H0EANLRvM8/bqha5on1EjvuPZpWfpJ9Zbqm32XJB0O3jyC4ySfEQzEzm6/Jeo07gHPGPLap2B5f
	wNi1nUEXqIm5pR0c/Bggt2e3MidnYgF8Q9IOWDBq9LiUMP+niI+v/hvZb56m5I3s0ElVDH8Iojq
	vT
X-Received: by 2002:a17:903:4b0d:b0:2b0:bed1:46f7 with SMTP id d9443c01a7336-2ba799d5f4dmr143685845ad.37.1778252613411;
        Fri, 08 May 2026 08:03:33 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1ecc4bbsm24477685ad.84.2026.05.08.08.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 08:03:32 -0700 (PDT)
Date: Fri, 8 May 2026 08:03:32 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Joshua Washington <joshwash@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com, 
	Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Shuah Khan <shuah@kernel.org>, dw@davidwei.uk, mohsin.bashr@gmail.com, willemb@google.com, 
	jiang.kun2@zte.com.cn, xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, 
	netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Stanislav Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 7/8] selftests: drv-net: add
 primary_rx_redirect support to NetDrvContEnv
Message-ID: <af37O7TXJm9wPl1h@devvm7509.cco0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
 <20260507-tcp-dm-netkit-v3-7-52821445867c@meta.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260507-tcp-dm-netkit-v3-7-52821445867c@meta.com>
X-Rspamd-Queue-Id: 69E7C4F8592
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20252-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,broadcom.com,nvidia.com,fb.com,meta.com,iogearbox.net,blackwall.org,davidwei.uk,gmail.com,zte.com.cn,vger.kernel.org,fomichev.me];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm7509.cco0.facebook.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fomichev.me:email,meta.com:email]
X-Rspamd-Action: no action

On 05/07, Bobby Eshleman wrote:
> From: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> When sending from a namespace that has access to a netkit device with a
> leased queue, the nk primary in the host namespace needs to redirect its
> RX to the physical device. This patch adds that redirection bpf program
> and teaches the harness to install it.
> 
> Add primary_rx_redirect=False parameter to NetDrvContEnv.__init__().
> When enabled, _attach_primary_rx_redirect_bpf() attaches a new BPF TC
> program (nk_primary_rx_redirect.bpf.c) to the primary (host-side) netkit
> interface. The program redirects non-ICMPv6 IPv6 packets to the physical
> NIC via bpf_redirect_neigh(), with the physical ifindex configured via
> the .bss map. ICMPv6 is left on the host's netkit primary so IPv6
> neighbor discovery still work locally.
> 
> Extract _find_bss_map_id() from _attach_bpf() into a reusable helper so
> other BPF attachment methods can use it.
> 
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

