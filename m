Return-Path: <linux-rdma+bounces-14985-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C2ECBBF93
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Dec 2025 20:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4A9C300F599
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Dec 2025 19:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBD33148D2;
	Sun, 14 Dec 2025 19:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNYfAZr6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Py7nhpZe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241143B8D68
	for <linux-rdma@vger.kernel.org>; Sun, 14 Dec 2025 19:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765740668; cv=none; b=fYOEE1XdMOcjbtCgg5+gVCqmlmWNOMeuJm/wQvDfE0sQ5FQ/OnGekk/HsYnkmcXUul8DjosjeTPWVw6WOXROsOyNKlisoHsL9MTTI7nwQyE+/Qw0U52iEsfr270g+pZh1+f7A4GUjY50uW0koIof/Mt3EUt4WJCs118RaYWFpC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765740668; c=relaxed/simple;
	bh=k8u03FjgqDJBg8ERVle+DHdeeA7ayrFPrNQbxMFc2sg=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=KwbejRavpeNmghogJsGAfftTplU9S/jN76hyqAvC50cgW3QxalmNNI4MZyZD/iXIngZ1fwfUf91MrNu+IcYkQXydBwbwa9n5amqbnL/rW7lcbIo1O/yl5jtRguuDA5gLKA0cDLbt3sykYG5Bbr9J1rZQoUNCInamIqzakuwLnng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KNYfAZr6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Py7nhpZe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765740662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AkDF/IHsQ0LQ2YPT4lm80CVidD6oYFhupeQzt7BNxAY=;
	b=KNYfAZr6MTby4Rk8uSConZyN24iYmVkv0qT+o3s5nCJ/x0Z6yp0t87C8gTqmtC8fh0W415
	j7fBD8wvxMiRkEbQ+XHLczUKD0onHs2nLH/H2ydQnzHYJ8Ol2dTm9q5LsiifvDf1hG+E1l
	GelNgI04H0Lr7dcW1FeiNoljRtiOE88=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-iQGwYHOBO2ilaGbXIHcohg-1; Sun, 14 Dec 2025 14:31:00 -0500
X-MC-Unique: iQGwYHOBO2ilaGbXIHcohg-1
X-Mimecast-MFC-AGG-ID: iQGwYHOBO2ilaGbXIHcohg_1765740660
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47a97b785bdso6448495e9.3
        for <linux-rdma@vger.kernel.org>; Sun, 14 Dec 2025 11:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1765740659; x=1766345459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AkDF/IHsQ0LQ2YPT4lm80CVidD6oYFhupeQzt7BNxAY=;
        b=Py7nhpZelDVGHp1EFLuG1ZaqlNunvXbbPfXUsxbc0TNYReHvcC3Dy/DGXw6NWRO254
         gJGyMVBbTVwlT1fuwAY6KuCSb9pFjzNwl0KsNRbk6lzbwm6cbDNg07CTK4FHMpU3alaM
         BSF33hm1v/SeC5KVtA67vv4rOyZYN2tIhULbPHhJj3YsiskPZXAv95BahL9Z+2T+XJq9
         b/g4Fre0xtKoxwpHUupI380ySm8NnqBrOFyXmElcPfmExV8ZVd3tBPUuupTF+qBDWArD
         CGQfJjsra5uCxfzmihjWa1BTx7ysbcAI5RMqHT0VseSHL+AKUGTio637fCdXOuoLTpRB
         Di0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765740659; x=1766345459;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AkDF/IHsQ0LQ2YPT4lm80CVidD6oYFhupeQzt7BNxAY=;
        b=OCT9Vij8AklFx056tCRcMP8BKa/LLK1QiQ0K7G/2AS4+lqwm7WRmBb3PFvR5xk5xOc
         0iWSNJq9uX7oJmBCpqSqRDydVxwHOROTA7dMZnlgXEdbev9H3HUOKuD3ID3GE2kratko
         ZLNl4RQzgydtBLyOZ82cemtX24cgvORXibaUZTkzQvVuJ+2J4eIAYKbCIVHW/UbMoPCA
         jYuhqvAzegd4MiR5NwKhT+pNhtsPYiQLrOQ9SfikGuPUM9SlOExR+KMT5KJyK20ZyQiq
         JwZdvbz/F4Ici36pvFnWcaTqT5TmY0VPVRnHQd3dyArmGYL2nB0QG5qJDwhSpUeOMitc
         A1mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz3iXN4S9N11dj/KIubIQZF3qSr+1sze3LsxE4IS6WCQMDjPFMPqHZkv/HLJUAoXxDmVBWXpNOydSo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw25Tfvx9HEjHO8Pi04KK6ECs/w3ImvpRYBFqqrEISnRfU5sv+r
	akAHhb6NHOQYPhXQZwccSMHT9CeNTUbnUMIW9EmDh+oHaeZD/+7rLDMge8Rk3SyvrV0RT96kDQO
	MEDUy6HSVU4k3z6r3MSRfgofWkd6BgZF21+lf8Xmk/40ZsswD0ZZUY9xgeVuoUgc=
