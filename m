Return-Path: <linux-rdma+bounces-6687-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 587109F98F2
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 19:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9EB91960934
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Dec 2024 17:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DFE6230D32;
	Fri, 20 Dec 2024 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="CL/UXxT3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AE12206B9
	for <linux-rdma@vger.kernel.org>; Fri, 20 Dec 2024 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734716461; cv=none; b=X2OjLhpe3mMEJe2RGuNfcydDDVidYsWXesvSoGApnRWa9SdF3AFvAxsyouBqJ6weY6ZHlJmWsNIVx/xs4QCKPa2e5IVxCxfGF0KUzkon0iOB7BIODOLfMi4vEA2ZGz84NUCSc2WosNW0vmeVUChuhfFH16ySO4D1uw5BKxINLOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734716461; c=relaxed/simple;
	bh=iEUGCjBbtkH37HKrbX0b7LpJEVvYl2PEK1v4afLn508=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFqaDBwO+JwHggHj7QW+s1kwRZojbP+ymsmAw+jYlGi4sJIdru87mRHEd4zoNnKE+NvqS7prOlyyAS6k2aZBZEnAoOZ7bdV+3olvqOrrU72KT9/Co1r3krbuctXXTeYVuLsQebf/8LJ5HX+wHZAfbq0cpJ2rHK3mM7cqxHECvxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=CL/UXxT3; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-728e1799d95so2603893b3a.2
        for <linux-rdma@vger.kernel.org>; Fri, 20 Dec 2024 09:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1734716459; x=1735321259; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b1Eta0nuAwctETcvrKKs7bPK/JbTvDxM/GusCkZRXTw=;
        b=CL/UXxT391YuHNhsbJeDiwUmfxapg48NrG6xOIroaHtRVQM13lFoCWGDFCSihmLc+l
         pTi+YsAJo90/aFadfGgpvsMg3i3tUCZNuakpGtPRYCxn8FokvSXS8TlCynLQkC2dlyqd
         QRTvcka28iACY4YKVaTlf9NCuQR0KTZg1pGbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734716459; x=1735321259;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b1Eta0nuAwctETcvrKKs7bPK/JbTvDxM/GusCkZRXTw=;
        b=hvalAg1H/466Iq++TID0ZBhq64+ryg/eYtWf6kIswyot5b1aXBGYIiHtPphGKh2ypU
         Et2FG9StrguWiEcUh0eW451JFyUuyF1xYkVavK32FHNeDOUM4KKGvZET/795g5JogrIO
         7RFl2UgHbKmPR6VseT2gLNhqKnNbeXnmsmkylSMwXFBveVwH4b9bIVMPlb/Y5pujsib8
         6YcVQHD8CSxN+2ntwTnw/diWyyn6QD2fZ/N/C/AK20Jeq+iDItx2KCpExomZt/3hrMqd
         f01No5lAxMMAsIHg7+OomxYxReuYqOtEo822yDbrA3ZYnoNYG2DU2j1qGaaklrURDA4S
         m9ew==
X-Forwarded-Encrypted: i=1; AJvYcCXmJxRGJQYCXL4c5Cv0C2yDKCavYVuK0LRRrbOVQboWAPGOWfAYVB0tV04CuHL3CgfW1k8QDFBKrflP@vger.kernel.org
X-Gm-Message-State: AOJu0YwCgwK8Vr/sKOdpJw8RbBbeNN8FJy2uPTng+5mAGqjsCZGkzxvV
	DwmSlnr+GEQoD8CFnN7ibfse8JsQkzgE+d/Q2ye1nIEVkXB2CD8T5Acd1UXjjAU=
X-Gm-Gg: ASbGncvfQdaq4Tm9A4ykXTRbfaH7aEHJ0suCpeRjRG+V7bnVTTOLD/JnhT8MM16Svxj
	YNI4vARhCc2p/HGZXCvjUzb5redTgQX2QfLTqjbUJOYf44klbQJpmSe83ND9q7jXX5wXhhqvYVq
	NKycIBx5kedlIF2clgMtydljU/dGaTel6KMgaViGju3OpHKYM6HDzijlfJAPThyZzN001vyribH
	62fXpLiNIkHu7jBgxC/Z8woC8XoetzwUXgMzzC6frFYEK/ktsPUgYYXoK3euBAxHbO7WYpaLbi/
	6YiQBpECaOZd6jsJtpAM1kA=
X-Google-Smtp-Source: AGHT+IGxh4PZgIriyltpnSerdK3R+0CRnHeegY0SDIcMBfpAi2CSUjzEyXE/AdwCDJ2cN8IKdMCFLQ==
X-Received: by 2002:a05:6a20:d81b:b0:1e0:c30a:6f22 with SMTP id adf61e73a8af0-1e5e080cba4mr7002714637.40.1734716458826;
        Fri, 20 Dec 2024 09:40:58 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b31ef0c0sm2696655a12.28.2024.12.20.09.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 09:40:58 -0800 (PST)
