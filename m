Return-Path: <linux-rdma+bounces-20372-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIbSOH2OAWrCeAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20372-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 10:08:29 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC00509D3D
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 10:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AEC723008D2B
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 08:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F553B7771;
	Mon, 11 May 2026 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="a++eeVQU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083643B3886
	for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 08:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486893; cv=none; b=mOs7ulBshYocjSLpNoWnB8Iqz5A+aT1hF8/0Vbkj9QPlW872FiLn4CJLGgE/OiKFb3jK8k9RUhQ6IRiwRMKM+M7osyn7+ufdGwiYApGdQ0e+V4whWyNbdiIGCkjdCuhhOgMH9sI4E5aesbCnKf76jM4zuiUSGCbA8qrFMsi1WPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486893; c=relaxed/simple;
	bh=NcjgQHe/X9C+SBudTsEkTDVrZL8ey9FSJwoVi7+nhtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=buNkg4EQh85zR0R6kx83UUqDFjFp4wQKxWr7oifrJu4K90ZysyXfwQW3erlUJaMgNpYzq72cHPHlkBtKf10fidK4BKEGCQKGcvm3LDjHAYij55wyLnEEHfTmIazrtmOtZPwKsuHD90EHh7zCfXH7MuG9j9hFoD9Kk+w+PetJBV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=a++eeVQU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48d102471a4so38943275e9.2
        for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 01:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1778486881; x=1779091681; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MdfA7aGOGSRQ1CILOc6Le7Ks8CyAnmg3KhzdGxgc+LI=;
        b=a++eeVQUmQC2uhkhik86EDQ3+IQGTEIrbONafIIO/TsC1d+8CACT4Ow2ImXauiXmEy
         iT6Z8dRk9jsko6OyvcVs3AllFEIzibqBGSrW5sVE77Zg9/XUA7JixvH6XspnXGO2NHRe
         ChywALP9BUOB9fXsyBydSIkyJRq8oQMIngY4APhu48oxHhRoVawmNP2MvTrGPiCRpFXz
         jXjRTp1B+d1MXBK2E1OHZCcB+hfX65rXRrJVbnNf4YZj1enyge5AbNrgFWRSrnlyCaQR
         CkSAZQvG1cWTQI2PMsKjfAvC0axtBsDdSjjANZjjRY7JsCfdZ+2TKsPOkjZIBzDus2sS
         PEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778486881; x=1779091681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdfA7aGOGSRQ1CILOc6Le7Ks8CyAnmg3KhzdGxgc+LI=;
        b=gEAeJUbUIw16PR84Go9i7Tb6ppk5WOrBPcdTcLoHFPjecFdjlHqJrwTjyVpdKRKirq
         x3tv9cH/SFVxI8z7M5+CCqs9GoypaqUy9FLuzdEAX/KBXgaL84inLqQESRiSZx05vlN3
         FDOJE6gfuyqyJ4r/6eCr6AM9cY/LhbR8ibEplFSlx/4BiyvUlH+uPDihjhAyBDZ0yQgS
         nH/NXjICZSJgkmDXdXvoqYa4TJspBINt7+6oxZik0v2vnnU3iJ9QFw1C/dldI6auitLT
         Z2cFmmLd34y9vO/J68SIgvVNLG7dLBiqh6xRHDnkMPJrE86TDDWCvBZ3N1r1lEr6PC/K
         iW7g==
X-Forwarded-Encrypted: i=1; AFNElJ/bEgqxI87yM39SMPJDjFyYH164DVgcZcbrGoj8n+LWmSvgr1g9ygFD71C0nPh/5LXtkUyKECf5hS61@vger.kernel.org
X-Gm-Message-State: AOJu0YxsrlqnTY9488hqDQsoSDYVswLgPCGi13dfNd3ZApI9F/dlH+Y5
	eWra47DUj13rKT4ZPRIuU9aIgnzIJFZywRncy6Swp8g4GAfKXNGNeUvAUzwTMnoeons=
X-Gm-Gg: Acq92OEmt1HwX+3tqZtSOSq4WOhOy6NDdpCtslU3jVhauQmcNkS88GNd860dITqhMVl
	XmZHdz8uyu0Gd1739Mv7iO4EPe5t4ZyX3nRxkOCeCjRCksiKfBf8Kacn+XnWGPtnO/ttvSs6vaF
	OXQfz4oos1J0997Kz2y89t2mp+7HUYI/W7CwQjg3NbdFOGRrdPcRGSzuRGR3x/X7dOjxwMyVEao
	1N3UEuk1fSS9qEdOm0N11vd85m0MiUrV/sYfGQ1m0S1hm7CjPIOlndUH+/4XaFHhJEJE3vSspnI
	H0/KZDyztEVo5T5lhprMlBRZaEoHbGeXT2lRROLT54XFEypVdILKCPzKCHLWhL+9XztkwXYm++o
	e72R2zNofOm6Nh7lBvOb5YkJJxyWkv+BPlpcKK/4jWSHQBYi8s/v/RLmhL9K3e0wot74Oyopwt1
	RZiytjb55MwWW2MY8AE52S5jjSSHh7hjEt/cQ=
