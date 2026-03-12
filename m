Return-Path: <linux-rdma+bounces-18072-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JDDMLBwsmmuMgAAu9opvQ
	(envelope-from <linux-rdma+bounces-18072-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 08:52:16 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C87E526E7C9
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 08:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 86552301E4BE
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 07:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7896D3B635E;
	Thu, 12 Mar 2026 07:51:55 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E413B584E
	for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 07:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773301915; cv=none; b=OSSoaxdbAz8SkIg2UkO8T3HCjU8SZw5x3Coo/ES9qlrRDVnliyloNOCALxax6SEUgIym6w/4qh8I9f9pzoOxS9WctsGKp2GGoCYmGFEUr59+4GL6Za05ZuNjBDMUvawQjrF0HYEx2VQvMJcZGD/mfk+nsHWhaY/pl5XMICI+R8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773301915; c=relaxed/simple;
	bh=r2PdE6HYGVzZYpXyEn5kett8unUMILRQGQuMPOiuUPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aTiFLadKkYqAbdaE6BGoU/sZZBmFr6sI0Ex5TFKLh1f7RasvU+rOP8TbxgWfEyjUCFenUBrpxipDQtlUuCuYOjxt+m2mPy4/+gF3i6CJT86U2W5t4wYAPa4XUpZBarAdQUXsHtaj9lz28ORTEZ8GpmVddBbJv1Yx6KZePXynuaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aaed195901so4039415ad.0
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 00:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773301913; x=1773906713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LhKuHInA3JH1whpdNQPR6DLSzWmpT0VhZEHTHtHiaY=;
        b=ghj5l6QftHyRVRVb3HUkfVQlHF6cfwafKvHEUg+87q/RXsznGcstn+X5w0WpG0ikW/
         Jfa+rkdp5pAaOx5hr13bUgZangidXIMgwlwZjKP955yWBqz9JDmvh2YpzU17cWXemtLi
         rMmV67ffsOR+ByeSc9n0kGcScRKXKP1+1RQl2AGxao3goIY/yLK//tke39UyHgnaX33z
         1viqkSnPOZ6MVc5vuP4bDekyzh1OmiMAHKVGPW/eCed8604csWATiE6VAJqAfEXxI3o3
         5uF96yL5QjhLzx19hI7L3AwjwyPpp/9gZF6hjG+bEcYMe7HutoBL4OXU6EI5oShOZuBS
         YKgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgZbaOAKTNJu5d2qFoYS4ipieNcAjGesSw804XKSbmi1tmLWC1uFo42ZCwLvoeDSEdgVMZ+6K049pt@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/8lYcC62Iez7z74boVfEsbkdBJFpQgEDBH2LMbySvT9q1J6fg
	JisUtoKi+Jx2YQ1adgrr1nBoEQ2LcFjS9xOvNQc+vEaR0ENlBXLH7r5khFpAKgEaqdN/9g==
X-Gm-Gg: ATEYQzy0jj4H+xuEbauyotBZzv3Rsf+Fn26Ypeut4LI5BILtv/pB/etaucbhA3A5wKU
	TzW56ZsLW1MIPSzAK9f0s+apKIpmHA19DfIzzVUnRFOo+W+bdsNbl1iu0gKzoLtNlivI6ZJnK+m
	5BARIJvBTYGSIZ7nL77XhqYxGp6sX3jEN2c16e+0yu0t2WvSl1qyU+qp1Q4YteCvc6h7tjf9Ltr
	BGS8aRpPpAAFBSdkdXVO63UEW68Gvv33a9A91KNjoEJrq9ff/M3oyIE5duaYweTWYcPwqL35/T3
	XTZcX3sKqc38yRaAPDUHGs/brgi6DXcd4enx49rb4m9PNrJrrF+yq2K8mX9SqWHrNUaz0Mco+36
	P6S+uLly0E82FM/p+wMBJVLGVjubR7XDU1k1BQl3A7HqC+NcuYQqXEK5vneAu01omdMQ4NnyUwx
	KbdLWDVepfk3oCGAw/e2jf+qfsG3NpMpjfxh1+LwBnrAQPb+d37xIIiko+a+/lv+H6CkFNhg==
X-Received: by 2002:a17:903:2f8a:b0:2ae:508d:fc33 with SMTP id d9443c01a7336-2aeae8e2105mr52719445ad.43.1773301913397;
        Thu, 12 Mar 2026 00:51:53 -0700 (PDT)
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com. [74.125.82.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae378a1dsm67039705ad.83.2026.03.12.00.51.53
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2026 00:51:53 -0700 (PDT)
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-126ea4e9694so1719031c88.1
        for <linux-rdma@vger.kernel.org>; Thu, 12 Mar 2026 00:51:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU7Pu6S9tGfKY8XK8LAD3mFOFxcWYlgirqaxr0hUZYfRp+XNkZvGkXE/ztAq/iZLbb4wKhiT6/XeddB@vger.kernel.org
X-Received: by 2002:a05:6122:1b0f:b0:56a:9f03:1719 with SMTP id
 71dfb90a1353d-56b47483c0fmr2043365e0c.7.1773301414536; Thu, 12 Mar 2026
 00:43:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310153506.5181-1-fmancera@suse.de> <20260310153506.5181-2-fmancera@suse.de>
In-Reply-To: <20260310153506.5181-2-fmancera@suse.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 12 Mar 2026 08:43:23 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWj-7J5bMq=wpv12CGaV7xtq7=O3nLHLvOT_odxOE4ueA@mail.gmail.com>
X-Gm-Features: AaiRm50vZ50YS2w5-6lod2s5W_kA6Ap8FK_nMN9HyVzDzz2AFRy7FAD50ZqnaYU
Message-ID: <CAMuHMdWj-7J5bMq=wpv12CGaV7xtq7=O3nLHLvOT_odxOE4ueA@mail.gmail.com>
Subject: Re: [PATCH 01/10 net-next v2] ipv6: convert CONFIG_IPV6 to built-in
 only and clean up Kconfigs
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, rbm@suse.com, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Selvin Xavier <selvin.xavier@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Saurav Kashyap <skashyap@marvell.com>, Javed Hasan <jhasan@marvell.com>, 
	"maintainer:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER" <GR-QLogic-Storage-Upstream@marvell.com>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Nilesh Javali <njavali@marvell.com>, 
	Manish Rangankar <mrangankar@marvell.com>, Varun Prakash <varun@chelsio.com>, 
	Alexander Aring <aahringo@redhat.com>, David Teigland <teigland@redhat.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	David Ahern <dsahern@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>, 
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Jon Maloy <jmaloy@redhat.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>, 
	Eric Biggers <ebiggers@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Luca Weiss <luca.weiss@fairphone.com>, Sven Peter <sven@kernel.org>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Gow <david@davidgow.net>, 
	Kuan-Wei Chiu <visitorckw@gmail.com>, Ryota Sakamoto <sakamo.ryota@gmail.com>, 
	Kir Chou <note351@hotmail.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Vikas Gupta <vikas.gupta@broadcom.com>, 
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>, 
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>, =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>, 
	Heiner Kallweit <hkallweit1@gmail.com>, open list <linux-kernel@vger.kernel.org>, 
	"open list:M68K ARCHITECTURE" <linux-m68k@lists.linux-m68k.org>, 
	"open list:INFINIBAND SUBSYSTEM" <linux-rdma@vger.kernel.org>, 
	"open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@corigine.com>, 
	"open list:BROADCOM BNX2FC 10 GIGABIT FCOE DRIVER" <linux-scsi@vger.kernel.org>, 
	"open list:DISTRIBUTED LOCK MANAGER (DLM)" <gfs2@lists.linux.dev>, "open list:ETHERNET BRIDGE" <bridge@lists.linux.dev>, 
	"open list:NETFILTER" <netfilter-devel@vger.kernel.org>, 
	"open list:NETFILTER" <coreteam@netfilter.org>, 
	"open list:RXRPC SOCKETS (AF_RXRPC)" <linux-afs@lists.infradead.org>, 
	"open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>, 
	"open list:TIPC NETWORK LAYER" <tipc-discussion@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.com,ziepe.ca,kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,nvidia.com,marvell.com,hansenpartnership.com,oracle.com,chelsio.com,blackwall.org,netfilter.org,strlen.de,nwl.cc,auristor.com,gmail.com,oss.qualcomm.com,arndb.de,amd.com,fairphone.com,bp.renesas.com,renesas.com,linux-foundation.org,davidgow.net,hotmail.com,gondor.apana.org.au,blochl.de,lists.linux-m68k.org,corigine.com,lists.linux.dev,lists.infradead.org,lists.sourceforge.net];
	TAGGED_FROM(0.00)[bounces-18072-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_GT_50(0.00)[68];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,linux-m68k.org:email,linux-m68k.org:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C87E526E7C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Fernando,

On Tue, 10 Mar 2026 at 16:37, Fernando Fernandez Mancera
<fmancera@suse.de> wrote:
> Maintaining a modular IPv6 stack offers image size and memory savings
> for specific setups, this benefit is outweighed by the architectural
> burden it imposes on the subsystems on implementation and maintenance.
> Therefore, drop it.
>
> Change CONFIG_IPV6 from tristate to bool. Remove all Kconfig
> dependencies across the tree that explicitly checked for IPV6=m. In
> addition, remove MODULE_DESCRIPTION(), MODULE_ALIAS(), MODULE_AUTHOR()
> and MODULE_LICENSE().
>
> This is also replacing module_init() by device_initcall(). It is not
> possible to use fs_initcall() as IPv4 does because that creates a race
> condition on IPv6 addrconf.
>
> Finally, modify the default configs from CONFIG_IPV6=m to CONFIG_IPV6=y
> except for m68k as according to the bloat-o-meter the image is
> increasing by 330KB~ and that isn't acceptable. Instead, disable IPv6 on
> this architecture by default. This is aligned with m68k RAM requirements
> and recommendations [1].
>
> [1] http://www.linux-m68k.org/faq/ram.html
>
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks for your patch!

>  arch/m68k/configs/amiga_defconfig           | 45 +-------------------
>  arch/m68k/configs/apollo_defconfig          | 46 +-------------------
>  arch/m68k/configs/atari_defconfig           | 45 +-------------------
>  arch/m68k/configs/bvme6000_defconfig        | 45 +-------------------
>  arch/m68k/configs/hp300_defconfig           | 47 +--------------------
>  arch/m68k/configs/mac_defconfig             | 45 +-------------------
>  arch/m68k/configs/multi_defconfig           | 45 +-------------------
>  arch/m68k/configs/mvme147_defconfig         | 45 +-------------------
>  arch/m68k/configs/mvme16x_defconfig         | 45 +-------------------
>  arch/m68k/configs/q40_defconfig             | 45 +-------------------
>  arch/m68k/configs/sun3_defconfig            | 45 +-------------------
>  arch/m68k/configs/sun3x_defconfig           | 45 +-------------------

Why are the stats not the same for each file?

> --- a/arch/m68k/configs/apollo_defconfig
> +++ b/arch/m68k/configs/apollo_defconfig

> @@ -384,7 +343,6 @@ CONFIG_FB=y
>  CONFIG_FRAMEBUFFER_CONSOLE=y
>  CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION=y
>  CONFIG_LOGO=y
> -# CONFIG_LOGO_LINUX_VGA16 is not set

Unrelated change.

>  # CONFIG_LOGO_LINUX_CLUT224 is not set
>  CONFIG_HID=m
>  CONFIG_HIDRAW=y

> --- a/arch/m68k/configs/hp300_defconfig
> +++ b/arch/m68k/configs/hp300_defconfig

> @@ -386,8 +345,6 @@ CONFIG_FB=y
>  CONFIG_FRAMEBUFFER_CONSOLE=y
>  CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION=y
>  CONFIG_LOGO=y
> -# CONFIG_LOGO_LINUX_MONO is not set
> -# CONFIG_LOGO_LINUX_VGA16 is not set

Two more.

>  CONFIG_HID=m
>  CONFIG_HIDRAW=y
>  CONFIG_UHID=m

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

