Return-Path: <linux-rdma+bounces-20256-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBllIpsN/mk0mgAAu9opvQ
	(envelope-from <linux-rdma+bounces-20256-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 18:21:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 226744F95E8
	for <lists+linux-rdma@lfdr.de>; Fri, 08 May 2026 18:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C4C2303714F
	for <lists+linux-rdma@lfdr.de>; Fri,  8 May 2026 16:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ECB3ED12A;
	Fri,  8 May 2026 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPcdaAur"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B629F3CFF51
	for <linux-rdma@vger.kernel.org>; Fri,  8 May 2026 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778257207; cv=none; b=UzraDOT0LhlYVJ8xPzgbWbGMlNNlGKWr9FnyHGrZPo8AtGPRbrstVYFgGXJnLa+yQwEksCUMFVH8B5nQA87L6QQd2ij7tLtaqyxAxoT0wJq7dXA3Gfc4yuM6mWBucUXCEjUcW3T5Zara99/hq2KGXYtWCxCRZwO4ULt3Q2CDSZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778257207; c=relaxed/simple;
	bh=v647WHHmXcdLQIFhGfoT7NEbJ1k0sAZWFnTY5EXnBc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kg6QYG0Yxq0sMm9TSusnmICW5JAtU0ZIXYyNnbh2UO6KfTWCcwaHuuuXkU7zza7EMgz+Fe9zvakOvSYLID0nUXpFt4siirXL+hvusm0OoEfO9K6fEBV8Zn0RaEhoClLydOlOyA2CWu5mFDFhROpwZvzGPDfl/5nGoOH+EvuVH80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sPcdaAur; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50d880e6fbbso29166831cf.0
        for <linux-rdma@vger.kernel.org>; Fri, 08 May 2026 09:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778257205; x=1778862005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VVIaSjloZ3+LpxQTNssmJQh6h7Rks2diPWr6o44EUDI=;
        b=sPcdaAurUpMDi10Sft6uGMJ2a/3e3HI1R+WovtJHcva09XXrP9E3WDtnvB/z/oOHmb
         JZSTVv5xHeIplTuYpGYcaB3CcmK8Qfep7o5JhM0Mw2FecYi+Z/q9Zj/1BQB85HZg1bfb
         pQcDeHRLUpHK5PIaeWLaA/WQaXfBunzXYk7nUXVtF/bPFy6o6Suz9ZM1SxO6tAiYtNmp
         VKUjjzZWuvwyc+2htS0wdWQTjHDGHxEsHylrMQNZ0TV3utkRg0vFVp3nOfKelE5L67XF
         StDhjMlr1oYCKZ7QttpiNCGrMptZMWMInB0T+Az6ELSTpP+QY6/IxarVExCL7vHhJLlT
         ir6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778257205; x=1778862005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VVIaSjloZ3+LpxQTNssmJQh6h7Rks2diPWr6o44EUDI=;
        b=PpSkhUd6wOC2ww5pLbC/nPm+jFA8RJzDI/6IzfWpTmQWyyC731zX1nJ8PwI+jEOrvV
         b+44IXiyj/zn3tgFXQQb2Uuc/ZiSWxqZ77T/QaSb1l9L3qVolPhts44Sldxt71T6uO4X
         brkILHhuqVWMNEQFZX8gEX1qZB741FyyVVZ1GZfVE4d5hCtcRKPdK/EpaNtjjE7ePpYW
         KdSfFaZQHuu66kqSpPU7ZYeDWEcKR/5pwjBXn8jVSekpEDNugYa/0ORfAovP97u/kesn
         w44QphkjHdYKnA0XuAr8Em6cBihhXxafsVQEQgj4URCQbPTnvI0yxtkGpLSHpbaDPLgI
         D5cg==
X-Forwarded-Encrypted: i=1; AFNElJ8WmiBiDlcrK6RuYQ0YvHb2ZTR5kRjQv+qJFPaDeEyqccS8vyB+CHJKIr1knDt2lMczNqKe0U0NlV80@vger.kernel.org
X-Gm-Message-State: AOJu0YwFM82Yojiq7LCamVV8L8AuxyXE7lxwLZXY9BRKzxyA2poRSiMu
	JY85jBchHF/bzAjUuDL5kbDTqzRQ6rj0PgzPuzHaSx+wOHF9380UziHq
X-Gm-Gg: AeBDieupm83x+MTZfHXbqKaS0c40vJcYz3Jx6aCGiKFhhJAg6OEQucBTEHw7xIKZdcg
	zlP9TJsgKKQPbFT3kkZMd4Vwfrtr6ty/4wUutm/64zmp3DKtcE/z8m28PVnLdsuJTg+sdhC2Wp0
	ceYUX0g60ob1d0yO8U5K6Jd2o9ajc3fbyOsAUjJm7L9DAqI0ifwucYAohLIWivHA+hLM6I1uu0X
	N2aKE8SzA+cZ+8wDAZ+35mMqjP97T0yCt7YFUQYFFMiTbDMTEA/kaW+6JmCSL4409GQfaGscD2O
	esSxuqdG8CGqQvZW8kRCplv/Ea8KGxQSWy5CZU6Lg5Jnc9rraxwRrvSdQPcpCcNwkR6i6MeEwor
	qj6YEd09cTOG+j/WbjF2DfcamhQVyENTb/2pg/PNmg6CvmhJEzvWYe5Rf9zb36SCQd5ug8Bfr6Z
	EbdJKO1k43MosBuKNPHxNJ2W/1XK6EMJxI84DwgFApkqqwUg==
X-Received: by 2002:ac8:584d:0:b0:50f:ad91:8906 with SMTP id d75a77b69052e-51475c100cdmr95757961cf.20.1778257204178;
        Fri, 08 May 2026 09:20:04 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:f800:d::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d35787esm238874416d6.44.2026.05.08.09.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:20:03 -0700 (PDT)
Date: Fri, 8 May 2026 09:19:57 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
	Shuah Khan <shuah@kernel.org>, dw@davidwei.uk,
	mohsin.bashr@gmail.com, willemb@google.com, jiang.kun2@zte.com.cn,
	xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Mina Almasry <almasrymina@google.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v3 6/8] selftests: drv-net: refactor devmem
 command builders into lib module
