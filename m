Return-Path: <linux-rdma+bounces-17612-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AC0OakHq2kMZgEAu9opvQ
	(envelope-from <linux-rdma+bounces-17612-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 17:58:17 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB7E225913
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 17:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E7B0330748D5
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 16:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D3136C59B;
	Fri,  6 Mar 2026 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y9U5GPvN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401AB3783D3
	for <linux-rdma@vger.kernel.org>; Fri,  6 Mar 2026 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772815823; cv=none; b=F63mQUjQJZWGZP65U3qxvzOfX34U83x0uHcPNK9fO/b8iauhsV1Yw8jSYiMEYQSvIXMOJ5LOCzOGE7MfQ1cqkwgm8MZi6wvJtqBFSsUBZVdn3WWaTVrtO9tIqCkD2ZOUhyDppA+JHozpLHoKirHNzvPiXcFB/GwQCJllIOZq/ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772815823; c=relaxed/simple;
	bh=69n0WQNrKRRX3k9PPitHPmEVhNQIkSihAWqSYE06hIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMsQXjid3DColrMETjQGJ3lw1HtbD8AHRXnZRjeDYUomBQYAGTDZkDsnetnnk38em7vcEpewJ7D3g/WWtvm7OeQa6tzMJqkqv7nQmzPRQGRKRhaYd4PxQ5pjpOFs6qdF0/wiBT9NS6FACRmJ2x2dxZI4LHBV0HuChbS8znM3wJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Y9U5GPvN; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9360037cdfso1445473366b.1
        for <linux-rdma@vger.kernel.org>; Fri, 06 Mar 2026 08:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1772815820; x=1773420620; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/JdWkEYAoxELgAwR8n3saGF3HFaHOnFaPXfAPoD+V5c=;
        b=Y9U5GPvNKN/3Hr/QeWIiz0imzA+M4rAsQDreANFoZZu0ZHgihMgf2dG6QWFbQYaSXJ
         slEye0rEILh4tY8HV9DF0wh7ovOBMF9L9dwkUoQXdLXSjl7FnNeIZdwcymXdoh/4+j7B
         fXBdwzo6f4YiqSXtAHNyguij6TCApznHzKP1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772815820; x=1773420620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JdWkEYAoxELgAwR8n3saGF3HFaHOnFaPXfAPoD+V5c=;
        b=oqrAh+EsDlP8Txam3L0AmYoJgQiEYa2PoGVO+CevPvkT3h+2XJtjG2ckBDuW+Xge3q
         cHlB/IMUMPlYDS8W5G37PrZv7Ey9O2rgYL+Q7OPzI83NWCc6JWPCGDAKl2F2oP2kNejA
         MSTzHFiWDjmTRrJKr69mKzY/3SMeY3xV0cCaGzh3fIqjpujYsamW/wJT1uSDzRQYCRbr
         zMXHj9+uwAXaVeltTlCadre11NqQlfw8IWb33OBrQWEwjlRgnR++eu1DhPEawJAVGT0+
         yOyYeXuOHxQP1R76jZhx4xQ/d802Uqw1pUVE5DhAUNMO6xCdbsqpd0XDSiWzRqfcHJrj
         2AXg==
X-Forwarded-Encrypted: i=1; AJvYcCXVNVQrXTUbTKD/okkE2PHDseFGpFEC4vwerXifaVK4FD4ScRBGmCMKkpE4qQm9J8mcyYDUR40dr1zs@vger.kernel.org
X-Gm-Message-State: AOJu0YxXt3mZvi8VZQnk1xmuWWNKTDq3OzScWPooQsWSCpldCLBuqYRf
	WmWHdP+DwE1SJ/x29YrdjJ5mhAPgzYmkSmND0LTi0dv9HWzUHGi3lfWlJEpa0UTjn157PgRhceU
	u6H7Pywg=
X-Gm-Gg: ATEYQzwrxY0rggMYLdhPnpZst/CML4c7PxnlvEvOEaH9ZTGoMR+Qaq86dxmo0bYgFH5
	X6urP9pLYJydif+dC8Eirsq7B847C8Z079c9My6wkT6w+PbNxiM9gG0KPixubWMkIOdOIhnPLWr
	qIw468YO2gt4or9q7osMPjqViJqaPVfJu0INloY/v63fVeUmDUxIBK9WKUcZzdw5hhMlX5zKd4E
	c8XMFU9kbOx4RCXLA4/aJAt3IQ6jKVdaYu2KZaC7pggawUyKFiioEndKcAJa5aoHQ8Z20TIaBLo
	qcL5Gykigkx0qZMxuV4TYmodh0vl39z9/fj9c72y68E5k4d7C9BNkI8bUWNSdnI3nS1D+NEF0d+
	nRISUaTiqH5qaPYxz/R7sSTZH/w5WvSNOfevySK1KHmy7Hks+Erhn/zK71HRh0oKUnxGPcfdBs5
	L4cGOrh4hArqUchBh86zG2kPAuBnoHxXcvimdg+6B2mKXSarCUGJeDMaG+SL05+5nQdNrn+oT7
X-Received: by 2002:a17:907:9612:b0:b88:7568:26d5 with SMTP id a640c23a62f3a-b942dbdc764mr183839266b.27.1772815820376;
        Fri, 06 Mar 2026 08:50:20 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b942f161979sm74866166b.58.2026.03.06.08.50.19
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 08:50:19 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8d7f22d405so1392129766b.0
        for <linux-rdma@vger.kernel.org>; Fri, 06 Mar 2026 08:50:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUdCApKkbMxGf/WlhfXnF/CHn/cSP9MQuH3kopHkdppXO2RD+zTPKzldFlgBirQ6No8+9QYlPXgGTWT@vger.kernel.org
X-Received: by 2002:a17:907:960a:b0:b8e:a1ad:36d3 with SMTP id
 a640c23a62f3a-b942df83300mr169072566b.46.1772815818781; Fri, 06 Mar 2026
 08:50:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305103941.11f1b27d@gandalf.local.home> <CAHk-=wggaToeRYv6B5L9ob=wBdVW9_gFudYxH_WJDTuhyX_Ueg@mail.gmail.com>
 <a8907468-d7e9-4727-af28-66d905093230@kernel.org> <CAHk-=whW890h4m8r0iYwXEJK=MUJx9nLxuOduttRJNCLrMdz7A@mail.gmail.com>
 <a21ea7c3-fbdb-4ac7-8be5-0173f54890c7@kernel.org>
In-Reply-To: <a21ea7c3-fbdb-4ac7-8be5-0173f54890c7@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 6 Mar 2026 08:50:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi4CA=yPP-rQON_2_swS5Jd0SS4UwWbct4LdfGFyzHFRg@mail.gmail.com>
X-Gm-Features: AaiRm53iDzSi0JGYZcfli_2X5ejbywSxs09OuffDjXkat3fpYe7Z3-u4fRncIZ0
Message-ID: <CAHk-=wi4CA=yPP-rQON_2_swS5Jd0SS4UwWbct4LdfGFyzHFRg@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Fixes for 7.0
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Huiwen He <hehuiwen@kylinos.cn>, Jerome Marchand <jmarchan@redhat.com>, 
	Qing Wang <wangqing7171@gmail.com>, Shengming Hu <hu.shengming@zte.com.cn>, 
	Linux-MM <linux-mm@kvack.org>, linux-rdma <linux-rdma@vger.kernel.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: EAB7E225913
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17612-lists,linux-rdma=lfdr.de];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FREEMAIL_CC(0.00)[goodmis.org,ziepe.ca,kernel.org,efficios.com,kylinos.cn,redhat.com,gmail.com,zte.com.cn,kvack.org,vger.kernel.org,oracle.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.979];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[13];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid,linux-foundation.org:dkim]
X-Rspamd-Action: no action

On Thu, 5 Mar 2026 at 10:59, David Hildenbrand (Arm) <david@kernel.org> wrote:
>
> Agreed. We could think about letting it sit a bit in -next before moving
> it to mainline.

Honestly, I doubt it would get any testing in -next. Yes, -next gets
some boot testing and maybe on a good day somebody runs LTP or some
other test suite on it, but almost nobody actually *uses* it.

I think I'll just apply this now while it's early, and see if anybody
notices. Lorenzo will apparently be shitting in the woods if they do.

             Linus

