Return-Path: <linux-rdma+bounces-15648-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AECF3D38A54
	for <lists+linux-rdma@lfdr.de>; Sat, 17 Jan 2026 00:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E25A130869F1
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Jan 2026 23:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98AA7315775;
	Fri, 16 Jan 2026 23:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPr7Dtsn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F073002D8
	for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 23:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768606788; cv=none; b=eRG5ARrwv4VtSCPW3Xgd9EHYc//IgUt2Y/3tbcawra3FJc8Io6PI7xQqQf2j71Pd3tGOdnKPHTcT7/NzDN6l3toOPlAUItark9GjAPUJ4Ga6HYJHAboVn4OS8Qd+oqRMh/vGA4VxrP+Jtrs9kl9AR0rbeeD6RW4CRBH1YChM3Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768606788; c=relaxed/simple;
	bh=1L4Z10EN3fStlLWrOTv25Pq3Qk48HrL3c61DmZOsz6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e9nj3gEVuK7EurziTcz59h8EY72V7ZbQHeZLK6mq01lCBztjRDKqNox+YsHoEEpAgOQ3uwZQRy0C+BRL6HtMAHnmWFYLS9RIqXmPM6dS6Xx+WUuzLPNnjrWhF5SJ/Y19FdQCkq4wClj22oEksFZLxL0Wgnw8WTLW4qqCTytro+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPr7Dtsn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A52C2BCB0
	for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 23:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768606788;
	bh=1L4Z10EN3fStlLWrOTv25Pq3Qk48HrL3c61DmZOsz6s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=CPr7Dtsnm5xqqjXRoF4zmWwxIcvihEIqjlYx3ZOjBpFWmdO+6X/jWujdQK9oaw2gp
	 khc5ZIXwQLm32zCcGPWx58h/7b6Ar2SeZjjylFefDa0SyPZIeuCm6XPVxTVyqNILYc
	 cGsBKMlC8DlhJQBl8v1ITDHAkqoEFnW9nnuMOmPQB8eW5+CjcfMo1mLhzsZUDYPFUe
	 9v4fwygvZqHklVK8cdq+xo90aLrH+KhrA+JxOZ/C3EeM4rPHAzNTB3gjfXlwpPsg/y
	 Q8Q8RCBh7QIaWDcGjgqE6LFQa5rq0PmGvEBeOg/QC57ckm0PJ4lqje94zowytehp0k
	 N2SK0WfBEUNyw==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64b608ffca7so3968848a12.3
        for <linux-rdma@vger.kernel.org>; Fri, 16 Jan 2026 15:39:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX1d8iPgaAGjkqez1SeIGExcRd9C7gJZrM5CZ6x3gbysyevaDbJ3OfaWTRcs40QJ8O+15dA1qNLi1VM@vger.kernel.org
X-Gm-Message-State: AOJu0YyBcHdkvcLV3HxwEzWmcvP3nSbr+rINBiA+Z5YdNpjkPYRUThNw
	ZZVnpYlvB5XIZIpOAxH4wTNRvksOEhRMkLWTXrn5icPTwD8U3ajBwjv/IFTaYbVHHkxBYYafqiI
	sA8AM9BYZRDt7be7Behx+I/sgHCb1HQ==
X-Received: by 2002:a05:6402:3547:b0:653:10be:c89b with SMTP id
 4fb4d7f45d1cf-654bb70fa92mr3102930a12.34.1768606786546; Fri, 16 Jan 2026
 15:39:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108182318.20935-1-ivecera@redhat.com> <20260108182318.20935-2-ivecera@redhat.com>
 <92bfc390-d706-4988-b98d-841a50f10834@redhat.com> <CAL_Jsq+m7-wop-AU-7R-=2JsUqb+2LsVTXCbZw==1XuAAQ4Tkg@mail.gmail.com>
 <a5dad0f9-001c-468f-99bc-e24c23bc9b36@redhat.com>
In-Reply-To: <a5dad0f9-001c-468f-99bc-e24c23bc9b36@redhat.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 16 Jan 2026 17:39:35 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJhqp-cgj604eEgxD47gJci0d3CFYf1wC_t1c00OptTiQ@mail.gmail.com>
X-Gm-Features: AZwV_Qgghn897CtG_q8P6welgr6_MD-NJlyOmC0cWTEkTMdvGwzWh8_gNK8Dfu8
Message-ID: <CAL_JsqJhqp-cgj604eEgxD47gJci0d3CFYf1wC_t1c00OptTiQ@mail.gmail.com>
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

