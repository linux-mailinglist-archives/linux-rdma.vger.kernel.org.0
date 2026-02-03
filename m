Return-Path: <linux-rdma+bounces-16383-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBcGOzVugWkeGQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16383-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 04:40:37 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 973FED430A
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 04:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1F654304DEB5
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 03:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398B5322B81;
	Tue,  3 Feb 2026 03:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A15Hcc+r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0B3214A64;
	Tue,  3 Feb 2026 03:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770090026; cv=none; b=pSzJ59fWU5/xTttDYuN/1wI+w01VdLzqSgsNVKi0Uj6QbVHohhzUbas2yTQ9l//5fMiJIQgF7V0paLhhFXPDQZLwaRj7fbl/GFnIU4ZCwA8cAxz0UFXevBjdNT3ADbCRePdH6QWVvulTevLJ7SFoTVACeGTNvFuBqBHBqQcV1PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770090026; c=relaxed/simple;
	bh=eVjGccF/g6Fb0gixvi5Zf/nFMF5+9n8M9E2Vh1rOWRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOuCfw/AIXY+xcoxsQMxqO+8AqZrnYFABl6U34TLmN8xflAXszqq6Wh4tLc7PUxoSvKLZ8gCVY1dKFkPQIIggV5VNa/mOo1aea5g1BDYk2HCNTgauO/c65e9Mj8ejUiXDvfafGvB/b/HcaeTjlF496rvyuP7rkOsOPOt2MEh1RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A15Hcc+r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6106CC116D0;
	Tue,  3 Feb 2026 03:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770090025;
	bh=eVjGccF/g6Fb0gixvi5Zf/nFMF5+9n8M9E2Vh1rOWRY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A15Hcc+rku6h1K4MXt1S1nDBp7k171XwgUUpJBNaeyrxjgjMq39cvYZgVv6DUBeQ+
	 A/xeO+BPe156UKLeC7pR+J2sZDIvB9FQAwFDperq9e0nq4GBrDr67Oxz9KyFLDMrRW
	 KQxYbPyiInnNSZnqKcpyr1tV4tDGFRXIl0ig44LmdoTz/eYHOPOfJCgAHXprnT1gVY
	 4BpXAoT9Pi6TIwk6DAMti4Q0tUmxaRkhBTg/Qt9Q56mO5/oQHv28tgUwz+jE8Q4phd
	 OsTU8EeY/QBnJRRvyvBYh9inUvqiP3L8SKYqs7aMbOxYBKag1H78020PySRtfaS0nK
	 lKqpV3JWQtY6A==
Date: Mon, 2 Feb 2026 19:40:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed
 <saeedm@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>, Mark Bloch
 <mbloch@nvidia.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
 <moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
 <cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Randy Dunlap
 <rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, Krzysztof
 Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH net-next V7 01/14] documentation: networking: add shared
 devlink documentation
