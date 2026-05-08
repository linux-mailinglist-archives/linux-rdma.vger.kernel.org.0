Return-Path: <linux-rdma+bounces-20277-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8qJOAOxr/mlTqgAAu9opvQ
	(envelope-from <linux-rdma+bounces-20277-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 09 May 2026 01:04:12 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DEA4FC924
	for <lists+linux-rdma@lfdr.de>; Sat, 09 May 2026 01:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C12A301C937
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 23:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC7C3AC0E9;
	Fri,  8 May 2026 23:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfY2uaG0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D5A3AA19B
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 23:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778281449; cv=none; b=fuV/JqoFaScYHJWezSyFKD+ei32dC3i5dXGUN1CMqi3F9N0mWsaOQdxs+em7s9Vh0wQos+5d0sRZmkF4NMzb4INJB2+aHTvTFQtE3+0XkqA3Uo+JLXaO+my/BzkT7REzbgTeWs4eu1MFKh+dNwWF2brCiKbIjJVJ9mIR+EteBvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778281449; c=relaxed/simple;
	bh=q61aqXrgAcupB+Zifhih+seu6DMFA/Fw8pWwohOp1Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NIthGVXckvmgHnLN7+ykuO/LgZCXCIp4fUvX+tMf+6cmNJ9wKMa+rnoOgqDXQRO87J8xBhv3JKJn/U8BWaIhDSHJYAOVhw30RJd/jVZaUGLTiBYxaWV5iYZ6llsPgwdFUFmRRi9gyBzY8ua49JR0nNOKJdUjjF2ulM7tBgmePZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfY2uaG0; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8b7105dfb35so24208116d6.3
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 16:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778281447; x=1778886247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ak6woxAtttxf/K0Pu5NsuJRxK4tCh/8r19p69HTWvdM=;
        b=RfY2uaG0gQyw4iSckGI91hCQl9X0yEcfj9yWuSka/KOOudIM/2dB88FfMvNd3uLoTD
         wajPs9uycinmW/jWBX0uq1nnetqD3/xU3SiZstjUHeLlLHsZGlWB+TbxAtGNhow2HUlx
         qlNCI7yx9ExUPXoXmnw7h3F8xjzx0gcLusJBzpvPtxgqNvdEGSG4T6Illa2m7XoBDFzb
         UvyYUu2vSRVeqglPGZJvQIVtlEgar66UkmVOVz0PiAbmHGDk7tJJ1I+9RQxEUVMOjrkN
         Rmg1CZhOKS+wm99c/qqi4pIvqF3cWQwVenA9kFab2ldKCSDcRrC53V/WJxsqWgUIvwzA
         2eTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778281447; x=1778886247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ak6woxAtttxf/K0Pu5NsuJRxK4tCh/8r19p69HTWvdM=;
        b=IuqeNAFLSE5O7Vl6S14cMaW60/lCnFBcnnFqvpQBXUEQT86pH36G5eJtTk3hti5QXw
         MkQ+tlnlZewK6FwUKeBqRgRARRVsr2sIRklVPM7LL+BxGAlHTjTYOoPVq78NH2+DU1fG
         /TAMXH0sH5A0OIl32TkxBE/IcxOxAQylDcugj8hp4z6PYHHoaXbewmBrA8aM3SadynPZ
         nXA/79M57NHqrn1B6L5N3TXcXxcx/d/iM/AeAxuVThPMgfePqqVpHN1LidpIZtBn9a1s
         7rTl0dIrvP83liNzgCWKi3uJNmD9knDjc4OA/oH35GN7nJBPWFrgOAwobt5ynenZcuc5
         kDjQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ysP/51+ROaPhinClwg4ESkWQyCw9BRGlh6V0OfqqCfkXatowOmJA4tGKPt9xheHYMkAts837L69V1@vger.kernel.org
X-Gm-Message-State: AOJu0YxIi8pXZl0gyuIfdSAPWyxvvHnMjyF8GZuQLn11ix2SuFcactxA
	EouH+xPfbpZg+DgkF//o3G5XMIpfApIrMGI/LXHLH93dJIfXoUYLlzy1
X-Gm-Gg: Acq92OGN3LULc6wcxCjxlwrb3DXbFJlpJAFZ0QslU814lPuNi0XnhngSb/n7jsODCpP
	ACc8WwV8tFe3rZkZhmSdZnXykRAow26xkUo1ocPiYIV2O2cXTTZBiks2yKH8lfoKtFbh30zBJ+P
	a6fYlCN0tSTknFknWs3QF7voGGT8YjApJSBIrhkPB2TWXqiSGhVsTvvjBVRoa/p3/w30Dgxjtkq
	wl1O+FacPDSv+ABkG2vsS91ZWVOO7IXVxrU+YJmbfkfBzY4vfYKB2qP03RRNlqA491zwYAP+36I
	CRt+aIJ0ZiZL05V+bDjG0yNnaZYq+eMG6Yp21x1DkadlochO84cAwqsZZz10fZmKpdFyFbXX43T
	h6n/xn87HMjHBqAmDGEoMKnsVmDJFqT4un/5kPbHXSBIAhMB1Eylft7qgBc/OWQL2TkFv7limwh
	tP0iKLWvK6z7VqipJK0hieT4KnSB0FU/Ikws42eTeLcVvBng==
X-Received: by 2002:a05:6214:3d0f:b0:8a4:8b2c:428f with SMTP id 6a1803df08f44-8bc41cc2d2dmr219254366d6.2.1778281446534;
        Fri, 08 May 2026 16:04:06 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f800:2::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d35787esm247534496d6.44.2026.05.08.16.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 16:04:06 -0700 (PDT)
Date: Fri, 8 May 2026 16:03:59 -0700
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
Message-ID: <af5r393EdNgGNh4o@devvm29614.prn0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
 <20260507-tcp-dm-netkit-v3-3-52821445867c@meta.com>
 <20260508134717.4ef87ab6@kernel.org>
 <af5Vlwb5RctHym8D@devvm29614.prn0.facebook.com>
 <20260508152708.011a9687@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508152708.011a9687@kernel.org>
X-Rspamd-Queue-Id: 61DEA4FC924
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20277-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,devvm29614.prn0.facebook.com:mid]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 03:27:08PM -0700, Jakub Kicinski wrote:
> On Fri, 8 May 2026 14:28:55 -0700 Bobby Eshleman wrote:
> > My guess is this would probably be the simplest way?
> 
> IDK. Notifiers are so inelegant. Don't we have the same problem with
> the main ->dev on Tx binding?

Yes, true. For some reason, I thought I recalled the dma buf attachment
causing some chain of reference holding that kept the device alive, but
that is actually not true...