Date: Fri, 20 Dec 2024 09:40:54 -0800
From: Joe Damato <jdamato@fastly.com>
To: Alex Lazar <alazar@nvidia.com>,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>,
	"almasrymina@google.com" <almasrymina@google.com>,
	"amritha.nambiar@intel.com" <amritha.nambiar@intel.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>,
	"bjorn@rivosinc.com" <bjorn@rivosinc.com>,
	"corbet@lwn.net" <corbet@lwn.net>, Dan Jurgens <danielj@nvidia.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"hawk@kernel.org" <hawk@kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"johannes.berg@intel.com" <johannes.berg@intel.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"leitao@debian.org" <leitao@debian.org>,
	"leon@kernel.org" <leon@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>,
	"michael.chan@broadcom.com" <michael.chan@broadcom.com>,
	"mkarsten@uwaterloo.ca" <mkarsten@uwaterloo.ca>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"skhawaja@google.com" <skhawaja@google.com>,
	"sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	Gal Pressman <gal@nvidia.com>, Nimrod Oren <noren@nvidia.com>,
	Dror Tennenbaum <drort@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [net-next v6 0/9] Add support for per-NAPI config via netlink
Message-ID: <Z2WsJtaBpBqJFXeO@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Alex Lazar <alazar@nvidia.com>,
	"aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>,
	"almasrymina@google.com" <almasrymina@google.com>,
	"amritha.nambiar@intel.com" <amritha.nambiar@intel.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>,
	"bjorn@rivosinc.com" <bjorn@rivosinc.com>,
	"corbet@lwn.net" <corbet@lwn.net>, Dan Jurgens <danielj@nvidia.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"hawk@kernel.org" <hawk@kernel.org>,
	"jiri@resnulli.us" <jiri@resnulli.us>,
	"johannes.berg@intel.com" <johannes.berg@intel.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"leitao@debian.org" <leitao@debian.org>,
	"leon@kernel.org" <leon@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"lorenzo@kernel.org" <lorenzo@kernel.org>,
	"michael.chan@broadcom.com" <michael.chan@broadcom.com>,
	"mkarsten@uwaterloo.ca" <mkarsten@uwaterloo.ca>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"sdf@fomichev.me" <sdf@fomichev.me>,
	"skhawaja@google.com" <skhawaja@google.com>,
	"sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	"willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	Gal Pressman <gal@nvidia.com>, Nimrod Oren <noren@nvidia.com>,
	Dror Tennenbaum <drort@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>
References: <DM8PR12MB5447837576EA58F490D6D4BFAD052@DM8PR12MB5447.namprd12.prod.outlook.com>
 <Z2MBqrc2FM2rizqP@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z2MBqrc2FM2rizqP@LQ3V64L9R2>

On Wed, Dec 18, 2024 at 09:08:58AM -0800, Joe Damato wrote:
> On Wed, Dec 18, 2024 at 11:22:33AM +0000, Alex Lazar wrote:
> > Hi Joe and all,
> > 
> > I am part of the NVIDIA Eth drivers team, and we are experiencing a problem,
> > sibesced to this change: commit 86e25f40aa1e ("net: napi: Add napi_config")
> > 
> > The issue occurs when sending packets from one machine to another.
> > On the receiver side, we have XSK (XDPsock) that receives the packet and sends it
> > back to the sender.
> > At some point, one packet (packet A) gets "stuck," and if we send a new packet
> > (packet B), it "pushes" the previous one. Packet A is then processed by the NAPI
> > poll, and packet B gets stuck, and so on.
> > 
> > Your change involves moving napi_hash_del() and napi_hash_add() from
> > netif_napi_del() and netif_napi_add_weight() to napi_enable() and napi_disable().
> > If I move them back to netif_napi_del() and netif_napi_add_weight(),
> > the issue is resolved (I moved the entire if/else block, not just the napi_hash_del/add).
> > 
> > This issue occurs with both the new and old APIs (netif_napi_add/_config).
> > Moving the napi_hash_add() and napi_hash_del() functions resolves it for both.
> > I am debugging this, no breakthrough so far.
> > 
> > I would appreciate if you could look into this.
> > We can provide more details per request.
> 
> I appreciate your report, but there is not a lot in your message to
> help debug the issue.
> 
> Can you please:
> 
> 1.) Verify that the kernel tree you are testing on has commit
> cecc1555a8c2 ("net: Make napi_hash_lock irq safe") included ? If it
> does not, can you pull in that commit and re-run your test and
> report back if that fixes your problem?
> 
> 2.) If (1) does not fix your problem, can you please reply with at
> least the following information:
>   - Specify what device this is happening on (in case I have access
>     to one)
>   - Which driver is affected
>   - Which upstream kernel SHA you are building your test kernel from
>   - The reproducer program(s) with clear instructions on how exactly
>     to run it/them in order to reproduce the issue

I didn't hear back on the above, but wanted to let you know that
I'll be out of the office soon, so my responses/bandwidth for
helping to debug this will be limited over the next week or two.

