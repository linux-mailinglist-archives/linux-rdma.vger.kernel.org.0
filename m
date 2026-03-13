Return-Path: <linux-rdma+bounces-18143-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICamHbcvtGkEigAAu9opvQ
	(envelope-from <linux-rdma+bounces-18143-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 16:39:35 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3CD2862F5
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 16:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A4BA130AD749
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 15:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887F83A6F03;
	Fri, 13 Mar 2026 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MqLfArxx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B39F3ACEEE
	for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2026 15:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773415407; cv=pass; b=NvdZAYv+cQHizIAwA/4yN4e2qgdI85NMXwG4wDKRxJ+T79aT3MkN3H8Z5LsVl3yjT3VmbI/uGbxYuZfTpSI4hv9hQotIEFXTmuvGaJbA106CzTq/eAznDEXgkSeZJ/mRx57GgpQ2FRKCHDThXgdPRXcmNJdYKY4lmFq2oWRchJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773415407; c=relaxed/simple;
	bh=9nXJ5BNxZns7pHSD1f69Ri0q7JU2QDu8jU/glDOJ10E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h0Wep8NmdSt/h0EUSlqZwhhBMl/VrTA1ytjBOF6zN4LL3UmlbC8ka4Xw7CxJHU0S2ukdtm4S+QDVaif0FZWwHi3/bgXNNvmS18TNjJUv7Ygp8DFgDQ0HE4ilb/2xpQnOx3vLpUWucqlSYTUq2SRmedet0LcBw+LYgAIMuyYmbI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MqLfArxx; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79868cde1eeso24549917b3.2
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2026 08:23:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773415404; cv=none;
        d=google.com; s=arc-20240605;
        b=ieamcCwS9ELaxSZOINC2DF1meAKaC/q+PrAboh0YayO9zVLkcv6HlYR6Xqs6dFYuFA
         PETVAxL+tjiR6QsdPB3QVuSB4AJhvZVED5xlegjiiPv0XjYrzCr+ZiJwMEn2hafVqawe
         KoVgBLYvrXpDQT2HZ5JLDAcoomwH7Q2mNoYb50aV0tLHxpbjgGLKNeUC7Fx7ZGjFW9sF
         zBAQAY7yK1gQXfs5K8t1ufKDyuqs/sN0zTa5lYnE5eN1vdhcp6txEpuGcTtDwNtMvWYD
         lYnz2jC44cJLAlZJm6y1TUVwzpkUVN5fiygSHHGT4gIHcEihH273kkCc4gdQW8HDnqYf
         GgaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9nXJ5BNxZns7pHSD1f69Ri0q7JU2QDu8jU/glDOJ10E=;
        fh=9K7pXxalAOQQvaGau/Ql+V70wPweoucurVceA05LKgA=;
        b=QF6II0OYhhYOwRCAmi1VjsiE0YZ8clp5PyYFcqtR5FlVugnao15NbRelIdLFaMCh9n
         +/z6GP5lZLASad2gQ4bE6hYYua2eQQnM28bKGlAcsrDvciqKFmpohZ2nA3ZyHcmztsND
         RMnmwH21C+Yqi57v00M1B1dK9c3QOk9r2Za0UZRW7TTXkOzr0rua5LOhVe5xaKEYpKpf
         QtffQQlQRnp7y1uKlrlC3sVO1vy10+Sn51EacEQ4wc9tEBAl6ZyJjFTDzgRlvkzzmj9z
         eTJFRVKR0IotJ735lms7Tzz6mM35KNGLYloI2bL3b6d+mmQ/Hm/gLcWOJVe20rtxtpRv
         R/LA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773415404; x=1774020204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9nXJ5BNxZns7pHSD1f69Ri0q7JU2QDu8jU/glDOJ10E=;
        b=MqLfArxx9WavGOVcNbQ/YuikDXr8zrfI9pMe0VvodHyONDK2YYVYs7IpP9apEBlypP
         Ez6x5SRvTBvRGER2SNjESUQ2YXaxRkjQa69ErILkq9lg4oHuwOyIL+mUnetUkw9uOzYD
         MiNQGv/iuGVu5xzhi9l0MzUJFHUjEXVss35CJIubve1CgfqOR7/bJatkpPifQV8jtq39
         z5LPpzeg3WjOQQOtcpHzolhS44W/kpZ/pYSIe9J5CSvPfJpcfM1Z4hKi9rJHYuuATXZs
         br8HVDqKkQ8FPlUFhN9asfKCUmWAvofbONWOra37GZQizZfJj70IkNZk13GKLj/AGvGp
         dRZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773415404; x=1774020204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9nXJ5BNxZns7pHSD1f69Ri0q7JU2QDu8jU/glDOJ10E=;
        b=aS2VQVKztngKl+MJDzbsicewiHu3rrsJdERP/xr19T7af4H425YHrC4hTYwS8dXN2Z
         6ugDsFfQ4UTJOQ3r4WvxYXevBq6rxx5XGMnKyaTYqStxEhP46oAJkU8KtTH0m4/Ol4ie
         iEQa5+k5eF6UcxY0KIr0hH/bWsmXfcfdRK1IWgjA7VnCbIZ+C9BoFJg7yCt0YttPJIQz
         wVN2LUNuVA1MiEIQbEoyWi2TzThkGOSrBg740+2K5PxTqroZPnrOQgdQyc30N3ZavxUs
         mvPFRlVQuHVLfRDdApmEm3vfT9tgmt+E3EBB4XDFDaEZ8KMw1zpyDUCA5bL8O+rKRM2j
         7vgw==
X-Forwarded-Encrypted: i=1; AJvYcCU2oIWZUDmE9gpVJ8QoEhPpGrkB5aX+1s6GIehh3SKHZHIX84pkoTI3A3t3bIuucPwkKhXnuptqu969@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn8eaxKAh99YWKWfJiisWObhSTay8XAu+PaRH3m3ovRPHwsIVK
	kl1I0Ckb6l1FGyY2Ea0STqDGR32jTViIvvbMKfoRQzZDUMld/S1tGuocO1UTBuSwqeRwyJQqIQi
	d8l6T5W+Rza36RV4VK6J6IfyNsnI0zkAVzFXfAJm0
X-Gm-Gg: ATEYQzy9BfOPMO07KWdHke+X64hrRUiVunGRJqWk2FxlD57P66pb2xIEMPCLpIOtmBc
	RNtN1Z0Mw9dC8/pDbDx+gztih8buhK/3OlG2pgGySiSJIQi0jOIYyRswPT5ogVFPFszoensFrAl
	vowAElT2uszVPG6PXBIJSxD5kfr+irhpaVmmTrTYugtokbXTK0wXGdCvsXY6Y5O0OUQ4alNi9wm
	EHx1wsSQIjEBU8eoCU/EMe3SX7ZQXBWcg7yZ30mG6pejCzYxVBYnmBmlBL69Yr1ns9R77cAl30U
	lbHIZV8L
X-Received: by 2002:a05:690c:d8d:b0:798:240:dc with SMTP id
 00721157ae682-79a1c1ff74fmr39519447b3.44.1773415403629; Fri, 13 Mar 2026
 08:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313151609.83026-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20260313151609.83026-1-bsdhenrymartin@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 13 Mar 2026 16:23:08 +0100
X-Gm-Features: AaiRm52KxJMaf1ydBJZ_jjLOyjV7GYRKOtKNeJuwOG2OEoR0W86DQ9uF5UWnY0Q
Message-ID: <CANn89iJSyAb+hrNEoGrum_W0Tfd_QY82dW4Y+YrvVqkPzdK=qA@mail.gmail.com>
Subject: Re: [PATCH] net/smc: fix NULL pointer dereference in smc_tcp_syn_recv_sock
To: bsdhenrymartin@gmail.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18143-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lkml.org:url,mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C3CD2862F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 4:16=E2=80=AFPM <bsdhenrymartin@gmail.com> wrote:
>
> From: Henry Martin <bsdhenrymartin@gmail.com>
>
> smc_tcp_syn_recv_sock() gets the SMC listener through
> smc_clcsock_user_data(sk), but then dereferences it unconditionally.
>
> During concurrent teardown, sk_user_data can already be cleared while the
> hooked syn_recv_sock path is still reached, leaving smc as NULL. This
> causes a NULL pointer dereference at atomic_read(&smc->queued_smc_hs).

https://lkml.org/lkml/2026/3/11/173

