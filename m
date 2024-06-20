Return-Path: <linux-rdma+bounces-3368-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4767E9110FF
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2024 20:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A7F1B22305
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2024 18:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA241BF30A;
	Thu, 20 Jun 2024 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e4kBkXYq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133C11B4C4B
	for <linux-rdma@vger.kernel.org>; Thu, 20 Jun 2024 18:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906889; cv=none; b=PaYJgLbPDqcESMBuQmCmkTTJYnwayWKENneNtzFYQn/4rAcafg45uV+Tlx3RS0A4yIBOd3lHuRoa+qd1nwz5/l6jbFPdlOO8xzlOnzHvQC3csFznaxAFBjTuK/x8q+RisHCmyZ8XcEWluL2+RttzDkWY0OlLYam1s/SneMvgd/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906889; c=relaxed/simple;
	bh=29OxgEL3l6wtk/wr9HSlAcydEGnms+qvS9bonjZCeq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u+a7ZjAs4vk0cSI9p0iDz5wK1LW0Tld5ry13PJCRZmP9LRn3WVJI+tRQfz99FulBD6GCLVBmSxmMe0WvmbNp4EMFTqNoJNyeotmeoI3jYjB44UEd8Zr6NrbTKe10UdC97ma1Y9X8r/eBhSps6USg9b1AVAgaUPxZLzS0jw5bXBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=e4kBkXYq; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52c82101407so1936150e87.3
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jun 2024 11:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718906885; x=1719511685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fuatl8An2r1cXJScFESolD1f90VPFvdc9a3mKIi/oro=;
        b=e4kBkXYqzvGgu8ToqrxyNslxMF/N3V2762oCrJ6AvktdnK07ZMDQiTjH4GUhrx6CN+
         QQcL92H7b24AVDKujHO+Pr7YJz8K8dJ39mpr01st/BpcoaAldP+XIxYZBB8e3g2pCCon
         YKGOYvaSlnVj8zaAws565quVoXdqON4Y8AwBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906885; x=1719511685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fuatl8An2r1cXJScFESolD1f90VPFvdc9a3mKIi/oro=;
        b=nZGbeVizDAdEDQ/+w4Hk3zVuIAaBGzvefJUXaODgDNhT2qCco657peacltNE+btNOB
         j5iwzEhY3uUgnOHf7qQBwhaIqYesMjQQrM3oArz3u7aq3T86JE3+AqEfLFZbfjDvmrSr
         fIs/YcqJQ1DY+4VipdSwJtWb53G2DhvVPFZd/LPa6MwkduedJXazbo1ys6JMpTyl52nv
         gQg6NDkybJcmHo3r2USMLCe3NIuZhhV8hBFzwwqlEfjjLBcBdu9G32tQFYbFSImyf8t7
         5y5e1n6V5ybsi0fwHyi5nvAj5Z8rMGd1KxuNDnlt+ZGiaXnMJ2yXNjDWlQ8/K8LNeEsl
         21Ng==
X-Forwarded-Encrypted: i=1; AJvYcCXmf4zH+r6/sLBzT58Ea+cRWFH6/5DShRTO7gnGThfn+HWc0CqdGXAAceD78g2NUQI1dalqa6mACSzieGxr2/fO5KNORlyuVPprTg==
X-Gm-Message-State: AOJu0YxNjcAuw8ZztMD3QX7S8sOYxTojHZdLpZ643CyBgD4znAfy7wSy
	gQ7obe4j6TAirx4ufNhcsthXgiE6KggnvCa+inX5dSR6NEI3WqPR0x43FJ0amZGSRf86+zRvpdM
	yn0cUZ4ua
