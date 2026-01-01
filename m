Return-Path: <linux-rdma+bounces-15265-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 534D6CECB4F
	for <lists+linux-rdma@lfdr.de>; Thu, 01 Jan 2026 01:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B29813034A28
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Jan 2026 00:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984691FA272;
	Thu,  1 Jan 2026 00:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="GwHgbc9r"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1291F03D7
	for <linux-rdma@vger.kernel.org>; Thu,  1 Jan 2026 00:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767227327; cv=none; b=E20B6X7yfSn7KAiCEXUXT8OwP6vH91wPlMJtZwoUWwAkt3P6M2OZdvyZmK0DfZMCbrf1gWjkUBBhAqRRd3tCrdkc/kn8hiIlVsjmPyyvxyIrmRa30NlG2sBjSEt54g746fJflE7DQB2NsCscEEstwL0BQZ4d6rCT6f6KcnTJZqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767227327; c=relaxed/simple;
	bh=+kPcMSmk7R+Gdq2EzKirCklN8/HPtQfdcLKStyPOwlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WA/qHEJgXyySI+H0k1pHTaXHliCKqjGPiqPg24mGlFKlNkKVrEeCDw01rsh9M3StXxPArvZmWG5nDAB/0scR4TUIGNHR+q6NZY18i/IlWVMDsdcP6gZ2/6xfzLg8Ig9JAocrY33e9RwWWzx+FiyfYioJlF+NUEjZyP8VABMo6Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=GwHgbc9r; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-29f08b909aeso25111625ad.2
        for <linux-rdma@vger.kernel.org>; Wed, 31 Dec 2025 16:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767227321; x=1767832121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S2uWD+3+uKcWSebatXzToxK0XPCm9Txe1uJXgdjEiEI=;
        b=GwHgbc9r30Ug/mgssLkcZMbvvGVTEIKLD02ashIzCLtfm6ZCgTMRZW6nX+ldXWlhMO
         18m0rs+7ZizGE9ulyqa78mVGaPbsUs1NhfftCftyPExezEdexRD0QEMN/R6W+QPvATWe
         Ld+mCKpk1/dRRsnqU0CUEo8L0+UeSEJut4YtxkAKjlHDX7t5YB8e9fJTGEOdPjN3qGnR
         acEcVh1hqQNbzHUgxw2BDa9fURZZwe+2M/IS9VEJRARrlxkPBM71IdWz/Mm9G/LnLuMx
         tdl91nW0Ocdpir1EYE2CPjQhfsm0tT7hWQlQyQSVW9XVppr20DG1VRMUJjKQvTJXzAUt
         ROLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767227321; x=1767832121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S2uWD+3+uKcWSebatXzToxK0XPCm9Txe1uJXgdjEiEI=;
        b=ZIFcK9ZAv10LTBAlQ/Ym/YvX0XEvUykbszzQOVw3pYAJa7hVNfe79kd3+jYTz3+Q0+
         o+eFOZTD3evzm19EBVx5LkuXoJNLGXIzFAyXAPxIjsni46p17YmoPLY0vhdTRzMnTr89
         0mvmWes3AzggkbgoomNCGyzxn1DA2iBHaCZYZg236R3Y4TYwpvGVRFwCBysa38eiLTMx
         Zv1rxX2gkHSDvX51Cu0kYeWUByynJ+mdg5C+ryjEIMgVwI575/kCbCH3hsJ7jcKPMv7p
         v3A0p0w1cPxB4KJhRCjdN/CbFyNLUCNDIoaLGHHC2I7BdYVHdlblWa5vsZC/tuC47Wb1
         dVGA==
X-Forwarded-Encrypted: i=1; AJvYcCUW9ujk8nYDANONXMigbGN4CAuL+8LDEI0LIlEOtAYZUJd1FbIyxKotXIyDBW62a6oNcplD6864pnSc@vger.kernel.org
X-Gm-Message-State: AOJu0YxkQZXU2rWZZF5lkJXIWwLv9xzlplnaXlu+WPcCL8KzNTgAdRIW
	wWQgLdw5bvk+JffK7L8Bi+j/t/S9UMZv/Q5f7rQrJKoyNSvlQT0NOFj7qST8ZecUjLtfMW1fIzE
	GzVrw5btxjcVmP6sDyHmmx18HATC0kJhiSqSXvcfA/g==
X-Gm-Gg: AY/fxX53AnztXPh+0fLcgAIbiYadjPZbUmfxAknz51DIgXSXvKwyM7J5zp6atNT35yq
	jcfiXIyAARBZeHLvcdi95IykYbvIRi4y9ZldQu4G9mXJR+9LsphJDVe3fDfamxSJtCsUdmrE7Te
	Fun8XlJ41Y6cI6dzVqrVyrJhAV/xr7WMob12CIvOyfyrXP+o9AQccNyFF5avU85W027LC7o61A1
	y6PBta9iZDCPQklZjo/GY4h6DiGJvofUDwF4ho0WN8nep/rCcl0VgB8EWfYJ1lyAAbZiybMEeYD
	GbRlFqU=
