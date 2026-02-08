Return-Path: <linux-rdma+bounces-16669-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AL79Fgvrh2lxfAQAu9opvQ
	(envelope-from <linux-rdma+bounces-16669-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Feb 2026 02:46:51 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE28D107922
	for <lists+linux-rdma@lfdr.de>; Sun, 08 Feb 2026 02:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79962301326A
	for <lists+linux-rdma@lfdr.de>; Sun,  8 Feb 2026 01:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB5B306496;
	Sun,  8 Feb 2026 01:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDdMCyE9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D64027CB04
	for <linux-rdma@vger.kernel.org>; Sun,  8 Feb 2026 01:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770515200; cv=none; b=Fv1dMqvNSP1rqX12X5TyYWLO6g4iVz4iIME+3583zYwumTIc8Iw1FSitj+9Fzs06RguGNKVvJkwLwjDR6OJ37hdN4RIDF6VpDC3eAEgvJL5AvIeu0M29VF6/bAClNw99tditewa3OwS2kc9uzdO+Z2N9Pi2jSnFsPLvyF6gMuzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770515200; c=relaxed/simple;
	bh=tyWxKxHsau3OE/oOgqAMGEezSdgdUNWkxIfNxt57e0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YbnnICl2nzs0B/cBmy0c+UMWMxlB02m1vOWaAHCvM/fT8a4IivCpFlpsgooVKqsASzvjDk7gFicT7s/QJ5Kih7BDY7vbg5rPi2M6RWDaSLJI5wiiXBGqZHK079H9m5/bnG6lvNLhTDOQizIUeI7b8Y21vgLvTy/rsxjpie5n/TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDdMCyE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4472C2BC87
	for <linux-rdma@vger.kernel.org>; Sun,  8 Feb 2026 01:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770515199;
	bh=tyWxKxHsau3OE/oOgqAMGEezSdgdUNWkxIfNxt57e0o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QDdMCyE9FaslMT+tqVeDGyLkA0xMjAYaKfS3mx6ZcgEHXqpcucaofAyQ1H09X6VW1
	 mz3CWkYMvfWrn9KQ0lG9il8AmmNDS1jIP+7JLyrPF2chvbPfRanw6BzUCIZWr8NAJd
	 WQXZFmkm4WMJ9Uav00q1irrRY5cx2UuUXbtvFi8ZSV32EJhQBNRqFrEoxSj67cqZy8
	 bYqxrS/BjSgy/WMWQ79sWBa5wjsKXbPvaF5vbGzWfaarZM+Hx7AUZYuNOAPEtbit7M
	 VFGojULfqI6GaIOM+fGSP1GvYp76cyjUsBuIkSuQbVmNW3iG6c/VOlkr+0b56NfqY6
	 L/DqvALmsPqWQ==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64c893f3a94so6720624a12.0
        for <linux-rdma@vger.kernel.org>; Sat, 07 Feb 2026 17:46:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXcG3sGRDlrjUhQg++lvrYCVUyKh1t39uzPpJ+bTlk3qOcCrxO2S39QEaijutwhexdSl7IRlWnQ9gHy@vger.kernel.org
X-Gm-Message-State: AOJu0YyIcGjztpqzdn5uDrTcFdjyscb/FWXZW+24cxYyR5y/Nu3+htnJ
	4eO81wJ8x1Ej7Ncn6YqaPj9ADCHBrRJ/QAjdswWJy7Fx/bsCNwVeoPA6+t3GEJ3OJQFQLP/VN8Q
	/0N32NptJ3vyXz5CkPE7xZgtuIObS6aU=
X-Received: by 2002:a17:907:3f26:b0:b80:1403:764c with SMTP id
 a640c23a62f3a-b8eba262322mr666655266b.24.1770515198428; Sat, 07 Feb 2026
 17:46:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116184610.147591-1-ivecera@redhat.com> <20260116184610.147591-4-ivecera@redhat.com>
In-Reply-To: <20260116184610.147591-4-ivecera@redhat.com>
From: Saravana Kannan <saravanak@kernel.org>
Date: Sat, 7 Feb 2026 17:46:27 -0800
X-Gmail-Original-Message-ID: <CACRMN=dy3eosPYSne3UKBL+ArOT-pzd3N5k3e7GPwSXJQ=6UwA@mail.gmail.com>
X-Gm-Features: AZwV_Qg_RIFSoCTTzuceW6K6a5A6HDh2-N6dPY7F917i1v3mTVT5QWLwoY0jwlk
Message-ID: <CACRMN=dy3eosPYSne3UKBL+ArOT-pzd3N5k3e7GPwSXJQ=6UwA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 03/12] dpll: Add helpers to find DPLL pin fwnode
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, 
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, Conor Dooley <conor+dt@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Grzegorz Nitka <grzegorz.nitka@intel.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jiri Pirko <jiri@resnulli.us>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, 
	Michal Schmidt <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Petr Oros <poros@redhat.com>, 
	Prathosh Satish <Prathosh.Satish@microchip.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Richard Cochran <richardcochran@gmail.com>, 
	Rob Herring <robh@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Saravana Kannan <saravanak@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	devicetree@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16669-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,lunn.ch,kernel.org,davemloft.net,google.com,resnulli.us,gmail.com,nvidia.com,redhat.com,microchip.com,linux.dev,lists.osuosl.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[saravanak@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE28D107922
X-Rspamd-Action: no action

On Fri, Jan 16, 2026 at 10:46=E2=80=AFAM Ivan Vecera <ivecera@redhat.com> w=
rote:
>
> dpll: core: add helpers to find DPLL pin fwnode
>
> Add helper functions to the DPLL core to retrieve a DPLL pin's firmware
> node handle based on the 'dpll-pins' and 'dpll-pin-names' properties.
>
> Unlike simple phandle arrays, 'dpll-pins' entries typically contain
> a pin specifier (index and direction) as defined by '#dpll-pin-cells'.
> The new helper fwnode_dpll_pin_node_get() parses these specifiers
> using fwnode_property_get_reference_args(). It resolves the target
> pin by:
> 1. Identifying the DPLL device node from the phandle.
> 2. Selecting the correct sub-node ('input-pins' or 'output-pins') based
>    on the direction argument.
> 3. Matching the pin index argument against the 'reg' property of
>    the child nodes.
>
> Additionally, register 'dpll-pins' in drivers/of/property.c to enable
> proper parsing of the supplier bindings by the OF core.
>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
> v2:
> * added check for fwnode_property_match_string() return value
> * reworked searching for the pin using dpll device phandle and
>   pin specifier
> * added dpll-pins into OF core supplier_bindings
> ---
>  drivers/dpll/dpll_core.c | 74 ++++++++++++++++++++++++++++++++++++++++
>  drivers/of/property.c    |  2 ++
>  include/linux/dpll.h     | 15 ++++++++
>  3 files changed, 91 insertions(+)
>
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index fb68b5e19b480..b0083b5c10aa4 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -13,6 +13,7 @@
>  #include <linux/property.h>
>  #include <linux/slab.h>
>  #include <linux/string.h>
> +#include <dt-bindings/dpll/dpll.h>
>
>  #include "dpll_core.h"
>  #include "dpll_netlink.h"
> @@ -654,6 +655,79 @@ struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_=
handle *fwnode)
>  }
>  EXPORT_SYMBOL_GPL(fwnode_dpll_pin_find);
>
> +/**
> + * fwnode_dpll_pin_node_get - get dpll pin node from given fw node and p=
in name
> + * @fwnode: firmware node that uses the dpll pin
> + * @name: dpll pin name from dpll-pin-names property
> + *
> + * Return: ERR_PTR() on error or a valid firmware node handle on success=
.
> + */
> +struct fwnode_handle *fwnode_dpll_pin_node_get(struct fwnode_handle *fwn=
ode,
> +                                              const char *name)
> +{
> +       struct fwnode_handle *parent_node, *pin_node;
> +       struct fwnode_reference_args args;
> +       const char *parent_name;
> +       int ret, index =3D 0;
> +
> +       if (name) {
> +               index =3D fwnode_property_match_string(fwnode, "dpll-pin-=
names",
> +                                                    name);
> +               if (index < 0)
> +                       return ERR_PTR(-ENOENT);
> +       }
> +
> +       ret =3D fwnode_property_get_reference_args(fwnode, "dpll-pins",
> +                                                "#dpll-pin-cells", 2, in=
dex,
> +                                                &args);
> +       if (ret)
> +               return ERR_PTR(ret);
> +
> +       /* We support only 2 cell DPLL bindings in the kernel currently. =
*/
> +       if (args.nargs !=3D 2) {
> +               fwnode_handle_put(args.fwnode);
> +               return ERR_PTR(-ENOENT);
> +       }
> +
> +       /* Resolve parent node name according pin direction type */
> +       switch (args.args[1]) {
> +       case DPLL_PIN_INPUT:
> +               parent_name =3D "input-pins";
> +               break;
> +       case DPLL_PIN_OUTPUT:
> +               parent_name =3D "output-pins";
> +               break;
> +       default:
> +               fwnode_handle_put(args.fwnode);
> +               return ERR_PTR(-EINVAL);
> +       }
> +
> +       /* Get pin's parent sub-node */
> +       parent_node =3D fwnode_get_named_child_node(args.fwnode, parent_n=
ame);
> +       if (!parent_node) {
> +               fwnode_handle_put(args.fwnode);
> +               return ERR_PTR(-ENOENT);
> +       }
> +
> +       /* Enumerate child pin nodes and find the requested one */
> +       fwnode_for_each_child_node(parent_node, pin_node) {
> +               u32 reg;
> +
> +               if (fwnode_property_read_u32(pin_node, "reg", &reg))
> +                       continue;
> +
> +               if (reg =3D=3D args.args[0])
> +                       break;
> +       }
> +
> +       /* Release pin's parent and dpll device node */
> +       fwnode_handle_put(parent_node);
> +       fwnode_handle_put(args.fwnode);
> +
> +       return pin_node ? pin_node : ERR_PTR(-ENOENT);
> +}
> +EXPORT_SYMBOL_GPL(fwnode_dpll_pin_node_get);
> +
>  static int
>  __dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
>                     const struct dpll_pin_ops *ops, void *priv, void *coo=
kie)
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 4e3524227720a..8571c8bb71ade 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1410,6 +1410,7 @@ DEFINE_SIMPLE_PROP(post_init_providers, "post-init-=
providers", NULL)
>  DEFINE_SIMPLE_PROP(access_controllers, "access-controllers", "#access-co=
ntroller-cells")
>  DEFINE_SIMPLE_PROP(pses, "pses", "#pse-cells")
>  DEFINE_SIMPLE_PROP(power_supplies, "power-supplies", NULL)
> +DEFINE_SIMPLE_PROP(dpll_pins, "dpll-pins", "#dpll-pin-cells")
>  DEFINE_SUFFIX_PROP(regulators, "-supply", NULL)
>  DEFINE_SUFFIX_PROP(gpio, "-gpio", "#gpio-cells")
>
> @@ -1568,6 +1569,7 @@ static const struct supplier_bindings of_supplier_b=
indings[] =3D {
>                 .parse_prop =3D parse_post_init_providers,
>                 .fwlink_flags =3D FWLINK_FLAG_IGNORE,
>         },
> +       { .parse_prop =3D parse_dpll_pins, },

Keep the same order as the other table please.

-Saravana
>         {}
>  };
>
> diff --git a/include/linux/dpll.h b/include/linux/dpll.h
> index f0c31a111c304..755c36d1ef45a 100644
> --- a/include/linux/dpll.h
> +++ b/include/linux/dpll.h
> @@ -11,6 +11,7 @@
>  #include <linux/device.h>
>  #include <linux/netlink.h>
>  #include <linux/netdevice.h>
> +#include <linux/property.h>
>  #include <linux/rtnetlink.h>
>
>  struct dpll_device;
> @@ -176,6 +177,8 @@ int dpll_netdev_add_pin_handle(struct sk_buff *msg,
>                                const struct net_device *dev);
>
>  struct dpll_pin *fwnode_dpll_pin_find(struct fwnode_handle *fwnode);
> +struct fwnode_handle *fwnode_dpll_pin_node_get(struct fwnode_handle *fwn=
ode,
> +                                              const char *name);
>  #else
>  static inline void
>  dpll_netdev_pin_set(struct net_device *dev, struct dpll_pin *dpll_pin) {=
 }
> @@ -197,8 +200,20 @@ fwnode_dpll_pin_find(struct fwnode_handle *fwnode)
>  {
>         return NULL;
>  }
> +
> +static inline struct fwnode_handle *
> +fwnode_dpll_pin_node_get(struct fwnode_handle *fwnode, const char *name)
> +{
> +       return NULL;
> +}
>  #endif
>
> +static inline struct fwnode_handle *
> +device_dpll_pin_node_get(struct device *dev, const char *name)
> +{
> +       return fwnode_dpll_pin_node_get(dev_fwnode(dev), name);
> +}
> +
>  struct dpll_device *
>  dpll_device_get(u64 clock_id, u32 dev_driver_id, struct module *module);
>
> --
> 2.52.0
>

