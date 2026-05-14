Return-Path: <linux-rdma+bounces-20628-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO+IN1IzBWonTQIAu9opvQ
	(envelope-from <linux-rdma+bounces-20628-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 04:28:34 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A723553D07E
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 04:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 03873301B369
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 02:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADCF3321D4;
	Thu, 14 May 2026 02:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjnl5cjV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAF030DD00
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 02:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778725712; cv=none; b=iQ0N/pPxCQjlVga8j4n3IZnaCTvgnuEpTW+1W5kN8/2g4ZBIAo531AjTU1JL4QKxIhODFzPozd1Ebxll1GQVEri8E5qbZFAcFKvMEg6+FJtWQOGiuJO3lrOzqtOFCqwqreFoCvdyewiL685cny3KRpdlJ929d5GXMPDsliG8s98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778725712; c=relaxed/simple;
	bh=oaxgpoSbY65896j0Ju4jgMezNeznny82DVYv/Yi/2Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLtIEtnRbhCPanWydkrMxsPWOdx0BHA3DZEf9F/ffDfuWnVzt6piZl+96E+E/HGiug6/57au9pRD8hrLpUOneuKkHV2iKZdRedcDpjaQy34JdE4IoxRzAmOWek3vv9N8hjaJgZeZ6mCAVJ372Fk6u4joj9AAH7CLJUDUBZVX2Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjnl5cjV; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-65c0bda7f15so8556516d50.0
        for <linux-rdma@vger.kernel.org>; Wed, 13 May 2026 19:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778725710; x=1779330510; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mxfGgciuIl8ecIFy9+5zcD49dfpTzAB0PVcZJYXaajU=;
        b=fjnl5cjVVcoKnjVGGfmK/DNONvc0XgYuYhmB5ci7Ettt/CfRsbuO5BHrq6DMSp2Nsr
         DoLzh1Y4AmVVFPN2/r/nvLFmeRPbCGbUht6a/fRJLcZBVwrUdui9qrHQSK25QcrFlyzO
         qmFRzSKIf5H2QR2rW1he8KumP475SN3HL4ajJOmlivup1N4u4+RbQe30QQvgAz5Vfnod
         d+1SDq7ueGLmSkAwjHZGgEwk4ENZ5r0Sl4kp9HCh7MnmuOFilHnrUml+lsA6IE9bhJl0
         EhMxcJ3i9nCiDKnOTPNHqVIojk3we7X++fousEat7rt+2FaL9sPL5TRRMzM+y4IPcNe6
         aFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778725710; x=1779330510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxfGgciuIl8ecIFy9+5zcD49dfpTzAB0PVcZJYXaajU=;
        b=IeWPlWvV6rTIR/qw1A9QD1LkToia1qurEpnVtuBBAlO/vAREg3tOv9efTNgVRlfFws
         YemwpyTZr004pltkmuBAJ7k4nlzhojXUsGTa7bTAI2vWaG7Bj1KV8baCcJgKS+eeE6Kb
         Fy8MbFc6Os7mo3dvni4XkSILvxyNfLkBIR5cuIKNkAOvYmUtwwqHsiS11nF1vT7+3jWZ
         aBULMuM49l4sTAjdJEJywsbcG46F4n6W1OGpkPZXTN44BDniW9jEDbwI6a1ZkbO8b8fS
         h/Ihpt1/m70ll2VjZRzBtD4ttaykOmjgRklO6+JVfAaXLg920TIa8W+CLhDpJL7Hvqx0
         1KbA==
X-Forwarded-Encrypted: i=1; AFNElJ9REvwWX+tciHAJjnKApOwYsoB3YBB6difwJoevvu5Bjv3T2YIGxxKfBbdMAX5XwiEGGtjm5cPVRI35@vger.kernel.org
X-Gm-Message-State: AOJu0YzqlwUEfvYrcSL511yiskBIRXAa3ngXK+ORze99bnQ9oeyzKhwQ
	0j46ZN7hVZXD9Z6WmbmT94K4aY2nrRIJ3cDNu66fxp5J1md+UDqgEQHM
X-Gm-Gg: Acq92OHsoylwwM+yA+F8bG3NjcNjG6+01k0BEuO1j5i/DAg7/4xfVfLEgZqcuSydFPx
	LDHKO7P3ozjM0TMy33n+UXuPtGSYLz6cvSU/ANAZPbKBBMe7lPh8libWeWfP36kIDTzjxXW1CRW
	5AvdUoYVtAu/wGhaMgXb02+9IpCIXrVhTmeN3LrasW5fC+GMYln6qzdzVptaeTaGilgFQ2gInG2
	63ueNqw37nabehOPTCp46DUPKsvbWS1FB9gbhkXkrWRoEFeZOtIyyTygZC/A/8ns8hVdN65LSDV
	LTDqCMznUff9UvWaZLo2Xf4RmBufMRLtcx0TpozQPNrGRC2F4v5s2k/Gu/83p289kR331LMwszZ
	N0ni1NbHMqT0ZaZpDl918hT6wS4UM1PRV4dL0Ol+PlBGTBGI6l8kjVfQoDw18TBq/ko1wysyRJa
	4w6Y6NJL926sbPioTRK8pJqRf0KtISO9uGKs1Yh7cSPKfjS7w=
X-Received: by 2002:a05:690e:118a:b0:658:a18:cdf0 with SMTP id 956f58d0204a3-65df625951amr6137491d50.29.1778725709828;
        Wed, 13 May 2026 19:28:29 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f806:29::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0db0aa51sm438759d50.12.2026.05.13.19.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 19:28:29 -0700 (PDT)
Date: Wed, 13 May 2026 19:28:23 -0700
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
Subject: Re: [PATCH net-next v4 6/8] selftests: drv-net: refactor devmem
 command builders into lib module
Message-ID: <agUzR3O35Rx4RHnu@devvm29614.prn0.facebook.com>
References: <20260511-tcp-dm-netkit-v4-0-841b78b99d74@meta.com>
 <20260511-tcp-dm-netkit-v4-6-841b78b99d74@meta.com>
 <20260513192133.60a82598@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513192133.60a82598@kernel.org>
X-Rspamd-Queue-Id: A723553D07E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20628-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm29614.prn0.facebook.com:mid]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 07:21:33PM -0700, Jakub Kicinski wrote:
> On Mon, 11 May 2026 18:18:00 -0700 Bobby Eshleman wrote:
> >  tools/testing/selftests/drivers/net/hw/devmem.py   |  77 ++------
> >  .../selftests/drivers/net/hw/lib/py/devmem.py      | 218 +++++++++++++++++++++
> 
> If the reuse is in the same dir I think you can create
> 
> tools/testing/selftests/drivers/net/hw/devmem_lib.py
> 
> and import:
> 
> from devmem_lib import bla
> 
> I _think_ that should "just work" ?
> 
> The lib/ is meant for things shared between targets.

I will give that a try.

> 
> Also I think you missed adding the new file to Makefiles ?
> It needs to be under TEST_FILES for building tarballs

Ah okay, I wasn't sure if the already existing `TEST_INCLUDES :=
$(wildcard lib/py/*.py ../lib/py/*.py)` was sufficient or not. Will use
TEST_FILES with the devmem_lib approach above next rev.

Thanks,
Bobby