X-Google-Smtp-Source: AGHT+IFdBMje3pnEFdkXLIfnRWJ5hysTabkkamtVS8bCSG8FnqVHfzLw8gfE0QdSc/2hoIrXIja460pqGNnL6T+duQk=
X-Received: by 2002:a05:7022:f007:b0:11e:3e9:3e89 with SMTP id
 a92af1059eb24-12172312c16mr18360486c88.7.1767227320930; Wed, 31 Dec 2025
 16:28:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231173633.3981832-6-csander@purestorage.com>
 <e9a1bd633fb4bb3d2820f63f41a8dd60d8c9c5e3c699fa56057ae393ef2f31d0@mail.kernel.org>
 <CADUfDZpSSikiZ8d8eWvfucj=Cvhc=k-sHN03EVExGBQ4Lx+23Q@mail.gmail.com> <CAADnVQKXUUNn=P=2-UECF1X7SR+oqm4xsr-2trpgTy1q+0c5FQ@mail.gmail.com>
In-Reply-To: <CAADnVQKXUUNn=P=2-UECF1X7SR+oqm4xsr-2trpgTy1q+0c5FQ@mail.gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 31 Dec 2025 19:28:29 -0500
X-Gm-Features: AQt7F2r4zx9aMRYNSaKUcm0Gdej6msD8c2I3CLYONDae3Dt0B2iooTor-dsXV_A
Message-ID: <CADUfDZq5Bf8mVD9o=VHsUqYgqyMJx82_fhy73ZzkvawQi2Ko2g@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/bpf: make cfi_stubs globals const
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bot+bpf-ci@kernel.org, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Benjamin Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "D. Wythe" <alibuda@linux.alibaba.com>, 
	Dust Li <dust.li@linux.alibaba.com>, sidraya@linux.ibm.com, wenjia@linux.ibm.com, 
	mjambigi@linux.ibm.com, Tony Lu <tonylu@linux.alibaba.com>, guwen@linux.alibaba.com, 
	Shuah Khan <shuah@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, sched-ext@lists.linux.dev, 
	linux-rdma@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 10:13=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Dec 31, 2025 at 10:09=E2=80=AFAM Caleb Sander Mateos
> <csander@purestorage.com> wrote:
> >
> > On Wed, Dec 31, 2025 at 10:04=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
> > >
> > > > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > > index 90c4b1a51de6..5e460b1dbdb6 100644
> > > > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > > > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > >
> > > [ ... ]
> > >
> > > > @@ -1275,7 +1275,7 @@ bpf_testmod_ops__test_return_ref_kptr(int dum=
my, struct task_struct *task__ref,
> > > >       return NULL;
> > > >  }
> > > >
> > > > -static struct bpf_testmod_ops __bpf_testmod_ops =3D {
> > > > +static const struct bpf_testmod_ops __bpf_testmod_ops =3D {
> > > >       .test_1 =3D bpf_testmod_test_1,
> > > >       .test_2 =3D bpf_testmod_test_2,
> > >
> > > Is it safe to make __bpf_testmod_ops const here? In bpf_testmod_init(=
),
> > > this struct is modified at runtime:
> > >
> > >     tramp =3D (void **)&__bpf_testmod_ops.tramp_1;
> > >     while (tramp <=3D (void **)&__bpf_testmod_ops.tramp_40)
> > >         *tramp++ =3D bpf_testmod_tramp;
> > >
> > > Writing to a const-qualified object is undefined behavior and may cau=
se a
> > > protection fault when the compiler places this in read-only memory. W=
ould
> > > the module fail to load on systems where .rodata is actually read-onl=
y?
> >
> > Yup, that's indeed the bug caught by KASAN. Missed this mutation at
> > init time, I'll leave __bpf_testmod_ops as mutable.
>
> No. You're missing the point. The whole patch set is no go.
> The pointer to cfi stub can be updated just as well.

Do you mean the BPF core code would modify the struct pointed to by
cfi_stubs? Or some BPF struct_ops implementation (like this one in
bpf_testmod.c) would modify it? If you're talking about the BPF core
code, could you point out where this happens? I couldn't find it when
looking through the handful of uses of cfi_stubs (see patch 1/5). Or
are you talking about some hypothetical future code that would write
through the cfi_stubs pointer? If you're talking about a struct_ops
implementation, I certainly agree it could modify the struct pointed
to by cfi_stubs (before calling register_bpf_struct_ops()). But then
the struct_ops implementation doesn't have to declare the global
variable as const. A non-const pointer is allowed anywhere a const
pointer is expected.

Thanks,
Caleb

