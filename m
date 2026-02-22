Return-Path: <linux-rdma+bounces-17048-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJxLOwtgm2kmywMAu9opvQ
	(envelope-from <linux-rdma+bounces-17048-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Feb 2026 20:59:07 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCA31703DB
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Feb 2026 20:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63646300FECE
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Feb 2026 19:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA75835C188;
	Sun, 22 Feb 2026 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sP7CsShI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9A035BDB8
	for <linux-rdma@vger.kernel.org>; Sun, 22 Feb 2026 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771790322; cv=none; b=kmYYmtSKn46hw4Q4V6dE0NMX1RObb2i36DenIA2fii1xdzOhUwirMiudlsBXQSkeSH1Mj8TCIw73Iy8hWU9E2NwblvRJnTqmIQzVT193EaDn9zX0zBUXVTGEDiOL/h7EcYgwj6LscdtCw4JRT752rO07wQJKeyS4KfA/bE5F+lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771790322; c=relaxed/simple;
	bh=XbOYmoiKmvZc0TpiZ+4qaUVvKWKkSTRjdYI8od7dCLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lK0VMH59ije0XFSEpWvh4nBX7M+FIwyzZ4yQyrOsZZPkKI2eyhijCxcpGorPOAgDzqB70nYCgrsEkaGZ5jszw3isEqdplr1idzBga6GUKvsbjMpGWn6SIzcFFUbxecaRp4WwR7cH+460Hfvg7RlxBL9nfJmBX5TCtCbgZTDPhno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sP7CsShI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FBE2C2BC9E
	for <linux-rdma@vger.kernel.org>; Sun, 22 Feb 2026 19:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771790322;
	bh=XbOYmoiKmvZc0TpiZ+4qaUVvKWKkSTRjdYI8od7dCLM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=sP7CsShIa+9tBAVOpZoUIyhDovnLK/iulAF3RRMZoVAv/3wx5MN5ZaXKYHtNMN/6X
	 h9nkrDHQUcI9orrG41egzrvDkiODBKN44kR9DF1ZcZxNXMfzD/FsUR1EzZqx1/G2e6
	 Hps8rYr6+wDQY2kZw5Qcil6Ed7fCij3fXVLDUuQmDsZAE2HmlZEv5oDVRFcmfLxMQj
	 GWEf2Eh24FuxP/RRwOAiNV0Ub7QXW1LLwXcHHsuZwqBfgBSzb3lZLUW9qnfa+9/CpI
	 TKb70YzBkJCzTWqJ0O+WJ924S/wnKzc7VvJqV3dXlJ8TVP/1NMeFvxhvGazugmNAvl
	 kuU0TLvGdmU1Q==
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-89464760408so22879866d6.0
        for <linux-rdma@vger.kernel.org>; Sun, 22 Feb 2026 11:58:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWkFCqi8SNGuwLdJ9bMibLkABuODl4lF1/q9GBMKSJ++xUy5e/dNOx/k/fJkI103+uLrgdiNHN9dbRg@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj+NPr4lbZBwIyw3QEhlchVix/CNh0PXo562Jwu9+haB1wibji
	WuWiwvGrVdkifu2dnA5ycnuiLCQNyENTA/i5PfgXISv4qAuyfX9O74StPeCyP7npVWOdImtaQdK
	iiiyrjs44pFmNMRTRqcPee4xqGrrmxpY=
X-Received: by 2002:a05:6214:20ea:b0:888:fc37:f9b7 with SMTP id
 6a1803df08f44-89979c78478mr88266616d6.25.1771790321119; Sun, 22 Feb 2026
 11:58:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219130050.2390226-1-bjorn@kernel.org> <415c4922-cc8d-4e35-bbac-3a532f44d238@lunn.ch>
 <20260219160519.323041bf@kernel.org> <3b0949fa-0b05-4bce-86c0-2a7a058865a5@lunn.ch>
 <20260220131254.03874c4c@kernel.org>
In-Reply-To: <20260220131254.03874c4c@kernel.org>
From: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date: Sun, 22 Feb 2026 20:58:30 +0100
X-Gmail-Original-Message-ID: <CAJ+HfNgXqpqDYsmAa-mpHnO82aDgC7XbyVw3TmXk-ySFmGA-JQ@mail.gmail.com>
X-Gm-Features: AaiRm50dFFABjs7xMRr7bPvGJoJmWkgrR5jZgwSuGpuHDNGj6z0XXgMM_PtlaCQ
Message-ID: <CAJ+HfNgXqpqDYsmAa-mpHnO82aDgC7XbyVw3TmXk-ySFmGA-JQ@mail.gmail.com>
Subject: Re: [RFC net-next 0/4] ethtool: CMIS module diagnostic loopback support
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,vger.kernel.org,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,nvidia.com,bootlin.com,broadcom.com,marvell.com];
	TAGGED_FROM(0.00)[bounces-17048-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9CCA31703DB
X-Rspamd-Action: no action

Andrew/Kuba!

Thanks for having a look!

On Fri, 20 Feb 2026 at 22:12, Jakub Kicinski <kuba@kernel.org> wrote:

>> > Something like:
>> >
>> >   struct {
>> >      enum type;   // MAC, PHY, SFP
>> >      int type_id; // if type=3DPHY - phy id
>> >      int depth;   // counting from CPU, first loopback opportunity is =
1
>> >                   // second is 2, etc.
>> >      bool direction; // towards CPU/host vs towards network
>> >      char name[16];  // "pcs", "far", "near", "post-fec", whatever
>> >   }
>>
>> Lets see what comes from the drawing board, but i was more thinking
>> about expanding the bitmap this proposal already has, extending it to
>> other layers.
>
>IIUC the bitmap this proposal has is basically a product of
>direction x depth: [host, network] x [nearest, furthest]
>plus its scoped to SFP.

(Digging into different ways to loopback, rather than drawing board,
but here goes! ;-))