On Fri, Jan 16, 2026 at 1:00=E2=80=AFPM Ivan Vecera <ivecera@redhat.com> wr=
ote:
>
> On 1/16/26 4:23 PM, Rob Herring wrote:
> > On Thu, Jan 15, 2026 at 6:02=E2=80=AFAM Ivan Vecera <ivecera@redhat.com=
> wrote:
> >>
> >> On 1/8/26 7:23 PM, Ivan Vecera wrote:
> >>> Introduce a common schema for DPLL pin consumers. Devices such as Eth=
ernet
> >>> controllers and PHYs may require connections to DPLL pins for Synchro=
nous
> >>> Ethernet (SyncE) or other frequency synchronization tasks.
> >>>
> >>> Defining these properties in a shared schema ensures consistency acro=
ss
> >>> different device types that consume DPLL resources.
> >>>
> >>> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> >>> ---
> >>>    .../bindings/dpll/dpll-pin-consumer.yaml      | 30 +++++++++++++++=
++++
> >>>    MAINTAINERS                                   |  1 +
> >>>    2 files changed, 31 insertions(+)
> >>>    create mode 100644 Documentation/devicetree/bindings/dpll/dpll-pin=
-consumer.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/dpll/dpll-pin-consumer=
.yaml b/Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml
> >>> new file mode 100644
> >>> index 0000000000000..60c184c18318a
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml
> >>> @@ -0,0 +1,30 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/dpll/dpll-pin-consumer.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: DPLL Pin Consumer
> >>> +
> >>> +maintainers:
> >>> +  - Ivan Vecera <ivecera@redhat.com>
> >>> +
> >>> +description: |
> >>> +  Common properties for devices that require connection to DPLL (Dig=
ital Phase
> >>> +  Locked Loop) pins for frequency synchronization (e.g. SyncE).
> >>> +
> >>> +properties:
> >>> +  dpll-pins:
> >>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> >>> +    description:
> >>> +      List of phandles to the DPLL pin nodes connected to this devic=
e.
> >>> +
> >>> +  dpll-pin-names:
> >>> +    $ref: /schemas/types.yaml#/definitions/string-array
> >>> +    description:
> >>> +      Names for the DPLL pins defined in 'dpll-pins', in the same or=
der.
> >>> +
> >>> +dependencies:
> >>> +  dpll-pin-names: [ dpll-pins ]
> >>> +
> >>> +additionalProperties: true
> >>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>> index 765ad2daa2183..f6f58dfb20931 100644
> >>> --- a/MAINTAINERS
> >>> +++ b/MAINTAINERS
> >>> @@ -7648,6 +7648,7 @@ M:      Jiri Pirko <jiri@resnulli.us>
> >>>    L:  netdev@vger.kernel.org
> >>>    S:  Supported
> >>>    F:  Documentation/devicetree/bindings/dpll/dpll-device.yaml
> >>> +F:   Documentation/devicetree/bindings/dpll/dpll-pin-consumer.yaml
> >>>    F:  Documentation/devicetree/bindings/dpll/dpll-pin.yaml
> >>>    F:  Documentation/driver-api/dpll.rst
> >>>    F:  drivers/dpll/
> >>
> >> Based on private discussion with Andrew Lunn (thanks a lot), this is
> >> wrong approach. Referencing directly dpll-pin nodes and using their
> >> phandles in consumers is at least unusual.
> >>
> >> The right approach should be referencing dpll-device and use cells
> >> to specify the dpll pin that is used.
> >
> > You only need a cells property if you expect the number of cells to
> > vary by provider.
> >
> > However, the DPLL device just appears to be a clock provider and
> > consumer, so why not just use the clock binding here? Also, there is
> > no rule that using foo binding means you have to use foo subsystem in
> > the kernel.
>
> Hmm, do you mean something like this example?
>
> &dpll0 {
>      ...
>      #clock-cells =3D <2>; /* 1st pin index, 2nd pin type (input/output) =
*/
>
>      input-pins {
>          pin@2 {
>              reg =3D <2>;
>              ...
>          };
>          pin@4 {
>              reg =3D <4>;
>              ...
>          };
>      };
>      output-pins {
>          pin@3 {
>              reg =3D <3>;
>          };
>      };
> };
> &phy0 {
>      ...
>      clock-names =3D "rclk0", "rclk1", "synce_ref";
>      clocks =3D <&dpll0 2 DPLL_INPUT>,
>               <&dpll0 4 DPLL_INPUT>,
>               <&dpll0 3 DPLL_OUTPUT>;
>      ...
> };

No, clock providers are always the clock outputs, and clock consumers
are the clock inputs. So something like this:

&dpll0 {
     ...
     #clock-cells =3D <1>; /* 1st pin index */

     // clocks index corresponds to input pins on dpll0 */
     clocks =3D <&phy0 0>, <&phy0 1>, <&phy1 0>, <&phy1 1>
};
&phy0 {
     ...
     #clock-cells =3D <1>;
     clocks =3D <&dpll0 3>;
     ...
};

Rob

