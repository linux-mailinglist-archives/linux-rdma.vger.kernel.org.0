Return-Path: <linux-rdma+bounces-19573-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gD1mMbLT7mkKyQAAu9opvQ
	(envelope-from <linux-rdma+bounces-19573-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 05:10:42 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B5B46C46E
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 05:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FD7F3008760
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2026 03:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC15C3537C7;
	Mon, 27 Apr 2026 03:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qXbjC6H1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3448A175A81
	for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2026 03:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777259438; cv=pass; b=moo9yRfyi4kbiqv/2lmPyiaXszE66tvGhx5rlBe9jSlxlUSJzDP6gw6FV0DXtXfL9LBS4+3xomWjK7Eyc8DjUMJe2KfO/H8YrHpZ6IntLUHrM0tuti/KKxqr9ym4I3yhHIK1zGWYCmx9PCzoo6AugBcmMNICC1T6/Ja/gmY02nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777259438; c=relaxed/simple;
	bh=bFA5R5s/ApWwIU0IMVzHHLs/GmhmijZVcyomgAFWa0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjUTG9ytSU1emWA4fE/hhJ34ExF+rgUaxVElMPshltYwBMkKof16F1vxTpOLmxir7yfW4tdTveo7WRQE6GwZQmlrDgmAkLI1wgO8/4ps1mi4GhF3ofrqWa7nVJttpNFFCruRvr0Q52F8a9PYoB4L4jti/+6jAFJ6JsmQXWm2wJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qXbjC6H1; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c637089ccso13133697c88.1
        for <linux-rdma@vger.kernel.org>; Sun, 26 Apr 2026 20:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777259436; cv=none;
        d=google.com; s=arc-20240605;
        b=QBdAhrgDmiYhzdScTeB4dp0w7OcfyPUOzhpC8SOhOsXLwEtP/A82IsQASDW+EEIULH
         cpfq2/4TgNv4XZLtHj9srFuq44rXIp1p3+BQCbPEH6JwRfeyYGTyM8OEUV6vci2h+LA/
         cvgl+5RzyFRPTsHjhwVA2XyM5c/tj/5XeLtHOiMbwrNAnEa7zDpPL66xNZvswmhB+RQU
         92/H9/KWkTbS9ZoTDlBZAxzp4miwHGplg+j25Kaor/qRLqMiuJ2i/u+urmR1wZskdgA1
         +ovgEUBWbOQRpQs1X/d9ut4HApCWGikuM8f05lBMQtKBeC3Ic3IXlXcqOpqUMVveSqHg
         Z29g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hRQdbA6NSwh/lKMxxTvy4i65xqXmRZd3lrqBYWyYvIU=;
        fh=/WzXPIwni5vvrp4R4IibP79QwW73CcSUN/bb9kz+uTs=;
        b=OQTvO45ld8pQHuI8MzKM+/y1qWWN/mB3OVCsQauvjszme9DbWpsx8g2RgG8J99jb/N
         tV+52K1WeOLQhxh7mUMFpiy1lV3Zqa74Ridr+wsohlt6Wai+NHIcpfKDLozgRuQl3epe
         gy4h6YnV7FrXwMDbvfxY6iJbASvSaf/pJ0/W534rQPzsRtEieCa4ewsxMb8OjJAOqMuR
         mNFXQ2gRn169mk5VsP+7BMuDkuJ1JVTz63r2trP1yoBCltWDodfsPvdgaZAbsRs9o40O
         pYF60KascXYcWc8jjG7eJ1vA0yN+VGia7jJhrxiWZho3EWCfFv5wa+OQ/XOFcfGR0/VH
         L3Ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777259436; x=1777864236; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRQdbA6NSwh/lKMxxTvy4i65xqXmRZd3lrqBYWyYvIU=;
        b=qXbjC6H1KIJI0tfKFwd4nXmCuVoM8C7R9TZlqIWjBWxEvjC24qvd7nWbZEAc59Ewyg
         xGivs3lkEX6T17fA2GrIzfKoGHrg2eLjpW5NNrSKqg4eJmAEii4OtjDwBZsnw9q/EMxq
         ziZ+K9L5DwxmOiVH4Nzvt/BPPqqbVNskxfAl/orOfVwA82VDgnyi5J5IwijLAsYdVotQ
         OG96MoceiyNpM/+lVlAb8OEQCL+0Dzx7cLSdF9AiJ6uMYCf5HI53qMlznbbQG/OQ1jKE
         yx9OHu5GX/uXxteJyRr/Wp8Uix00ZYufn3ZGddTuVuzubCvGZmU92jVUhN9LjruAAr80
         QnFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777259436; x=1777864236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hRQdbA6NSwh/lKMxxTvy4i65xqXmRZd3lrqBYWyYvIU=;
        b=C7uOXqFSpVAnIs9O2zJgHCbJC2LeMBYMHR8DckdqfGNPOqEZLNINakOQE9yhhgvMgI
         OwFXb5G7aJ5XcY71z7Yz5f8tUEMduebmef5n0Ie9vQ/pCnX39f7p1QVAdQ94OYjQ1uqg
         TN67fkBXLPbn+r5EQ5DYDDKLVdkfJB0dJfi2f0rLq9znt/g4fdnqmCzYLFhcpcrdDaZx
         8M7VBsfhM221aZqLDVgYxoPuK9A8mlPvhsLR6AsI5CVz3UuT8mXIaEbEkNl90gUeM6Ec
         /Pdzys8YUSqGp/UWhiV7/iBIo8VUw1pH5vkTbcyRNWG6HGzFEuDIVwVHuie4Y19DcNeZ
         Zymw==
X-Forwarded-Encrypted: i=1; AFNElJ+AC0YdS8XbMAyjhRDz03S5+w7T1D3PS0BB+V1RvkJbF+JOneSoLaXIxIJn885gPoXpd91XP7gTfD2p@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3j4pqawFftwXoyVwKOLG2ngqVNNf4HAKHulrR6WlYFxiUh7u4
	8dMDsxOnog9M/2EqXoOV4DLI2TFChjzlQkQjGHkjZR/V/GVBHRKbRp8+lusFZyTCcfDR1ThnBrC
	wT0fpSJmRidvtK7R74EeN9yWkChIQ9h8nY8kLIFSqyTk8hFZq7ehjcOPVzqFaFA==
X-Gm-Gg: AeBDievL9DR98baJ9Z0CewKFYcN7A4XCCq9SvwK/by/HGKkIg75kptmQ+g3epjQJ8K0
	Z8hTsNBBPbu7L92/YkQpWIzDnFSNSmEGAZv+gHlIyXRBCV2ZqqJjHBJGEDhTQ86NbdIWvhBUHyl
	cTYzGN0yfsQz7SRF/LKTOOKX3idDnfPEbE6F0HYc1qDzophWHRApQCyVxU/CBQWA4wthCuyhAV8
	rz0ppyZmYL5lCvt2/kFAUTi2+NG22q6VkGTDXPdjm3WFf9gw3XInCiK3EOLy5aFKOt8qA/CFyP+
	mT/Qj24g7WdCvtnxz6kZltj/mpocMNeVtmsOetzpbnPKx/77Cxp/QRDgBuLVPPOEpznLD3Ut74t
	rKz8mQ5BY5prYu+tGO1qE5qGHvJ6+lBDkgh2s7Ws1T5HMFGsUVui393wgXtJn3BYjotBmwH+WFg
	==
X-Received: by 2002:a05:7022:f016:b0:12c:44a5:fb54 with SMTP id
 a92af1059eb24-12c73f66c7fmr19938986c88.7.1777259435664; Sun, 26 Apr 2026
 20:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425060436.2316620-1-kuniyu@google.com> <20260425060436.2316620-2-kuniyu@google.com>
 <030d3487-b5b9-4067-8b8c-89b4e8756e1a@linux.dev> <86499305-4522-4a82-a689-0247f2d5f6c0@kernel.org>
 <4196fe33-88c2-416d-ac20-b68bf7f328a6@linux.dev>
In-Reply-To: <4196fe33-88c2-416d-ac20-b68bf7f328a6@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 26 Apr 2026 20:10:24 -0700
X-Gm-Features: AQROBzBpf5_v-u5TNVd1Er35j_5QMW9T0-mqDhAd8-7UfDfZCepwPAH31e7k0LA
Message-ID: <CAAVpQUAh2KT=YpfDO5nkqrzH0kbAXEBVe6jtOtLc93wjs3N7Fg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] RDMA/rxe: Fix null-ptr-deref in kernel_sock_shutdown().
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: David Ahern <dsahern@kernel.org>, Zhu Yanjun <zyjzyj2000@gmail.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	linux-rdma@vger.kernel.org, 
	syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 22B5B46C46E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,ziepe.ca,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-19573-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

