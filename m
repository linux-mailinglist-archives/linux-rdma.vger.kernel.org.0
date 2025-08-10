Return-Path: <linux-rdma+bounces-12653-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A29B1FBED
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 21:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A907F3A9FC1
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Aug 2025 19:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FAA1D5CE8;
	Sun, 10 Aug 2025 19:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ayido+yU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DAB1388;
	Sun, 10 Aug 2025 19:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754854277; cv=none; b=ZQBRRCpKuEGC1OOFgztzOt9g51IBtNDfxYpCE14ffTA8ACDm8q3lug0FQc/O1wNZeiRESeoUNXYm0PCM71AFlevSr6s3y2GNOa4ou0CD++ypxdhe32O8JIli748Um7F9JPEh8TZkNzRTm8B7vqU3/r9DtWxBCddxbUEfFR0upEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754854277; c=relaxed/simple;
	bh=DatxjTxLETNHkRw+7hKersE1pQX6G4HjlzHJJywFU9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qNxqOa9LpeN1MkcetLKZJSXdhPYXj42Crdj3FYKfr7mNEPgNDH6htBvDcR8DXiu2PyStlCFq89RkRs1cSvsUJ3RXW/gARzREzi65RYaKTKsMsB3HWk8bzy+B0pFUywcfxWecUqHmh5D/b/IGdGPwvkNkg0cHviEBDtKZKc+7uOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ayido+yU; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6182ea5a6c0so349094a12.0;
        Sun, 10 Aug 2025 12:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754854274; x=1755459074; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DatxjTxLETNHkRw+7hKersE1pQX6G4HjlzHJJywFU9o=;
        b=Ayido+yUm+b2w8i8ObA4OMw848q3z+dWVe7zDmbBwAGynNZe3wnOaCdA/Xn/S/UFg5
         X3YzTa4IaNfq78A7+XaSTs6A4KkOem6T2XYaikQZIXJZopK5yzSqjxIUOkeCXdBzf5Kt
         gQ0JmNu0+8xcays4uAqfTpTlDMrm7CH0IobiMQrnqhSr7LHu+j7MY50z+6imV8Wj7zP4
         JxT0uNvPjPtiKMcmO6ERgCQIYGW+A9iMQO32E/KrRylfLFhKJu8Yq8EYsS71UX99q9za
         jjX9b+Nf/q4r8v2IEx3yTe1hU5UWL4nwNumdXKsqdWZJ9NgZ1a/j46gJnZxqeX5/kk/1
         kOaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754854274; x=1755459074;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DatxjTxLETNHkRw+7hKersE1pQX6G4HjlzHJJywFU9o=;
        b=XhesgxoSAI954b8ZiJYDBYn0az+BLyTxzsYHC4RT/85odce8Rc5YfQMxH4WLShJXpl
         VNVpIJDsaxZYcSLE4mcU6dr5s6RFTIv+azyYcH1xUhSAEjf3kh5Kfpf7jAEY7OYL6U8Y
         LodV2wtlDymLkYbt6TsO669mksScGQHAt0CtypIeggS/W3/8HFr14Ojdwuc1UoBslD1o
         Ub5xPS9zmht4xZaaPjDhmSmDgNTmikm+T5A8sCg1F2+kp2Kpf9elXgrbqinQ3kaP6Fft
         fWWViokMJwfcdOo3mA056lIsfXL0Xq0ySKoNceA/uiY7fhEUQaWX72/7WqRZ//VTa848
         yHfg==
