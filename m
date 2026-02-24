Return-Path: <linux-rdma+bounces-17111-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EN7RIW19nWk1QQQAu9opvQ
	(envelope-from <linux-rdma+bounces-17111-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 11:29:01 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A9406185552
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 11:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9152A300D4E6
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Feb 2026 10:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BD53783C7;
	Tue, 24 Feb 2026 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zy/bTAae"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A959F377541
	for <linux-rdma@vger.kernel.org>; Tue, 24 Feb 2026 10:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771928932; cv=none; b=thPB+mcgl5iQ5hYqGRbHZ/S4kfgLlFJsZoecPddM8ojb5lrTjRWsSHI+3MAk7RRz+nCdwFOz2YmR5Z+hPWpwSKc9qZuyltryJkUm/QvoR4XMtsZ+802+A2gQogw+RQ3Xdss9Xzv7h5u5vcSdr/umhUhNlkgowlIj7Llch+36MSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771928932; c=relaxed/simple;
	bh=EC6UQV3bJ4mzD11DcaayRO4aNhv6kxZDN1L0AFj43xI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Na5DgO4VBEQtoLKjbxO0ij4amH6GdcDzo+Xoz1QSTMbgOK7T7JoKD03gCKvfFZrjHHPDH0CPciHSMqTfZU4KE/MOjTEU/Ra3auEz2sJuw6om0disSajwyI2pxUMYE50mJQOtHqD7UHdogOkhewFIdYmpm7qCZIpO2P6PjM/GSkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zy/bTAae; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6EDC2BCB4
	for <linux-rdma@vger.kernel.org>; Tue, 24 Feb 2026 10:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771928932;
	bh=EC6UQV3bJ4mzD11DcaayRO4aNhv6kxZDN1L0AFj43xI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Zy/bTAaewfRBXica+9bZCeVZ2Zy9kV0cxnuRN9PJmCHj6nbaYZI1dvqZ+oJE/TRqk
	 JuRep1ZCygbA7gsaPgco8ucdywtiCUqjaPueKOtgWaF8G0CBy/qpceoaRSyjnqnSMG
	 xwSGD6+l4rV0LrrF57j9fwbrAaFOwR+IBAze1B82DtkmqJDwGdXhHQNDxo4q8rL5Z6
	 hqAzfx56a4wLUeBUf91E2l26TJFGIEO3fKEo9eLrqusCA4tImyo/Gf43YwnHF4weBt
	 Xcl3zQgq+fVy4JeVVv0VIBNSd81q6hT3Ib5Ei/L/bkW78Jq4Ea9f1s89i+AKcZPjaw
	 O2s8nOKLeia6A==
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8951c720496so32003246d6.2
        for <linux-rdma@vger.kernel.org>; Tue, 24 Feb 2026 02:28:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCMLUgIdrBPhZK6DI6Eq/l4bvJKHEa0yqU7CJwoGL6fhLZG1ZJ7FLTnoC0pBTays2NFo5BSjsT7eYj@vger.kernel.org
X-Gm-Message-State: AOJu0YzraKuKxzKhMZZRm5er2eYliIUWjWicvEJApMWFjGQIMyM9+JLt
	V90z4djJ4Cq9stAP8KUbuJjlBc8aef2/PRsevcpSe4TjBpI42RadZVRz+CUgKadi0qYeflKEyfr
	PFbKlhTNbsDSRnmcGDPIJQM9UM/0/Ggo=
X-Received: by 2002:a05:6214:483:b0:894:3c57:dbc0 with SMTP id
 6a1803df08f44-89979d384c8mr174072396d6.39.1771928931351; Tue, 24 Feb 2026
 02:28:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219130050.2390226-1-bjorn@kernel.org> <415c4922-cc8d-4e35-bbac-3a532f44d238@lunn.ch>
 <20260219160519.323041bf@kernel.org> <3b0949fa-0b05-4bce-86c0-2a7a058865a5@lunn.ch>
 <20260220131254.03874c4c@kernel.org> <CAJ+HfNgXqpqDYsmAa-mpHnO82aDgC7XbyVw3TmXk-ySFmGA-JQ@mail.gmail.com>
 <20260223150401.7993b11a@kernel.org>
In-Reply-To: <20260223150401.7993b11a@kernel.org>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Tue, 24 Feb 2026 11:28:40 +0100
X-Gmail-Original-Message-ID: <CAJ+HfNjmRjr6VtRijmN9=4zPwxstw9B8D-_XVn3hwJzNHka1Jw@mail.gmail.com>
X-Gm-Features: AaiRm53eAlOKtfwmff8WmWox0Kqc95C58nl0cmy1zmZHOMcSH5LSueTKo690ffM
Message-ID: <CAJ+HfNjmRjr6VtRijmN9=4zPwxstw9B8D-_XVn3hwJzNHka1Jw@mail.gmail.com>
Subject: Re: [RFC net-next 0/4] ethtool: CMIS module diagnostic loopback support
To: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Michael Chan <michael.chan@broadcom.com>, Hariprasad Kelam <hkelam@marvell.com>, 
	Ido Schimmel <idosch@nvidia.com>, Danielle Ratson <danieller@nvidia.com>, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.01 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,nvidia.com,lunn.ch,broadcom.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-17111-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: A9406185552
X-Rspamd-Action: no action

Good feedback, Kuba! ...more thinking...

On Tue, 24 Feb 2026 at 00:04, Jakub Kicinski <kuba@kernel.org> wrote:
...
As a reference, there's a v2-ish version here (API I suggested +
netdevsim plumbing) [1].

