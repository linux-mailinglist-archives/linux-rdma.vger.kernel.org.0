Return-Path: <linux-rdma+bounces-20356-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCkAEEl6AWqMagEAu9opvQ
	(envelope-from <linux-rdma+bounces-20356-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 08:42:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E1C508A7A
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 08:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D399D3004623
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2026 06:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E366A33ADBA;
	Mon, 11 May 2026 06:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcI6t4Xo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668452C026C
	for <linux-rdma@vger.kernel.org>; Mon, 11 May 2026 06:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778481732; cv=pass; b=AKcQLxHj59nZqG8DpGrwb8A7KiL1gGpy7Vtwz4xn5FZYbNpwzXyRduV/JkSzN69aFBtGsh1U9gPnSOc/iUDsfGAwO0QNPZ9t81KhzjnLPbbrubP2QUUXI3lS+icTEEGUaHNLq+KxsGlYzGWjVZjzUAI1STf89W9TGOT7flq6P3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778481732; c=relaxed/simple;
	bh=FfTedBOMUlVnj5CTRngWKFRj3NK32yJ5+3edLfpIC2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bW/13A2cC03oHEzpsSnH0u4MPCWytBq1pSOmdvvUvmc1y5wbF4s5zFUg3rQkIix1PVaE78bJSOurgkzukWYvWoyJTYErJPiLlWaQL+R1+hw19jsXOYv74Mm6Qxbo1Pp0U1h7QnNF99e3lxO+t3+NvBCPyjf0XwX6Ozs9WUViZM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcI6t4Xo; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-44509921fbcso1900973f8f.3
        for <linux-rdma@vger.kernel.org>; Sun, 10 May 2026 23:42:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778481730; cv=none;
        d=google.com; s=arc-20240605;
        b=JNFMFItdQpGwW5YsE5kHJuxrwYOyusgrYCqbIGFj7jtigu1TSNYf4G3KNxHQZgTTzZ
         2GbMWt0ruKfSCrJDH3SnWvl5ffRxNs9OyczPAQDXU7xNTN+HZ/A8yr9bTuCxktpMst4C
         2yvojZb43PrSV1cvoRyY74EAb12DjkVkjMPVul6f63vHRR9O0FDAGr4F34TdwY8Azok4
         hZoHbBtL7tr0aw6o7KAprybjfPCei4bpwgLZb0X/76HFFC6pk8/zqsociKKCRqQbYZXj
         5UYmKk3yRU50qb4BBRWl7YziJw84hIqdChdqzXCpk1hn0Bre5WPocJ2+Jzj4a1HWl2j2
         3luQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ixl+rregM98dF27c4lqph6kYPtmIdfqfI1YXLoMUfoE=;
        fh=i/ikACfR4biTpTKD3SJZuRmCmafxV9R35B3/nkM6BSw=;
        b=CYJMBgcfCAh3+P8bKtDl1DUagvX8HWx6H1V04norJmAlsqW8mn9Tz52JzTWiolxmgS
         5rY0UYAGhPBzAKOj0O93hnrwxSFCo7FRa9Kt9VIdO3+tKA5mxaIpuyB16n9YizCejsnh
         4F10EtCOZZY4aRCuUuUp8HcBXNzm+1xzFHTAQIATuWuyWxkAr2gIzFVvz5LMl8/TUKGZ
         8gFY2gmtOJyzVukBNCGzLzO02nr4I5T4BC5xa10GCddN29RmgdN/+KFlbM43E+REUsLS
         v8I+Yp1BEzqU7814m8gBDnl+WDPvx7sf9fVr+6im4bYGbpjZuF48DcYYLSxXO7MVcjI2
         YBYQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778481730; x=1779086530; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ixl+rregM98dF27c4lqph6kYPtmIdfqfI1YXLoMUfoE=;
        b=TcI6t4XoE4oVv5VNTniiSh7h/mHG2rHlTE1CYGC0rm4RBFOJ362Gh/RUV7PGpGKbBQ
         dVzLHIapjJwr73JI87SH4/hVdDx/95BilugTGqAq7o1bpfuj7lcrQAOjX3Yoke9K/l1k
         3HJxetX4HylMAGrCkDNHk9da9XcbY5cW4w8TMhrJ80l78O1jrZHg81igqwo/zy5Q7fc1
         qc+1AQhcXpjv2s7ChtjpjFhVztQPiiPJGeIs41YOumpw4At/eRXyftgHdH6gi7ubEKcJ
         AmBXSdaMrnG2RnXqiYdR1+d5F7abAujTNG7cdZGDy1VtUb73/JkoQuw0Xkn8G+9jxraX
         gyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778481730; x=1779086530;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ixl+rregM98dF27c4lqph6kYPtmIdfqfI1YXLoMUfoE=;
        b=e/1Kqtt65XuoOfzeSrtxlpALTQlhAL8wvTTNLYVEjt/MqREEXl4pqeYKIw1MNYsbK1
         jyl8sNlOV4lQ8G0qU2hpRnrJ57k1caPO+EvZXXnN0RStqZYKINZMcWB2OyLXGI3503kW
         zLTed+54wA++oYoJT9iHvlaU1NWjNmXs4FMJsFbM+LcUlLoQv+IuGO0vx3sNZ3Ay+tGX
         +if3Rvqj0l4kh9aHY4OkGLzQ4VVWpF4o1V9BAcAhmsdgt2/Ty8Act8GWOEkIC2G6m+WB
         Y0ZWwe4dSOeH2KA8tS2riRmn2M0nxI3PuTYEo76ZmCj3zMXNZNe5YMxXMizYn/C5dqTA
         Rnqg==
X-Forwarded-Encrypted: i=1; AFNElJ+mi6Oa5rEvSgpXgNcWN8o7FhmkjS6UNp8h8nvZ1WZRewuyvWDZvp6/fsq60M+KrIy5kdF1szSlUSrM@vger.kernel.org
X-Gm-Message-State: AOJu0YyyYtR9iag0Sevhak4BvbzKCw2vV0Ky5zeyDbBofY/cqt5vKstA
	iTIQRMMK68MK67qL68jeFF9krfCWryty1zL7IUoFDDS5GbcjV3QPaVXEsTnWMPiOCH0kuqTczCb
	zR927qvjyZ4T9HuGcwuoYutWjBYEGRB4=
X-Gm-Gg: Acq92OHGZ5PHDVPV+yw56xbvBfE5/L2RpEcXg3p4VTtT5hsOCbpI/rFESfl6rMIlh2Q
	IgRaSX4NKHCQs5hf7ZwFDvMrAZb0xvFIcNjGzfDZo7LZ3gf/nZD7te4Z/xPcRQ7QWepEoiHLaJ7
	u7zO2Uc6Rk3Or7QCD0/mHo9A/GwmObPIkitH9EUIUgBnquqhdpauEMuo+6cuUo99jfJpJDT1sfX
	rcnZZ7CzAul5mmDRT8Q3nB0ak4+MNGIH4vzbbnV8fvE5+Vtg7RIw8R06ukFu9ZvuhM/7Gs3lRW4
	E88/mrQ=
X-Received: by 2002:a05:6000:144b:b0:43c:fbfa:20a0 with SMTP id
 ffacd0b85a97d-4515ce1c859mr35646350f8f.25.1778481729487; Sun, 10 May 2026
 23:42:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507081332.2868770-1-maoyixie.tju@gmail.com> <20260510145425.1372018-3-horms@kernel.org>
In-Reply-To: <20260510145425.1372018-3-horms@kernel.org>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Mon, 11 May 2026 14:41:58 +0800
X-Gm-Features: AVHnY4JlowENWaXpdZEiEfTxuQ71SK893QjOzWDT766OkjMpq0H-gQ-YWIqd_C0
Message-ID: <CAHPEe=FDQUTZn5QVfYiqf_p1OwiUOehe49WLXHGWzB+hgnnWrw@mail.gmail.com>
Subject: Re: [PATCH net v2] rds: filter RDS_INFO_* getsockopt by caller's netns
To: Simon Horman <horms@kernel.org>
Cc: achender@kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-kernel@vger.kernel.org, maoyi.xie@ntu.edu.sg, 
	praveen.kakkolangara@aumovio.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D7E1C508A7A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20356-lists,linux-rdma=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Simon,

Thanks for the review.

> Does this early-out check using the global rds_sock_count break the
> namespace isolation and force callers to over-allocate memory?

Both effects are present. The size returned via lens to a probing
caller is still the global count. A caller in an isolated ns that
sizes its buffer to that value can also see ENOSPC on the second
call. The precheck compares against the global count. The data
written only covers entries in the caller's ns.

v3 addresses this. Each handler now does a first pass to count
entries in the caller's ns. The precheck uses that count. A second
pass fills the buffer. The change applies to four handlers:
rds_sock_info and rds6_sock_info in net/rds/af_rds.c, plus
rds_tcp_tc_info and rds6_tcp_tc_info in net/rds/tcp.c. lens->nr
now reflects the ns scoped count on both probe and full reads.

Re-verified on a KASAN VM. One AF_RDS socket is bound in init_net
to 127.0.0.1:4242. The attacker is the same process after
unshare(CLONE_NEWUSER | CLONE_NEWNET) and uid_map "0 0 1".

  [init]     count-probe rc=-1 errno=ENOSPC optlen_after=28 entries=1
  [init]     full-read   rc=0  len=28 entries=1 (127.0.0.1:4242)
  [attacker] count-probe rc=0  optlen_after=0 entries=0
  [attacker] full-read   rc=0  len=0 entries=0

Pre-v3 the precheck returned the global count of 1 to the attacker
via lens->nr on the zero-length probe. v3 returns 0.

> Can concurrent getsockopt calls trigger a NULL pointer dereference
> here?

Yes, the window looks reachable.

The writer takes rds_tcp_tc_list_lock and calls list_add_tail. It
releases the lock. Only after that it assigns tc->t_sock = sock.
The reader takes the same lock, walks the list, and dereferences
inet_sk(tc->t_sock->sk). There is no NULL check on the read side.
A reader that enters between the writer's spin_unlock and the
t_sock store observes a list entry whose t_sock is still NULL.

The companion restore_callbacks path is safe. list_del_init is
inside the lock. A reader holding the lock cannot observe the
unlinked entry. The matching tc->t_sock = NULL outside the lock
is then harmless. Another reader in the same file at line 676
already checks !tc->t_sock before use.

The smallest fix is to move tc->t_sock = sock into the
rds_tcp_tc_list_lock critical section in rds_tcp_set_callbacks,
just before list_add_tail. The list insertion and the t_sock
store then become atomic from the reader's view. The diff is
one line moved. It does not affect the callback_lock side
effects below.

This is independent of the netns filter. I have not built a
runtime PoC. The window is short. Does the code analysis above
match your reading? If yes, I can send this as a separate patch
with a Fixes tag.

Thanks,
Maoyi

