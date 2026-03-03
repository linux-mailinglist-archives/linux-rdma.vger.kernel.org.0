Return-Path: <linux-rdma+bounces-17442-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBfWMGpJp2m8gQAAu9opvQ
	(envelope-from <linux-rdma+bounces-17442-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 21:49:46 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9EF1F6F17
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Mar 2026 21:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EB30310E887
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Mar 2026 20:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9CE388E72;
	Tue,  3 Mar 2026 20:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MC/6UvpH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5196538757C
	for <linux-rdma@vger.kernel.org>; Tue,  3 Mar 2026 20:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772570962; cv=pass; b=RIeLYAUZSjy/d0nLxst/kAOct388wZzdXVQINvXtIdRkwm9yTCnLPB5Jj73hQ0O3RPBg3G6StZKht9EXaeh+nUOoyHhzHTOlT4Ibk6YUTkv2FCKJTsjY4/C51tgHGxE+bs62rjZtyZsZYTExlnp1mtE0O8Zf1W5Mx3Q3wCkMvW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772570962; c=relaxed/simple;
	bh=z5K9TC0MkEO8By22h3GqX8xxcKLeF0UtxgZ/D1gjfh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NiIuPw3zUoke6J3Xl7J/AoLZozKk0IyKbnnhBmEPflj0o/2Yv4zbTLguPXYI4oV9qZYcg++17E2Kgr73MjN5ZDlzk/ghQvm4yPIqkeIVfaTTT6exXMKFAQ5fTtNZz9PFsLmVdw3WeB/h+5J3ED9H8G6gSMxn3C2U/nKAFab9uQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MC/6UvpH; arc=pass smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2bdff6c15a5so165089eec.3
        for <linux-rdma@vger.kernel.org>; Tue, 03 Mar 2026 12:49:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772570960; cv=none;
        d=google.com; s=arc-20240605;
        b=HAAUspjfzbM/9+Qpl0NkHxByNbQPwoj8tsmXShFMd3aIHx1InIZQTrsYdDzq+3SwJD
         YltSwpuGkinHtKEWQLovryVXiklHoZCBiB9cuBd6fSvkV7d+zMRxsT6Y5uAnKnVo0VS0
         qhT5VqxPAXAT+FzhV9mjwgH50Kd74bYSGZEB9gmkYq1tkcx/9pCD2gzjkuZJGdghD2+K
         scmztCj+g7JvJWyAMGB74+RZz29mairLB53PMnmslSEgkZ3kX04wjRQTpqUVXXE9QQU4
         8UXP4jVRYIkbuCNcgt/Bua3voqpUlLwquPRRY1IAhAtkrs6dKSbyDl4ylcETQdrRCqn8
         lCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z5K9TC0MkEO8By22h3GqX8xxcKLeF0UtxgZ/D1gjfh8=;
        fh=xgpoZjv+3ZsKWxsB1TY+XvbIAwBhx3A1HO+4gVTTX+Y=;
        b=S7z/2xb7U+333BYSV1ZQCVAMmu34ckqR08I73iH1IGH3AHMja1Qdze4ir1rxUsQuWz
         dHtwNit8tHGIiLZ0XDgEhCwEUCAC7+/SfSrFaFj7vLnkcMPFdY8W0kQQuE/8KkVgKuM6
         vSZ10a9DC3V7Q36Oz1b8UkTOkslfSljR96mb0xEmSL1at7OL8dw0oG2c1gKxmt2qVsRl
         idiT8Ap5nYK5F03SbGSuTleRWPNEbS3xdgVmFgUCdEO/fkTghQzHPcCtZZE+//Fm7ynK
         A9YOYVmNLeAIcDZbeW5KRQHywXCDcT68JEIe0Y2xsfn1sSfs9xOJCms33kxPh5E7z9V6
         EQOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772570960; x=1773175760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5K9TC0MkEO8By22h3GqX8xxcKLeF0UtxgZ/D1gjfh8=;
        b=MC/6UvpHT4SEnjb/NMu4nCD7Y/CgFLGhB10BzWPvEDjKvZA2lZ9okaGCUCGB3IbeLy
         cGgqGyj71FN7/CioLy93vdYXiKOMJe3vR+j+biXyjvWiP1VvwY0SpZuEnET7WI0E0PLq
         BBf1WqOSwDjAumUHPBfJGMcqZXc4B6Yuz6rp/ed69z6jmhyN3Yhj3DTtzwNIYZQmx/SF
         jhT5DwBvS3xmxNKPvfei0LpqgbJOmZuKLyUK2wYyCE/Tg1IJjSJ0URjLr+TYYhp768vW
         OGrdSbrtyYfSf/xo+vB+w4pxsweRRJyYX/6uv1dcXSw8p0Wob8DVrGmxbm0/OVwZigJr
         6Z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772570960; x=1773175760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z5K9TC0MkEO8By22h3GqX8xxcKLeF0UtxgZ/D1gjfh8=;
        b=L7JozfzjWo94YODJtpthLwehvwvvVkaSxba9PkaDkfN3vT3PCEX28G2RVXfA5QvP+Y
         ado1s7AVpgBZpoLbrHy4BdAre+52k/3MjzTL1kZruUCLCVsKe5HGNaiibENlyVr2Q1c8
         laL1D42INKI1SchBlTAToN8nGo1bMndPOMPWviPxrFcnOjt/Zi1/MNrsC+cVzh95vCw0
         PWIPlG7nyBCLV5vbA2VO9rtt4bvvlvaCgzQNhNhvlCtVJa8sdFsrtUT60lIWdKO2VSFJ
         w4Yqaaiv0HeUucXizO12N2zQrUh6/eT8jCl2sAkfuLjGO7sT21izqnYxCFpYaOx0g/UK
         txoA==
X-Forwarded-Encrypted: i=1; AJvYcCV5iJPG52FjmSQ5sPXF9xqKsIlMNn1VgqWWU+3dpIEyWZHMMVrWdgHAUSVrvhY2ay7vILZmHIK3nuKO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0jzmxJdNyF63csmdKOZ69A/309t2xkt16N9D67UgINafvHRVx
	XlOBwwc3geEtfxXPgeOW4EtOAB/Y+/bt2R+wjV2OgArS84DilqJrPC2k4qDlKXr/W+9xzu7sIPF
	qT31IWU5gtnMm35yUImwE48B7rhtDzL4=
X-Gm-Gg: ATEYQzweKmqfaCzGpWIe+XBDT4ZDmw2yPCu6Rp3hSjCxU9OBE4qqKGWqq+4xxhYd6XJ
	0NmJ/M6uPzdwz5h+PL3Tv6FhSE197lCI7HKWHOXaMnO7YZXSPsVkW2O33G+Tmaxnk7hXPe7CCjL
	ZUniC+WHu1EOalIEcopBWtHXD5+ZndBcAIYadxnmYpSv+BRYKOS6zzQAFTrANPGZqVu7ZOYPo1i
	8DpHmFGaCzPk9QFh16hKfxl/58MBUJz12kVEh/YHyZjxGFSG0mtEaM1v27LW0YN/HfggkHNUKQQ
	ZDRt1L6RNVM0Xy7/38Rgs/aL99hhS1JBxHMGUONuoInO9kvoX9x3rASMUB86tXKUJgUxWgQWasn
	4k839D09IRDa1uxx4X05rICWD
X-Received: by 2002:a05:7300:231e:b0:2b7:103a:7697 with SMTP id
 5a478bee46e88-2bde1d4bc79mr3350396eec.5.1772570960234; Tue, 03 Mar 2026
 12:49:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227200848.114019-1-david@kernel.org> <20260227200848.114019-3-david@kernel.org>
 <aaLh2BxSgC9Jl5iS@google.com> <8a27e9ac-2025-4724-a46d-0a7c90894ba7@kernel.org>
 <aaVf5gv4XjV6Ddt-@google.com> <f2f3a8a1-3dbf-4ef9-a89a-a6ec20791d1c@kernel.org>
 <aaVnifbdxKhBddQp@google.com> <5f8dcb7f-9e4f-4484-b160-3a9ce541d63c@kernel.org>
 <aaWvtn48X8UizaaN@google.com>
In-Reply-To: <aaWvtn48X8UizaaN@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 3 Mar 2026 21:49:06 +0100
X-Gm-Features: AaiRm50lUTXkxHRxiLsKpWNGF1HIgeoo2SkrDpQfQSxM22wzlSiellk8rvn7q80
Message-ID: <CANiq72nK8P1rUYw=y3fMzWZR3f_mW2v0_LSLWR1i0dQTtOqu2w@mail.gmail.com>
Subject: Re: [PATCH v1 02/16] mm/memory: remove "zap_details" parameter from zap_page_range_single()
To: Alice Ryhl <aliceryhl@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-kernel@vger.kernel.org, 
	"linux-mm @ kvack . org" <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Ian Abbott <abbotti@mev.co.uk>, 
	H Hartley Sweeten <hsweeten@visionengravers.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Dimitri Sivanich <dimitri.sivanich@hpe.com>, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-sgx@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1F9EF1F6F17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,kvack.org,linux-foundation.org,oracle.com,google.com,suse.com,suse.de,linux.dev,infradead.org,linux.ibm.com,ellerman.id.au,redhat.com,alien8.de,linuxfoundation.org,android.com,mev.co.uk,visionengravers.com,linux.intel.com,intel.com,ursulin.net,gmail.com,ffwll.ch,ziepe.ca,hpe.com,arndb.de,iogearbox.net,arm.com,davemloft.net,lists.ozlabs.org,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-17442-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_GT_50(0.00)[74];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Mon, Mar 2, 2026 at 4:41=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> It's not relevant in this patch, but another thing that may be useful is
> to add CLIPPY=3D1 to the make invocation when building normally. This
> causes additional warnings to be checked using a tool called clippy.

Yes, please do use `CLIPPY=3D1` -- the build should be Clippy clean
modulo exceptional cases that may slip through (and soon linux-next
will probably start reporting those warnings too).

Thanks!

Cheers,
Miguel

