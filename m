Return-Path: <linux-rdma+bounces-19301-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKZ0NC8r3WmVaQkAu9opvQ
	(envelope-from <linux-rdma+bounces-19301-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 19:43:11 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7BE3F19F4
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 19:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5F48F300ADB2
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2026 17:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C59376BCA;
	Mon, 13 Apr 2026 17:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RAC1ntsB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145F6375F8A
	for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 17:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776102155; cv=none; b=RKBL+DoC5DnJ6mYew5kIp1vUOAABxfGyKhFhNbjPFYInyVbncIh5HUVUC1r5/cnVS3FUvW/UJ9KOpci4axnF7Xf5C7O0f/8lnCvEbG8JsqLRIvrAqWC+LWeaNblbAYjmuzgwN3OJzw/1Ldu1CuA0FyZ4ahP/Gk/7vFjeggGlTVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776102155; c=relaxed/simple;
	bh=40D9/sGMozIjmtBqWMzTTl8LH1+xqFnrILKvDECrlQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfIDloUkvm3+uOf36U+/A1IvrGN+ErqkPVwX9Q5sRT6bLdhy6M9BVtVfmTDjAujCxya1ChPHdPJ730n2iHjalF+RQFGE0yb9vtJVjGw+jZmYjDAZlvW0TPBC5Rl0v/ztlzQOPW0ZtZLDrR73Y1UxNZmvo0ffCg+Q3jIhZj4fMr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=RAC1ntsB; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50b2b289925so39063771cf.2
        for <linux-rdma@vger.kernel.org>; Mon, 13 Apr 2026 10:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776102150; x=1776706950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9P15ZvH/WcKMIIoGY4JlV5XMiItkZb3l1DLJfQHNL7c=;
        b=RAC1ntsB5OQ3J+H2SB5xfnKvep+R3Ii8tdUccmYgGCd1Qpo5knRA9Omk6QGgFOxFOA
         WnXOvMgpvA4oDFs4pEJWkNB78hKbt3bkBnuuCt8p0XZ3W01Rj7+bqNh9OwohDWFA0hAh
         RMZTM3mZSOacPNojNciMbGiMrI0OP09nz3u4DaPTPpMkSFfKq2wj6HPNbRfZ5IB3lKMK
         m1uBvpYBN1b3VJK+WaF8ucbqV71I2qbEZiLO96Hcq7OF5P/jDfQ1e3bsvQFSjUnvs39x
         /jFByl2xuZtqfLfUmyBqLJ1VS+5PS4pZE89kVhQmk8MxVBWAu6oAj/07SMdRDeCnZzbm
         ldzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776102150; x=1776706950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9P15ZvH/WcKMIIoGY4JlV5XMiItkZb3l1DLJfQHNL7c=;
        b=h4Pjs0yk1YZVTKQNq0w7wJvpfjwybXzS/Lo5cO0B15h+HP7emyNB4tUsPhODeyGjYh
         8upfOhxh/JL+ElgolFYh3Nr9tMx50JO1FzODBJ6gUhlx9qtxdx5mEIa3mXmT2uveYErt
         pV6BVTTUnOsDFMoGt2ox3RBmt2ktsyRr/RNikDOMaeR+16rUGCs+ABTxvgj89sqzLTqh
         /ekyY5+VuL8hWb9kWKlI91gvWAuvGnWPklmJhPcbr8a56A7i0D+/9Rzn93HMVETuNEL0
         A1vY7c24ybzAW5d7aL+eCB3OhjUIT2nLVLYYA6hLmo9I/Vb6hKWk5EInwiEWC7LuR8xd
         M6pQ==
X-Forwarded-Encrypted: i=1; AFNElJ+IznKxNq5F/MX8In49b3iH3JZev+0EjGrtkrXa1lik/YxOpz+F8m0Z4fbJO2np0Ifrus0/EuN+d36M@vger.kernel.org
X-Gm-Message-State: AOJu0YxZLxR9AYuDykg7+ZyAmQ4kdx84U+ZwVesePQ0DSFGipe6bInwN
	dLzcyo/wunFwX3bHg/jS+kV2lSXq4aLhrev2nqOefymQU76gbVV6uw2oR/Ts+FqkB5E=
X-Gm-Gg: AeBDievjJK6hkV9cP4Z6y5cAxuRjjPyI3E8bjxtR/oKe+Y0zWFGwUm7fmX9gA58ysXu
	5+PQAdYLKezLwWe6sTGubc2lSS5aIzXsJ8uYWdVGQ4Z1v2VvjZ9P4vOBObTQOmOJtJnon01YA2a
	rVJ6ze9NQqlnKQ5iEkUq7CJj0t312tSaN931qxmgJNq93I0cko6QMbvd/0Ird5/XyKuJVZ9KodY
	jQ/jK3OahVdWW6jfkrrG6p3uP5on7WzyzvKGFE5kuA31GsxxNo/db+fhGHBH/Dc/QdgSD8AZ0Hv
	eMBSciartDUG9atIFpERiTc25pBP639oGye9m0SfQl9X3d8WJjiRCj+dTLuNArMZRjVoiF+LSQ/
	swWMVYeaqmL9hKT/IU7oh00IXW/x62APWloriS4D9+wnkOObbImgk2pASB21KGAuJhfU77Eci3U
	kaCX5Yw47hxqWYD/9dm4lsLXfymI0ij2GPW4VRCPcgojcmG/+qKtqVQEfvK5wvCXn/l0kW30tXD
	R/TJg==
X-Received: by 2002:a05:622a:2305:b0:509:1009:e7a6 with SMTP id d75a77b69052e-50dd5ba317fmr229021571cf.43.1776102149554;
        Mon, 13 Apr 2026 10:42:29 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac84a180a2sm104198376d6.15.2026.04.13.10.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 10:42:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wCLIq-00000005q47-1UXO;
	Mon, 13 Apr 2026 14:42:28 -0300
Date: Mon, 13 Apr 2026 14:42:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jiri Pirko <jiri@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	syzbot <syzbot+03393ff6c35fd2cc43de@syzkaller.appspotmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [rdma?] WARNING in ib_dealloc_device
Message-ID: <20260413174228.GQ3694781@ziepe.ca>
References: <69dc3310.a00a0220.475f0.0018.GAE@google.com>
 <20260413154353.GK21470@unreal>
 <PH7PR12MB66356E0176748BFFF081D9B4B0242@PH7PR12MB6635.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR12MB66356E0176748BFFF081D9B4B0242@PH7PR12MB6635.namprd12.prod.outlook.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-19301-lists,linux-rdma=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:dkim,ziepe.ca:mid];
	DMARC_NA(0.00)[ziepe.ca];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,03393ff6c35fd2cc43de];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: CC7BE3F19F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 04:12:09PM +0000, Jiri Pirko wrote:
