Return-Path: <linux-rdma+bounces-15262-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 041A5CEC70E
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Dec 2025 19:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42A28301D664
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Dec 2025 18:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C102F691A;
	Wed, 31 Dec 2025 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="eMIZNaZx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1870A2D3ED2
	for <linux-rdma@vger.kernel.org>; Wed, 31 Dec 2025 18:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767204574; cv=pass; b=qwIw3k7UdGAWW9fA+oXPAu4g/9mpa6+Ik5Na1VlCmNMWmBjpUE1RxgbVjnBwLzE9Y8y8/od6M4ieoCT/CIenxND0xc3cGafXQVR4GTjtokDljhDYEUJAGAdGeC3vAE3XQ1YVJwAUE7u1Eahh3bgRz1u+Zjk4YAtBgmEQj77nrJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767204574; c=relaxed/simple;
	bh=Mtz2A8tWa233gsaBDZq5niJH69EnDrxIcs8csRo3gmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HH15ZkcOrEYdHBW6BOVNQTUcPDWloPjGZ0qB/je7GXSjIKiLqp1X5+eMRjx68uj6v8atCWKHhftGPp92rIKAxtXkjgKLwC0ewBGpjV9rNX8M1tqlZtblT9tG/pkr8L8kcYwGpmjJBCvp/Pu2SsyseRyz4rsj3wH7FAmANDOubBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=eMIZNaZx; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c03ea3b9603so446544a12.2
        for <linux-rdma@vger.kernel.org>; Wed, 31 Dec 2025 10:09:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1767204571; cv=none;
        d=google.com; s=arc-20240605;
        b=RdnnzsDAv4Yim8q03LiHfzvYEFI6KsIlSZQJ2h5yoqlT0pnwByh4Hf8cpsQNG9PDtM
         jvW0teJoCmOiqafbkv+uWKqgf8YaRm0KgbSWGKA6XETk+qKj0KM5GSmyOuznS1AFHPLv
         TCU6SZrzBA+U9IKBQQvghVs33VArv7kIN7Da4vJlMjHz8y4OuwvE7ni5thci2zBk/SBq
         wwZeG2XYxv4fsm/vcZwpCPP/J9NZTQKiHNrNcoTTDxnNWsewK7PLkssykYSF1WQr+dii
         q7BHMZKNtBODiyPBoquedMYyJrBlghZCdexto9ZvCxVmDHVQiNKy1IFJcK8+7wytgtrA
         bvxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bIMPl7WzuufPEFhizw2OC5bzIw2A/w2Jw5N6sXr/zUI=;
        fh=dOe8vSbRlvymdfIys/zW0YWRSzmB/f5IZTIwTjQ3e5Q=;
        b=bMXFd8sfu9+squO9jFw8ypQMi6sZdvhXtrP7q5mKAgxhHgcP2hl2ti0BNVbmyUagQS
         mwa8O3iD9Bj9qzLABFesWJ1HBApg+XDOG2zxP8JmFgvO/VsLcYt/UlnLLT2A3irSuM88
         gDP+FK4Ki7srsiirkVTvT2tzV1JcF6bycYIRTBliWjRQ96GdmsrsuYMKhB3PMl7PARBE
         3t+4iP6w+aMfOCw3jw8jUutTh/wbzLtQjru6SaEF1eQVxoqZxv3KRqOnvCba1s+dEEJU
         GYbSQ3PoYpJUY5OcyRA1X9UBibRVeoUAe4oRvLSfA3It5BkqfpHoIFGNs5ZBhF+cf6Qy
         HH6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767204571; x=1767809371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIMPl7WzuufPEFhizw2OC5bzIw2A/w2Jw5N6sXr/zUI=;
        b=eMIZNaZxBhjFWbRV5ha9XKWe6+Thr83KYVjbX2EkOS0ijkIS/ouyjp0CtYoTRWnilM
         e58ePoaklivu0fQntxNqGZw9WUotToDYHEVdITkDaRpzEbVk0cI4e+0WXxKdC9aGjZJj
         JgFBFp0fhc6aUWuQCuIWhwiQ4wMayISpnxgDrXkOgMY16odAXqHr9AANLOBFS7j+6a5F
         fJO0q61tAgcea0PhgKSTCegLBw7cy5T1i8LarrJq8r33fGcLXBobunY3aVGko+6xOKhS
         RkYLDJqwAvKBEaH/S64IIxntuSDjfWqmS+f7PwuwiOI+FcPy3dSnealEdllqritOeNLy
         1TpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767204571; x=1767809371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bIMPl7WzuufPEFhizw2OC5bzIw2A/w2Jw5N6sXr/zUI=;
        b=vCnGI2xrLLFdnDV3c/5Xn2UDOv4Ep29Caqo6e7qHoZ/SMq2K5hGnANr2wel+0zYmTN
         NtGFyK4DfgZg3K+y4in8ScpI/VjqfoIYcRWeVXWkFvkHyHiwZApCVMYyCQmA/rEw1hMl
         bdwrZPXNscItIzzU32VN/r7jnBWOw0DgadxoC7WG3ybFktcXEOcAvVX61hJr4QU+pIIW
         0/WnY9FVXwKbC7WJglOcXLg31nxzIevDFmwNhhqBkUXKMJiHyQ04QYHyXf1RjeLz8gbJ
         dsENr03oawQFFI00cqDIc5MSd0/uVOTTwaotZmiBLVfiv0Ohg2kg1vGGJ5HLhZOtJM9y
         H+xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS5XrvoNv+y3PfW42+oyG3YGRDIhwNCWDYqTXAXipdkzxmyf5+9xTUp++ntysC0NoDu8PXjDNXbRyR@vger.kernel.org
