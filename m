Return-Path: <linux-rdma+bounces-1367-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4374A8777A9
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 18:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2C71F21771
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 17:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D58374F2;
	Sun, 10 Mar 2024 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2Idd4g2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DAE22324;
	Sun, 10 Mar 2024 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710090034; cv=none; b=tlvATEgTgu0DPy1VF92NXZ95OUD7UNi6I9ByVvmrKpvCTL3rkkrTE3yIwoTSdxahoW+LUfSO1rlmoihqOVD1s8nSWbeesm8y7p2rxxXCAZvHd7EBtsSb0TRmtvTuxqArMe/WcjeYjw/Ez1UtyOkr/w+4kf7Kb1hEmvgnNdx+Wik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710090034; c=relaxed/simple;
	bh=isUjSND0if6U6AVyAM5vWFTaxcZA26iTE1HBZb8B/Rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQ0YmUWWo44r2tP10haUdQ/REQ4b4aQ4kfGQEqWn7Ou2sJAYjFuVweDByWE3d/VYjaQyiTHFbNE5TCLoMjrAFK3hfbQsjRe/ZVvycGTcQplr1R+c+31gtcZcQYvTiNXUa/bbDYJhftMKtcrHOMg0s9X23bHw7fudNBM9l1mYa4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2Idd4g2; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6e56d594b31so1989519b3a.1;
        Sun, 10 Mar 2024 10:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710090032; x=1710694832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isUjSND0if6U6AVyAM5vWFTaxcZA26iTE1HBZb8B/Rk=;
        b=P2Idd4g2GCz6me4aXIR0zBXQ7K2W0DFncOPcp3uQAdYdjXM4U2ovDCd6Fz8zh7MeOX
         WdbSihT7GJcjiPN0kgIQz872K0WXQABSngs7ZZmQTMRxFUezRknmZDvAiH+OlspdrSWQ
         jJqbPwnM3Jyg6J5TxOnvlJdocJ6d/VmpUNXIYCV0bT7BWykOu7cS/YlfWysr64UMECzC
         GfXlJDKvj3FVLXqj5Am5iez5VfdSQlikirtFEadIIy/k4guhb2sOCdWOXeZ0jiGq2oGJ
         FTdW9LdEETGt0VO7CFI0wijah13unRYznZYQzkylTB7Bo82yT164prX86aL3oYN3kbp+
         jC4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710090032; x=1710694832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isUjSND0if6U6AVyAM5vWFTaxcZA26iTE1HBZb8B/Rk=;
        b=hRT2CsZhk10xV7KpE+1F/ZOKWmZp/yT3r1wJWvRWmxM44L70H/woy4Oowys65vqCeA
         ly9wx3LGLoyaamgkvdBlar+i3t1UgK4yNhu/7CRw3pOBw5IJp6dur2S4V2fBpgqMjqgo
         Dv60iO0XvcCtuJG3WF3cp9shIMgU6C50eyeLjC1rAsnLJzddF1bKrKReQzi8hy3iY729
         B0KVF4jhwojqtRx3jq2BX5kq33jKPvA7upltCIQlPf6BdCaHMCcv4opP92Gsd+8UWzNH
         wcONlRAf5en7JtA+q4zN9Fjf9gh9mb2YjquldPJp9FKwTiiipS3mSXlxttkWYTbl03fj
         rHUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU24MqyF06n0GtGswT+YfjZa2Jv5BsW1y0EMsbzKjrUg9FbV94IWmYmL27wJKp7R6ZuyUFG+nNrrWStexO9Bexmq3XvKK/UZTUHVXgwBCW530MuvmVZRIbTn/WcLM/yMOZkDAzeHan/4Q==
X-Gm-Message-State: AOJu0Ywjaz3ROUssWECemOCN9Us6dZLEl865vuomsrV94oq9ahTvCyjY
	m2sLJuYFAFo6g1MeULZGSOJ4vWV0n5yKb572Wu7SqNX2FVI/vvEXeUTN33v86s9+7Nbv3kjlK1G
	/sSYe82J+E2ByXYgUFc9l9x1sbh0=
X-Google-Smtp-Source: AGHT+IHj1fjxpGAoLj9jV4/D1Zb5hzkHO6+BHLdVYn101EKsO1MxTPLOUw1nYIJ5+JSo694r9VBuL5aAk+hEbG5d58g=
X-Received: by 2002:a05:6a21:394a:b0:1a2:d81d:d28e with SMTP id
 ac10-20020a056a21394a00b001a2d81dd28emr2481863pzc.30.1710090032326; Sun, 10
 Mar 2024 10:00:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2d508574-c2b8-489b-a26d-71b1c36961cf@linux.dev> <tencent_688B20450ABBA409637C5A4BC3A7B0191D07@qq.com>
In-Reply-To: <tencent_688B20450ABBA409637C5A4BC3A7B0191D07@qq.com>
From: Greg Sword <gregsword0@gmail.com>
Date: Mon, 11 Mar 2024 01:00:20 +0800
Message-ID: <CAEz=LctG46xSHVxRg0VwnfCpv+uyOHdb0jqQ+WJNc7zSnMA2Ng@mail.gmail.com>
Subject: Re: [PATCH] RDMA/siw: Reuse value read using READ_ONCE instead of
 re-reading it
To: linke li <lilinke99@qq.com>
Cc: yanjun.zhu@linux.dev, bmt@zurich.ibm.com, jgg@ziepe.ca, leon@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 10, 2024 at 8:36=E2=80=AFPM linke li <lilinke99@qq.com> wrote:
>
> > In a complicated environment, for example, this function is called many
> > times at the same time and orqe->flags is changed at the same time, I a=
m
> > not sure if this will introduce risks or not.
>
> I think one function of READ_ONCE is to read a valid value while the valu=
e
> may change concurrently. And there is a smp() above the READ_ONCE, which
> means that the READ_ONCE is well ordered. I think it is kind of safe here=
.

This is not a smp problem. Compared with the original source, your
commit introduces a time slot.

>
> > if you need to ensure the consistency of the flags throughout the funct=
ion, not sure if the following is better or not.
>
> > if (((orqe_flags=3DREAD_ONCE(orqe->flags))) & SIW_WQE_VALID) {
>
> This patch looks like exactly do the same things. The only difference I
> think is the code style.

No.

>
> Thanks,
> Linke
>
>