>    Will check it tmrw

I fed it to Claude and after 40 mins it is stumped too.. It should not
be possible for this to happen.

__ib_unregister_device() always calls down to disable_device()

Which always removes it from all visibility, drives the refcount to 0
and then cleans the xarray:

	xa_for_each (&device->compat_devs, index, cdev)
		remove_one_compat_dev(device, index);

Then ib_dealloc_device() checks it is empty:

	WARN_ON(!xa_empty(&device->compat_devs));

At the point the xa_for_each is run there should be no cocurrent
threads that can see the device. The refcount is zero, it was removed
from the xarray. The add_one_compat_dev() is never called in an
condition that could see a stray device.

It should not be possible for the compat_devs of a 0 refcount
ib_device removed from the device's xarray to be mutated between those
two checks.

One notable thing about xarray is you can have a xa_for_each() iterate
over nothing and also have xa_empty() be false. Maybe that is
happening here, but I could not find any way that should happen.

I guess just keep watching this and see if it happens ever again. Add
some debugging to print out the xarray. Maybe the way we are using
xarray is unexpectedly triggering a stray 0 entry?

Jason

diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index 4c174f7f1070cb..592e29b0cccf39 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1020,6 +1020,71 @@ static void remove_compat_devs(struct ib_device *device)
 
 	xa_for_each (&device->compat_devs, index, cdev)
 		remove_one_compat_dev(device, index);
+
+	if (!xa_empty(&device->compat_devs)) {
+		struct xa_node *node;
+		void *head;
+		unsigned int i;
+
+		dev_warn(&device->dev,
+			 "compat_devs xarray not empty after removal!\n");
+
+		xa_lock(&device->compat_devs);
+		head = xa_head_locked(&device->compat_devs);
+		dev_warn(&device->dev, "  xa_head=%px xa_flags=%x\n",
+			 head, device->compat_devs.xa_flags);
+
+		if (!xa_is_node(head)) {
+			/* Single entry at index 0 stored directly in head */
+			if (xa_is_zero(head))
+				dev_warn(&device->dev,
+					 "  head[0]: zero entry (leaked xa_reserve)\n");
+			else if (!xa_is_internal(head))
+				dev_warn(&device->dev,
+					 "  head[0]: pointer %px\n", head);
+			else
+				dev_warn(&device->dev,
+					 "  head[0]: internal %px (%lu)\n",
+					 head, xa_to_internal(head));
+		} else {
+			node = xa_to_node(head);
+			dev_warn(&device->dev,
+				 "  node %px shift %d count %d nr_values %d\n",
+				 node, node->shift, node->count,
+				 node->nr_values);
+			for (i = 0; i < XA_CHUNK_SIZE; i++) {
+				void *entry = xa_entry_locked(
+					&device->compat_devs, node, i);
+
+				if (!entry)
+					continue;
+				if (xa_is_zero(entry))
+					dev_warn(&device->dev,
+						 "  slot[%u]: zero entry (leaked xa_reserve)\n",
+						 i);
+				else if (xa_is_sibling(entry))
+					dev_warn(&device->dev,
+						 "  slot[%u]: sibling -> slot %lu\n",
+						 i, xa_to_sibling(entry));
+				else if (xa_is_retry(entry))
+					dev_warn(&device->dev,
+						 "  slot[%u]: retry\n", i);
+				else if (xa_is_node(entry))
+					dev_warn(&device->dev,
+						 "  slot[%u]: node %px (deeper tree)\n",
+						 i, xa_to_node(entry));
+				else if (!xa_is_internal(entry))
+					dev_warn(&device->dev,
+						 "  slot[%u]: pointer %px\n",
+						 i, entry);
+				else
+					dev_warn(&device->dev,
+						 "  slot[%u]: unknown internal %px\n",
+						 i, entry);
+			}
+		}
+		xa_unlock(&device->compat_devs);
+	}
 }
 
 static int add_compat_devs(struct ib_device *device)

