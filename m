Return-Path: <linux-rdma+bounces-6765-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776099FE723
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2024 15:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20467160AF3
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Dec 2024 14:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953C41AA1E0;
	Mon, 30 Dec 2024 14:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="J/APm32F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1D11AA1D0
	for <linux-rdma@vger.kernel.org>; Mon, 30 Dec 2024 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735569089; cv=none; b=DNmbM2UAq+uRyoaFFUX2/vLxcmF4QAeMF8X3StORzWaly7HIwIBpMvog0ok/j94Wyo7+8Zi+FJRFOcUsDNwQ/5NlL5Jg+VHYo3nZeaVcc0j28o1z8crnE1b6qmxtgoHfF+Xr2mFelKBvBRzSEozNIsO4tKuevnjBCzL+KsXjs2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735569089; c=relaxed/simple;
	bh=DzcdSK4Fbjvsk9GyTH4M7MGUMxmfuEMWS7vM5YmOw7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrDfZflr9WkXx3eBUmyCqVSoh+y5RwAD3hnLJzWm9HOarg55IXwZHAZPtavGUgbaCLHpXUt9UKvudzgHOdDQv3nNRjr/lv7hxcza3XlBD7Ocw0+XZTF8CrCvAuuVBbO3YDC9OTMK7P0h4HnGeidSYnH3HW929ezXeh30ZKAUk+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=J/APm32F; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6d92cd1e811so87451046d6.1
        for <linux-rdma@vger.kernel.org>; Mon, 30 Dec 2024 06:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1735569086; x=1736173886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZ0qh5CvDNrWXK/tQQvVpQ5E5ArB37lBngu63gu7KW8=;
        b=J/APm32Fezcc/NBzQxat8iksR8O3TIZIrDs1LMImXd5pjWPjoaekUOaMTuNyR7gQ6H
         JgTpltfcsIq1MUf83RNw/TMSyFeUq6svdySnOaUjfJvMikClmoVtijDdxuAjmKD7SZjZ
         nQznCWfCYWsgrRoVjW/gAxAyDR9IXUBFm8cvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735569086; x=1736173886;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aZ0qh5CvDNrWXK/tQQvVpQ5E5ArB37lBngu63gu7KW8=;
        b=eDMf1NxyvguVgMDvyfFKhvUpc7UcC5+9qP6zye+CxDkrXbcV+1Kw0Y5x2iakD9DNc3
         HsLO32I815yPp5+6AzBLvFD9IawfrmI7jFyVKc0BPl7nbn+gMPwpKRziU/XIZYh7MXLB
         6yD2ypRoNUUcXMYJi4233SFq0YHF69GNO282Y8BEiYZDpdj0mp70GGbcr0wLUN8GEBAi
         HW/G4lRblZr9gpUC7O+vCBpQyhclSr3uL4mx1sgzxfsIvT91HXRsssrSqhCTRp9XhgNn
         3gUpBHewj18Lb3MY11BJBA+T/Q+VZJ46/BIX1CppSvEsyeOiBGc9JWYMEqhYTggXn834
         yvvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXDloRJF4TCkPpdSPwFaxTfgg+DiGe2W+NnUj5vhtbwkc6LUqxDrfQfmZ4kA/0TM/8LcGSBUvkWr2K@vger.kernel.org
X-Gm-Message-State: AOJu0Yz21Kp72cm8XqQWheo7ZcumPf2//RWuSazgl7QERUIxo5N6v75O
	ioZTKABKT4BpNzgA60Xfm/mU5vByw0BYYmhlG4G8l+PYJcxXquKx+awkjOp90HI=
X-Gm-Gg: ASbGncsMl0EPbucLKDpPA+J4EHA7p7GeTy6Q07c8oXnnZa6kMWQ4wv5jhDdGgKMxAyc
	AAd9fQioJZunL5XZLxONUQ7t7wuCiw3OjOaKCR49SFJFnowW9HFCByupHWD5dvEpxh0dWUHzdOs
	uvW8eEvyEAlfSWM86vm34A/D+NFA9emH+pw869c0+zM5+rBOrfHXYAcxLNamDGRYyl5AF7g2pEo
	L+M88IuL9lDM/dfHd7dXXjkQmPIB90BVLdRtKXft+XFLII6RN0WlOxh1nUjVI8k8ufbpMsA6Omi
	yYw5ow2d37qfWJHK2Rw=
X-Google-Smtp-Source: AGHT+IFhhaSR9avGcVQrR2u/7A1pOVupmdwRVmvYVv11neW65aqnZNqInNc4kMN4KbFRYCDE54xu3A==
X-Received: by 2002:a05:6214:29ef:b0:6d4:1c27:e9b1 with SMTP id 6a1803df08f44-6dd23631f97mr591874976d6.23.1735569086295;
        Mon, 30 Dec 2024 06:31:26 -0800 (PST)
Received: from LQ3V64L9R2 (ool-44c5a22e.dyn.optonline.net. [68.197.162.46])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6dd181d3169sm102799846d6.102.2024.12.30.06.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 06:31:25 -0800 (PST)
Date: Mon, 30 Dec 2024 09:31:23 -0500
From: Joe Damato <jdamato@fastly.com>
To: Alex Lazar <alazar@nvidia.com>
Cc: "aleksander.lobakin@intel.com" <aleksander.lobakin@intel.com>,
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
Message-ID: <Z3Kuu44L0ZcnavQF@LQ3V64L9R2>
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
 <Z2WsJtaBpBqJFXeO@LQ3V64L9R2>
 <550af81b-6d62-4fc3-9df3-2d74989f4ca0@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <550af81b-6d62-4fc3-9df3-2d74989f4ca0@nvidia.com>