X-Forwarded-Encrypted: i=1; AJvYcCUJi2l/lq3Lrryds5/vjA1rAaqjCWwvdVmJEC5F557i6InuuY2LwLEeUayddEWj/mX348Wrwv6jhqkjSug=@vger.kernel.org, AJvYcCW0W6p1376GiBkpQpMqRFz1QqLRh+XuamG+8/2WRmOHZOl2LHm2UvFdt67wqvqJg/oO9T9daU2RD/0Y5w==@vger.kernel.org, AJvYcCXevyAQJfgBMI0g9QjDAhDFZu0cySz8aWniHLy6XAqA70prpCQmRhDK7abp8Ah7e3F8gEXtOnk0@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8ndCgQzir3qjcr7ZafIBIPMkwOkQ36fs7MOZ3V/MEGS8V1hkE
	ql9PkdbHaYy0Qp/ktpe7pZhKOwjktQu5e5vZVRnh8+Ieyc1/9ydzWo7nJQwl3rmgmSulJC4z7Y6
	dAWQCswwAKV8UAdEeTR63tB5DDwtf5p2b9aOmhr7W
X-Gm-Gg: ASbGncuXDOPPF6dXgNxvxXTNplWyg5X6TCoaepheHvY1epJB/KkilIQqqad9Z+N3wMD
	lQH/4xyC5Pg7w7kuFzQ7MkWNNlTpstjiI846hxWBcdKgirIe39efU63khzjThaXAdoaVrKjaIXi
	lYqxE88NvdRTAO9J4OuVExpgi4cXWiAe4cfkgmkpdp6gT/AF7m99Atr7Btc3DRw++kOnzOwx25s
	WkJfX9h
X-Google-Smtp-Source: AGHT+IFdAzLXoFTMTevoWa0y0vW60njujby+4GoZiLDrNpxEKdMftiawQHqTzQXmbahK1mDDotLn58yEtzAw+IJzYk0=
X-Received: by 2002:a17:906:6a18:b0:af9:a2a9:b5f8 with SMTP id
 a640c23a62f3a-af9c63c3370mr958208766b.18.1754854274364; Sun, 10 Aug 2025
 12:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810171155.3263-1-ujwal.kundur@gmail.com> <20250810174705.GK222315@ZenIV>
 <20250810182506.GL222315@ZenIV> <398e53d8-906d-43c9-9395-f6115dcb945b@lunn.ch>
In-Reply-To: <398e53d8-906d-43c9-9395-f6115dcb945b@lunn.ch>
From: Ujwal Kundur <ujwal.kundur@gmail.com>
Date: Mon, 11 Aug 2025 01:01:01 +0530
X-Gm-Features: Ac12FXzGPrWp5csxdUnL0IPn-LVy_VHOTKVb3PefMkAigPGlusRpKqdSn6oZdp8
Message-ID: <CALkFLLJkGqA7T5JhRQOs4spa+ihr-6RXA9xWwQRbRp6upLXBaw@mail.gmail.com>
Subject: Re: [PATCH net] rds: Fix endian annotations across various assignments
To: Andrew Lunn <andrew@lunn.ch>
Cc: Al Viro <viro@zeniv.linux.org.uk>, allison.henderson@oracle.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks a lot for the explanation Al!
I was apprehensive about breaking things and in hindsight, should've
understood why the cast was present rather than accepting sparse's
report as the whole truth; Will go through the code more thoroughly
and send a v2 patchset.

> This smells of an LLM generated patch. So i think you are somewhat
> wasting your time explaining in detail why this is wrong.
I have never used (and will not use) LLMs :(
I intend to learn more about the networking stack through
contributions and I __strongly__ believe using LLMs / AI won't help me
get there.

> It took me about 60 seconds to prove the POLLERR change was wrong, and
> i know nothing about this code base. So it is in fact not a lot of
> effort.
I looked up the definition of POLLERR on Elixir [1] and it seemed like
a valid Sparse report to me. I wasn't aware of EPOLLERR, and now
realize all the other operations are prefixed with EPOLL* in af_rds.c.
I look forward to reviews/critiques to learn from them but being
accused of using LLMs is kinda disheartening.

P.S: I'm still learning the ropes as a contributor so please pardon my
ignorance.

[1] - https://elixir.bootlin.com/linux/v6.16/source/include/uapi/asm-generic/poll.h#L9

