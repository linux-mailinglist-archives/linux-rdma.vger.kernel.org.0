Return-Path: <linux-rdma+bounces-18131-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKznDrpCs2l6TgAAu9opvQ
	(envelope-from <linux-rdma+bounces-18131-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 23:48:26 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D6027B1A2
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 23:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70FDB301B86E
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 22:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0213B21D00A;
	Thu, 12 Mar 2026 22:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="htKkcFPc"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FFB35966
	for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 22:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773355700; cv=none; b=pZoa4piCyAle2kQqPVMWvwAQdvPqmiZmWe9WUHJ00Uawg8eGaRXNYhf95yJ760Y0989UrAKrkDKsWBIal9mpUHDgUQUy5lIb06zXReQ/mIc7RkSXbtnqic7OKwWPWl+fy/uMeRYzRstWT8gfUzunqx2lInl7CEUq8ZZ1K7WOy2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773355700; c=relaxed/simple;
	bh=z28IegkFi2/sHsgKnojVtJ4sbkMmOSoNwWw72Tc3qc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DD/lXW2Op7CgGJXpe4rQEhb4dVBixztROl5TPQdkVoRC1nrsKLPnpELfPdEMhWUB7ZWXTRuBd4VJGmerm74AKWmjElUtCUfyA2/SNNwq9njFLohhvphT2Tu6OZORndgnYIR612u8jJHmIETxPw2Al9Tre5c0NrjtnZr1eZ0NbRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=htKkcFPc; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-506362ac5f7so15186751cf.1
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 15:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1773355698; x=1773960498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z28IegkFi2/sHsgKnojVtJ4sbkMmOSoNwWw72Tc3qc8=;
        b=htKkcFPcyba9ssMuutCn68GPFyd6UPFChGttIli8uNyYV1wbsU88fWstPZH/aTBdnQ
         6F6e3pPlW4mt4mD7JnzWugIBpgVbdMFeEJcKUBS843ZnR63x0KwEFN/kQOTQBEThczwM
         sJmREO46/FIf+mLfxjs5mv+AnJFcbpJfJw3zsTTRdrWZ4UaA06XY5KNJI5d1QXKmf3DJ
         yuUKUemvswQRrmLCKNZbqcwrypZxgvuXiVjFza4F8Tr5YqVbLGCceXySYpsjPVzdFmof
         mx03XKTcHQatKbG6BZAhEN6WuSzv8I/l8EL2GRikqOZcmzO3lfJbny6i7DX6ecxz5wZx
         c0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773355698; x=1773960498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z28IegkFi2/sHsgKnojVtJ4sbkMmOSoNwWw72Tc3qc8=;
        b=NKUUitNviguLren/IlCcDxok6XCawCe+ytL5hSpHCnsRfWHQ1+zA6eEwhpxTphHSlt
         0FkrsqL+8i2/8kRjHL1uFQRNGx7254j9sI9cAacQUHAeUgKQjECpabGtRHRoCUsab1n2
         yXUsEBmZyo3/FF3XYJ58huGs3UXBPmi/WfdGCIgQGCzcQ+9z9BRq01SgEzFx77Hxemac
         hEA9Py00qtr9L+pKebHDD3v/NZRGGBjAEC2hFOxG5ber8ZrwUotjMoJUIIszI/5FMqRs
         xrELQIlbcxehAYK8byIP0ChzzKKhaEV2HlQDStqPHV39/T1WD5zfAsFiz0r1oibnzCaU
         cWYA==
X-Forwarded-Encrypted: i=1; AJvYcCUaOrG8BHcLYMGBGjvq50VKZ8c1Sb584W0l7eJ5mEySxn0LVF6pqHi5c+lpy0pa5OZuAC38e3iwsz8F@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9NCniYftKj88qkP7A620fKVWzPt8x9nVZgHaaB8C1BRJRpBwU
	5KPA3cJBHAZAM2SF4a5JQxEXfEwCS6quiJPxheqXrjKQipv/155V7mb0po1LsQNyi7o=
X-Gm-Gg: ATEYQzxGfcVvW5+T2fwxHCgRvsmQUaf/DEykjB7817qovig+rOK9K79bdx3Fy2ok+Zk
	IzQ0Ue65Nmy+pr1WQGUKGHuY1zjuOBFWhAgS1zzB+2gnd9yIOBnI/6vGWrB4wD5hB+9saAsQuGm
	+cwMCyeD08HafoChkAhz4slVr+GWok6NI5EEOkoOL0u5eM3jaJXNRSmQrNBJB9JN2C1TyU+KPoe
	vrQTrlVYd4zNTBQlCgWpWsdaoKMggcWFBM9XHKcX1lLQeAWyfpaIQZkiw0EQEXLC2dZ5T3IU0JW
	AUP7HADXjcMciJasHovHyFJMw7/TzC3MO5hiv53ysbY4V50RUUA4l56/Y3shfLMMnGskDzVQg2U
	NsGCoyhL1pStvb6NR4ntVfsqCf0OW3jIQVwYxClk7IHuPo0zZuQqJQGqCG/L0K8wdnLqqdg+Xf0
	P66CAvT8HFOPrpeLG+lDB/+nvHaPnzHSxQ3GJoAVQNg+rdKFwYzLrHZHYkEusbz4f/xUI9kn/FE
	bvqYRUS
X-Received: by 2002:ac8:590d:0:b0:506:a56d:3f2d with SMTP id d75a77b69052e-50957e41b49mr16122411cf.75.1773355698330;
        Thu, 12 Mar 2026 15:48:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50939e8e14esm40241411cf.6.2026.03.12.15.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 15:48:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w0opE-000000070dH-1Z0r;
	Thu, 12 Mar 2026 19:48:16 -0300
Date: Thu, 12 Mar 2026 19:48:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: longli@microsoft.com, kotaranov@microsoft.com,
	Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v2] RDMA/mana_ib: hardening: Clamp adapter
 capability values from MANA_IB_GET_ADAPTER_CAP
Message-ID: <20260312224816.GO1469476@ziepe.ca>
References: <20260312181642.989735-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312181642.989735-1-ernis@linux.microsoft.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	TAGGED_FROM(0.00)[bounces-18131-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ziepe.ca];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,ziepe.ca:dkim,ziepe.ca:mid]
X-Rspamd-Queue-Id: 48D6027B1A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 12, 2026 at 11:16:41AM -0700, Erni Sri Satya Vennela wrote:
> The response fields (max_qp_count, max_cq_count, max_mr_count,
> max_pd_count, max_inbound_read_limit, max_outbound_read_limit,
> max_qp_wr, max_send_sge_count, max_recv_sge_count) are u32 but are
> assigned to signed int members in struct ib_device_attr.

There is no reason they should be signed, you should just fix the
type.

I'm also not convinced clamping to such a high value has any value
whatsoever, as it probably still triggers maths overflows elsewhere. I
think you should clamp to reasonable limits for your device if you
want to do this.

Jason