X-Received: by 2002:a05:600d:8496:20b0:48e:86e6:c2f1 with SMTP id 5b1f17b1804b1-48e86e6c38fmr7387965e9.2.1778486881151;
        Mon, 11 May 2026 01:08:01 -0700 (PDT)
Received: from FV6GYCPJ69 ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-454917d57aesm24147511f8f.26.2026.05.11.01.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:08:00 -0700 (PDT)
Date: Mon, 11 May 2026 10:07:57 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Mark Bloch <mbloch@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Borislav Petkov (AMD)" <bp@alien8.de>, Randy Dunlap <rdunlap@infradead.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Christian Brauner <brauner@kernel.org>, 
	Petr Mladek <pmladek@suse.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>, 
	Eric Biggers <ebiggers@kernel.org>, Li RongQing <lirongqing@baidu.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC net-next 0/4] devlink: Add boot-time defaults
Message-ID: <agGNVmN9tpHh0K1P@FV6GYCPJ69>
References: <20260506123739.1959770-1-mbloch@nvidia.com>
 <aftaW-irGmkfA7FS@FV6GYCPJ69>
 <3f9215c4-7c84-46d9-ba74-30dabe24db09@nvidia.com>
 <afxvzOjqw-vxUAED@FV6GYCPJ69>
 <b6a9b568-dd09-4414-be57-6b9cd282a43c@nvidia.com>
 <af4lBIJdCuN5VKq_@FV6GYCPJ69>
 <20260508175213.1952097f@kernel.org>
 <af7Y4AYv-XDCbK_8@FV6GYCPJ69>
 <580a774b-ba9e-4523-b43a-476f75dd5b12@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <580a774b-ba9e-4523-b43a-476f75dd5b12@nvidia.com>