What I discovered was that the "layer"/IEEE abstraction I suggested
didn't even fit nicely with the CMIS module loopback work -- I had to
split PMD into PMD-HOST/PMD-MODULE to fit the CMIS spec, which felt
like a hack.

I've obviously taken too high-level a "PCIe device" view of the world.
Looking at Maxime's slides from netdev 0x17 [2] reveals a more
complicated world; multiple PHY-like things in the path (onboard PHY,
module, external PHY, ...). My model doesn't cover what Maxime
outlines.

Instead, like Jakub hinted at, userspace should reason in terms of
"loopback entities" (or IDs) that correspond to "places where loopback
can be applied=E2=80=9D, not in terms of PCS/PMA/PMD topology.

A loopback entity would have:
    an ID / type (which matches a driver),
    a direction,
    an optional descriptive name.

Reiterating what Jakub said earlier, using hwstamp-source as a
precedent, you could imagine something like:

  struct {
     enum type;   // MAC, PHY, SFP
     int type_id; // if type=3DPHY - phy id
     int depth;   // counting from CPU, first loopback opportunity is 1
                  // second is 2, etc.
     bool direction; // towards CPU/host vs towards network
     char name[16];  // "pcs", "far", "near", "post-fec", whatever
  }

I'm not sure that depth/name are actually useful here.

Concretely, that could look like this in ethtool:

  /* What kind of kernel object owns this loopback. */
  enum ethtool_loopback_owner {
          ETHTOOL_LB_OWNER_MAC,       /* struct net_device / MAC driver */
          ETHTOOL_LB_OWNER_PHY,       /* struct phy_device (phylib PHY) */
          ETHTOOL_LB_OWNER_MODULE,    /* module / SFP driver, e.g. CMIS */
  };

  enum ethtool_loopback_dir {
          ETHTOOL_LB_DIR_HOST_LOOP_HOST,
          ETHTOOL_LB_DIR_LINE_LOOP_LINE,
  };

  /* One "loopback entity" associated with the netdev. */
  struct ethtool_loopback_entry {
          u32 id;                               /* per-netdev */
          enum ethtool_loopback_owner owner;
          u32 depth;                            /* ??? */
          enum ethtool_loopback_dir direction;  /* enum ethtool_loopback_di=
r */
          bool  enabled;
          char  name[16];                       /* ??? "mac",
"phy-pcs", "module-far", ... */
  };

  /* Aggregate for GET: list all possible endpoints + their status. */
  struct ethtool_loopback_state {
          struct ethtool_loopback_entry entries[16];
          unsigned int n_entries;
  };

From a driver POV:
* The MAC driver can add its own MAC-level loopback entity (owner =3D
  MAC).
* If there is one or more phydevs, it can call into a phylib helper
  (e.g. phy_get_loopback_state()) to append PHY entities (owner =3D
  PHY).
* If there is a CMIS module, it can append its entities (owner =3D MODULE).

# ethtool --show-loopback eth0
Loopback endpoints for eth0:
  id  owner  depth  direction          name       enabled
   0  mac       1   host->loop->host   mac        off
   1  phy       2   host->loop->host   phy-pcs    on
   2  module    3   line->loop->line   cmis-far   off

# Enable endpoint 2
ethtool --set-loopback eth0 id 2 on


Does this model make more sense, especially for the multi-PHY / CMIS
cases Maxime described?


Bj=C3=B6rn

[1] https://github.com/fb-bjorn/linux/compare/master...fb-bjorn:linux:ethto=
ol-loopback-rfc-v2
[2] https://netdevconf.info/0x17/docs/netdev-0x17-paper2-talk-slides/multi-=
port-multi-phy-interfaces.pdf

