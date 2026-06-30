Return-Path: <linux-rdma+bounces-22605-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id D+4OAcr7Q2olmwoAu9opvQ
	(envelope-from <linux-rdma+bounces-22605-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 19:24:26 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C65E6E6E19
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 19:24:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ptT1TlCm;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22605-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22605-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D2C8307EDEB
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 17:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2FE3DC4BC;
	Tue, 30 Jun 2026 17:23:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337DE3B635F
	for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2026 17:23:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840203; cv=pass; b=gtWB0iQs/MQBfLwW5+5KaI+Ryk71hhNJPr45U6fzYeyLPQncX0DLFD/1w1wO2mMJo2lQiKcj6PKWhbv0pyhmGpQtVKrc0/Tk+ezi36apKuzJTM3D/BkF7sv+8GvM7Kv4yC1UTXkB8tvGgNqDBh4/pXM9cd8AwCqlab4SKLrqWs8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840203; c=relaxed/simple;
	bh=iCE7YWnv6fQepLHz0kGRAVYarDF7N3eG4MYTzFP8WQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAggzUtyTzHA0M60bExnQ4YiviWemvO5TdYemjASiEovz1vib8zrFtrgWd53mHZNFsDtFw77ttdUWBDCQR3ikGFr2x5i5sbMu3+/sDK4JyOoxoXPDaOlTl7Fbf5UQwJpGQP4knsAQpZIh6wgwz0krJ9mNW72jHBWGyy3DC0OesI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ptT1TlCm; arc=pass smtp.client-ip=209.85.210.54
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e6b5737bb2so4976958a34.1
        for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2026 10:23:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782840197; cv=none;
        d=google.com; s=arc-20260327;
        b=rFpW7MSbwZqibXE3aYMoT6fY/hkVOe36kUHkY3wKiUTGdBIrlvPOAR/qv6t9VL6512
         kzi/sQ3Z1hv/XVkzcN3opH2yEtpnBtqD5BjCh42rsfa+/p1I2JveMQpwCvC+gOvN1diF
         Hk5rMCBrmizsUberUtoObyP92IPO7/iIQVPmOH3UCI8qD+Ds6Zdkp/+0sjSMVn5S4nKf
         Is4JWVLsbrWyucmOOuLFgHAoLTvwCg0f4ONe9r8RupQNCYDUAP0gmJx+JnH3TDj3EI7B
         uzFiqm9ZJ6NWao8YRA+gm3dW1OF3l5vRENlmiGCSQgfNG/MSLCZHv85OhueFpXnVz/Ko
         RxVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iCE7YWnv6fQepLHz0kGRAVYarDF7N3eG4MYTzFP8WQY=;
        fh=3S7WsFupyKSyFco3mpqMKcifrqlZNFLu7GKqnVIpTyg=;
        b=ocQd/bQHcrhBG3/ogapFB286EGdAjLj9brpFfD9BJu+LWOjdQEOYqRkoLknS/oyK2/
         IiMlTwrtcjhp1qOc6OT5StMTrjm0kvBgvGRRxe8flE6yxG5aAsscN/IZxeG5sqPOBlFy
         cXAkPNuCgk6JC3iHAd+OhSHQCqBcC1lQ0TgetmO13CZd6V/Vt5K2aS8+GHpDiVR9GsUZ
         kMQsMMrAbIQF/f9QLbu3cyW7K7NeRswKa/ziJ7RmAX8EU4Mtlh/Qq67eG86giR6GOLrs
         omcbLWTG+sXTdNCYch8nMMyVKIwfhuFWhN8uMXdxX2YV5a/XpF+tZN2+wyfmfnGs3qo5
         2bJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782840197; x=1783444997; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iCE7YWnv6fQepLHz0kGRAVYarDF7N3eG4MYTzFP8WQY=;
        b=ptT1TlCmywf2fzi/H6xUFspBNVufSziZaKHT70u0QSfPsBcl2p8UVJfqOE/sUNl4q/
         eDj0jhvd+3epcy2+Ta+uhYJR63GWqRzlE1q9hruFfmxRwUYbRRpSNWT9suqz4oseWIqS
         lRX2Bs9EVYOuBlbR75cDlEeURHCdqMT/cl30tPlALDeuPdBh64u0WZEIHGELrz6S2fN0
         80wTSob3ARMmiB+aviaNWBjIcy3d0kR5XBzbGUrOLftVlr9wRN01JBVbfk1ZQa/LcjwT
         Tt7dI7krWq5lJkgVzXR7P2lA0q6wK8lybkRDwu15HPlfIeffzqInuPvzPBZJJRZB9i/Z
         svUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782840197; x=1783444997;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iCE7YWnv6fQepLHz0kGRAVYarDF7N3eG4MYTzFP8WQY=;
        b=UzZ0pfIRLwk0sx9cocFmMd1ABDL6IQKH4JYSQPHdx9wuUo5LaBJzclNQKm2xsAjkxX
         Yq5vkT8ypv9sqB1MHVFiuXYb12YY+chH1cdjl3xB5Itm2FKaR8ZTEwk57WFIdCJED8zY
         2jVLBVCNf1fUii6nGV+WMM+cquPh1vCodzkZMtXpefXGFUf9kvGiwwzS+M3TyPW41N/X
         gUiW4AMUYe0/z5t4JpxRJl/yMJm9ruFOv1KEJxOLF+Cv2dRAnjABoWq+W8BGBLecmD94
         yEy46jQajdjhDMGmDZ5pH+7JzvdyOuYjeILLxcg08M6jY73PR9Aa9POw3EgZG81oICwT
         M8ww==
X-Gm-Message-State: AOJu0YzBXNfkq+P4URCAOMWxveY9mrn+/UOjD/+ut+OTZio+69/8oqcU
	6QkB2D1Os7YmQPpHFFFvrc2zzZLXCZbWpBtl6gTn6HAAP5XBERyV1Mqs6XrRhkE14oQORxhy5PF
	7DAMvm7QrJoGZXJZGjEKndLoRNQKen3OZ6pgO83y7N12M/dA68y5bB4f7IZM=
X-Gm-Gg: AfdE7cluVii/FE9O8toaCM35fTAErdfjZLEwo5BD4SC3d0cAL6q1LIVdZ8B3J7Gtmwt
	GbQbkZwSxJZtxJache6g0RDGOdEVw4XPSK/nadZXYihcQx+d86K50ieQQEkosXxOQxiuKPm9K+L
	lncS3NX+9za839N4mwzQGi761/ejAQHq+3pafmorO4kAQeMPCfkiADnuJmGxZPQK+DoXlavI5R9
	Z9KgY2fhS4C+1p7r/9xdpLOQH2rdb6zkasGF/Xf/gSt/9KsH5qUV1qzwJ7kg5p8KwZ6zv+nXA==
X-Received: by 2002:a05:6808:1396:b0:495:dbb:7320 with SMTP id
 5614622812f47-495eb0143demr3741087b6e.41.1782840196784; Tue, 30 Jun 2026
 10:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629232532.2057423-1-jmoroni@google.com>
In-Reply-To: <20260629232532.2057423-1-jmoroni@google.com>
From: Jacob Moroni <jmoroni@google.com>
Date: Tue, 30 Jun 2026 13:23:04 -0400
X-Gm-Features: AVVi8CdUNZeTuzafYU45taL3Xaw0gZZAl8gh_gscEbXIthlCtVEyEVP2AjSuLkM
Message-ID: <CAHYDg1T099scmOKWXXV25OvOBNBFMA+Fm3ev3Cs+51JOCQA01Q@mail.gmail.com>
Subject: Re: [PATCH rdma-next v2 0/5] RDMA/irdma: Adopt robust udata
To: tatyana.e.nikolova@intel.com, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22605-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tatyana.e.nikolova@intel.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8C65E6E6E19

Hi Jason,

I need to respin this yet again to fix a few more sashiko findings (sorry), but
I was curious:

Looking at bnxt_re and irdma, in many cases where we use ib_respond_empty_udata,
there is also a check for ib_is_udata_in_empty.

Should I make a combined helper? Something like "ib_check_no_udata_io"?

Also, for bnxt_re, I think there are places where the ib_respond_empty_udata
call at the end of the method could be problematic, particularly for "destroy"
ops since the driver doesn't check the return value. V1 of this series did the
same for irdma and sashiko freaked out.

The issue is that ib_respond_empty_udata can return a failure but the driver
doesn't check for it. If this happens, the kernel will keep the object around
and will try to destroy it later when the process exits, but the driver has
likely already cleaned up its resources on the first destroy call.

Does this seem legitimate? Anyway, a unified helper that is called right
at the beginning would eliminate the issue if so.

Thanks,
- Jake