Message-ID: <20260202194023.412bb454@kernel.org>
In-Reply-To: <20260128112544.1661250-2-tariqt@nvidia.com>
References: <20260128112544.1661250-1-tariqt@nvidia.com>
	<20260128112544.1661250-2-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	TAGGED_FROM(0.00)[bounces-16383-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,redhat.com,lunn.ch,davemloft.net,gmail.com,resnulli.us,lwn.net,nvidia.com,kernel.org,vger.kernel.org,infradead.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 973FED430A
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 13:25:31 +0200 Tariq Toukan wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Document shared devlink instances for multiple PFs on the same chip.

> diff --git a/Documentation/networking/devlink/devlink-shared.rst b/Documentation/networking/devlink/devlink-shared.rst
> new file mode 100644
> index 000000000000..74655dc671bc
> --- /dev/null
> +++ b/Documentation/networking/devlink/devlink-shared.rst
> @@ -0,0 +1,95 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +============================
> +Devlink Shared Instances
> +============================

Shouldn't the length of the ==== lines match the title length?

> +Overview
> +========
> +
> +Shared devlink instances allow multiple physical functions (PFs) on the same
> +chip to share an additional devlink instance for chip-wide operations. This
> +is implemented within individual drivers alongside the individual PF devlink
> +instances, not replacing them.
> +
> +Multiple PFs may reside on the same physical chip, running a single firmware.
> +Some of the resources and configurations may be shared among these PFs. The
> +shared devlink instance provides an object to pin configuration knobs on.
> +
> +The shared devlink instance is backed by a faux device and provides a common
> +interface for operations that affect the entire chip rather than individual PFs.
> +A faux device is used as a backing device for the 'entire chip' since there's no
> +additional real device instantiated by hardware besides the PF devices.

There needs to be a note here clearly stating the the use of "shared
devlink instace" is a hack for legacy drivers, and new drivers should
have a single devlink instance for the entire device. The fact that
single instance is always preferred, and *more correct* must be made
very clear to the reader. Ideally the single instance multiple function
implementation would leverage the infra added here for collecting the
functions, however.

> +Implementation
> +==============
> +
> +Architecture
> +------------
> +
> +The implementation uses:
> +
> +* **Faux device**: Virtual device backing the shared devlink instance

"backing"? It isn't backing anything, its just another hack because we
made the mistake of tying devlink instances to $bus/$device as an id.
Now we need a fake device to have an identifier.

> +* **Chip identification**: PFs are grouped by chip using a driver-specific identifier
> +* **Shared instance management**: Global list of shared instances with reference counting
> +
> +API Functions
> +-------------
> +
> +The following functions are provided for managing shared devlink instances:
> +
> +* ``devlink_shd_get()``: Get or create a shared devlink instance identified by a string ID
> +* ``devlink_shd_put()``: Release a reference on a shared devlink instance
> +* ``devlink_shd_get_priv()``: Get private data from shared devlink instance
> +
> +Initialization Flow
> +-------------------
> +
> +1. **PF calls shared devlink init** during driver probe
> +2. **Chip identification** using driver-specific method to determine device identity

This isn't very clear.

> +3. **Get or create shared instance** using ``devlink_shd_get()``:

Just "Call ``devlink_shd_get()`` with the identifier constructed in
step 2" (?) and then have the points below explain that it gets or
recreates

> +   * The function looks up existing instance by identifier
> +   * If none exists, creates new instance:
> +     - Creates faux device with chip identifier as name
> +     - Allocates and registers devlink instance
> +     - Adds to global shared instances list
> +     - Increments reference count
> +
> +4. **Set nested devlink instance** for the PF devlink instance using
> +   ``devl_nested_devlink_set()`` before registering the PF devlink instance
> +
> +Cleanup Flow
> +------------
> +
> +1. **Cleanup** when PF is removed

"``.remove()`` callback for a PCIe device is called"

> +2. **Call** ``devlink_shd_put()`` to release reference (decrements reference count)
> +3. **Shared instance is automatically destroyed** when the last PF removes (device list becomes empty)
> +
> +Chip Identification
> +-------------------
> +
> +PFs belonging to the same chip are identified using a driver-specific method.
> +The driver is free to choose any identifier that is suitable for determining
> +whether two PFs are part of the same device. Examples include:
> +
> +* **PCI VPD serial numbers**: Extract from PCI VPD
> +* **Device tree properties**: Read chip identifier from device tree
> +* **Other hardware-specific identifiers**: Any unique identifier that groups PFs by chip
> +
> +Locking
> +-------
> +
> +A global mutex (``shd_mutex``) protects the shared instances list during
> +registration/deregistration.
> +
> +Similarly to other nested devlink instance relationships, devlink lock of
> +the shared instance should be always taken after the devlink lock of PF.

of an instance, not a PF

> +
> +Reference Counting
> +------------------
> +
> +Each shared devlink instance maintains a reference count (``refcount_t refcount``).
> +The reference count is incremented when ``devlink_shd_get()`` is called and
> +decremented when ``devlink_shd_put()`` is called. When the reference count
> +reaches zero, the shared instance is automatically destroyed.

I think AI went too far with the text generation here, this is very
obvious from the previous sections.
-- 
pw-bot: cr