Message-ID: <af4NLRXDN3nzEDce@devvm29614.prn0.facebook.com>
References: <20260507-tcp-dm-netkit-v3-0-52821445867c@meta.com>
 <20260507-tcp-dm-netkit-v3-6-52821445867c@meta.com>
 <af37Eoq2TLjhI7kx@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af37Eoq2TLjhI7kx@devvm7509.cco0.facebook.com>
X-Rspamd-Queue-Id: 226744F95E8
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20256-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,broadcom.com,nvidia.com,fb.com,meta.com,iogearbox.net,blackwall.org,davidwei.uk,gmail.com,zte.com.cn,vger.kernel.org,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm29614.prn0.facebook.com:mid,meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 08:03:11AM -0700, Stanislav Fomichev wrote:
> On 05/07, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Adding netkit-based devmem tests is a straight-forward copy of devmem
> > test commands plus some args for the nk cases, so this patch breaks out
> > these command builders into helpers used by both.
> > 
> > Though we tried to avoid libraries to avoid increasing the barrier of
> > entry/complexity (see selftests/drivers/net/README.md, section "Avoid
> > libraries and frameworks"), factoring out these functions seemed like
> > the lesser of two evils in this case of using the same commands, just
> > with slightly different args per environment.
> > 
> > I experimented with just having all of the tests in the same file to
> > avoid having helpers in a library file, but because ksft_run() is
> > limited to a single call per file, and the new tests will require
> > different environments (NetDrvContEnv/NetDrvEpEnv), it would have been
> > necessary to have each test set up its own environment instead of
> > sharing one for the entire ksft_run() run. This came at the cost of
> > ballooning the test time (from under 5s to 30s on my test system), so to
> > strike a balance these tests were placed in separate files so they could
> > keep a shared environment across a single ksft_run() run shared across
> > all tests using the same env type (introduced in subsequent patches).
> > 
> > The helpers work transparently with both plain and netkit environments
> > by inspecting cfg for netkit-specific attributes (netns, nk_queue,
> > etc...).
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> 
> [..]
> 
> > Changes in v4:
> 
> This is a v3, but you already have changes for v4 :-p

oops, will change on respin.

Thanks,
Bobby

