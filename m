Return-Path: <linux-rdma+bounces-16129-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM/8KQfieWm50gEAu9opvQ
	(envelope-from <linux-rdma+bounces-16129-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 11:16:39 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA619F567
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 11:16:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AAEAF300B2B4
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Jan 2026 10:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2CA82D8DDB;
	Wed, 28 Jan 2026 10:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="h8ejhmxL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A272E7F1D
	for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769595385; cv=none; b=VrtSuH3HtQMqcfaXG1JLj8w+57Fuf43JOfJDVPn+EJ49jHD5PlwSZFFfcn6NRY8C3obo95OBsL7YFzx7LE02B1r+Ez/+RFNCxmVxdtfLBR1ovk5yM+WnRMI1cZ1bjwRBMMtfQNLBlhmY4SLDL7dq3Z7v0E+ECJJgLMgU0fQ4fvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769595385; c=relaxed/simple;
	bh=MBROMSMyxCnBPDISAOcvavKGlT51CiKVhMGg2EyPKjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ka8LuNLAxniT7Ilr6CVFcYBMm65ZOwpS+Mzi1Sel9S2LftUbwUO7ywAbEayITPdinl6HZziMVq9wW7LwIpAGuK+O/+tukpMzFEPQuY6mgeJ3fVstsUsnY8mDe4CMVvgJpVxVY8XPKpoGEN8YKPkeu69Rq8YOSymVXPLs6FuHycs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=h8ejhmxL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43590777e22so4152961f8f.3
        for <linux-rdma@vger.kernel.org>; Wed, 28 Jan 2026 02:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1769595379; x=1770200179; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oWd1+lOuSsLq4VVEtDWJ9I+HHBIMp7Q+M3wx+v6GYYE=;
        b=h8ejhmxLxitlY/ZfwebnWsNmKj8ZUvZQPRSxmgdNcCSuFEXVAL0IKWx4Bn2YXKZDbY
         B9iFpgAZQbMSCuFX0MtqIltYKHR3KDDUql0Pw9VIDjQwwdN6YKwHVCIBVR2RSs0mzmIO
         3KyaiBvjQMZhRPAheknOiufTnnaRTMlkr5EuPGKoWE03e/yaPPfdLyQhehqHMPGu6XJS
         sPC7+4sNjuMTxJuZ2ldE+uBkuflotlgEcHJzgO89H7bhutyUWd1RocAaRBtm7yUiir/L
         9hYt60+/VKAAGQOpS8MocfImpTJQxppEJyezKEPfuby5qfOQbaAz3CK/RfqEygGLPqKM
         mgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769595379; x=1770200179;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oWd1+lOuSsLq4VVEtDWJ9I+HHBIMp7Q+M3wx+v6GYYE=;
        b=v1Ipew3zZUs9FDnc3uoIuYh2JUr0mpEyLI573L2XzRnnW6yb6ck+w0N0H1t3v+4VGz
         l8swID4spYsyef6eKb8ZA0a48Qe6GeOIAyL119ZGA1ppDEU5epFdIrlYwH8bZbtVJbhU
         /JCOZQzjbiPQN2cxJ1wcJPCuLXSZbYeWbN03EBPbwOk0mUQ/SnYsBB45Vl8fhocp/VPx
         hkEU6IEJqTeRnIfmPPq1xMwMOsLdv7OyK4zteLxjv+RN8Xh1eOQUsGGyF2jq2XKYuIMx
         Hh7wwGKfaU+FruCi2RnQKlhl65Y4WQDNLR0WE7nuScwIRLkTG0BqL8IKisuto+XjcFcC
         knQg==
X-Forwarded-Encrypted: i=1; AJvYcCVntsNct6Euq9sB6SmHtVmbKcxyVI3gL8Q64WiiVpc15SoTBDJmNK4gGuqeDIvaG67QliTYmozK6iLJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxw04K8n+bvXxG4MFui7jb9autBM0Vhofv0IstqfViFn3mL4Drz
	CFLHiS6sds8+mMWf8FXKwy37CooLwmcB/vvTGPh4PGADJgDQgAAP/4k0yItCVlz0cxQ=
X-Gm-Gg: AZuq6aJeXEDU1wy5bpR6ZNcRlvxeuYbOgP7By/gDiPS4aZZOg1mwbSw/6RVTSRqA6UW
	I0F5ksT8PxtsXhnq4owwMoGJ8qhNnv5H65FRZUXh0Eg5DHsUG2webglWj1j3c89RR2aq6xJFpJn
	anlqybq3UvlfqOJ+th2NUuCvjQ4yt78g1SDZUANO6Cox0pS6NBQutM74YR3filJstWkFCeSE56T
	CLvFN+J1TNusB7J73fQqKcC7ed3BV1HbWFyHCbB3cIBg72qC0g7rjOmGZiGDJZpGk8hLq+xQ/Vw
	chsj7nm7hh3bG6oID2zciQN9HDuVbrfFWjuW6PM41MmItpIbxL1auH0oM9PruUHIZ5U/YytzRwT
	LmZShBr/7LdQk4fcgR0qmWNvGQxE+i45LfPE6/QWOOqdYf3DBiHNcaFAJn/YMbgTz0tA9GUUq5K
	gAAVzZUxM/do8eHYTNZZZ7aOM=
X-Received: by 2002:a05:6000:25c6:b0:429:b751:7935 with SMTP id ffacd0b85a97d-435dd1d7c61mr6210020f8f.56.1769595378567;
        Wed, 28 Jan 2026 02:16:18 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e132368csm5501602f8f.31.2026.01.28.02.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 02:16:18 -0800 (PST)
Date: Wed, 28 Jan 2026 11:16:14 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v9 1/5] RDMA/uverbs: Support QP creation with
 user allocated memory
