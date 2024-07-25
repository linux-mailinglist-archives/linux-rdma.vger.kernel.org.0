Return-Path: <linux-rdma+bounces-3997-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F37E793C967
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 22:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AE2B1F22A4C
	for <lists+linux-rdma@lfdr.de>; Thu, 25 Jul 2024 20:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE023771C;
	Thu, 25 Jul 2024 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NuBBfnPz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977643224
	for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2024 20:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721938616; cv=none; b=JUfKt8glkse9tHcQIPtELjwG4aoDp2iXVnysyfX8+t4EeDdrWOG0eG3LVl5G7tfNLCbhf95cLB5vK9m/gcEtVmel6h4trN9ZtJgCDIRoiMOx9I+SQJ0Fqo+keRWKqcp66+blgRh/KC976XTATi3BCqQlMU8ZuA36g7Qpdt/UKoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721938616; c=relaxed/simple;
	bh=IvdqZvTacjy6MAQ5qDRh4fw3aGKlpJ5TgBBkoXVfd24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGsXHU9U01mKYJ5NF3gKM/cDwPOAnsHwO/lpQqGC0Ujt8yM/IctuR8xLu+fAZmRGWkyc2cFDd4bHuwelpRpOqmHcVSu6Q3/qWl0QAbtJXWYgcEKnYCqgs6ge9fJs8N+0uko2GwD+R7Gu17L2m3A3iOwcXi5s0K9msSlbBunXLGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NuBBfnPz; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7ad02501c3so111545066b.2
        for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2024 13:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721938613; x=1722543413; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=NuBBfnPzcA8fFre8f8vTtfXrvzqUnVeTZn4Iy3iOneovAAT5SQuGDTYG9eWIdlJK8b
         ptjA/DNncbXYZJ139oPcUpAT3EEKaNtt2O4x4vWqPoD6K+EiM+16+9vEkL1nSC1/+LKX
         8CMxmHcpG8WHwX+483zUPJlhBl03AU48CGUhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721938613; x=1722543413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYXza095pMOoHpnczk24pBNsoS9nyihsTN3J/3umgZw=;
        b=eAjq7KlEAyGcJ4wExn9DbOMcYM5VnetSaUJIsQ22Gb6cMddm0dEd6fI/aVOcnXrESQ
         vQeZ+1je+/2RgBpdcS/88PJiwSsU18WFSiG8NT6T8dcZ0g0NNeqNvx69XIKQ6lhLYZM8
         dBuAA5c5Y3wp5odLb3tRjIvikYfdY/LfMmjz7DjUiQsddE3rfd5CFOu+iCjABFe82lKl
         cBzaES656ZjZU7gB55RSuxEvpqP3C/OL4kDf3E+wYEQEvF/g1RzGk4++jDKM3HUxF1jR
         myZsfR3z6fXBeLn4xl+0T1KpOl9MW/X90mul1jVs7I6rmCtP5Wc/b8zIN2+51XsAHUwF
         v3Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVsN4VfaO+KMOq50HiFIqV1BDiZJVr0DoPC5+QZXNb7boaM1aiKkcLRUsBr3YfmXsm4f0NYbPLqT6rJPlkSwhXaPGnQM44ELFSEog==
X-Gm-Message-State: AOJu0YzvKt69aTaYprd12PgEwCJkqOTCvbAeQ9gbr94HSxnOzXUzmLTK
	ckKzecdJSAeNpebjneaRFnX4g3kxeAvXnp/nV2+Bjx4u/2FKgEA5f2OYoHWEINYvtuP9l1GDNwn
	cLbA=
X-Google-Smtp-Source: AGHT+IHM6Bs4EbDlB5zuUQokfPP0DyP+enkffyuM+yIatqRKNBl4y8ZQc7UJYQv+wQbNdP1/0hEeBA==
X-Received: by 2002:a17:906:c10f:b0:a72:aeff:dfed with SMTP id a640c23a62f3a-a7acb82371emr251419066b.53.1721938612720;
        Thu, 25 Jul 2024 13:16:52 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad4114esm103811666b.106.2024.07.25.13.16.52
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 13:16:52 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5a88be88a3aso1725741a12.3
        for <linux-rdma@vger.kernel.org>; Thu, 25 Jul 2024 13:16:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXZr2MleihKEBtHmZzPf64NtFsj9LKcZlgW7Rq/jMrZ9LiA0BQNwuVjehwBcQgPffHwVm4nEY1Eq10pLmxDBuPDGSRXwAbIq25JbA==
X-Received: by 2002:a50:a686:0:b0:5a1:1:27a9 with SMTP id 4fb4d7f45d1cf-5ac63b59c17mr2468749a12.18.1721938304541;
 Thu, 25 Jul 2024 13:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240724210020eucas1p2db4a3e71e4b9696804ac8f1bad6e1c61@eucas1p2.samsung.com>
 <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
In-Reply-To: <20240724210014.mc6nima6cekgiukx@joelS2.panther.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jul 2024 13:11:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Message-ID: <CAHk-=wiHHDGQ03qJc+yZKmUpmKOgbz26Tq=XBrYcmNww8L_V0A@mail.gmail.com>
Subject: Re: [GIT PULL] sysctl constification changes for v6.11-rc1
To: Joel Granados <j.granados@samsung.com>
Cc: =?UTF-8?B?VGhvbWFzIFdlae+/vXNjaHVo?= <linux@weissschuh.net>, 
	Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Dave Chinner <david@fromorbit.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, bpf@vger.kernel.org, kexec@lists.infradead.org, 
	linux-hardening@vger.kernel.org, bridge@lists.linux.dev, 
	mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
	linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jul 2024 at 14:00, Joel Granados <j.granados@samsung.com> wrote:
>
> This is my first time sending out a semantic patch, so get back to me if
> you have issues or prefer some other way of receiving it.

Looks fine to me.

Sometimes if it's just a pure scripting change, people send me the
script itself and just ask me to run it as a final thing before the
rc1 release or something like that.

But since in practice there's almost always some additional manual
cleanup, doing it this way with the script documented in the commit is
typically the right way to go.

This time it was details like whitespace alignment, sometimes it's
"the script did 95%, but there was another call site that also needed
updating", or just a documentation update to go in together with the
change or whatever.

Anyway, pulled and just going through my build tests now.

              Linus

