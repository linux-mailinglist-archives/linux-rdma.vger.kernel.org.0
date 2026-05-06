Return-Path: <linux-rdma+bounces-20072-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEKEGIE6+2nUXwMAu9opvQ
	(envelope-from <linux-rdma+bounces-20072-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 14:56:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EC24DA973
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 14:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48C2C30948A4
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 12:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6253045BD7B;
	Wed,  6 May 2026 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R0y8GjLL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A2E44E045
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071987; cv=pass; b=Tst4j7GWBZB4X0r5ftDI9A8w2dg72DZ4pNGWjnt6YYvKT7CPBz6mZodJ4Uq3cqkXhXKPZss02Jhgdiw+mcwiaXNbQPL6o9Mq8p4eqtAogFUv1M4A37Ja3Ldm/DurYjPZb9TBxZ4cgdncPf+QrvwtSTOQt52mzHAxOHZ5ZnCKQkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071987; c=relaxed/simple;
	bh=i2B+NxU0CZTK0xwM8OLVyFfmzdA22KKzORXTSg+xy+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQ27rJpdrlTwzCcwdapaWKZOqEh6Fh7ASUCs2IwkNaWZxSGYMVIoP9kwxe/Gil98uz7LP2AvP0dJQZyt4N/dP3XbNm8q1CqXCuzuPb8SanBxGoiG91ZP+F6O1C6mW3Cd7LQMpFdNQUuDNbHLC3JC6Yf1u5SYz66PerfDYwYDFwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R0y8GjLL; arc=pass smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7de4e6c5a30so5603546a34.0
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 05:53:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778071985; cv=none;
        d=google.com; s=arc-20240605;
        b=dBW5WDxHRIbXtm0kTsJMS8FkUmg+mhLjRT4xrXZnnI80MB1rLM9JbZg069UfFeCZ+s
         DOF/f5d28e/7/zmDid3ruYCd7RxsA794BXSgt0IScmql8fbS4Lr9o3nTxrKi92gOYMcJ
         9u4fA4kVzsb+/bDU2vLZKHvr21XS6e1SOmvDc57idAn5DM1uh+jG7ia+qb54sZjBBv6F
         wMkRXs/nQ5Qs+Y8fd3fBKwK34XCQgl7d9ABauoUORhhEKXQjwyzxGGQAtLdIT9lPD3Hl
         3Pc+RXYlSEJZATNR1Q1BzI07KIAE8K37gZwHpMXgCA4n2NFSPp9O3BfWQCUGiA8ZlUcc
         aOKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=i2B+NxU0CZTK0xwM8OLVyFfmzdA22KKzORXTSg+xy+M=;
        fh=NM3QlVm2gljnKIq8nzxobuktninE1S8cE3JEJ/Y4+cY=;
        b=asw2CTozlZtDYBE1BedkoQET3vRya92pjeNLNGlLUbJoXb36Wzh3ROtve7GVcchwv4
         tslw5UkmWs7trVt1Nin2mSvKXfn1cs1w8ScEOKYO7dN6OwcpxFaoYFu1bVehCynxQ6F7
         9+qrEdaX0+blQkNR7AjAx1Xj7I4r43yQx6J+Gf/MWX0HtjUfr+VE0CHT6l1HfjuLSo7G
         tomD45sWV4ZWve+P/R2l5+ABBfNmHmhftWGilWhve0w3X26Rqdt5kCkNJtlE6gDHNGdZ
         HX/iGw18ad74+yg1OxUPEaoJYeajTlY+2sPTNYRrCA8j0yAaq5WOBSCkxLVjErI2qvr4
         Llag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778071985; x=1778676785; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i2B+NxU0CZTK0xwM8OLVyFfmzdA22KKzORXTSg+xy+M=;
        b=R0y8GjLLxWmlkXRbv3S0aKO/6Coo2urcSZbNHVGlY1Y0ou8EtvfX9CMHzY6deoR/bd
         530zGFaTsoaLbekipSFeR5HIHzKfvXjpfmUOW9uf9jR4GCtgOPe5iiD8ITLXouq2UemH
         wzOdYs7GkGaPy3fFwegM8fJaJeVGB0s6MMtME+imzs/5o0WC78Ftp3p8spn1SGMV2DCS
         bktg0gLDRd/bLI9W/D9Sdldsn/mb9Bw+jzh8OXfT+n4HaMhDKUB0U4PthGOqUX+DIE0y
         pR7G1/0BXzQcXGR+xS3IxKFIuREs+iWZ/eBpDZlBcux5moYl/Q20QTWWu/JmOAsxvE/3
         wbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071985; x=1778676785;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2B+NxU0CZTK0xwM8OLVyFfmzdA22KKzORXTSg+xy+M=;
        b=dViZncMfI62+3yELVg1PDAPm8eBB5UXp/SWcaSRO5NdbGFX0yy+hU62e1Flu5jrDx4
         mZ0p5WZWiE/8yu6CPieIxeFSATube0D7kGlRsyvAYZzrPjwVgn9YrOqT28TzKrYHj7Op
         dnu1u1c4z2YvtGRlYKOqEThKSOFvYpaltyOgE9Aevy5+kxiookdJMvaowD7xdddpoOlt
         KLJwasu//H8460cJJD4Cvy/XoVRjVMZCyEfep+9GBxXerG23k6T0UfnG6QJAy/KYE6uU
         XUKoPuXWVMKraLaVmMD0ii/pWhaq4IubNz8QoMIvv2PYJa1r2q2GItelWDVPrCqDDejW
         PZ+g==
X-Gm-Message-State: AOJu0Yw083s8a09TzVIz917ouDhvBcMWqGSZFXTHrgCVrOTJmgJXxKE7
	7MGGzE2Sjwb0b0T58y9nBqnuCrQyfJz/h0b3p8sY1OySi2+ToeDRZb1mzqTd7dChMI27EeJjzr8
	6KejEzCLUYSoTTJaTgWSDS2G2AGjkLg1YyiWebjwK
X-Gm-Gg: AeBDieuZK9fOnJQFBYsHiHmUMVT02R3894Vhd34+FzoPOEM8DPsX4J/4cIDesEPgc4d
	JZz6GAPi2EzaI25DKUg4mfz/kQHVRPrqnp8Vs1+iauj/mIRMqlOVYVYY5AXvP30iOFg3r5rNZ8u
	GH5baEIYAbSL9Du47D5+Gh+Hi29XPC2PIC44Ru5+1Pdm6OrgYdBMq4+OBAHO43pxtoMIcvU2bUn
	xEMf+7Dkoghg1RalRscu1YRzB+RIm35vhU2fsPIDAsOnR6gi6jjBtv+mhrSyiwg9MKCY3kf7yMb
	BMS5UCbk7qnPGKTgiZJjwylwYXSrERzAwyDroHh+bHYKj6n44wXmmZ3yb9YlDQ==
X-Received: by 2002:a05:6830:600c:b0:7d9:b58e:55ed with SMTP id
 46e09a7af769-7e1df137a49mr1750837a34.25.1778071982713; Wed, 06 May 2026
 05:53:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506111447.2697789-1-jiri@resnulli.us>
In-Reply-To: <20260506111447.2697789-1-jiri@resnulli.us>
From: Jacob Moroni <jmoroni@google.com>
Date: Wed, 6 May 2026 08:52:50 -0400
X-Gm-Features: AVHnY4JsUgaYhNavmrDw6HwdE97-Oe9BBb8uLqGNrrT2KLiIImow9cRCq-KXQ_o
Message-ID: <CAHYDg1SwbHebMMF7Sm_YRzzcJXK50bPM+XzXrANc2WP3qwWOMw@mail.gmail.com>
Subject: Re: [PATCH rdma-next v2 0/2] RDMA: detect and handle CoCo DMA bounce buffering
To: Jiri Pirko <jiri@resnulli.us>
Cc: linux-rdma@vger.kernel.org, jgg@ziepe.ca, leon@kernel.org, 
	edwards@nvidia.com, kees@kernel.org, parav@nvidia.com, mbloch@nvidia.com, 
	yishaih@nvidia.com, lirongqing@baidu.com, huangjunxian6@hisilicon.com, 
	liuy22@mails.tsinghua.edu.cn
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 99EC24DA973
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20072-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jmoroni@google.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

Reviewed-by: Jacob Moroni <jmoroni@google.com>