X-Gm-Gg: AY/fxX6ze/96xsJ505YzVeY5HWgvIaXQdYmoN4q0IiYSBBXvvLekKNVuhKpgBLfrJo/
	uS5YcxI+MIkZ3aNITxtFYg0J1TEuJg5ZwzBUkE1clZKeU4wEL5PPYq6hftilUTVbph2HOxVbP41
	ATsiU7w4omnXP5USPVnWtUGXqkhEWpR2HZyhbtuTRWCIftsZh+6a7xDFOuYeDc5HlZrbCjtcWl+
	4x5D7J4Qgf9O/KcxrJpr8ja5XF8rR4u8LD3MC4nPvd2R1MD0DO5lfMiy2n8EK1qhPygRQ7Ld59c
	WCv3KUkh6w515I8Naa65C/o66M4hgyxb621AL+suHE0ZpRMkEz9cSocdBP5aSKf40lAYm1sE0X0
	9LtpvbqzsC9FHkN+f
X-Received: by 2002:a05:600c:1994:b0:477:a978:3a7b with SMTP id 5b1f17b1804b1-47a8f905675mr74588115e9.22.1765740659481;
        Sun, 14 Dec 2025 11:30:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1JD6sqz6cMNfj68jqPv9uhNS9gihklxA8B3t1RSm2FSST2qEHqefUpOZ7al5hM84O0pEMNA==
X-Received: by 2002:a05:600c:1994:b0:477:a978:3a7b with SMTP id 5b1f17b1804b1-47a8f905675mr74587865e9.22.1765740659011;
        Sun, 14 Dec 2025 11:30:59 -0800 (PST)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:11d6:cade:a15:8421])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a8f72ce1bsm55125135e9.5.2025.12.14.11.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Dec 2025 11:30:58 -0800 (PST)
Date: Sun, 14 Dec 2025 20:30:56 +0100
From: Ivan Vecera <ivecera@redhat.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
 "Nitka, Grzegorz" <grzegorz.nitka@intel.com>, Jiri Pirko <jiri@resnulli.us>,
 "Oros, Petr" <poros@redhat.com>, "Schmidt, Michal" <mschmidt@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Simon Horman <horms@kernel.org>,
 "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
 Willem de Bruijn <willemb@google.com>, Stefan Wahren <wahrenst@gmx.net>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: =?US-ASCII?Q?RE=3A_=5BIntel-wired-lan=5D_=5BPAT?=
 =?US-ASCII?Q?CH_RFC_net-next_13/13=5D_ice=3A?=
 =?US-ASCII?Q?_dpll=3A_Support_E825-C_SyncE_and_dynamic_pin_discovery?=
