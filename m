Return-Path: <linux-rdma+bounces-15347-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E36ACFE8E1
	for <lists+linux-rdma@lfdr.de>; Wed, 07 Jan 2026 16:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AC19307F203
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Jan 2026 15:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3478534B1AC;
	Wed,  7 Jan 2026 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/6zdPLU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75BE34AB17
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798951; cv=none; b=L1vJY6fRH72ZRvp+D1fFZbbHShTkel/wmxfiEzNJ3vs9zTv/SlnwrbHY/VHI35KE7hghbADFe3R3OZq5Sa85wayYNQT6fRiYt3eUjZUypR/NdVn2YuEMqaNtatZLsHb4BpXr1cdy9i7uO4MYWqb2NOp+q5KdRx5F/Oz7YxZrZa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798951; c=relaxed/simple;
	bh=btRszEfDKT0eYItv1CyxkQzic7zsq25d8SD2XhT7Hog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BECA+NllgYvoxmq0mTfw0AXj0kv45OMryYe+frNbpQWx2ZLQbZCluqnb2b+lI0HO4UQp9TpQlU6K0Fzl6FgtVOuEtSj6AlP6Tg8vSWniyyIpK/c7Sq0LB6PBm8TA4t0ULfv7e94mvTLYXlWzHpZjOU5G0HLDknD5sHvjctGm66M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/6zdPLU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1D8C19422
	for <linux-rdma@vger.kernel.org>; Wed,  7 Jan 2026 15:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767798950;
	bh=btRszEfDKT0eYItv1CyxkQzic7zsq25d8SD2XhT7Hog=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B/6zdPLUrFsRfFIILoc6ihh2pnTBRCgUDg6kHie7ruTF5G+SqykR4KeEajNF7nilE
	 3dTq+EsHHIs4uOWxUr14XcsCol9PWpVCjYXW9jNtLGg5Wrjkmpm5O3mwes/g41d/O7
	 49gGSQEh1SIMqPI1c7flLRZZeMMA7gyNGg5mUy2EKTEbjcO1Uh7b5F81xiXscQMzis
	 GRXaQrSthfxBjO8/iktetAn9b2vu/Ybqb7E8zPXNSiafFqHy198G28Elp0PYSLqR9m
	 5x/k6bKczDAJ3MKr7GfZ60PJ/AbIm4Steb24xrz5EfvFPgr9PhNQiTNr/MkLYzgNXd
	 u4MrBJYRVHWEA==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64b7318f1b0so2949342a12.2
        for <linux-rdma@vger.kernel.org>; Wed, 07 Jan 2026 07:15:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXiycPJUGQ0m5NIgHcP+S5/kwjBC583aR0PvjM4AfRosdCQJMoxSuWB1WX6hV9qISKtmXETCYWqGtsD@vger.kernel.org
X-Gm-Message-State: AOJu0YzzLAIXaiX/0g4Ban7m56u5qtctU7/M0gmrIhdPXRmJgAwnAt0k
	XHzD8/sdHS3pCe33Oo31qTAkCgHNqPDN8noKHOOkT4DfEsl0tXEQD7ENc7OHkdKlRkgx7gsPkWu
	nYAlmsZjkdMgQagRM00R41w0TykabxQ==
X-Google-Smtp-Source: AGHT+IHTu0IXdc7TRfyMIYF+QpCpK6DkoNxBGd6TkBQLccFk0QYJOtERX/Fnx/bdwmh+ZYEKzBXy6b/YHmlBglI6/fk=
X-Received: by 2002:a05:6402:524e:b0:649:aa2b:d34e with SMTP id
 4fb4d7f45d1cf-65097e6eb29mr2485631a12.34.1767798947742; Wed, 07 Jan 2026
 07:15:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211194756.234043-1-ivecera@redhat.com> <20251211194756.234043-2-ivecera@redhat.com>
 <2de556f0-d7db-47f1-a59e-197f92f93d46@lunn.ch> <20251217004946.GA3445804-robh@kernel.org>
 <5db81f5b-4f35-46e4-8fec-4298f1ac0c4e@redhat.com>
