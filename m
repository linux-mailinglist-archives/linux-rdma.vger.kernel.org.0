Return-Path: <linux-rdma+bounces-15626-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7D7D332B8
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 16:26:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 166B03022031
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 15:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B4D32939B;
	Fri, 16 Jan 2026 15:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLfyX71N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEF82459E7
	for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 15:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768576998; cv=none; b=og3Hj3Nn/tWQNX/f1w6d7Cp13xihQURVpN7HYy5GLaeRVpDdfuOr1yInHzzT4be9og93xK5r/oH/M8OLt5CDC2fcKIf7oQ1+xEH/c67jGHakKs0yUhvJv6DjZ78d1AvpCMso2vf23kHxrt2ge5PXzRYAxWpt67IwbU/cOOF6QMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768576998; c=relaxed/simple;
	bh=I95ZAYK4g0iaIBgyWWT6qE8RYqfadEs79jthdaODn8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhSBZVKl6k+aDekoSYzfm8xx6piLXZPVoVNlk9UUF/VwX4jUuw39lCfv6Wfu1Ub6FZuLl7e5GHj9S9udieolAa+iwnPom0G3W7AL6c4lY/oXMEAUoNCTZ8cpKUWQpevfbB98ACoDfn5UBIZYoA/hdweWsp9uVnEd19bHMJ4Xjd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLfyX71N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C732EC2BC86
	for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 15:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768576997;
	bh=I95ZAYK4g0iaIBgyWWT6qE8RYqfadEs79jthdaODn8M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZLfyX71NQXvwj/W5BpplKZI96FuK+hnvfwagcEoCCp1huo5SIDB2cdZnVDYkaafNW
	 6VWM7RJCtBFn37WiR/vFe91iP1YsUpYS0pNSZiYSGm4qgLUaWTDnOxMKfxQFxt6/8R
	 ZGYNDleeXIKp8uX1O7+T5nrW/G4/1xUdeX+jEbPbuxWyFctOiFJRmZjQRmad38pV10
	 d7yOGk0L3l7pjFvJi0wS3Rd55fdJR5lqpZhKAFwQJv04pj4KBubhAGQQ7OQ5IhFNe1
	 4fups7R4YuoayyfwW1NQJftiNpVrLu8GTppdfs86xIraTWulFvnLYIzjZsgWoYn4f1
	 /WUb729mKhHXw==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-65089cebdb4so3431243a12.0
        for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 07:23:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW4C4Voevr4nz2kvnZe7KwI7MbJwppZQwJzlM8GMESgzBYdkh6CF70WpSB5UYldh1KLbqTmkA2MNj+b@vger.kernel.org
X-Gm-Message-State: AOJu0YyrWqXVv8cdh0j7dtRckdyhPCSxPMA3aRqBhlAbBsjYKwBZPe1V
	woruZDtGQpepCaDiCNJYimkEzdGvDr4NAph2hm2Ie1ChggVeXZLR84Zt2RP1o5oUjwidhbHKlGw
	/PyD7i/27q29oNEDAoy77B7DGgkEK9g==
X-Received: by 2002:a17:907:9622:b0:b86:ef31:b16a with SMTP id
 a640c23a62f3a-b8796afd5dbmr247755966b.39.1768576996219; Fri, 16 Jan 2026
 07:23:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108182318.20935-1-ivecera@redhat.com> <20260108182318.20935-2-ivecera@redhat.com>
 <92bfc390-d706-4988-b98d-841a50f10834@redhat.com>
In-Reply-To: <92bfc390-d706-4988-b98d-841a50f10834@redhat.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 16 Jan 2026 09:23:04 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+m7-wop-AU-7R-=2JsUqb+2LsVTXCbZw==1XuAAQ4Tkg@mail.gmail.com>
X-Gm-Features: AZwV_QheQ8JZ1b9uOY1VIrHmkFgsPGZdWR9BRMf5iRCGHz0XIPV_zO5cvZNd_B0
Message-ID: <CAL_Jsq+m7-wop-AU-7R-=2JsUqb+2LsVTXCbZw==1XuAAQ4Tkg@mail.gmail.com>
Subject: Re: [PATCH net-next 01/12] dt-bindings: dpll: add common
 dpll-pin-consumer schema
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Jiri Pirko <jiri@resnulli.us>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Jonathan Lemon <jonathan.lemon@gmail.com>, Richard Cochran <richardcochran@gmail.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	linux-rdma@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>, 
	Petr Oros <poros@redhat.com>, Grzegorz Nitka <grzegorz.nitka@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 6:02=E2=80=AFAM Ivan Vecera <ivecera@redhat.com> wr=
ote:
>
> On 1/8/26 7:23 PM, Ivan Vecera wrote:
> > Introduce a common schema for DPLL pin consumers. Devices such as Ether=
net
> > controllers and PHYs may require connections to DPLL pins for Synchrono=
us
> > Ethernet (SyncE) or other frequency synchronization tasks.
> >
> > Defining these properties in a shared schema ensures consistency across
> > different device types that consume DPLL resources.
> >
> > Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> > ---
> >   .../bindings/dpll/dpll-pin-consumer.yaml      | 30 ++++++++++++++++++=
+
> >   MAINTAINERS                                   |  1 +
> >   2 files changed, 31 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin-co=
nsumer.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/dpll/dpll-pin-consumer.y=
aml b/Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml
> > new file mode 100644
> > index 0000000000000..60c184c18318a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml
> > @@ -0,0 +1,30 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dpll/dpll-pin-consumer.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: DPLL Pin Consumer
> > +
> > +maintainers:
> > +  - Ivan Vecera <ivecera@redhat.com>
> > +
> > +description: |
> > +  Common properties for devices that require connection to DPLL (Digit=
al Phase
> > +  Locked Loop) pins for frequency synchronization (e.g. SyncE).
> > +
> > +properties:
> > +  dpll-pins:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description:
> > +      List of phandles to the DPLL pin nodes connected to this device.
> > +
> > +  dpll-pin-names:
> > +    $ref: /schemas/types.yaml#/definitions/string-array
> > +    description:
> > +      Names for the DPLL pins defined in 'dpll-pins', in the same orde=
r.
> > +
> > +dependencies:
> > +  dpll-pin-names: [ dpll-pins ]
> > +
> > +additionalProperties: true
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 765ad2daa2183..f6f58dfb20931 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7648,6 +7648,7 @@ M:      Jiri Pirko <jiri@resnulli.us>
> >   L:  netdev@vger.kernel.org
> >   S:  Supported
> >   F:  Documentation/devicetree/bindings/dpll/dpll-device.yaml
> > +F:   Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml
> >   F:  Documentation/devicetree/bindings/dpll/dpll-pin.yaml
> >   F:  Documentation/driver-api/dpll.rst
> >   F:  drivers/dpll/
>
> Based on private discussion with Andrew Lunn (thanks a lot), this is
> wrong approach. Referencing directly dpll-pin nodes and using their
> phandles in consumers is at least unusual.
>
> The right approach should be referencing dpll-device and use cells
> to specify the dpll pin that is used.

You only need a cells property if you expect the number of cells to
vary by provider.

However, the DPLL device just appears to be a clock provider and
consumer, so why not just use the clock binding here? Also, there is
no rule that using foo binding means you have to use foo subsystem in
the kernel.

Rob