User-Agent: Thunderbird for Android
In-Reply-To: <IA3PR11MB898612C9A66ABA4DA673D3FCE5AEA@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20251211194756.234043-1-ivecera@redhat.com> <20251211194756.234043-14-ivecera@redhat.com> <IA3PR11MB898612C9A66ABA4DA673D3FCE5AEA@IA3PR11MB8986.namprd11.prod.outlook.com>
Message-ID: <08A08E3A-0EEF-4FE3-B038-04300E2A5E3A@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On December 12, 2025 11:20:43 AM GMT+01:00, "Loktionov, Aleksandr" <aleksa=
ndr=2Eloktionov@intel=2Ecom> wrote:
>
>
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl=2Eorg> On Behalf
>> Of Ivan Vecera
>> Sent: Thursday, December 11, 2025 8:48 PM
>> To: netdev@vger=2Ekernel=2Eorg; Andrew Lunn <andrew+netdev@lunn=2Ech>;
>> David S=2E Miller <davem@davemloft=2Enet>; Eric Dumazet
>> <edumazet@google=2Ecom>; Jakub Kicinski <kuba@kernel=2Eorg>; Paolo Aben=
i
>> <pabeni@redhat=2Ecom>; Rob Herring <robh@kernel=2Eorg>; Krzysztof
>> Kozlowski <krzk+dt@kernel=2Eorg>; Conor Dooley <conor+dt@kernel=2Eorg>;
>> Vadim Fedorenko <vadim=2Efedorenko@linux=2Edev>; Kubalewski, Arkadiusz
>> <arkadiusz=2Ekubalewski@intel=2Ecom>; Nitka, Grzegorz
>> <grzegorz=2Enitka@intel=2Ecom>; Jiri Pirko <jiri@resnulli=2Eus>; Oros,
>> Petr <poros@redhat=2Ecom>; Schmidt, Michal <mschmidt@redhat=2Ecom>;
>> Prathosh Satish <Prathosh=2ESatish@microchip=2Ecom>; Nguyen, Anthony L
>> <anthony=2El=2Enguyen@intel=2Ecom>; Kitszel, Przemyslaw
>> <przemyslaw=2Ekitszel@intel=2Ecom>; Saeed Mahameed <saeedm@nvidia=2Ecom=
>;
>> Leon Romanovsky <leon@kernel=2Eorg>; Tariq Toukan <tariqt@nvidia=2Ecom>=
;
>> Mark Bloch <mbloch@nvidia=2Ecom>; Richard Cochran
>> <richardcochran@gmail=2Ecom>; Jonathan Lemon
>> <jonathan=2Elemon@gmail=2Ecom>; Simon Horman <horms@kernel=2Eorg>;
>> Lobakin, Aleksander <aleksander=2Elobakin@intel=2Ecom>; Willem de Bruij=
n
>> <willemb@google=2Ecom>; Stefan Wahren <wahrenst@gmx=2Enet>;
>> devicetree@vger=2Ekernel=2Eorg; linux-kernel@vger=2Ekernel=2Eorg; intel=
-
>> wired-lan@lists=2Eosuosl=2Eorg; linux-rdma@vger=2Ekernel=2Eorg
>> Subject: [Intel-wired-lan] [PATCH RFC net-next 13/13] ice: dpll:
>> Support E825-C SyncE and dynamic pin discovery
>>=20
>> From: Arkadiusz Kubalewski <arkadiusz=2Ekubalewski@intel=2Ecom>
>>=20
>> Add DPLL support for the Intel E825-C Ethernet controller=2E Unlike
>> previous
>> generations (E810), the E825-C connects to the platform's DPLL
>> subsystem
>> via MUX pins defined in the system firmware (Device Tree/ACPI)=2E
>>=20
>> Implement the following mechanisms to support this architecture:
>>=20
>> 1=2E Dynamic Pin Discovery: Use the fwnode_dpll_pin_find() helper to
>>    locate the parent MUX pins defined in the firmware=2E
>>=20
>> 2=2E Asynchronous Registration: Since the platform DPLL driver may
>> probe
>>    independently of the network driver, utilize the DPLL notifier
>> chain
>>    (register_dpll_notifier)=2E The driver listens for DPLL_PIN_CREATED
>>    events to detect when the parent MUX pins become available, then
>>    registers its own Recovered Clock (RCLK) and PTP (1588) pins as
>> children
>>    of those parents=2E
>>=20
>> 3=2E Hardware Configuration: Implement the specific register access
>> logic
>>    for E825-C CGU (Clock Generation Unit) registers (R10, R11)=2E This
>>    includes configuring the bypass MUXes and clock dividers required
>> to
>>    drive SyncE and PTP signals=2E
>>=20
>> 4=2E Split Initialization: Refactor `ice_dpll_init()` to separate the
>>    static initialization path of E810 from the dynamic, firmware-
>> driven
>>    path required for E825-C=2E
>>=20
>> Co-developed-by: Ivan Vecera <ivecera@redhat=2Ecom>
>> Co-developed-by: Grzegorz Nitka <grzegorz=2Enitka@intel=2Ecom>
>> Signed-off-by: Ivan Vecera <ivecera@redhat=2Ecom>
>> Signed-off-by: Grzegorz Nitka <grzegorz=2Enitka@intel=2Ecom>
>> Signed-off-by: Arkadiusz Kubalewski <arkadiusz=2Ekubalewski@intel=2Ecom=
>
>> ---
>>  drivers/net/ethernet/intel/ice/ice_dpll=2Ec   | 964
>> ++++++++++++++++++--
>>  drivers/net/ethernet/intel/ice/ice_dpll=2Eh   |  29 +
>>  drivers/net/ethernet/intel/ice/ice_lib=2Ec    |   3 +
>>  drivers/net/ethernet/intel/ice/ice_ptp=2Ec    |  29 +
>>  drivers/net/ethernet/intel/ice/ice_ptp_hw=2Ec |   9 +-
>>  drivers/net/ethernet/intel/ice/ice_ptp_hw=2Eh |   1 +
>>  drivers/net/ethernet/intel/ice/ice_tspll=2Ec  | 223 +++++
>>  drivers/net/ethernet/intel/ice/ice_tspll=2Eh  |  14 +-
>>  drivers/net/ethernet/intel/ice/ice_type=2Eh   |   6 +
>>  9 files changed, 1188 insertions(+), 90 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll=2Ec
>
>=2E=2E=2E
>
>> +static int
>> +ice_dpll_pin_get_parent_num(struct ice_dpll_pin *pin,
>> +			    const struct dpll_pin *parent)
>> +{
>> +	int i;
>> +
>> +	for (i =3D 0; pin->num_parents; i++)
>> +		if (pin->pf->dplls=2Einputs[pin->parent_idx[i]]=2Epin =3D=3D
>> parent)
>Oh, no! we don't need a 2nd Infinite Loop in Cupertino!

Oops, thanks for pointing out=2E=2E=2E During testing the parent
was always found so this didn't cause any problem=2E

Of course I will fix it=2E =F0=9F=98=89
>
>=2E=2E=2E
>
>
>> --
>> 2=2E51=2E2
>