X-Google-Smtp-Source: AGHT+IF0uloPReQxtiI7kPy2lReag9zrdJq5O37gO2OO26ef72OX90/SmjIHT7A6pqqm7YI9svQj4w==
X-Received: by 2002:ac2:59db:0:b0:51d:9f10:71b7 with SMTP id 2adb3069b0e04-52ccaa33e25mr4541786e87.28.1718906885001;
        Thu, 20 Jun 2024 11:08:05 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f6ac22e57sm656434966b.177.2024.06.20.11.08.04
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 11:08:04 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4230366ad7bso13948245e9.1
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jun 2024 11:08:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXolDN7Q/SuNpkn3vf4X3DYLk1c/8u24IZ7YvpbGQgqI1gWLWSxdB39YpFug3Z+OwSTQTIXmWX/m+9fCB3ZUJn5W3yQ4TjndpivOg==
X-Received: by 2002:a50:96cf:0:b0:57c:5874:4f5c with SMTP id
 4fb4d7f45d1cf-57d07ea857fmr5124279a12.32.1718906455555; Thu, 20 Jun 2024
 11:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240620175703.605111-1-yury.norov@gmail.com>
In-Reply-To: <20240620175703.605111-1-yury.norov@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Jun 2024 11:00:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiUTXC452qbypG3jW6XCZGfc8d-iehSavxn5JkQ=sv0zA@mail.gmail.com>
Message-ID: <CAHk-=wiUTXC452qbypG3jW6XCZGfc8d-iehSavxn5JkQ=sv0zA@mail.gmail.com>
Subject: Re: [PATCH v4 00/40] lib/find: add atomic find_bit() primitives
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	"H. Peter Anvin" <hpa@zytor.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, 
	Akinobu Mita <akinobu.mita@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Bjorn Andersson <andersson@kernel.org>, Borislav Petkov <bp@alien8.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Disseldorp <ddiss@suse.de>, 
	Edward Cree <ecree.xilinx@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Gregory Greenman <gregory.greenman@intel.com>, 
	Hans Verkuil <hverkuil@xs4all.nl>, Hans de Goede <hdegoede@redhat.com>, 
	Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>, 
	Jiri Pirko <jiri@resnulli.us>, Jiri Slaby <jirislaby@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
	Karsten Graul <kgraul@linux.ibm.com>, Karsten Keil <isdn@linux-pingi.de>, 
	Kees Cook <keescook@chromium.org>, Leon Romanovsky <leon@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Martin Habets <habetsm.xilinx@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Michal Simek <monstr@monstr.eu>, 
	Nicholas Piggin <npiggin@gmail.com>, Oliver Neukum <oneukum@suse.com>, Paolo Abeni <pabeni@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ping-Ke Shih <pkshih@realtek.com>, Rich Felker <dalias@libc.org>, Rob Herring <robh@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Sean Christopherson <seanjc@google.com>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Valentin Schneider <vschneid@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	GR-QLogic-Storage-Upstream@marvell.com, alsa-devel@alsa-project.org, 
	ath10k@lists.infradead.org, dmaengine@vger.kernel.org, iommu@lists.linux.dev, 
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-media@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-net-drivers@amd.com, 
	linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	mpi3mr-linuxdrv.pdl@broadcom.com, netdev@vger.kernel.org, 
	sparclinux@vger.kernel.org, x86@kernel.org, 
	Alexey Klimov <alexey.klimov@linaro.org>, Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>, 
	Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Shtylyov <s.shtylyov@omp.ru>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 10:57, Yury Norov <yury.norov@gmail.com> wrote:
>
>
> The typical lock-protected bit allocation may look like this:

If it looks like this, then nobody cares. Clearly the user in question
never actually cared about performance, and you SHOULD NOT then say
"let's optimize this that nobody cares about":.

Yury, I spend an inordinate amount of time just double-checking your
patches. I ended up having to basically undo one of them just days
ago.

New rule: before you send some optimization, you need to have NUMBERS.

Some kind of "look, this code is visible in profiles, so we actually care".

Because without numbers, I'm just not going to pull anything from you.
These insane inlines for things that don't matter need to stop.

And if they *DO* matter, you need to show that they matter.

               Linus