X-Rspamd-Queue-Id: 2AC00509D3D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20372-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[resnulli-us.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Sun, May 10, 2026 at 02:31:35PM +0200, mbloch@nvidia.com wrote:
>
>
>On 09/05/2026 10:01, Jiri Pirko wrote:
>> Sat, May 09, 2026 at 02:52:13AM +0200, kuba@kernel.org wrote:
>>> On Fri, 8 May 2026 20:07:44 +0200 Jiri Pirko wrote:
>>>>> I don't think switchdev by default should mean CX4+ in general. If we get
>>>>> there, I would expect it to be limited to the DPU/BlueField/ECPF case, where
>>>>> the host PF probe path can depend on the ECPF reaching switchdev. Changing the
>>>>> default for regular host NIC deployments feels like a much larger compatibility
>>>>> change.  
>>>>
>>>> We can't travel throught time, but if from CX5 onwards the default would
>>>> be switchdev, nobody would feel broken in terms of compatibility. That
>>>> is my point. Having "legacy" as default is simply wrong for never NIC
>>>> generations. That is why it is called "legacy" and it should have been
>>>> rotten through and out since CX4 times.
>>>
>>> legacy vs switchdev only describes the eswitch configuration.
>>> As a non-SR-IOV user I really don't want to see the extra representors
>>> hanging around my systems, confusing all daemons. IIRC mlx5 had some
>>> limitations around the uplink representor. Maybe that's the disconnect.
>>> But for a real, fully featured switchdev eswitches having the
>>> PHY and PF representors on boot, always, will not make sense.
>> 
>> As "a non-SR-IOV user", what extra representors you talk about? When you
>> have pfs only, you don't have anything extra. Just 1 netdev per-pf, one
>> devlink port per-pf. What's extra about it? When you don't have VFs/SFs.
>> Everyhing is the same:
>
>The netdev list looking similar is a bit misleading. What matters here is
>not only how many netdevs show up, but what that netdev actually is.
>
>In legacy mode, a PF only user can just use the PF netdev as a regular NIC
>and use ROCE on it directly.

I don't see why we have this limitation. Sounds more like a bug to me.
The netdev is still the same, capable of the same things no matter in
which mode you have it. RoCE should work on it in both modes.


>
>In switchdev mode, even if there are no VFs or SFs yet, the PF is moved into
>the switchdev model and the visible netdev is the uplink representor. That is
>not the same thing from a user point of view. The uplink representor is not a
>ROCE capable endpoint. So a user who used to boot the machine and use ROCE on
>the PF now has to create a VF or SF, use that as the roce endpoint, and also
>set up the switchdev forwarding path with tc, bridge or OVS so traffic from
>that function actually reaches the wire.
>
>That is why I don't think this is only a card generation question. It changes
>the deployment model. It may be the right default for BlueField/ECPF style
>systems, where the host is expected to sit behind a switchdev control plane,
>but it is not a safe default for every regular host NIC setup.

Yeah, the point is, not to change deployment model. The legacy/switchdev
should only change behaviour for sriov/eswitch usecase. The rest
(PF/uplink netdev and related objects) should stay the same.


>
>> 
>> c-220-136-220-218:~$ sudo devlink dev eswitch show pci/0000:08:00.0
>> pci/0000:08:00.0: mode switchdev inline-mode none encap-mode basic
>> c-220-136-220-218:~$ sudo devlink dev eswitch show pci/0000:08:00.1
>> pci/0000:08:00.1: mode legacy inline-mode none encap-mode basic
>> c-220-136-220-218:~$ devlink dev
>> pci/0000:08:00.0: index 0
>>   nested_devlink:
>>     auxiliary/mlx5_core.eth.0
>> devlink_index/1: index 1
>>   nested_devlink:
>>     pci/0000:08:00.0
>>     pci/0000:08:00.1
>> auxiliary/mlx5_core.eth.0: index 2
>> pci/0000:08:00.1: index 3
>>   nested_devlink:
>>     auxiliary/mlx5_core.eth.1
>> auxiliary/mlx5_core.eth.1: index 4
>> c-220-136-220-218:~$ devlink port
>> auxiliary/mlx5_core.eth.0/65535: type eth netdev eth2 flavour physical port 0 splittable false
>> auxiliary/mlx5_core.eth.1/131071: type eth netdev eth3 flavour physical port 1 splittable false
>> c-220-136-220-218:~$ ip link
>> ...
>> 4: eth2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>>     link/ether b8:e9:24:f2:b7:6c brd ff:ff:ff:ff:ff:ff
>>     altname enp8s0f0np0
>> 5: eth3: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
>>     link/ether b8:e9:24:f2:b7:6d brd ff:ff:ff:ff:ff:ff
>>     altname enp8s0f1np1
>> 
>> 
>>>
>>> IOW it's not a question of the generation of the card but of
>>> the deployment type / use case.
>> 
>> I don't think so, not in the case of mlx5. The difference is only when
>> you work with sr-iov, you either use legacy way (ip vf) or the new one.
>> Same usecase.
>> 
>> 
>>>
>>>>> For the ASIC/NV bit: maybe technically possible, but it feels like the wrong
>>>>> layer. This is boot/deployment policy, not a persistent hardware property, and
>>>>> storing it in NV memory would make the state persist across kernels/hosts in a
>>>>> surprising way.  
>>>>
>>>> Well, as any other nv config, it persists across kernels/hosts. Think
>>>> about it as "unbreak-my-not-legacy-device" bit.
>>>
>>> For most devices the switchdev mode does not change anything
>>> substantial about the device. It's purely a kernel / driver config. 
>>> It changes what objects and default rules kernel / driver installs. 
>>> So I don't get why it would make sense to flash into the device
>>> nvmem a Linux SW stack specific config.
>> 
>> I look at it from the perspective that from some CX generation,
>> switchdev mode should be default. So that is a device-based decision.
>> I believe as such it can optionally be permanenty configured (nv config)
>> on older device. Why not?
>
>This is a deployment policy decision, not a permanent property of the card.
>The same adapter can be used in a regular host/RDMA setup or in a
>switchdev/offload setup. If we store this in NVM, that Linux switchdev policy
>follows the device across hosts, kernels and use cases, and can surprise the
>next deployment that just expects a normal NIC.

Yeah, from my perspective, there should be not surprise/behaviour_change
for non-sriov/eswitch user. Then switchdev can be default and everyone
is happy. Why to complicate things?


>
>I'll send another RFC v2 with support limited to:
>devlink=[...]:esw:mode:{ switchdev | switchdev_inactive | legacy }
>and let's see where we land with that.
>
>I still think a small kernel command line knob is the cleanest way to get to
>"switchdev by default" without making the interface too broad. For more
>complex boot-time configuration, I agree that a devlinkd or similar userspace
>path is probably the better direction.
>
>The "pause probing until userspace configures devlink" idea feels less clear
>to me. It is not quite the simple boot policy knob, and not quite the full
>userspace policy manager either. It would add a new probe state and require
>early userspace orchestration before the device is fully materialized. At
>least for now, I would prefer either the small cmdline option for the simple
>global/default case, or a proper devlinkd-like solution for more complex
>policy. Between those, I still prefer the cmdline option for this specific
>early eswitch mode default.
>
>Mark
>
>> 
>> [...]
>

