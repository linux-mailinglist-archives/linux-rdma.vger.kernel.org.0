Return-Path: <linux-rdma+bounces-16073-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KdiLMGreGl9rwEAu9opvQ
	(envelope-from <linux-rdma+bounces-16073-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 13:12:49 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A2A94167
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 13:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7599D3002F71
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 12:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667F1345CA8;
	Tue, 27 Jan 2026 12:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="N9XWiDgp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011973491D5
	for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769515963; cv=none; b=JGHJsSkWDxBw/ZWfYX6fDu7e1wyJFQKBHSQ9q7BH5QVa4OGpLog/X8+A9Ban6PZKedl1BBGmRGhOFPtR5LXxKs4sDscF3cl9DsDGYg3JwgIBQAI8rxI6fQcC/b8hlGIvpkFjp+3FeC9zkwVeUE7VU+jpxJbZnvHRFpcRo1WkSAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769515963; c=relaxed/simple;
	bh=1DAvy+ePIkWuSpxuZKyjRATU94Ju+0t+mY9NCTUFvjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgkyQjV0eP7Dqj2XWCYm0SBfrTeRiNaULQbw2pT6ooHlu3DO8oJSH+uSGomsnsmn2TMIsXx03x8DJ668bmEVRu7+hxqv/JQeDH+3wS8u+2ocY4lfKseoN4uJlS5zbwRVFC78sjsgB8lr6CZqvBgOQVtK3a0009xVA3f4Tx3nl94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=N9XWiDgp; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-432d2c7a8b9so5427979f8f.2
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 04:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1769515959; x=1770120759; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4YvnESycSIooqBe4xgnuJltfckA1dqClmGyqnKYvfo0=;
        b=N9XWiDgpQPy61S0noe98lb6HvHjOiEXFj8SrqwF+PyBql43GtYvl/pd5kjWMj6+icd
         AeHekDLUvaykJZkN2ObOc23UpHaMrjwPYwr6nQefERXXQVTV/qIWPpc95R6cAaUk4ZnN
         ygmz8tr7OzoiBHN6hwLel0wSA6cfxVHy84C8iLydPYpKtm5R9JcPEQoruAupIPcDV8Ie
         IxiH1ZuYu3gCOzgyJlM9HPh7D4NvA2dd1TLI9Pr6gRqUo3II7qtGVt88BhsltTd//t8x
         tLTn6w5Ijs/aD70mMk4IQ8GUggrNpGsFxPgr3BCxPC//D84U01VEMwvS/4HY0BFkF2Gv
         YAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769515959; x=1770120759;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4YvnESycSIooqBe4xgnuJltfckA1dqClmGyqnKYvfo0=;
        b=rOoU02WDy44/kN7N+CUzfUfjA+ekMJiBv3ggPgyourOzF/mB9pJ5yvYHmRRYaD7hkj
         5GQcO5c61OL+IU+MB6YJMJzrXYj0fdvdVwr+D+Tz+GrMGFGkzx2rRW1RMx7U3pQRtSKv
         VzIQRmNZmK6aOfNmvFXH7182MXJkGjWROEro6o4tDaHivnobo6fcipNZxSFJagXXflZf
         BuSyUqPm7K91oQrEN8UnhlKzx2WvoMdnjKVVr+F+rig+lZl8ZzfDzQYKnv2WqsFNkQ+D
         yZFKTM8gLyDD8LeY9neAI+7NfvuBSZsIrlopSQQJg4mJ7lpGjEi/4oYwOpHfgIgzQOWI
         XIlA==
X-Forwarded-Encrypted: i=1; AJvYcCWLBbyz6yHhPLxvIfWlTK0N/w/tcp3kVu3fTvKIZLCrPrMKBNKJgJVYZgOkKX+smFYZynIjB41JZzTS@vger.kernel.org
X-Gm-Message-State: AOJu0YyCW/a1TfLcIxkzkXR3f7UAvpE6vSeyhoi2bs1GwVlo+fiZB68L
	D9FkFk9BgtF20Tkd0Th6nHS6orDvUbztHGLEmqLTnQYsEJDMDH6aaNLZfb2ZyskMCTU=
X-Gm-Gg: AZuq6aInzrTodusmth55zuRTNzUMohqEDVo0zFmc/8jHSmPRQcIWRZ0ryJuCqDQh8Yg
	beXStfQNbfE6Qajp44XiZ8ozMyv1/kiWSOG1nUP39E49yN2E9h/OMemcPik/dWXB4nyDIcmizic
	SBHqATDUAfmRQUqzUg3WidkxcDurRB5rEjL093Fw7Qw3YXZGL/jP1UbDnN3tFW+unachwEhOW7w
	2jTLfOg6MuE5lCpCX77pz1DVSWWyZo5X7vp/QJwoyfUxNk2tg6KOKLtexc4NSn6otHK+9VtIS8v
	BKbDGNOgTyFOOK+dNwM/eNKjLMGOlM3TO1MgWXJrEhqqY6wKYbtoPg6lYLZA677+8v7F8zbz2UX
	xczRG92UgCGe7AxFqUxSdmFOV1YdHWpTdHkv6hAwMT5JnYLcswQ6zJCn7iQovCGy88N154sWOc9
	dknX1MgWdttJoTVhUYwdPlKJo=
X-Received: by 2002:a05:6000:2081:b0:435:953e:589c with SMTP id ffacd0b85a97d-435dd0b2a29mr2177867f8f.34.1769515959273;
        Tue, 27 Jan 2026 04:12:39 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c02ba3sm36841859f8f.2.2026.01.27.04.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 04:12:38 -0800 (PST)
Date: Tue, 27 Jan 2026 13:12:37 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, jgg@ziepe.ca, linux-rdma@vger.kernel.org, 
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v9 1/5] RDMA/uverbs: Support QP creation with
 user allocated memory
Message-ID: <gn7se37zhkzzlarasfr6akpojmigjn7e3mpacusnqgzybysj3h@vmgfsazrzl32>
References: <20260127103109.32163-1-sriharsha.basavapatna@broadcom.com>
 <20260127103109.32163-2-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127103109.32163-2-sriharsha.basavapatna@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-16073-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: D7A2A94167
X-Rspamd-Action: no action

Tue, Jan 27, 2026 at 11:31:05AM +0100, sriharsha.basavapatna@broadcom.com wrote:
>From: Jiri Pirko <jiri@resnulli.us>
>
>This patch supports creation of QPs with user allocated memory (umem).
>This is similar to the existing CQ umem support. This enables userspace
>applications to provide pre-allocated buffers for QP send and receive
>queues.
>
>- Add create_qp_umem device operation to the RDMA device ops.
>- Implement get_qp_buffer_umem() helper function to handle both VA-based
>  and dmabuf-based umem allocation.
>- Extend QP creation handler to support umem attributes for SQ and RQ.
>- Add new uAPI attributes to specify umem buffers (VA/length or
>  FD/offset combinations).
>
>Signed-off-by: Jiri Pirko <jiri@resnulli.us>
>Signed-off-by: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>

When you send patch in my name, and you do some changes (patch
description was not present in my draft at least), I would expect some
off-list handshake. Is it too much to ask? Looks like you are in a big
hurry, that never brought anything good :/