On Mon, Dec 23, 2024 at 08:17:08AM +0000, Alex Lazar wrote:
> 
> 
> On 20/12/2024 19:40, Joe Damato wrote:
> > On Wed, Dec 18, 2024 at 09:08:58AM -0800, Joe Damato wrote:
> >> On Wed, Dec 18, 2024 at 11:22:33AM +0000, Alex Lazar wrote:
> >>> Hi Joe and all,
> >>>
> >>> I am part of the NVIDIA Eth drivers team, and we are experiencing a problem,
> >>> sibesced to this change: commit 86e25f40aa1e ("net: napi: Add napi_config")
> >>>
> >>> The issue occurs when sending packets from one machine to another.
> >>> On the receiver side, we have XSK (XDPsock) that receives the packet and sends it
> >>> back to the sender.
> >>> At some point, one packet (packet A) gets "stuck," and if we send a new packet
> >>> (packet B), it "pushes" the previous one. Packet A is then processed by the NAPI
> >>> poll, and packet B gets stuck, and so on.
> >>>
> >>> Your change involves moving napi_hash_del() and napi_hash_add() from
> >>> netif_napi_del() and netif_napi_add_weight() to napi_enable() and napi_disable().
> >>> If I move them back to netif_napi_del() and netif_napi_add_weight(),
> >>> the issue is resolved (I moved the entire if/else block, not just the napi_hash_del/add).
> >>>
> >>> This issue occurs with both the new and old APIs (netif_napi_add/_config).
> >>> Moving the napi_hash_add() and napi_hash_del() functions resolves it for both.
> >>> I am debugging this, no breakthrough so far.
> >>>
> >>> I would appreciate if you could look into this.
> >>> We can provide more details per request.
> >>
> >> I appreciate your report, but there is not a lot in your message to
> >> help debug the issue.
> >>
> >> Can you please:
> >>
> >> 1.) Verify that the kernel tree you are testing on has commit
> >> cecc1555a8c2 ("net: Make napi_hash_lock irq safe") included ? If it
> >> does not, can you pull in that commit and re-run your test and
> >> report back if that fixes your problem?
> 
> I verified that the kernel tree includes commit cecc1555a8c2 ("net: Make 
> napi_hash_lock irq safe"), but the issue still occurs.

OK, thanks for verifying that.
 
> >>
> >> 2.) If (1) does not fix your problem, can you please reply with at
> >> least the following information:
> >>    - Specify what device this is happening on (in case I have access
> >>      to one)
> 
> We are using two ConnectX-5 cards connected back-to-back.
> 
> >>    - Which driver is affected
> 
> The affected driver is the MLX5 driver.
> 
> >>    - Which upstream kernel SHA you are building your test kernel from
> 
> The upstream kernel SHA we are building is 9163b05eca1d ("Merge branch 
> 'add-support-for-so_priority-cmsg'").

I have access to ConnectX-5 Ex EN MCX516A-CDAT NICs and can build a
kernel based on the upstream SHA you mentioned.

> >>    - The reproducer program(s) with clear instructions on how exactly
> >>      to run it/them in order to reproduce the issue
> 
> Test setup/configuration:
> On one side, we use a Python script with the scapy.all library to create 
> UDP packets of size 1024, using port 19017 and the MAC/IP of the other side.
> On the other side, we define an n-tuple filter (ethtool --config-ntuple 
> eth2 flow-type udp4 dst-port 19017 action 4) and run xdpsock (xdpsock -i 
> eth2 -N -q 4 --l2fwd -z -B).
> In the test, we send a single packet each time, which is received and 
> sent back to the sender.
> As part of the validation, we check the statistics on the other side and 
> notice a discrepancy between what xdpsock shows and what we see in the 
> driver (ethtool -S eth2 | grep "tx_xsk_xmit").

1. Can you please be much more specific when you say "notice a
   discrepancy" and substitute that for specific data? What,
   exactly, is a single run of the experiment that results in a lost
   or delayed packet? Do you have tcpdump output? What is the
   expected output and what is the actual output?

2. Can you provide the full source code? Both the reproducer and the
   script to check the values?

   You can feel free to create a github gist and link to it, then I
   can git clone it and run it.

   In the gist you can create a README.md that shows exactly what
   commands I need to run to reproduce, the expected output from the
   script, and the actual output.

   Since I have access to this hardware, I should be able to
   reproduce.

   Ideally, I'll git clone your gist, run something like "make test"
   (or similar) and reproduce the issue and get either "Test
   succeeded" or Test failed; expected %d packets but received %d".

3. If this issue is with napi_disable/napi_enable, can you think of
   a simpler reproducer? For example, wouldn't changing the queue
   count cause the same issue without needing to involve xdp at all?

   What about a simpler experiment with UDPing [1] and an ntuple
   filter? Does it reproduce with plain old NAPI processing or is it
   XDP specific?

> > 
> > I didn't hear back on the above, but wanted to let you know that
> > I'll be out of the office soon, so my responses/bandwidth for
> > helping to debug this will be limited over the next week or two.
> 
> Hi Joe,
> 
> Thanks for the quick response.
> Comments inline, If you need more details or further clarification, 
> please let me know.

As mentioned above and in my previous emails: please provide lot
more detail and make it as easy as possible for me to reproduce this
issue with the simplest reproducer possible and a much more detailed
explanation.

Please note: I will be out of the office until Jan 9 so my responses
will be limited until then.

