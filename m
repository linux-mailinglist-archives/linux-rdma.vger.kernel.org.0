Return-Path: <linux-rdma+bounces-19596-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CK8LBiSq72kCDwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19596-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 20:25:40 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 810D247888C
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 20:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2648130234E6
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 18:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3BA3EB7FA;
	Mon, 27 Apr 2026 18:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="OMa4dji2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C573D6CD4
	for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2026 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777314312; cv=none; b=lSDqlKijqeEitaXWVCljvqb40vOMdXBYAj5MZ5akFmRcz3iJq2qCcl91hnY5pxSuRSOPMIQg2CTwmp19sdsrnY3GpAF2JxKZNnmrfbnWDDM2sb9AWaFElPQ7SaoYxd0gW56Am64JnQcQDLO8e98l9GdItDVX+if6kdy1S8akpZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777314312; c=relaxed/simple;
	bh=x8daYy/xe2IGqkndE63c9mrqTq6cO/rv1/64decL3Uk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LXusQ3VzPkJ9kkP6U2CZNiljEy8R8HxztKPIPe0Z4M2oBKlFBkF60zGLi6Tld1kfP3v5oiUwlYHVMmA3A2sPQyLV5QBb5WI4ufuoyS6jUpQ3RxKVWSepR5nzibZ/NxDEGQx4LIpFScn/dEUwenvfxYHiEJ4XYTDEfNNJbZZ/h3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=OMa4dji2; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2d832f2f44cso8904474eec.0
        for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2026 11:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777314309; x=1777919109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r62aUJ0jnce9kgdNQ/Nlm4it1uU6lIZXN3jr7p6GKXA=;
        b=OMa4dji2yoscdggFxpN6U1TI4K52pVo09e7PLvdqfYoHchFET8ZQ/r3sYI0HV7ec5+
         +Y4eaiWG7C64TVvv0EHXv/f9nRtmHOLhPbK1f63eXYELE0fPHOsjfGoZA/OSRQHMUbwz
         t8aGKIIO85IOH66a9b4RUbG/LZE90dqCPGBqQTStTOVdQzQRuOGIpqbo7+tIOKTAWg6g
         2C+TKUXsxqnMULOwBugiaB6/dSonbClcx2EGhBESeTDkZVrIs4EIHFhw0CyB/j4xVCpm
         MtxQ9vGTsS3x+EbJZ+sb0Qk6ApN/Zx0Y2+L5gBoKX2hTNBCwjS81oBswoIRJkC9og8xo
         OxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777314309; x=1777919109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r62aUJ0jnce9kgdNQ/Nlm4it1uU6lIZXN3jr7p6GKXA=;
        b=rTjP9Dn997h31XC2uRIhNOfhX1qP2mXntS+6yi/02nLDEqqbtvHeddp83YItEMXpTr
         zi/67p1mwR9udJIWqgNx4Mc6gNNE7s6W2UZX0fm0Mxi6OPb6ew0ub+ZpaXZSL+DTq74X
         4Yff+sVTQ3FlKI3wfpDdxOZcu6ikI4mt3mVdou+XjZ3HU6rgy7bQwvwa0vZZYWSqobv3
         baxCk4RwZN6Hvx+TX0JnrPkcmns11/nvN3iYTY5j+4qN1/929uj119ibEBZnOoxvjYx0
         3XBWoWqClKU+l0ql3TTBkXIq1y4sBW6HZmc5J/L2RuRtFSx7qHOunpknJKpr1JzJWFBB
         Yh4w==
X-Forwarded-Encrypted: i=1; AFNElJ/I/I6ow5Uhf6n5D/tldvPdBoRLAEFyrsrMWQduyNoXUKl8QVScfAbIoVGp8+yg864NZwliC1XWbCN+@vger.kernel.org
X-Gm-Message-State: AOJu0YxqEQO9T8tsrZmxzyJ379M1IgLYsVlFjGg71OQo34VPJntq+fTD
	9rRJy1x5kn1CXdi3ZkvM8Sx0x5U7vQysOMUAfDdh3XcWgkgH3kpu0CQrwokgcLQ0YI0=