X-Gm-Message-State: AOJu0YwpLoOZ65lCUSy5zVFUzinsCazE6rugHDpZl1hZ3mQXGD++8YBX
	WtePCTlwuuNk1zbmUhbg5nwSv5sWlsupG3/1hxYH0NUHK2ezyF5o8DvV4j/QEHAl/ZqSlLWfboZ
	k7CeJhLeggYy5ZOIE7uySOUPZEqnMfXQ3vvJq7lyCYg==
X-Gm-Gg: AY/fxX6aVgz2PTq/c4/AVEhZkc3f2+kyZ9WrpWUAX7L0h+eIpnMMEeZCok7/JKHXPN2
	MlGiQJ/jG0B69a/lTdj8CcW1vSKUDqIYYYK8ovpxI71n6a6XNFJbxx1JzMzzwoKYj5mi/olPG4X
	KoOG6d2ft4LyiZw4Ub/tQIy1cK7MecPT5V2pn88YtqRpRR09u7GpdIHq1FTDFAxr6I3UDF6TY6J
	z6AJNg8jrrVyMbILzWiHmoGQfulstV/pXMHTm6ZpQBpXdMtWrw578VoUViEHMEW/wdfIUMJz8YD
	U0PoOXo=
X-Google-Smtp-Source: AGHT+IEoQb+VMYUZF/EVHfCupM/J7UKB/HyklpfhaHst9+Iqt6sXvQ7lmZWvrOhCEyHebOWe5s6vxpHZd7OfrJbc6Sg=
X-Received: by 2002:a05:7022:6194:b0:11d:faef:21c2 with SMTP id
 a92af1059eb24-121722b44b3mr19049815c88.2.1767204570391; Wed, 31 Dec 2025
 10:09:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231173633.3981832-6-csander@purestorage.com> <e9a1bd633fb4bb3d2820f63f41a8dd60d8c9c5e3c699fa56057ae393ef2f31d0@mail.kernel.org>
In-Reply-To: <e9a1bd633fb4bb3d2820f63f41a8dd60d8c9c5e3c699fa56057ae393ef2f31d0@mail.kernel.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 31 Dec 2025 13:09:19 -0500
X-Gm-Features: AQt7F2q8qmB_ZWyKhj1fKhcgEDCzRqBwfvvrWtG8WY5Jchb5VzTDRzCjSxJzD0s
Message-ID: <CADUfDZpSSikiZ8d8eWvfucj=Cvhc=k-sHN03EVExGBQ4Lx+23Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] selftests/bpf: make cfi_stubs globals const
To: bot+bpf-ci@kernel.org
Cc: jikos@kernel.org, bentiss@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	tj@kernel.org, void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	dsahern@kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, wenjia@linux.ibm.com, mjambigi@linux.ibm.com, 
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, shuah@kernel.org, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, sched-ext@lists.linux.dev, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, martin.lau@kernel.org, clm@meta.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 31, 2025 at 10:04=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/too=
ls/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > index 90c4b1a51de6..5e460b1dbdb6 100644
> > --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> > +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
>
> [ ... ]
>
> > @@ -1275,7 +1275,7 @@ bpf_testmod_ops__test_return_ref_kptr(int dummy, =
struct task_struct *task__ref,
> >       return NULL;
> >  }
> >
> > -static struct bpf_testmod_ops __bpf_testmod_ops =3D {
> > +static const struct bpf_testmod_ops __bpf_testmod_ops =3D {
> >       .test_1 =3D bpf_testmod_test_1,
> >       .test_2 =3D bpf_testmod_test_2,
>
> Is it safe to make __bpf_testmod_ops const here? In bpf_testmod_init(),
> this struct is modified at runtime:
>
>     tramp =3D (void **)&__bpf_testmod_ops.tramp_1;
>     while (tramp <=3D (void **)&__bpf_testmod_ops.tramp_40)
>         *tramp++ =3D bpf_testmod_tramp;
>
> Writing to a const-qualified object is undefined behavior and may cause a
> protection fault when the compiler places this in read-only memory. Would
> the module fail to load on systems where .rodata is actually read-only?

Yup, that's indeed the bug caught by KASAN. Missed this mutation at
init time, I'll leave __bpf_testmod_ops as mutable.

Thanks,
Caleb

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/206242=
06229

