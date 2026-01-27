Return-Path: <linux-rdma+bounces-16075-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLH4LT63eGlzsQEAu9opvQ
	(envelope-from <linux-rdma+bounces-16075-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 14:01:50 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5778949C0
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 14:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E830130C3457
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Jan 2026 12:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8EF3570CD;
	Tue, 27 Jan 2026 12:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bYpoprn9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A70F3563C5
	for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769518593; cv=pass; b=hcJpHQQPmUU1v7BBqcGwYeyz8R6O+zrfcE+ea//Y8QcfjlHmkdOhLT5VhSLceBFJc24dgp0PuoyUSNBsEHR9aaVbYM+nq/yipVh2jVsiWth/CpmnzMyzJPLZSKD/njovzEeKwfYEc9Uqt9vRs7VU4WbdjvU5OXBK8TPMd9JUG58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769518593; c=relaxed/simple;
	bh=Kec1cFY+HbyNTGIK32aZqfqQW/BaaYnVG+pQ+omEY1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjG+6lLbLiwyqWQT5j9gW6ZLG5JwNtBBR3YpoaaWhpDDzRFONEHlbpRzRXI0r8rfShpYHfx2daCZ3evYNr9M+GMiA17flsQC8/rRL8g5yHDe7YD3j9znMiWSacB5UzAyWGTbudZ4vf9SF+ue/mkTRWGJ/k0m4To3mrzGSm4IRQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bYpoprn9; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50331ac1fedso4054951cf.0
        for <linux-rdma@vger.kernel.org>; Tue, 27 Jan 2026 04:56:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769518591; cv=none;
        d=google.com; s=arc-20240605;
        b=WAWkYECBgDgVfNghV3GxUzahLEtwN83Fi3SfFHx9SFfzL0PJR65T4zZtRpkegsoSzX
         3ftxohosDzDSETMtiC2qGpmcuANDyFpYi6wQgpKUYDUlQUtmeG9COeY35HJcuEjvpzR7
         ipMga/XHcRp8+aGaHofSLCBBDKH19rLNALCcsmaG/GqsDJItEr0jwLDO4ZGsDaT+XtJT
         wLrYbmP9kyD4jwQdpN2I2Gd8KdeN3fL8404dDG82GOV8zEquFUWn83xyjsxTfggpX8or
         3t7rv7H97fcCxWarLwVXANJG9TvgLvcNzccjq+g8p64e9h4qED9IJw8Ui5G6PGVGCDR3
         MPpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Kec1cFY+HbyNTGIK32aZqfqQW/BaaYnVG+pQ+omEY1k=;
        fh=0c49rabnJRjQXe3vlegB8mcbcmwFAzfcIZ+r7R9GZ3U=;
        b=TjTj61iScB3OvWanZluhRx8rlI0Fho8Mc2Js1uG8Zi60Yh4Hizcm0tXjn/WXgFNuyl
         1JPR7OIIl0gSc3F6vPhbnMOTEazpEdB7LsHHy4YmQQdoh8qzz12CWy5gJyVk0U+bYZP3
         4ZmK7mfkceWBqoOexiEsQ8JxKoXisjc+hMGpyzlW/PJXkXsvohCnQFnr4YsnM2MAPQqK
         LtQqqCe8nJSJmbY/kxUUQuioUpXWaOrupjxibtMSPCo91WXx2VfklgahohQy7T8qE3uc
         oJGl8KDci8t0knq8zLFM9W7QEgQ0wS5V546A6YCt0F50c1JYAttmF1eKIFHc9E8o1lW7
         PPCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769518591; x=1770123391; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kec1cFY+HbyNTGIK32aZqfqQW/BaaYnVG+pQ+omEY1k=;
        b=bYpoprn9zPYFJvVEouZndT3wiWPW6VgdJdpQhnEW9kDYzUXXX+Ux2rNPYUYcMdj5/3
         PFnS5LEpqhRxbudQVO2QIgoO217+gURozLf84x2WDYxO1l+f8qGRTH5541cfgoTxSjMv
         kK7jVz8w8aPMEsx9ETGIsuI3R1pOXE4E3YVgi6odpTysufpgls8bu3kxUAcWh14XaBas
         MpBNe0JbrimZLasMc3snwNdNnWmYi9WIvoD0d2qnwn4vLseZsA9qREvfLzrTG6rBeOui
         0P8gpHCRy+1wYzmpsrkpSFJXng3Ncr+S7VxsNrHb3em9T+N2JxEgB3H/NHjq/Eg4d0fR
         SI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769518591; x=1770123391;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kec1cFY+HbyNTGIK32aZqfqQW/BaaYnVG+pQ+omEY1k=;
        b=EFGROY9dOMu8QzU9xhmZTlDM6ry17ywiu/gOT97qLTl+aqUgW3LzGIwhNm6bkAcdUS
         KcY16/jhP4fUEWHDRDBWRD+tShh2o585y4oWtwqBH4G8P90kifYox/otOfIEHwsJ8rma
         mBQhdiNINBG/giopS23eoIzeNt9nBZK9CDJZOvYIFW5pITBpVnwocLL1L22wa/C+0WX0
         orRpMev6HA3RnMDnGM0ldFzZxQUSshdmslejj73X5il1Z3H9OuUsrIpMX0oM+PAnp0qm
         A/PEKRCFXfbpXX0bBM9Fy8BML17+9P7YhwYQEgmvYizc87FVGw3xDPvAvueRrv+HFbzu
         ADIg==
X-Forwarded-Encrypted: i=1; AJvYcCUo/DaM0fm/vtKJK1mecPZlfmWBNN35LVio4fwz23nBDvPjDZc7NKZdGyGgVMjb0pT4t6bF/PIUTGsL@vger.kernel.org
X-Gm-Message-State: AOJu0YyIAco+N2hqB4aFu+jCic0Ps9fEr/O6jTYHhfb08EmJTAhLcCsx
	GGlX3Z82jJJ7DAnBLIAeWgNymQeqhSnHomevbmwAJuNUhxK4v0itthGv/eQNmkltWPc4W/1Bmxk
	tUAomopdu8FPHVp0oeQXsg9/cbvcQfOC10+BPQg2S
X-Gm-Gg: AZuq6aJysAV/3172XBF4NW9F0DYhYoykgUd0802URG6Pl4VP3CxW/ACywC1R5t172r3
	Lsaqytw+RezJi756/ixVohk+IngdHkXbiN8cuxNrGn1ZrmFuYzuDmgz6LW7d78y1gP0EVz7A1TZ
	UshcTjjOVb2V6iOpgFQFSkGjT4M+hMQ52Wv9/EB4w2IJ6b0+kd7d+WkqmwpkaAy17JRcygSls7Z
	NU0Ex7wt9G/orOOsXVp0qdd0hVMNOd97V1vI4vtFhHVHE0nS74IDj6ZcCqnk5rN2uKq0tw=
X-Received: by 2002:a05:622a:95:b0:501:1813:4165 with SMTP id
 d75a77b69052e-5032fb1e136mr18371991cf.70.1769518590674; Tue, 27 Jan 2026
 04:56:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126-dzahka-fix-tx-csum-partial-v2-1-0a905590ea5f@gmail.com>
In-Reply-To: <20260126-dzahka-fix-tx-csum-partial-v2-1-0a905590ea5f@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 27 Jan 2026 13:56:19 +0100
X-Gm-Features: AZwV_Qj2KzUhSRnQshlLMp6CWqqzx7W1z7GHrToYMhWl_sOMG8tn60ohHqZx0Lo
Message-ID: <CANn89i+OEP2xxNjExxxE81uT-U+nZSSFLT37gKk+25CpU6ZEsg@mail.gmail.com>
Subject: Re: [PATCH v2] net/mlx5e: don't assume psp tx skbs are ipv6 csum handling
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Boris Pismenny <borisp@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Raed Salem <raeds@nvidia.com>, 
	Cosmin Ratiu <cratiu@nvidia.com>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,linux-rdma@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-16075-lists,linux-rdma=lfdr.de];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5778949C0
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 8:38=E2=80=AFPM Daniel Zahka <daniel.zahka@gmail.co=
m> wrote:
>
> mlx5e_psp_handle_tx_skb() assumes skbs are ipv6 when doing a partial
> TCP checksum with tso. Make correctly mlx5e_psp_handle_tx_skb() handle
> ipv4 packets.
>
> Fixes: e5a1861a298e ("net/mlx5e: Implement PSP Tx data path")
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