X-Gm-Gg: AeBDiet4Oklo09tFpZaFNiw88hLVIZ41wRXVwmhVLhHPqxn/8fpE3vi4BViNmLSn8Js
	NZz9pDuKBcYphACHi1jxQEfVKna9yfIIQ5S8R5RT49XgmqXpiRcNCYb3hD9tu+hMyqbWS+3OocK
	rq7An7i4Y4gE8J4ZQZJZ9iLJp+aVgfDIASrxrvqirUpdVHxqbsKHVWJmgNwm2OI54bTOTAM6He9
	EkljZdSUzxPrBtD57lTgfK4G0dHfHNjG/ArUHckI78USJr+DDhVV3QK7sw64OWTy0DfpdhrOoaT
	wWhW9J4UTTa7em06W1AQZDqZPYhUaQxvM4az2TZfj/30w+j69ConSqSOaFdOJU9/Ij5XnvVdCV/
	TpgY3Canp6Ke3/g1i80p2XRtHAUnFxaPCS3fqRWoSjehK6WvxyEht4OVKpG9IN4RtA1qxO+ZLUN
	0++iB6WdA/kLvh/Vot9YRFI8s0qhDgg4KdYgeE2WWcx1pWNQ==
X-Received: by 2002:a05:7300:fd15:b0:2d0:239a:23cb with SMTP id 5a478bee46e88-2ed09b7d31bmr51555eec.16.1777314308449;
        Mon, 27 Apr 2026 11:25:08 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d8aed43sm43833183eec.26.2026.04.27.11.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 11:25:08 -0700 (PDT)
Date: Mon, 27 Apr 2026 11:25:05 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Chiara Meiohas <cmeiohas@nvidia.com>
Cc: <leon@kernel.org>, <dsahern@gmail.com>, <michaelgur@nvidia.com>,
 <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
 Patrisious Haddad <phaddad@nvidia.com>
Subject: Re: [PATCH v2 iproute2-next 1/4] rdma: Update headers
Message-ID: <20260427112505.684c21f3@phoenix.local>
In-Reply-To: <20260330173118.766885-2-cmeiohas@nvidia.com>
References: <20260330173118.766885-1-cmeiohas@nvidia.com>
	<20260330173118.766885-2-cmeiohas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 810D247888C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,nvidia.com,vger.kernel.org];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19596-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,phoenix.local:mid,networkplumber-org.20251104.gappssmtp.com:dkim]

On Mon, 30 Mar 2026 20:31:15 +0300
Chiara Meiohas <cmeiohas@nvidia.com> wrote:

> From: Michael Guralnik <michaelgur@nvidia.com>
>=20
> Update rdma_netlink.h file up to kernel commit dbd0472fd7a5
> ("RDMA/nldev: Expose kernel-internal FRMR pools in netlink")
>=20
> Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
> Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
> Reviewed-by: Chiara Meiohas <cmeiohas@nvidia.com>

The upstream macro names changed, the iproute2 build is broken after
current headers sync.

In file included from res.c:7:
res.h: In function =E2=80=98_res_frmr_pools=E2=80=99:
res.h:203:26: error: =E2=80=98RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET=E2=80=99 un=
declared (first use in this function); did you mean =E2=80=98RDMA_NLDEV_CMD=
_FRMR_POOLS_GET=E2=80=99?
  203 | RES_FUNC(res_frmr_pools, RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET,
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
res.h:56:44: note: in definition of macro =E2=80=98RES_FUNC=E2=80=99
   56 |                 _command =3D res_get_command(command, rd);         =
                      \
      |                                            ^~~~~~~
res.h:203:26: note: each undeclared identifier is reported only once for ea=
ch function it appears in
  203 | RES_FUNC(res_frmr_pools, RDMA_NLDEV_CMD_RES_FRMR_POOLS_GET,
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
res.h:56:44: note: in definition of macro =E2=80=98RES_FUNC=E2=80=99
   56 |                 _command =3D res_get_command(command, rd);         =
                      \
      |                                            ^~~~~~~