On Sun, Apr 26, 2026 at 7:57=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
>
> =E5=9C=A8 2026/4/26 9:42, David Ahern =E5=86=99=E9=81=93:
> > On 4/25/26 3:25 PM, Zhu Yanjun wrote:
> >> =E5=9C=A8 2026/4/24 23:04, Kuniyuki Iwashima =E5=86=99=E9=81=93:
> >>> syzbot reported null-ptr-deref in kernel_sock_shutdown(). [0]
> >>>
> >>> The problem is ->newlink() and ->dellink() can be called
> >>> concurrently with no synchronisation, leading sk leak or
> >>> double free, etc.
> >>>
> >>> We defer UDP tunnel allocation to the first device creation,
> >>> but this would requrie per-netns locking.
> >>>
> >>> Let's allocate UDP tunnels in the __init_net hook.
> >>>
> >>> Now extra sock_hold() and __sock_put() are no longer needed.
> >>>
> >>> Note that rxe_ns_pernet_sk6() is broken and will be fixed
> >>> in the following patch.
> >>>
> > ...
> >>
> >> All the commits are functionally correct, but I noticed some regressio=
ns
> >> when running:
> >> make -C tools/testing/selftests/rdma/ TARGET=3Drdma run_tests
> >>
> >> After applying this commit, the UDP port 4791 starts listening in both
> >> init_net and all other net namespaces as soon as modprobe rdma_rxe is
> >> executed. This breaks tests that expect the port to be unoccupied unti=
l
> >> a device is actually created.
> >
> > Not opening the port until an rxe device is created in that namespace
> > needs to be kept.
>
> This change alters the user-visible behavior:
> the UDP port is now always listening per netns,
> even without an rxe device.
>
> Is this intentional, or should we preserve the
> previous lazy allocation semantics?

I did it intentionally because before f1327abd6abe
the port was reserved while loading the module, and
if the tunnel creation failed, the module was unloaded.

Rather I feel f1327abd6abe introduced the user-visible
change.

That said, I don't have a strong preference, so up to you
maintainers.  Simple lockless solution vs per-newlink/dellink
locking.

FWIW, there is another example that reserves a port in every
netns while loading the module, see rds_tcp_listen_init().