Message-ID: <aXnh7rftc2DiZH_L@FV6GYCPJ69>
References: <20260127103109.32163-1-sriharsha.basavapatna@broadcom.com>
 <20260127103109.32163-2-sriharsha.basavapatna@broadcom.com>
 <gn7se37zhkzzlarasfr6akpojmigjn7e3mpacusnqgzybysj3h@vmgfsazrzl32>
 <CAHHeUGXpvj0owS6Z7Y53pxzf_MwT0EN6OdXqYN6Z-AbBXG4gVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHHeUGXpvj0owS6Z7Y53pxzf_MwT0EN6OdXqYN6Z-AbBXG4gVg@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-16129-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,resnulli.us:email]
X-Rspamd-Queue-Id: CFA619F567
X-Rspamd-Action: no action

Tue, Jan 27, 2026 at 02:04:27PM CET, sriharsha.basavapatna@broadcom.com wrote:
>On Tue, Jan 27, 2026 at 5:42 PM Jiri Pirko <jiri@resnulli.us> wrote:
>>
>> Tue, Jan 27, 2026 at 11:31:05AM +0100, sriharsha.basavapatna@broadcom.com wrote:
>> >From: Jiri Pirko <jiri@resnulli.us>
>> >
>> >This patch supports creation of QPs with user allocated memory (umem).
>> >This is similar to the existing CQ umem support. This enables userspace
>> >applications to provide pre-allocated buffers for QP send and receive
>> >queues.
>> >
>> >- Add create_qp_umem device operation to the RDMA device ops.
>> >- Implement get_qp_buffer_umem() helper function to handle both VA-based
>> >  and dmabuf-based umem allocation.
>> >- Extend QP creation handler to support umem attributes for SQ and RQ.
>> >- Add new uAPI attributes to specify umem buffers (VA/length or
>> >  FD/offset combinations).
>> >
>> >Signed-off-by: Jiri Pirko <jiri@resnulli.us>
>> >Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
>>
>> When you send patch in my name, and you do some changes (patch
>> description was not present in my draft at least), I would expect some
>> off-list handshake. Is it too much to ask? Looks like you are in a big
>> hurry, that never brought anything good :/
>
>I didn't know you expected an offline handshake, since I was just
>updating the commit message (and that one other line I mentioned
>earlier). But please feel free to suggest/revert changes or if you
>want to push an updated revision yourself, I'm ok either way.

On which planet you find okay to take someones draft (untested) patch
from discussion, take it, add description and send it on his behalf, all
without consulting him?

I'm in a process of testing the patch. Give me day or two, I will send
it myself.

Thanks!


>Thanks,
>-Harsha