I'd agree with Jakub here, unless I'm not getting the details of what
you mean, Andrew. Sounds like we'd end up with a huge bitmap? I
suggest tweaking Jakub's idea to something like:

/* loopback.c: A new ETHTOOL_MSG_LOOPBACK_{GET,SET} */

/* Loopback layers/scope
enum ethtool_loopback_layer {
    ETHTOOL_LB_LAYER_SW =3D 0,    /* Software/Kernel stack loopback */
    ETHTOOL_LB_LAYER_MAC,        /* MAC/Controller internal */
    ETHTOOL_LB_LAYER_PCS,        /* Physical Coding Sublayer (Digital) */
    ETHTOOL_LB_LAYER_PMA,        /* SerDes / Analog-Digital boundary */
    ETHTOOL_LB_LAYER_PMD,        /* Transceiver / Module internal */
    ETHTOOL_LB_LAYER_EXT,        /* External physical plug/cable */
};

/* Loopback Direction (XXX is local/remote easier to understand?) */
enum ethtool_loopback_dir {
    ETHTOOL_LB_DIR_NEAR_END =3D 0,    /* Host -> Loop -> Host  */
    ETHTOOL_LB_DIR_FAR_END,        /* Line -> Loop -> Line  */
};

struct ethtool_loopback_layer_cfg {
    enum ethtool_loopback_layer layer;    /* ETHTOOL_LB_L_MAC, etc. */
    enum ethtool_loopback_dir direction;  /* NEAR or FAR */
    u32 lane_mask;                        /* Specific lanes */
    u32  flags;                           /* patterns? reserved... */
    bool enabled;
    char name[16];
};

struct ethtool_loopback_cfg {
    struct ethtool_loopback_layer_cfg *entries;
    u32 num_layers;
};

struct ethtool_ops {
    /* ... */

    /* Query which layers/lane-combos are physically possible */
    int (*get_loopback_caps)(struct net_device *dev,
                             struct ethtool_loopback_cfg *caps);

    /* Get current active status for all layers */
    int (*get_loopback_state)(struct net_device *dev,
                              struct ethtool_loopback_cfg *state);

    /* Set one or more layer/lane configurations atomically */
    int (*set_loopback)(struct net_device *dev,
                        const struct ethtool_loopback_cfg *cfg,
                        struct netlink_ext_ack *extack);
};

As for layers; EXT vs PMD? EXT could be a loopback plug, whereas PMD
would be CMIS, or whatever the driver detects.

Userland would be something like:

# ethtool --show-loopback eth0
Loopback Status for eth0:
  Layer: SW  | State: OFF
  Layer: MAC   | State: OFF
  Layer: PMA   | State: ON  | Lanes: 0x1 (Lane 0) | Direction: Near-End (Lo=
cal)
  Layer: PMD   | State: ON  | Lanes: 0xF (All)    | Direction: Far-End (Rem=
ote)
  Layer: EXT   | State: ON  | Detected: External Loopback Plug

# ethtool --set-loopback <dev> [layer[:lanes][:direction]] ... [off]

# # Simple MAC loopback:
# ethtool --set-loopback eth0 mac (Defaults: lanes=3Dall, dir=3Dnear)
# # Specific SerDes (PMA) lane:
# ethtool --set-loopback eth0 pma:lane0
# # Complex multi-layer (PMA Near + PMD Far):
# ethtool --set-loopback eth0 pma:0x1:near pmd:all:far
# # Disable all loopbacks:
ethtool --set-loopback eth0 off

Thoughts? Is this somewhat close to what you had in mind, Andrew?

I'm far from an expert on the details here, so the folks with more
knowledge, please chime in!


Cheers,
Bj=C3=B6rn