In-Reply-To: <5db81f5b-4f35-46e4-8fec-4298f1ac0c4e@redhat.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 7 Jan 2026 09:15:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJoybgJTAbSjGbTBxo-v=dbYY68tT309CV98=ohWhnC=w@mail.gmail.com>
X-Gm-Features: AQt7F2pnzqJSJSW6Fy5D7MtV-9H8Kn_aFTARkU6M2TNlskQ2igYg-G95nQ8JUTs
Message-ID: <CAL_JsqJoybgJTAbSjGbTBxo-v=dbYY68tT309CV98=ohWhnC=w@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 01/13] dt-bindings: net: ethernet-controller:
 Add DPLL pin properties
To: Ivan Vecera <ivecera@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Grzegorz Nitka <grzegorz.nitka@intel.com>, 
	Jiri Pirko <jiri@resnulli.us>, Petr Oros <poros@redhat.com>, 
	Michal Schmidt <mschmidt@redhat.com>, Prathosh Satish <Prathosh.Satish@microchip.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Mark Bloch <mbloch@nvidia.com>, Richard Cochran <richardcochran@gmail.com>, 
	Jonathan Lemon <jonathan.lemon@gmail.com>, Simon Horman <horms@kernel.org>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Willem de Bruijn <willemb@google.com>, 
	Stefan Wahren <wahrenst@gmx.net>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org, 
	Horatiu Vultur <Horatiu.Vultur@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 10:24=E2=80=AFAM Ivan Vecera <ivecera@redhat.com> wr=
ote:
>
> On 12/17/25 1:49 AM, Rob Herring wrote:
> > On Thu, Dec 11, 2025 at 08:56:52PM +0100, Andrew Lunn wrote:
> >> On Thu, Dec 11, 2025 at 08:47:44PM +0100, Ivan Vecera wrote:
> >>> Ethernet controllers may be connected to DPLL (Digital Phase Locked L=
oop)
> >>> pins for frequency synchronization purposes, such as in Synchronous
> >>> Ethernet (SyncE) configurations.
> >>>
> >>> Add 'dpll-pins' and 'dpll-pin-names' properties to the generic
> >>> ethernet-controller schema. This allows describing the physical
> >>> connections between the Ethernet controller and the DPLL subsystem pi=
ns
> >>> in the Device Tree, enabling drivers to request and manage these
> >>> resources.
> >>
> >> Please include a .dts patch in the series which actually makes use of
> >> these new properties.
> >
> > Actually, first you need a device (i.e. a specific ethernet
> > controller bindings) using this and defining the number of dpll-pins
> > entries and the names.
>
> The goal of this patch is to define properties that allow referencing
> dpll pins from other devices. I included it in this series to allow
> implementing helpers that use the property names defined in the schema.
>
> This series implements the dpll pin consumer in the ice driver. This is
> usually present on ACPI platforms, so the properties are stored in _DSD
> ACPI nodes. Although I don't have a DT user right now, isn't it better
> to define the schema now?

I have no idea what makes sense for ACPI and little interest in
reviewing ACPI bindings. While I think the whole idea of shared
bindings is questionable, really it's a question of review bandwidth
and so far no one has stepped up to review ACPI bindings.

> Thinking about this further, consumers could be either an Ethernet
> controller (where the PHY is not exposed and is driven directly by the
> NIC driver) or an Ethernet PHY.
>
> For the latter case (Ethernet PHY), I have been preparing a similar
> implementation for the Micrel phy driver (lan8814) on the Microchip EDS2
> board (pcb8385). Unfortunately, the DTS is not upstreamed yet [1], so I
> cannot include the necessary bindings here.
>
> Since there can be multiple consumer types (Ethernet controller or PHY),
> would it be better to define a dpll-pin-consumer.yaml schema instead
> (similar to mux-consumer)?

The consumer type doesn't matter for that. What matters is you have
specific device bindings and if they are consumers of some
provider/consumer style binding, then typically each device binding
has to define the constraints if there can be multiple
entries/connections (e.g. how many interrupts, clocks, etc. and what
each one is).

Hard to say what's needed for DPLL exactly because I know next to
nothing about it.

Rob

